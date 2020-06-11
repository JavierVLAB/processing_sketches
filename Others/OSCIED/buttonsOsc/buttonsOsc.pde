import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Button play;
Button pause;
Button stop;

void setup() {
  size(500, 200);

  oscP5 = new OscP5(this, 5005);
  myRemoteLocation = new NetAddress("127.0.0.1", 5001);

  play = new Button(100, 100, 50, 50, "PLAY");
  pause = new Button(100, 100, 200, 50, "PAUSE");
  stop = new Button(100, 100, 350, 50, "STOP");
}

void draw() {
  play.update();
  pause.update();
  stop.update();
}

void mousePressed() {
  if (play.active) {
    sendMessage(play.name);
  }
  if (pause.active) {
    sendMessage(pause.name);
  }
  if (stop.active) {
    sendMessage(stop.name);
  }
}

void sendMessage(String message) {
  OscMessage oscMessage = new OscMessage("/Laser");
  oscMessage.add(message);
  oscP5.send(oscMessage, myRemoteLocation);
}

void oscEvent(OscMessage theOscMessage) {

  println(theOscMessage.get(0));
}

void keyPressed() {
  //Detect space key presses (to show that it works)    
  if (key == 'G') {
    println("1Space!");
  }

  if (key == 'P') {
    println("2Space!");
  }

  if (key == 'S') {
    println("3Space!");
  }
}