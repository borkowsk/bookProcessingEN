/// Bounded confidence 0D - second attempt.
/// Treshold and epsilon.
//-////////////////////////////////////////

final int   N=25;        //Number of agents
final float eps=0.002;   //pace of change
final float tre=1.0/2;   //Treshold

float[] minds=new float[N]; //creating an array 

//for visualisation
float   side=0;

void setup() // modifies global side
{
  size(1000,250);
  side=height/(N*2);
  frameRate(600);
  
  //Initialisation
  for(int i=0;i<N;i++)
    minds[i]=i*(1.0/(N-1)); //<0..1>
    
  //Check
  println("N:",str(N),"Epsilon:",str(eps),"Treshold:",str(tre) ); //surface.setTitle("confidence02 "+tre);
  for(int i=0;i<N;i++)
    print(minds[i]," ");
}


void draw()
{
  //Visualisation:
  float step=255/N,R=255,B=0;
  for(int i=0;i<N;i++)
  {
    stroke(R,0,B);R-=step;B+=step;
    ellipse(frameCount,(1-minds[i])*height,side,side);
  }
  
  //Monte Carlo step of changes
  for(int i=0;i<N;i++)
  {
    int a=int(random(N));
    int b=int(random(N));
    
    if( abs(minds[a]-minds[b]) < tre )
    {
      if(minds[a] < minds[b])
        minds[a]+=eps;
      else
        if(minds[a] > minds[b])
          minds[a]-=eps;
    }
  }
} //End of draw()

/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence)
