// A world full of agents requires a method of visualization on a screen/window
//-//////////////////////////////////////////////////////////////////////////

void visualizeAgents(Agent[][] agents)
{
  Agent curra;
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
   {
    //AGENT COLORING
    if( (curra=agents[a][b]) != null )
    {
      float green=curra.immunity*255;
      switch(curra.state){ //The selection statement allows us to choose any color
      case Recovered:  fill(0,255,0);break; // Cured
      case Infected:   fill(255,green,0);break; // Just infected
      case Susceptible:fill(0,green,255);break; // Vulnerable
      case Death:      fill(0);break;//Deceased
      default:         fill(random(255),green,random(255)); // Sick
      break;
      } 
    }
    else
    {
      fill(128);
    }
    
    noStroke();
    rect(b*cwidth,a*cwidth,cwidth,cwidth); //THIS IS ACTUAL DRAWING 
   }
}
//OR
void visualizeAgents(Agent[] agents)
{
   Agent curra;
   for(int a=0;a<agents.length;a++)
   {
    //AGENT COLORING  
    if( (curra=agents[a]) != null )
    {
      switch(curra.state){ //The selection statement allows us to choose any color
      case Recovered:  fill(0,255,0);break; // Cured
      case Infected:   fill(255,0,0);break; // Just infected
      case Susceptible:fill(0,0,255);break; // Vulnerable
      default:         fill(random(255),0,random(255)); // Sick
      break;
      } 
    }
    else
    {
      fill(128);
    }
    
    int t=StepCounter%side;
    noStroke();
    rect(a*cwidth,t*cwidth,cwidth,cwidth); //THIS IS ACTUAL DRAWING 
    
    stroke(255);
    line(0,(t+1)*cwidth+1,width,(t+1)*cwidth+1); //LINE FOR THE PRESENT TIME
   }
}

//-//////////////////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM: BASIC VISUALISATION
//-//////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
