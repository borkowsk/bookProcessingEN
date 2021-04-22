// "sum of the states [of neighbors] modulo M": 
// One-dimensional, SYNCHRONOUS, deterministic cellular automaton
///////////////////////////////////////////////////////////////////////

final int   WorldSize=500;//How many cells do we want?
final float Dens=0.005;   //0.5 or so also posible
final int   Divider=5;    //By how much we divide?
final boolean self=true;  //Do we include the state of the middle cell

int[] WorldOld=new int[WorldSize];//We need two arrays for the old  
int[] WorldNew=new int[WorldSize];//and new state of the simulation

void setup()
{
  size(500,1000); 
  frameRate(100);
  noSmooth();//CA look better without smooth
  
  if(Dens>0)
  {
   for(int i=0;i<WorldOld.length;i++) //Zasiewanie tablicy
    if(random(1.0)<Dens)
      WorldOld[i]=int(random(3));
  }
  else
  {
    WorldOld[WorldSize/2]=1;
  }
}

void visualisation()
{
  for(int i=0;i<WorldOld.length;i++)
  { //color selection
    switch(WorldOld[i]){ 
    //case *:stroke(*,*,*);break; 
    //case 5:stroke(255,0,255);break; 
    case 4:stroke(255,255,0);break;
    case 3:stroke(0,255,0);break;
    case 2:stroke(255,0,0);break;
    case 1:stroke(0,0,255);break;
    case 0:stroke(0,0,0);break;
    default: stroke(128,255,128);//It shouldn't appear!
    break;
    }
    
    point(i,t);//current state
    line(i,999,i,994);//& at the bottom
  }
}

int t=0;
void draw()
{
  if(t>994) return; //Nic już nie ma do narysowania 
  visualisation();

  for(int i=0;i<WorldSize;i++)
  {    //RULE: "sum of the states [of neighbors] modulo M"
       int right = (i+1) % WorldSize;      
       int morer = (i+2) % WorldSize;     
       int left  = (WorldSize+i-1) % WorldSize;
       int morel = (WorldSize+i-2) % WorldSize;
       int stsum = self ? WorldOld[i] : 0 ;
       
       stsum+=WorldOld[left]
            +WorldOld[right]
            +WorldOld[morel]
            +WorldOld[morer]              
               ;//sum of four/five cells 
    
       WorldNew[i]=stsum % Divider;//... taken then modulo DIVIDER
   }
   
   //NOW THE MOST IMPORTANT - Swap the arrays
   int[] WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp;
   
   t++;//The next generation/step/year
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/

