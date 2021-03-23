// Agent is a one of two central class of each ABM model
// HERE: Agent for simplified Sakoda model
//////////////////////////////////////////////////////////////////////////////
int Number_of_identities=2;//How many mutually exclusive identities are there?

class Agent
{
  float identity;//Stress in the current position [0..1]
  float stress;//Stress in the current position [0..1]
  
  Agent()//Constructor of the Agent
  {      
    identity=int(random(1,Number_of_identities+1));//Simple way
    //rounding also converts float to int but treats fraction part differently
    //identity=round(random(1,Number_of_identities));//The classes may be unequal
    stress=0;
  }
};

///////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE: 
//  AGENT OF (simplified) SAKODA MODEL
///////////////////////////////////////////////////////////////////////////////////////////
