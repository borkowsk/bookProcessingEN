// The world is one of the two central classes of every ABM model
//-/////////////////////////////////////////////////////////////
int StepCounter=0;

class World
{
  //Agent agents[]; //One-dimensional array of agents
  //OR
  Agent agents[][]; //Two-dimensional array of agents
  
  World(int side) //Constructor for the "World" object
  {
    //agents=new Agent[side];
    //OR
    agents=new Agent[side][side];
  }
}

// More extensive functionalities are defined as standalone functions,
// ... not as methods, due to Processing’s insufficiently flexible syntax
//-/////////////////////////////////////////////////////////////////////////////

void initializeModel(World world)
{
  initializeAgents(world.agents);
}

void visualizeModel(World world)
{
  visualizeAgents(world.agents);
}

void dummyChange(World world) //Remove once the actual SIMULATION is defined.
{
  dummyChangeAgents(world.agents);
}

void modelStep(World world)
{
   //Dummy part
   dummyChange(world);
   //OR
   //... prepare a real-world simulation using agents... THIS PART IS FOR YOU!
   
   StepCounter++;
}

//-/////////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM: WORLD OF AGENTS FOR FILL UP
//-/////////////////////////////////////////////////////////////////////////////////////////////
