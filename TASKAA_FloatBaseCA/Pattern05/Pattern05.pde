/// Simple floating point based cellular automaton.

int SIDE=400;
float[][] cstates=new float[SIDE][SIDE]; //Current states of cells
float[][] nstates=new float[SIDE][SIDE]; //New states of cells
float DENS=0.125;//0.5;

//Weights depending on the neighbor's distance
float WeightDist3=-0.33333;//-0.4; //-0.2;
float WeightDist2=0.1;//-0.1; //-0.05;
float WeightDist1=6.15554666666667;//6.68888888888889;//1.0; //6.06666666666667;
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
      
      if(0.<=value && value<=1.)
        stroke(value*255);
      else if(value<0.)
        stroke(255,0,0);
      else
        stroke(0,255,255);
        
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
      for(int l=-3;l<=3;l++)
       for(int r=-3;r<=3;r++)
       {
         int a=(i+l+SIDE)%SIDE;
         int b=(j+r+SIDE)%SIDE;
         
         float w=WeightDist1;
         
         //when any neighborhood coordinate is distant by 3.
         if(l==-3 || l==3 || r==-3 || r==3)
           w=WeightDist3;
         else if(l==-2 || l==2 || r==-2 || r==2) // and if not at 3, then at 2
           w=WeightDist2;
           
         sum+=cstates[a][b]*w;
       }
       
       sum/=WeightSum;
       
       if(0.<=sum && sum<=1.)
         nstates[i][j]=sum;
       else if(sum<0) 
         nstates[i][j]=0.;
       else
         nstates[i][j]=1.;
       
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
  frameRate(100); // wishful thinking :-D
}

void draw()
{
  newStates();
  visualise();
  fill(64+random(128),128,0);
  text(frameCount+": "+average+" "+frameRate+"frm/sec",1,height); // here we have the actual speed.
}

/// @date 2025-11-20 (initial)
