//Drawing-machine #11///Alejandro González///60rpm.tv///Dominio Púbico///
/////////////////////////////////////////////////////////////////////////
//A drawing machine + semi-estochastic motion && not based in noise//////
/////////////////////////////////////////////////////////////////////////
//Just allow certain angles to the random movement of particles//////////
/////////////////////////////////////////////////////////////////////////
 
int
N=60,                       //initial number of particles in each bunch
CR=360,                      //range of allowed angles and colors
iso=60;                      //angles allowed will be multiples of this;                      
float
ONE_D=TWO_PI/CR;             //one degree     
float[]
sins,cosins;                 //sins and cosins of allowed angles
color
BG_COL=#222222;
boolean
zzz;                         //sleeping boolean

int time = 0;
 
ArrayList<Bunch> bunches;   //list of bunches of pencils
 
 
void setup(){
  //general settings
  size(1000,500);
  smooth();
  cursor(CROSS);
  colorMode(HSB,CR);
  noStroke();
  background(BG_COL);
  noiseDetail(1);
  sins   = new float[CR];     
  cosins = new float[CR];
  bunches= new ArrayList<Bunch>();
  for(int i=0;i<CR;i++){
    sins[i]  =sin(i*ONE_D);
    cosins[i]=cos(i*ONE_D);
  } 
}
 
void draw(){
  if(!zzz){
    if(time > 5){
    fill(0,0,0,5);
    rect(0,0,width,height);
    time = 0;}
    time++;
    for (int i=0;i<bunches.size();i++){
      Bunch currentBunch=bunches.get(i);
      if(currentBunch.isFullofJoy()){ 
        currentBunch.update();
        currentBunch.display();
      }else{
        bunches.remove(currentBunch);
      }
    }
  }
}
 
void mousePressed(){
    bunches.add(new Bunch(mouseX,mouseY,N));
}
 
void keyPressed(){
  int    kn=key-48;
  if     (key=='s') setup();
  else if(key=='z') zzz=!zzz;
  else if(kn>=1 && kn<=6) iso=kn*15;
} 