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
  end

  def must_move_on_edges
    moves = 0..@steps
    for m in moves
      @game.nodes.each do |node|
        sentence = []
        sentence << LogicAtom.new("at",node.name,m,false)
        node.next_nodes.each do |next_node|
          sentence << LogicAtom.new("at",next_node,m+1,true)
        end
        @sentence_set.add(sentence)
      end
    end
  end

  def player_can_pay_toll
    moves = 0..@steps
    for m in moves
      @game.nodes.each do |node|
        node.tolls.each do |toll|
          sentence = []
          sentence << LogicAtom.new("at",node.name,m,false)
          sentence << LogicAtom.new("has",toll,m,true)
          @sentence_set.add(sentence)
        end
      end
    end
  end

  def player_picks_up_treasure
    moves = 0..@steps
    for m in moves
      @game.nodes.each do |node|
        node.treasures.each do |treasure|
          sentence = []
          sentence << LogicAtom.new("available",treasure,m,false)
          sentence << LogicAtom.new("at",node.name,m+1,false)
          sentence << LogicAtom.new("has",treasure,m+1,true)
          @sentence_set.add(sentence)
        end
      end
    end

  end

  def player_pays_toll
    moves = 0..@steps
    for m in moves
      @game.nodes.each do |node|
        node.tolls.each do |toll|
          sentence = []
          sentence << LogicAtom.new("at",node.name,m,false)
          sentence << LogicAtom.new("has",toll,m,false)
          @sentence_set.add(sentence)
        end
      end
    end
  end

  def treasure_is_available
    moves = 0..@steps
    for m in moves
      @game.nodes.each do |node|
        node.treasures.each do |treasure|
          sentence = []
          sentence << LogicAtom.new("available",treasure,m,false)
          sentence << LogicAtom.new("at",node.name,m+1,false)
          sentence << LogicAtom.new("available",treasure,m+1,true)
          @sentence_set.add(sentence)
        end
      end
    end
  end

  def treasure_is_picked_up
    moves = 0..@steps
    for m in moves
      @game.nodes.each do |node|
        node.treasures.each do |treasure|
          sentence = []
          sentence << LogicAtom.new("available",treasure,m,true)
          sentence << LogicAtom.new("available",treasure,m+1,false)
          @sentence_set.add(sentence)
        end
      end
    end
  end

  def player_spends_treasure
    moves = 0..@steps
    for m in moves
      @game.nodes.each do |node|
        node.treasures.each do |treasure|
          sentence = []
          sentence << LogicAtom.new("available",treasure,m,true)
          sentence << LogicAtom.new("has",treasure,m,true)
          sentence << LogicAtom.new("has",treasure,m+1,false)
          @sentence_set.add(sentence)
        end
      end
    end
    puts "---- made sentences: ----"
    puts @sentence_set.to_s
  end

end
