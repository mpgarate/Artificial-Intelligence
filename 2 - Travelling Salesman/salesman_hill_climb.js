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

function swapForImprovedDistance(path, best, j){
  var best_distance = best;
  var best_path = path;
  var best_swap = [];
  for(var i in path){
    for(var j in path){
      new_path = swap(path, i, j);
      var new_distance = getTotalDistance(new_path);
      if (new_distance < best_distance){
        console.log("found " + new_distance);
        best_distance = new_distance;
        best_path = new_path;
        best_swap = [i, j];
      }
    }
  }
  console.log(best_swap);
  return [best_distance, best_path];
}

// Primary algorithm function
function travellingSalesman(path){
  var best_distance = getTotalDistance(path);
  var best_path = path;
  while(true){
    var result = swapForImprovedDistance(best_path, best_distance);
    var new_distance = result[0];
    var new_path = result[1];

    console.log("best: " + best_distance + " new: " + new_distance);
    if (best_distance <= new_distance){
      return new_path;
    }
    else{
      best_distance = new_distance;
      best_path = new_path;
    }
  }
}

travellingSalesman(path);