float x,y,n;
PImage img;

void setup() {
  img = loadImage("2.jpg");
  size(img.width, img.height);
  background(0);
  noFill();
  imageMode(CENTER);
}

void draw() {

  x = width/2+ noise(n)*20;
  y = height/2 + noise(n+20)*20;
  tint(noise(n+50)*255,noise(n)*255,noise(n+20)*255, 150); 
  image(img, x-10, y-10);

  n += .5;

  if (frameCount>50 && frameCount<75) saveFrame("image-####.gif");
}
