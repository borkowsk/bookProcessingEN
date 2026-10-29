// The world is one of the two central classes of every ABM model
//-/////////////////////////////////////////////////////////////
int StepCounter=0; //GLOBAL SIMULATION STEP COUNTER

class World
{
  //Agent agents[]; //ONE-DIMENSIONAL AGENT TABLE
  //OR
  Agent agents[][]; //TWO-DIMENSIONAL AGENT TABLE
  
  World(int side) //CONSTRUCTION OF THE WORLD
  {
    //agents=new Agent[side];
    //OR
    agents=new Agent[side][2*side];
  }
}

//MORE COMPLEX FUNCTIONALITIES ARE DEFINED AS SEPARATE FUNCTIONS RATHER THAN CLASS METHODS World
//DUE TO PROCESSING SYNTAX LIMITATIONS
//WHICH DOESN'T ALLOW YOU TO HIDE LESS IMPORTANT CLASS METHODS SOMEWHERE ELSE
//-//////////////////////////////////////////////////////////////////////////

void initializeModel(World world)
{
  initializeAgents(world.agents); //THE OVERLOADED FUNCTION WILL BE SELECTED HERE!
}

void visualizeModel(World world)
{
  visualizeAgents(world.agents); //THE OVERLOADED FUNCTION WILL BE SELECTED HERE!
}

//void dummyChange(World world) //THIS FUNCTION CAN BE REMOVED WHEN
//{                             //A REAL MODEL CODE APPEARS
//  dummyChangeAgents(world.agents); //THE OVERLOADED FUNCTION WILL BE SELECTED HERE!
//}

void modelStep(World world)
{
   //dummyChange(world); //TEMPORARY USE OF TRIVIA DYNAMICS
   //OR
   //A REAL MODEL CODE APPEARS
   agentsChange(world.agents); //THE OVERLOADED FUNCTION WILL BE SELECTED HERE!
   
   StepCounter++;
}

//-/////////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM: WORLD OF AGENTS FOR FILL UP
//-/////////////////////////////////////////////////////////////////////////////////////////////
