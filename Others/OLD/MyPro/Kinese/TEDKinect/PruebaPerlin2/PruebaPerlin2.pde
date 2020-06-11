import processing.opengl.*; 

ArrayList<Vehicle> cars;
Vehicle[] carros;
float times = 2;
float dt = 0.00001;
int Nt = 100;
Vehicle carro;

void setup(){
  size(600,600);
  size(displayWidth,displayHeight);
  frameRate(60);
  hint(DISABLE_DEPTH_TEST);
  randomSeed(1);

  cars = new ArrayList<Vehicle>();

  for(int i=0; i<Nt; i++){
    Vehicle c = new Vehicle(new PVector(random(width), random(height)),10,random(1,5)*0.0001);
    cars.add(c);
  }
  
}

void draw(){

  fill(255,100);
  noStroke();
  rect(0, 0, width, height);

  if(cars.size() < 5000){
    for(int i= 0; i<100; i++){
      Vehicle q = new Vehicle(new PVector(random(width), random(height)),5,random(1,5)*0.0001);
      cars.add(q);}
  }

  //println(cars.size());
  for(Vehicle c: cars){
    c.run();
  }

  times++;
  
}
