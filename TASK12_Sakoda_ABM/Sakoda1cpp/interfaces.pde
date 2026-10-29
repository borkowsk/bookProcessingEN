/// World of simulation interface - expected methods
//-//////////////////////////////////////////////////////////////////

interface simulation_world
{
  /*_interfunc*/ void   initializeModel() /*_forcebody*/;
  /*_interfunc*/ void   changeState() /*_forcebody*/;
  /*_interfunc*/ void   makeStatistics() /*_forcebody*/;
  /*_interfunc*/ void   modelFullStep() /*_forcebody*/;
  /*_interfunc*/ float  getTimeStep() /*_forcebody*/;
};

//-/////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM
/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
//-/////////////////////////////////////////////////////////////////
