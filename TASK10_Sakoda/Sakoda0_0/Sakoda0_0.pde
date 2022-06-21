/// Sakoda inspired asynchronous AGENT BASE MODEL 
/// utilized 2D discrete geometry (but prepared also for 1D)
//*//////////////////////////////////////////////////////////

// Model parameters
int side=50; //side of main table
String modelName="Sakoda0ABM";
float density=0.55;

// Parameters of visualisation etc...
int cwidth=16; //size of cell
int STATUSHEIGH=40; //Height of the status bar
int STEPSperVIS=1; //How often to visualize the simulation world?
int FRAMEFREQ=5; //Expected speed of the animation

World TheWorld=new World(side); //Create a simulation world
              //Which still needs to be initialized in the setup()

void setup()
{
  // Graphics initialization
  size(800,840); //Variables cannot be used here unfortunately :-(
  background(255,255,200); //They can already be used here, but what for?
  strokeWeight(2);
  frameRate(FRAMEFREQ); //It will come in handy here...
  
  // Does the window size match the program's expectations?
  println("REQUIRED SIZE OF PAINTING AREA IS ",
          (cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
  println("CURRENT SIZE OF PAINTING AREA IS ",
                  width+"x"+height);
  cwidth=(height-STATUSHEIGH)/side; //Adjusting the size of the agents. 
         //At most, the entire window will not be filled.
  
  // Finally, we deal with the MODEL itself
  TheWorld.initializeModel(); //Initialisation of the World
  visualizeModel(TheWorld); //The first visualization
}

void draw()
{
  TheWorld.modelStep(); //The next simulation step
    
  // Visualization doesn't have to be at every step  
  if(TheWorld.StepCounter % STEPSperVIS == 0 )
    visualizeModel(TheWorld);
  
  // Drawing the status bar is not that expensive, so every step.
  statusLine();
}

void statusLine()
{
  fill(255);noStroke();
  // Cleaning is the most expensive, so let's cut it down!
  rect(0,side*cwidth,width/6,STATUSHEIGH);
  fill(0);textAlign(LEFT, TOP);
  textAlign(LEFT, BOTTOM);
  // Not much to write yet
  text(TheWorld.StepCounter+")  Fps:"+frameRate,0,side*cwidth+STATUSHEIGH-2);
}

// Expected interface for a world class
interface simulation_world // For documentation only
{
  void   initializeModel();
  void   changeState();
  void   makeStatistics();
  void   modelFullStep();
  float  getTimeStep();
};

//*/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM SAKODA0 MAIN 
//  https://github.com/borkowsk/bookProcessingEN
//*/////////////////////////////////////////////////////////////////////////////////////////
