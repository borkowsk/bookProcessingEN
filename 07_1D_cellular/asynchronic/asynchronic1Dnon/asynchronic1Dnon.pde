/// "Not too many neighbors": 
/// The one-dimensional, asynchronous cellular automaton.
//-///////////////////////////////////////////////////////

final int WorldSize=500; // How many cells do we want?
final int MCD=3;         // Monte Carlo step divider
final int FR=300;        // Expected speed of the simulation

int[] World=new int[WorldSize]; // Here it creates an array of the "world"

void setup() // modifies external World
{
  size(500,1000); // The window is more vertical than horizontal
  frameRate(FR);  // Expected speed of the simulation
  noSmooth();     // Antialiasing is unnecessary for cellular automata
  // Initialisation
  World[WorldSize/2]=1; // The seed of the automaton more or less in the middle
}

void Visualisation1()
{
  for(int i=0;i<WorldSize;i++)
  {                               
    if(World[i]>0) stroke(255,255,0); // Non-zero cells are yellow
    else           stroke(0,0,255);   // Zero cells are blue
    point(i,t); // State of the 'i' cell of the automaton at time 't'
  }
}

void Visualisation2()
{
  for(int i=0;i<WorldSize;i++)
  {                               
    if(World[i]>0) stroke(0,255,128); // Non-zero cells are green
    else           stroke(0); // Zero cells are black
    line(i,t,i,height); // State of the 'i' cell of the automaton at time 't'
  }
}

int t=0; // Time counter, i.e. steps/generations/years

void draw() // uses external t
{
  if(t>height) // Is it off screen?
    return;    // We use "emergency exit" because there is nothing to draw 
 
  Visualisation1();
  
  // Monte Carlo or part of Monte Carlo step
  int N=WorldSize/MCD; // At MOST 1/MCD of the automaton cells changes its state in a time step
  for(int j=0;j<N;j++)
  {
       int i=int(random(WorldSize)); // We need to truncate the fractional part
       
       // Calculation of neighbors' indices taking into account the "boundary conditions" 
       int right = (i+1) % WorldSize; // Wrapping in a circle using the remainder of division operator       
       int left  = (WorldSize+i-1) % WorldSize; // This operator works intuitively only for positive numbers!
       int lcou  = 0; // counter of live neighbors
       
       if(World[left]>0) // Is the left neighbor not zero, ie is he "alive"?
         lcou++;    
       
       if(World[right]>0) // Is the right neighbor not zero?
         lcou++; 
       
       // The rule of this automaton - if you have ONE living neighbor, you are alive
       if(lcou==1)
         World[i]=1;
       else
         World[i]=0;
   }
   
   t++; // The next generation/step/year
}

 
/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
