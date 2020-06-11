float a = 0.01;
void setup() {
  size(1000, 600);
  noFill();
  //noiseDetail(3);
}

void draw() {
  stroke(0,50);
  background(255);
  for (int j = 0; j< 300; j++) {
    beginShape();
    for (int i = 0; i< 15; i++) {
      curveVertex(20+60*i, height/2 +300*noise(i, j*a)-300+j*1);
      //curveVertex(20+40*i, height/2 +random(-150,150));
    }
    endShape();
  }
}

void keyPressed() {
  if (key == 'a') {
    a += 0.001;
  }
  if (key == 's') {
    a -=0.001;
  }
  if (key == 'd' || key == ' '){
   noiseSeed(int(random(100))); 
  }
  println(a);
}
