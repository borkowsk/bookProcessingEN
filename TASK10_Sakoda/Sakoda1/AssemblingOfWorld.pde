// World is a one of two central class of each ABM model
///////////////////////////////////////////////////////////////


class World implements simulation_world
{
  int _counter=0;
  
  //Agent agents[];//One dimensional array of agents
  //OR
  Agent agents[][];//Two dimensional array of agents
  
  World(int side)//Constructor of the World
  {
    //agents=new Agent[side];
    //OR
    agents=new Agent[side][side];
  }
   
  float  getTimeStep() //"Getter" for simulation step
  {
    return _counter;
  }
  
  void initializeModel()
  {
    initializeAgents(this.agents);
    //other initialisations
    //...
  }
  
  void changeState()
  {
    changeAgents(this.agents);
    //other changes
    //...
  }
  
  void makeStatistics()
  {
    doStatisticsOnAgents(this.agents);
  }
  
  void modelFullStep()
  {
     this.changeState(); //'this' is redundant here. For examples only.
     this.makeStatistics();
     
     //Other changes...
     //...
     
     _counter++;
  }
  
}

//More alaborated functionalities are defined as stand-alone functions,
//not as methods because of not enought flexible syntax of Processing
///////////////////////////////////////////////////////////////////////////

void visualizeModel(World world)
{
  visualizeAgents(world.agents);
}

///////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
///////////////////////////////////////////////////////////////////////////////////////////////
