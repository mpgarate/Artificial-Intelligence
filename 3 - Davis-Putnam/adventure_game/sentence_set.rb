class SentenceSet
  attr_accessor :sentences
  def initialize
    @sentences = []
  end
  
  def add(obj)
    @sentences << obj
  end

  def to_digits

  end

  def to_s
    str = ""
    @sentences.each do |s|
      str << s.to_s
      str << "\n"
    end
    return str
  end
end
