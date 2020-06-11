float x, y, px, py;
float t=0;

void setup() {
  size(600, 600);
  x = 0; 
  y= 0;
  px = 0;
  py = 0;
  background(255);
}






void draw() {
  translate(width/2, height/2);

  x += (noise(1, t)-0.5)*15;
  y += (noise(5, t)-0.5)*15;

  t += 0.5;

  line(px, py, x, y);
  px=x;
  py=y;

}
