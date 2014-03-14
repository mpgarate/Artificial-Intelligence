require 'set'
require_relative 'davis_putnam/clause'
require_relative 'davis_putnam/input_file'
require_relative 'davis_putnam/literal'
require_relative 'davis_putnam/solver'
require_relative 'davis_putnam/state'
require_relative 'davis_putnam/valuation'


# Davis-Putnam (DPLL) procedure
# Martin Davis and Hillary Putnam, 1961
# Implementation by Michael Garate for
# Artificial Intelligence. March 2014. 

# Primary algorithm in davis_putnam/solver.rb


### Instantiate and call Solver

file = InputFile.new("dp_input.txt")
solver = Solver.new(file.clauses)
puts solver.atoms
puts solver.clauses
solver.solve!