require_relative 'adventure_game'
require_relative 'davis_putnam'
require 'test/unit'
require 'fileutils'

class TestGameCases < Test::Unit::TestCase
  def test_simple_case
    file_path = 'test/ag_simple.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
  end
end
