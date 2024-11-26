/// "sum of the states [of neighbors] modulo 4": 
/// One-dimensional, SYNCHRONOUS, deterministic cellular automaton
//-/////////////////////////////////////////////////////////////////////////////

final int   WorldSize=500; //How many cells do we want?
final float Dens=0.0;      //0.005 or 0.5 or similars are also posible

int[] WorldOld=new int[WorldSize]; //We need two worlds for the old  
int[] WorldNew=new int[WorldSize]; //and new state of the simulation

void setup()
{
  size(500,1000);
  frameRate(100);
  noSmooth(); //CA look better without smooth
  if(Dens>0)
  {
   for(int i=0;i<WorldOld.length;i++)
    if(random(1.0)<Dens)
      WorldOld[i]=1;
  }
  else
  {
    WorldOld[WorldSize/2]=1;
  }
}

void visualisation()
{
  for(int i=0;i<WorldOld.length;i++)
  {
    // The selection instruction allows us 
    // to choose any color depending on the number in the cell
    switch(WorldOld[i]){
    case 3:stroke(0,255,0);break;
    case 2:stroke(255,0,0);break;
    case 1:stroke(0,0,255);break;
    case 0:stroke(0,0,0);break;
    default: stroke(255,255,0); //It shouldn't appear!
    break;
    }
    point(i,t); //current state
    line(i,999,i,994); //Reflect the current state at the bottom of the canvas
  }
}

int t=0; ///< is global!

void draw() // uses global t,WorldOld,WorldNew
{
  if(t>994) return;
  visualisation();
  
  //Now the cellular automaton state change
  for(int i=0;i<WorldOld.length;i++)
  {
     //RULE - sum of the states of neighbors modulo 4  
     int right = (i+1) % WorldSize; 
     int morer = (i+2) % WorldSize;     
     int left  = (WorldSize+i-1) % WorldSize;
     int morel = (WorldSize+i-2) % WorldSize;
     int sumState = 0; //The sum of the states
     
     //We always add the WHOLE state, no matter, if it is zero or "alive"
     sumState+=WorldOld[left];
     sumState+=WorldOld[right];
     sumState+=WorldOld[morel];
     sumState+=WorldOld[morer];
     sumState+=WorldOld[i]; //center cell
     //Sum modulo 4 or 5 !      
     WorldNew[i]=sumState % 4;  
   }
   
  //NOW THE MOST IMPORTANT - Swap the arrays
  int[] WorldTmp=WorldOld; WorldOld=WorldNew; WorldNew=WorldTmp;
 
  t++;//The next generation/step/year
}

// https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/
// @date 2024-11-26 (revived)
