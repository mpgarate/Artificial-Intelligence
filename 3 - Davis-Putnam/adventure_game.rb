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
    @file_path = file_path
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
    puts
    puts "AdventureGame: Generating game logic for #{@file_path}..."

    @lb = LogicBuilder.new(self)

    # creates a set of all possible atoms and atom types
    # this is used for getting unique index numbers when
    # generating output for davis_putnam
    @lb.build_possible_atoms

    # proposition type 1 
    @lb.one_place_at_a_time

    # proposition type 2
    @lb.treasure_availability

    # proposition type 3
    @lb.must_move_on_edges

    # proposition type 4
    @lb.player_can_pay_toll

    # proposition type 5
    @lb.player_picks_up_treasure

    # proposition type 6
    @lb.player_pays_toll

    # proposition type 7
    @lb.treasure_is_available

    # proposition type 8
    @lb.treasure_is_picked_up

    # proposition type 9
    @lb.player_spends_treasure

    # proposition type 10
    @lb.player_carries_treasure

    # proposition type 11
    @lb.player_starts_at_zero

    # proposition type 12
    @lb.treasures_available_from_start

    # proposition type 13
    @lb.player_reaches_goal

    @sentences = @lb.get_sentences_as_digits
  end

  def write_logic(file_path)
    outfile = File.open(file_path,"w")
    @sentences.each do |sentence|
      outfile.puts(sentence)
    end
    outfile.puts("0 ")
    outfile.close
  end

  def print_dp_results(file_path)
    infile = File.open(file_path,"r")

    atoms = []

    infile.each_line do |line|
      break if line == "0\n" or line == "0 \n"

      # read line to a pair like [1,F] or [3,T]
      pair = line.split
      atom_index = pair[0].to_i
      atom_value = pair[1] # 'T' or 'F'

      if atom_value == 'T'
        atom = @lb.atom_set.atoms[atom_index - 1]
        if atom.type == "at"
          atom.value = true
          atoms << atom
        end
      end
    end

    if atoms.size > 0
      atoms.sort_by! { |atom| atom.b }

      puts "----------------"
      puts "RESULT:"
      puts

      atoms.each do |atom|
        puts "Step #{atom.b} | #{atom.a}"
      end

      puts "----------------"

      infile.close
      puts
    else
      puts "AdventureGame: No solution. "
    end
  end

end

# When running from command line
if __FILE__ == $0 then
  file_path = ARGV.first
  game = AdventureGame.new(file_path)
end