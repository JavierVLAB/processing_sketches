import processing.opengl.*; 
import SimpleOpenNI.*;
import codeanticode.gsvideo.*;

GSMovieMaker myMovie;
int fps = 15;

SimpleOpenNI camKinect;

PImage imgKinect;
boolean showKinect = false;
int timer = 0;

boolean grabar = true;
ArrayList<Vehicle> cars;
Vehicle[] carros;
int times = 2;
float dt = 0.00001;
int Nt = 100;
Vehicle carro;
PImage chispas;
PImage imgKbig;

PImage myImg;

void setup(){
  size(640,480,OPENGL);
  //size(displayWidth,displayHeight,OPENGL);
  frameRate(fps);
  hint(DISABLE_DEPTH_TEST);
  smooth(8);
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
  
  if(grabar)
    initMovie();
  
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

  if(cars.size() < 1500){
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
  if(grabar && (times >= 100)){makeMovie();}
  //imgKinect = new PImage();
}

boolean sketchFullScreen() {
  return false;
}

void initMovie(){
  myMovie = new GSMovieMaker(this, width, height, "drawing.ogg", GSMovieMaker.THEORA, GSMovieMaker.BEST, fps);
  myMovie.setQueueSize(500, 100);
  myMovie.start();
}

void makeMovie(){
  myImg = get();
  //myImg.resize(mWidth,mHeight);
  myMovie.addFrame(myImg.pixels);
}

void keyPressed(){
  if(key == 'k'){
    showKinect = !showKinect;
  }
  if(key == ' '){
  
  if(grabar == true){
    myMovie.finish();}
    exit();}
}


