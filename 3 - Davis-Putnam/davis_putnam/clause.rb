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
    line.split.each do |str|
      @literals << Literal.new(str)
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
    @literals.each do |literal|
      if target.to_s == literal.to_s
        return true
      end
    end

    return false
  end

  # delete a literal
  def delete(target)
    @literals.each_with_index do |literal, index|
      if target.to_s == literal.to_s
        @literals.delete literal
        if @literals.length == 0
          @literals << nil
          puts "MADE NIL: #{literal}"
        end
      end
    end
  end
  
  def duplicate!
    return Marshal.load(Marshal.dump(self))
  end
end
