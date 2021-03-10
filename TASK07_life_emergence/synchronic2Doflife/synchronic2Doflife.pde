// "Min-Opt-Max neighbors": Not too many neighbors, but not too few, but OPTIMAL!
// TWO-dimensional, SYNCHRONOUS, vonNeuman/Moore, deterministic cellular automaton
////////////////////////////////////////////////////////////////////////////////////
// See 233 (Conways Game of Life) or 123 & 234 - much more "biological"
final int     WorldSide=1001;//How many cells do we want in one line?
final float   Dens=200.05;//When >=1, simetric horizontal line is created
final int     MinN=2;//Minimal number of neighbors required
final int     OptN=3;//The number of neighbors needed to revive the cell
final int     MaxN=3;//Maximal number of neighbors required
final boolean withM=true;//With Moore neighbors
final boolean sync=true;//Synchronous or asynchronous update

int[][] WorldOld=new int[WorldSide][WorldSide];//We need two arrays for the old  
int[][] WorldNew=new int[WorldSide][WorldSide];//and new state of the simulation

final boolean traceVA=true;//virgin areas trace ON/OFF
int FR=100;

void setup()
{
  size(1001,1021);    //square window
  background(255);
  noSmooth();
  frameRate( FR>0 ? FR : Dens );  

  initialisation();
}

int t=0;
void draw()
{  
   if(sync)
   {
     visualisationSY();
     synchronicStep();
   } 
   else
   {
     visualisationAS();
     stepMonteCarlo();
   }
   
   t++;//The next generation/step/year
   fill(128);noStroke();rect(0,height-20,width,20);
   fill(255);textSize(18);textAlign(LEFT,BOTTOM);text(t+" ("+ nf(frameRate,3,2) +") "+liveCounter,0,height);
}

void initialisation()
{
  if(Dens<1)
  {
   for(int i=0;i<WorldSide;i++) //Initialisation
    for(int j=0;j<WorldSide;j++)
    {
      if(!traceVA) 
          WorldNew[i][j]=-1;//Something different from any possible state
      
      if(random(1.0)<Dens)
        WorldOld[i][j]=1;
    }
  }
  else
  {  //Initialisation for testing an emergent properties of CA
     int off=-0;
     for(int j=1;j<Dens;j++)
     {
        WorldOld[off+WorldSide/2][off+WorldSide/2+j]=1;
        WorldOld[off+WorldSide/2][off+WorldSide/2-j]=1;
     }
     WorldOld[off+WorldSide/2][off+WorldSide/2]=1;
  }
}

void visualisationSY()
{
  for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++)
    if( (WorldOld[i][j] != WorldNew[i][j]) ) //now WorldNew have step-1 content!!!
    {
      if(WorldOld[i][j]>0) stroke(255,0,100);
      else           stroke(0);
      point(j,i);//the horizontal dimension of the array is the SECOND index
    }
}

void visualisationAS()
{
  for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++)
    {
      if(WorldOld[i][j]>0) stroke(255,0,100);
      else           stroke(0);
      point(j,i);//the horizontal dimension of the array is the SECOND index
    }
}

int liveCounter=0;//The only statistics for the model so far

void synchronicStep()
{
  liveCounter=0;//Reset the only statistic
  
  for(int i=0;i<WorldSide;i++)//Now the cellular automaton state change
  {
       //RULE: Not too many neighbors, not too few, but optimal
       int right = (i+1) % WorldSide;          
       int left  = (WorldSide+i-1) % WorldSide;
       
       for(int j=0;j<WorldSide;j++) 
       {
         int dw=(j+1) % WorldSide;   
         int up=(WorldSide+j-1) % WorldSide;
         
         int lives = WorldOld[left][j] + WorldOld[right][j]
                 +  WorldOld[i][up] +  WorldOld[i][dw]
                 + (withM ?
                    WorldOld[left][up] +  WorldOld[right][up]
                 +  WorldOld[left][dw] +  WorldOld[right][dw]    
                 : 0)
                 ;
                 
         if(WorldOld[i][j]==0)
           WorldNew[i][j]=(lives == OptN ? 1:0);
         else
           WorldNew[i][j]=(MinN <= lives && lives <=MaxN ? 1:0 );//New state 
         
         if(WorldNew[i][j]>0) liveCounter++;//Calculating the only statistic
       }
   }
   
   //Swap the arrays
   int[][] WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp;
}

void stepMonteCarlo()
{
  liveCounter=0;//Reset the only statistic
  
  for(int N=WorldSide*WorldSide,a=0;a<N;a++)
  {
       //draw the agent's indexes
       int i=(int)random(WorldSide);
       int j=(int)random(WorldSide);
       
       //Rule: "Min-Best-Max neighbors"
       int right = (i+1) % WorldSide;      
       int left  = (WorldSide+i-1) % WorldSide;
       int dw=(j+1) % WorldSide;   
       int up=(WorldSide+j-1) % WorldSide;
       
       int lives =  WorldOld[left][j] + WorldOld[right][j]
                + WorldOld[i][up] + WorldOld[i][dw]        
                // corners:
                + (withM ?
                + WorldOld[left][up] + WorldOld[right][up]
                + WorldOld[left][dw] + WorldOld[right][dw]
                : 0 )
                ;//sum of living neighbors 
                //= sum of states of neighbors (states 0 and 1 only)
                                                                                         //WorldNew[i][j]=WorldOld[i][j];//Forcing painting o this point. Not work properly :-( 
         //Implementation of the rule
         if(WorldOld[i][j]==0)
           WorldOld[i][j]=(lives == OptN ? 1:0);
         else
           WorldOld[i][j]=(MinN <= lives && lives <=MaxN ? 1:0 );//New state 
         
         if(WorldOld[i][j]>0) liveCounter++;//Calculating the only statistic
   }
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/
