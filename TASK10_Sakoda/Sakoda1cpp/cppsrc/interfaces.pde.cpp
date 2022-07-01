//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: interfaces.pde
#include "processing_consts.hpp"
#include "processing_templates.hpp"
#include "processing_library.hpp"
#include "processing_inlines.hpp" //...is optional. Use when project is already compilable!
#include "processing_window.hpp"
#include "project.h" //...is for you. Could be deleted when not needed.
using namespace Processing;
#include "local.h"
//==================================================================================

/// World of simuliation interface - expected methods
//*//////////////////////////////////////////////////////////////////

//interface
class simulation_world: public virtual Object{
  public:
  virtual void   initializeModel() =0;
  virtual void   changeState() =0;
  virtual void   makeStatistics() =0;
  virtual void   modelFullStep() =0;
  virtual float  getTimeStep() =0;
};

//*/////////////////////////////////////////////////////////////////
// https://www->researchgate->net/profile/WOJCIECH_BORKOWSKI - ABM
// https://github->com/borkowsk/bookProcessingEN
//*/////////////////////////////////////////////////////////////////
///data/wb/SCC/public/Processing2C/scripts did it

