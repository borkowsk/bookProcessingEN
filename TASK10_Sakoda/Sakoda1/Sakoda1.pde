//   Sakoda inspired AGENT BASE MODEL utilized 1D or 2D dicrete geometry
//   implemented by Wojciech Borkowski
/////////////////////////////////////////////////////////////////////////////////////////

//Model parameters
int side=100;//side of main table
String modelName="ABMSakoda";
float density=0.55;

World TheWorld=new World(side);//... but also will be initialised inside setup()

//Parameters of visualisation etc...
int cwidth=8;//size of cell
int STATUSHEIGH=40;
int STEPSperVIS=1;
int FRAMEFREQ=20;
boolean WITH_VIDEO=false;
boolean simulationRun=true;//Start/stop flag

void setup()
{
  //Graphics
  size(800,840);
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //Model
  TheWorld.initializeModel();
  initializeStats();//Wykomentowanie blokuje tworzenie pliku log!
  TheWorld.makeStatistics();
  
  //Window 
  println("REQUIRED SIZE OF PAINTING AREA IS "+(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
  cwidth=(height-STATUSHEIGH)/side;
    
  if(WITH_VIDEO) 
  {
    initVideoExport(this,modelName+".mp4",FRAMEFREQ);
    FirstVideoFrame();
  }
  
  //Finishing setup stage
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height);//-myMenu.bounds.height???
  visualizeModel(TheWorld);//First time visualisation
  if(!simulationRun)
    println("PRESS 'r' or 'ESC' to start simulation");
  else
    println("PRESS 's' or 'ESC' to pause simulation");
  NextVideoFrame();//It utilise inside variable to check if is enabled
}

void draw()
{
  if(simulationRun)
  {
    TheWorld.modelFullStep();
  }
  
  writeStatusLine();
  
  if(!simulationRun //When simulation was stopped only visualisation should work
  || TheWorld.getTimeStep() % STEPSperVIS == 0 ) //But when model is running, visualisation shoud be done from time to time
  {
    visualizeModel(TheWorld);
    NextVideoFrame();//It utilise inside variable to check if is enabled
  }

}

void writeStatusLine()
{
  fill(255);noStroke();
  rect(0,side*cwidth,width,STATUSHEIGH);
  
  fill(0);textAlign(LEFT, TOP);
  text(liveCount+"  "+meanStress,0,side*cwidth);
  textAlign(LEFT, BOTTOM);
  text(TheWorld.getTimeStep()+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

///////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM SAKODA MAIN 
///////////////////////////////////////////////////////////////////////////////////////////
