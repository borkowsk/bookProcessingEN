// Agent jest jedną z dwóch centralnych klas każdego modelu ABM
// Agent musi zostać zainicjowany i musi mieć logikę zmian
//-/////////////////////////////////////////////////////////////

void initializeAgents(Agent[][] agents,int[][] env)
{
   //Umieszczamy agentów w domach i szukamy im pracy
   for(int a=0;a<agents.length;a++) //po Y
    for(int b=0;b<agents[a].length;b++) //po X
      if(env[a][b]==Env_FLAT && random(1)<density) //Tylko w obszarach mieszkalnych
      {
        Agent curr=new Agent(b,a);  
        liveCount++; 
        env[a][b]|=1; //Zaznaczamy mieszkanie jako zajęte
                     //Zajęte mają na końcu jedynkę. Taka sztuczka   
                     
        //Każdemu agentówi dajemy N szans znalezienia miejsca pracy
        for(int i=0;i<Nprob;i++)
        {
          curr.workX=int(random(agents[0].length));
          curr.workY=int(random(agents.length));
          if( env[curr.workY][curr.workX]/100 ==1  //Wszystkie miejsca pracy mają 
          && (env[curr.workY][curr.workX] & 1) !=1 //wartości od 100 do 190 co 10
          )
          {                        assert (env[curr.workY][curr.workX] & 1) == 0;
             env[curr.workY][curr.workX] |= 1; //Zaklepuje sobie to miejsce pracy
             break; //Mam już miejsce pracy
          }
          else //Nadal pracuje w domu
          {
            curr.workX=curr.flatX;
            curr.workY=curr.flatY;
          }
        }
        
        agents[a][b]=curr;
      }
      
   //Inicjowanie infekcji z pozycji losowej
   int a=int(random(agents.length/3));    //Tylko fragment miasta
   int b=int(random(agents[0].length/3)); //Żeby łatwiej było znaleźć
   if(agents[a][b]==null) //Gdyby go nie było
   {
      agents[a][b]=new Agent(b,a); //Konstruktor wymaga podania x,y położenia
      liveCount++;
   }
   println("Pacjent 0 at ",b,a);
   agents[a][b].state=Infected;
}

void sheduleAgents(Agent[][] agents,int[][] env,int step)
//Proste przemieszczanie agentów sterowane upływem czasu symulacji
{
   Agent curra; //println("Parzysty: ",step%2==0); //Co innego w krokach parzystych!
   for(int a=0;a<agents.length;a++)
    for(int b=0;b<agents[a].length;b++)
    {
     if( (curra=agents[a][b])!= null //Coś dalej do zrobienia gdy agent tu jest
     && curra.state!=Death       //duchy nie chodzą do pracy
     && curra.workX!=curra.flatX && curra.workY!=curra.flatY//nie pracuje w domu!
     )
     {
       if(step % 2 == 0 ) //Jak 0 czyli krok parzysty to z domu do pracy
       {
         float workProbability=(Infected < curra.state && curra.state < Recovered) 
                               ? Dutifulness * (1-PSLeav): Dutifulness;
         if(env[a][b]==Env_FLAT+1 //Nadal jest w domu 
         && random(1)< workProbability //i zdecydował się iść
         )
         {
           agents[a][b]=null; //A z domu znika
           agents[curra.workY][curra.workX]=curra; //Teleportuje się do pracy
         }
       }
       else// jak krok nieparzysty to z pracy do domu
         if(env[a][b]==Env_WORK+1) //Tylko jak nadal jest w pracy to z niej wraca
         {
           agents[a][b]=null; //A z pracy znika
           agents[curra.flatY][curra.flatX]=curra; //Teleportuje się do domu
         }
     }
   } 
}

void  agentsChange(Agent[][] agents)
{
  //Zapamiętujemy stan przed krokiem
  int befInfected=sumInfected;
  int befRecovered=sumRecovered;
  int befDeath=sumDeath;
  
  int MC=agents.length*agents[0].length;
  for(int i=0;i<MC;i++)
  {
    int a=(int)random(0,agents.length); //agents[a].length na wypadek gdyby nam przyszło do głowy zrobić prostokąt
    int b=(int)random(0,agents[a].length); //print(a,b,' ');
    if(agents[a][b]!= null )
    {
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
       
       if(prob<PDeath) //Albo tego dnia umiera
        { 
          sumDeath++;liveCount--;
          //agents[a][b]=null; //Można by dawać mu stan "dead", ale...
          agents[a][b].state=Death; //Ale to trzeba uwzględnić przy statystyce!
        }
        else
        {
          //Albo jest wyleczony
          if(++(agents[a][b].state)==Recovered)
          {
              sumRecovered++;
              //agents[a][b].immunity=1; //Dla sprawdzenia, ale demoluje ;-) wykres
          }
          //else //NADAL CIERPI!
        }
    }
  }
  //Zapamiętujemy zmianę w podstawowych statystykach jaka się dokonała w kroku symulacji
  deaths.append(sumDeath-befDeath);
  newcas.append(sumInfected-befInfected);
  cured.append(sumRecovered-befRecovered);
}

//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: BASIC INITIALISATION & EVERY STEP CHANGE
//-//////////////////////////////////////////////////////////////////////////////////////////////////////////
