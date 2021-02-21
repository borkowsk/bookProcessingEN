//Bounded confidence 0D - second attempt
//with information bubles
final int N=25;//Number of agents
float[] minds=new float[N];//creating an array 
float   eps=0.005;
float   tre=0.20;
int     bub=N/5;//radius of information bubble

//for visualisation
float   side=0;

void setup()
{
  size(1000,250);
  side=height/(N*2);
  frameRate(60);
  //Initialisation
  for(int i=0;i<N;i++)
    minds[i]=i*(1.0/(N-1));
  //Check
  println("N:"+N , "Epsilon:"+eps , "Treshold:"+tre , "bubleR="+bub);
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
    int low=max(0,a-bub),hig=min(a+bub+1,N);
    int b=int( random( low , hig ) );  //println(a,low,b,hig);
    
    if(abs(minds[b]-minds[a])<tre)
    {
      if(minds[a] < minds[b])
        minds[a]+=eps;
      else
      if(minds[a] > minds[b])
        minds[a]-=eps;
    }
  }
  
}
