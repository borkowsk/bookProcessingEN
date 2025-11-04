// Two-dimensional, probabilistic (MC steps) cellular automaton - SIR rule
// Seeding the table at the beginning with a given density of healthy cells and a single infected cell
// NUMBER OF INTERACTIONS 4, but the probability of infection is not equal to 1 only PTransfer
// DISEASE lasts in the infected depending on PRecovery or PDeath
// WE COLLECT STATISTICS: int kranken,geheilt,starben;
//-////////////////////////////////////////////////////////////////////////////////////////////////////

int WorldSize=400; //How many elements do we want in a line and how many lines (square array)

int[][] World=new int[WorldSize][WorldSize]; //Creating the world table

float IDens=0.70; //Initial density in the array -
                  // QUESTION: what is the threshold density,
                  // at which the epidemic will ALWAYS attack the entire world? (if it starts)
                  // Although there may be small areas that it has missed.

//`final` is something like constants ;-)
final int Empty=0; 
final int Susceptible=1;
final int Infected=2;
final int Recovered=3;
final float PTransfer=0.33;   //Probability of infecting an agent in a single interaction
final float PRecovery=0.10;   //Average probability of recovery on a given day
final float PDeath=0.01;      //Average probability of death on a given day of illness
                              //PDeath + PRecovery < 1  !!!

//STATISTICS COUNTED DURING SIMULATION
int kranken=0; // Sick
int geheilt=0; // Recovery
int starben=0; // Those who died

void setup()
{
 assert PDeath + PRecovery < 1 : "Probabilities too high PDeath + PRecovery"; //Assertion
                                                                              //- checking assumptions
 
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
      switch(World[i][j]){//The switch statement allows us to select any color depending on the number in the cell
      case 3:stroke(0,255,0);break;
      case 2:stroke(255,0,0);break;
      case 1:stroke(0,0,255);break;
      case 0:stroke(0,0,0);break;
      default: stroke(255); //This shouldn't appear
      break;
      } 
      point(i,j);
    }
  
  kranken=0;geheilt=0;starben=0; //Resetting for the step. As commented out, we collect statistics of the entire epidemic
  
  //Changing the state of the automaton - Monte Carlo step
  //STATES: Empty=0; Susceptible=1; Infected=2; Recovered=3;
  for(int a=0;a<World.length*World.length;a++) //As many draws as there are cells
  {
       // Agent draw
       int i=(int)random(World.length);
       int j=(int)random(World.length);
       
       //If empty or healthy, nothing happens
       if(World[i][j]!=Infected) continue;
       
       //Calculating the location of neighbors
       int right = (i+1) % WorldSize;      
       int left  = (WorldSize+i-1) % WorldSize;
       int dw=(j+1) % WorldSize;   
       int up=(WorldSize+j-1) % WorldSize;

       if(World[left] [j]==Susceptible && random(1) < PTransfer) 
        {World[left][j]=Infected; kranken++;}
       if(World[right][j]==Susceptible && random(1) < PTransfer) 
        {World[right][j]=Infected; kranken++;}
       if(World[i][up]==Susceptible && random(1) < PTransfer) 
        {World[i][up]=Infected; kranken++;}
       if(World[i][dw]==Susceptible && random(1) < PTransfer) 
        {World[i][dw]=Infected; kranken++;}

       float prob=random(1); //Fate for the day
       
       if(prob<PDeath) //He dies that day
        {World[i][j]=Empty;starben++;}
       else if(prob<PRecovery+PDeath) //Or he is cured,
             {World[i][j]=Recovered;geheilt++;}
             //else //or STILL SUFFERING!
   } //End of the loop after randomly selected agents
      
   t++; //Next generation/step/year
   text("ST:"+t+" got sick:"+kranken+" recovered:"+geheilt+" died:"+starben,0,10);
   println("ST:"+t+"\tZ\t"+kranken+"\tW\t"+geheilt+"\tU\t"+starben);
}

//////////////////////////////////////////////////////////////////////////////////
// Author: Wojciech T. Borkowski
// Materials for the script "Processing in education and simulation
// https://github.com/borkowsk/bookProcessingEN
//////////////////////////////////////////////////////////////////////////////////
