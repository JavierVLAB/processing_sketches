void setup() {
  size (700, 700, P2D);
  background(255);
  noFill();
  pushMatrix();
  translate(width/2, height/2); 

  PShape s;
  s = createShape();
  s.beginShape();
  s.curveVertex(0, 0);
  s.curveVertex(-14, 0);
  s.curveVertex(0, 30);
  s.curveVertex(14, 0);
  s.curveVertex(0, 0);
  s.rotate(-PI/2);

  s.endShape();


  for (int i = 1; i < 9; i++) {
    int R = i*40;
    //ellipse(0, 0, R*2, R*2);
    int n = i*6*3;//fibonacci(i+6);//
    for (int j = 0; j < n; j+=2) {
      pushMatrix();
      translate(R*cos(ang(j, n)), R*sin(ang(j, n)));
      rotate(ang(j, n)+i);

      shape(s);
      popMatrix();
    }
  }
  popMatrix();
}

float ang(int a, int n) {
  return  a*2*PI/n;
}

int fibonacci(int x) {
  if (x == 0) {
    return 0;
  } else if (x == 1) {
    return 1;
  } else {
    return fibonacci(x-1) + fibonacci(x-2);
  }
}
