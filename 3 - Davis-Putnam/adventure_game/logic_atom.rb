class LogicAtom
  def initialize(type,a,b,value=nil)
    @string = "#{type}(#{a.name},#{b.name})"
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
    new LogicAtom(@type,@a,@b,@value)
  end
end