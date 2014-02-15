var parser = require("./parser.js");

var points = parser.parseFileToCoordinates("./points_coordinates.txt");
console.log(points);