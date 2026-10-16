// Świat jest jedną z dwóch centralnych klas każdego modelu ABM
//-/////////////////////////////////////////////////////////////
int StepCounter=0; //GLOBALNY LICZNIK KROKÓW SYMULACJI

class World
{
  //Agent agents[]; //JEDNOWYMIAROWA TABLICA AGENTÓW
  //OR
  Agent agents[][]; //DWUWYMIAROWA TABLICA AGENTÓW
  
  World(int side) //KONSTRUKTOR ŚWIATA
  {
    //agents=new Agent[side];
    //OR
    agents=new Agent[side][2*side];
  }
}

//BARDZIEJ ZŁOŻONE FUNKCJONALNOŚCI ZOSTAŁY ZDEFINIOWANE JAKO OSOBNE FUNKCJE
//A NIE METODY KLASY World ZE WZGLĘDU NA OGRANICZENIA SKŁADNI PROCESSINGU
//NIE POZWALAJĄCEJ SCHOWAĆ GDZIEŚ INDZIEJ MNIEJ ISTOTNYCH METOD KLASY
//-/////////////////////////////////////////////////////////////////////////

void initializeModel(World world)
{
  initializeAgents(world.agents); //TU NASTĄPI WYBÓR FUNKCJI PRZECIĄŻONEJ!
}

void visualizeModel(World world)
{
  visualizeAgents(world.agents); //TU NASTĄPI WYBÓR FUNKCJI PRZECIĄŻONEJ!
}

//void dummyChange(World world) //FUNKCJĘ MOŻNA USUNĄĆ GDY POJAWI SIĘ
//{                             //REALNY KOD MODELU
//  dummyChangeAgents(world.agents); //TU NASTĄPI WYBÓR FUNKCJI PRZECIĄŻONEJ!
//}

void modelStep(World world)
{
   //dummyChange(world); //TYMCZASOWE WYWOŁANIE TRYWIALNEJ DYNAMIKI
   //OR
   //REALNY KOD MODELU
   agentsChange(world.agents); //TU NASTĄPI WYBÓR FUNKCJI PRZECIĄŻONEJ!
   
   StepCounter++;
}

//-/////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF AGENTS FOR FILL UP
//-/////////////////////////////////////////////////////////////////////////////////////////////
