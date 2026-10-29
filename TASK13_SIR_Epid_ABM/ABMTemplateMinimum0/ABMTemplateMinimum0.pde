//   ABM minimum template - using template for AGENT BASE MODEL in 2D discrete geometry
//   >>>> only necessary modules of full template <<<<
//   @author Wojciech Borkowski
//-///////////////////////////////////////////////////////////////////////////////////////

//Model parameters
int side=75; //side length of the main matrix
String modelName="ABMTemplateMin";
float density=0.75;

World TheWorld=new World(side); //will be fully initialized inside setup()

//Visualization parameters etc...
int cwidth=15; //length of the cell side in the visualization
int STATUSHEIGH=40;

int STEPSperVIS=1; //How often to visualize?
int FRAMEFREQ=10; //Update less frequently or more frequently
//boolean WITH_VIDEO=false; //Should we make a movie based on the simulation?
boolean simulationRun=true; //Start/Stop flag

void setup()
{
  //Graphics
  size(750,790);
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //Model
  initializeModel(TheWorld); //Completing model initialization
  //initializeStats(); //For statistical purposes
  //doStatistics(TheWorld);
  
  //Window size calculation
  println("REQUIRED SIZE OF PAINTING AREA IS "+(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
  cwidth=(height-STATUSHEIGH)/side;
  
  //FOR RTMVideo.pde UNIT
  //if(WITH_VIDEO) {initVideoExport(this,modelName+".mp4",FRAMEFREQ);FirstVideoFrame();}
  
  //Completing the configuration stage
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height); //-myMenu.bounds.height???
  visualizeModel(TheWorld); //FOR RTMVideo.pde UNIT - First time visualization
  
  //if(!simulationRun) //FOR RTMEvents.pde UNIT
  //  println("PRESS 'r' or 'ESC' to start simulation");
  //else
  //  println("PRESS 's' or 'ESC' to pause simulation");
  
  //NextVideoFrame(); //FOR RTMVideo.pde - Uses internal variable to check if animation is enabled
}

void draw()
{
  if(simulationRun)
  {
    modelStep(TheWorld);
    //doStatistics(TheWorld);
  }
  
  writeStatusLine();
  
  if(!simulationRun //Only visualization should work after pausing the simulation
  || StepCounter % STEPSperVIS == 0 ) //When the model is running, visualization should only be performed every few steps
  {
    visualizeModel(TheWorld);
    //NextVideoFrame(); //FOR RTMVideo.pde UNIT - Uses internal variable to check if animation is enabled
  }

}

void writeStatusLine()
{
  fill(255);rect(0,side*cwidth,width,STATUSHEIGH);
  fill(0);noStroke();
  //textAlign(LEFT, TOP);
  //text(meanDummy+"  "+liveCount,0,side*cwidth); //MOST IMPORTANT STATISTICS
  textAlign(LEFT, BOTTOM);
  text(StepCounter+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

//-/////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM MAIN TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
