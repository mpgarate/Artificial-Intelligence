function draw_grid(context){
  var canvas = document.getElementById("canvas_a");
  var context = canvas.getContext("2d");

  canvas.width = canvas.width;

  for (var x = 0.5; x < 500; x += 50) {
    context.moveTo(x, 0);
    context.lineTo(x, 500);
  }
  for (var y = 0.5; y < 500; y += 50) {
    context.moveTo(0, y);
    context.lineTo(500, y);
  }
  context.strokeStyle = "#eee";
  context.stroke();
}

function draw_path(path, context, canvas) {
  var canvas = document.getElementById("canvas_a");
  var context = canvas.getContext("2d");

  var mult = 100;
  var offset = 50;
  for (var i in path){
    var x = path[i][0] * mult + offset;
    var y = path[i][1] * mult + offset;
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
  console.log(co_2);
  var canvas = document.getElementById("canvas_a");
  var context = canvas.getContext("2d");

  var mult = 100;
  var offset = 50;

  var x_1 = co_1[0] * mult + offset;
  var y_1 = co_1[1] * mult + offset;
  var x_2 = co_2[0] * mult + offset;
  var y_2 = co_2[1] * mult + offset;

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