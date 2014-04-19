require_relative 'bio_classifier.rb'


# defaults
verbose = false
path = "corpus.txt"
n = 5

# set vals from args if present
n = ARGV[0].to_i || n
path = ARGV[1] || path

ARGV.each do |arg|
  if arg == "-v" then
    verbose = true
  end
end

# alert the user of the settings to be used

puts "n: #{n}"
puts "path: #{path}"
puts "verbose: #{verbose} "

puts


# run the classification
bc = BioClassifier.new(path, verbose)
bc.learn_first(n)
bc.classify_remaining