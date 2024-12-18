/// "Not too many neighbors": 
/// Two-dimensional, Moore, asynchronous cellular automaton
//-//////////////////////////////////////////////////////////////////////////////////

final int   Opt=2;              //How many neighbors allowed?
final int   WorldSide=600;      //Side lenght of simulation world (square)
final float Dens=0.15;          //.01;//Initial density in the lattice World
//final boolean withMoore=true; //TODO neighborhood with the corners of the square

int[][] World=new int[WorldSide][WorldSide]; //2 dimensional array <=> "matrix" or "lattice" 
                                            
int FR=100; //desired simulation speed

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
  }
}

void visualisation()
{
  for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++) 
    {                      
      switch(World[i][j]){ 
      case 1:stroke(255,255,0);break; //Yellow
      case 0:stroke(0,0,0);break;
      default: stroke(255,0,0); //"emergency color" - RED
      break;
      } 
      // Now color is chosen, so ready to plot a point.
      point(i,j);
    }
}

int t=0; ///< time is global!

void draw() // uses global t
{  
  visualisation();
  
  // Monte Carlo step
  int N=WorldSide*WorldSide;
  for(int a=0;a<N;a++)
  {
    //Losowanie agenta 
    int i=int(random(WorldSide));
    int j=int(random(WorldSide));
     
    //Rule: "Not too many neighbors" needs idexes of the neighborhood...
    int right = (i+1) % WorldSide;      
    int left  = (WorldSide+i-1) % WorldSide;
    int dw    = (j+1) % WorldSide;   
    int up    = (WorldSide+j-1) % WorldSide;
    
    //Then sum of living neighbors...  
    int sum = ( World[left][j] // This brackets are redundant in JAVA syntax, but necessary in Python.
    + World[right][j]
    + World[i][up]
    + World[i][dw]  
    // withMoore ? with corners?
    + World[left][up]
    + World[right][up]
    + World[left][dw]
    + World[right][dw] 
    ); //= sum of states of neighbors (states 0 and 1 only)
    
    //And final implementation of the rule comparing sum to the expected optimal.
    if(sum==Opt)
       World[i][j]=1;
    else
       World[i][j]=0;
  }
      
  t++; //next step
  textSize(20);textAlign(LEFT,TOP);text("ST:"+str(t),0,0);
   
  if(t%10==0) 
    println( t,frameRate, "fps" );
}

// https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
/// @date 2024-11-29 (revived)
