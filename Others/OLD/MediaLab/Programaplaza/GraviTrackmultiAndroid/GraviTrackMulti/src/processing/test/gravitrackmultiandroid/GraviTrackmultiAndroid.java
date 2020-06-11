package processing.test.gravitrackmultiandroid;

import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import android.view.MotionEvent; 
import android.content.Context; 
import android.content.Intent; 
import android.content.IntentFilter; 
import java.util.ArrayList; 
import java.io.IOException; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.lang.reflect.Method; 

import android.view.MotionEvent; 
import android.view.KeyEvent; 
import android.graphics.Bitmap; 
import java.io.*; 
import java.util.*; 

public class GraviTrackmultiAndroid extends PApplet {

// Eric Pavey - AkEric.com - 2010-12-29
// Example showing simple multi-touch detection in 'Processing - Android'.
// My Samsung Captivate (Galaxy S) can track 5 touch-points.
// Updated to work with Processing's surfaceTouchEvent instead of
// Android's dispatchTouchEvent.

// Should point out that API Level 9 has MotionEvent.PointerCoords class that
// expose some cool functionality, but I'm only on Level 7.











int numPuntos = 0;
int[][] touch = new int[15][2]; 

Stars estrellas; 
Star  est;
ArrayList<PVector> planetas;


public void setup(){
 
  orientation(PORTRAIT); 
  background(0); 
  frameRate(25);
  strokeWeight(1);
  estrellas = new Stars(50); // numeros de estrellas
  planetas = new ArrayList<PVector>();
}

public void draw(){
  //background(0,20);
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  planetas = planetTrack();
  //println(planetas);
  estrellas.update();
}

class Star{
  PVector pos, vel, ac;
  int r;
  int c;
  int posN;
  
  Star(int n){
    pos = new PVector(random(5, width-5), random(5, height-5));
    colorMode(HSB,100,100,100);
    c = color(random(100), random(30,50), random(90,100));
    colorMode(RGB,255,255,255);
    r = 3;
    vel = new PVector(random(-2, 2), random(-2, 2));
    ac = new PVector(0,0,0);
    posN = n;
  }
  
  public void dibujame(){
    stroke(c,100);
    fill(c,100);
    ellipse((int) pos.x,(int) pos.y,r,r);
  }
  public void update(){
    /*if(mouseX > width || mouseX < 0 || mouseY > height || mouseY < 0){
      ac.set(0,0,0);}
      else{
        float d = dist(pos.x, pos.y, mouseX, mouseY);
        float g = 0.1;
        ac.set(g*(-pos.x+mouseX)/d,g*(-pos.y+mouseY)/d,0); }*/
    vel.add(ac);
    vel.limit(2);
    
    pos.add(vel);
    
    if ((pos.x > width-r) || (pos.x < r)) {
      vel.x *= -1;
    }
    if ((pos.y > height-r) || (pos.y < r)) {
      vel.y *= -1;
    }
    
  }
  
}

class Stars{
  int nT;
  ArrayList<Star> stars; 
  
  Stars(int N){
    stars = new ArrayList<Star>();
    for(int i = 0; i < N; i++){
      stars.add(new Star(i));
    }
    
    nT = stars.size();
  }
  
  public void update(){
     for(Star s : stars){
       //s.ace =
       PVector ace = new PVector(0,0,0); 
       for(PVector p : planetas){
         float d = dist(s.pos.x, s.pos.y, p.x, p.y);
         float g = 0.1f;
         ace.add(g*(-s.pos.x+p.x)/d,g*(-s.pos.y+p.y)/d,0);
       }
       s.ac = ace.get(); 
       s.update();
       s.dibujame();
     } 
  }
  
  
  
}

public ArrayList<PVector> planetTrack(){
 
 
 ArrayList<PVector> puntos;
 
 puntos = new ArrayList<PVector>();
 for(int i=0; i<numPuntos; i++){
   puntos.add(new PVector(touch[i][0],touch[i][1],0));
   //fill(255);
   //ellipse(60*i+30,60*i+30,1,1);
 }
 //puntos.add(new PVector(mouseX,mouseY,0));
 return puntos;
}

//-----------------------------------------------------------------------------------------
// Override Processing's surfaceTouchEvent, which will intercept all
// screen touch events.  This code only runs when the screen is touched.

public boolean surfaceTouchEvent(MotionEvent me) {
  // Number of places on the screen being touched:
  numPuntos = me.getPointerCount();
  for(int i=0; i < numPuntos; i++) {
    //int pointerId = me.getPointerId(i);
    touch[i][0] = (int) me.getX(i);
    touch[i][1] = (int) me.getY(i);
    //float siz = me.getSize(i);
    //infoCircle(x, y, siz, pointerId);
  }
  // If you want the variables for motionX/motionY, mouseX/mouseY etc.
  // to work properly, you'll need to call super.surfaceTouchEvent().
  return super.surfaceTouchEvent(me);
}


  public int sketchWidth() { return displayWidth; }
  public int sketchHeight() { return displayHeight; }
  public String sketchRenderer() { return A2D; }
}
