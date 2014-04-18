require_relative '../text_classifier.rb'
require 'test/unit'
require 'fileutils'

class TestCorpora < Test::Unit::TestCase

  def test_a_tiny_corpus

    path = 'test/corpora/tinyCorpus.txt'
    n = 5

    # train the classifier on the first n entries of a formatted file
    tc = TextClassifier.new
    tc.learn(path,n)
    tc.classify(path,n)

    # classify and write to output.txt
    
  end

end
