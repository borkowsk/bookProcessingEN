/** Sakoda inspired asynchronous AGENT BASE MODEL 
    which utilizes 1D or 2D dicrete geometry
// https://github.com/borkowsk/bookProcessingEN
   Agent is a one of two central class of each ABM model.  
   Agents need to be initialised & they need logic of change 
   HERE ARE 1D alternatives of main procedures
   
               We're using function overload!
*/

void initializeAgents(Agent[] agents)
{
  for(int a=0;a<agents.length;a++)
  if(random(1.0)<density)
  {
    Agent curr=new Agent();
    //... Ability to change agent properties
    agents[a]=curr;
  }
}

void visualizeAgents(Agent[] agents)
{
   Agent curra;
   for(int a=0;a<agents.length;a++)
   {
    // Drawing the agent only when it is in this array cell   
    if( (curra=agents[a]) != null )
    {
        if(curra.stress>0)
          stroke(curra.stress*255,0,curra.stress*255);
        else
          noStroke();
           
        float forFill=(curra.identity*255.0)/Number_of_identities;
        fill(forFill,forFill,0);
    }
    else //otherwise bacground only
    {
      noStroke();
      fill(128);
    }
    
    int t=int(TheWorld.getTimeStep()/STEPSperVIS)%side; //We take into account different visualization frequencies
    rect(a*cwidth,t*cwidth,cwidth,cwidth);              //Whether full or empty, the same area is painted over
    stroke(255);
    line(0,(t+1)*cwidth+1,width,(t+1)*cwidth+1); //line of the current time
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
      // Sprawdzenie stresu
      int strangers=0;
      
      if(0<=a-1 && agents[a-1]!=null 
      && agents[a-1].identity!=agents[a].identity)
        strangers++;
        
      if(a+1<agents.length && agents[a+1]!=null 
      && agents[a+1].identity!=agents[a].identity)
        strangers++;  
        
      agents[a].stress=strangers/2.0; //Only two possible neighbors  
      
      // Attempting to migrate when the agent is under stress
      if(agents[a].stress>0 
      && random(1.0)<agents[a].stress)
      { //An index draw for the moving destination
        int target=(int)random(0,agents.length);
        if(agents[target]==null)//is there a place
        {
          agents[target]=agents[a];
          agents[a]=null;
        }
      }
    }
  }  
}


//*/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE: 
//  1D BASIC INITIALISATION, STEP CHANGE & VISUALISATION
//*/////////////////////////////////////////////////////////////////////////////////////////
