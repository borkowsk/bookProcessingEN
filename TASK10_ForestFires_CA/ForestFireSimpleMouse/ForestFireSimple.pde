//"Monte-Carlo Forest fire" 
//The "forest fire" model - a very classic, in the original Monte Carlo version
//-//////////////////////////////////////////////////////////////////////

//Model parameters
int N=50;               //The length of the side of the matrix
int FireTimeDiv=10;     //How long does a tree burn (by age/size)
float IgnitionP = 0.75; //Probability of fire transmission
float InitT=  0.750;    //What is the density of the forest at the beginning?

//2D world of trees
int World[][] = new int[N][N];

//For visualization
int S=20;       //cell width and height

//For statistical purposes
int Step=0;

//Initialisation
void setup()
{
  size(900,930);
  S=width/N; //Cell side length (in visualization)
 
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
    if(random(0,1)<InitT)
     //World[i][j]=100;
     //World[i][j]=(int)random(100); //FLAT DISTRIBUTION? COMMON IN MODELS, BUT RARELY REALISTIC!
     World[i][j]=(int)(20*(random(1)+random(1)+random(1)+random(1)+random(1))); //Or maybe some kind of bell distribution (e.g. binomial)?
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
 for(int i=0;i<N;i++) //Visualization
  for(int j=0;j<N;j++)
  {
    if(World[i][j]==0) //Free or burnt cell
    {
      fill(0,0,0);
    }
    else
    if(World[i][j]>0) //Any tree?
    {
      int col=30+(int)World[i][j];
      if(col>255) col=255;
      fill(0,col,0);
    }
    else //It's burning!
    {
      fill(random(255),random(255),0);
    }
    
    rect(i*S,j*S,S,S);
  } 
}

void keyPressed() //"Manual" ignition in random location!
{
    int i=(int)random(N);
    int j=(int)random(N);
    World[i][j]=-World[i][j]/FireTimeDiv - 1; //At least one step
}

void mouseClicked()
{
  int i=mouseX/S;
  int j=mouseY/S;
  World[i][j]=-World[i][j]/FireTimeDiv - 1; //At least one step
}

void doMonteCarloStep()
{
  Step++;
  int M=N*N;
  for(int m=0;m<M;m++) //Processing is CASE-sensitive in identifiers. However, taking advantage of this capability is not good programming practice.
  {
    int i=(int)random(N);
    int j=(int)random(N);
    
    if(World[i][j]<0) //A negative value means it is still burning!
    {
       //Setting a neighbor on fire.
       int a=(N+i+(int)random(-1.99,1.99))%N;
       int b=(N+j+(int)random(-1.99,1.99))%N;
       
       if(World[a][b]>0
       && random(0,1)<IgnitionP)
       {
         World[a][b]=-World[a][b]/FireTimeDiv - 1; //At least one step
         //print("!");
       }
       
       //It's still burning.
       World[i][j]++; //Up to 0
       if(World[i][j]>0) print("?");
    }
  }
}
