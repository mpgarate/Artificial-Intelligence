var parser = require("./parser.js");

// Parse file to coordinate path
var path = parser.parseFileToCoordinates("./points_coordinates.txt");

function printPath(path){
  console.log(path);
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

function swap(path, a, b){
  var tmp = path[a];
  path[a] = path[b];
  path[b] = tmp;
  return path;
}

// Primary algorithm function
function travellingSalesman(path){
  var best_distance = getTotalDistance(path);
  var best_path = path;

  var new_path;
  var new_distance;
  var new_best_distance = best_distance;
  var best_swap;
  while(true){
    for(var U in path){
      for (var V in path){
        new_path = best_path;
        swap(new_path,U,V);
        // calculate new distance
        new_distance = getTotalDistance(new_path);
        if(new_distance < new_best_distance){
          new_best_distance = new_distance;
          best_swap = [U,V];
        }
        // undo the swap for future iterations
        swap(new_path,U,V);
      }
    }

    if (new_best_distance === best_distance){
      console.log(new_best_distance + " == " + best_distance);
      return path;
    }
    console.log("distances were not equal.");
    best_distance = new_best_distance;
    best_path = new_path;
    path = swap(path,best_swap[0],best_swap[1]);

    console.log("best: " + best_distance + " new: " + new_distance);
  }
}

travellingSalesman(path);