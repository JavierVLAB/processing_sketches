int num_bolas = 50;
int intentos = 10, bolas = 4, loterias = 50000;
int tickets = 5;
int[]  lotery = new int[bolas], aciertosTotal = new int[bolas];
// int[][] tickets = new int[intentos][bolas];
// float[] probs = new float[bolas+1]; 
Intento[] losIntentos = {};
int[][] Probal = new int[num_bolas][num_bolas];


void setup(){



      for(int i=0; i < num_bolas; i++){
      for(int j=0; j < num_bolas; j++){
        Probal[i][j] = 0; }}

for(int a=0; a < 250; a++){
  for(int b=0; b < 250; b++){
      numeroLoteria();
      for(int i=0; i < bolas; i++){
      for(int j=0; j < bolas; j++){
        if(i != j){
          int a1 = lotery[i]-1;
          int a2 = lotery[j]-1;
          Probal[a1][a2] += 1;
        } }}
        
  }
}

String[] probatext = new String[num_bolas*num_bolas];

for(int i=0; i < num_bolas; i++){
      for(int j=0; j < num_bolas; j++){
        probatext[i+j*num_bolas] = i + " " + j + " " + Probal[i][j] + "\t"; }}

saveStrings("lines.txt", probatext);
  exit(); 
}




class Intento{
  int[][] intent = new int[intentos][bolas];
  int[]   misAciertos = new int[bolas+1];
  
  Intento(){
    
  for (int j = 0; j < intentos; j++){ 
    for (int i = 0; i < bolas; i++){
      intent[j][i] = (int) (random(num_bolas) + 1);
      if(compruebabolas(intent[j][i], this, i, j)) i--;
  }
  }
  }
  
void aciertos(){
  int[] conteo = new int[bolas+1];
  int count;
  
  for(int i = 0; i < bolas; i++) conteo[i] = 0;
  
  for (int j = 0; j < intentos; j++){ 
    count = 0;
    for (int i = 0; i < bolas; i++){
      if(lotery[i] == this.intent[j][i]) count++;
  }
  conteo[count]++;
  }
  
  for(int k=0; k<bolas+1;k++)
  this.misAciertos[k] += conteo[k];
  
} 
}




boolean compruebabolas(int valor, Intento bla, int bol, int jbol){
  boolean comp = false;
  for(int i = 0; i < bol; i++){
    if(bla.intent[jbol][i] == valor) comp = true;
  }
  
  if(!comp){
    int count = 0;
  for(int j = 0; j < jbol; j++){
    for(int i = 0; i < bolas; i++){
    
    if(bla.intent[j][i] == valor) count++;  
  }}
  if(count >= 2) comp = true;
  }
  
  
  
  return comp;
  
}




void numeroLoteria(){
  
  for(int i=0; i < bolas; i++){
    lotery[i] = (int) (random(num_bolas) + 1);
    
    for(int j=0; j<i; j++){
    if(lotery[j]==lotery[i]) i--;
    
    }
  }
  
  
  
}

