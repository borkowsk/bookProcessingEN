// An agent is one of the two central classes in any ABM model.
// The agent must be initialized and must have change logic
//-/////////////////////////////////////////////////////////////

void initializeAgents(Agent[][] agents)
{
   for(int a=0;a<agents.length;a++)
    for(int b=0;b<agents[a].length;b++)
      if(random(1)<density)
      {
        Agent curr=new Agent();
        //ADDITIONAL AGENT INITIALIZATION CODE, e.g. curr.initialise();
        liveCount++;
        agents[a][b]=curr;
      }
      
   //Initiating infection from the center
   if(agents[agents.length/2][agents.length/2]==null) //If he weren't here
   {
      agents[agents.length/2][agents.length/2]=new Agent();
      liveCount++;
   }
   agents[agents.length/2][agents.length/2].state=Infected;
}
//OR
void initializeAgents(Agent[] agents)
{
  for(int a=0;a<agents.length;a++)
    if(random(1)<density)
    {
      Agent curr=new Agent();
      //ADDITIONAL AGENT INITIALIZATION CODE, e.g. curr.initialise();
      liveCount++;
      agents[a]=curr;
    }
   
   //Initiating infection from the center
   if(agents[agents.length/2]==null) //If he weren't here
   {
      agents[agents.length/2]=new Agent();
      liveCount++;
   }
   
   //Initiating infection from the center
   if(agents[agents.length/2]==null) //If he weren't here
   {
      agents[agents.length/2]=new Agent();
      liveCount++;
   }
   agents[agents.length/2].state=Infected;
}

void  agentsChange(Agent[] agents) //przerobiona z dummyChangeAgents()
{
  int MC=agents.length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length);
    if(agents[a]!= null )
    {
      //agents[a].dummy+=random(-0.1,0.1); //EXAMPLE AGENT STATE CHANGE
    }
  }  
}

//OR

void  agentsChange(Agent[][] agents) //przerobiona z dummyChangeAgents()
{
  int MC=agents.length*agents[0].length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length); //agents[a].length na wypadek gdyby nam przyszło
    int b=(int)random(0,agents[a].length); // do głowy zrobić prostokąt
    if(agents[a][b]!= null )
    {
       //If the cell is empty or the agent is healthy, we do nothing
       if(agents[a][b].state<Infected || Recovered<=agents[a][b].state) 
          continue;
       
       //Calculating neighbor locations
       int dw=(a+1) % agents.length;   
       int up=(agents.length+a-1) % agents.length;
       int right = (b+1) % agents[a].length; //MOŻE BYĆ INNE NIŻ agents.length      
       int left  = (agents[a].length+b-1) % agents[a].length; //JEŚLI PROSTOKĄT

       if(agents[a][left]!=null
       && agents[a][left].state==Susceptible && random(1) < PTransfer) 
         {agents[a][left].state=Infected; sumInfected++;}
        
       if(agents[a][right]!=null
       && agents[a][right].state==Susceptible && random(1) < PTransfer) 
         {agents[a][right].state=Infected; sumInfected++;}
        
       if(agents[up][b]!=null
       && agents[up][b].state==Susceptible && random(1) < PTransfer) 
         {agents[up][b].state=Infected; sumInfected++;}
        
       if(agents[dw][b]!=null
       && agents[dw][b].state==Susceptible && random(1) < PTransfer) 
         {agents[dw][b].state=Infected; sumInfected++;}

       float prob=random(1); //Fate for the day
       
       if(prob<PDeath) //He dies on this day
        {agents[a][b]=null;sumDeath++;liveCount--;}
        else
        {
          //... or he is cured
          if(++(agents[a][b].state)==Recovered)
              sumRecovered++;
          //else //...OR STILL SUFFERING!
        }
    }
  }
}

//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: BASIC INITIALISATION & EVERY STEP CHANGE
//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
