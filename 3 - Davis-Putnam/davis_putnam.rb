require 'set'
require_relative 'davis_putnam/clause'
require_relative 'davis_putnam/input_file'
require_relative 'davis_putnam/output_file'
require_relative 'davis_putnam/literal'
require_relative 'davis_putnam/solver'
require_relative 'davis_putnam/state'
require_relative 'davis_putnam/valuation'


# Davis-Putnam (DPLL) procedure
# Martin Davis and Hillary Putnam, 1961
# Implementation by Michael Garate for
# Artificial Intelligence. March 2014. 

# Primary algorithm in davis_putnam/solver.rb
class DavisPutnam
  def self.solve_file(path)
    file = InputFile.new(path)
    solver = Solver.new(file.clauses)
    
    solver.solve!

    out_file = OutputFile.new(file,"dp_output.txt")
    out_file.write_atoms!(solver.atoms)
  end 
end

# When running from command line
if __FILE__ == $0 then
  file_path = ARGV.first
  DavisPutnam.solve_file(file_path)
end