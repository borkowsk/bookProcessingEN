// "sum of the states [of neighbors] modulo M": 
// One-dimensional, SYNCHRONOUS, deterministic cellular automaton
/////////////////////////////////////////////////////////////////////////////////

final int   WorldSize=1000; // How many cells do we want?
final float Dens=0.005;     // 0.5 or so also posible.

final int   Divider=4;      // By how much we divide.
final boolean self=false;   // Do we include the middle cell?
final boolean far=true;     // Do we include the far cells?
final boolean alives=true;  // Do we summ alives cell? Othervise all states.

int[] WorldOld=new int[WorldSize]; // We need two arrays for the old.
int[] WorldNew=new int[WorldSize]; // and new state of the simulation.

void setup()
{
  size(1000,1000); 
  frameRate(100);
  noSmooth(); // CA look better without smooth.
  
  if(Dens>0)
  {
   for(int i=0;i<WorldOld.length;i++)
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
    case 6:stroke(0,255,255);break; 
    case 5:stroke(255,0,255);break; 
    case 4:stroke(255,255,0);break;
    case 3:stroke(0,255,0);break;
    case 2:stroke(255,0,0);break;
    case 1:stroke(0,0,255);break;
    case 0:stroke(0,0,0);break;
    default: stroke(255,255,255); // It shouldn't appear!
    break;
    }
    
    point(i,t);  // current state
    line(i,t,i,height); // & to the bottom
  }
}

int alive(int state)
{
  return state>0 ? 1 : 0 ; 
}

int t=0;

void draw()
{
  if(t>994) return;
  visualisation();

  for(int i=0;i<WorldSize;i++) // Compute new state loop
  {    // RULE: "sum of something modulo M" 
       // self - Do we include the middle cell? 
       // far - Do we include the far cells? 
       // alives - Do we summ alives cells? Otherwise all states.
       int right = (i+1) % WorldSize;      
       int left  = (WorldSize+i-1) % WorldSize;       
       int sum = 0; 
       
       if(self) 
         sum+=(alives ? alive(WorldOld[i]) : WorldOld[i] );
       
       sum+=(alives ? alive(WorldOld[left])  : WorldOld[left] );
       sum+=(alives ? alive(WorldOld[right]) : WorldOld[right]);
       
       if(far)
       {
         int morer = (i+2) % WorldSize;    
         int morel = (WorldSize+i-2) % WorldSize;
         sum+=(alives ? alive(WorldOld[morel]) : WorldOld[morel] );
         sum+=(alives ? alive(WorldOld[morer]) : WorldOld[morer] );             
       }
       
       WorldNew[i]=sum % Divider; //... taken then modulo DIVIDER
   }
   
   // NOW THE MOST IMPORTANT - Swap the arrays
   int[] WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp;
   
   t++; // The next generation/step/year
}


// https://github.com/borkowsk/bookProcessingEN
// https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/
// @date 2024-11-25 (revived)
