# Adventure Game w/ Davis Putnam

### Usage: Davis Putnam Algorithm

~~~sh
  $ ruby davis_putnam.rb path/to/input_file.txt
~~~

or

~~~ruby
  require_relative 'davis_putnam'
  path = "path/to/input_file.txt"
  DavisPutnam.solve_file(path)
~~~

Input file conventionally stored in ```dp_input.txt``` 
```
1 2 3 
-2 3 
-3 
0 
This is a simple example with 3 clauses and 3 atoms.
```

Produces the following output in ```dp_output.txt```
```
1 T
2 F
3 F
0
This is a simple example with 3 clauses and 3 atoms.
```

### Tests

Run all tests for the adventure game:
~~~sh
ruby test_game_cases.rb
~~~


Run tests individually:
~~~sh
# simple example from assignment
ruby test_game_cases.rb -n test_a_simple_case

# primary example from assignment
ruby test_game_cases.rb -n test_b_normal_case

# custom long example. takes about 45 seconds
ruby test_game_cases.rb -n test_c_bigger_case

# impossible example. should print "No solution."
ruby test_game_cases.rb -n test_d_impossible_case
~~~


Run tests for david putnam algorithm (without game):
~~~sh
ruby test_dp_cases.rb
~~~

Run tests individually:
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
