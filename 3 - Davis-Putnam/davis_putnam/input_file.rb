# parse an input file to clauses
#
# file = InputFile.new("dp_input.txt")
# file.clauses
#   => [[1,2,3],[-2,3],[-3]]

class InputFile
  attr_accessor :clauses, :file

  def initialize(filename)
    @clauses = []

    @file = File.open(filename)
    @file.each_line do |line|
      break if line.eql? "0 \n" or line.eql?("0\n")
      @clauses << Clause.new(line)
    end
  end
end
