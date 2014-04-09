require 'set'

require_relative 'text_classifier/biography.rb'
require_relative 'text_classifier/word_set.rb'

class TextClassifier

  def initialize(path,n_entries)
    input_file = File.open(path, "r")
    stopwords_file = File.open('stopwords.txt', "r")

    parse_stopwords_to_set(stopwords_file)

    parse_file_to_bios(input_file)

  end

  private

  def parse_stopwords_to_set(stopwords_file)
    @stopwords = Set.new
    stopwords_file.each_line do |l|
      l.split.each do |word|
        @stopwords.add(word)
      end
    end
  end

  def parse_file_to_bios(input_file)
    @bios = []
    name_pos = 0
    category_pos = 1
    word_set_pos = 2

    name = nil
    category = nil
    word_set = Set.new

    current_position = 0

    input_file.each_line do |l|
      # if empty line
      if l.split.length == 0 then
        bio = Biography.new(name, category, word_set)
        @bios << (bio)

        puts bio

        current_position = 0
        name = nil
        category = nil
        word_set = Set.new
      elsif current_position == name_pos
        words = l.split # remove trailing white space
        name = "#{words[0]} #{words[1]}"
        current_position += 1
      elsif current_position == category_pos
        category = l.split.first # remove trailing white space
        current_position += 1
      elsif current_position == word_set_pos
        l.split.each do |word|
          word = word.delete "," "."
          word_set.add(word) unless @stopwords.include? word
        end
      end
    end
  end

end