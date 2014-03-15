require_relative 'davis_putnam'
require 'test/unit'
require 'fileutils'

class TestDP < Test::Unit::TestCase
  def test_trivial
    input_path = "test/dp_trivial.txt"

    produced = "dp_output.txt"
    solution = "test/dp_trivial_out.txt"

    DavisPutnam.solve_file(input_path)

    assert FileUtils.compare_file(produced, solution)
  end

  def test_normal
    input_path = "test/dp_normal.txt"

    produced = "dp_output.txt"
    solution = "test/dp_normal_out.txt"

    DavisPutnam.solve_file(input_path)

    assert FileUtils.compare_file(produced, solution)
  end

  def test_sample_midterm
    input_path = "test/dp_sample_midterm.txt"

    produced = "dp_output.txt"
    solution = "test/dp_sample_midterm_out.txt"

    DavisPutnam.solve_file(input_path)

    assert FileUtils.compare_file(produced, solution)
  end
end