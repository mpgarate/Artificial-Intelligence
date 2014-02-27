Traveling Salesman Hill Climbing
=======================
Salesman Hill Climbing written in Javascript.
Written by Michael Garate for the NYU Artificial Intelligence course.

Includes animation visible by opening ```./animated_salesman/index.html``` in a browser.

Store points in the file ```points_coordinates.txt```.

Run ```salesman_hill_climb.js``` with Node.js from the terminal

```sh
$ node node salesman_hill_climb.js
```

For the sample input, it produces the following output:

```
Path:
0.0  1.0  2.0  0.0  2.0  1.0  
0.0  2.0  0.0  1.0  1.0  0.0  

Length = 11.1224

Swap 1 and 5

2.0  1.0  2.0  0.0  0.0  1.0  
1.0  2.0  0.0  1.0  0.0  0.0  

Length = 9.3006

Swap 2 and 3

2.0  2.0  1.0  0.0  0.0  1.0  
1.0  0.0  2.0  1.0  0.0  0.0  

Length = 8.0645

Swap 1 and 2

2.0  2.0  1.0  0.0  0.0  1.0  
0.0  1.0  2.0  1.0  0.0  0.0  

Length = 6.8284

End of hill climbing
```
