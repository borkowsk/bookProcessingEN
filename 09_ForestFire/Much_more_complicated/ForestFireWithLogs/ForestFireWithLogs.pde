//"Forest fire with regeneration" - my private version 
//Model "pożaru lasu" jest bardzo klasyczny, choć tu mamy wersję autorską
//z próbą urealnienia stosunków czasowych
///////////////////////////////////////////////////////////////////////////
//One step is equivalential to one hour
int week=24*7;    //how many steps is equivalential to one week?
float year=365.5*24;//how many steps is equivalential to one YEAR?

//Model parameters
int N=300;        //array side

int FireTimeDiv=50;//How long the tree is burning (divider for size)
float IgnitionP = 0.10;//Probability of fire transfer
float InitT=  0.00; //How many trees at start
float GrowS=  0.0005; //Growt per step
float SeedP=  0.0005;//How often new ofspring emerging (per free cell)
float LightP= 0.000000005;//How often fire emerge (per tree)
int MatureT=220; //Max size of tree. Then will stop to grow

//2D "World" of trees
float World[][] = new float[N][N];
PrintWriter Log;//For writing statistics into disk drive

//For visualisation
int S=20;       //cell width & height
boolean is_burning=false;

//For statistics
int Step=0;

//Simple statistics
int empty=0;
int alives=0;
int burning=0;
double meanSize=0;

//Initialisation
void setup()
{
  size(900,936);
  S=width/N; //cell side size

  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
   if(random(0,1)<InitT)
    //World[i][j]=(int)random(MatureT);//FLAT DISTRIBUTION? RATHER NOT REALISTIC!
    World[i][j]=MatureT/2;
    else
    World[i][j]=0;
   
  frameRate(4*week);
  noSmooth();
  noStroke();
  
  String LogName="FF"+IgnitionP+"_"+GrowS+"_"+LightP+".log";
  Log = createWriter(LogName); // Create a new file in the sketch directory
  Log.println("step\t alives\t burning\t empty\t meanSize");//Header
}

void draw()
{
  if(is_burning ||
     Step % (4*week) == 0)
      doVisualisation();
  
  is_burning=false;//We will check it in a moment
  
  doMonteCarloStep();
}

float Burn=0;//Ile możliwości zapalenia na krok
void doMonteCarloStep()
{
  //Bardzo rzadkie zapalanie - trochę oszukujemy, ale unikamy wywołań random na każdą niemal komórkę!
  Burn+=N*N*LightP;//Prawdopodobieństwo jest na komórkę na krok. Z czasem licznik rośnie
  for(;Burn>1;)//Spontanic fireing
      {
        int i=(int)random(N);
        int j=(int)random(N);
        if(World[i][j]>0)
        {
          World[i][j]=(int)(-World[i][j]/FireTimeDiv - 1);//At least one step 
          Burn--;
          is_burning=true;//At least one! DO VISUALISATION!
        }
      }
      
  //Reszta akcji
  int M=N*N;
  for(int m=0;m<M;m++)//Processing is CASE SENSITIVE. 
  {
    int i=(int)random(N);
    int j=(int)random(N);
    if(World[i][j]==0)//Free or burned cell
    {
      if(random(0,1)<SeedP)
          World[i][j]=1;//New seedling
    }
    else
    if(World[i][j]>0) //TREE
    {
      if(World[i][j]<MatureT)
            World[i][j]+=GrowS;
    }
    else //Negative means still burning!
    {
       //Ignite neighbors!
       for(int l=-1;l<2;l++) //Moore neighborhood
        for(int k=-1;k<2;k++)        
        {
            int a=(N+i+l)%N;
            int b=(N+j+k)%N;
            if(World[a][b]>0 //If is still not burning
            && random(0,1)<IgnitionP)//May ignite
             {
               World[a][b]=(int)(-World[a][b]/FireTimeDiv - 1);//At least one step
               //println(World[a][b],"!");
               is_burning=true;//At least one! DO VISUALISATION!
             }
        }
       //Burn more
       World[i][j]++;//Until 0
    }
  }
  //Step completed
  Step++;
}

void doVisualisation()
{
  empty=0;alives=0;burning=0;//Simple counting will be done during visualisation
  meanSize=0;
  
 for(int i=0;i<N;i++)//visualisation
  for(int j=0;j<N;j++)
  {
    if(World[i][j]==0)//Free or burned cell
    {
      fill(20,20,20);
      empty++;
    }
    else
    if(World[i][j]>0) //TREE
    {
      int col=30+(int)World[i][j];
      if(col>255) col=255;
      fill(0,col,0);
      alives++;
      meanSize+=World[i][j];
    }
    else //Burning!
    {
      fill(50+random(205),random(255),0);
      burning++;
    }  
    rect(i*S,j*S,S,S);
  } 
  
  //Printing statistics:
  fill(0);
  rect(0,height,width,-32);
  
  if(!is_burning)
    fill(255);
  else
    fill(50+random(205),random(255),0);
  meanSize/=alives;
  text(" T:"+alives+" B:"+burning+" Speed:"+frameRate+"fr/sec",0,height-16);
  fill(0,255,0);
  text(" Growing:"+GrowS+" Fire transfer p.:"+IgnitionP+" Fire p.:"
    +LightP+"(all per step & per tree)",width/3,height-16);
  fill(255,255,0);
  text(Step/year+" years  = "+Step/week+" weeks & " 
    + (Step%week)/24 + " days = " 
    + Step + " h"  ,0,height);
  fill(0,255,255);
  text("Mean Size: "+meanSize+" ",width/2,height);
  
  Log.println(Step+"\t "+alives+"\t "+burning+"\t "+empty+"\t "+meanSize);
  if(Step % 5000==0) Log.flush();//Sometimes writes the buffer to the file
}

void exit() //it is called whenever a window is closed. 
{
  noLoop();   // For to be sure...
  delay(100); // it is possible to close window when draw() is still working!
  Log.flush();// Writes the remaining data to the file
  Log.close();// Finishes the file
  println("Thank You");
  super.exit(); //What library superclass have to do at exit
} 
