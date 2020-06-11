float t = 0;
float deltaT = 0.001;
float A1 = 180, f1 = random(1)/40+2, p1 = 3.1415*0, d1 = 0.0001;
float A2 = 180, f2 = random(1)/40+2, p2 = 3.1415*1/13, d2 = 0.0000215;
float A3 = 180, f3 = random(1)/40+2, p3 = 3.1415*0, d3 = 0.00001;
float A4 = 180, f4 = random(1)/40+2, p4 = 3.1415*0, d4 = 0.00001;
color[] goodcolor = {#3a242b, #3b2426, #352325, #836454, #7d5533, #8b7352, #b1a181, #a4632e, #bb6b33, #b47249, #ca7239, #d29057, #e0b87e, #d9b166, #f5eabe, #fcfadf, #d9d1b0, #fcfadf, #d1d1ca, #a7b1ac, #879a8c, #9186ad, #776a8e};
color myc;
int  mmyx;

void setup(){

  size(740,740);
  background(255);
  smooth();
  //stroke(180);
  //strokeWeight(1);
  //colorMode(HSB,100);
  noStroke();
  mmyx=0;
//println(_alpha2);
}

void draw(){

  mmyx = int(random(goodcolor.length));
  myc = color(goodcolor[mmyx]);
  fill(0,10);
  float Vx, Vy;
  for(int i=0;i<2000;i++){ 
  Vx = A1 * sin(f1 * t + p1) * exp(-d1 * t) + A2 * sin(f2 * t + p2) * exp(-d2 * t);
  Vy = A3 * sin(f3 * t + p3) * exp(-d3 * t) + A4 * sin(f4 * t + p4) * exp(-d4 * t);
  Vx = width/2 + Vx;
  Vy = height/2 + Vy;
  
  ellipse(Vx,Vy,1,1);
  
  t += deltaT;
  }
  mmyx++;
  if(mmyx >= goodcolor.length){mmyx=0;}
}
