import processing.opengl.*; 
import SimpleOpenNI.*;

SimpleOpenNI camKinect;

PImage imgKinect;

ArrayList<Vehicle> cars;
Vehicle[] carros;
float times = 2;
float dt = 0.00001;
int Nt = 100;
Vehicle carro;
PImage chispas;

void setup(){
  //size(640,480);
  size(displayWidth,displayHeight);
  //frameRate(1);
  hint(DISABLE_DEPTH_TEST);
  randomSeed(1);

  chispas = loadImage("sprite.png");
  chispas.resize(chispas.width/3, chispas.height/3);

  camKinect = new SimpleOpenNI(this);
  if (!camKinect.enableScene()) {
    exit();
  } else {
    camKinect.setMirror(true);
  }

  cars = new ArrayList<Vehicle>();

  for(int i=0; i<Nt; i++){
    Vehicle c = new Vehicle(new PVector(random(width), random(height)),10,random(1,5)*0.0001);
    cars.add(c);
  }
  
}

void draw(){

  camKinect.update();
  imgKinect = camKinect.sceneImage().get();
  imgKinect.loadPixels();

  fill(0,100);
  noStroke();
  rect(0, 0, width, height);

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

boolean sketchFullScreen() {
  return false;
}


