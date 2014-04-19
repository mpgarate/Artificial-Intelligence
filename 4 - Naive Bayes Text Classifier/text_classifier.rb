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
  
  def classify_remaining
    
    total_correct = 0
    total_considered = 0
    # resumes from last place in @file_parser after learning
    bio = @file_parser.get_next_bio
    while(bio != nil) do
      total_considered += 1
      # only give it the words! Cannot access category!
      c = @classifier.classify_with_details(bio.words)

      c.print_detailed_and_compare_to(bio)

      total_correct += 1 if c.is_right_for?(bio)

      bio = @file_parser.get_next_bio
    end



    overall_accuracy = total_correct.to_f / total_considered.to_f
    print "Overall accuracy: #{total_correct} out of #{@total_considered}"
    print "= #{overall_accuracy}\n"

    puts
  end

  private

end
