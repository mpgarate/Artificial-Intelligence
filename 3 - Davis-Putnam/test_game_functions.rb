require_relative 'adventure_game'
require 'test/unit'
require 'fileutils'

class TestGameCases < Test::Unit::TestCase
  def test_simple_initialize_treasures
    game = AdventureGame.new("test/ag_simple.txt")

    error_message = "got #{game.treasures} and expected ['WAND']"
    assert(game.treasures == ["WAND"], error_message)
  end

  def test_simple_initialize_nodes
    game = AdventureGame.new("test/ag_simple.txt")
    
    error_message = "got #{game.nodes.count} and expected 4"
    assert(game.nodes.count == 4, error_message)
  end
end
