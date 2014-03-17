require_relative 'davis_putnam'
require_relative 'adventure_game/node'

class AdventureGame
  attr_accessor :treasures, :nodes, :allowed_steps

  def initialize(file_path)
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

end

# When running from command line
if __FILE__ == $0 then
  file_path = ARGV.first
  AdventureGame.solve_file(file_path)
end