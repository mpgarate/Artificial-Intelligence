require 'set'

require_relative 'text_classifier/naive_bayes_classifier.rb'
require_relative 'text_classifier/input_file_parser.rb'
require_relative 'text_classifier/biography.rb'

class TextClassifier

  def initialize(path)
    @classifier = NaiveBayesClassifier.new
    @file_parser = InputFileParser.new(path)
  end

  def learn_first(n)    
    bio = @file_parser.get_next_bio
    (n).times do
      break if bio == nil # reached end of file before n
   
      @classifier.learn(bio.words, bio.category)

      bio = @file_parser.get_next_bio
    end

    @classifier.print_contents
  end

  def classify_remaining
    
    # resumes from last place in @file_parser after learning

    bio = @file_parser.get_next_bio
    while(bio != nil) do
      # only give it the words! Cannot access category!
      result = @classifier.classify(bio.words)

      puts "#{bio.name}. Prediction #{result[1]} should be #{bio.category}"
      bio = @file_parser.get_next_bio
    end
  end
end
