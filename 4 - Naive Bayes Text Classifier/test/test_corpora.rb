require_relative '../bio_classifier.rb'
require 'test/unit'
require 'fileutils'

class TestCorpora < Test::Unit::TestCase

  def test_a_tiny_corpus

    path = 'test/corpora/tinyCorpus.txt'
    n = 5

    # train the classifier on the first n entries of a formatted file
    bc = BioClassifier.new(path)
    bc.learn_first(n)
    #tc.classify_first(n)

    bc.classify_remaining

    # classify and write to output.txt
    
  end

  def test_b_small_corpus

    path = 'test/corpora/bioCorpus.txt'
    n = 5

    # train the classifier on the first n entries of a formatted file
    bc = BioClassifier.new(path)
    bc.learn_first(n)
    #tc.classify_first(n)

    bc.classify_remaining

    # classify and write to output.txt
    
  end

end
