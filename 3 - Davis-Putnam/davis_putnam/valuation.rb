class Valuation
  attr_accessor :atoms
  
  def initialize(atoms)
    @atoms = atoms
  end

  def assign(key,val)
    @atoms[key] = val
  end
end