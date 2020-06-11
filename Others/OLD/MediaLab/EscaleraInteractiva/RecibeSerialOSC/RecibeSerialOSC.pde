import ketai.net.*;

import oscP5.*;
import netP5.*;
import processing.serial.*; 

OscP5 oscP5;
NetAddress myRemoteLocation;

Serial myPort;

int distancia = 0;

void setup() {
  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
  oscP5 = new OscP5(this,12000);
  
  myRemoteLocation = new NetAddress("192.168.1.80",12000);
  
  
  
}

void draw() {

  if ( myPort.available() > 0) {  // If data is available,
     distancia = myPort.read();         // read it and store it in val
  }
  
  OscMessage myMessage = new OscMessage("/enciende");
  
  myMessage.add(210); // punto X 
  myMessage.add(232); // punto Y
  myMessage.add(distancia); // tamaño 
  myMessage.add((int) color(255,0,0)); // color entero
  
  oscP5.send(myMessage, myRemoteLocation); 
}
  


