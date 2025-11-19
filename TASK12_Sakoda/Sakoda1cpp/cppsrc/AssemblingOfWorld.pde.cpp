//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: AssemblingOfWorld.pde
#include "processing_consts.hpp"
#include "processing_templates.hpp"
#include "processing_library.hpp"
#include "processing_inlines.hpp" //...is optional. Use when project is already compilable!
#include "processing_window.hpp"
#include "project.h" //...is for you. Could be deleted when not needed.
using namespace Processing;
#include "local.h"
//==================================================================================

/// World is a one of two central class of each ABM model
//*/////////////////////////////////////////////////////////////

class World : public virtual simulation_world , public virtual Object{
  public:
  
  int _counter=0;   //!< steps counter
  
  //Agent sarray<pagents>; //!< One dimensional array of agents
  //OR
  Agent smatrix<pagents>; //!< Two dimensional array of agents
  
  World(int side) //!< Constructor of the World
  {
    //agents=new array<pAgent>(side);
    //OR
    agents=new matrix<pAgent>(side,side);
  }
   
  float  getTimeStep() //!< "Getter" for simulation step
  {
    return _counter;
  }
  
  //Here, we postpone real implementations for later and, 
  //most importantly, for other files !!!
  
  void initializeModel()
  {
    initializeAgents(this->agents);
    //other initialisations
    //...
  }
  
  void changeState()
  {
    changeAgents(this->agents);
    //other changes
    //...
  }
  
  void makeStatistics()
  {
    doStatisticsOnAgents(this->agents);
  }
  
  void modelFullStep()
  {
     this->changeState(); //'this' is redundant here. For examples only.
     this->makeStatistics();
     
     //Other changes...
     //...
     
     _counter++;
  }
  
}

/// More alaborated functionalities are defined as stand-alone functions,
/// not as methods because of not enought flexible syntax of Processing
//*/////////////////////////////////////////////////////////////////////////

void visualizeModel(pWorld world)           ///< global function
{
  visualizeAgents(world->agents);
}

//*/////////////////////////////////////////////////////////////////////////////////////////////
// https://www->researchgate->net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
// https://github->com/borkowsk/bookProcessingEN
//*/////////////////////////////////////////////////////////////////////////////////////////////
///data/wb/SCC/public/Processing2C/scripts did it

