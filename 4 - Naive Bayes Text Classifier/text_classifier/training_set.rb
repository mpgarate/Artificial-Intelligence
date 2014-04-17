class TrainingSet
  attr_accessor :biographies, :categories

  def initialize(n)
    @n = n
    @biographies = []

    # category name mapped to TrainingCategory object 
    @categories = Hash.new

    @words = Hash.new
    @word_count

    # class to calculate probabilities
    @prob_calc = ProbCalculator.new(@n,@categories,@biographies)

  end

  def add(bio)
    @biographies << bio

    handle_category(bio.category)

    categorize_words_in(bio)

  end


  def get_category_occurrence(category,n)
    return @categories[category].count.to_f / n.to_f
  end


  def update_probabilities
    @biographies.each do |bio|
      update_probabilities_for(bio)
    end
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
      # alert the category that a word has occurred
      @categories[bio.category].handle_word_occurrence(word)

      if @words.include? word then
        # alert the word object that it has appeared again
        @words[word].handle_word_occurrence(word,bio)
      else
        @words[word] = Word.new(word,bio)
      end
    end
  end


  def update_probabilities_for(bio)

    # Step 1: For each classiﬁcation C, deﬁne FreqT
    # (C) = OccT(C)/|T|, the fraction of the biographies
    # that are of category C. For instance, in the tiny 
    # training corpus, FreqT (Government) = 2/5.

    @prob_calc.update_freq_t_of_c(bio)

    # Step 2: For each classiﬁcation C and word W,
    # compute the probabilities using the Laplacian
    # correction.

    @prob_calc.update_prob_of_c(bio)
    @prob_calc.update_prob_of_w_given_c(bio)

  end

end