/// "sum of states modulo 3": 
/// One-dimensional, SYNCHRONOUS, deterministic cellular automaton
//-/////////////////////////////////////////////////////////////
final int   WorldSize=500; //How many cells do we want?
final float Dens=0.000; //0.5 or 0.005 are also posible

int[] WorldOld=new int[WorldSize]; //We need two "worlds" for the old  
int[] WorldNew=new int[WorldSize]; //and new state of the simulation

void setup()
{
  size(500,1000); 
  frameRate(100);
  noSmooth(); //CA look better without smooth
  
  if(Dens>0)
  {
   for(int i=0;i<WorldSize;i++)
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
  for(int i=0;i<WorldSize;i++)
  { // The selection instruction allows us 
    // to choose any color depending on the number in the cell
    switch(WorldOld[i]){ 
    case 2:stroke(255,0,0);break;
    case 1:stroke(0,0,255);break;
    case 0:stroke(0,0,0);break;
    default: stroke(0,255,0); //It shouldn't appear!
    break;
    }
    point(i,t); //current state
    line(i,999,i,994); //Reflect the current state at the bottom of the canvas
  }
}

int t=0; ///< time is global!

void draw() // modifies global t,WorldOld,WorldNew
{
  if(t>994) 
        return;
        
  visualisation();
  
  for(int i=0;i<WorldSize;i++) //Now the cellular automaton state change
  {
     //"Rule - "SUM YOUR STATE WITH YOUR NEIGHBORS AND TAKE MODULO 3""
     int right = (i+1) % WorldSize;      
     int left  = (WorldSize+i-1) % WorldSize;
     //calculation of sum...
     int sum = WorldOld[i];
     sum+=WorldOld[left];
     sum+=WorldOld[right];
     //We save the new state on the second array  
     WorldNew[i]=sum % 3; 
   }
   
  //NOW THE MOST IMPORTANT - Swap the worlds!
  int[] WorldTmp=WorldOld;
  WorldOld=WorldNew;
  WorldNew=WorldTmp;
 
  t++; //The next generation/step/year
}

// https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/
// @date 2024-11-26 (revived)
