// ABM minimum template - using template for AGENT BASE MODEL in 1D & 2D discrete geometry
//   >>>> ONLY THE ESSENTIAL MODULES OF THE ABM TEMPLATE <<<<
// @author Wojciech Borkowski
//-///////////////////////////////////////////////////////////////////////////////////////

//MODEL PARAMETERS
int side=75; //LENGTH OF THE SIDE OF THE WORLD
String modelName="ABMTemplateMin";
float density=0.75;

World TheWorld=new World(side); //THIS IS THE CONSTRUCTION, BUT INITIALIZATION IS COMPLETED IN THE setup() FUNCTION

//VISUALIZATION PARAMETERS, STATISTICS, ETC.
int cwidth=15; //CELL SIDE LENGTH IN VISUALIZATION - THE VALUE GIVEN HERE IS ONLY PROVISIONAL
int STATUSHEIGH=40; //HEIGHT OF THE STATUS BAR AT THE BOTTOM OF THE WINDOW

int STEPSperVIS=1; //HOW OFTEN DO WE RUN THE VISUALIZATION
int FRAMEFREQ=10; //HOW MANY TIMES PER SECOND DOES draw() RUN?
//boolean WITH_VIDEO=false; //DO WE WANT TO SAVE TO A MOVIE FILE (requires RTMVideo.pde module)
boolean simulationRun=true; //SIMULATION OPERATIONS FLAG (Start/Stop) 

void setup()
{
  //GRAPHICS BELOW
  size(750,790); //UNFORTUNATELY, ONLY LITERAL VALUES CAN BE PRESENTED HERE ("LITERALS")
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //INITIALIZATION OF THE MODEL AND (OPTIONALLY) STATISTICS
  initializeModel(TheWorld); //COMPLETE WORLD INITIALIZATION
  //initializeStats();      //UNCOMMENT THIS IF USING STATISTICS
  //doStatistics(TheWorld); //as above
  
  //CALCULATE THE REQUIRED WINDOW SIZE FOR size()
  println("REQUIRED SIZE OF PAINTING AREA IS "+(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
  cwidth=(height-STATUSHEIGH)/side; // HOWEVER, WE ADAPT THE SIZE OF THE CELLS TO THE WINDOW THAT IS
  
  //INITIALIZE ANIMATION RECORDING (if using RTMVideo.pde)
  //if(WITH_VIDEO) {initVideoExport(this,modelName+".mp4",FRAMEFREQ);FirstVideoFrame();}
  
  //CONSOLE INFO AT THE END OF THE setup() FUNCTION
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height); //-myMenu.bounds.height???
  visualizeModel(TheWorld); //FIRST WORLD VISUALIZATION AFTER INITIALIZATION
  
  //if(!simulationRun) //REQUIRES RTMEvents.pde MODULE
  //  println("PRESS 'r' or 'ESC' to start simulation");
  //else
  //  println("PRESS 's' or 'ESC' to pause simulation");
  
  //NextVideoFrame(); //FIRST REAL ANIMATION FRAME (if we use RTMVideo.pde)
}

void draw()
{
  if(simulationRun)
  {
    modelStep(TheWorld);
    //doStatistics(TheWorld); //UNCOMMENT THIS IF USING STATISTICS
  }
  
  writeStatusLine();
  
  if(!simulationRun //Only visualization should work after pausing the simulation
  || StepCounter % STEPSperVIS == 0 ) //When the model is running, visualization should only be performed every few steps
  {
    visualizeModel(TheWorld);
    //NextVideoFrame(); //Uses internal variable to check if animation is enabled
  }

}

void writeStatusLine()
{
  fill(255);rect(0,side*cwidth,width,STATUSHEIGH);
  fill(0);noStroke();
  //textAlign(LEFT, TOP);
  //text(meanDummy+"  "+liveCount,0,side*cwidth); //A place for the MOST IMPORTANT STATISTICS
  textAlign(LEFT, BOTTOM);
  text(StepCounter+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM MAIN TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
