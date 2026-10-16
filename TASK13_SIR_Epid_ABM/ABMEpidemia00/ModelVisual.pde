// Świat pełen agentów wymaga metody wizualizacji na ekranie/oknie
//-//////////////////////////////////////////////////////////////////////////

void visualizeAgents(Agent[][] agents)
{
  Agent curra;
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
   {
    //KOLORYZACJA AGENTA
    //NA WZÓR TEGO KODU ZDEFINIUJ WŁASNE KOLOROWANIE!
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
    rect(b*cwidth,a*cwidth,cwidth,cwidth); //WŁAŚCIWE RYSOWANIE a jest pionowe
                                          //bo tak leżą w pamięci tablice 2D
   }
}
//OR
void visualizeAgents(Agent[] agents)
{
   Agent curra;
   for(int a=0;a<agents.length;a++)
   {
    //KOLORYZACJA AGENTA
    //NA WZÓR TEGO KODU ZDEFINIUJ WŁASNE KOLOROWANIE!   
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
    rect(a*cwidth,t*cwidth,cwidth,cwidth); //WŁAŚCIWE RYSOWANIE 
    
    stroke(255);
    line(0,(t+1)*cwidth+1,width,(t+1)*cwidth+1); //LINIA CZASU TERAŹNIEJSZEGO
   }
}

//-//////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: BASIC Wizualizacja
//-//////////////////////////////////////////////////////////////////////////////////////////////////////
