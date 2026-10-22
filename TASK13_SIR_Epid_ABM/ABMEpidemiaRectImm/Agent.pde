// An agent is one of the two central classes in any ABM model.
//-/////////////////////////////////////////////////////////////
class Agent
{
  //float dummy; //DEMONSTRATIVE ATTRIBUTE - CAN BE REMOVED THEN
  //NOWY KOD
  int   state;
  float immunity;
  
  Agent() //Agent constructor. Initializes attributes
  {
    //dummy=0;
    //NOWY KOD
    state=Susceptible;
    immunity=random(0.0,1.0); //InsteadPTransfer!
  }
}

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: AGENT FOR FILL UP
//-/////////////////////////////////////////////////////////////////////////////////////////
