// A world full of agents requires a method of visualization on a screen/window
//-//////////////////////////////////////////////////////////////////////////

void visualizeAgents(Agent[][] agents)
{
  Agent curra;
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
   {
    //AGENT COLORING
    //USING THIS CODE AS AN EXAMPLE, DEFINE YOUR OWN COLORING!
    if( (curra=agents[a][b]) != null )
    {
      if(curra.dummy>=0)
        fill(curra.dummy*255,0,curra.dummy*255);
      else
        fill(-curra.dummy*255,-curra.dummy*255,0);
    }
    else
    {
      fill(128);
    }
    
    noStroke();
    rect(b*cwidth,a*cwidth,cwidth,cwidth); //THIS IS ACTUAL DRAWING- "a" is vertical
                                          //because that’s how 2D arrays are laid out in memory
   }
}
//OR
void visualizeAgents(Agent[] agents)
{
   Agent curra;
   for(int a=0;a<agents.length;a++)
   {
    //AGENT COLORING
    //USING THIS CODE AS AN EXAMPLE, DEFINE YOUR OWN COLORING!   
    if( (curra=agents[a]) != null )
    {
      if(curra.dummy>=0)
        fill(curra.dummy*255,0,curra.dummy*255);
      else
        fill(-curra.dummy*255,-curra.dummy*255,0);
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
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: BASIC VISUALISATION
//-//////////////////////////////////////////////////////////////////////////////////////////////////////
