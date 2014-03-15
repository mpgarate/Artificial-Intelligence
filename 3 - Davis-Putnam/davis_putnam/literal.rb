# lit = Literal.new("-4")
# lit.name => "4"
# lit.value => false
# lit.to_s => "-4"
class Literal
  attr_accessor :name, :value, :string

  def initialize(str)
    @name = str.delete("-")

    if str.include? '-' then
      @value = false
    else
      @value = true
    end
  end

  def to_s
    str = ""
    str << "-" if @value == false
    str << @name
    return str
  end

  def ==(object)

    if object.is_a?(Literal) then
      if @name == object.name and @value == object.value
        return true
      end
      return false
    elsif object == nil then
      if @value == nil
        return true
      else
        return false
      end
    end
  end

  def negate
    str = ""
    str << "-" if @value == true
    str << @name
    return Literal.new(str)
  end
end
