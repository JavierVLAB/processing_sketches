void render() {
  background(255);
  int R = -40;
  int r1 = 100;
  int r2 = 180;
  pushMatrix();
  translate(width/2, height/2);
  int n = 180;
  
  for (int i = 0; i  <  2*n; i+=2) {
    float t = 0.5;
    float L1, L2;
    float angle = i*PI/n;
    float r = random(t);
    if(i>-n){
      R = 40;
      r1 = 180;
      r2 = 100;
    }
    L1 = r1;
    L2 = r2+random(R);
    line(L1*cos(angle), L1*sin(angle), L2*cos(angle), L2*sin(angle));
  }
  popMatrix();
}
