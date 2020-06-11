package processing.test.recibeserialosc;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 
import netP5.*; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class RecibeSerialOSC extends PApplet {



 

OscP5 oscP5;
NetAddress myRemoteLocation;

Serial myPort;

int distancia = 0;

public void setup() {
  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
  oscP5 = new OscP5(this,12000);
  
  myRemoteLocation = new NetAddress("192.168.1.80",12000);
  
  
  
}

public void draw() {

  if ( myPort.available() > 0) {  // If data is available,
     distancia = myPort.read();         // read it and store it in val
  }
  
  OscMessage myMessage = new OscMessage("/enciende");
  
  myMessage.add(210); // punto X 
  myMessage.add(232); // punto Y
  myMessage.add(distancia); // tama\u00f1o 
  myMessage.add((int) color(255,0,0)); // color entero
  
  oscP5.send(myMessage, myRemoteLocation); 
}
  



}
