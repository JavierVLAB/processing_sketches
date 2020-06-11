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

public class PruebaPerlin3 extends PApplet {

 


// declare SimpleOpenNI object
SimpleOpenNI context;

PImage cam;

ArrayList<Vehicle> cars;
Vehicle[] carros;
float times = 2;
float dt = 0.00001f;
int Nt = 100;
Vehicle carro;

public void setup(){
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
    Vehicle c = new Vehicle(new PVector(random(width), random(height)),5,random(1,5)*0.0001f);
    cars.add(c);
  }

  /*carros = new Vehicle[Nt];
  for(int i=0; i<Nt; i++){
    carros[i] = new Vehicle(new PVector(random(width), random(height)),5,random(1,5)*0.0001);
  }*/
  
}

public void draw(){
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
      Vehicle q = new Vehicle(new PVector(random(width), random(height)),5,random(1,5)*0.0001f);
      cars.add(q);}
  }

  //println(cars.size());
  for(Vehicle c: cars){
    c.run();
  }

  times++;
  
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
  int me;

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
    timeLife = (long) (random(5,10)*frameRate);
    int me = color(0,0,0);
    inPast = inNow = false;
  }

  public void run() {
    update();
    borders();

    display();

    
  }

  public void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  public void update() {
    
    ifDead();

    id += 0.0001f;
    locationpast = location.get();
    noiseFloat = noise(location.x * idsteep, location.y * idsteep, id);
    acceleration.x = cos(((noiseFloat - 0.3f) * TWO_PI) * 10);
    acceleration.y = sin(((noiseFloat - 0.3f) * TWO_PI) * 10);
    

    velocity.add(acceleration);
    choque();
    velocity.limit(maxspeed);
    location.add(velocity);
    inPast = inNow;
    //acceleration.mult(0);
  }

  public void display(){

    strokeWeight(0.8f);
    if(!inNow){
      stroke(me,255);}
      else{
        stroke(color(255,0,0),100);
      }
    PVector vec = PVector.sub(location,locationpast);

    if(!(vec.mag() > 20))
      line(location.x,location.y,locationpast.x,locationpast.y);
  }
  
  
  // Wraparound
  public void borders() {
    //Periodic borders
    if (location.x < 4) location.x = width;
    if (location.y < 4) location.y = height;
    if (location.x > width-4) location.x = 0;
    if (location.y > height-4) location.y = 0;/*
    //Solid Borders
    if ((location.x < r) || (location.x > width-r)) velocity.x *= -1;
    if ((location.y < r) || (location.y > height-r)) velocity.y = -1;*/
    
  
  }

  public void choque(){
    int loc = (int) ((int)location.x+(int)location.y*640);
    if(loc > 640*480){println(loc);}
    int c = cam.pixels[loc];
    
    if(c != 0xff000000){
      
      inNow = true;

      if(inPast != inNow){
        velocity.mult(-1);
      }
    }
  }

  public void choque2(){
    PVector vec = PVector.sub(location, new PVector(mouseX,mouseY));
    if (vec.mag() < 50){
      velocity.mult(-1);
    }
  }

  public void ifDead(){
    if(life > timeLife){
      location = new PVector(random(width),random(height));
      life = 0;
      id = random(1,5)*0.0001f;
    }
    life++;
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "PruebaPerlin3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
