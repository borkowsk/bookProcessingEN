// "Seeding": One-dimensional, asynchronous cellular automaton
//  (the simplest simulation of CA in functional syntax) 
///////////////////////////////////////////////////////////////
final int WorldSize=500;//How many cells do we want?
final int MCD=4; //Monte Carlo step divider
final int FR=200;//Expected speed of the simulation

int[] World=new int[WorldSize];//We create an array of the "world"

void setup()
{
  size(500,1000);//The window is more vertical than horizontal
  frameRate(FR); //Expected speed of the simulation
  noSmooth();    //Antialiasing is unnecessary for cellular automata
  //for(int i=0;i<World.length;i++) //Reset an array - if needed.
  //    World[i]=0; //It is no longer needed in this version of Processing! 
  World[WorldSize/2]=1; //The seed of the automaton more or less in the middle
}

int t=0;//Time counter, i.e. steps/generations/years
void draw()
{
  if(t>height) //Is it off screen?
    return;//We use "emergency exit" because there is nothing to draw 
  
  //Visualisation
  for(int i=0;i<WorldSize;i++)//Instead WorldSize may be World.length (an attribute of any array)
  {                               
    if(World[i]>0) stroke(255,255,0);//Non-zero cells are yellow
    else           stroke(0,0,255);//Zero cells are blue
    
    point(i,t);//State of the 'i' cell of the automaton at time 't'
  }
  
  //Monte Carlo or part of Monte Carlo step
  int N=WorldSize/MCD; //At MOST 1/MCD of the automaton cells changes its state in a time step
  for(int j=0;j<N;j++)
  {
       int i=int(random(WorldSize));//We need to truncate the fractional part
       
       //Calculation of neighbors' indices taking into account the "boundary conditions" 
       int right = (i+1) % WorldSize;//Wrapping in a circle using the remainder of division operator       
       int left  = (WorldSize+i-1) % WorldSize;//This operator works intuitively only for positive numbers!
       
       //The rule of this automaton - if you have a living neighbor, you become alive
       if(World[left]>0) //Is the left neighbor not zero, ie is he "alive"?
         World[i]=1;     //The cell under consideration becomes alive
       
       if(World[right]>0) //Is the right neighbor not zero?
         World[i]=1;
   }
   
   t++;//The next generation/step/year
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/asynchronic
