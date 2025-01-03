/// Bounded confidence 1D - 3th+4th attempts.
/// Differences in tresholds as a function of extremes of views
/// & with information bubles.
//-//////////////////////////////////////////////////////////////////

final int          N=100; //Number of agents
final float treScale=0.5; //Threshold is a function of extremes of views times Scale
final float   minEps=0.001;
final float   maxEps=0.005;
final int        bub=N/2; //radius of information bubble

float[] minds=new float[N]; //creating the minds array 
float[]   eps=new float[N]; //creating the epsilons array
float[]   tre=new float[N]; //creating the tresholds array

boolean classicVis=false;   //Type of visualisation

void setup()
{
  size(1000,250);
  frameRate(300);
  
  //Initialisation
  for(int i=0;i<N;i++)
  {
    minds[i]=i*(1.0/(N-1));//<0..1>
    eps[i]=random(minEps,maxEps);
    //Threshold is a function of extremes of views
    tre[i]=(0.5-abs(minds[i]-0.5))*treScale;//<0..0.5*Scale>
  }
  
  //Check
  println("N:",N , "Epsilon:",minEps,"..",maxEps , " Tres.Scale:",treScale , ",Inf.buble:",bub );
  for(int i=0;i<N;i++)
    println(minds[i],eps[i],tre[i]);
}


void visualisationA()
{
  int side=height/(N*2);
  float step=255/N,R=255,B=0;
  for(int i=0;i<N;i++)
  {
    stroke(R,0,B);R-=step;B+=step;
    ellipse(frameCount,(1-minds[i])*height,side,side);
  }
}


void visualisationB()
{ //Alternative visualisation
  int side=height/N;
  for(int i=0;i<N;i++)
  {
    float R=minds[i]*255, B=(1-minds[i])*255;
    stroke(R,0,B);
    rect(frameCount,i/(float)(N)*height,side,side);
  }
}


void draw()
{
  if(frameCount>width) return; //Emergency exit
  
  //Visualisation
  if(classicVis) visualisationA();
  else visualisationB();
  
  //Monte Carlo step of changes
  for(int i=0;i<N;i++)
  {
    int a=int(random(N));
    int low=max(0,a-bub),hig=min(a+bub+1,N);
    int b=int( random( low , hig ) );  //println(a,low,b,hig);

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

//@date 2023 (https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence)
