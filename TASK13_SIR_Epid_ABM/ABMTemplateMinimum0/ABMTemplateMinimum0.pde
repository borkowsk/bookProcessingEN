//   ABM minimum template - using template for AGENT BASE MODEL in 2D discrete geometry
//   >>>>   only necessary modules <<<<
//   @author Wojciech Borkowski
//-///////////////////////////////////////////////////////////////////////////////////////

//Parametry modelu
int side=75; //długość boku głównej macierzy
String modelName="ABMTemplateMin";
float density=0.75;

World TheWorld=new World(side); //... ale zostanie w pełni zainicjowany wewnątrz setup()

//Parametry wizualizacji etc...
int cwidth=15; //długość boku komórki w wizualizacji
int STATUSHEIGH=40;

int STEPSperVIS=1; //Jak często wizualizować
int FRAMEFREQ=10; //Rzadsza lub częstsza aktualizacja
//boolean WITH_VIDEO=false; //Czy zrobić film na podstawie symulacji?
boolean simulationRun=true; //Flaga startu/stopu

void setup()
{
  //Grafika
  size(750,790);
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //Model
  initializeModel(TheWorld); // Uzupełnienie inicjalizacji
  //initializeStats(); //Do celów statystycznych
  //doStatistics(TheWorld);
  
  //Window size calculation
  println("REQUIRED SIZE OF PAINTING AREA IS "+(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
  cwidth=(height-STATUSHEIGH)/side;
  
  //FOR RTMVideo.pde UNIT
  //if(WITH_VIDEO) {initVideoExport(this,modelName+".mp4",FRAMEFREQ);FirstVideoFrame();}
  
  //Zakończenie etapu konfiguracji
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height); //-myMenu.bounds.height???
  visualizeModel(TheWorld); //FOR RTMVideo.pde UNIT - Pierwszy raz wizualizacja
  
  //if(!simulationRun) //FOR RTMEvents.pde UNIT
  //  println("PRESS 'r' or 'ESC' to start simulation");
  //else
  //  println("PRESS 's' or 'ESC' to pause simulation");
  
  //NextVideoFrame(); //FOR RTMVideo.pde - Wykorzystuje zmienną wewnętrzną do sprawdzenia, czy jest włączone
}

void draw()
{
  if(simulationRun)
  {
    modelStep(TheWorld);
    //doStatistics(TheWorld);
  }
  
  writeStatusLine();
  
  if(!simulationRun //Po wstrzymaniu symulacji powinna działać tylko wizualizacja
  || StepCounter % STEPSperVIS == 0 ) //Ale gdy model jest uruchomiony, wizualizacja powinna być przeprowadzana od czasu do czasu
  {
    visualizeModel(TheWorld);
    //NextVideoFrame(); //FOR RTMVideo.pde UNIT - Wykorzystuje zmienną wewnętrzną do sprawdzenia, czy jest włączone
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
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM MAIN TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
