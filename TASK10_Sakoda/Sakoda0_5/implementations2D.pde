// Agent is a one of two central class of each ABM model
// Agents need to be initialised & they need logic of change 
// HERE ARE 2D alternatives of main procedures
///////////////////////////////////////////////////////////////

void initializeAgents(Agent[][] agents)
{
   for(int a=0;a<agents.length;a++)
    for(int b=0;b<agents[a].length;b++)
    if(random(1.0)<density)//with some probability
    {
      Agent curr=new Agent();// We construct the agent
      agents[a][b]=curr;// ... and put it in the array
    }
}

void visualizeAgents(Agent[][] agents)
{
  Agent curra;
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
   {
      //Cell background
      noStroke();fill(200);
      rect(b*cwidth,a*cwidth,cwidth,cwidth);//'a' is vertical!
      
      //Drawing the agent only when it is in this array cell
      if( (curra=agents[a][b]) != null )
      {
        if(curra.stress>0)// Stress as the outline color
          stroke(curra.stress*255,0,curra.stress*255);
        else
          noStroke();
           
        float forFill=(curra.identity*255.0)/Number_of_identities;
        fill(forFill,forFill,0);
        ellipse(b*cwidth+cwidth/2,a*cwidth+cwidth/2,cwidth-2,cwidth-2);
      }  
   }
}

void  changeAgents(Agent[][] agents)
{
  int MCN=agents.length*agents[0].length;//number of draws in MC steps
  for(int i=0;i<MCN;i++)
  {
    int a=(int)random(0,agents.length);
    int b=(int)random(0,agents[a].length);
    
    if(agents[a][b]!= null )
    {
      //Check the stress on the agent
      int strangers=0;
      
      if(0<=a-1 && agents[a-1][b]!=null 
      && agents[a-1][b].identity!=agents[a][b].identity)
        strangers++;
        
      if(a+1<agents.length && agents[a+1][b]!=null 
      && agents[a+1][b].identity!=agents[a][b].identity)
        strangers++;  
        
      if(0<=b-1 && agents[a][b-1]!=null 
      && agents[a][b-1].identity!=agents[a][b].identity)
        strangers++;
        
      if(b+1<agents.length && agents[a][b+1]!=null 
      && agents[a][b+1].identity!=agents[a][b].identity)
        strangers++;  
      
      agents[a][b].stress=strangers/4.0;//von Neumann neib.  
      
      //Attempting to migrate when the agent is under stress
      if(agents[a][b].stress>0 
      && random(1.0)<agents[a][b].stress)
      {
        int tara=(int)random(0,agents.length);
        int tarb=(int)random(0,agents[a].length);
        
        if(agents[tara][tarb]==null)//There is an empty place
        {
          agents[tara][tarb]=agents[a][b];//Take a new place
          agents[a][b]=null;//Release the old ones
        }
      }
    }
  }
}

void doStatisticsOnAgents(Agent[][] agents)
{  
  Agent curra;//Auxiliary agent handle
  double summ=0;//Sum of stresses
  liveCount=0;//Number of agents
  
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
    if( (curra=agents[a][b]) != null )
    {
      summ+=curra.stress;//Sum of stresses
     
      //Other statistics
      //... //TODO
      
      liveCount++;//Number of agents
    }
     
   meanStress=(float)(summ/liveCount);
}


///////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE: 
//  2D BASIC INITIALISATION, STEP CHANGE & VISUALISATION
///////////////////////////////////////////////////////////////////////////////////////////
