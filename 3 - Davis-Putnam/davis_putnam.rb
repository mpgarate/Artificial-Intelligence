require 'set'
=begin
# atom = Atom.new("-4")
# atom.name => "4"
# atom.value => false
# atom.to_s => "4 F"

# atom = new Atom("2")
# atom.name => "2"
# atom.value => true
# atom.to_s => "2 T"
class Atom
  attr_accessor :name, :value

  @value = nil

  def initialize(str)
    @name = str.delete("-")
  end

  def to_s
    string = @name

    unless @value == nil then
      if (@value == false) then
        string << " F"
      else
        string << " T"
      end
    end

    return string
  end
end
=end

# lit = Literal.new("-4")
# lit.name => "4"
# lit.value => false
# lit.to_s => "-4"
class Literal
  attr_accessor :name, :value

  def initialize(str)
    @name = str.delete("-")

    if str.include? '-' then
      @value = false
    else
      @value = true
    end
  end

  def to_s
    string = ""
    if (@value == false) then
      string << "-"
    end
    string << @name
  end
end

# clause = Clause.new("1 -2 3")
# clause.is_satisfied? => false;
# clause.literals => [1,-2,3]
# clause.propagate("3")
# clause.literals => []
# clause.isSatisfied? => true;
class Clause
  attr_accessor :literals

  def initialize(line)
    @literals = []
    line.split.each do |str|
      @literals << Literal.new(str)
    end
  end

  def to_s
    @literals.to_s
  end
end

# state = State.new([1][-3,4])
# state.clauses => [1][-3,4]

class State
  attr_accessor :clauses

  def initialize(clauses)
      @clauses = clauses
  end

  def has_empty_clause?
    @clauses.each do |clause|
      return true if clause == nil
    end
    return false
  end
end

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

    @clauses.each do |clause|
      clause.literals.each do |literal|
        @atoms[literal.name] = nil
      end
    end

  end
end

# file = InputFile.new("dp_input.txt")
# file.clauses
#   => [[1,2,3],[-2,3],[-3]]

class InputFile
  attr_accessor :clauses

  def initialize(filename)
    @clauses = []

    f = File.open(filename)
    f.each_line do |line|
      break if line.include? "0"
      @clauses << Clause.new(line)
    end
  end
end

### Instantiate and call Solver

file = InputFile.new("dp_input.txt")
solver = Solver.new(file.clauses)
puts solver.atoms
puts solver.clauses