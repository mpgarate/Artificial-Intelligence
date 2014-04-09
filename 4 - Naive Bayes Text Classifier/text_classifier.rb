require 'set'

require_relative 'text_classifier/biography.rb'
require_relative 'text_classifier/word_set.rb'
require_relative 'text_classifier/input_file_parser.rb'

class TextClassifier

  def initialize(path,n_entries)
    ifp = InputFileParser.new(path)
    
    bio = ifp.get_next_bio
    while bio != nil
      puts bio
      
      bio = ifp.get_next_bio
    end
  end
end