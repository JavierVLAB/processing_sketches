import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

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

public class sketch_121121b extends PApplet {

int elapsedFrames = 0;
ArrayList points = new ArrayList();
 
public void setup(){
  smooth();
  size(600,600);
  background(255);
}
 
public void draw(){
  for(int i = 0; i < points.size(); i++){
     Point localPoint = (Point) points.get(i);
      
     if(localPoint.isDead == true){
       points.remove(i);
     }
      
     localPoint.update();
     localPoint.draw();
  }
   
  elapsedFrames++;
}
 
 
public void keyPressed(){
  if(key == ' '){
    for(int i = 0; i < points.size(); i++){
       Point localPoint = (Point) points.get(i);
       localPoint.isDead = true;
    }
    noStroke();
    fill(255);
    rect(0, 0, width, height);
  }
  if(key == 'r'){
    for(int i = 0; i < 5000; i++){
      PVector pos = new PVector(random(width), random(height));
      PVector vel = new PVector(0, 0);
      Point punt = new Point(pos, vel, 250+random(250));
      points.add(punt);
    }
  }
}
 
 
class Point{
   
  PVector pos, vel, noiseVec;
  float noiseFloat, lifeTime, age;
  boolean isDead;
   
  public Point(PVector _pos, PVector _vel, float _lifeTime){
    pos = _pos;
    vel = _vel;
    lifeTime = _lifeTime;
    age = 0;
    isDead = false;
    noiseVec = new PVector();
  }
   
  public void update(){
    noiseFloat = noise(pos.x * 0.0025f, pos.y * 0.0025f);
    noiseVec.x = cos(((noiseFloat -0.3f) * TWO_PI) * 5);
    noiseVec.y = sin(((noiseFloat - 0.3f) * TWO_PI) * 5);
     
    vel.add(noiseVec);
    vel.div(3);
    pos.add(vel);
     
    if(1.0f-(age/lifeTime) == 0){
     isDead = true;
    }
     
    if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height){
     isDead = true;
    }
     
    age++;   
  }
   
  public void draw(){   
    fill(vel.x * 255, vel.y * 255, pos.x * 100 ,20);
    noStroke();
    ellipse(pos.x, pos.y, 1-(age/lifeTime), 1-(age/lifeTime));
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "sketch_121121b" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
