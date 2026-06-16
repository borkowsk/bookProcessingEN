//"Forest fire with regeneration" - my private version 
//Model "pożaru lasu" jest bardzo klasyczny, choć tu mamy wersję autorską
///////////////////////////////////////////////////////////////////////////

//Model parameters
int N=150;        //array side
int FireTimeDiv=50;//How long the tree is burning (divider for size)
float IgnitionP = 0.10;//Probability of fire transfer
float InitT=  0.75; //How many trees at start
float GrowS=  0.01; //Growt per step
float SeedP=  0.005;//How often new ofspring emerging (per free cell)
float LightP= 0.000001;//How often fire emerge (per tree)
int MatureT=220; //Max size of tree. Then will stop to grow

//2D "World" of trees
float World[][] = new float[N][N];

//For visualisation
int S=20;       //cell width & height

//For statistics
int Step=0;
//Simple counters
int empty=0;
int alives=0;
int burning=0;

//Initialisation
void setup()
{
  size(900,930);
  S=width/N; //Agent side size
 
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
   if(random(0,1)<InitT)
    World[i][j]=(int)random(MatureT);//FLAT DISTRIBUTION? RATHER NOT REALISTIC!
    else
    World[i][j]=0;
    
  frameRate(100);
  noSmooth();
}

void draw()
{
  doVisualisation();
  doMonteCarloStep();
}

void doVisualisation()
{
 empty=0;alives=0;burning=0;//Simple caunting will be done during visualisation

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
    }
    else //Burning!
    {
      fill(random(255),random(255),0);
      burning++;
    }
    
    rect(i*S,j*S,S,S);
  } 
  fill(0);
  rect(0,height,width,-16);
  fill(255);
  text(Step+") T:"+alives+" B:"+burning+" Speed:"+frameRate+"fr/sec",0,height);
}


void doMonteCarloStep()
{
  Step++;
  int M=N*N;
  for(int m=0;m<M;m++)//Processing is CASE SENSITIVE. But utilising this, is not a good praktise. 
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
      if(random(0,1)<LightP) //Spontanic fireing
        World[i][j]=(int)(-World[i][j]/FireTimeDiv - 1);//At least one step 
      else  
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
               println(World[a][b],"!");
             }
        }
       //Burn more
       World[i][j]++;//Until 0
    }
  }
}