// Agent is a one of two central class of each ABM model
// Agents need to be initialised & they need logic of change 
// HERE ARE 1D alternatives of main procedures
///////////////////////////////////////////////////////////////

void initializeAgents(Agent[][] agents)
{
   for(int a=0;a<agents.length;a++)
    for(int b=0;b<agents[a].length;b++)
    if(random(1.0)<density)
    {
      Agent curr=new Agent();
      agents[a][b]=curr;
    }
}

void visualizeAgents(Agent[][] agents)
{
  Agent curra;
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
   {
      //Background
      noStroke();fill(200);//Lepiej dopasowa tło
      rect(b*cwidth,a*cwidth,cwidth,cwidth);//'a' is vertical!
      
      //Colorisation of agent
      if( (curra=agents[a][b]) != null )
      {
        if(curra.stress>0)
          stroke(curra.stress*255,0,curra.stress*255);
        else
          noStroke();
           
        float forFill=(curra.identity*255.0)/Number_of_identities;
        fill(forFill,forFill,0);
        ellipse(b*cwidth,a*cwidth,cwidth,cwidth);
      }  
   }
}

void  changeAgents(Agent[][] agents)
{
  int MCN=agents.length*agents[0].length;
  for(int i=0;i<MCN;i++)
  {
    int a=(int)random(0,agents.length);
    int b=(int)random(0,agents[a].length);
    
    if(agents[a][b]!= null )
    {
      //Sprawdzenie stresu
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
      
      agents[a][b].stress=strangers/4.0;//von Neumann neib.  
      
      //Próba migracji gdy stres doskwiera
      if(agents[a][b].stress>0 
      && random(1.0)<agents[a][b].stress)
      {
        int tara=(int)random(0,agents.length);
        int tarb=(int)random(0,agents[a].length);
        
        if(agents[tara][tarb]==null)//Jest miejsce
        {
          agents[tara][tarb]=agents[a][b];//Przeprowadzka
          agents[a][b]=null;//Wymeldowanie ze starego miejsca
        }
      }
    }
  }
}

void doStatisticsOnAgents(Agent[][] agents)
{  
  Agent curra;
  double summ=0;
  liveCount=0;
  
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
    if( (curra=agents[a][b]) != null )
    {
      summ+=curra.stress;
     
      //Inne statystyki
      //TODO
      
      liveCount++;
    }
     
   meanStress=(float)(summ/liveCount);
}


///////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE: 
//  2D BASIC INITIALISATION, STEP CHANGE & VISUALISATION
///////////////////////////////////////////////////////////////////////////////////////////
