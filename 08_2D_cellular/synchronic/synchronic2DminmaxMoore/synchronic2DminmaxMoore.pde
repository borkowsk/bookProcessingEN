/// "Min Max neighbors": Not too many neighbors, but not too few.
/// TWO-dimensional, SYNCHRONOUS, Moore, deterministic cellular automaton.
//-/////////////////////////////////////////////////////////////////////////

final int   WorldSide=601; // How many cells do we want in one line?
final float Dens=0.875;    // 0.05 or so also posible

final int   MinN=3;        // Minimal number of neighbors required
final int   MaxN=4;        // Maximal number of neighbors required

int[][] WorldOld=new int[WorldSide][WorldSide]; //We need two "worlds" for the old  
int[][] WorldNew=new int[WorldSide][WorldSide]; //and new state of the simulation


void setup()
{
  size(601,601);    //square window
  frameRate(999);  
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


int t=0;

void draw() // modifies global t,WorldOld,WorldNew
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
       
      int live = ( //Brackets are redundand in JAVA syntax, but they don't bother
                  WorldOld[left][j]
               +  WorldOld[right][j]
               +  WorldOld[i][up]
               +  WorldOld[i][dw]    
               +  WorldOld[left][up]
               +  WorldOld[right][up]
               +  WorldOld[left][dw]
               +  WorldOld[right][dw]            
               ); // Brackets do not interfere in JAVA syntax, unlike Python syntax where without them a multi-line expression will malfunction.
               
      // Now we define a new cell state and write to the new world state.
      WorldNew[i][j]=(MinN <= live && live <=MaxN ? 1:0 ); //New state 
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

/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/)
