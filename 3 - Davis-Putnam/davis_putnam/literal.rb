# lit = Literal.new("-4")
# lit.name => "4"
# lit.value => false
# lit.to_s => "-4"
class Literal
  attr_accessor :name, :value, :string

  def initialize(str)
    @string = str
    @name = str.delete("-")

    if str.include? '-' then
      @value = false
    else
      @value = true
    end
  end

  def to_s
    @string
  end

  def ==(object)

    if @name == object.name and @value == object.value
      return true
    end

    return false
  end

  def negate
    str = ""
    str << "-" if @value == false
    str << @name
    return Literal.new(str)
  end
end
