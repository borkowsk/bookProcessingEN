/// Greenberg-Hastings Model: Excitable media simulation.
/// TWO-dimensional, SYNCHRONOUS, Moore, deterministic cellular automaton.
//-/////////////////////////////////////////////////////////////////////////

final int   WorldSide=601; //< How many cells do we want in one line?
final float Dens=0.5;      //< Lower density works great for initial excitation seeds 

// Cell states: 0 - Resting/Quiescent, 1 - Excited, 2 - Refractory
final int   STATE_RESTING = 0;
final int   STATE_EXCITED = 1;
final int   STATE_REFRACTORY = 2;

int[][] WorldOld=new int[WorldSide][WorldSide]; //< We need two "worlds" for the old...
int[][] WorldNew=new int[WorldSide][WorldSide]; //< And for new state of the simulation.


void setup()
{
  size(601,601);    //square window
  frameRate(999); 
  noSmooth();
  
  // 1. Najpierw czyścimy cały świat do stanu spoczynku
  for(int i=0; i<WorldSide; i++) {
    for(int j=0; j<WorldSide; j++) {
      WorldOld[i][j] = STATE_RESTING;
    }
  }
  
  // 2. Tworzymy sztuczną asymetrię na środku ekranu
  int środekX = WorldSide / 2;
  int startY  = (int)(WorldSide / 4 * Dens);
  int koniecY = (int)(3 * (WorldSide / 4) * Dens);
  
  // Rysujemy pionowy pasek pobudzenia (linia frontu fali)
  for(int i = startY; i <= koniecY; i++) {
    WorldOld[i][środekX] = STATE_EXCITED;
  }
  
  // Tuż obok (po lewej stronie) rysujemy pasek refrakcji (ogon fali)
  // Dzięki temu fala może poruszać się tylko w prawą stronę, a na końcach zacznie się zwijać
  for(int i = startY; i <= koniecY; i++) {
    WorldOld[i][środekX - 1] = STATE_REFRACTORY;
  }
}
  
  
void visualisation()
{
  for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++)
    {
      // Color-coding for three states
      if(WorldOld[i][j] == STATE_EXCITED)         stroke(255, 0, 100); //Red/Pink for Excited
      else if(WorldOld[i][j] == STATE_REFRACTORY) stroke(0, 0, 255);   //Blue for Refractory
      else                                        stroke(0);           //Black for Resting
      
      point(j,i); //the horizontal dimension of the array is the SECOND index
    }
}

int t=0;
void draw() //Modifies global t,WorldOld,WorldNew
{  
  visualisation(); //Draw the current world
  
  for(int i=0;i<WorldSide;i++) //Now the cellular automaton state change [cite: 13]
  {
    int right = (i+1) % WorldSide;
    int left  = (WorldSide+i-1) % WorldSide;
     
    for(int j=0;j<WorldSide;j++) 
    {
      // GREENBERG-HASTINGS RULES:
      //-/////////////////////////
      if (WorldOld[i][j] == STATE_EXCITED) 
      {
        WorldNew[i][j] = STATE_REFRACTORY; //Excited cells automatically become refractory
      } 
      else if (WorldOld[i][j] == STATE_REFRACTORY) 
      {
        WorldNew[i][j] = STATE_RESTING;    //Refractory cells automatically recover to resting
      } 
      else //STATE_RESTING
      {
        int dw=(j+1) % WorldSide;
        int up=(WorldSide+j-1) % WorldSide;
         
        // Counting neighbors in the EXCITED state (Moore neighborhood)
        int excitedNeighbors = (
                    (WorldOld[left][j]   == STATE_EXCITED ? 1 : 0)
                 +  (WorldOld[right][j]  == STATE_EXCITED ? 1 : 0)
                 +  (WorldOld[i][up]     == STATE_EXCITED ? 1 : 0)
                 +  (WorldOld[i][dw]     == STATE_EXCITED ? 1 : 0)    
                 +  (WorldOld[left][up]  == STATE_EXCITED ? 1 : 0) 
                 +  (WorldOld[right][up] == STATE_EXCITED ? 1 : 0) 
                 +  (WorldOld[left][dw]  == STATE_EXCITED ? 1 : 0) 
                 +  (WorldOld[right][dw] == STATE_EXCITED ? 1 : 0)            
                 );
                 
        // Resting cell becomes excited if it has at least one excited neighbor
        WorldNew[i][j] = (excitedNeighbors >= 1 ? STATE_EXCITED : STATE_RESTING); 
      }
    }
  }
   
  //Swap the arrays 
  int[][] WorldTmp=WorldOld; 
  WorldOld=WorldNew; 
  WorldNew=WorldTmp; 
   
  t++; //The next generation/step/year 
  fill(255,128); 
  textSize(20); textAlign(LEFT,TOP); text("ST:"+t,0,0); 
}

//For more fun ;-)
void mousePressed()
{
  int i=mouseX;
  int j=mouseY;
  WorldOld[j][i]=STATE_EXCITED;
}

/// @date 2026-06-20
