class Valuation
  attr_accessor :atoms
  
  def initialize(atoms)
    @atoms = atoms
  end

  def assign(key,val)
    @atoms[key] = val
  end

  def get_unbound_atom
    puts "getting unbound atom from #{@atoms}"
    @atoms.each do |atom|
      if atom[1] == nil
        return Literal.new(atom[0])
      end
    end
    return nil
  end
end