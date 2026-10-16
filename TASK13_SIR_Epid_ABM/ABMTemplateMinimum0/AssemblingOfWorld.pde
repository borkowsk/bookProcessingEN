// Świat jest jedną z dwóch centralnych klas każdego modelu ABM
//-/////////////////////////////////////////////////////////////
int StepCounter=0;

class World
{
  //Agent agents[]; //Jednowymiarowa tablica agentów
  //OR
  Agent agents[][]; //Dwuwymiarowa tablica agentów
  
  World(int side) //Konstruktor obiektu "Świata"
  {
    //agents=new Agent[side];
    //OR
    agents=new Agent[side][side];
  }
}

// Bardziej rozbudowane funkcjonalności są definiowane jako funkcje samodzielne,
// nie jako metody z powodu niewystarczająco elastycznej składni Processingu
//-/////////////////////////////////////////////////////////////////////////////

void initializeModel(World world)
{
  initializeAgents(world.agents);
}

void visualizeModel(World world)
{
  visualizeAgents(world.agents);
}

void dummyChange(World world) //Usuń, gdy zostanie zdefiniowana prawdziwa SYMULACJA.
{
  dummyChangeAgents(world.agents);
}

void modelStep(World world)
{
   //Dummy part
   dummyChange(world);
   //OR
   //... przygotuj prawdziwą symulację na agentach... TA CZĘŚĆ JEST DLA CIEBIE!
   
   StepCounter++;
}

//-/////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF AGENTS FOR FILL UP
//-/////////////////////////////////////////////////////////////////////////////////////////////
