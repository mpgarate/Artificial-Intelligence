var X_OFFSET = 50;
var Y_OFFSET = 450;
var MULT = 100;

function draw_grid(context){
  var canvas = document.getElementById("canvas_a");
  var context = canvas.getContext("2d");

  canvas.width = canvas.width;


  var first_x = true;
  for (var x = 0; x < 500; x += 50) {
    context.moveTo(x, 0);
    context.lineTo(x, 500);
    var label = (x / 100) - 0.5;
    if (label >= 0){
      context.fillText(label.toString(), x, 500);
    }
  }
  var first_y = true;
  for (var y = 0; y < 500; y += 50) {
    context.moveTo(0, y);
    context.lineTo(500, y);
    var label = 4.5 - (y /100);
    if(label >= 0) {
      context.fillText(label.toString(), 0, y);
    }
  }
  context.strokeStyle = "#eee";
  context.stroke();
}

function draw_path(path, context, canvas) {
  var canvas = document.getElementById("canvas_a");
  var context = canvas.getContext("2d");

  for (var i = 0; i < path.length; i++){
    var x = path[i][0] * MULT + X_OFFSET;
    var y = path[i][1] * MULT * -1 + Y_OFFSET;
    context.beginPath();
    context.arc(x, y, 3, 0, 2 * Math.PI, false);
    context.fillStyle = 'black';
    context.fill();
    context.lineWidth = 5;
    context.strokeStyle = '#000000';
    context.stroke();

    context.font = "bold 12px sans-serif";
    var label = path[i][0] + "," + path[i][1];
    context.fillText(label, x - 10, y + 20);
  }
}

function draw_path_segment(co_1,co_2){
  var canvas = document.getElementById("canvas_a");
  var context = canvas.getContext("2d");

  var x_1 = co_1[0] * MULT + X_OFFSET;
  var y_1 = co_1[1] * MULT * -1 + Y_OFFSET;
  var x_2 = co_2[0] * MULT + X_OFFSET;
  var y_2 = co_2[1] * MULT * -1 + Y_OFFSET;

  context.moveTo(x_1,y_1);
  context.lineTo(x_2,y_2);
  context.strokeStyle = "#333";
  context.stroke();
}

function clear_path_segments(path){
  var canvas = document.getElementById("canvas_a");
  var context = canvas.getContext("2d");

  draw_grid(context);
  draw_path(path, context, canvas);
}