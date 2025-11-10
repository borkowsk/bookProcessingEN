// Two-dimensional, probabilistic (MC steps) cellular automaton - SIR rule
// Seeding the table at the beginning with a given density of healthy cells and a single infected cell
// NUMBER OF INTERACTIONS 4, but the probability of infection is not equal to 1 only PTransfer
// DISEASE lasts in the infected Duration steps unless he dies (PDeath)
// WE COLLECT TOTAL STATISTICS FROM THE ENTIRE EPIDEMIC: int sumInfected,sumRecovered,sumDeath;
//-////////////////////////////////////////////////////////////////////////////////////////////////////

int WorldSize=400; //How many elements do we want in a line and how many lines (square array)

int[][] World=new int[WorldSize][WorldSize]; //Creating the world table

float IDens=0.70; //Initial density in the array -
                  // QUESTION: what is the threshold density,
                  // at which the epidemic will ALWAYS attack the entire world? (if it starts)
                  // Although there may be small areas that it has missed.

//`final` is something like constants ;-)
final int Duration=7; //Duration of a single infection!
final int Empty=0; 
final int Susceptible=1;
final int Infected=2;
final int Recovered=Infected+Duration;
final float PTransfer=0.75;   //Probability of infecting an agent in a single interaction
final float PDeath=0.01;      //Average probability of death on a given day of illness

//STATISTICS COUNTED DURING SIMULATION
int sumInfected=0;  // Sick
int sumRecovered=0; // Recovery
int sumDeath=0;     // Those who died

void setup()
{ 
 size(400,400); //Square window
 noSmooth();    //It speeds up simulations significantly
 
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
      case Recovered:  stroke(0,255,0);break; // He is cured
      case Infected:   stroke(255,0,0);break; // He got sick
      case Susceptible:stroke(0,0,255);break; // Susceptible
      case Empty:      stroke(0,0,0);break;   // Empty cell
      default:         stroke(random(255),0,random(255)); // Sick
      break;
      } 
      point(i,j);
    }
  
  //Changing the state of the automaton - Monte Carlo step
  //STATES: Empty=0; Susceptible=1; Infected=2; Recovered=Infected+Duration;
  for(int a=0;a<World.length*World.length;a++) //As many draws as there are cells
  {
       //Random agent selection
       int i=(int)random(World.length);
       int j=(int)random(World.length);
       
       //If empty or healthy, nothing happens
       if(World[i][j]<Infected || Recovered<=World[i][j]) continue;
       
       //Calculating the location of neighbors
       int right = (i+1) % WorldSize;      
       int left  = (WorldSize+i-1) % WorldSize;
       int dw=(j+1) % WorldSize;   
       int up=(WorldSize+j-1) % WorldSize;

       if(World[left] [j]==Susceptible && random(1) < PTransfer) 
        {World[left][j]=Infected; sumInfected++;}
       if(World[right][j]==Susceptible && random(1) < PTransfer) 
        {World[right][j]=Infected; sumInfected++;}
       if(World[i][up]==Susceptible && random(1) < PTransfer) 
        {World[i][up]=Infected; sumInfected++;}
       if(World[i][dw]==Susceptible && random(1) < PTransfer) 
        {World[i][dw]=Infected; sumInfected++;}

       float prob=random(1); //Fate for the day
       
       if(prob<PDeath) //He dies that day
        {World[i][j]=Empty;sumDeath++;}
        else
        {
           //Or he is cured,
          if(++World[i][j]==Recovered)
              sumRecovered++;
         //else //or STILL SUFFERING!
        }
   }
      
   t++; //Next generation/step/year
   text("ST:"+t+"  got sick:"+sumInfected+" recovered:"+sumRecovered+" died:"+sumDeath
         ,0,10);
   println("ST:"+t+"\tZ\t"+sumInfected+"\tW\t"+sumRecovered+"\tU\t"+sumDeath);
}

//*////////////////////////////////////////////////////////////////////////////////
// Author: Wojciech T. Borkowski
// Materials for the script "Processing in education and simulation
// https://github.com/borkowsk/bookProcessingEN
/// @date 2025-11-10 (last modification)
//*////////////////////////////////////////////////////////////////////////////////
