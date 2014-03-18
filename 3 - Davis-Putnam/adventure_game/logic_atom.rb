class LogicAtom
  attr_accessor :value, :a, :b, :type

  def initialize(type,a,b,value=nil)
    @string = "#{type}(#{a},#{b})"
    @type = type
    @a = a
    @b = b
    @value = value
  end

  def to_s
    val = "nil"
    val = @value unless @value == nil
    "#{@string} : #{val}"
  end


  def duplicate
    LogicAtom.new(@type,@a,@b,@value)
  end
end