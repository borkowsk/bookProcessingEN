// World full of agents need method of visualisation on screen/window
////////////////////////////////////////////////////////////////////////////

void visualizeAgents(Agent[][] agents)
{
  Agent curra;
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
   {
      //Background
      noStroke();fill(200);//Lepiej dopasowa tło
      rect(b*cwidth,a*cwidth,cwidth,cwidth);//a is vertical!
      
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
//OR
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
    
    int t=(StepCounter/STEPSperVIS)%side;//Uwzględniamy różne częstości wizualizacji
    rect(a*cwidth,t*cwidth,cwidth,cwidth);
    stroke(255);
    line(0,(t+1)*cwidth+1,width,(t+1)*cwidth+1);
   }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: BASIC VISUALISATION
////////////////////////////////////////////////////////////////////////////////////////////////////////
