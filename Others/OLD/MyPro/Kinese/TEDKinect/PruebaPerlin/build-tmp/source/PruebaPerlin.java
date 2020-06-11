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

public class PruebaPerlin extends PApplet {

int Nt = 50;
PerlinParticle[] particulas;

public void setup(){
	size(600,600,OPENGL);
	hint(DISABLE_DEPTH_TEST);
	
	particulas = new PerlinParticle[Nt];

	for(int i = 0; i < Nt; i++){
		particulas[i] = new PerlinParticle(width/2, i*10+10,i/10000.0f);
	}

}

public void draw(){
	background(0,1);

	for(int i = 0; i < Nt; i++){
		particulas[i].update();
		particulas[i].display();
	}
	//delay(1000);

}

class PerlinParticle{
	int x,y;
	float id;
	float speed;
	float step; 

	PerlinParticle(int x_, int y_, float id_){
		x = x_;
		y = y_;
		id = id_;
		speed = random(2.0f,6.0f);

	}

	public void update(){
		id += 0.0001f;
		step = noise(id)*360;
		y += (int) (sin(radians(step))*speed);
		x += (int) (cos(radians(step))*speed);

	}

	public void display(){
		fill(255);
		ellipse(x,y,5,5);
	}

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "PruebaPerlin" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
