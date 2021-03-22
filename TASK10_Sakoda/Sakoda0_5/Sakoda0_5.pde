// Sakoda inspired asynchronous AGENT BASE MODEL utilized 1D or 2D dicrete geometry
/////////////////////////////////////////////////////////////////////////////////////////

//Model parameters
int side=100;//side of main table
String modelName="Sakoda0.5ABM";
float density=0.45;

//Parameters of visualisation etc...
int cwidth=8;//size of cell
int STATUSHEIGH=40;
int STEPSperVIS=1;
int FRAMEFREQ=20;

World TheWorld=new World(side);//... but also will be initialised inside setup()

void setup()
{
  //Graphics
  size(800,840);//Nie można użyć tu zmiennych :-(
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //Window 
  println("REQUIRED SIZE OF PAINTING AREA IS "+(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height);
  cwidth=(height-STATUSHEIGH)/side;
  
  //Model
  TheWorld.initializeModel();//Initialisation of the World
  visualizeModel(TheWorld);//First time visualisation
}

void draw()
{
  modelStep(TheWorld);//OBA ROZWIĄZANIA SĄ ZDEFINIOWANE
  //TheWorld.modelFullStep();
    
  if(TheWorld.getTimeStep() % STEPSperVIS == 0 ) //But when model is running, visualisation shoud be done from time to time
    visualizeModel(TheWorld);

  statusLine();
}

void statusLine()
{
  fill(255);noStroke();rect(0,side*cwidth,width,STATUSHEIGH);
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
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM SAKODA0 MAIN 
///////////////////////////////////////////////////////////////////////////////////////////
