require 'set'

require_relative 'text_classifier/biography.rb'
require_relative 'text_classifier/word_set.rb'
require_relative 'text_classifier/input_file_parser.rb'
require_relative 'text_classifier/training_set.rb'
require_relative 'text_classifier/training_category.rb'
require_relative 'text_classifier/prob_calculator.rb'

class TextClassifier

  def initialize(path,n_entries)
    ifp = InputFileParser.new(path)
    training_set = TrainingSet.new(n_entries)
    
    bio = ifp.get_next_bio
    n_entries.times do
      break if bio == nil # reached end of file before n
      bio = ifp.get_next_bio

      training_set.add bio
    end

    training_set.update_probabilities

  end
end