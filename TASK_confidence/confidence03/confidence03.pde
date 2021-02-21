//Bounded confidence 0D - 3th attempt
//Differences in tresholds as a function of extremes of views
final int N=25;//Number of agents
final float treScale=0.5;//Threshold is a function of extremes of views times Scale
float[] minds=new float[N];//creating the minds array 
float[]   eps=new float[N];//creating the epsilons array
float[]   tre=new float[N];//creating the tresholds array

//for visualisation
float   side=0;

void setup()
{
  size(1000,250);
  side=height/(N*2);
  frameRate(60);
  //Initialisation
  for(int i=0;i<N;i++)
  {
    minds[i]=i*(1.0/(N-1));//<0..1>
    eps[i]=random(0.001,0.01);
    //Threshold is a function of extremes of views
    tre[i]=(0.5-abs(minds[i]-0.5))*treScale;//<0..0.5*Scale>
  }
  //Check
  for(int i=0;i<N;i++)
    println(minds[i],eps[i],tre[i]);
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
    
    if(abs(minds[a]-minds[b])<tre[a])
    {
      if(minds[a] < minds[b])
        minds[a]+=eps[a];
      else
      if(minds[a] > minds[b])
        minds[a]-=eps[a];
    }
  }
  
}
