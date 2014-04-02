# clause = Clause.new("1 -2 3")
# clause.is_satisfied? => false;
# clause.literals => [1,-2,3]
# clause.propagate("3")
# clause.literals => []
# clause.isSatisfied? => true;
class Clause
  attr_accessor :literals

  def initialize(line)
    @literals = []
    @lit_hash = Hash.new
    line.split.each do |str|
      @literals << Literal.new(str)
      @lit_hash[str.to_s] = true
    end
  end

  def to_s
    @literals.to_s
  end

  def is_singleton?
    if literals.length == 1
      return true
    else
      return false
    end
  end

  # contains a literal?
  def contains?(target)
    return @lit_hash[target.to_s] == true
  end

  # delete a literal
  def delete(target)
    @literals.each_with_index do |literal, index|
      if target.to_s == literal.to_s
        @literals.delete literal
        if @literals.length == 0
          @lit_hash[nil.to_s] = true
        end
      end
    end
  end
  
  def duplicate!
    return Marshal.load(Marshal.dump(self))
  end
end
