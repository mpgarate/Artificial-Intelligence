class Classification
  def initialize
    @best_match = []
    @matches = Hash.new
  end

  def best_category
    @best_match[0]
  end

  def add(cat, val)
    @matches[cat] = val

    if @best_match.empty? or @best_match[1] > val then
      @best_match = [cat,val]
    end
  end

  def print_detailed_and_compare_to(bio)
    if @best_match[0] == bio.category then
        right_or_wrong = "Right"
      else
        right_or_wrong = "Wrong"
      end

      puts "#{bio.name}. Prediction: #{@best_match[0]}. #{right_or_wrong}."

      value_sum = 0
      @matches.each_key do |cat|
        print("#{cat}: ")
        printf("%.2f",@matches[cat])
        print("    ")

      end

      puts
      puts
  end
end