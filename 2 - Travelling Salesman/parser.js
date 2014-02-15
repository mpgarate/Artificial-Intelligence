// Node.js module to allow reading from file
fs = require('fs');

// Determine which use of \n or \r for newline
function getNewlineType(points_string){
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
function inputStringToArray(points_string){
    var newline = getNewlineType(points_string);

    var split_points = points_string.split(newline);
    split_points[0] = split_points[0].split(" ");
    split_points[1] = split_points[1].split(" ");

    var points = [];
    for (var i = 0; i < split_points[0].length; i++){
      points[i] = [];
      points[i][0] = parseFloat(split_points[0][i]);
      points[i][1] = parseFloat(split_points[1][i]);
    } 
    return points;
}

exports.parseFileToCoordinates = function(path){
  // Read file synchronously
  var points_string = fs.readFileSync(path).toString();

  // Remove extra blank spaces from input
  while(points_string.indexOf("  ") > 0){
    points_string = points_string.replace("  ", " ");
  }

  return inputStringToArray(points_string);
}
