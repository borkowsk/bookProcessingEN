// Agent jest jedną z dwóch centralnych klas każdego modelu ABM
// Agent musi zostać zainicjowany i musi mieć logikę zmian
//-/////////////////////////////////////////////////////////////
float noiseMult=0.05;
float noiseTres=0.55;

void initializeAgents(Agent[][] agents)
{
   for(int a=0;a<agents.length;a++)
    for(int b=0;b<agents[a].length;b++)
      if(noise(a*noiseMult,b*noiseMult)<noiseTres
      && random(1)<density )
      {
        Agent curr=new Agent();
        //DODATKOWY KOD INICJALIZACJI AGENTÓW, np. curr.initialise();
        liveCount++;
        agents[a][b]=curr;
      }
}

void  agentsChange(Agent[] agents) //do zmiany na agentsChange()
{
  int MC=agents.length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length);
    if(agents[a]!= null )
    {
      //agents[a].dummy+=random(-0.1,0.1); //PRZYKŁADOWA ZMIANA
    }
  }  
}

boolean agentMigration(int a,int b,Agent[][] agents)
{
   //Wyliczenie lokalizacji bliskich sąsiadów
   int dw=(a+1) % agents.length;   
   int up=(agents.length+a-1) % agents.length;
   int right = (b+1) % agents[a].length;      
   int left  = (agents[a].length+b-1) % agents[a].length;
   
   boolean flaga=false; //Jak samotny to może migrować niezależnie od `pFarTrans`
   
   if( pFarTrans!=0 //Nawet jak nie ma paniki to nikt nie chce być sam! 0 blokuje wszelkie migracje
   &&  (agents[dw][left]==null || (panic && agents[dw][left].state==Death) )
   &&  (agents[dw][right]==null || (panic && agents[dw][right].state==Death) )
   &&  (agents[up][left]==null || (panic && agents[up][left].state==Death) )
   &&  (agents[up][right]==null || (panic && agents[up][right].state==Death) ) 
   ) //Samotny...
   {
     migrationCont++;flaga=true; //Wymuszone błądzenie jeśli wokół pusto i głucho
     //println("elone"); //DEBUG
   }
  
   if(flaga || (pFarTrans>random(1) && (++migratioStart)>0) )
   {
     //Wyliczenie lokalizacji do dalekiej migracji
     dw=(a+10) % agents.length;   
     up=(agents.length+a-10) % agents.length;
     right = (b+10) % agents[a].length;      
     left  = (agents[a].length+b-10) % agents[a].length; 
   
     int targA,targB;
     switch(int(random(4))){
     default:
     case 0:targA=dw;targB=right;break;
     case 1:targA=dw;targB=left;break;
     case 2:targA=up;targB=right;break;
     case 3:targA=up;targB=left;break;
     }
     Agent tmp=agents[targA][targB];
     agents[targA][targB]=agents[a][b];
     agents[a][b]=tmp;
     return true;
   }
   else
   return false;
}

void  agentsChange(Agent[][] agents)
{
  migratioStart=0;
  migrationCont=0;
  //Zapamiętujemy stan przed krokiem
  int befInfected=sumInfected;
  int befRecovered=sumRecovered;
  int befDeath=sumDeath;
  
  int MC=agents.length*agents[0].length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length);   //agents[a].length na wypadek gdyby nam przyszło do głowy zrobić prostokąt
    int b=(int)random(0,agents[a].length); //print(a,b,' '); DEBUG
    
    if(agents[a][b]!= null && agents[a][b].state!=Death )
    {
       //Jeśli migrował to nic więcej nie robimy
       if( agentMigration(a,b,agents) ) continue;
       
       //Jeśli pusty lub zdrowy to nic nie robimy
       if(agents[a][b].state<Infected || Recovered<=agents[a][b].state) continue;
       
       //Wyliczenie lokalizacji sąsiadów
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

       float prob=random(1); //Los na dany dzień
       
       if(prob<pDeath) //Albo tego dnia umiera
        { 
          sumDeath++;liveCount--;
          agents[a][b].state=Death; //Ale to trzeba też uwzględnić przy statystyce!
        }
        else
        {
          //Albo jest wyleczony
          if(++(agents[a][b].state)==Recovered)
          {
              sumRecovered++;
              agents[a][b].immunity=0.9+random(0.0333)+random(0.0333)+random(0.0333);
          }
          //else //NADAL CIERPI!
        }
    }
  }
  
   if(StepCounter==infectionPoint)
   {
     //Inicjowanie infekcji od środka w 100 kroku dopiero
     if(agents[agents.length/2][agents.length/2]==null) //Gdyby go nie było
     {
        agents[agents.length/2][agents.length/2]=new Agent();
        liveCount++;
     }
     agents[agents.length/2][agents.length/2].state=Infected;
   }
  
  //Zapamiętujemy zmianę w podstawowych statystykach 
  //jaka się dokonała w tym kroku symulacji
  if(infectionPoint<=StepCounter && abs(infectionPoint)<=StepCounter )
  {
    deaths.append(sumDeath-befDeath);
    newcas.append(sumInfected-befInfected);
    cured.append(sumRecovered-befRecovered);
    migration.append(migratioStart + migrationCont);
  }
}

//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: BASIC INITIALISATION & EVERY STEP CHANGE
//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
