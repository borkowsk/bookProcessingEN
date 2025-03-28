/// Rule: "Min=Best:1 Max:2 neig.". 
/// Two-dimensional, von Neuman, asynchronous cellular automaton.
//-///////////////////////////////////////////////////////////////

final int WorldSide=600;        //Side lenght of simulation world (square)
final float Dens=0;             //.1;//Initial density in the lattice World

int[][] World=new int[WorldSide][WorldSide]; //2 dimensional array <=> "matrix" or "lattice" 

int FR=50; //desired simulation speed
                                                                                      
void setup()
{
  size(600,600); //squre canvas
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
      default: stroke(255,0,0);break; //"emergency color"
      } 
      point(i,j);
    }
}

int t=0; ///< Time counter is global.

void draw() ///< uses global t
{  
  visualisation();
  
  // Monte Carlo step
  int N=WorldSide*WorldSide;
  for(int a=0;a<N;a++)
  {
    //draw the agent's indexes...
    int i=int(random(WorldSide));
    int j=int(random(WorldSide));
     
    //Rule: "as you see!"
    int right = (i+1) % WorldSide;      
    int left  = (WorldSide+i-1) % WorldSide;
    int dw    = (j+1) % WorldSide;   
    int up    = (WorldSide+j-1) % WorldSide;
     
    int sum = World[left][j]
    + World[right][j]
    + World[i][up]
    + World[i][dw]; //sum of living neighbors = sum of states of neighbors (states 0 and 1 only)
    
    //Implementation of the rule
    if(World[i][j]==0) //Empty central cell
    {
      if(sum==1)
         World[i][j]=1; //Become or remain alife
    }
    else
    {
      if(sum>2) 
         World[i][j]=0; //Central cell dies
    }
  }
      
  t++; //next step
  textSize(20);textAlign(LEFT,TOP);text("ST:"+str(t),0,0);
  if(t==100) //After hundred steps...
      println(frameRate,"fps");
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
/// @date 2024-11-29 (revived)
