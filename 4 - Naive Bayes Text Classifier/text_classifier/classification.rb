class Classification
  def initialize
    @best_match = []
    @min_match = []
    @matches = Hash.new
    @value_sum = 0
  end

  def best_category
    @best_match[0]
  end

  def add(cat, val)
    @matches[cat] = val
    @value_sum += val

    if @best_match.empty? or @best_match[1] > val then
      @best_match = [cat,val]
    end

    if @min_match.empty? or @min_match[1] < val then
      @min_match = [cat,val]
    end
  end

  def print_detailed_and_compare_to(bio)

    recovered_sum = 0
    recovered_matches = Hash.new
    @matches.each do |k,v|
      rp = recover_probability(v)
      recovered_matches[k] = rp
      recovered_sum += rp
    end

    recovered_matches.each_key do |k|
      val = recovered_matches[k]
      recovered_matches[k] = (val / recovered_sum)
    end

    if @best_match[0] == bio.category then
        right_or_wrong = "Right"
      else
        right_or_wrong = "Wrong"
      end

      puts "#{bio.name}. Prediction: #{@best_match[0]}. #{right_or_wrong}."

      @matches.each_key do |cat|
        print("#{cat}: ")
        printf("%.2f", recovered_matches[cat])
        print("    ")

      end

      puts
      puts
  end

  def recover_probability(val)
    if val - @min_match[1] < 7 then
      return 2 ** (@min_match[1] - val)
    else
      return 0
    end
  end
end