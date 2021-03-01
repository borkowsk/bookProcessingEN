// "Min Max neighbors": Not too many neighbors, but not too few, but OPTIMAL!
// TWO-dimensional, SYNCHRONOUS, Moore, deterministic cellular automaton
//////////////////////////////////////////////////////////////////////////////
// See 233 (Conways Game of Life) or 123 & 234 - much more "biological"
final int WorldSide=513;//How many cells do we want in one line?
final float Dens=0.03;//0.5 or so also posible
final int   MinN=3;//Minimal number of neighbors required
final int   Best=3;//The number of neighbors needed to revive the cell
final int   MaxN=8;//Maximal number of neighbors required

int[][] WorldOld=new int[WorldSide][WorldSide];//We need two arrays for the old  
int[][] WorldNew=new int[WorldSide][WorldSide];//and new state of the simulation

void setup()
{
  size(513,513);    //square window
  frameRate(160);  
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

int t=0;//Or use buildin "frameCount" instead 
void draw()
{  
  visualisation();
  
  for(int i=0;i<WorldSide;i++)//Now the cellular automaton state change
  {
       //RULE - Not too many neighbors, but not too few
       int right = (i+1) % WorldSide;          
       int left  = (WorldSide+i-1) % WorldSide;
       
       for(int j=0;j<WorldSide;j++) 
       {
         int dw=(j+1) % WorldSide;   
         int up=(WorldSide+j-1) % WorldSide;
         
         int live = WorldOld[left][j]
                 +  WorldOld[right][j]
                 +  WorldOld[i][up]
                 +  WorldOld[i][dw]    
                 +  WorldOld[left][up]
                 +  WorldOld[right][up]
                 +  WorldOld[left][dw]
                 +  WorldOld[right][dw]            
                 ;
         if(WorldOld[i][j]==0)
         {
           WorldNew[i][j]=(live == Best ? 1:0);
         }
         else
         {
           WorldNew[i][j]=(MinN <= live && live <=MaxN ? 1:0 );//New state 
         }
       }
   }
   
   //Swap the arrays
   int[][] WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp;
   
   t++;//The next generation/step/year
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/
