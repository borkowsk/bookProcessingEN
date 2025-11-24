/// Simple floating point based cellular automaton.

int SIDE=400;
float[][] cstates=new float[SIDE][SIDE]; //Current states of cells
float[][] nstates=new float[SIDE][SIDE]; //New states of cells

void settings()
{
  size(SIDE, SIDE);
  noSmooth();
}

void initialiseDens()
{
  for (int i=0; i<SIDE; i++)
    for (int j=0; j<SIDE; j++)
      if (random(1.0)<0.5)
        cstates[i][j]=1.0;
      else
        cstates[i][j]=0.0;
}

void visualise()
{
  for (int i=0; i<SIDE; i++)
    for (int j=0; j<SIDE; j++)
    {
      float value=cstates[i][j];
      if(0<=value && value<=1)
        stroke(value*255);
      else
        stroke(255,0,0);
      point(i,j);  
    }
}

void newStates()
{
  for (int i=0; i<SIDE; i++)
    for (int j=0; j<SIDE; j++)
    {
      float sum=0;
      for(int k=-3;k<=3;k++)
       for(int l=-3;l<=3;l++)
       {
         int a=(i+k+SIDE)%SIDE;
         int b=(j+l+SIDE)%SIDE;
         sum+=cstates[a][b];
       }
       nstates[i][j]=sum/49;
    }
   
   float[][] tmp=cstates;
   cstates=nstates;
   nstates=tmp;
}

void newStates2()
{
  final int maxd=2;
  final int powr=(2*maxd+1)*(2*maxd+1); //when maxd==2, powr==25
  
  for (int i=0; i<SIDE; i++)
    for (int j=0; j<SIDE; j++)
    {
      float sum=0;
      for(int k=-maxd;k<=maxd;k++)
       for(int l=-maxd;l<=maxd;l++)
       {
         int a=(i+k+SIDE)%SIDE;
         int b=(j+l+SIDE)%SIDE;
         sum+=cstates[a][b];
       }
       nstates[i][j]=sum/powr;
    }
   
   float[][] tmp=cstates;
   cstates=nstates;
   nstates=tmp;
}

void setup()
{
  initialiseDens();
  visualise();
  frameRate(1);
}

void draw()
{
  newStates2();
  visualise();
  println(frameCount);
}

/// @date 2025-11-24 (initial)
