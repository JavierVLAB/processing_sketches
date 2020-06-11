import processing.opengl.*; 

import SimpleOpenNI.*;
// declare SimpleOpenNI object
SimpleOpenNI context;

PImage cam;

ArrayList<Vehicle> cars;
Vehicle[] carros;
float times = 2;
float dt = 0.00001;
int Nt = 100;
Vehicle carro;

void setup(){
  size(640,480);
  //frameRate(60);
  hint(DISABLE_DEPTH_TEST);
  randomSeed(1);

  context = new SimpleOpenNI(this);
  if (!context.enableScene()) {
    println("Kinect not connected!");
    exit();
  } else {
    // mirror the image to be more intuitive
    context.setMirror(true);
  }

  cars = new ArrayList<Vehicle>();

  for(int i=0; i<Nt; i++){
    Vehicle c = new Vehicle(new PVector(random(width), random(height)),5,random(1,5)*0.0001);
    cars.add(c);
  }

  /*carros = new Vehicle[Nt];
  for(int i=0; i<Nt; i++){
    carros[i] = new Vehicle(new PVector(random(width), random(height)),5,random(1,5)*0.0001);
  }*/
  
}

void draw(){
  context.update();
  cam = context.sceneImage().get();
  cam.loadPixels();
  fill(255,60);
  noStroke();
  rect(0, 0, width, height);
  /*for(int i=0; i<Nt; i++){
    carros[i].run();
  }*/

  if(cars.size() < 10000){
    for(int i= 0; i<100; i++){
      Vehicle q = new Vehicle(new PVector(random(width), random(height)),5,random(1,5)*0.0001);
      cars.add(q);}
  }

  //println(cars.size());
  for(Vehicle c: cars){
    c.run();
  }

  times++;
  
}
