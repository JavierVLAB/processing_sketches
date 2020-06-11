
//Bunch class//A really simple class for packing all particles together//
/////////////////////////////////////////////////////////////////////////
//Don know what to comment here... really as-it-is///////////////////////
/////////////////////////////////////////////////////////////////////////
 
 
class Bunch {
   
  ArrayList<Pencil> pencils;   //bunch of pencils
   
  //Contructor
  Bunch (int n,int minRad,int maxRad,int refHue,int x,int y,int z){
    pencils= new ArrayList<Pencil>();
    for(int i=0;i<n;i++){
      pencils.add(new Pencil(new PVector(x,y,z),refHue,minRad,maxRad));
    }
  }
   
  void update(){
    for (Pencil cur:pencils){
      cur.update(pencils); 
    }
  }
   
  void display(){
    for (Pencil cut:pencils){
      cut.display();
    }
  }
   
}    