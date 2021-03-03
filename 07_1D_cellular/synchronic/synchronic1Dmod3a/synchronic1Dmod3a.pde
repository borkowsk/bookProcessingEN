// "sum of alives neig. modulo 3": 
// One-dimensional, SYNCHRONOUS, deterministic cellular automaton
///////////////////////////////////////////////////////////////
final int   WorldSize=500;//How many cells do we want?
final float Dens=0.001;//0.5 or so also posible

int[] WorldOld=new int[WorldSize];//We need two arrays for the old  
int[] WorldNew=new int[WorldSize];//and new state of the simulation

void setup()
{
  size(500,1000); 
  frameRate(10);
  noSmooth();//CA look better without smooth
  
  if(Dens>0)
  {
   for(int i=0;i<WorldSize;i++)
    if(random(1.0)<Dens)
      WorldOld[i]=1;
  }
  else
  {
    WorldOld[WorldSize/2]=1;
  }
}

void visualisation()
{
  for(int i=0;i<WorldSize;i++)
  { // The selection instruction allows us 
    // to choose any color depending on the number in the cell
    switch(WorldOld[i]){ 
    case 2:stroke(0,255,0);break;
    case 1:stroke(255,0,255);break;
    case 0:stroke(0,0,0);break;
    default: stroke(0,0,255);//It shouldn't appear!
    break;
    }
    point(i,t);//current state
    line(i,t,i,999);//Reflect the current state to the bottom of the canvas
  }
}

int t=0;
void draw()
{
  if(t>height-8) return;
  visualisation();
  
  for(int i=0;i<WorldSize;i++)//Now the cellular automaton state change
  {    //Reguła - "Rule - "SUM YOUR STATE WITH YOUR NEIGHBORS AND TAKE MODULO 3"
       int right = (i+1) % WorldSize;      
       int left  = (WorldSize+i-1) % WorldSize;
       
       int sum = 0;
       if(WorldOld[i]>0)
         sum++;
       if(WorldOld[left]>0)
         sum++;
       if(WorldOld[right]>0)  
         sum++;
         
       WorldNew[i]=sum % 3;//We save the new state on the second array
   }
   
   //NOW THE MOST IMPORTANT - Swap the arrays
   int[] WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp;
   
   t++;//The next generation/step/year
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/
