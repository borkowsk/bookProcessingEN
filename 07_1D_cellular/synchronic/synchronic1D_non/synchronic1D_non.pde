// "Not too many neighbors": 
// One-dimensional, SYNCHRONOUS, deterministic cellular automaton
///////////////////////////////////////////////////////////////
final int   WorldSize=500;//How many cells do we want?
final float Dens=0.005;//0.5 or so also posible

int[] WorldOld=new int[WorldSize];//We need two arrays for the old  
int[] WorldNew=new int[WorldSize];//and new state of the simulation

void setup()
{
  size(500,1000);//The window is more vertical than horizontal  
  frameRate(100);
  noSmooth();//CA look better without smooth
  
  if(Dens>0)//Initialisation 
  {
   for(int i=0;i<WorldSize;i++) //Seeding an array with a given density
    if(random(1.0)<Dens)
      WorldOld[i]=1;
  }
  else WorldOld[WorldSize/2]=1; //... or one seed
}

void visualisation()
{
  for(int i=0;i<WorldSize;i++)
  {
    if(WorldOld[i]>0) stroke(255,0,100);
    else           stroke(0);
    point(i,t);
  }
}

int t=0;
void draw()
{
  if(t>height) return; //There is no place to draw
  visualisation();

  for(int i=0;i<WorldSize;i++)//Now the cellular automaton state change
  {
       //Rule - "I don't like to have too many neighbors"
       int right = (i+1) % WorldSize;//Wrapping around     
       int left  = (WorldSize+i-1) % WorldSize;//thanks to the remainder of the integer divide
       int howMany= 0;//How many live neighbors?
       
       if(WorldOld[left]>0) //It is not zero, so, it is "alive"
         howMany++;
       
       if(WorldOld[right]>0)//It is not zero, so, it is "alive"
         howMany++;
               
       if(howMany==1) WorldNew[i]=1;//Only having one neighbor is correct
       else WorldNew[i]=0;//Otherwise, he dies of loneliness or crowds
   }
   
   //NOW THE MOST IMPORTANT - Swap the arrays
   int[] WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp;
   
   t++;//The next generation/step/year
}
