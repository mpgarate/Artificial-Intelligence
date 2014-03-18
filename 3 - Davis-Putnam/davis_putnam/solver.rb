# solver = Solver.new(clauses)
# solver.state.clauses
#   => [1,2,3],[-2,3],[-3]
# solver.atoms
#   => ["1"=>nil,"2"=>nil,"3"=>nil]
# solver.solve!
# solver.atoms
#   => ["1"=>T,"2"=>T,"3"=>F]

class Solver
  attr_accessor :clauses, :atoms

  def initialize(clauses)
    @clauses = clauses
    initialize_atoms
  end


  # Davis-Putnam (DPLL) procedure
  # Martin Davis and Hillary Putnam, 1961
  #
  # V := array of atoms
  def solve!
    v = Valuation.new(@atoms)
    s = State.new(@clauses)
    vnew = dp1(s,v)
    if vnew == nil
      throw "impossible sentences"
      return nil
    end
    @atoms = vnew.atoms
  end

  private
  
  def dp1(s,v)
    # loop as long as there are easy cases
    while true
      # base of recursion
      if s.is_empty?
        #puts v.atoms
        @clauses = s.clauses
        return finish_recursion(v)
      elsif s.has_empty_clause?
        return nil
      elsif s.has_pure_literal?
        literal = s.pure_literal
        v.assign(literal.name, literal.value)
        s.delete_every(literal)
      elsif s.has_singleton_clause?
        literal = s.singleton_clause.literals.first
        v.assign(literal.name, literal.value)
        s.propagate(literal)
      else
        break
      end
    end


    a = v.get_unbound_atom

    # try an assignment true
    a.value = true
    v.assign(a.name, true)

    s1 = s.duplicate!
    s1.propagate(a)

    vnew = dp1(s1,v.duplicate!)
    return vnew unless vnew == nil

    # try an assignment false
    a.value = false

    v.assign(a.name, false)

    s1 = s.duplicate!
    s1.propagate(a)
    vnew = dp1(s1,v.duplicate!)
    return vnew

  end

  def finish_recursion(v)
    nil_keys = []
    v.atoms.each do |key,value|
      if value == nil
        nil_keys << key
      end
    end
    nil_keys.each do |key|
      v.atoms[key] = true # arbitrary
    end

    return v
  end

  def initialize_atoms
    @atoms = Hash.new

    @clauses.each do |clause|
      clause.literals.each do |literal|
        @atoms[literal.name] = nil
      end
    end

  end
end
