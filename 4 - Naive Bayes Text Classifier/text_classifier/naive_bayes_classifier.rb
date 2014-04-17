class NaiveBayesClassifier
  
  def initialize
    # hash of words
    @vocabulary = Hash.new(0)

    # hash of categories
    # Occ_T(C)
    @categories = Hash.new(0)

    # double hash mapping category to word frequency
    # ie: @category_word_count["government"]["french"] => 1
    # OccT(W|C)
    @category_word_count = Hash.new(0)
  end
  
  def learn(bio)

    get_category_from(bio)
    get_words_from(bio)

  end

  private
  
  def get_words_from(bio)
    cat = bio.category

    bio.words.each do |word|
      @vocabulary[word] += 1
      @category_word_count[cat][word] += 1
    end
  end

  def get_category_from(bio)
    cat = bio.category

    @categories[cat] += 1

    # create the hash in which to store word counts
    @category_word_count[cat] = Hash.new(0)
  end

end