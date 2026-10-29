// ABM minimum template - using template for AGENT BASE MODEL in 1D & 2D discrete geometry
// @author Wojciech Borkowski
//-///////////////////////////////////////////////////////////////////////////////////////

//MODEL PARAMETERS
int side=200; //LENGTH OF THE SIDE OF THE WORLD
String modelName="ABMEpidemia";
float density=0.66;

World TheWorld; //=new World(side); //INITIALIZATION IS IN THE setup() FUNCTION

//"final" is something like constants ;-)
final int Duration=7; //Infection duration
//final int Empty=0; //UNNECESSARY. Instead, there is a null value in the agent handle array cell. 
final int Susceptible=1;
final int Infected=2;
final int Recovered=Infected+Duration;
final int Death=100;
//final float PTransfer=???;  //Probability of infecting an agent in a single interaction
                              //now it depends on the individual "immunity" value!
final float PDeath=0.015;     //Average probability of death in one day of illness duration

//STATISTICS CALCULATED DURING THE SIMULATION
int liveCount=0;

int  sumInfected=0; //Number of successful infections
int sumRecovered=0; //Number of recoveries
int     sumDeath=0; //Number of deaths

FloatList deaths=new FloatList(); //Death counter
FloatList newcas=new FloatList(); //New cases (infected)
FloatList  cured=new FloatList(); //Cured counter 

//VISUALIZATION PARAMETERS, STATISTICS, ETC.
int cwidth=1; //CELL SIDE LENGTH IN VISUALIZATION
             // - THE VALUE GIVEN HERE IS ONLY PROVISIONAL
int STATUSHEIGH=150; //HEIGHT OF THE STATUS BAR AT THE BOTTOM OF THE WINDOW

int STEPSperVIS=1; //HOW OFTEN DO WE RUN THE VISUALIZATION
int FRAMEFREQ=50; //HOW MANY TIMES PER SECOND DOES draw() RUN?

boolean WITH_VIDEO=false; //DO WE WANT TO SAVE TO A VIDEO FILE? (required RTMVideo.pde)
boolean simulationRun=true; //SIMULATION OPERATIONS FLAG (Start/Stop) 

void setup()
{
  //GRAPHICS BELOW
  float reqwidth=16*100;
  float reqheight=9*100;
  println("Wymagane rozmiary size(",reqwidth,",",reqheight,");");
  size(1600,900); //UNFORTUNATELY, ONLY LITERAL VALUES CAN BE PRESENTED HERE ("LITERALS")
  
  //OBLICZAMY WYMAGANE PARAMETRY OKNA 
  cwidth=(height-STATUSHEIGH)/side; // HOWEVER, WE ADAPT THE SIZE OF THE CELLS TO THE WINDOW THAT IS
  STATUSHEIGH=int(height*0.15);
  
  noSmooth();   //Significantly speeds up visualizations
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  //randomSeed(-1013); //Seeding a generator when a repeatable sequence is required, e.g., 107 or 1013.
  
  //INITIALIZATION OF THE MODEL AND (OPTIONALLY) STATISTICS
  int wside=width/cwidth;
  TheWorld=new World(side,wside); 
  initializeModel(TheWorld); //COMPLETING WORLD INITIALIZATION
  //initializeStats();      //UNCOMMENT THIS IF USING STATISTICS
  //doStatistics(TheWorld); //as above
  
   
  //INITIALIZE ANIMATION RECORDING (if using RTMVideo.pde)
  if(WITH_VIDEO) {initVideoExport(this,modelName+".mp4",FRAMEFREQ);FirstVideoFrame();}
  
  //CONSOLE INFO AT THE END OF THE setup() FUNCTION
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height); //-myMenu.bounds.height???
  visualizeModel(TheWorld); //FIRST WORLD VISUALIZATION AFTER INITIALIZATION
  
  //if(!simulationRun) //REQUIRES RTMEvents.pde MODULE
  //  println("PRESS 'r' or 'ESC' to start simulation");
  //else
  //  println("PRESS 's' or 'ESC' to pause simulation");
  
  NextVideoFrame(); //FIRST REAL ANIMATION FRAME (if we use RTMVideo.pde)
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
    NextVideoFrame(); //ANIMATION FRAME RECORDING FUNCTION. 
  }                    //Uses an internal flag to determine if the movie has started

}

void writeStatusLine()
{
  fill(0);
  rectMode(CORNERS);
  rect(0,cwidth*side,width,height);fill(128);
  rectMode(CORNER);
  histogram(TheWorld.agents,0,height-16,STATUSHEIGH-16); //Histogram by resistance to infection  
  textAlign(LEFT,TOP);
  text("Odporność",0,height-STATUSHEIGH);
   
  //legend and the histories of three daily variables, each on its own scale
  stroke(0,0,255);fill(0,0,200);text("nowi chorzy",300,height-STATUSHEIGH+16);
  //timeline(newcas,200,height,STATUSHEIGH-16,false);
  stroke(255,0,0);fill(200,0,0);text("nowi zmarli",300,height-STATUSHEIGH+32);
  //timeline(deaths,200,height,STATUSHEIGH-16,false);
  stroke(0,255,0);fill(0,200,0);text("nowo wyleczeni",300,height-STATUSHEIGH+48);
  //timeline(cured, 200,height,STATUSHEIGH-16,false);
  
  //Histories of three variables, each on a common scale
  fill(0,128,255); //Tylko kolor napisów tu możemy ustalić
  stroke(128);
  viewAxis(200,height-1,width-200,height-STATUSHEIGH);
  timeline(newcas,deaths,cured, 200,height,STATUSHEIGH-16,false,
           color(0,0,255),color(255,0,0),color(0,255,0));
  
  fill(128);noStroke();
  textAlign(RIGHT, TOP);
  text("Alives:"+liveCount+" Infected:"+sumInfected+" Cured:"+sumRecovered+" Death:"+sumDeath+"     ",width,side*cwidth); //A place for the MOST IMPORTANT STATISTICS
  println("ST:"+StepCounter+"\tZ\t"+sumInfected+"\t"+newcas.get(newcas.size()-1)
                           +"\tW\t"+sumRecovered+"\t"+cured.get(cured.size()-1)
                           +"\tU\t"+sumDeath+"\t"+deaths.get(deaths.size()-1)
                           +"\t");
  textAlign(LEFT, BOTTOM);
  text("Dzień:"+StepCounter/*+"  Fps:"+ frameRate*/,0,side*cwidth+STATUSHEIGH-2);
}

//-/////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM MAIN TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
