require 'set'

require_relative 'text_classifier/naive_bayes_classifier.rb'
require_relative 'text_classifier/input_file_parser.rb'
require_relative 'text_classifier/biography.rb'
require_relative 'text_classifier/classification.rb'

class TextClassifier

  def initialize(path)
    @classifier = NaiveBayesClassifier.new
    @path = path
    @file_parser = InputFileParser.new(path)
  end

  def learn_first(n)

    (n).times do
      bio = @file_parser.get_next_bio
      break if bio == nil # reached end of file before n
      
      @classifier.learn(bio.words, bio.category)
    end

    @classifier.print_contents
  end

  def classify_first(n)
    @file_parser = InputFileParser.new(@path)

    n.times do
      bio = @file_parser.get_next_bio
      break if bio == nil

      c = @classifier.classify_with_details(bio.words)

      c.print_detailed_and_compare_to(bio)
      
    end
  end

  def classify_remaining
    
    # resumes from last place in @file_parser after learning
    bio = @file_parser.get_next_bio
    while(bio != nil) do

      # only give it the words! Cannot access category!
      c = @classifier.classify_with_details(bio.words)

      c.print_detailed_and_compare_to(bio)

      bio = @file_parser.get_next_bio
    end
  end

  private

end
