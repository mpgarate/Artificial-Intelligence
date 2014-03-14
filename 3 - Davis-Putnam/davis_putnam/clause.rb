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
end