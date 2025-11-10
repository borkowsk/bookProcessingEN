/// "Min Max neighbors": Not too many neighbors, but not too few.
/// TWO-dimensional, SYNCHRONOUS, vonNeuman/Moore, deterministic cellular automaton.
//-/////////////////////////////////////////////////////////////////////////////////

final int     WorldSide=601;   //How many cells do we want in one line?
final int     FM = 100;        // Desired computation rate [fps].

final float   Dens=0.86;       //0.5, 0.75 or so are also posible.
final int     MinN=3;          //Minimal number of neighbors required.
final int     MaxN=4;          //Maximal number of neighbors required.

final boolean withMoore=false; //With or without Moore neighbors

int[][] WorldOld=new int[WorldSide][WorldSide]; //We need two arrays for the old  
int[][] WorldNew=new int[WorldSide][WorldSide]; //and new state of the simulation
  
void setup()
{
  size(601,601);    //square window
  frameRate(FM);  
  noSmooth();
  
  for(int i=0;i<WorldSide;i++) //Initialisation
    for(int j=0;j<WorldSide;j++) 
      if(random(1.0)<Dens)
        WorldOld[i][j]=1;
}

void visualisation()
{
  for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++)
    {
      if(WorldOld[i][j]>0) stroke(255,0,100);
      else           stroke(0);
      point(j,i); //the horizontal dimension of the array is the SECOND index
    }
}


int t=0; ///< time is global

void draw() // uses global t, WorldNew, WorldOld
{  
  visualisation();
  
  for(int i=0;i<WorldSide;i++) //Now the cellular automaton state change
  {
    //RULE - Not too many neighbors, but not too few
    int right = (i+1) % WorldSide;          
    int left  = (WorldSide+i-1) % WorldSide;
     
    for(int j=0;j<WorldSide;j++) 
    {
      int dw=(j+1) % WorldSide;   
      int up=(WorldSide+j-1) % WorldSide;
      
      int live = ( WorldOld[left][j] + WorldOld[right][j] + WorldOld[i][up] + WorldOld[i][dw]  // Von Neumann neighbours
               + ( withMoore ? WorldOld[left][up] + WorldOld[right][up] + WorldOld[left][dw] + WorldOld[right][dw] : 0 ) // Moore neighbours
               );
     
      WorldNew[i][j]=(MinN <= live && live <=MaxN ? 1:0 ); //New state 
    }
  }
   
  //Swap the arrays
  int[][] WorldTmp=WorldOld;
  WorldOld=WorldNew;
  WorldNew=WorldTmp;
   
  t++; //The next generation/step/year
  textSize(20); textAlign(LEFT,TOP); text("ST:"+t,0,0);
}


/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/)
