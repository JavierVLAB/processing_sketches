import processing.opengl.*; 
import SimpleOpenNI.*;

SimpleOpenNI camKinect;

PImage imgKinect;
boolean showKinect = false;

ArrayList<Vehicle> cars;
Vehicle[] carros;
int times = 2;
float dt = 0.00001;
int Nt = 100;
Vehicle carro;
PImage chispas;
PImage imgKbig;
int time = 0;

void setup(){
  //size(640,480);
  size(displayWidth,displayHeight,OPENGL);
  frameRate(60);
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
  int w = imgKinect.width/2, h = imgKinect.height/2;
  //imgKinect.resize(w,h);
  //imgKbig = imgKinect.get();
  //imgKbig.resize(width,height);
  tint(255,40);
  image(imgKinect, 0,0,width,height);
  noTint();
  imgKinect.loadPixels();

  fill(0,90);
  noStroke();
  rect(0, 0, width, height);

  if(cars.size() < 5000){
    for(int i= 0; i<100; i++){
      Vehicle q = new Vehicle(new PVector(random(width), random(height)),5,random(1,5)*0.0001);
      cars.add(q);}
  }


  //println(cars.size());
  for(Vehicle c: cars){
    c.run();
  }

  times++;
  println(frameRate);

  if(showKinect){
    image(imgKinect, 0, 0, 320, 240);
  }
  
  //imgKinect = new PImage();
}

boolean sketchFullScreen() {
  return true;
}

void keyPressed(){
  if(key == 'k'){
    showKinect = !showKinect;
  }
}


