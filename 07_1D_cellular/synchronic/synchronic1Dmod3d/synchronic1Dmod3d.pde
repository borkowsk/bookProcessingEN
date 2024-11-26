/// "sum of living neighbors modulo 3": 
/// One-dimensional, SYNCHRONOUS, deterministic cellular automaton
//-/////////////////////////////////////////////////////////////////////////

final int   WorldSize=500; //How many cells do we want?
final float Dens=0.002;    //0.5 or so also posible

final boolean withMe=false;  //Own cell is taking to account.
final boolean withMore=true; //More far cells are taking to account.

int[] WorldOld=new int[WorldSize]; //We need two worlds for the old  
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

int t=0; ///< is global!

void draw() ///< uses global t,WorldOld,WorldNew
{
  if(t>994) return;
 
  visualisation();
  
  for(int i=0;i<WorldSize;i++)//Now the cellular automaton state change
  {
    //RULE - sum of living neighbors (distance 2) modulo 3
    int right = (i+1) % WorldSize;      
    int left  = (WorldSize+i-1) % WorldSize;
    int morer = (i+2) % WorldSize; //More right 
    int morel = (WorldSize+i-2) % WorldSize;// More left
    int howMany= 0;//How many live neighbors?
   
    if(WorldOld[left]>0) //It is not zero, so, it is "alive"
      howMany++;
   
    if(WorldOld[right]>0) //It is not zero, so, it is "alive"
      howMany++;
    
    if(withMore)
    {
      if(WorldOld[morel]>0) //It is not zero, so, it is "alive"
         howMany++;
      if(WorldOld[morer]>0) //It is not zero, so, it is "alive"
         howMany++; 
    }  
    //What about me?
    if(withMe && WorldOld[i]>0) howMany++;
    //Now MODULO! We save the new state on the second array     
    WorldNew[i]=howMany % 3;
   }
   
  //NOW THE MOST IMPORTANT - Swap the arrays
  int[] WorldTmp=WorldOld;
  WorldOld=WorldNew; WorldNew=WorldTmp;
   
  t++;//The next generation/step/year
}

// https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/
// @date 2024-11-26 (revived)
