var sides = 4; // number of polygon sides
var x = [];
var y = [];
var variance = 25; // strength of polygon variation
var iterations = 10; // amount of times program runs
var radius = 150; // initial radius

var angle = 2 * 3.1415 / sides;

let pg;

function setup() {
	createCanvas(600, 600);
	//frameRate(1);
	pg = createGraphics(600,600);
}



function draw() {
	background(255,255,255);
	pg.background(255,255,255);
	for (var i=0; i < sides; i++) { // coordinates of polygon
	  x[i] = cos(angle*i+50) * radius;
	  y[i] = sin(angle*i+50) * radius;
	}
	pg.noFill();
	for (var a=0; a < iterations; a++) { // array of polygon coordinates
	  for (var i=0; i < sides; i++) {
		x[i] += random(-variance, variance);
		y[i] += random(-variance, variance);
	  }
	  pg.beginShape(); // draw polygon shape
	  pg.curveVertex(x[sides-1]+width/2, y[sides-1]+height/2);
	  for (var i=0; i < sides; i++) {
		pg.curveVertex(x[i]+width/2, y[i]+height/2);
	  }
	  pg.curveVertex(x[0]+width/2, y[0]+height/2);
	  pg.curveVertex(x[1]+width/2, y[1]+height/2);
	  pg.endShape();
	}
	image(pg,0,0);
	save(); // give file name
	//print("saved svg");

	noLoop();
}

function keyPressed(){
	loop();
}
