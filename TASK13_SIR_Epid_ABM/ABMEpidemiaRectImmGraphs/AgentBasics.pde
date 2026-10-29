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
   agents[agents.length/2].state=Infected;
}

void  agentsChange(Agent[] agents) //to be changed to agentsChange()
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

void  agentsChange(Agent[][] agents)
{
  //We store the state before the step
  int befInfected=sumInfected;
  int befRecovered=sumRecovered;
  int befDeath=sumDeath;
  
  int MC=agents.length*agents[0].length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length);   //or "agents[a].length" in case we want to make a rectangle
    int b=(int)random(0,agents[a].length); //print(a,b,' '); DEBUG
    if(agents[a][b]!= null )
    {
       //If the cell is empty or the agent is healthy, we do nothing
       if(agents[a][b].state<Infected || Recovered<=agents[a][b].state) continue;
       
       //Calculating neighbor locations
       int dw=(a+1) % agents.length;   
       int up=(agents.length+a-1) % agents.length;
       int right = (b+1) % agents[a].length;      
       int left  = (agents[a].length+b-1) % agents[a].length;

       if(agents[a][left]!=null
       && agents[a][left].state==Susceptible && random(1) < 1-agents[a][left].immunity )
         {agents[a][left].state=Infected; sumInfected++;}
        
       if(agents[a][right]!=null
       && agents[a][right].state==Susceptible && random(1) < 1-agents[a][right].immunity )
         {agents[a][right].state=Infected; sumInfected++;}
        
       if(agents[up][b]!=null
       && agents[up][b].state==Susceptible && random(1) < 1-agents[up][b].immunity )
         {agents[up][b].state=Infected; sumInfected++;}
        
       if(agents[dw][b]!=null
       && agents[dw][b].state==Susceptible && random(1) < 1-agents[dw][b].immunity ) 
         {agents[dw][b].state=Infected; sumInfected++;}

       float prob=random(1); //Fate for the day
       
       if(prob<PDeath) //He dies on this day
        { 
          sumDeath++;liveCount--;
          agents[a][b].state=Death; //But this also needs to be taken into account in the statistics!
        }
        else
        {
          //... or he is cured
          if(++(agents[a][b].state)==Recovered)
          {
              sumRecovered++;
              //agents[a][b].immunity=1; //Just to check, though it will mess up the chart ;-)
          }
          //else //...OR STILL SUFFERING!
        }
    }
  }
  //We record the change in the base statistics 
  //which took place during this simulation step
  deaths.append(sumDeath-befDeath);
  newcas.append(sumInfected-befInfected);
  cured.append(sumRecovered-befRecovered);
}

//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM: BASIC INITIALISATION & EVERY STEP CHANGE
//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
