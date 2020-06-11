void setup() {
  size (500, 500);
  background(255);
  noFill();
  pushMatrix();
  translate(width/2, height/2); 
  for (int i = 0; i < 5; i++) {
    int R = i*40+20;
    ellipse(0, 0, R*2, R*2);
    int n = i*6*4;
    for(int j = 0; j < n; j++){
      int l = 30;
      float a = j*2*PI/n;
      float a2 = (j+1)*2*PI/n;
      float x = R*cos(j*PI/6);
      float y = R*sin(j*PI/6);
      //line(R*cos(a),R*sin(a),(R+l)*cos(a2),(R+l)*sin(a2));
      //line(R*cos(a2),R*sin(a2),(R+l)*cos(a),(R+l)*sin(a));
    }
    for(int j = 0; j < n; j+=2){
      int l = 30;
      float a = j*2*PI/n;
      float a2 = (j+1)*2*PI/n;
      float x = R*cos(j*PI/6);
      float y = R*sin(j*PI/6);
      beginShape();
      curveVertex(R*cos(ang(j,n)),R*sin(ang(j,n)));
      curveVertex(R*cos(ang(j,n)),R*sin(ang(j,n)));
      curveVertex((R+l)*cos(ang(j+1,n)),(R+l)*sin(ang(j+1,n)));
      curveVertex((R)*cos(ang(j+2,n)),(R)*sin(ang(j+2,n)));
      curveVertex((R)*cos(ang(j+2,n)),(R)*sin(ang(j+2,n)));
      endShape();
      ellipse((R+2*l/5)*cos(ang(j+1,n)),(R+2*l/5)*sin(ang(j+1,n)),9,9);
      
      
    }
    
  }
  popMatrix();
}

float ang(int a, int n){
  return  a*2*PI/n;
}
