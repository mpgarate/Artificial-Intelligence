class Biography
  attr_accessor :category, :words

  def initialize(name,category,word_set)
    @name = name
    @category = category
    @words = word_set
  end

  def to_s
    return "#{@name} : #{@category} : #{@word_set.to_a}"
  end
  
end