// Agent is a one of two central class of each ABM model
//////////////////////////////////////////////////////////////////

int Number_of_identities=3;//How many mutually exclusive identities will be?

class Agent
{
  float identity;//Stress in the current position [0..1]
  float stress;//Stress in the current position [0..1]
  
  Agent()//Constructor of the Agent
  {
    //rounding also converts float to int but treats fractions differently
    identity=round(random(1,Number_of_identities));
    stress=0;
  }
};

///////////////////////////////////////////////////////////////////////////////////////////  
// AGENT OF SAKODA MODE
// https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE: 
// https://github.com/borkowsk/bookProcessingEN 
///////////////////////////////////////////////////////////////////////////////////////////
