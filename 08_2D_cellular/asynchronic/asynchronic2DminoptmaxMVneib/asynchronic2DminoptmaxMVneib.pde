/// Rule: "Min:1 Best:2 Max:2 or 3 neighbors". 
/// Two-dimensional, vonNeuman/Moore, asynchronous cellular automaton.
//-/////////////////////////////////////////////////////////////////////

final int MinN=2; //Minimal number of neighbors allowed
final int OptN=3; //Number of neighbors needed to reproduce
final int MaxN=4; //Maximal number of neighbors allowed

final int     WorldSide=601;  //Side lenght of simulation world (square)
final float   Dens=0.01;      //Initial density in the lattice World
final boolean withM=true;     //With or without Moore neighbors

int[][] World=new int[WorldSide][WorldSide]; //2 dimensional world <=> "matrix" or "lattice" 
                                            
int FR=30; //desired simulation speed

void setup()
{
  size(601,601); //squre canvas
  noSmooth();    //much faster drawing
  frameRate(FR);
    
  if(Dens>0) //initialisation
  {
    for(int i=0;i<WorldSide;i++) 
      for(int j=0;j<WorldSide;j++) 
        if(random(1.0)<Dens)
          World[i][j]=1;
  }
  else
  {
    World[WorldSide/2][WorldSide/2]=1;
    World[WorldSide/2+1][WorldSide/2]=1;
  }
}

void visualisation()
{
  for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++) 
    {                      
      switch(World[i][j]){ 
      case 1:stroke(255,255,0);break;
      case 0:stroke(0,0,0);break;
      default: stroke(255,0,0); //"emergency color"
      break;
      } 
      point(i,j);
    }
}

int t=0; ///< is global

void draw() ///< uses global t
{  
  visualisation();
  
  // Monte Carlo step
  int N=WorldSide*WorldSide;
  for(int a=0;a<N;a++)
  {
       //draw the agent's indexes
       int i=int(random(WorldSide));
       int j=int(random(WorldSide));
       
       //Rule: "Min-Best-Max neighbors"
       int right = (i+1) % WorldSide;      
       int left  = (WorldSide+i-1) % WorldSide;
       int dw=(j+1) % WorldSide;   
       int up=(WorldSide+j-1) % WorldSide;
       
       int sum =  World[left][j] + World[right][j] + World[i][up] + World[i][dw] +      
                  // corners:
                  ( withM ? World[left][up]  + World[right][up] + World[left][dw] + World[right][dw] : 0 )
                  ; //sum of living neighbors = sum of states of neighbors (states 0 and 1 only)
      
       //Implementation of the rule
       if(World[i][j]==0) //Empty central cell
       {
         if(sum==OptN) //Become... 
            World[i][j]=1; //Become...
       }
       else //Central cell dies of loneliness or over-density
         if(sum<MinN || MaxN<sum)
            World[i][j]=0;
  }
    
  t++;//next step
  textSize(20);textAlign(LEFT,TOP); text("ST:"+t,0,0); // In processing, you can concatenate strings with numbers and variables representing numbers.
}

/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/)
