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
      //...A PLACE FOR YOUR AGENT INITIALIZATION CODE, e.g. curr.initialise();
      agents[a][b]=curr;
    }
}
//OR
void initializeAgents(Agent[] agents)
{
  for(int a=0;a<agents.length;a++)
  if(random(1)<density)
  {
    Agent curr=new Agent();
    //...A PLACE FOR YOUR AGENT INITIALIZATION CODE, e.g. curr.initialise();
    agents[a]=curr;
  }
}

void  dummyChangeAgents(Agent[] agents) //to be changed to agentsChange()
{
  int MC=agents.length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length);
    if(agents[a]!= null )
      agents[a].dummy+=random(-0.1,0.1); //EXAMPLE AGENT STATE CHANGE
  }  
}
//OR
void  dummyChangeAgents(Agent[][] agents) //to be changed to agentsChange()
{
  int MC=agents.length*agents[0].length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length);
    int b=(int)random(0,agents[a].length);
    if(agents[a][b]!= null )
      agents[a][b].dummy+=random(-0.1,0.1); //EXAMPLE AGENT STATE CHANGE
  }
}

//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: BASIC INITIALISATION & EVERY STEP CHANGE
//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
