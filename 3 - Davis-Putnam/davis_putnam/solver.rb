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
    dp1(@atoms,s,v)
  end

  private
  
  def dp1(atoms,s,v)
    # loop as long as there are easy cases
    while true
      # base of recursion
      if s.is_empty?
        #puts v.atoms
        @clauses = s.clauses
        return finish_recursion(atoms)
      elsif s.has_empty_clause?
        "STATE HAS EMPTY CLAUSE"
        return nil
      elsif s.has_pure_literal?
        literal = s.pure_literal
        puts "pure literal. #{literal.name} must be #{literal.value}"
        v.assign(literal.name, literal.value)
        s.delete_every(literal)
      elsif s.has_singleton_clause?
        literal = s.singleton_clause.literals.first
        puts "singleton clause. #{literal.name} must be #{literal.value}"
        v.assign(literal.name, literal.value)
        s.dup.propagate(literal,v)
      else
        break
      end
    end

    # try an assignment true
    _atom = v.get_unbound_atom
    a = Literal.new(_atom[0]) #true
    puts "trying #{a} true"
    v.assign(a.name,true)

    s1 = s.dup.propagate(a,v)
    vnew = dp1(atoms,s1,v)
    return vnew unless vnew == nil


    # try an assignment false
    _atom = v.get_unbound_atom
    a = Literal.new("-#{_atom[0]}") #false

    puts "trying #{a} false"
    v.assign(a.name,false)

    s1 = s.dup.propagate(a,v)
    vnew = dp1(atoms,s1,v)
    return vnew unless vnew == nil

  end

  def finish_recursion(atoms)
    nil_keys = []
    puts "done recursion. atoms: #{atoms}"
    atoms.each do |key,value|
      if value == nil
        nil_keys << key
      end
    end
    
    puts "nil_keys: #{nil_keys} #{nil_keys.length}"
    puts "atoms: #{atoms}"
    if nil_keys.length > 0
      nil_keys.each do |key|
        puts "SETTING KEY #{key}"
        atoms[key] = true # arbitrary
      end
    end

    puts "finalized atoms. atoms: #{atoms}"
    return atoms
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
