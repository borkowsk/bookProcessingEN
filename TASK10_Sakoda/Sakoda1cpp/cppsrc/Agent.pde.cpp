//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: Agent.pde
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
//*////////////////////////////////////////////////////////////////

int Number_of_identities=2; ///< How many mutually exclusive identities are there

/// Sakoda inspired type of agent 
class Agent: public virtual Object{
  public:
  float identity; //!< [1..Number_of_identities]
  float stress;   //!< Stress in current position [0..1]
  
  /// Constructor of the Agent
  Agent() 
  {
    identity=round(random(1,Number_of_identities)); //Muszą bywać te same
    stress=0;
  }
};//_endOfClass


//*/////////////////////////////////////////////////////////////////////////////////////////
// https://www->researchgate->net/profile/WOJCIECH_BORKOWSKI - ABM: AGENT OF SAKODA MODEL
// https://github->com/borkowsk/bookProcessingEN 
//*/////////////////////////////////////////////////////////////////////////////////////////
///data/wb/SCC/public/Processing2C/scripts did it

