//Two-dimensional, DETERMINISTIC cellular automaton - "SUM WITH NEIGHBOR AND TAKE MODULO" rule. Synchronous steps
// ON A HEXAGONAL GRID
//========================
int WorldSize=27; //How many elements do we want in a line?
float IDens=0.00; //Initial density in the array (0 means initialization in the middle)
int Div=5;

int[][] World=new int[WorldSize][WorldSize];

float CellSize=22; //We will use the ability to specify screen coordinates as `float`

void settings() // A SPECIAL FUNCTION THAT ALLOWS YOU TO USE AN EXPRESSION DETERMINING WINDOW SIZES AND OTHER WINDOW SETTINGS
{
   //noSmooth(); //If there is a `settings()` function, this command must be in it before calling `size()`
   //Window aspect ratio 3:2
   size(int(WorldSize*1.5*CellSize),int(WorldSize*CellSize) ); // Tu akurat parametry muszą być typu `int`
}

void setup() /// CLASSIC `setup()` IS RUN AFTER `settings()`
{
  initialize(); // World initialization...
  visualize();  // and the first visualization of the world.
  visualise_connections(); //visualization of connections, i.e. possible interactions of cells
  frameRate(2);
}

void draw()
{
  if(frameCount<2) 
  {  
    delay(1000*3/*n*/); //For n-seconds, the initial state - i.e. visualization of connections
    background(8);
  }
  change();     // changing the state of the world...
  visualize();  // and another visualization of the world
  fill(255);
  text("ST:"+frameCount,0,10);
}

void initialize() /// World initialization
{
  if(IDens>0)
  {
   for(int i=0;i<World.length;i++) //Seeding the array
    for(int j=0;j<World.length;j++) 
     if(random(1.0)<IDens)
       World[i][j]=int(random(Div));
  }
  else
  {
    World[WorldSize/2][WorldSize/2]=int(random(Div)); // Only one seed.
  }
}

// hexagon(center x-coordinate, center y-coordinate, width, height)
// Source: https://forum.processing.org/two/discussion/21083/creating-a-simple-function-to-draw-a-hexagon.html
void hexagon(float x, float y, float gsX, float gsY) ///< "Tool" for drawing a hexagon
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

void visualize() /// Visualization of the world
{
  noStroke();
  for(int i=0;i<World.length;i++)
  for(int j=0;j<World.length;j++) 
  {
    switch(World[i][j]){ //The selection statement allows us to select any color depending on the number in the cell
    case 3:fill(128,128,0);break;
    case 2:fill(255,0,0);break;
    case 1:fill(0,0,255);break;
    case 0:fill(0,0,0);break;
    default:
           fill(0,255,0); //This shouldn't appear!
    break;
    }
    
    //We will use the ability to specify screen coordinates as `float`
    float offsetY=CellSize*0.5; //Half the height of the ellipse
    float offsetX=offsetY*1.5;  //Half the width of the ellipse
    float lineIsEven=(j%2==0?offsetX:0); //Each even row will be offset more!
    float X=offsetX+i*1.5*CellSize+lineIsEven;
    float Y=offsetY+j*CellSize;
    hexagon(X,Y,CellSize*1.5,CellSize);   //hexagons represent cells
    //ellipse(X,Y,CellSize*1.5,CellSize); //or ellipses represent cells
    //stroke(255,255,0);point(X,Y);noStroke(); //Centers of ellipses
  }
}

void visualise_connections() /// Connection visualization
{
  for(int i=1;i<World.length-1;i++)
  for(int j=0;j<World.length-1;j++) 
  {    
    //We will again use the option of specifying screen coordinates as `float`
    float offsetY=CellSize*0.5; //Half the height of the ellipse
    float offsetX=offsetY*1.5;  //Half the width of the ellipse
    float X=offsetX+i*1.5*CellSize+(j%2==0?offsetX:0);
    float Y=offsetY+j*CellSize;
    
    int right = (i+1) % WorldSize;      
    int left  = (WorldSize+i-1) % WorldSize;
    int dw    = (j+1) % WorldSize;
    //int up    = (WorldSize+j-1) % WorldSize;
    int add   = (j%2==0 ?  right   //even
                        :  left    //odd
                        );
    stroke(255,0,255);
    float X1=offsetX+right*1.5*CellSize+(j%2==0?offsetX:0);
    line(X,Y,X1,Y);
    
    if(i==1)
    {
       stroke(255,0,0);
       X1=offsetX+left*1.5*CellSize+(j%2==0?offsetX:0);
       line(X,Y,X1,Y);
    }
    
    // Different color for even and odd rows
    if(j%2==0) stroke(0,255,255);
    else stroke(255,255,0);             
    
    //World[add][dw]
    float Y1=offsetY+dw*CellSize;
    X1=offsetX+i*1.5*CellSize+(dw%2==0?offsetX:0);
    line(X,Y,X1,Y1);
    //World[i][dw]
    X1=offsetX+add*1.5*CellSize+(dw%2==0?offsetX:0);
    line(X,Y,X1,Y1);
  }
}

void change() /// changing the state of the world - here asynchronous Monte Carlo
{
  for(int a=0;a<World.length*World.length;a++)//As many draws as cells
  {
       //Cell/agent randomization
       int i=(int)random(World.length);
       int j=(int)random(World.length);
       
       //Rule - "SUM WITH YOUR NEIGHBORS AND TAKE THE MODULO"
       int right = (i+1) % WorldSize;      
       int left  = (WorldSize+i-1) % WorldSize; 
       int dw    = (j+1) % WorldSize;
       int up    = (WorldSize+j-1) % WorldSize;
       int add   = (j%2==0 ?  right   //the even row additionally takes the upper and lower left neighbors
                           :  left    //the odd row also takes right-handers 
                           );
       int ile = World[i][j]
                 +World[left][j]
                 +World[right][j]
                 +World[i][up]
                 +World[add][up] // additional upper
                 +World[i][dw]  
                 +World[add][dw] // additional lower
                 ; //the sum of seven taken then modulo `Div`
      
        World[i][j]=ile % Div;//We save the new state to the world table
   }
}

//////////////////////////////////////////////////////////////////////////////////
// Autor: Wojciech T. Borkowski
// Materials for the textbook "Processing in education and simulation
// https://github.com/borkowsk/sym4processing/tree/master/ProcessingWEdukacji
//////////////////////////////////////////////////////////////////////////////////
