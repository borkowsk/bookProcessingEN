// Two-dimensional, probabilistic (MC steps) cellular automaton - SIR rule
// Seeding the table at the beginning with a given density of healthy cells and a single infected cell
// NUMBER OF INTERACTIONS 4, THE DISEASE IS VERY SHORT BUT VERY CONTAGIOUS
//-//////////////////////////////////////////////////////////////////////////////////////////////

int WorldSize=400; //How many elements do we want in a line and how many lines (square array)

int[][] World=new int[WorldSize][WorldSize]; //Creating the world table

float IDens=0.99; //Initial density in the array -
                  // QUESTION: what is the threshold density,
                  // at which the epidemic will ALWAYS attack the entire world? (if it starts)
                  // Although there may be small areas that it has missed.
                  
//Something like constants ;-)
final int Empty=0; 
final int Susceptible=1;
final int Infected=2;
final int Recovered=3;

void setup()
{
 size(400,400);    //Square window
 noSmooth();       //It speeds up simulations significantly
 
 if(IDens>0)
  {
   for(int i=0;i<World.length;i++) //Seeding the array
    for(int j=0;j<World.length;j++) 
      if(random(1.0)<IDens)
        World[i][j]=Susceptible;
      else
        World[i][j]=Empty; //For initialization certainty, especially if "Empty" was not zero.
  }
 
 World[WorldSize/2][WorldSize/2]=Infected;
  
 frameRate(100);
}

int t=0;

void draw()
{  
  for(int i=0;i<World.length;i++) //Visualization, in other words "drawing on the screen"
    for(int j=0;j<World.length;j++) 
    {
      switch(World[i][j]){ //The switch statement allows us to select any color depending on the number in the cell
      case 3:stroke(0,255,0);break;
      case 2:stroke(255,0,0);break;
      case 1:stroke(0,0,255);break;
      case 0:stroke(0,0,0);break;
      default: stroke(255); //This shouldn't appear
      break;
      } 
      point(i,j);
    }
  
  //Changing the state of the automaton - Monte Carlo step
  //STATES: Empty=0; Susceptible=1; Infected=2; Recovered=3;
  for(int a=0;a<World.length*World.length;a++) //As many draws as there are cells
  {
       //Random agent selection 
       int i=(int)random(World.length);
       int j=(int)random(World.length);
       
       //If empty or healthy, nothing happens
       if(World[i][j]!=Infected) continue;
       
       //Calculating the location of neighbors
       int right = (i+1) % WorldSize;      
       int left  = (WorldSize+i-1) % WorldSize;
       int dw=(j+1) % WorldSize;   
       int up=(WorldSize+j-1) % WorldSize;
       
       for(int b=0;b<4;b++) //More and more interactions
       {
         int neigh=(int)random(4);
         
         switch(neigh) //Here you have to be very careful not to make a mistake in the indexes
         {
         case 0: if(World[left] [j]==Susceptible) World[left][j]=Infected;  break;
         case 1: if(World[right][j]==Susceptible) World[right][j]=Infected;  break;
         case 2: if(World[i][up]==Susceptible) World[i][up]=Infected;break;
         case 3: if(World[i][dw]==Susceptible) World[i][dw]=Infected;break;
         default: println("Ups!",neigh);break;
         } 
       }
       World[i][j]=Recovered;
   }
      
   t++; //Next generation/step/year
   text("ST:"+t,0,10);
}


//*////////////////////////////////////////////////////////////////////////////////
// Author: Wojciech T. Borkowski
// Materials for the script "Processing in education and simulation
// https://github.com/borkowsk/bookProcessingEN
/// @date 2025-11-10 (last modification)
//*////////////////////////////////////////////////////////////////////////////////
