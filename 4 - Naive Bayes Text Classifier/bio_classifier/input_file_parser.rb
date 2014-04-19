require 'set'
class InputFileParser
  def initialize(path)
    @input_file = File.open(path, "r")

    stopwords_file = File.open('stopwords.txt', "r")
    parse_stopwords_to_set(stopwords_file)
  end

  def parse_stopwords_to_set(stopwords_file)
    @stopwords = Set.new
    stopwords_file.each_line do |l|
      l.split.each do |word|
        @stopwords.add(word)
      end
    end
  end

  def get_next_bio
    name_pos = 0
    category_pos = 1
    word_set_pos = 2

    name = nil
    category = nil
    word_set = Set.new

    current_position = 0

    previous_name = ""

    @input_file.each_line do |l|
      # if empty line
      if l.split.length == 0 then
        if name == nil then # continue through blank lines
          next
        end

        bio = Biography.new(name, category, word_set)
        name = nil
        return bio
      elsif current_position == name_pos
        words = l.split # remove trailing white space
        name = "#{words[0]} #{words[1]}"
        current_position += 1
      elsif current_position == category_pos
        category = l.split.first # remove trailing white space
        category = category.downcase.capitalize # downcase all and then capitalize first letter
        current_position += 1
      elsif current_position == word_set_pos
        l.split.each do |word|
          word = word.delete "," "."
          word = word.downcase
          if word.length > 2
            word_set.add(word) unless @stopwords.include? word
          end
        end
      end
    end
      return nil
  end
end
