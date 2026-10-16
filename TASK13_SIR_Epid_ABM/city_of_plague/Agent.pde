// Agent jest jedną z dwóch centralnych klas każdego modelu ABM
//-/////////////////////////////////////////////////////////////

class Agent
{
  int   state;
  float immunity; //Zamiast PTransfer!
  
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
              +random(1.0)+random(1.0)+random(1.0) )/6.0; //Średnia 0.5
             //random(1.0); //Średnia taka sama, ale rozkład płaski
  }
}

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: AGENT FOR FILL UP
//-/////////////////////////////////////////////////////////////////////////////////////////
