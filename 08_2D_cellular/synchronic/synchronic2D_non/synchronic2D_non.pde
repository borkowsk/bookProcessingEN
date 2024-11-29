/// "Not too many neighbors": 
/// TWO-dimensional, SYNCHRONOUS, von Neumann, deterministic cellular automaton
//-//////////////////////////////////////////////////////////////////////////////

final int   WorldSide=601; //How many cells do we want in one line?
final float Dens=0.15;     //0.5 or so also posible
final int   optN=2;        //Optimum number of neighbors required

int[][] WorldOld=new int[WorldSide][WorldSide]; //We need two "worlds" for the old  
int[][] WorldNew=new int[WorldSide][WorldSide]; //and new state of the simulation

void setup()
{
  size(601,601);    //square window
  frameRate(20);  
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
      point(j,i);//the horizontal dimension of the array is the SECOND index
    }
}

int t=0; ///< time is global

void draw() ///< modifies global t, WorldOld, WorldNew
{  
  visualisation();
  
  for(int i=0;i<WorldSide;i++) //Now the cellular automaton state change
  {
    //RULE - Not too many neighbors
    int right = (i+1) % WorldSide;          
    int left  = (WorldSide+i-1) % WorldSide;
     
    for(int j=0;j<WorldSide;j++) 
    {
      int dw=(j+1) % WorldSide;   
      int up=(WorldSide+j-1) % WorldSide;
     
      int live = (
                 (WorldOld[left][j]>0 ?1:0) 
               + (WorldOld[right][j]>0 ?1:0)
               + (WorldOld[i][up]>0 ?1:0) 
               + (WorldOld[i][dw]>0 ?1:0)             
               );
      WorldNew[i][j]=(live == optN ? 1:0 ); //New state 
   }
  }
   
  //Swap the arrays
  int[][] WorldTmp=WorldOld;
  WorldOld=WorldNew;
  WorldNew=WorldTmp;
   
  t++;//The next generation/step/year
}

// https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/
/// @date 2024-11-29 (revived)
