/// Simple floating point based cellular automaton.

int SIDE=400;
float[][] cstates=new float[SIDE][SIDE]; //Current states of cells
float[][] nstates=new float[SIDE][SIDE]; //New states of cells
float DENS=0.5;

void settings()
{
  size(SIDE, SIDE);
  noSmooth();
}

void initialiseDens()
{
  for (int i=0; i<SIDE; i++)
    for (int j=0; j<SIDE; j++)
      if (random(1.0)<DENS)
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
      for(int l=-3;l<=3;l++)
       for(int r=-3;r<=3;r++)
       {
         int a=(i+l+SIDE)%SIDE;
         int b=(j+r+SIDE)%SIDE;
         sum+=cstates[a][b];
       }
       nstates[i][j]=sum/49;
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
  newStates();
  visualise();
  println(frameCount);
}

/// @date 2025-11-20 (initial)
