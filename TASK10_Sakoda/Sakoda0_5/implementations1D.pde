// Agent is a one of two central class of each ABM model
// Agents need to be initialised & they need logic of change 
// HERE ARE 1D alternatives of main procedures
///////////////////////////////////////////////////////////////

void initializeAgents(Agent[] agents)
{
  for(int a=0;a<agents.length;a++)
  if(random(1.0)<density)
  {
    Agent curr=new Agent();
    agents[a]=curr;
  }
}

void visualizeAgents(Agent[] agents)
{
   Agent curra;
   for(int a=0;a<agents.length;a++)
   {
    //Colorisation    
    if( (curra=agents[a]) != null )
    {
        if(curra.stress>0)
          stroke(curra.stress*255,0,curra.stress*255);
        else
          noStroke();
           
        float forFill=(curra.identity*255.0)/Number_of_identities;
        fill(forFill,forFill,0);
    }
    else
    {
      noStroke();
      fill(128);
    }
    
    int t=int(TheWorld.getTimeStep()/STEPSperVIS)%side;//Uwzględniamy różne częstości wizualizacji
    rect(a*cwidth,t*cwidth,cwidth,cwidth);
    stroke(255);
    line(0,(t+1)*cwidth+1,width,(t+1)*cwidth+1);
   }
}

void  changeAgents(Agent[] agents)
{
  int MCN=agents.length;
  for(int i=0;i<MCN;i++)
  {
    int a=(int)random(0,agents.length);
    
    if(agents[a]!= null )
    {
      //Sprawdzenie stresu
      int strangers=0;
      
      if(0<a-1 && agents[a-1]!=null 
      && agents[a-1].identity!=agents[a].identity)
        strangers++;
        
      if(a+1<agents.length && agents[a+1]!=null 
      && agents[a+1].identity!=agents[a].identity)
        strangers++;  
        
      agents[a].stress=strangers/2.0;  
      
      //Próba migracji gdy stres doskwiera
      if(agents[a].stress>0 
      && random(1.0)<agents[a].stress)
      {
        int target=(int)random(0,agents.length);
        if(agents[target]==null)//Jest miejsce
        {
          agents[target]=agents[a];//Przeprowadzka
          agents[a]=null;//Wymeldowanie ze starego miejsca
        }
      }
    }
  }  
}

void doStatisticsOnAgents(Agent[] agents)
{  
  Agent curra;
  double summ=0;
  liveCount=0;
  
  for(int a=0;a<agents.length;a++)
    if( (curra=agents[a]) != null )
    {
      summ+=curra.stress;
     
      //Inne statystyki
      //TODO
      //...
      
      liveCount++;
    }
     
   meanStress=(float)(summ/liveCount);
}

///////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE: 
//  1D BASIC INITIALISATION, STEP CHANGE & VISUALISATION
///////////////////////////////////////////////////////////////////////////////////////////
