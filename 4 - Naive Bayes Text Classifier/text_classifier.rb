require 'set'

require_relative 'text_classifier/naive_bayes_classifier.rb'
require_relative 'text_classifier/input_file_parser.rb'
require_relative 'text_classifier/biography.rb'

class TextClassifier

  def initialize(path,n)
    @path = path
    @n = n

    file_parser = InputFileParser.new(path)
    classifier = NaiveBayesClassifier.new
    
    bio = file_parser.get_next_bio
    n.times do
      break if bio == nil # reached end of file before n

      bio = file_parser.get_next_bio

      classifier.learn bio
    end
  end

  def classify

  end
end
