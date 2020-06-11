Button play;
Button pause;
Button stop;

void setup() {
  size(500, 200);

  play = new Button(100, 100, 50, 50, "PLAY");
  pause = new Button(100, 100, 200, 50, "PAUSE");
  stop = new Button(100, 100, 350, 50, "STOP");
  //rectMode(CENTER);
  
}

void draw() {
  play.update();
  pause.update();
  stop.update();
}

void mousePressed(){
  if(play.active){
    println(play.name);
  }
}