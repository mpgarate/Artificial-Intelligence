class ProbCalculator
  EPSILON = 0.1

  def initialize(n,categories,biographies)
    @n = n
    @categories = categories
    @biographies = biographies
  end

  # Step 1: For each classiﬁcation C, deﬁne FreqT
  # (C) = OccT(C)/|T|, the fraction of the biographies
  # that are of category C. For instance, in the tiny 
  # training corpus, FreqT (Government) = 2/5.
  def update_freq_t_of_c(bio)
    val = @categories[bio.category].count.to_f / @n.to_f
    @categories[bio.category].freqt = val
  end

  # Step 2: For each classiﬁcation C and word W,
  # compute the probabilities using the Laplacian
  # correction. Let EPSILON = 0.1
  def update_prob_of_c(bio)
    freq_t_of_c = @categories[bio.category].freqt

    numerator = freq_t_of_c + EPSILON
    denominator = 1 + (@categories.length * EPSILON)

    prob_of_c = numerator.to_f / denominator.to_f

    @categories[bio.category].prob = prob_of_c

    puts "#{bio.category} : #{prob_of_c}"
  end

  def update_prob_of_w_given_c(bio)
  end

end