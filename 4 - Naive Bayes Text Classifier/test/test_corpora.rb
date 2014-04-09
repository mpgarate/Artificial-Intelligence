require_relative '../text_classifier.rb'
require 'test/unit'
require 'fileutils'

class TestCorpora < Test::Unit::TestCase

  def test_a_tiny_corpus

    path = 'test/corpora/tinyCorpus.txt'
    n_entries = 5

    tc = TextClassifier.new(path, n_entries)
    # classify and write to output.txt
    
  end

end