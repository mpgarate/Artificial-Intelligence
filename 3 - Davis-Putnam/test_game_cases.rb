require_relative 'adventure_game'
require 'test/unit'
require 'fileutils'

class TestGameCases < Test::Unit::TestCase
  
  file_path = 'test/ag_simple.txt'
  game = AdventureGame.new(file_path)
  game.generate_logic
  game.write_logic('dp_input.txt')
end