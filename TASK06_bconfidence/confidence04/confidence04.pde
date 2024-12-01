///  Bounded confidence 1D.
///  "because of information bubles"
//-///////////////////////////////////

final int   N=25;        //Number of agents
final float eps=0.007;
final float tre=0.20;
final int   bub=N/7;    //radius of information bubble

float[] minds=new float[N]; //creating an array 

void setup()
{
  size(1000,250);
  frameRate(60);
  
  //Initialisation
  for(int i=0;i<N;i++)
    minds[i]=i*(1.0/(N-1));
    
  //Check
  println("N:",N , "Epsilon:",eps , "Treshold:",tre , "bubleR=",bub);
  for(int i=0;i<N;i++)
    print(minds[i]," ");
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
  
  //Visualisation:
  visualisationA();
  
  //Monte Carlo step of changes:
  for(int i=0;i<N;i++)
  {
    int a=int(random(N));
    int low=max(0,a-bub),hig=min(a+bub+1,N); //an alternative way to solve the problem of the world's boundaries
    int b=int( random( low , hig ) );   //println(a,low,b,hig);
    
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


//@date 2023 (https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence)
