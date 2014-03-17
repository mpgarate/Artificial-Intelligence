require_relative 'davis_putnam'
require_relative 'adventure_game/node'
require_relative 'adventure_game/atom_set'
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
    @allowed_steps = lines[2]

    # lines 3-EOF : encoded maze nodes
    lines.slice!(0,2) # remove first two elements
    lines.each do |line|
      @nodes << Node.new(line)
    end
  end

  def generate_logic
    lb = LogicBuilder.new(self)
    lb.one_place_at_a_time
  end

  def write_logic(file)
  end

end

# When running from command line
if __FILE__ == $0 then
  file_path = ARGV.first
  game = AdventureGame.new(file_path)
end