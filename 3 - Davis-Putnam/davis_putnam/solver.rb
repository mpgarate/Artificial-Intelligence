
# solver = Solver.new(clauses)
# solver.clauses
#   => [1,2,3],[-2,3],[-3]
# solver.atoms
#   => ["1"=>nil,"2"=>nil,"3"=>nil]
# solver.solve!
# solver.atoms
#   => ["1"=>T,"2"=>T,"3"=>F]
class Solver
  attr_accessor :clauses, :atoms

  def initialize(clauses)
    @state = State.new(clauses)
    initialize_atoms
  end

  # Davis-Putnam (DPLL) procedure
  # Martin Davis and Hillary Putnam, 1961
  #
  # V := array of atoms
  def solve!
    dp1
  end

  private
  
  def dp1
    handle_easy_cases
  end

  def handle_easy_cases
     # loop as long as there are easy cases
    while true
      # base of recursion
      if clauses.isEmpty?
        finish_recursion
      elsif clauses.hasEmpty
      end

    end
  end

  def finish_recursion
    atoms.each do |atom|
      if atoms[atom] == nil
        atoms[atom] = true
      end
    end
    return atoms
  end

  def initialize_atoms
    @atoms = Hash.new

    @state.clauses.each do |clause|
      clause.literals.each do |literal|
        @atoms[literal.name] = nil
      end
    end

  end
end
