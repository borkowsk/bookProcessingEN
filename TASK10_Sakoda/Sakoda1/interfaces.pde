// World of simuliation interface - expected methods
////////////////////////////////////////////////////////////////////

interface simulation_world
{
  void   initializeModel();
  void   changeState();
  void   makeStatistics();
  void   modelFullStep();
  float  getTimeStep();
};

///////////////////////////////////////////////////////////////////
// https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM
// https://github.com/borkowsk/bookProcessingEN
///////////////////////////////////////////////////////////////////
