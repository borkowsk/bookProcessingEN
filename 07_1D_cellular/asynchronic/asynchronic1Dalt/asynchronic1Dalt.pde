// "Seeding": One-dimensional, asynchronous cellular automaton
//  (the simplest simulation of CA in functional syntax) 
///////////////////////////////////////////////////////////////
final int WorldSize=500;//How many cells do we want?
final int MCD=5;//Monte Carlo step divider
final int FR=300;//Expected speed of the simulation

int[] World=new int[WorldSize];//We create an array of the "world"

void setup()
{
  size(500,1000);//The window is more vertical than horizontal
  frameRate(FR); //Expected speed of the simulation
  noSmooth(); //Antialiasing is unnecessary for cellular automata
  World[WorldSize/2]=1; //The seed of the automaton more or less in the middle
}

void Visualisation1()
{
  for(int i=0;i<WorldSize;i++)//or World.length
  {                               
    if(World[i]>0) stroke(255,255,0);//Non-zero cells are yellow
    else           stroke(0,0,255);//Zero cells are blue
    point(i,t);//'i' cell of the automaton at time 't'
  }
}

void Visualisation2()
{
  for(int i=0;i<WorldSize;i++)
  {                               
    if(World[i]>0) stroke(0,255,128);//Non-zero cells are green
    else           stroke(0);//Zero cells are black  
    line(i,t,i,height);//'i' cell of the automaton at time 't'
  }
}

int t=0;//Steps counter
void draw()
{
  if(t>height) return; //Is it off screen? -> We use "emergency exit"
  Visualisation2();
  
  //Monte Carlo or part of Monte Carlo step
  int N=WorldSize/MCD; //At MOST 1/MCD of the automaton cells changes its state in a time step
  for(int j=0;j<N;j++)
  {
       int i=int(random(WorldSize));//We need to truncate the fractional part
       
       //Calculation of neighbors' indices taking into account the "boundary conditions" 
       int right = (i+1) % WorldSize;//Wrapping in a circle using the remainder of division operator       
       int left  = (WorldSize+i-1) % WorldSize;//This operator works intuitively only for positive numbers!
       
       //The rule of this automaton - if you have a living neighbor, you become alive
       if(World[left]>0 || World[right]>0) //Is the left or right neighbor not zero, ie is he "alive"?
         World[i]=1;       //The cell under consideration becomes alive
   }
   
   t++;//The next generation/step/year
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/asynchronic
