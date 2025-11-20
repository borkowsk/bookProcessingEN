/// Simple floating point based cellular automaton.

int SIDE=400;
double[][] cstates=new double[SIDE][SIDE]; //Current states of cells
double[][] nstates=new double[SIDE][SIDE]; //New states of cells
float DENS=0.15;//0.5;

//Weights depending on the neighbor's distance
double WeightDist3=-0.3; //-0.333333333333333333;//-0.4; //-0.2;
double WeightDist2=0.1; // 0.1;//-0.1; //-0.05;
double WeightDist1=6.066666666666667; // 6.155555555555555556;//6.68888888888889;//1.0; //6.06666666666667;
double WeightSum=9*WeightDist1+16*WeightDist2+24*WeightDist3;

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
      double value=cstates[i][j];
      sum+=value;
      
      if(0.<=value && value<=1.)
        stroke((float)value*255);
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
      double sum=0;
      for(int l=-3;l<=3;l++)
       for(int r=-3;r<=3;r++)
       {
         int a=(i+l+SIDE)%SIDE;
         int b=(j+r+SIDE)%SIDE;
         
         double w=WeightDist1;
         
         //when any neighborhood coordinate is distant by 3.
         if(l==-3 || l==3 || r==-3 || r==3)
           w=WeightDist3;
         else if(l==-2 || l==2 || r==-2 || r==2) // and if not at 3, then at 2
           w=WeightDist2;
           
         sum+=cstates[a][b]*w;
       }
       
       sum/=WeightSum;
       //If the initial density is not 0.5, then for many sets of weights 
       //the truncations below zero and above 1 do not balance each other, 
       //and the average then tends to 0.5 (faster or slower)
       if(0.<=sum && sum<=1.)
         nstates[i][j]=sum;
       else if(sum<0) 
         nstates[i][j]=0.;
       else
         nstates[i][j]=1.;
       
    }
   
   double[][] tmp=cstates;
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
  String msg=frameCount+": "+average+" "+frameRate+"frm/sec";
  text(msg,1,height); // here we have the actual speed.
  if(frameCount%10==0) println(msg);
}

/// @date 2025-11-20 (initial)
