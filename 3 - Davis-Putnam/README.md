# Adventure Game w/ Davis Putnam

Written in Ruby. 

### Usage: Adventure Game

~~~ruby
    require_relative 'davis_putnam'
    require_relative 'adventure_game'

    file_path = 'test/ag_simple.txt'
    game = AdventureGame.new(file_path)
    game.generate_logic # game front end
    game.write_logic('io/game.txt')
    DavisPutnam.solve_file("io/game.txt")
    game.print_dp_results('dp_output.txt') # game back end

~~~


### Usage: Davis Putnam Algorithm

~~~ruby
  require_relative 'davis_putnam'
  path = "path/to/input_file.txt"
  DavisPutnam.solve_file(path)
~~~

### Tests

Run all tests for the adventure game:
~~~sh
ruby test_game_cases.rb
~~~

Run all tests for david putnam solver:
~~~sh
ruby test_dp_cases.rb
~~~


Run game tests individually:
~~~sh
# simple example from assignment
ruby test_game_cases.rb -n test_a_simple_case

# primary example from assignment
ruby test_game_cases.rb -n test_b_normal_case

# impossible example. should print "No solution."
ruby test_game_cases.rb -n test_c_impossible_case

# custom long example. Takes about 1 minute to solve.
ruby test_game_cases.rb -n test_d_bigger_case

# long and difficult example. Takes 10+ minutes to solve.
ruby test_game_cases.rb -n test_d_impossible_case
~~~


Run david putnam tests individually:
~~~sh
# trivial example from assignment
ruby test_dp_cases.rb -n test_trivial

# another example from assignment
ruby test_dp_cases.rb -n test_normal

# example from sample midterm
ruby test_dp_cases.rb -n test_sample_midterm

# example from AI homework 5
ruby test_dp_cases.rb -n test_hw5

# example from midterm exam
ruby test_dp_cases.rb -n test_midterm
~~~
