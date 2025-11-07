/// Two-dimensional, DETERMINISTIC cellular automaton - "SUM WITH NEIGHBOR AND TAKE MODULO" rule. SYNCHRONOUS.
///  ON A HEXAGONAL GRID - Display optimized by a change table (Changed)
//=============================================================================

int WorldSize=302; //How many elements do we want in a line?
float IDens=0.0; //The initial density in the array
int   Div=7;     //What divisor in the automaton rule

int[][] WorldOld=new int[WorldSize][WorldSize]; //Creating tables - in Processing always using allocation!
int[][] WorldNew=new int[WorldSize][WorldSize];
boolean[][] Changed=new boolean[WorldSize][WorldSize]; //An array of change flags to draw

float CellSize=3;       //Cell height
int   FRAME_RATE_REQ=2; //How many frames per second would we like

void settings() //A SPECIAL FUNCTION THAT ALLOWS YOU TO USE AN EXPRESSION DETERMINING WINDOW SIZES AND OTHER WINDOW SETTINGS
{
  noSmooth(); //If there is a `settings()` function, this command must be in it and before `size()`
  //Window aspect ratio 3:2
  size(int(WorldSize*1.5*CellSize),int(WorldSize*CellSize) ); // Here, the parameters must be of type `int`
}

void setup()
{
  background(0); //Black window background
  if(IDens>0)
  {
    for(int i=0;i<WorldOld.length;i++) //Seeding the array
      for(int j=0;j<WorldOld.length;j++) 
      {
        Changed[i][j]=true;
        if(random(1.0)<IDens)
          WorldOld[i][j]=(int)(random(Div)); //you need to change the type (do a "cast"), because the array stores `int` and not `float`
        else
          WorldOld[i][j]=0;
      }
  }
  else
  {
    for(int i=0;i<WorldOld.length;i++) //Resetting the array
      for(int j=0;j<WorldOld.length;j++) 
      {
        Changed[i][j]=true;
        WorldOld[i][j]=0;
      }
    
    WorldOld[WorldSize/2][WorldSize/2]=1; //Only one planted inside
  }
  visualize();
  frameRate(FRAME_RATE_REQ);
}

void draw()
{  
  change();
  visualize();
  fill(0,0,0,128);rect(10,height-16,20*8,16);
  fill(255);
  text("ST: "+frameCount+" Fr: "+frameRate,10,height);
  //saveFrame("step-######.png");
}

/** "Tool" for drawing a hexagon:
 * hexagon(center x-coordinate, center y-coordinate, width, height) */
void hexagon(float x, float y, float gsX, float gsY) ///< Source: https://forum.processing.org/two/discussion/21083/creating-a-simple-function-to-draw-a-hexagon.html
{  
  float sqrt3=sqrt(3);
  gsX/=4;
  gsY/=3.5;
  beginShape();
  vertex(x - gsX, y - sqrt3 * gsY);
  vertex(x + gsX, y - sqrt3 * gsY);
  vertex(x + 2 * gsX, y);
  vertex(x + gsX, y + sqrt3 * gsY);
  vertex(x - gsX, y + sqrt3 * gsY);
  vertex(x - 2 * gsX, y);
  endShape(CLOSE);
}

void visualize() ///< Visualization of the world
{
  noStroke();
  for(int i=0;i<WorldOld.length;i++)
    for(int j=0;j<WorldOld.length;j++) 
    {
      switch(WorldOld[i][j]) {  //The selection statement allows us to select any color depending on the number in the cell
      case 0:fill(0,0,0);break; //A properly selected set of colors allows you to achieve interesting effects
      case 1:fill(0,255,0);break;
      case 2:fill(64,128,64);break;
      case 3:fill(128,64,128);break;
      case 4:fill(255,0,200);break;
      case 5:fill(64,0,255);break;
      case 6:fill(0,0,255);break;
      default: fill(255,255,255); //This shouldn't appear
      break;
      }
      
      //We will use the ability to specify screen coordinates as `float`
      float offsetY=CellSize*0.50; //Half the height of the ellipse/hexagon
      float offsetX=CellSize*0.75; //Half the width of the ellipse/hexagon
      float lineIsEven=(j%2==0?offsetX:0); //The even row will be offset more!
      float X=offsetX+i*1.5*CellSize+lineIsEven;
      float Y=offsetY+j*CellSize;
      hexagon(X,Y,CellSize*1.5,CellSize); //hexagons representing cells
      //ellipse(X,Y,S*1.5,S); //or plain ellipses represent cells
      //stroke(255,255,0);point(X,Y);noStroke(); //Centers of ellipses/hexagons
    }
}

//change of the state of the world - here, synchronous
void change() ///< modifies global WorldOld,WorldNew
{
  for(int i=0;i<WorldOld.length;i++)
  {
     //RIGHT AND LEFT IS THE SAME FOR THE ENTIRE COLUMN
     //counting neighbor indexes with wrapping thanks to the remainder of division
     int right = (i+1) % WorldSize;         
     int left  = (WorldSize+i-1) % WorldSize;
     
     for(int j=0;j<WorldOld.length;j++) 
     {
       //Rule - "SUM WITH YOUR NEIGHBORS AND TAKE THE MODULO"
       int dw  = (j+1) % WorldSize;   
       int up  = (WorldSize+j-1) % WorldSize;
       // the even row additionally takes its left neighbors, but the odd row additionally takes its right neighbors
       int add = (j%2==0 ?  right :  left  );
       int ile = ( WorldOld[i][j]
               +WorldOld[left][j]
               +WorldOld[right][j]
               +WorldOld[i][up]
               +WorldOld[add][up] // additional top neighbor
               +WorldOld[i][dw]        
               +WorldOld[add][dw] // additional lower neighbor
               ); //the sum of seven taken then modulo `Div`
      
       WorldNew[i][j]=ile % Div; //We save the new state to the second board
       Changed[i][j]=(WorldNew[i][j] !=0 || WorldOld[i][j]!=0);// Does it need to be visualised?
     }
  }
   
  //Swithing arrays - easy because you don't have to copy data, just replace their "handles".
  int[][] WorldTmp=WorldOld;
  WorldOld=WorldNew;
  WorldNew=WorldTmp;
}

//*////////////////////////////////////////////////////////////////////////////////
// Author: Wojciech T. Borkowski
// Materials for the textbook "Processing in education and simulation
//*////////////////////////////////////////////////////////////////////////////////
/// @date 2025-11-07 (revived)
