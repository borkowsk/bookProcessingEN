/// Simple floating point based cellular automaton.

int SIDE=400;
float[][] cstates=new float[SIDE][SIDE]; //Current states of cells
float[][] nstates=new float[SIDE][SIDE]; //New states of cells
float DENS=0.5;

//Weights depending on the neighbor's distance
float WeightDist3=0.1;
float WeightDist2=0.2;
float WeightDist1=4.822222222222222;
float WeightSum=9*WeightDist1+16*WeightDist2+24*WeightDist3;

//Statistic
float average=0;

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

void initialiseLine() //Alternative initialisation
{
  for (int i=0; i<SIDE; i++)
    for (int j=0; j<SIDE; j++)
      if (j==SIDE/2)
        cstates[i][j]=1.0;
      else
        cstates[i][j]=0.0;
}

void visualise()
{
  double sum=0; //More precise
  for (int i=0; i<SIDE; i++)
    for (int j=0; j<SIDE; j++)
    {
      float value=cstates[i][j];
      sum+=value;
      
      if(0<=value && value<=1)
        stroke(value*255);
      else
        stroke(255,0,0);
      point(i,j);  
    }
    
  average=(float)sum/(SIDE*SIDE); //with limited precision of the result
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
         
         float w=WeightDist1;
         
         //when any neighborhood coordinate is distant by 3.
         if(k==-3 || k==3 || l==-3 || l==3)
           w=WeightDist3;
         else if(k==-2 || k==2 || l==-2 || l==2) // and if not at 3, then at 2
           w=WeightDist2;
           
         sum+=cstates[a][b]*w;
       }
       
       nstates[i][j]=sum/WeightSum;
    }
   
   float[][] tmp=cstates;
   cstates=nstates;
   nstates=tmp;
}

void setup()
{
  if(DENS>0) //selection of initialization method
    initialiseDens();
  else
    initialiseLine();
  visualise();
  frameRate(2);
}

void draw()
{
  newStates();
  visualise();
  println(frameCount,'\t',average);
}

/// @date 2025-11-24 (initial)
