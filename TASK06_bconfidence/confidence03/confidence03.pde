//Bounded confidence 0D - 3th attempt
//Differences in tresholds as a function of extremes of views
final int          N=50;//Number of agents
final float treScale=0.999;//Threshold is a function of extremes of views times Scale

float[] minds=new float[N];//creating the minds array 
float[]   eps=new float[N];//creating the epsilons array
float[]   tre=new float[N];//creating the tresholds array

void setup()
{
  size(1000,500);
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
  println("N:"+N , "Epsilon: 0.001..0.01" , "Tres.Scale:"+treScale );
  for(int i=0;i<N;i++)
    println(minds[i],eps[i],tre[i]);
}

void draw()
{
  //Visualisation
  visualisationA();
  
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
    rect(frameCount,i/(float)N*height,side,side);
  }
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence
