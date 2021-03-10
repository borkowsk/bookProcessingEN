// "Voter model" <=> "Nearest Neighbors Social Impact"
// Two-dimensional, synchronous cellular automaton
////////////////////////////////////////////////////////////////////////////////////
final int WorldSide=600;//Side lenght of simulation world (square)
final float Dens=0.50;//.01;//Initial density in the lattice World
final boolean withMoore=true;//neighborhood with the corners of the square

int[][] WorldOld=new int[WorldSide][WorldSide];
int[][] WorldNew=new int[WorldSide][WorldSide];

int FR=100;//desired simulation speed

void setup()
{
 size(600,600); //squre canvas
 noSmooth();    //much faster drawing
 frameRate(FR);
  
 for(int i=0;i<WorldSide;i++) 
    for(int j=0;j<WorldSide;j++) 
      if(random(1.0)<Dens)
        WorldOld[i][j]=1;
}

void visualisation()
{
   for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++) 
    {                      
      switch(WorldOld[i][j]){ 
      case 1:stroke(255,255,0);break;//Yellow
      case 0:stroke(0,0,0);break;
      default: stroke(255,0,0);//"emergency color" - RED
      break;
      } 
      point(i,j);
    }
}

int t=0;
void draw()
{  
  visualisation();
  
  for(int i=0;i<WorldSide;i++)
  {    
       int right = (i+1) % WorldSide;      
       int left  = (WorldSide+i-1) % WorldSide;
       for(int j=0;j<WorldSide;j++)
       {
         int dw=(j+1) % WorldSide;   
         int up=(WorldSide+j-1) % WorldSide;
         int cou0  = 0;//counter of 0 state neighbors
         int cou1  = 0;//counter of 1 state neighbors
         
         if(WorldOld[left][j]==0 )cou0++;else cou1++;
         if(WorldOld[right][j]==0)cou0++;else cou1++;
         if(WorldOld[i][up]==0)cou0++;else cou1++;
         if(WorldOld[i][dw]==0)cou0++;else cou1++; 
         if(withMoore)
         {
           if(WorldOld[left][up]==0)cou0++;else cou1++;
           if(WorldOld[right][up]==0)cou0++;else cou1++;
           if(WorldOld[left][dw]==0)cou0++;else cou1++;
           if(WorldOld[right][dw]==0)cou0++;else cou1++; 
         }
         if(WorldOld[i][j]==0)cou0++;else cou1++;
         
         //The rule of this automaton - you assume a state 
         //more common in your vicinity
         if(cou0>cou1)
           WorldNew[i][j]=0;
         else //What about == ?
           WorldNew[i][j]=1;
       }
   }
   
   //Swap the arrays
   int[][] WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp;
      
   t++;//next step
   fill(random(255),random(255),random(255));textSize(30);textAlign(LEFT,TOP);text("ST:"+t,0,0);
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
