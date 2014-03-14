require_relative 'davis_putnam'
require 'test/unit'
require 'fileutils'

class TestDP < Test::Unit::TestCase
  def test_trivial
    in_file = InputFile.new("test/dp_trivial.txt")
    solver = Solver.new(in_file.clauses)
    solver.solve!
    out_file = OutputFile.new(in_file,"dp_output.txt")
    out_file.write_atoms!(solver.atoms)

    produced = "dp_output.txt"
    solution = "test/dp_trivial_out.txt"

    assert FileUtils.compare_file(produced, solution)
  end
end