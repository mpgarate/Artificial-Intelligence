class AtomSet
  attr_accessor :atoms

  def initialize()
    @atoms = []
  end

  def add(atom)
    @atoms << atom unless @atoms.include? atom
  end

  def get_index_of(atom)
    @atoms.index(atom)
  end

  def to_s
    str = ""
    @atoms.each do |atom|
      str << "#{get_index_of(atom)} : #{atom} \n"
    end
    return str
  end

  def find_atom(type,a,b)
    @atoms.each do |atom|
      if atom.a == a and atom.b == b and atom.type == type
        return atom.duplicate
      end
    end
  end
end