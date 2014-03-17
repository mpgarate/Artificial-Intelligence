class LogicBuilder
  # atoms are stored in the @logic[] array
  # as a string like "-1 -2"
  # @logic_names keeps track of what digits represent
  # @logic_names[2] => "At(C,1)"
  # This means that 2 corresponds to the atom "At(C,1)"
  @logic = []
  @sentences

  def initialize(game)
    @game = game

    # @at_atoms
    @at_atoms = AtomSet.new("at")
    @available_atoms = AtomSet.new("available")
    @has_atoms = AtomSet.new("has")
    
    build_possible_atoms
  end

  def build_possible_atoms
    types = ["at","available","has"]
    types.each do |type|
      @game.nodes.each do |node_a|
        @game.nodes.each do |node_b|
          atom = LogicAtom.new(type,node_a,node_b)
          @at_atoms.add(atom)
        end
      end
    end
    puts @at_atoms.atoms
  end

  def one_place_at_a_time
    @game.nodes.each do |node_a|
      @game.nodes.each do |node_b|
        for i in 0..@game.nodes.count
          # looks like: 'At(C,2)'
          unless node_a == node_b
=begin
            atom_string_a = "At(#{node_a.name},#{i})"
            atom_string_b = "At(#{node_b.name},#{i})"
            @logic << atom_string_a
            @logic << atom_string_b
            sentence
            @logic << LogicAtom.new(atom_string,false)
=end
          end
        end
      end
    end
  end
end