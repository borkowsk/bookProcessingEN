// An agent is one of the two central classes in any ABM model.
//-/////////////////////////////////////////////////////////////
class Agent
{
  int   state;
  float immunity; //InsteadPTransfer!
  
  Agent() //Agent constructor. Initializes attributes
  {
    state=Susceptible;
    immunity=( random(1.0)+random(1.0)+random(1.0)
              +random(1.0)+random(1.0)+random(1.0) )/6.0; //Mean 0.5
             //random(1.0); //The mean is the same, but the distribution is flat
  }
}

//-///////////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM: AGENT FOR FILL UP
/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
//-///////////////////////////////////////////////////////////////////////////////////////////////
