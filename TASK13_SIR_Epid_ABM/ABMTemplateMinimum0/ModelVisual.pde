// A world full of agents requires a method of visualization on a screen/window
//-//////////////////////////////////////////////////////////////////////////

void visualizeAgents(Agent[][] agents)
{
  Agent curra;
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
   {
    //Coloring... an example.
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
    
    rect(b*cwidth,a*cwidth,cwidth,cwidth); //`a` is vertical, due to the natural layout of a 2D array in memory
   }
}
//OR
void visualizeAgents(Agent[] agents)
{
   Agent curra;
   for(int a=0;a<agents.length;a++)
   {
    //Coloring... an example.
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
    rect(a*cwidth,t*cwidth,cwidth,cwidth);
    stroke(255);
    line(0,(t+1)*cwidth+1,width,(t+1)*cwidth+1);
   }
}

//-//////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: BASIC VISUALISATION
//-//////////////////////////////////////////////////////////////////////////////////////////////////////
