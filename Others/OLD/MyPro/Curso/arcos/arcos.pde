float arc = 0;


void setup() {
  size(600, 600);
  strokeWeight(5);
  stroke(255);
  noFill();
  colorMode(HSB,100);
}
 
void draw() {
  background(0);
  for(int i = 1; i<20; i++){
    stroke(i*5,100,100);
    arc(width/2, height/2,i*30, i*30,PI, 2*PI*(1+sin(arc+i*0.1)));
  }
  
  //arc(width/2, height/2,100,100,0,PI);
  arc += 0.01;
  
}
