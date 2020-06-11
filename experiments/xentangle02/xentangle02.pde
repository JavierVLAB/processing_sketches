PShape s;

void setup(){
  size(600,600,P2D); 
  background(255);
}

void draw(){
  
  if(mousePressed){
    translate(mouseX,mouseY);
    draw_my_rec();
  }
  if(keyPressed){

    draw_2();
    //draw_mark();
    shape(s);
  }
  
}

void draw_my_rec(){
   
   int n = 10;
   int L = 200;
   noStroke();
   fill(0,30);
   ellipse(0,0,(n+1)*L/n,(n+1)*L/n);
   fill(255);
   stroke(0);
   for(int  i = n; i > 0; i--){
     ellipse(0,0,i*L/n,i*L/n);
   }
   fill(0);
   ellipse(0,0,40,40);
   
}


void draw_2(){
  fill(255);
  //noFill();
 s = createShape();
  s.beginShape();
  //s.noStroke();

  // Exterior part of shape
  s.vertex(0,0);
  s.vertex(width,0);
  s.vertex(width,height);
  s.vertex(0,height);

  // Interior part of shape
  int b = 60;
  s.beginContour();
  

  s.curveVertex(4*b,0);
  s.curveVertex(b,b); 
  s.curveVertex(b,height/2-b);
  s.curveVertex(b,height-b);
  s.curveVertex(width/2,height-b);
  s.curveVertex(width-b,height-b);
  s.curveVertex(width-b,height/2);
  s.curveVertex(width-b,b);
  s.curveVertex(width/2,b);
  s.curveVertex(b,b);
  s.curveVertex(0,4*b);

  s.endContour();

  // Finish off shape
  s.endShape(); 
}
