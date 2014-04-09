require_relative '../text_classifier.rb'
require 'test/unit'
require 'fileutils'

class TestCorpora < Test::Unit::TestCase

  def test_a_tiny_corpus
    # classify and write to output.txt
    path = 
    n_training_entries = 5
    TextClassifier.classify('corpora/tinyCorpus.txt')
  end

end