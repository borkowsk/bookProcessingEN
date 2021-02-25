//Bounded confidence 0D - second attempt
//Treshold and epsilon
final int N=25;//Number of agents
float[] minds=new float[N];//creating an array 
float   eps=0.003;
float   tre=0.25;

//for visualisation
float   side=0;

void setup()
{
  size(1000,250);
  side=height/(N*2);
  frameRate(60);
  
  //Initialisation
  for(int i=0;i<N;i++)
    minds[i]=i*(1.0/(N-1));//<0..1>
    
  //Check
  println("N:"+N , "Epsilon:"+eps , "Treshold:"+tre );
  for(int i=0;i<N;i++)
    print(minds[i]+" ");
}

void draw()
{
  //Visualisation
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
    
    if(abs(minds[a]-minds[b])<tre)
    {
      if(minds[a] < minds[b])
        minds[a]+=eps;
      else
      if(minds[a] > minds[b])
        minds[a]-=eps;
    }
  }
}
