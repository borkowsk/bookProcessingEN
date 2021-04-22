/** World is a one of two central class of each ABM model
///////////////////////////////////////////////////////////////
  In this version, instead of directly implementing the content 
  of the methods, we put calls to normal procedures there.
  This is the only way in Processing that the method implementation 
  could be in a different tab - another code module. 
  By the way, you can thus benefit from function overloading and 
  place calls to other simulation layers - e.g. environment resources.
*/

class World //implements simulation_world
{
  int StepCounter=0;//If we had more worlds, 
      //each one must have their own timer!
      
  Agent agents[][];//Two-dimensional array of agents
                   //But it could be one-dimensional,
                   //Or even hexagonal!
  
  World(int side)//Constructor of the World
  {
    agents=new Agent[side][side];//We guarantee the creation 
                                 //of an array. Empty for now!
  }
  
  float  getTimeStep() //"Getter" for simulation step
  {      //Would be required by the interface.
    return StepCounter;
  }
  
  void initializeModel()//Method 1
  {
    initializeAgents(this.agents);
    //... //Other initializations if there was anything but agents.
  }
  
  void changeState()//Method 2
  {
    changeAgents(this.agents);
    //... //other changes if there was anything but agents.
  }
  
  void makeStatistics()
  {
    //... later on
  }
  
  void modelStep()//Method 3 using method 2 
  {
     this.changeState(); //'this' is redundant here. For example only.
     
     //Other every step actions
     makeStatistics(); //here without 'this'
     
     StepCounter++;
  }
  
};

//More alaborated functionalities may be defined as stand-alone functions
///////////////////////////////////////////////////////////////////////////

void visualizeModel(World world)
{
   visualizeAgents(world.agents);
   //Other visualisations
   //... // if there was anything but agents.
         // Enviroment for example.
}

///////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
//  https://github.com/borkowsk/bookProcessingEN
///////////////////////////////////////////////////////////////////////////////////////////////
