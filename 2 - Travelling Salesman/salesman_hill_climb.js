// Import module for parsing coordinate path
var parser = require("./parser.js");

// Parse file to coordinate path
var path = parser.parseFileToCoordinates("./points_coordinates.txt");

function printPath(path){
  for(var i in path){
    //console.log(path[i][0]);
    process.stdout.write(path[i][0].toFixed(1) + "  ");
  }
  console.log();
  for(var i in path){
    process.stdout.write(path[i][1].toFixed(1) + "  ");
  }
  console.log();
}

// Get distance between two point pairs
function getPointsDistance(a, b){
  var sum = Math.pow((b[0] - a[0]),2) + Math.pow((b[1] - a[1]),2);
  return Math.sqrt(sum);
}

// Get total distance between points in path
function getTotalDistance(path){
  var total_distance = 0;
  for (var i = 0; i < path.length - 1; i++){
    total_distance += getPointsDistance(path[i], path[i + 1]);
  }
  // get distance from the last point back to the origin
  total_distance += getPointsDistance(path[path.length - 1], path[0]);

  return total_distance;
}

function swap_x_y(path, a, b){
  var tmp = path[a];
  path[a] = path[b];
  path[b] = tmp;
  return path;
}

function printPathIteration(path, swap, distance){
  if (swap[0] !== undefined){
    var swap_x = parseFloat(swap[0]) + 1;
    var swap_y = parseFloat(swap[1]) + 1;
    console.log("Swap " + swap_x + " and " + swap_y);
    console.log();
  }
  printPath(path);
  console.log();
  console.log("Length = " + distance.toFixed(4));
  console.log();
}

// Primary algorithm function
function simpleTravellingSalesman(path){
  var best_distance = getTotalDistance(path);
  
  var new_distance;
  var new_best_distance = best_distance;
  var best_swap = [];

  // Print out the initial path state
  console.log("Path:");
  printPathIteration(path,best_swap,best_distance);

  while(true){
    for(var U in path){
      for (var V in path){
        swap_x_y(path,U,V);
        // calculate new distance
        new_distance = getTotalDistance(path);
        if(new_distance < new_best_distance){
          new_best_distance = new_distance;
          best_swap[0] = U;
          best_swap[1] = V;
        }
        // undo the swap for future iterations
        swap_x_y(path,U,V);
      }
    }

    if (new_best_distance === best_distance){
      console.log("End of hill climbing");
      return path;
    }
    best_distance = new_best_distance;
    path = swap_x_y(path,best_swap[0],best_swap[1]);

    // Print out this iteration
    printPathIteration(path,best_swap,best_distance);
  }
}

function getWrappedIndex(length,index){
  if (index === -1){
    return length - 1;
  }
  if (index === length){
    return 0;
  }
  return index;
}

function calculateLengthChange(path,U,V){
  var difference = 0;
  var length = path.length;
  console.log("length: " + path.length);
  console.log("U: " + U + " V: " + V);

  U = Number(U);
  V = Number(V);

  var U_minus_1 = getWrappedIndex(length, (U-1));
  var V_minus_1 = getWrappedIndex(length, (V-1));
  var U_plus_1 = getWrappedIndex(length, (U+1));
  var V_plus_1 = getWrappedIndex(length, (V+1));

  console.log("U_minus_1 " + U_minus_1);
  console.log("V_minus_1 " + V_minus_1);
  console.log("U_plus_1 " + U_plus_1);
  console.log("V_plus_1 " + V_plus_1);

  // If locations in sequence
  if(Math.abs(U - V) == 1){
    difference -= getPointsDistance(U_minus_1, U);
    difference -= getPointsDistance(V_plus_1, V);

    difference += getPointsDistance(U_minus_1,U_plus_1);
    difference += getPointsDistance(V_minus_1,V_plus_1);
  }
  else{
    difference -= getPointsDistance(U_minus_1, U);
    difference -= getPointsDistance(U, U_plus_1);
    difference -= getPointsDistance(V_minus_1,V);
    difference -= getPointsDistance(V, V_plus_1);

    difference += getPointsDistance(U_minus_1, V);
    difference += getPointsDistance(V, U_plus_1);
    difference += getPointsDistance(V_minus_1, U);
    difference += getPointsDistance(U, V_plus_1);
  }
  return difference;
}

function improvedTravellingSalesman(path){
  var best_distance = getTotalDistance(path);

  var difference;
  var best_difference;
  var best_swap = [];
  while(true){
    best_difference = 0;
    for(var U in path){
      for(var V in path){
        difference = calculateLengthChange(path,U,V);
        console.log(difference);
        if (difference < best_difference){
          best_difference = difference;
          best_swap[0] = U;
          best_swap[1] = V;
        }
      }
    }

    if(best_difference === 0){
      return path;
    }
    path = swap(path,best_swap[0],best_swap[1]);
    length += best_difference;

    // Print out this iteration
    printPathIteration(path,best_swap,best_distance);
  }
}

//simpleTravellingSalesman(path);
improvedTravellingSalesman(path);