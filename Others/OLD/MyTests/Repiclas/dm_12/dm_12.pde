//Drawing-machine #12///Alejandro González///60rpm.tv///Dominio Púbico//////////
////////////////////////////////////////////////////////////////////////////////
//platonic particles moving as shadows of a true world,/////////////////////////
//revolving seeking the light of truth && finding the flames of death instead///
////////////////////////////////////////////////////////////////////////////////
 
int
CM_R=360,      //colorMode Range
C_R=30,        //color range
N=10;          //number of particles
boolean
zzz=false;     //sleeping boolean to toggle the loop
 
Bunch bunch;   //the group of pencils
 
void setup(){
  size(600,600);
  //fill(0);
  //rect(0,0,width,height);
  colorMode(HSB,CM_R);
  background(#eeeeee);
  smooth();
  noStroke();
  bunch = new Bunch(N,50,300,int(random(CM_R-C_R)),width/2,height/2,0);
}
 
void draw (){
  
  //fill(0,2);
  //rect(0,0,width,height);
  
  if (!zzz){
    bunch.update();
    bunch.display();
  }
}
 
void keyPressed(){
  if      (key=='s') setup();
  else if (key=='z') zzz=!zzz;
}

