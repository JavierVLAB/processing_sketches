float xc1 = 200;
float yc1 = 0;
float xc2 = 350;
float yc2 = 0;
float r1 = 50;
float r2 = 50;
float R1 = 330;
float R2 = 250;
float t = 0;
float dt = 0.1;
float w1 = 1;
float w2 = 2;
float xnewp = 0;
float ynewp = 0;

void setup() {
  size(800, 800);
  noFill();
  stroke(0,2);
  background(255);
}

void draw() {
  //background(255);
  translate(width/2,height/2);
  rotate(t*0.0001);
  translate(-200,-200);
  beginShape();
  for(int i = 0; i < 150; i++){
    PVector p = render();
    curveVertex(p.x,p.y);
  }
  endShape();
  
  
}


PVector render() {
  float x1 = xc1 + r1*cos(t*w1);
  float y1 = yc1 + r1*sin(t*w1);
  float x2 = xc2 + r2*cos(t*w2);
  float y2 = yc2 + r2*sin(t*w2);
  /*stroke(0,255);
   ellipse(xc1, yc1, r1*2, r1*2);
   ellipse(xc2, yc2, r2*2, r2*2);
   line(xc1,yc1,x1,y1);
   line(xc2,yc2,x2,y2);
   ellipse(x1, y1, R1*2, R1*2);
   ellipse(x2, y2, R2*2, R2*2);
   */
  t += dt;

  // (x - x1)^2 + (y - y1)2 = r1^2
  // (x - x2)^2 + (y - y2)2 = r2^2
  // Se restas las ecuaciones y se despeja X = > x = P + Qy

  float P = (R1*R1 - R2*R2) + (x2*x2 - x1*x1) + (y2*y2 - y1*y1);
  P /= 2*(x2-x1);

  float Q = (y1 - y2)/(x2 - x1);

  float A = Q*Q + 1;
  float B = 2*(P*Q - Q*x1 -y1);
  float C = (P*P - 2*x1*P + x1*x1 + y1*y1 - R1*R1);

  float ynew = - B + sqrt(B*B - 4*A*C);
  ynew /= 2*A;

  float xnew = P + Q*ynew;

  //line(x1,y1,xnew,ynew);
  //line(x2,y2,xnew,ynew);



  //translate(width/2, width/2);
  //rotate(0.01);
  //ellipse(xnew-width/2,ynew-width/2,5,5);
  //stroke(0, 10);
  //line(xnewp-width/2, ynewp-width/2, xnew-width/2, ynew-width/2);
  
  return new PVector(xnew,ynew);
  
}
