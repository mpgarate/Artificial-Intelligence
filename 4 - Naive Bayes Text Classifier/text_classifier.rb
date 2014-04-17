require 'set'

require_relative 'text_classifier/naive_bayes_classifier.rb'
require_relative 'text_classifier/input_file_parser.rb'
require_relative 'text_classifier/biography.rb'

class TextClassifier

  def initialize
    @classifier = NaiveBayesClassifier.new
  end

  def learn(path,n)
    file_parser = InputFileParser.new(path)
    
    bio = file_parser.get_next_bio
    n.times do
      break if bio == nil # reached end of file before n

      bio = file_parser.get_next_bio
      
      @classifier.learn(bio.words, bio.category)
    end
  end

  def classify(path,n)
    file_parser = InputFileParser.new(path)
    
    bio = file_parser.get_next_bio
    n.times do
      break if bio == nil # reached end of file before n
      bio = file_parser.get_next_bio
    end

    while(bio != nil) do
      bio = file_parser.get_next_bio

      # only give it the words! Cannot access category!
      @classifier.classify(bio.words)
    end
  end
end
