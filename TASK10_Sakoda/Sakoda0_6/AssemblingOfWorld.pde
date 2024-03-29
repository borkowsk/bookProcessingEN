/** World is a one of two central class of each ABM model:
    World for Sakoda inspired asynchronous AGENT BASE MODEL 
    which utilizes 1D or 2D dicrete geometry
//https://github.com/borkowsk/bookProcessingEN
*/

class World implements simulation_world
{
  int _counter=0; // the '_' character at the beginning 
      //is the conventional designation of "internal" names 
  
  //Agent agents[]; //One dimensional array of agents OR ...
  Agent agents[][]; //Two dimensional array of agents
  
  /// Constructor of the World
  World(int side)
  {
    //agents=new Agent[side]; //OR
    agents=new Agent[side][side];
  }
  
  float  getTimeStep() //"Getter" for simulation step
  {
    return _counter;
  }
  
  // We postpone real implementations for later and, 
  // most importantly, for other files !!!
  
  /// Method 1.
  void initializeModel()
  { //The appropriate overloaded function will be selected 
    //based on the agent table type!
    initializeAgents(this.agents);
    
    makeStatistics(); //First attempt to calculate & write staistics
  }
  
  //Method 2.
  void changeState()
  { //The function corresponding to the type of the array 
    changeAgents(this.agents); //... will be selected here
  }
  
  void makeStatistics()
  {  
    doStatisticsOnAgents(this.agents); //The function corresponding to the type of the array
    saveStatistics();
  }
  
  void modelFullStep()
  {
     changeState(); 

     //Other changes...
     //...inenviroment for example
     
     _counter++;
     makeStatistics(); //Calculating & writing
  }
};

/// More elaborated functionalities may be defined as stand-alone functions,
/// not as methods because of not enought flexible syntax of Processing
//*/////////////////////////////////////////////////////////////////////////

void visualizeModel(World world)
{
   visualizeAgents(world.agents);
   //...//& others things 
}

//*/////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
//*/////////////////////////////////////////////////////////////////////////////////////////////
