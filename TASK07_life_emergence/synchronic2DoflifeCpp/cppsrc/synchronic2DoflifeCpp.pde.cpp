//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: synchronic2DoflifeCpp.pde
#include "processing_consts.hpp"
#include "processing_templates.hpp"
#include "processing_library.hpp"
#include "processing_inlines.hpp" //...is optional. Use when project is already compilable!
#include "processing_window.hpp"
#include "processing_console.hpp"   //...is optional. Should be deleted when not needed.
#include "project.h" //...is for you. Could be deleted when not needed.
using namespace Processing;
#include "local.h"
//==================================================================================

/// "Min-Opt-Max neighbors": Not too many neighbors, but not too few, but OPTIMAL!
/// TWO-dimensional, SYNCHRONOUS, vonNeuman/Moore, deterministic cellular automaton
//*//////////////////////////////////////////////////////////////////////////////////
// See 233 (Conways Game of Life) or 123 & 234 - much more "biological"

//declared in local.h: const int     WorldSide=501;  ///< How many cells do we want in one line?
//declared in local.h: const bool sync=false;     ///< Synchronous or asynchronous update    !!!!!!!

//declared in local.h: const float   Dens=150.15;    ///< When >=1, simetric horizontal line is created
//declared in local.h: const int     MinN=2;         ///< Minimal number of neighbors required
//declared in local.h: const int     OptN=3;         ///< The number of neighbors needed to revive the cell
//declared in local.h: const int     MaxN=3;         ///< Maximal number of neighbors required
//declared in local.h: const bool withM=true;     ///< With Moore neighbors

//declared in local.h: const bool traceVA=true;   ///< virgin areas trace ON/OFF
int FR=999;                   ///< globally visible

smatrix<int> WorldOld=new matrix<int>(WorldSide,WorldSide); ///< We need two arrays for the old  
smatrix<int> WorldNew=new matrix<int>(WorldSide,WorldSide); ///< and new state of the simulation

void processing_window::setup()
{
  size(501,521);    //square window
  background(64);
  noSmooth();
  setFrameRate( FR>0 ? FR : Dens );  

  initialisation();
}

int t=0; ///< steps counter as "time"

void processing_window::draw()
{  
   if(sync)
   {
     visualisationSY(); //Visualisation for synchronous mode
     synchronicStep();
   } 
   else
   {
     visualisationAS(); //Visualisation for asynchronous mode
     stepMonteCarlo();
   }
   
   status(); //Status bar
   t++; //The next generation/step/year
}

void status() ///< globally visible
{
   fill(128);noStroke();
   rect(0,height-20,width,20);
   
   fill(255);textSize(18);textAlign(LEFT,BOTTOM);
   text(t+String(" (")+ nf(frameRate,3,2) +String(") ")+liveCounter,0,height);
}

void initialisation() ///< globally visible
{
  if(Dens<1)
  {
   for(int i=0;i<WorldSide;i++) //Initialisation
    for(int j=0;j<WorldSide;j++)
    {
      if(!traceVA) 
          WorldNew[i][j]=-1; //Something different from any possible state
      
      if(random(1.0)<Dens)
        WorldOld[i][j]=1;
    }
  }
  else
  {  // Initialisation for testing an emergent properties of CA
     int off=-0;
     for(int j=1;j<Dens;j++)
     {
        WorldOld[off+WorldSide/2][off+WorldSide/2+j]=1;
        WorldOld[off+WorldSide/2][off+WorldSide/2-j]=1;
     }
     WorldOld[off+WorldSide/2][off+WorldSide/2]=1;
  }
}

void visualisationSY() ///< globally visible
{
  for(int i=0;i<WorldSide;i++)
   for(int j=0;j<WorldSide;j++)
    if( WorldOld[i][j] != WorldNew[i][j] ) //now WorldNew have step-1 content!!!
    {
      if(WorldOld[i][j]>0) 
        stroke(255,0,100);
      else           
        stroke(0);
      point(j,i); //the horizontal dimension of the array is the SECOND index
    }
}

void visualisationAS() ///< globally visible
{
  for(int i=0;i<WorldSide;i++)
   for(int j=0;j<WorldSide;j++)
    if(WorldNew[i][j] == -1 )
    {
      if(WorldOld[i][j]>0) 
        stroke(255,0,100);
      else         
        stroke(0);
      point(j,i); //the horizontal dimension of the array is the SECOND index
      WorldNew[i][j]=1; //READY
    }
}

int liveCounter=0;  ///< globally visible. The only statistics for the model so far.

void synchronicStep() ///< globally visible
{
  liveCounter=0; //Reset the only statistic
  for(int i=0;i<WorldSide;i++) //Now the cellular automaton state change
  {
       // RULE: Not too many neighbors, not too few, but optimal
       int right = (i+1) % WorldSide;          
       int left  = (WorldSide+i-1) % WorldSide;
       
       for(int j=0;j<WorldSide;j++) 
       {
         int dw=(j+1) % WorldSide;   
         int up=(WorldSide+j-1) % WorldSide;
         
         int lives = WorldOld[left][j]+WorldOld[right][j]+WorldOld[i][up]+WorldOld[i][dw]
                 + (withM ?
                    WorldOld[left][up]+WorldOld[right][up]+WorldOld[left][dw]+WorldOld[right][dw]    
                 : 0)
                 ;
                 
         if(WorldOld[i][j]==0)
           WorldNew[i][j]=(lives == OptN ? 1:0);
         else
           WorldNew[i][j]=(MinN <= lives && lives <=MaxN ? 1:0 ); //New state 
         
         if(WorldNew[i][j]>0) liveCounter++; //Calculating the only statistic
       }
   }
   
   // Swap the arrays
   smatrix<int> WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp;
}

void stepMonteCarlo() ///< globally visible
{
  liveCounter=0; //Reset the only statistic
  for(int N=WorldSide*WorldSide,a=0;a<N;a++)
  {
       int i=int(random(WorldSide)),j=int(random(WorldSide)); //draw the agent's indexes
       
       //Rule: "Min-Best-Max neighbors"
       int right = (i+1) % WorldSide;      
       int left  = (WorldSide+i-1) % WorldSide;
       int dw=(j+1) % WorldSide;   
       int up=(WorldSide+j-1) % WorldSide;
       
       int lives =  WorldOld[left][j]+WorldOld[right][j]+WorldOld[i][up]+WorldOld[i][dw]        
                // corners:
                + (withM ?
                + WorldOld[left][up]+WorldOld[right][up]+WorldOld[left][dw]+WorldOld[right][dw]
                : 0 ); //sum of living neighbors = sum of states of neighbors (states 0 and 1 only)
       
       // Implementation of the rule  
       int State=WorldOld[i][j];
       if(State==0)
           WorldOld[i][j]=(lives == OptN ? 1:0);
       else
           WorldOld[i][j]=(MinN <= lives && lives <=MaxN ? 1:0 ); //New state 
         
       if(State!=WorldOld[i][j]) WorldNew[i][j]=-1; //Force painting changed points.
       
       if(WorldOld[i][j]>0) liveCounter++; //Calculating the only statistic
   }
}

// https://github->com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/
///data/wb/SCC/public/Processing2C/scripts did it

