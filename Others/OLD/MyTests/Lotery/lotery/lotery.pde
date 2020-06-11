int num_bolas = 50;
int intentos = 1, bolas = 5, loterias = 50000000;
int[]  lotery = new int[bolas], acierto = {0,0,0,0,0,0,0,0,0,0,0};
int[][] tickets = new int[intentos][bolas];
float[] probs = new float[bolas+1]; 

void setup(){
  int abc;
  crear_tickets();
  
  for(int lot = 0; lot < loterias; lot++){
  
    crear_lotery();
    abc = aciertos();
    
    acierto[abc] = acierto[abc] + 1;
  }
  
  for(int i = 0; i < bolas; i++)
  probs[i] = (float) acierto[i]/loterias;
  
  
  println(probs);
}

void crear_tickets(){
  boolean probe;
  int count = 0;
  for (int i = 0; i < bolas; i++){
    tickets[0][i] = (int) random(num_bolas) + 1;
    
    probe = igualdadpropia(0,i);
    if (probe == true){i--;}
    count++;
  }
   
}

void crear_lotery(){
  boolean probe;
  int count = 0;
  for (int i = 0; i < bolas; i++){
    lotery[i] = (int) random(num_bolas) + 1;    
  }

}

boolean igualdadpropia(int bola1, int bola2){
  boolean abc = false;
  
  if (bola2 == 0){
    abc = false; 
  }
  else {
    if (tickets[bola1][bola2] == tickets[bola1][bola2 - 1]){
     abc = true;}
    else { abc = igualdadpropia(bola1, bola2 - 1);} 
  }

  return abc;
}

int aciertos(){
 
  int count = 0;
  for(int i = 0; i < bolas; i++){
    for(int j = 0; j < bolas; j++){
     
     if(tickets[0][i] == lotery[j]){count++;}   
    }
  }
  
  return count;
}
