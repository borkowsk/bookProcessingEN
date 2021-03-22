// World is a one of two central class of each ABM model
///////////////////////////////////////////////////////////////

class World //implements simulation_world
{
  int StepCounter=0;//Gdybyśmy mieli więcej światów to każdy musi mieć własny licznik czasu!
  
  Agent agents[][];//Dwuwymiarowa tablica agentów 
                   //Ale mogłaby być jednowymiarowa
                   //Albo heksagonalna
  
  World(int side)//Constructor of the World
  {
    agents=new Agent[side][side];
  }
  
  float  getTimeStep() //"Getter" for simulation step
  {
    return StepCounter;
  }
  
  void initializeModel()//Method 1
  {
    initializeAgents(this.agents);
    //other initialisations
    //...
  }
  
  void changeState()//Method 2
  {
    changeAgents(this.agents);
    //other changes
    //...
  }
  
  void makeStatistics()
  {
    //... later
  }
  
  void modelStep()//Method 3 using method 2 
  {
     this.changeState(); //'this' is redundant here. For examples only.
     this.makeStatistics();
     
     //Other changes...
     //...
     
     StepCounter++;
  }
};

//More elaborated functionalities may be defined as stand-alone functions,
//not as methods because of not enought flexible syntax of Processing
///////////////////////////////////////////////////////////////////////////

void visualizeModel(World world)
{
   visualizeAgents(world.agents);
   //Other visualisations
   //...
}

///////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
///////////////////////////////////////////////////////////////////////////////////////////////
