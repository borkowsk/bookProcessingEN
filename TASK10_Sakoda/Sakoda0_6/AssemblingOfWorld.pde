// World is a one of two central class of each ABM model
///////////////////////////////////////////////////////////////

class World implements simulation_world
{
  int _counter=0;// the '_' character at the beginning 
      //is the conventional designation of "internal" names 
  
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
  
  //We postpone real implementations for later and, 
  //most importantly, for other files !!!
  
  void initializeModel()//Method 1
  { //The appropriate overloaded function will be selected 
    //based on the agent table type!
    initializeAgents(this.agents);
    
    makeStatistics();//First attempt to calculate & write staistics
  }
  
  void changeState()//Method 2
  { //The function corresponding to the type of the array 
    changeAgents(this.agents);//... will be selected here
  }
  
  void makeStatistics()
  {  
    doStatisticsOnAgents(this.agents);//The function corresponding to the type of the array
    saveStatistics();
  }
  
  void modelFullStep()
  {
     changeState(); 

     //Other changes...
     //...inenviroment for example
     
     _counter++;
     makeStatistics();//Calculating & writing
  }
};

//More elaborated functionalities may be defined as stand-alone functions,
//not as methods because of not enought flexible syntax of Processing
///////////////////////////////////////////////////////////////////////////

void visualizeModel(World world)
{
   visualizeAgents(world.agents);
   //...//& others things 
}

///////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
///////////////////////////////////////////////////////////////////////////////////////////////
