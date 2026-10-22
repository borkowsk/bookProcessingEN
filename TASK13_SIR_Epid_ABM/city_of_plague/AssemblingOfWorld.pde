// The world is one of the two central classes of every ABM model
//-/////////////////////////////////////////////////////////////
int StepCounter=0; //GLOBAL SIMULATION STEP COUNTER

class World
{
  Agent agents[][]; //TWO-DIMENSIONAL AGENT TABLE
  int      env[][]; //TABLICA ŚRODOWISKA - "environment"
  
  World(int side) //CONSTRUCTION OF THE WORLD
  {
    env=new int[side][2*side];
    agents=new Agent[side][2*side];
  }
}

//MORE COMPLEX FUNCTIONALITIES ARE DEFINED AS SEPARATE FUNCTIONS RATHER THAN CLASS METHODS World
//DUE TO PROCESSING SYNTAX LIMITATIONS
//WHICH DOESN'T ALLOW YOU TO HIDE LESS IMPORTANT CLASS METHODS SOMEWHERE ELSE
//-//////////////////////////////////////////////////////////////////////////

void initializeModel(World world)
{
  initializeEnv(world.env);
  initializeAgents(world.agents,world.env);
}

void visualizeModel(World world)
{
  visualizeEnv(world.env);
  visualizeAgents(world.agents);
}

void modelStep(World world)
{
   //environmentChange(world.env); //W tej symulacji na razie niepotrzebne
   agentsChange(world.agents);
   sheduleAgents(world.agents,world.env,StepCounter);
   StepCounter++;
}

//-/////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF AGENTS FOR FILL UP
//-/////////////////////////////////////////////////////////////////////////////////////////////
