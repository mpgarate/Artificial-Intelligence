// global variable for output log
var LOG = $(".output-log");

// Determine which use of \n or \r for newline in file
function getNewlineType(points_string){
  var newline;
    if (points_string.indexOf("\r\n") > 0){
      newline = "\r\n";
    }
    else if (points_string.indexOf("\r") > 0){
      newline = "\r";
    }
    else if (points_string.indexOf("\n") > 0){
      newline = "\n";
    }
    else{
      console.log("Invalid input. Should contain two lines.");
    }
    return newline;
}

// Convert String to an array
function inputStringToArray(split_points){

  x_points = split_points[0].split(" ");
  y_points = split_points[1].split(" ");

  var points = [];
  for (var i = 0; i < x_points.length; i++){
    points[i] = [];
    points[i][0] = parseInt(x_points[i]);
    points[i][1] = parseInt(y_points[i]);
  } 
  return points;
}


function getCoordinatesFromPage(){
  // Read file synchronously
  var split_points = []
  split_points[0] = $(".x-coordinates input").val();
  split_points[1] = $(".y-coordinates input").val();
  return inputStringToArray(split_points);
}

function printPath(path){
  clear_path_segments(path);
  for(var i in path){
    LOG.append(path[i][0].toFixed(1) + "  ");
    var next_point = (parseInt(i) + 1);
    if (next_point === path.length){
      next_point = 0;
    }
    console.log("index: " + i + " next: " +  next_point + " : " + path[next_point]);
    draw_path_segment(path[i], path[next_point]);
  }
  LOG.append("<br />");
  for(var i in path){
    LOG.append(path[i][1].toFixed(1) + "  ");
  }
  LOG.append("<br />");
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
    LOG.append("Swap " + swap_x + " and " + swap_y);
    LOG.append("<br />");
  }
  printPath(path);
  LOG.append("<br />");
  LOG.append("Length = " + distance.toFixed(4));
  LOG.append("<br />");
}

// Primary algorithm function
function simpleTravellingSalesman(path){
  var best_distance = getTotalDistance(path);
  
  var new_distance;
  var new_best_distance = best_distance;
  var best_swap = [];

  // Print out the initial path state
  LOG.append("Path:");
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
      LOG("End of hill climbing");
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
  V = parseInt(V);
  U = parseInt(U);
  if(U === V) return 0;
  
  var difference = 0;
  var length = path.length;
  var index_abs_difference = Math.abs(U - V);

  // Swap U and V to ensure V > U except when index-
  // wrapping is necessary
  if ((index_abs_difference === length-1) && (V > U)){
    var tmp = U;
    U = V;
    V = tmp;
  }
  else if ((index_abs_difference !== length-1) && (V < U)){
    var tmp = U;
    U = V;
    V = tmp;
  }

  var U_minus_1 = path[getWrappedIndex(length, (U-1))];
  var V_minus_1 = path[getWrappedIndex(length, (V-1))];
  var U_plus_1 = path[getWrappedIndex(length, (Number(U)+1))];
  var V_plus_1 = path[getWrappedIndex(length, (Number(V)+1))];

  var U_val = U;
  var V_val = V;

  U = path[U];
  V = path[V];

  var distance;

  // If locations in sequence
  if(index_abs_difference === 1 || index_abs_difference === length-1){
    difference -= getPointsDistance(U_minus_1, U);
    difference -= getPointsDistance(V, V_plus_1);
    difference += getPointsDistance(U_minus_1,V);
    difference += getPointsDistance(U,V_plus_1);
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
  return parseFloat(difference.toFixed(12));
}

function improvedTravellingSalesman(path){
  var best_distance = getTotalDistance(path);

  var difference;
  var best_difference;
  var best_swap = [];

  // Print out the initial path state
  console.log("Path:");
  printPathIteration(path,best_swap,best_distance);

  while(true){
    best_difference = 0;
    for(var U in path){
      for(var V in path){
        difference = calculateLengthChange(path,U,V);
        if (difference < best_difference){
          best_difference = difference;
          best_swap[0] = U;
          best_swap[1] = V;
        }
      }
    }

    if(best_difference === 0){
      console.log("End of hill climbing");
      return path;
    }
    path = swap_x_y(path,best_swap[0],best_swap[1]);
    best_distance += best_difference;

    // Print out this iteration
    printPathIteration(path,best_swap,best_distance);
    if (best_distance < 0) break;
  }
}

//simpleTravellingSalesman(path);
//improvedTravellingSalesman(path);

$( document ).ready(function() {

  draw_grid();
  var path = getCoordinatesFromPage();
  draw_path(path);


  $(".draw-button").click(function(){
    draw_grid();
    var path = getCoordinatesFromPage();
    LOG.empty();
    draw_path(path);
  });

  $(".solve-button").click(function(){
    var path = getCoordinatesFromPage();
    LOG.empty();

    improvedTravellingSalesman(path);
  });

});