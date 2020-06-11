import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import processing.opengl.*; 
import SimpleOpenNI.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class PruebaPerlin51 extends PApplet {

 


SimpleOpenNI camKinect;

PImage imgKinect;
boolean showKinect = false;

ArrayList<Vehicle> cars;
Vehicle[] carros;
int times = 2;
float dt = 0.00001f;
int Nt = 100;
Vehicle carro;
PImage chispas;

public void setup(){
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
    Vehicle c = new Vehicle(new PVector(random(width), random(height)),10,random(1,5)*0.0001f);
    cars.add(c);
  }
  
}

public void draw(){

  
  camKinect.update();
  imgKinect = camKinect.sceneImage().get();
  int w = imgKinect.width/2, h = imgKinect.height/2;
  //imgKinect.resize(w,h);
  
  imgKinect.loadPixels();

  fill(0,100);
  noStroke();
  rect(0, 0, width, height);

  if(cars.size() < 10000){
    for(int i= 0; i<100; i++){
      Vehicle q = new Vehicle(new PVector(random(width), random(height)),5,random(1,5)*0.0001f);
      cars.add(q);}
  }


  //println(cars.size());
  for(Vehicle c: cars){
    c.run();
  }

  times++;
  //println(frameRate);

  if(!showKinect){
    image(imgKinect, 0, 0, 320, 240);
  }
}

public boolean sketchFullScreen() {
  return false;
}

public void keyPressed(){
  if(key == 'k'){
    showKinect = !showKinect;
  }
}


class Vehicle {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float noiseFloat;
  PVector locationpast;
  float id;
  float idsteep;
  long life;
  long timeLife;
  boolean inPast;
  boolean inNow;
  boolean drawMe;
  int me;
  boolean nextColor;

  Vehicle(PVector l, float ms, float mf) {
    location = l.get();
    locationpast = l.get();
    r = 3.0f;
    maxspeed = ms;
    id = mf; idsteep = mf;
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-10,10),random(-10,10));
    velocity.limit(maxspeed);
    life = 0;
    timeLife = (long) (random(5,9)*frameRate);
    inNow = inPast = false;
    drawMe = true;
    nextColor = false;
    me = color(255,255,255);
  }

  public void run() {
    update();
    borders();

    display();
  }

  public void update() {
    
    ifDead();

    id += 0.0001f;
    locationpast = location.get();
    noiseFloat = noise(location.x * idsteep + times/1000, location.y * idsteep, id);
    acceleration.x = cos(((noiseFloat - 0.3f) * TWO_PI) * 10);
    acceleration.y = sin(((noiseFloat - 0.3f) * TWO_PI) * 10);
    
    if(inNow)
    acceleration.mult(-1);  
    velocity.add(acceleration);
    choque();
    velocity.limit(maxspeed);
    location.add(velocity);
    //acceleration.mult(0);
  }

  public void display(){
    
    if(inNow){

      if(random(1) < 0.5f){
        tint(me,255);
        image(chispas,location.x,location.y);
        noTint();}
    }
    else{
      strokeWeight(0.8f);
      stroke(me,255);
      PVector vec = PVector.sub(location,locationpast);
      if(!(vec.mag() > 20))//esto es para que no trace lineas desde un borde al otro
        line(location.x,location.y,locationpast.x,locationpast.y);
    }
  }
  
  public void display2(){
    strokeWeight(0.8f);
    if(inNow){
      stroke(0,255);}
    else{stroke(255,255);}
      PVector vec = PVector.sub(location,locationpast);
      if(!(vec.mag() > 20))
      line(location.x,location.y,locationpast.x,locationpast.y);
  }
  
  // Wraparound
  public void borders() {
    //Periodic borders
    if (location.x < 0) location.x = width;
    if (location.y < 0) location.y = height;
    if (location.x > width) location.x = 0;
    if (location.y > height) location.y = 0;/*
    //Solid Borders
    if ((location.x < r) || (location.x > width-r)) velocity.x *= -1;
    if ((location.y < r) || (location.y > height-r)) velocity.y = -1;*/
    
  
  }
  public void choque(){
    
    if (isInside()){
      velocity.mult(-1);
      inNow = true;
    }else{
      inNow = false;
    }
  }

  public boolean isInside(){//dentro de los usuarios en la camara
    int loc = (int) ((int)map(location.x,0,width,0,imgKinect.width-1)+(int)map(location.y,0,height,0,imgKinect.height-1)*imgKinect.width);
    if(loc > 640*480){println(location.y + " " + (int) location.y + " " + (int) 0.01f);}//
    int c = imgKinect.pixels[loc];
    
    if(c != 0xff000000){//si no es negro es porque esta dentro de un usuario
      inNow = true;
      if(!nextColor){ // si no ha estado en otro usuario no cambia
        me = c;
        nextColor = true;}
      return true;}
    else{
      inNow = false;
      //me = color(255,255,255);
      return false;
    }
  }

  public boolean isInside1(){// dentro de un circulo de radio 100
    PVector vec = PVector.sub(location, new PVector(mouseX,mouseY));
    if (vec.mag() < 50){
      return true;
    } else{
      return false;
    }
  }

  public void ifDead(){
    if(life > timeLife){
      location = new PVector(random(width),random(height));
      life = 0;
      id = random(1,5)*0.0001f;
      drawMe = true;
      nextColor = false;
      me = color(255,255,255);
    }
    life++;
  }


}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "PruebaPerlin51" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
