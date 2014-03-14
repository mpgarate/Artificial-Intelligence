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
    handle_easy_cases(atoms,s,v)
  end

  def handle_easy_cases(atoms,s,v)
     # loop as long as there are easy cases
    while true
      # base of recursion
      if s.is_empty?
        finish_recursion(atoms)
      elsif s.has_empty_clause?
        return nil
      elsif s.has_pure_literal?
        literal = s.pure_literal
        s.delete_every(literal)
      elsif s.has_singleton_clause?
        literal = s.singleton_clause.first
        literal_value = s.singleton_clause.first.value
        v.assign(literal.name, literal.value)
        state.propagate(literal, s,v)
      end


    end
  end

  def finish_recursion(atoms)
    atoms.each do |atom|
      if atoms[atom] == nil
        atoms[atom] = true
      end
    end
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
