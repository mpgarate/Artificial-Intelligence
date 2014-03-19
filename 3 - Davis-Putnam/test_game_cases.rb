require_relative 'davis_putnam'
require_relative 'adventure_game'
require 'test/unit'
require 'fileutils'

class TestGameCases < Test::Unit::TestCase
  def test_a_simple_case
    file_path = 'test/ag_simple.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
    game.print_dp_results('dp_output.txt')
  end

  def test_b_normal_case
    file_path = 'test/ag_normal.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
    game.print_dp_results('dp_output.txt')
  end

  # beware: takes about 1 minute to solve
  def test_c_bigger_case
    file_path = 'test/ag_bigger.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
    game.print_dp_results('dp_output.txt')
  end

  # beware: takes about 1 minute to solve
  def test_d_impossible_case
    file_path = 'test/ag_impossible.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
    game.print_dp_results('dp_output.txt')
  end
end
