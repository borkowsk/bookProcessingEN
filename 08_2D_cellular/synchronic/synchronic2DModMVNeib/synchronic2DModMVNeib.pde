/// "Modulo from neighbors states"
/// TWO-dimensional, SYNCHRONOUS, vonNeuman/Moore, deterministic cellular automaton
//-/////////////////////////////////////////////////////////////////////////////////

final int     WorldSide=602;   //How many cells do we want in one line?
final int     FR = 10;         //Desired fps.
final float   Dens=0;          //.001; //0.5 or so also posible.

final int     Div=7;           //Divider for remainder operation.
final boolean vonNeuman=false; //With or without von Neumann neighbors.
final boolean withMoore=true;  //With or without Moore neighbors.
final boolean withMe=true;     //false or true

int[][] WorldOld=new int[WorldSide][WorldSide]; //We need two arrays for the old  .
int[][] WorldNew=new int[WorldSide][WorldSide]; //and new state of the simulation.

final boolean traceVA=false; //virgin areas trace ON/OFF.


void setup()
{
  size(601,621);    //square window
  frameRate(FR);  
  noSmooth();
  
  initialisation();
}


void initialisation() ///< set up the world
{
  if(Dens>0)
  {
    for(int i=0;i<WorldOld.length;i++) 
      for(int j=0;j<WorldOld.length;j++) 
      {
        if( !traceVA ) 
          WorldNew[i][j]=-1; //Something different from any possible state
        
        if(random(1.0)<Dens)
          WorldOld[i][j]=int(random(Div));
        else
          WorldOld[i][j]=0;
      }
  }
  else
  {
    if( !traceVA )
      for(int i=0;i<WorldOld.length;i++)
        for(int j=0;j<WorldOld.length;j++) 
          WorldNew[i][j]=-1;//Something different from any possible state
        
    WorldOld[WorldOld.length/2][WorldOld.length/2]=1;
  }
}


void visualisation()
{
  for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++)
      //Print only when changed!!!
      if( WorldOld[i][j] != WorldNew[i][j] ) //WorldNew have step-1 content after swap 
      {
        switch(WorldOld[i][j]) {
        case 6:stroke(128,255,255);break;
        case 5:stroke(128,128,255);break;
        case 4:stroke(0,128,0);break;
        case 3:stroke(128,128,0);break;
        case 2:stroke(255,0,0);break;
        case 1:stroke(0,0,255);break;
        case 0:stroke(0,0,0);break;
        default: stroke(255,255,255); //emergency color
        //case N:stroke( , , );break; //for more colors
        break;
        }
        
        point(i,j); //or j,i ?
     }//end if    
}

int t=0;

void draw() // global t,WorldOld,WorldNew
{  
  visualisation();
  
  for(int i=0;i<WorldSide;i++) //Now the cellular automaton state change
  {
    //RULE - modulo from states
    int right = (i+1) % WorldSide;          
    int left  = (WorldSide+i-1) % WorldSide;
     
    for(int j=0;j<WorldSide;j++) 
    {
      int dw=(j+1) % WorldSide;   
      int up=(WorldSide+j-1) % WorldSide;
      
      int states=(withMe ?  WorldOld[i][j] : 0); //Self
      
      if(vonNeuman)
        states +=( // von Neumann
               +  WorldOld[left][j]
               +  WorldOld[right][j]
               +  WorldOld[i][up]
               +  WorldOld[i][dw] );
              
      if( withMoore )
        states +=( WorldOld[left][up]
               +  WorldOld[right][up]
               +  WorldOld[left][dw]
               +  WorldOld[right][dw] );
    
      WorldNew[i][j]=states % Div ; //New state 
    }
  }
   
  //Swap the arrays:
  int[][] WorldTmp=WorldOld;
  WorldOld=WorldNew;
  WorldNew=WorldTmp;
   
  t++; //The next generation/step/year
  textSize(18);
  fill(128);noStroke();             rect(0,height-20,width,20);
  fill(255);textAlign(LEFT,BOTTOM); text(str(t)+"("+frameRate+")",0,height);
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/
/// @date 2024-11-29 (revived)
