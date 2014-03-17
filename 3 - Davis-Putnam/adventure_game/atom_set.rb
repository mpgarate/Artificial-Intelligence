class AtomSet
  attr_accessor :type, :atoms

  def initialize(type)
    @type = type
    @atoms = []
  end

  def add(atom)
    @atoms << atom unless @atoms.include? atom
  end

  def get_index_of(atom)
    @atoms.index(atom)
  end
end