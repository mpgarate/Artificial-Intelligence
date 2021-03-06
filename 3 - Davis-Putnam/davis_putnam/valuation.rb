# store a current set of T/F values for given atoms
# support assignment and retrieval of unbound atoms

class Valuation
  attr_accessor :atoms
  
  def initialize(atoms)
    @atoms = atoms
  end

  def assign(key,val)
    @atoms[key] = val
    return self
  end

  def get_unbound_atom
    @atoms.each do |atom|
      if atom[1] == nil
        return Literal.new(atom[0])
      end
    end
    return nil
  end
  
  def duplicate!
    return Marshal.load(Marshal.dump(self))
  end
end