// Daniel Shiffman
// Kinect Point Cloud example
// http://www.shiffman.net
// https://github.com/shiffman/libfreenect/tree/master/wrappers/java/processing

import org.openkinect.*;
import org.openkinect.processing.*;

// Kinect Library object
Kinect kinect;

float a = 0;

// Size of kinect image
int w = 640;
int h = 480;

PFont font;
PGraphics g;
 
int N = 50;
color bg = color(0);
 
ArrayList particles = new ArrayList();



// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];

void setup() {
  size(800,600,P3D);
  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);
  // We don't need the grayscale image in this example
  // so this makes it more efficient
  kinect.processDepthImage(false);

  // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  
   colorMode(HSB, 255);
   
  g = createGraphics(400,400,P3D);
  g.colorMode(HSB, 255);
   
  font = createFont("Osaka", 102, true);
  textFont(font,102);
   
 // createTextPalette();
 // createParticle();
  
}

void draw() {

  background(0);
  fill(255);
  textMode(SCREEN);
  text("Kinect FR: " + (int)kinect.getDepthFPS() + "\nProcessing FR: " + (int)frameRate,10,16);

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();

  // We're just going to calculate and draw every 4th pixel (equivalent of 160x120)
  int skip = 4;

  // Translate and rotate
  translate(width/2,height/2,-50);
  rotateY(a);

  for(int x=0; x<w; x+=skip) {
    for(int y=0; y<h; y+=skip) {
      int offset = x+y*w;

      // Convert kinect data to world xyz coordinate
      int rawDepth = depth[offset];
      PVector v = depthToWorld(x,y,rawDepth);

      stroke(255);
      pushMatrix();
      // Scale up by 200
      float factor = 200;
      translate(v.x*factor,v.y*factor,factor-v.z*factor);
      // Draw a point
      point(0,0);
      popMatrix();
    }
  }

  // Rotate
  a += 0.015f;
}

// These functions come from: http://graphics.stanford.edu/~mdfisher/Kinect.html
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

PVector depthToWorld(int x, int y, int depthValue) {

  final double fx_d = 1.0 / 5.9421434211923247e+02;
  final double fy_d = 1.0 / 5.9104053696870778e+02;
  final double cx_d = 3.3930780975300314e+02;
  final double cy_d = 2.4273913761751615e+02;

  PVector result = new PVector();
  double depth =  depthLookUp[depthValue];//rawDepthToMeters(depthValue);
  result.x = (float)((x - cx_d) * depth * fx_d);
  result.y = (float)((y - cy_d) * depth * fy_d);
  result.z = (float)(depth);
  return result;
}

void createTextPalette(){
  g.beginDraw();
  g.textFont(font,102);
  g.textAlign(CENTER,CENTER);
  g.translate(width/2, height/2);
  g.fill(255);
  //g.text("Hello", 0, 0);
  for(int i=0; i<500; i++){
  g.ellipse(0.2*i*sin(i*0.1),0.2*i*cos(i*0.1),5,5);
  }
  
  g.endDraw();
}
 
void createParticle(){
  loadPixels();
  g.loadPixels();
   
  for(int i=0; i<width*height; i++){
    if(brightness(g.pixels[i]) > 230){
      if(random(100) < N)
      particles.add(new Particle(i%width, int(i/width), random(5)));
    }
  }
   
  updatePixels();
}
 
class Particle{
  float x;
  float y;
  float s;
   
  float nx = random(width*4) - width*1.5;
  float ny = random(height*4) - height*1.5;
   
  color c = color(random(255),255,255);
   
  Particle(float _x, float _y, float _s){
    x = _x;
    y = _y;
    s = _s;
     
    nx += sgn(nx-width/2)*width/2;
    ny +=  sgn(ny-height/2)*height/2;
  }
   
  void update(){
    float dx = random(sgn(x-nx)) + random(3) - 1.5;
    float dy  = random(sgn(y-ny)) + random(3) - 1.5;
     
    nx += dx;
    ny += dy;
  }
   
  void  draw(){
    noStroke();
    fill(c);
    ellipse(nx,ny,s,s);
  }
}
 
int sgn(float n){
  if(n==0) return 0;
  else return int(abs(n)/n);
}

void stop() {
  kinect.quit();
  super.stop();
}

