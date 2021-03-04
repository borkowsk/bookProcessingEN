// "Voter model" <=> "Nearest Neighbors Social Impact"
// Two-dimensional, asynchronous cellular automaton
////////////////////////////////////////////////////////////////////////////////////
final int WorldSide=600;//Side lenght of simulation world (square)
final float Dens=0.50;//.01;//Initial density in the lattice World
final boolean withMoore=true;//neighborhood with the corners of the square

int[][] World=new int[WorldSide][WorldSide];//2 dimensional array <=> "matrix" or "lattice" 
                                            
int FR=100;//desired simulation speed

void setup()
{
 size(600,600); //squre canvas
 noSmooth();    //much faster drawing
 frameRate(FR);
  
 for(int i=0;i<WorldSide;i++) 
    for(int j=0;j<WorldSide;j++) 
      if(random(1.0)<Dens)
        World[i][j]=1;
}

void visualisation()
{
   for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++) 
    {                      
      switch(World[i][j]){ 
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
  
  // Monte Carlo step
  int N=WorldSide*WorldSide;
  for(int a=0;a<N;a++)
  {
       int i=(int)random(WorldSide);
       int j=(int)random(WorldSide);
       
       int right = (i+1) % WorldSide;      
       int left  = (WorldSide+i-1) % WorldSide;
       int dw=(j+1) % WorldSide;   
       int up=(WorldSide+j-1) % WorldSide;
       int cou0  = 0;//counter of 0 state neighbors
       int cou1  = 0;//counter of 1 state neighbors
       
       if(World[left][j]==0 )cou0++;else cou1++;
       if(World[right][j]==0)cou0++;else cou1++;
       if(World[i][up]==0)cou0++;else cou1++;
       if(World[i][dw]==0)cou0++;else cou1++; 
       if(withMoore)
       {
         if(World[left][up]==0)cou0++;else cou1++;
         if(World[right][up]==0)cou0++;else cou1++;
         if(World[left][dw]==0)cou0++;else cou1++;
         if(World[right][dw]==0)cou0++;else cou1++; 
       }
       if(World[i][j]==0)cou0++;else cou1++;
       
       //The rule of this automaton - you assume a state 
       //more common in your vicinity
       if(cou0>cou1)
         World[i][j]=0;
       else //What about == ?
         World[i][j]=1;
   }
      
   t++;//next step
   textSize(20);textAlign(LEFT,TOP);text("ST:"+t,0,0);
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
