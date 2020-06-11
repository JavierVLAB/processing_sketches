int num_bolas = 50;
int intentos = 30, bolas = 5, loterias = 10000;
int[]  lotery = new int[bolas], acierto = {0,0,0,0,0,0,0,0,0,0,0};
int[][] tickets = new int[intentos][bolas];
int[]   intermedio = new int[intentos*bolas];
float[] probs = new float[bolas+1]; 

void setup(){
  int abc;
  crear_tickets2();
  
  for(int lot = 0; lot < loterias; lot++){
  
    crear_lotery();
    abc = aciertos2();
    
    
  }
  
  for(int i = 0; i < bolas+1; i++)
  probs[i] = (float) acierto[i]/(intentos*loterias);
  
  
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

void crear_tickets2(){
  boolean probe;
  int count = 0;
  for (int i = 0; i < num_bolas; i++){
    intermedio[i] = (int) random(num_bolas) + 1;
    
    //probe = igualdadpropia(0,i);
    //if (probe == true){i--;}
    //count++;
  }
  
  for (int i = 0; i < bolas; i++){
   for(int  j=0; j < intentos; j++){
   tickets[j][i] = intermedio[i+j*bolas];  
   }
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

int aciertos2(){
 
  int count = 0;
  
  for(int k = 0; k < intentos; k++){
  for(int i = 0; i < bolas; i++){
    for(int j = 0; j < bolas; j++){
     if(tickets[k][i] == lotery[j]){count++;}   
    }
  }
  acierto[count] = acierto[count] + 1;
  count = 0;
  }
  
  return count;
}
