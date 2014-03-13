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
end

# lit = Literal.new("-4")
# lit.name => "4"
# lit.value => false
# lit.to_s => "-4"
class Literal < Atom
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

# solver = Solver.new("dp_input.txt")
# solver.clauses
#   => [[1,2,3],[-2,3],[-3]]
# solver.atoms
#   => ["1","2","3"]
# solver.solve!
# solver.atoms
#   => ["1","2","3"]
class Solver
  def initialize(clauses)
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
puts file.clauses
solver = Solver.new(file.clauses)