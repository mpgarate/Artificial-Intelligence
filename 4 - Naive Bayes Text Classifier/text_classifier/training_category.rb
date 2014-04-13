class TrainingCategory
  attr_accessor :words, :count, :freqt, :prob

  def initialize(name)
    @name = name
    @count = 1

    # "america" => 3
    @words = Hash.new
  end

  def increment!
    @count += 1
  end

  def handle_word_occurrence(word)
    if @words.include? word
      val = @words[word]
      val += 1
    else
      val = 1
    end

    @words[word] = val
  end

  def to_s
    return "#{@name} : #{@count} : #{@words}"
  end

end
