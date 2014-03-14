require_relative 'davis_putnam/clause'
require_relative 'davis_putnam/input_file'
require_relative 'davis_putnam/literal'
require_relative 'davis_putnam/solver'
require_relative 'davis_putnam/state'

### Instantiate and call Solver

file = InputFile.new("dp_input.txt")
solver = Solver.new(file.clauses)
puts solver.atoms
puts solver.clauses