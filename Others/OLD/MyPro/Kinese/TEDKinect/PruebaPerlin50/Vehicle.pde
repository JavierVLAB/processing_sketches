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
  color me;

  Vehicle(PVector l, float ms, float mf) {
    location = l.get();
    locationpast = l.get();
    r = 3.0;
    maxspeed = ms;
    id = mf; idsteep = mf;
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-10,10),random(-10,10));
    velocity.limit(maxspeed);
    life = 0;
    timeLife = (long) (random(5,10)*frameRate);
    inNow = inPast = false;
    drawMe = true;
  }

  public void run() {
    update();
    borders();

    display();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  void update() {
    
    ifDead();

    id += 0.0001;
    locationpast = location.get();
    noiseFloat = noise(location.x * idsteep + times/1000, location.y * idsteep, id);
    acceleration.x = cos(((noiseFloat - 0.3) * TWO_PI) * 10);
    acceleration.y = sin(((noiseFloat - 0.3) * TWO_PI) * 10);
    
    if(inNow)
    acceleration.mult(-1);  
    velocity.add(acceleration);
    choque();
    velocity.limit(maxspeed);
    location.add(velocity);
    //acceleration.mult(0);
  }

  void display(){
    
    if(inNow){

      if(random(1) < 0.5){
        tint(me,255);
        image(chispas,location.x,location.y);
        noTint();}
    }
    else{
      strokeWeight(0.8);
      stroke(255,255);
      PVector vec = PVector.sub(location,locationpast);
      if(!(vec.mag() > 20))
        line(location.x,location.y,locationpast.x,locationpast.y);
    }
  }
  
  void display2(){
    strokeWeight(0.8);
    if(inNow){
      stroke(0,255);}
    else{stroke(255,255);}
      PVector vec = PVector.sub(location,locationpast);
      if(!(vec.mag() > 20))
      line(location.x,location.y,locationpast.x,locationpast.y);
  }
  
  // Wraparound
  void borders() {
    //Periodic borders
    if (location.x < 0) location.x = width;
    if (location.y < 0) location.y = height;
    if (location.x > width) location.x = 0;
    if (location.y > height) location.y = 0;/*
    //Solid Borders
    if ((location.x < r) || (location.x > width-r)) velocity.x *= -1;
    if ((location.y < r) || (location.y > height-r)) velocity.y = -1;*/
    
  
  }
  void choque(){
    
    if (isInside()){
      velocity.mult(-1);
      inNow = true;
    }else{
      inNow = false;
    }
  }

  boolean isInside(){//dentro de los usuarios en la camara
    int loc = (int) ((int)map(location.x,0,width,0,imgKinect.width-1)+(int)map(location.y,0,height,0,imgKinect.height-1)*640);
    if(loc > 640*480){println(location.y + " " + (int) location.y + " " + (int) 0.01);}//
    color c = imgKinect.pixels[loc];
    
    if(c != #000000){
      inNow = true;
      me = c;
      return true;}
    else{
      inNow = false;
      me = color(255,255,255);
      return false;
    }
  }

  boolean isInside1(){// dentro de un circulo de radio 100
    PVector vec = PVector.sub(location, new PVector(mouseX,mouseY));
    if (vec.mag() < 50){
      return true;
    } else{
      return false;
    }
  }

  void ifDead(){
    if(life > timeLife){
      location = new PVector(random(width),random(height));
      life = 0;
      id = random(1,5)*0.0001;
      drawMe = true;
    }
    life++;
  }


}

