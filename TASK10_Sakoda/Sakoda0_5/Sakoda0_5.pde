// Sakoda inspired asynchronous AGENT BASE MODEL utilized 1D or 2D dicrete geometry
/////////////////////////////////////////////////////////////////////////////////////////

//Model parameters
int side=50;//side of main table
String modelName="Sakoda0.5ABM";
float density=0.45;

//Parameters of visualisation etc...
int cwidth=8;//size of cell
int STATUSHEIGH=40;//Height of the status bar
int STEPSperVIS=1;//How often to visualize?
int FRAMEFREQ=20;//Expected simulation speed

World TheWorld=new World(side);//Create a simulation world, then initialize() in setup()

void setup()
{
  //Graphics initialization
  size(800,840);//Variables cannot be used here :-(
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //Does the window size match the program's expectations?
  println("REQUIRED SIZE OF PAINTING AREA IS "+(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height);
  cwidth=(height-STATUSHEIGH)/side;//Adjusting the size of the agents/cells 
  
  //Now model itself
  TheWorld.initializeModel();//Initialisation of the World
  visualizeModel(TheWorld);//The first visualization
}

void draw()
{
  modelStep(TheWorld);//BOTH SOLUTIONS ARE DEFINED
  //TheWorld.modelFullStep();
    
  if(TheWorld.getTimeStep() % STEPSperVIS == 0 )
    visualizeModel(TheWorld);//not always
    
  //Drawing the status bar every step.
  statusLine();
}

void statusLine()
{
  fill(255);noStroke();rect(0,side*cwidth,width/5,STATUSHEIGH);
  fill(0);
  textAlign(LEFT, TOP);text(liveCount+"  "+meanStress,0,side*cwidth);
  textAlign(LEFT, BOTTOM); text(TheWorld.getTimeStep()+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

interface simulation_world
{
  void   initializeModel();
  void   changeState();
  void   makeStatistics();
  void   modelFullStep();
  float  getTimeStep(); //"Getter" for simulation step
};

///////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM SAKODA0.5 MAIN 
///////////////////////////////////////////////////////////////////////////////////////////
