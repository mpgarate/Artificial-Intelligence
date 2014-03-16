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
    vnew = dp1(@atoms,s,v)
    @atoms = vnew.atoms
  end

  private
  
  def dp1(atoms,s,v)
    puts ""
    puts "----- dp1 called -----"
    puts "--- atoms ---"
    puts "#{atoms}"
    puts "--- v.atoms ---"
    puts "#{v.atoms}"
    puts "--- s.clauses ---"
    puts "#{clauses}"
    puts "---------------------------"
    puts ""
    # loop as long as there are easy cases
    while true
      puts "starting while loop"
      # base of recursion
      if s.is_empty?
        puts "s is empty: #{s.clauses}"
        #puts v.atoms
        @clauses = s.clauses
        return finish_recursion(v)
      elsif s.has_empty_clause?
        puts "STATE HAS EMPTY CLAUSE"
        return nil
      elsif s.has_pure_literal?
        literal = s.pure_literal
        puts "pure literal #{literal}. #{literal.name} must be #{literal.value}"
        v.assign(literal.name, literal.value)
        s.delete_every(literal)
        puts "---------- FAILED TO DELETE #{literal} ----------" if s.has_any_literal? literal
      elsif s.has_singleton_clause?
        literal = s.singleton_clause.literals.first
        puts "singleton clause. #{literal.name} must be #{literal.value}"
        v.assign(literal.name, literal.value)
        s.propagate(literal)
        puts "propagated #{literal}"
        puts s.has_empty_clause?
      else
        puts "breaking from while loop" 
        break
      end
      puts "about to repeat the while loop"
    end


    a = v.get_unbound_atom

    puts "trying a true assignment"
    # try an assignment true
    a.value = true
    puts "trying #{a} true"
    v.assign(a.name, true)

    s1 = s.duplicate!
    s1.propagate(a)

    vnew = dp1(atoms,s1,v.duplicate!)
    puts "returning #{a.name} T"
    puts vnew.atoms unless vnew == nil
    return vnew unless vnew == nil

    puts "trying a false assignment"
    # try an assignment false
    a.value = false

    puts "trying #{a} false"
    v.assign(a.name, false)

    s1 = s.duplicate!
    s1.propagate(a)
    vnew = dp1(atoms,s1,v.duplicate!)
    puts "returning #{a.name} F"
    puts vnew.atoms unless vnew == nil
    return vnew

  end

  def finish_recursion(v)
    nil_keys = []
    puts "done recursion. v.atoms: #{v.atoms}"
    v.atoms.each do |key,value|
      if value == nil
        nil_keys << key
      end
    end
    
    puts "nil_keys: #{nil_keys} #{nil_keys.length}"
    puts "atoms: #{atoms}"
    nil_keys.each do |key|
      puts "SETTING KEY #{key}"
      v.atoms[key] = true # arbitrary
    end

    puts "finalized atoms. atoms: #{atoms}"
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
