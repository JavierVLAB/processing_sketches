float arc = 0;

void setup() {
  size(600, 600);
  noStroke();
  fill(0);
  background(255);
  
}

void draw() {
  fill(255,255);
  rect(0,0,width,height);
  //for(int i = 0; i < 1000; i++){
  float Ry = 100*sin(arc) + width/2;
  float Rx = 100*cos(arc) + height/2;
  float ry = 100*sin(PI*arc);
  float rx = 100*cos(PI*arc);
  
  fill(0);
  ellipse(Rx, Ry, 5, 5);
  ellipse(rx + Rx, ry + Ry, 5, 5); 
  ellipse(Rx+ rx + 50*sin(arc*2*PI),Ry+ ry + 50*cos(arc*2*PI),2,2);
  
  arc += 0.01;//}
}

