import oscP5.*;
import netP5.*;
import processing.serial.*; 

OscP5 oscP5;
RGBLamp layout;
Serial serial;

float r,g,b;

public synchronized void sendCommand( byte addr, byte[] cmd ) {
    //println("sendCommand: "+(char)cmd[0]);
    byte cmdfull[] = new byte[4+cmd.length];
    cmdfull[0] = 0x01;                    // sync byte
    cmdfull[1] = addr;                    // i2c addr
    cmdfull[2] = (byte)cmd.length;        // this many bytes to send
    cmdfull[3] = 0x00;                    // this many bytes to receive
    for( int i=0; i<cmd.length; i++) {    // and actual command
        cmdfull[4+i] = cmd[i];
    }
    //serial.write(cmdfull);
}
// a common task, fade to an rgb color
public void fadeToColor(byte elblinkmAddr,  int r, int g, int b ) {
    byte[] cmd = {'c', (byte)r, (byte)g, (byte)b};
    sendCommand( elblinkmAddr, cmd );
}


void setup() {
  size(800,600);
  frameRate(20);

  oscP5 = new OscP5(this,8000);
  layout= new RGBLamp();
  //serial = new Serial(this, Serial.list()[0], 9600);
  layout.printAddr();
  r = 0; b = 0; g = 0;
  byte[] cmd = {'o'};
  sendCommand( (byte) 0, cmd );
  
  
}

void draw() {

  background(r,g,b);
  fadeToColor((byte) 0,(int) r,(int) g,(int) b); 
  
  
}

void mousePressed() {
  layout.printData();
}

void oscEvent(OscMessage theOscMessage) {
  layout.check(theOscMessage);
  theOscMessage.print();
  r = layout.Data[0]*255;
  g =  layout.Data[1]*255;
  b =  layout.Data[2]*255;
  
  
}


//Layout RGBLamp custom para touchOsc probado en version 1.2/1.4 y Processing 1.0.9
//Libreria oscP5

class RGBLamp {

  String[] Addr= {
    "/1/fader1",
    "/1/fader2",
    "/1/fader3",
  };

  float[] Data= new float[Addr.length];

  String Typetag="f";

  void check(OscMessage theOscMessage) {

    for (int i = 0; i < Addr.length; i++) {
      if(theOscMessage.checkAddrPattern(Addr[i])==true) {
        if(theOscMessage.checkTypetag(Typetag)) {
          Data[i] = theOscMessage.get(0).floatValue();
          println(Addr[i]+" "+ Data[i]);
        }
      }
    }
  }

  void printData() {
    println(Data);
  }

  void printAddr() {
    println(Addr);
  }
}

