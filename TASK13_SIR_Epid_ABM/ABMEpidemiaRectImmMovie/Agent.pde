// An agent is one of the two central classes in any ABM model.
//-/////////////////////////////////////////////////////////////
class Agent
{
  int   state;
  float immunity; //Instead PTransfer!
  
  Agent() //Agent constructor. Initializes attributes
  {
    state=Susceptible;
    immunity=( random(1.0)+random(1.0)+random(1.0)
              +random(1.0)+random(1.0)+random(1.0) )/6.0; //Average 0.5
             //random(1.0); //The mean is the same, but the distribution is flat
  }
}

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: AGENT FOR FILL UP
//-/////////////////////////////////////////////////////////////////////////////////////////
