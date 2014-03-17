class LogicBuilder
  # atoms are stored in the @logic[] array
  # as a string like "-1 -2"
  # @logic_names keeps track of what digits represent
  # @logic_names[2] => "At(C,1)"
  # This means that 2 corresponds to the atom "At(C,1)"

  def initialize(game)
    @game = game
    @steps = game.allowed_steps

    @atom_set = AtomSet.new

    @logic = []
    @sentence_set = SentenceSet.new
  end


  def build_possible_atoms
    moves = 0..@steps

    for m in moves
      @game.nodes.each do |node|
        atom = LogicAtom.new("at",node.name,m)
        @atom_set.add(atom)
      end

      @game.treasures.each do |treasure|
        atom = LogicAtom.new("available",treasure,m)
        @atom_set.add(atom)

        atom = LogicAtom.new("has",treasure,m)
        @atom_set.add(atom)
      end
    end

    puts @atom_set.to_s
  end

  def one_place_at_a_time
    moves = 0..@steps
    for m in moves
      @game.nodes.each do |node_a|
        @game.nodes.each do |node_b|
          unless node_a == node_b
            atom_1 = LogicAtom.new("at",node_a.name,m,false)
            atom_2 = LogicAtom.new("at",node_b.name,m,false)

            pair = [atom_1,atom_2]
            @sentence_set.add(pair)
          end
        end
      end
    end
  end

  def treasure_availability
    moves = 0..@steps
    for m in moves
      @game.treasures.each do |treasure|
        atom_1 = LogicAtom.new("has",treasure,m,false)
        atom_2 = LogicAtom.new("available",treasure,m,false)

        pair = [atom_1,atom_2]
        @sentence_set.add(pair)
      end
    end
    puts "---- made sentences: ----"
    puts @sentence_set.to_s
  end

  def must_move_on_edges
    moves = 0..@steps
  end

end