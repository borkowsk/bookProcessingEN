// "Voter model with RADIUS." <=> "R*2 Neighbors Social Impact": 
// One-dimensional, asynchronous cellular automaton
///////////////////////////////////////////////////////////////
final int WorldSize=500;//How many cells do we want?
final int NeiRadius=7;//Neighborhood radius

final int MCD=10;//Monte Carlo step divider
final int FR=100;//Expected speed of the simulation

int[] World=new int[WorldSize];//We create an array of the "world"

void densityInit(float Dens)
{
  for(int i=0;i<WorldSize;i++)
  if(random(1.0)<Dens)
    World[i]=1;
  else
    World[i]=0;
}

void setup()
{
  size(500,500); //The window is more vertical than horizontal
  frameRate(FR); //Expected speed of the simulation
  noSmooth(); //Antialiasing is unnecessary for cellular automata
  //Initialisation
  densityInit(0.5);
}

void Visualisation3()
{
  for(int i=0;i<WorldSize;i++)
  {                               
    if(World[i]>0) stroke(255,0,255);//Non-zero cells are magenta
    else           stroke(255);//Zero cells are white
    point(i,t);//State of the 'i' cell of the automaton at time 't'
  }
}

void Visualisation2()
{
  for(int i=0;i<WorldSize;i++)
  {                               
    if(World[i]>0) stroke(0,255,128);//Non-zero cells are green
    else           stroke(0);//Zero cells are black
    line(i,t,i,height);//State of the 'i' cell of the automaton at time 't'
  }
}

int t=0;//Time counter, i.e. steps/generations/years
void draw()
{
  if(t>height) //Is it off screen?
    return;//We use "emergency exit" because there is nothing to draw 
 
  Visualisation3();
  
  //Monte Carlo or part of Monte Carlo step
  int N=WorldSize/MCD; 
  for(int j=0;j<N;j++)
  {
       int i=int(random(WorldSize));
       int cou0  = 0;//counter of 0 state neighbors
       int cou1  = 0;//counter of 1 state neighbors
       
       for(int r=1;r<=NeiRadius;r++)
       {
         //Calculation of neighbors' indices taking into account the "boundary conditions" 
         int right = (i+r) % WorldSize;
         int left  = (WorldSize+i-r) % WorldSize;

         if(World[left]==0) //Is the left neighbor not zero?
           cou0++;else cou1++; 
         
         if(World[right]==0)//Is the right neighbor not zero?
           cou0++;else cou1++;
       } 
 
       if(World[i]==0) //What about me?
         cou0++;else cou1++;
       
       //Central cell assumes a state more common in your environment
       if(cou0>cou1) World[i]=0;
       else  World[i]=1;
   }
   
   t++;//The next generation/step/year
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/asynchronic
