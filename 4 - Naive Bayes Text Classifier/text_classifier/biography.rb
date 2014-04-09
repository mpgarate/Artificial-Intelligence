class Biography
  def initialize(name,category,word_set)
    @name = name
    @category = category
    @word_set = word_set
  end

  def to_s
    return "#{@name} : #{@category} : #{@word_set.to_a}"
  end
end