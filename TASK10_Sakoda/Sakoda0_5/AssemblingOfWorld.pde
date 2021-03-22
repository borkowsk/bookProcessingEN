// World is a one of two central class of each ABM model
///////////////////////////////////////////////////////////////

class World implements simulation_world
{
  int _counter=0;//znak '_' jest konwencjonalnym oznaczeniem nazw "wewnętrznych"
  
  //Agent agents[];//One dimensional array of agents OR ...
  Agent agents[][];//Two dimensional array of agents
  
  World(int side)//Constructor of the World
  {
    //agents=new Agent[side]; //OR
    agents=new Agent[side][side];
  }
  
  float  getTimeStep() //"Getter" for simulation step
  {
    return _counter;
  }
  
  void initializeModel()//Method 1
  {
    initializeAgents(this.agents);
  }
  
  void changeState()//Method 2
  {
    changeAgents(this.agents);
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
};

//For statistics
float meanStress=0;
int   liveCount=0;

//More alaborated functionalities may be defined as stand-alone functions,
//not as methods because of not enought flexible syntax of Processing
///////////////////////////////////////////////////////////////////////////

void visualizeModel(World world)
{
   visualizeAgents(world.agents);
}

void modelStep(World world)
{
   world.changeState();   
   world.makeStatistics();
   world._counter++;//Using of internal field!!! Processing allow it, but it is "bad practice".
}

///////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
///////////////////////////////////////////////////////////////////////////////////////////////
