PS ps;

void setup() {
  size(600, 600);
  smooth();
  strokeWeight(0.8);
  ps = new PS(50);

  background(255);

}

void draw() {
  
  ps.run();
 
} 