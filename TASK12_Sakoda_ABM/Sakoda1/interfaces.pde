/// World of simulation interface - expected methods
//-//////////////////////////////////////////////////////////////////

interface simulation_world
{
  void   initializeModel();
  void   changeState();
  void   makeStatistics();
  void   modelFullStep();
  float  getTimeStep();
};

//-/////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM
/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
//-/////////////////////////////////////////////////////////////////
