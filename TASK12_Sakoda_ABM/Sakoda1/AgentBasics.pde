/// Agent is a one of two central class of each ABM model
/// Agent need to be initialised & they need logic of change 
//*/////////////////////////////////////////////////////////////

void initializeAgents(Agent[][] agents)
{
   for(int a=0;a<agents.length;a++)
    for(int b=0;b<agents[a].length;b++)
    if(random(1)<density)
    {
      Agent curr=new Agent();
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
    agents[a]=curr;
  }
}

void  changeAgents(Agent[] agents)
{
  int MC=agents.length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length);
    if(agents[a]!= null )
    {
      // Stress check
      int strangers=0;
      if(0<a-1 && agents[a-1]!=null 
      && agents[a-1].identity!=agents[a].identity)
        strangers++;
      if(a+1<agents.length && agents[a+1]!=null 
      && agents[a+1].identity!=agents[a].identity)
        strangers++;  
      agents[a].stress=strangers/2.0;  
      
      // Attempting migration when stress takes its toll
      if(agents[a].stress>0 
      && random(1)<agents[a].stress)
      {
        int target=(int)random(0,agents.length);
        if(agents[target]==null) //Is there any space here?
        {
          agents[target]=agents[a]; //moving to a new place
          agents[a]=null; //Deregistration from the previous place
        }
      }
    }
  }  
}
//OR
void  changeAgents(Agent[][] agents)
{
  int MC=agents.length*agents[0].length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length);
    int b=(int)random(0,agents[a].length);
    if(agents[a][b]!= null )
    {
      // Stress check
      int strangers=0;
      if(0<a-1 && agents[a-1][b]!=null 
      && agents[a-1][b].identity!=agents[a][b].identity)
        strangers++;
        
      if(a+1<agents.length && agents[a+1][b]!=null 
      && agents[a+1][b].identity!=agents[a][b].identity)
        strangers++;  
        
      if(0<b-1 && agents[a][b-1]!=null 
      && agents[a][b-1].identity!=agents[a][b].identity)
        strangers++;
        
      if(b+1<agents.length && agents[a][b+1]!=null 
      && agents[a][b+1].identity!=agents[a][b].identity)
        strangers++;  
      
      agents[a][b].stress=strangers/4.0;  
      
      // Attempting migration when stress takes its toll
      if(agents[a][b].stress>0 
      && random(1)<agents[a][b].stress)
      {
        int tara=(int)random(0,agents.length);
        int tarb=(int)random(0,agents[a].length);
        
        if(agents[tara][tarb]==null) //Is there any space here?
        {
          agents[tara][tarb]=agents[a][b]; //moving to a new place
          agents[a][b]=null; //Deregistration from the previous place
        }
      }
    }
  }
}

//*//////////////////////////////////////////////////////////////////////////////////////////////////////////
// BASIC INITIALISATION & EVERY STEP CHANGE
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM EXAMPLE 
/// @date 2026 ( → https://github.com/borkowsk/bookProcessingEN 
//*//////////////////////////////////////////////////////////////////////////////////////////////////////////
