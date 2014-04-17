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

    # count how many biographies are learned
    @corpus_size = 0

    EPSILON = 0.1
  end
  
  # takes a string array of words and a string for the category
  def learn(words,cat)
    @corpus_size++

    @categories[cat] += 1

    # create the hash in which to store word counts
    @category_word_count[cat] = Hash.new(0)

    words.each do |word|
      @vocabulary[word] += 1
      @category_word_count[cat][word] += 1
    end
  end

  private

  #
  # Probabilities. Ideally all of these run in constant time. 
  #

  # fraction of biographies of category C that contain W
  def get_freq_of_w_given_c(word,cat)
    @category_word_count[cat][word].to_f / @categories[cat].to_f
  end

  #  Freq_T(C) = Occ_T(C)/|T|, the fraction of the biographies
  # that are of category C
  def get_category_frequency(cat)
    @categories[cat].to_f / @corpus_size.to_f 
  end

  # P(C)
  def get_prob_of_category(cat)
    freq_of_c = get_category_frequency(cat)
    
    numerator = freq_of_c + EPSILON

    denominator = 1 + (@categories.length * EPSILON)

    return numerator / denominator
  end

  # 
  def get_prob_of_word_given_cat(word,cat)
    freq_of_w_given_c = get_freq_of_w_given_c(word,cat)

    numerator = freq_of_w_given_c + EPSILON
    denominator = 1 + (2 * EPSILON)

    return numerator / denominator
  end

end