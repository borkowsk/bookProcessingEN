// An agent is one of the two central classes in any ABM model.
//-/////////////////////////////////////////////////////////////

class Agent
{
  int   state;
  float immunity; //InsteadPTransfer!
  
  //Położenie komórek zamieszkania i pracy
  int   flatX;
  int   flatY;
  int   workX;
  int   workY;
  
  Agent(int initX,int initY) //Konstruktor agenta. Podajemy "adres zamieszkania" 
  {
    flatX=workX=initX;
    flatY=workY=initY; //"workX|Y" mоże zostać sensowniej przypisane później.
    
    state=Susceptible;
    immunity=( random(1.0)+random(1.0)+random(1.0)
              +random(1.0)+random(1.0)+random(1.0) )/6.0; //Mean 0.5
             //random(1.0); //The mean is the same, but the distribution is flat
  }
}

//-/////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM: AGENT FOR FILL UP
//-/////////////////////////////////////////////////////////////////////////////////////////
