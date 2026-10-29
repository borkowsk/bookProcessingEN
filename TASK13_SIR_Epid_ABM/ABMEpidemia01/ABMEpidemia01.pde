// ABM minimum template - using template for AGENT BASE MODEL in 1D & 2D discrete geometry
//   >>>> ONLY THE ESSENTIAL MODULES OF THE ABM TEMPLATE <<<<
// @author Wojciech Borkowski
//-///////////////////////////////////////////////////////////////////////////////////////

//MODEL PARAMETERS
int side=200; //LENGTH OF THE SIDE OF THE WORLD
String modelName="ABMEpidemia";
float density=0.66;

World TheWorld=new World(side); //INITIALIZATION IS COMPLETED 
                               //IN THE setup() FUNCTION

//STAŁE MODELU
final int Duration=7; //Infection duration
//final int Empty=0; //UNNECESSARY. Instead, there is a null in the cell of the array of agent handles.
final int Susceptible=1;
final int Infected=2;
final int Recovered=Infected+Duration;
final float PTransfer=0.330; //Probability of infecting an agent in a single interaction
final float PDeath=0.05;    //Average probability of death in one day of illness duration

//STATISTICS CALCULATED DURING THE SIMULATION
int liveCount=0;
int sumInfected=0; //Number of successful infections
int sumRecovered=0; //Number of recoveries
int sumDeath=0; //Number of deaths
                               
//VISUALIZATION PARAMETERS, STATISTICS, ETC.
int cwidth=3; //CELL SIDE LENGTH IN VISUALIZATION
              // - THE VALUE GIVEN HERE IS ONLY PROVISIONAL
int STATUSHEIGH=40; //HEIGHT OF THE STATUS BAR AT THE BOTTOM OF THE WINDOW

int STEPSperVIS=1; //HOW OFTEN DO WE RUN THE VISUALIZATION
int FRAMEFREQ=10; //HOW MANY TIMES PER SECOND DOES draw() RUN?

//boolean WITH_VIDEO=false; //DO WE WANT TO SAVE TO A MOVIE FILE (requires RTMVideo.pde module)
boolean simulationRun=true; //SIMULATION OPERATIONS FLAG (Start/Stop) 

void setup()
{
  //GRAPHICS BELOW
  size(600,640); //UNFORTUNATELY, ONLY LITERAL VALUES CAN BE PRESENTED HERE ("LITERALS")
  noSmooth();   //Significantly speeds up visualizations
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //INITIALIZATION OF THE MODEL AND (OPTIONALLY) STATISTICS
  initializeModel(TheWorld); //COMPLETE WORLD INITIALIZATION
  //initializeStats();      //UNCOMMENT THIS IF USING STATISTICS
  //doStatistics(TheWorld); //as above
  
  //CALCULATE THE REQUIRED WINDOW SIZE FOR size()
  println(modelName+": REQUIRED SIZE OF PAINTING AREA IS "
          +(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
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
  }                          //Uses an internal flag to determine whether the log has been opened
  
  writeStatusLine();
  
  if(!simulationRun //Only visualization should work after pausing the simulation
  || StepCounter % STEPSperVIS == 0 ) //When the model is running, visualization should only be performed every few steps
  {
    visualizeModel(TheWorld);
    //NextVideoFrame(); //ANIMATION FRAME RECORDING FUNCTION. 
  }                    //Uses an internal flag to determine if the movie has started

}

void writeStatusLine()
{
  fill(255);rect(0,side*cwidth,width,STATUSHEIGH);
  fill(0);noStroke();
  textAlign(LEFT, TOP);
  text(liveCount+" Zachorowali:"+sumInfected+" Wyzdrowieli:"+sumRecovered+" Umarli:"+sumDeath,
       0,side*cwidth); //A place for the MOST IMPORTANT STATISTICS
  println("ST:"+StepCounter+"\tZ\t"+sumInfected+"\tW\t"+sumRecovered+"\tU\t"+sumDeath);
  textAlign(LEFT, BOTTOM);
  text(StepCounter+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

//-/////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM MAIN TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
