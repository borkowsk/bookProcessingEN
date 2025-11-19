//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: ModelStats.pde
#include "processing_consts.hpp"
#include "processing_templates.hpp"
#include "processing_library.hpp"
#include "processing_inlines.hpp" //...is optional. Use when project is already compilable!
#include "processing_window.hpp"
#include "processing_string.hpp"  //Processing::String class
#include "processing_console.hpp"   //...is optional. Should be deleted when not needed.
#include "processing_files.hpp" //...is optional. Should be deleted when not needed.
#include "project.h" //...is for you. Could be deleted when not needed.
using namespace Processing;
#include "local.h"
//==================================================================================

/// Simulation have to collect and write down statistics from every step
//*/////////////////////////////////////////////////////////////////////////////////////

PrintWriter outstat;           ///< globally visible handle to output file

void initializeStats()         ///< global function
{
  String FileName=modelName+=String("_s")+side+String("d")+density+String("i")+Number_of_identities
                           +String("_")+year()+String('.')+nf(month(),2)+String('.')+nf(day(),2)
                           +String('.')+nf(hour(),2)+String('.')+nf(minute(),2)+String('.')+nf(second(),2)
                           +String('.')+millis();
  println("Output in file:",FileName);
  outstat=createWriter(FileName+ String(".out"));
  println(outstat,"$STEP\tAlive\tStress\t..."); //<-- complete the header fields!
}

float meanStress=0;          ///< global statistic
int   liveCount=0;           ///< global stat.

void doStatisticsOnAgents(sarray<pAgent> agents)           ///< global function
{  
  pAgent curra;
  double summ=0;
  liveCount=0;
  
  for(int a=0;a<agents->length;a++)
    if( (curra=agents[a]) != nullptr )
    {
      summ+=curra->stress;
     
      //Inne statystyki
      //TODO
       
      liveCount++;
    }
  
   if(outstat!=nullptr)
      println(outstat,TheWorld->getTimeStep()+ String("\t")
                      +liveCount+String("\t")+(summ/liveCount)+ String("\t...")); //<-- complete the fields!
   
   meanStress=(float)(summ/liveCount);
   
   //outstat should be closed in exit() --> see Exit->pde
}

void doStatisticsOnAgents(smatrix<pAgent> agents)           ///< global function
{  
  pAgent curra;
  double summ=0;
  liveCount=0;
  
  for(int a=0;a<agents->length;a++)
   for(int b=0;b<agents[a]->length;b++)
    if( (curra=agents[a][b]) != nullptr )
    {
      summ+=curra->stress;
     
      //Inne statystyki
      //TODO
      
      liveCount++;
    }
  
   if(outstat!=nullptr)
      println(outstat,TheWorld->getTimeStep()+String("\t")+liveCount+String("\t")+(summ/liveCount)+ String("\t..."));
   
   meanStress=(float)(summ/liveCount);
   
   //outstat should be closed in exit() --> see RTMExit->pde
}

//*/////////////////////////////////////////////////////////////////////////////////////////
// https://www->researchgate->net/profile/WOJCIECH_BORKOWSKI - ABM: STATISTICS LOG TEMPLATE
// https://github->com/borkowsk/bookProcessingEN 
//*/////////////////////////////////////////////////////////////////////////////////////////
///data/wb/SCC/public/Processing2C/scripts did it

