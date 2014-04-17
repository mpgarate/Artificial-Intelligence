class NaiveBayesClassifier
  EPSILON = 0.1

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
  end
  
  # takes a string array of words and a string for the category
  def learn(words,cat)
    @corpus_size++

    @categories[cat] += 1

    # create the hash in which to store word counts
    if @category_word_count[cat] == 0 then
      @category_word_count[cat] = Hash.new(0)
    end

    words.each do |word|
      @vocabulary[word] += 1
      @category_word_count[cat][word] += 1
    end
  end

  def classify(words)
    best_match = nil

    @categories.each_key do |cat|
      sum = 0
      words.each do |word|
        sum += get_l_of_w_given_c(word,cat)
      end

      l_of_c_given_b = get_l_of_c(cat) + sum

      puts "#{cat} : #{l_of_c_given_b}"

      if best_match == nil or best_match[0] > sum then
        best_match = [sum,cat]
      end
    end

    return best_match
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

  def get_l_of_c(cat)
    -Math.log(get_prob_of_category(cat),2)
  end

  def get_l_of_w_given_c(word,cat)
    -Math.log(get_prob_of_word_given_cat(word,cat),2)
  end

end