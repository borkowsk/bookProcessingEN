//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: AgentBasics.pde
#include "processing_consts.hpp"
#include "processing_templates.hpp"
#include "processing_library.hpp"
#include "processing_inlines.hpp" //...is optional. Use when project is already compilable!
#include "processing_window.hpp"
#include "project.h" //...is for you. Could be deleted when not needed.
using namespace Processing;
#include "local.h"
//==================================================================================

/// Agent is a one of two central class of each ABM model
/// Agent need to be initialised & they need logic of change 
//*/////////////////////////////////////////////////////////////

void initializeAgents(smatrix<pAgent> agents)           ///< global function
{
   for(int a=0;a<agents->length;a++)
    for(int b=0;b<agents[a]->length;b++)
    if(random(1)<density)
    {
      pAgent curr=new Agent();
      agents[a][b]=curr;
    }
}
//OR
void initializeAgents(sarray<pAgent> agents)           ///< global function
{
  for(int a=0;a<agents->length;a++)
  if(random(1)<density)
  {
    pAgent curr=new Agent();
    agents[a]=curr;
  }
}

void  changeAgents(sarray<pAgent> agents)           ///< global function
{
  int MC=agents->length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents->length);
    if(agents[a]!= nullptr )
    {
      // Sprawdzenie stresu
      int strangers=0;
      if(0<a-1 && agents[a-1]!=nullptr 
      && agents[a-1]->identity!=agents[a]->identity)
        strangers++;
      if(a+1<agents->length && agents[a+1]!=nullptr 
      && agents[a+1]->identity!=agents[a]->identity)
        strangers++;  
      agents[a]->stress=strangers/2.0;  
      
      // Próba migracji gdy stres doskwiera
      if(agents[a]->stress>0 
      && random(1)<agents[a]->stress)
      {
        int target=(int)random(0,agents->length);
        if(agents[target]==nullptr) //Jest miejsce
        {
          agents[target]=agents[a]; //Przeprowadzka
          agents[a]=nullptr; //Wymeldowanie ze starego miejsca
        }
      }
    }
  }  
}
//OR
void  changeAgents(smatrix<pAgent> agents)           ///< global function
{
  int MC=agents->length*agents[0]->length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents->length);
    int b=(int)random(0,agents[a]->length);
    if(agents[a][b]!= nullptr )
    {
      // Sprawdzenie stresu
      int strangers=0;
      if(0<a-1 && agents[a-1][b]!=nullptr 
      && agents[a-1][b]->identity!=agents[a][b]->identity)
        strangers++;
        
      if(a+1<agents->length && agents[a+1][b]!=nullptr 
      && agents[a+1][b]->identity!=agents[a][b]->identity)
        strangers++;  
        
      if(0<b-1 && agents[a][b-1]!=nullptr 
      && agents[a][b-1]->identity!=agents[a][b]->identity)
        strangers++;
        
      if(b+1<agents->length && agents[a][b+1]!=nullptr 
      && agents[a][b+1]->identity!=agents[a][b]->identity)
        strangers++;  
      
      agents[a][b]->stress=strangers/4.0;  
      
      // Próba migracji gdy stres doskwiera
      if(agents[a][b]->stress>0 
      && random(1)<agents[a][b]->stress)
      {
        int tara=(int)random(0,agents->length);
        int tarb=(int)random(0,agents[a]->length);
        
        if(agents[tara][tarb]==nullptr) //Jest miejsce
        {
          agents[tara][tarb]=agents[a][b]; //Przeprowadzka
          agents[a][b]=nullptr; //Wymeldowanie ze starego miejsca
        }
      }
    }
  }
}

//*//////////////////////////////////////////////////////////////////////////////////////////////////////////
// BASIC INITIALISATION & EVERY STEP CHANGE
// https://www->researchgate->net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE 
// https://github->com/borkowsk/bookProcessingEN 
//*//////////////////////////////////////////////////////////////////////////////////////////////////////////
///data/wb/SCC/public/Processing2C/scripts did it

