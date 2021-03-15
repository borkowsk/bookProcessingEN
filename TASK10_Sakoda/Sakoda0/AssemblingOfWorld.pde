// World is a one of two central class of each ABM model
///////////////////////////////////////////////////////////////
int StepCounter=0;

class World
{
  //Agent agents[];//One dimensional array of agents OR ...
  Agent agents[][];//Two dimensional array of agents
  
  World(int side)//Constructor of the World
  {
    //agents=new Agent[side]; //OR
    agents=new Agent[side][side];
  }
  
  void initializeModel()//Method 1
  {
    initializeAgents(this.agents);
  }
  
  void changeState()//Method 2
  {
    changeAgents(this.agents);
  }
};

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
   StepCounter++;
}

///////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
///////////////////////////////////////////////////////////////////////////////////////////////
