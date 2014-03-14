# lit = Literal.new("-4")
# lit.name => "4"
# lit.value => false
# lit.to_s => "-4"
class Literal
  attr_accessor :name, :value

  def initialize(str)
    @name = str.delete("-")

    if str.include? '-' then
      @value = false
    else
      @value = true
    end
  end

  def to_s
    string = ""
    if (@value == false) then
      string << "-"
    end
    string << @name
  end
end
