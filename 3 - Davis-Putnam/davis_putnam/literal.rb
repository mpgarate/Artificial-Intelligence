# lit = Literal.new("-4")
# lit.name => "4"
# lit.value => false
# lit.to_s => "-4"
class Literal
  attr_accessor :name, :value, :int_val, :string

  def initialize(str)
    @int_val = str.to_i
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
    return false if nil == object
    if @int_val == object.int_val
      return true
    else
      return false
    end
  end
  
=begin

  def ==(object)
    if object.is_a?(Literal) then
      if @string == object.string
        return true
      else
        return false
      end
    elsif object == nil then
      if @value == nil
        return true
      else
        return false
      end
    end
  end
=end
  def negate
    str = ""
    str << "-" if @value == true
    str << @name
    return Literal.new(str)
  end
end
