//Bounded confidence 0D - second attempt
//Treshold and epsilon, alternative visualisation

final int     N=25;//Number of agents
final float eps=0.005;
final float tre=0.15;

float[] minds=new float[N];//creating an array

//for visualisation
float   side=0;

void setup()
{
  size(1000,250);
  side=height/(N);
  frameRate(190);
  
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
  //Alternative visualisation
  for(int i=0;i<N;i++)
  {
    float R=minds[i]*255, B=(1-minds[i])*255;
    stroke(R,0,B);
    rect(frameCount%width,i/(float)N*height,side,side);
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

//https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence

