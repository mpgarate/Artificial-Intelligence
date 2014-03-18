require_relative 'davis_putnam'
require_relative 'adventure_game/node'
require_relative 'adventure_game/atom_set'
require_relative 'adventure_game/sentence_set'
require_relative 'adventure_game/logic_builder'
require_relative 'adventure_game/logic_atom'

class AdventureGame
  attr_accessor :treasures, :nodes, :allowed_steps

  def initialize(file_path)
    parse_attributes_from_file(file_path)

  end

  def parse_attributes_from_file(file_path)
    @nodes = []
    @treasures = []

    file = File.open(file_path)
    lines = file.readlines
    
    # line 0 : nodes    

    # line 1 : treasures
    @treasures = lines[1].split

    # line 2 : allowed steps
    @allowed_steps = Integer(lines[2])

    # lines 3-EOF : encoded maze nodes
    lines.slice!(0,3) # remove first three lines
    lines.each do |line|
      @nodes << Node.new(line)
    end
  end

  def generate_logic
    lb = LogicBuilder.new(self)

    # creates a set of all possible atoms and atom types
    # this is used for getting unique index numbers when
    # generating output for davis_putnam
    lb.build_possible_atoms

    # proposition type 1 
    lb.one_place_at_a_time

    # proposition type 2
    lb.treasure_availability

    # proposition type 3
    lb.must_move_on_edges

    # proposition type 4
    lb.player_can_pay_toll

    # proposition type 5
    lb.player_picks_up_treasure

    # proposition type 6
    lb.player_pays_toll
  end

  def write_logic(file)
  end

end

# When running from command line
if __FILE__ == $0 then
  file_path = ARGV.first
  game = AdventureGame.new(file_path)
end