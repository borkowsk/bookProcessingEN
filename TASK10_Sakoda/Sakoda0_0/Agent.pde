// Agent is a one of two central class of each ABM model
// HERE: Agent for simplified Sakoda model
//////////////////////////////////////////////////////////////////////////////

int Number_of_identities=3;//How many mutually exclusive identities are there?

class Agent
{
  float identity;// [1..Number_of_identities]
  float stress;//Stress in the current position [0..1]
  
  Agent()//Constructor of the Agent
  {      
    identity=int(random(1,Number_of_identities+1));//Simple way
    stress=0;
  }
};

///////////////////////////////////////////////////////////////////////////////////////////
// AGENT OF (simplified) SAKODA MODEL
// https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE 
// https://github.com/borkowsk/bookProcessingEN
///////////////////////////////////////////////////////////////////////////////////////////
