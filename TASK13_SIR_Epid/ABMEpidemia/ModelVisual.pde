// Świat pełen agentów wymaga metody wizualizacji na ekranie/oknie
//-//////////////////////////////////////////////////////////////////////////

void visualizeAgents(Agent[][] agents)
{
  Agent curra;
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
   {
    //KOLORYZACJA AGENTA
    if( (curra=agents[a][b]) != null )
    {
      float green=curra.immunity*255;
      switch(curra.state){ //Instrukcja wyboru pozwala nam wybrać dowolny kolor
      case Recovered:  fill(0,255,0);break; //Wyleczony
      case Infected:   fill(255,green,0);break; //Zachorował
      case Susceptible:fill(0,green,255);break; //Podatny
      default:         fill(random(255),green,random(255)); //Chory
      break;
      } 
    }
    else
    {
      fill(128);
    }
    
    noStroke();
    rect(b*cwidth,a*cwidth,cwidth,cwidth); //WŁAŚCIWE RYSOWANIE 
   }
}
//OR
void visualizeAgents(Agent[] agents)
{
   Agent curra;
   for(int a=0;a<agents.length;a++)
   {
    //KOLORYZACJA AGENTA  
    if( (curra=agents[a]) != null )
    {
      switch(curra.state){ //Instrukcja wyboru pozwala nam wybrać dowolny kolor
      case Recovered:  fill(0,255,0);break; //Wyleczony
      case Infected:   fill(255,0,0);break; //Zachorował
      case Susceptible:fill(0,0,255);break; //Podatny
      default:         fill(random(255),0,random(255)); //Chory
      break;
      } 
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
