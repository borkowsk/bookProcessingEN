/// "Min-Opt-Max neighbors": Not too many neighbors, but not too few, but OPTIMAL!
/// TWO-dimensional, (A)SYNCHRONOUS, vonNeuman/Moore, deterministic cellular automaton
//-//////////////////////////////////////////////////////////////////////////////////
// See 233 (Conways Game of Life) or 123 & 234 - much more "biological"

final int     WorldSide=501;  //How many cells do we want in one line?
final boolean sync=true;      //Synchronous or asynchronous update    !!!!!!!

final float   Dens=100.00;    //When >=1, simetric horizontal line is created
final int     MinN=2;         //Minimal number of neighbors required
final int     OptN=3;         //The number of neighbors needed to revive the cell
final int     MaxN=3;         //Maximal number of neighbors required
final boolean withM=true;     //With Moore neighbors

final boolean traceVA=true; //virgin areas trace ON/OFF
int FR=100;

int[][] WorldOld=new int[WorldSide][WorldSide]; //We need two arrays for the old  
int[][] WorldNew=new int[WorldSide][WorldSide]; //and new state of the simulation

void setup()
{
  size(501,521);    //square window
  background(64);
  noSmooth();
  frameRate( FR>0 ? FR : Dens );  

  initialisation();
}

int t=0; // time is global

void draw() // modifies global t
{  
  if(sync)
  {
     visualisationSY(); //Visualisation for synchronous mode
     synchronicStep();
  } 
  else
  {
     visualisationAS(); //Visualisation for asynchronous mode
     stepMonteCarlo();
  }
   
  status(); //Status bar
  t++;      //The next generation/step/year
}

void status()
{
  fill(128);noStroke();
  rect(0,height-20,width,20);
 
  fill(255);textSize(18);textAlign(LEFT,BOTTOM);
  text(str(t)+" ("+ nf(frameRate,3,2) +") "+liveCounter,0,height);
}

void initialisation()
{
  if(Dens<1)
  {
   for(int i=0;i<WorldSide;i++) //Initialisation
    for(int j=0;j<WorldSide;j++)
    {
      if(!traceVA) 
          WorldNew[i][j]=-1; //Something different from any possible state
      
      if(random(1.0)<Dens)
        WorldOld[i][j]=1;
    }
  }
  else
  {  // Initialisation for testing an emergent properties of CA
     int off=-0;
     for(int j=1;j<int(Dens);j++)
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
    if( WorldOld[i][j] != WorldNew[i][j] ) //now WorldNew have step-1 content!!!
    {
      if(WorldOld[i][j]>0) 
        stroke(255,0,100);
      else           
        stroke(0);
      point(j,i); //the horizontal dimension of the array is the SECOND index
    }
}

void visualisationAS()
{
  for(int i=0;i<WorldSide;i++)
   for(int j=0;j<WorldSide;j++)
    if(WorldNew[i][j] == -1 )
    {
      if(WorldOld[i][j]>0) stroke(255,0,100);
      else stroke(0);
      point(j,i); //the horizontal dimension of the array is the SECOND index
      WorldNew[i][j]=1; //READY
    }
}

int liveCounter=0; //The only statistics for the model so far

void synchronicStep() // uses global WorldOld,WorldNew
{
  liveCounter=0; //Reset the only statistic
  for(int i=0;i<WorldSide;i++) //Now the cellular automaton state change
  {
     // RULE: Not too many neighbors, not too few, but optimal
     int right = (i+1) % WorldSide;          
     int left  = (WorldSide+i-1) % WorldSide;
     
     for(int j=0;j<WorldSide;j++) 
     {
       int dw=(j+1) % WorldSide;   
       int up=(WorldSide+j-1) % WorldSide;
       
       int lives = (
                   WorldOld[left][j]+WorldOld[right][j]+WorldOld[i][up]+WorldOld[i][dw]
                   +(withM ? WorldOld[left][up]+WorldOld[right][up]+WorldOld[left][dw]+WorldOld[right][dw] : 0)
                   );
               
       if(WorldOld[i][j]==0)
         WorldNew[i][j]=(lives == OptN ? 1:0);
       else
         WorldNew[i][j]=(MinN <= lives && lives <=MaxN ? 1:0 ); //New state 
       
       if(WorldNew[i][j]>0) 
             liveCounter++; //Calculating the only statistic
     }
  }
   
  // Swap the arrays
  int[][] WorldTmp=WorldOld;
  WorldOld=WorldNew;
  WorldNew=WorldTmp;
}

void stepMonteCarlo() // uses global WorldOld,WorldNew
{
  liveCounter=0; // Reset the only statistic
  final int N=WorldSide*WorldSide;
  for(int a=0;a<N;a++)
  {
       int i=int(random(WorldSide)),j=int(random(WorldSide)); //draw the agent's indexes
       
       //Rule: "Min-Best-Max neighbors"
       int right = (i+1) % WorldSide;      
       int left  = (WorldSide+i-1) % WorldSide;
       int dw=(j+1) % WorldSide;   
       int up=(WorldSide+j-1) % WorldSide;
       
       int lives = ( //sum of living neighbors = sum of states of neighbors (states 0 and 1 only)
                 WorldOld[left][j]+WorldOld[right][j]+WorldOld[i][up]+WorldOld[i][dw]        
                 // corners:
                 + (withM ? WorldOld[left][up]+WorldOld[right][up]+WorldOld[left][dw]+WorldOld[right][dw]: 0 )
                 ); 
       
       // Implementation of the rule  
       int State=WorldOld[i][j];
       if(State==0)
           WorldOld[i][j]=(lives == OptN ? 1:0);
       else
           WorldOld[i][j]=(MinN <= lives && lives <=MaxN ? 1:0 );//New state 
         
       if(State!=WorldOld[i][j]) 
           WorldNew[i][j]=-1; //Force painting changed points.
       
       if(WorldOld[i][j]>0) liveCounter++; //Calculating the only statistic
   }
}

/// @date 2024-12-01 (https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/)
