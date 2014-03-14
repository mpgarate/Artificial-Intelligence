== Adventure Game w/ Davis Putnam

=== Usage: Davis Putnam Algorithm

~~~sh
  ruby davis_putnam.rb path/to/input_file.txt
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
Comments allowed here.
```

Produces the following output in ```dp_output.txt```
```
1 T
2 F
3 F
0
This is a simple example with 3 clauses and 3 atoms.
```