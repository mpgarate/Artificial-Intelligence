class TrainingSet
  attr_accessor :biographies, :categories

  def initialize
    @biographies = []

    # category name mapped to TrainingCategory object 
    @categories = Hash.new

  end

  def add(bio)
    @biographies << bio

    handle_category(bio.category)

    categorize_words_in(bio)
  end

  private

  def handle_category(cat)
     if @categories.include? cat
      @categories[cat].increment!
    else
      @categories[cat] = TrainingCategory.new(cat) 
    end
  end

  def categorize_words_in(bio)
    bio.words.each do |word|
      @categories[bio.category].handle_word_occurrence(word)
    end
  end

end