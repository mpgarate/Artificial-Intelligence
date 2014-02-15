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

// Get distance between two points
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
function travellingSalesman(path){
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

travellingSalesman(path);