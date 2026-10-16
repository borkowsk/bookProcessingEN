// Świat pełen agentów wymaga metody wizualizacji na ekranie/oknie
//-//////////////////////////////////////////////////////////////////////////
void visualizeEnv(int[][] env)
{
  noStroke(); //Nie ma powodu być w pętli!
  for(int a=0;a<env.length;a++)
   for(int b=0;b<env[a].length;b++)
   {
    //KOLORYZACJA ŚRODOWISKA 
    switch(env[a][b]){
    case Env_FLAT:fill(255);break;
    case Env_FLAT+1:fill(220);break; //Zajęte mieszkanie. Sztuczka taka
    case Env_WORK:fill(128);break;
    case Env_WORK+1:fill(64);break; //Zajęte miejsca pracy 
    case Env_ROAD:fill(0,0,48);break;
    case Env_REST:fill(0,128,0);break;  
    default:fill(255,0,0);break;
    }
    
    rect(b*cwidth,a*cwidth,cwidth,cwidth); //WŁAŚCIWE RYSOWANIE 
   }
}

void visualizeAgents(Agent[][] agents)
{
  noStroke(); //Nie ma powodu być w pętli!
  ellipseMode(CORNER);
  Agent curra;
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
   {
    //KOLORYZACJA AGENTA
    if( (curra=agents[a][b]) != null )
    {
      float green=curra.immunity*200;
      switch(curra.state){ 
      case Recovered:  fill(0,128,0);break; //Wyleczony
      case Infected:   fill(0,255,255);break; //Zachorował
      case Susceptible:fill(0,green,128);break; //Podatny
      case Death:      fill(0);break; //Zmarły
      default:         fill(random(255),green,random(255)); //Chory
      break;
      } 
      rect(b*cwidth,a*cwidth,cwidth,cwidth); //WŁAŚCIWE RYSOWANIE 
                             //Zamiast rect() mogłoby też być ellipse()
    }    
   }
}

//-//////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM city_of_plague: Wizualizacja
//-//////////////////////////////////////////////////////////////////////////////////////////////////////
