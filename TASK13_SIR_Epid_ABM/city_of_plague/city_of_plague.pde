// ABM epidemic model with environment 
// - using template for AGENT BASE MODEL in 2D discrete geometry
// @author Wojciech Borkowski
//-///////////////////////////////////////////////////////////////////////////////////////
// Generalny pomysł jest taki, że mamy miasto podzielone drogami, złożone z obszarów 
// mieszkalnych (jasne) i miejsc pracy (szare).
// Ci sami agenci na zmianę są w domu lub w pracy, i wszędzie mogą zarazić się przez 
// kontakt. Stąd jeden krok symulacji to pół dnia - parzyste kroki w pracy, nieparzyste 
// w domu, chyba że agent nie ma pracy.
//
// Właściwości danego wirusa są opisane parametrami symulacji.
// Właściwością agentów poza rozlosowaną z rozkładu Gaussa "immunity" jest tylko wiedza 
// o miejscu zamieszkania i miejscu pracy.
String modelName="ABMcity_of_plague"; //NAZWA modelu, na razie nie używana.

//MODEL PARAMETERS
int side=200; //LENGTH OF THE SIDE OF THE WORLD - PIONOWEGO. Poziomy jest x2
float density=0.66; //Population density in "residential areas"
                           
final float  PDeath=0.15;     //Średnie prawdopodobieństwo śmierci w danym KROKU(12h!) 
                              //choroby. Teraz krok to 12 godzin.
final int    Duration=14;     //Infection duration W krokach symulacji. 
                              //Krok to teraz  12 godzin, czyli default to 7 dni.
//float PTransfer=???;        //Prawdopodobieństwo zarażenia agenta w pojedynczej
                              //interakcji zależy od indywidualnej wartości `immunity`!
                              //Ale można by go liczyć jako globalną statystykę!
final float  PSLeav=0.90;     //Prawdopodobieństwo, że danego DNIA chory agent 
                              //nie będzie w stanie iść do pracy
                              
//Właściwości nie związane z epidemią
final int    Nprob=10;          //Liczba prób szukania pracy w inicjalizacji. 
                                //Jak się nie uda to agent cały czas siedzi w domu
final float  Dutifulness=0.900; //Jak często zdrowi agenci idą do pracy. 
                                //Mogą pracować w domu lub mieć ograniczone wyjścia.

//Stałe używane do określania stanu agentów
final int Susceptible=1;    
final int Infected=2;
final int Recovered=Infected+Duration;
final int Death=100;

World TheWorld=new World(side); //INITIALIZATION IS COMPLETED 
                               //IN THE setup() FUNCTION

//STATISTICS CALCULATED DURING THE SIMULATION
int liveCount=0;
int sumInfected=0; //Number of successful infections
int sumRecovered=0; //Number of recoveries
int sumDeath=0; //Number of deaths
FloatList deaths=new FloatList(); //Historia śmierci 
FloatList newcas=new FloatList(); //Historia nowych zachorowań
FloatList  cured=new FloatList(); //Historia wyleczeń 

//VISUALIZATION PARAMETERS, STATISTICS, ETC.
int cwidth=3;  //CELL SIDE LENGTH IN VISUALIZATION - THE VALUE GIVEN HERE IS ONLY PROVISIONAL
               //WARTOŚĆ NADANA TU JEST TYLKO WSTĘPNA
int STATUSHEIGH=150; //HEIGHT OF THE STATUS BAR AT THE BOTTOM OF THE WINDOW
int STEPSperVIS=1; //HOW OFTEN DO WE RUN THE VISUALIZATION
int FRAMEFREQ=2; //HOW MANY TIMES PER SECOND DOES draw() RUN?

//boolean WITH_VIDEO=false; //DO WE WANT TO SAVE TO A MOVIE FILE (requires RTMVideo.pde module)
boolean simulationRun=true; //FLAGA Start/Stop DZIAŁANIA SYMULACJI

void setup()
{
  //GRAPHICS BELOW
  pixelDensity(1); //1 or 2, expecially for "Retina" (HERE?)
  size(1200,750); //UNFORTUNATELY, ONLY LITERAL VALUES CAN BE PRESENTED HERE ("LITERALS")
  pixelDensity(1); //1 or 2, expecially for MAC "Retina"
  println("Width:",width,"Height:",height,"displayDensity:",displayDensity());
  noSmooth();   //Significantly speeds up visualizations
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  //randomSeed(-1013); //Seeding a generator when a repeatable sequence is required, e.g., 107 or 1013.
  
  //INITIALIZATION OF THE MODEL AND (OPTIONALLY) STATISTICS
  initializeModel(TheWorld); //COMPLETING WORLD INITIALIZATION
  //initializeStats();      //UNCOMMENT THIS IF USING STATISTICS
  //doStatistics(TheWorld); //as above
  
  //CALCULATE THE REQUIRED WINDOW SIZE FOR size()
  println(modelName+": REQUIRED SIZE OF PAINTING AREA IS "
          +(cwidth*side*2)+"x"+(cwidth*side+STATUSHEIGH)); //Tu brakowało 2
          
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
  fill(0);rect(0,side*cwidth,width,STATUSHEIGH);fill(128);
  histogram(TheWorld.agents,0,height-16,STATUSHEIGH-16); //Histogram by resistance to infection  
  
                                                                  // Albo historie trzech zmiennych dziennych 
  //Legenda                                                       // w swojej skali
  stroke(0,0,255);fill(0,0,200);text("nowi chorzy",300,height-16); //timeline(newcas,200,height,STATUSHEIGH-16,false);
  stroke(255,0,0);fill(200,0,0);text("nowi zmarli",300,height-32); //timeline(deaths,200,height,STATUSHEIGH-16,false);
  stroke(0,255,0);fill(0,200,0);text("nowo wyleczeni",300,height-48); //timeline(cured, 200,height,STATUSHEIGH-16,false);
  
  //Histories of three variables, each on a common scale
  stroke(0,0,255);fill(0,0,255);
  timeline(newcas,deaths,cured, 200,height,STATUSHEIGH-16,false,color(0,0,255),color(255,0,0),color(0,255,0));
  
  fill(128);noStroke();
  textAlign(RIGHT, TOP);
  text("Żyją:"+liveCount+" Zachorowali:"+sumInfected+" Wyzdrowieli:"+sumRecovered+" Umarli:"+sumDeath+"     ",width,side*cwidth); //A place for the MOST IMPORTANT STATISTICS
  println("ST:"+StepCounter+"\tZ\t"+sumInfected+"\t"+newcas.get(newcas.size()-1)
                           +"\tW\t"+sumRecovered+"\t"+cured.get(cured.size()-1)
                           +"\tU\t"+sumDeath+"\t"+deaths.get(deaths.size()-1)
                           +"\t");
  textAlign(LEFT, BOTTOM);
  text(StepCounter+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

//-/////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM MAIN TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
