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

    assert game.is_solved?
  end

  def test_b_normal_case
    file_path = 'test/ag_normal.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
    game.print_dp_results('dp_output.txt')

    assert game.is_solved?
  end

  def test_c_impossible_case
    puts
    puts "TestGameCases: Trying an impossible game. Should find no solution."
    file_path = 'test/ag_impossible.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
    game.print_dp_results('dp_output.txt')

    assert !game.is_solved?
  end

  # beware: takes about 1 minute to solve
  def test_d_bigger_case
    puts
    puts "TestGameCases: Trying a game with many steps. Takes about 1 minute to solve."
    file_path = 'test/ag_bigger.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
    game.print_dp_results('dp_output.txt')

    assert game.is_solved?
  end

  # beware: takes a 10+ minutes to solve
  def test_e_difficult_case
    puts
    puts "TestGameCases: Trying a long and difficult game. Takes 10+ minutes to solve."
    file_path = 'test/ag_difficult.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
    game.print_dp_results('dp_output.txt')

    assert game.is_solved?
  end
  
end
