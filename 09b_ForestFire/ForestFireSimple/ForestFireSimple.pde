//"Forest fire" - my private Monte-Carlo version 
//Model "pożaru lasu" - bardzo klasyczny, w wersji autorskiej Monte Carlo 
///////////////////////////////////////////////////////////////////////////

//Model parameters
int N=50;        //array side
int FireTimeDiv=10;//How long the tree is burning (divider for age/size)
float IgnitionP = 0.75;//Probability of fire transfer
float InitT=  0.750; //How many trees at start

//2D "World" of trees
int World[][] = new int[N][N];

//For visualisation
int S=20;       //cell width & height

//For statistics
int Step=0;

//Initialisation
void setup()
{
  size(900,930);
  S=width/N; //Agent side size
 
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
    if(random(0,1)<InitT)
     //World[i][j]=100;
     //World[i][j]=(int)random(100);//FLAT DISTRIBUTION? RATHER NOT REALISTIC!
     World[i][j]=(int)(20*(random(1)+random(1)+random(1)+random(1)+random(1)));//MAYBE GAUSSIAN DISTRIBUTION? 
    else
     World[i][j]=0;
}

void draw()
{
  doVisualisation();
  doMonteCarloStep();
}

void doVisualisation()
{
 for(int i=0;i<N;i++)//visualisation
  for(int j=0;j<N;j++)
  {
    if(World[i][j]==0)//Free or burned cell
    {
      fill(0,0,0);
    }
    else
    if(World[i][j]>0) //TREE
    {
      int col=30+(int)World[i][j];
      if(col>255) col=255;
      fill(0,col,0);
    }
    else //Burning!
    {
      fill(random(255),random(255),0);
    }
    
    rect(i*S,j*S,S,S);
  } 
}

void keyPressed() //Lighting
{
    int i=(int)random(N);
    int j=(int)random(N);
    World[i][j]=-World[i][j]/FireTimeDiv - 1;//At least one step
}

void doMonteCarloStep()
{
  Step++;
  int M=N*N;
  for(int m=0;m<M;m++)//Processing is CASE SENSITIVE. But utilising this, is not a good praktise. 
  {
    int i=(int)random(N);
    int j=(int)random(N);
    
    if(World[i][j]<0)//Negative means still burning!
    {
       //Ignite neighbor!
       int a=(N+i+(int)random(-1.99,1.99))%N;
       int b=(N+j+(int)random(-1.99,1.99))%N;
       
       if(World[a][b]>0
       && random(0,1)<IgnitionP)
       {
         World[a][b]=-World[a][b]/FireTimeDiv - 1;//At least one step
         //print("!");
       }
       
       //Burn more
       World[i][j]++;//Until 0
       if(World[i][j]>0) print("?");
    }
  }
}