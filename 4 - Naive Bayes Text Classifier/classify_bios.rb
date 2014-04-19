require_relative 'text_classifier.rb'

# defaults
verbose = false
path = "corpus.txt"
n = 5

n = ARGV[0].to_i || n
path = ARGV[1] || path

ARGV.each do |arg|
  if arg == "-v" then
    verbose = true
  end
end

puts "n: #{n}"
puts "path: #{path}"
puts "verbose: #{verbose} "


bc = TextClassifier.new(path)
bc.learn_first(n)
bc.classify_remaining