// ABM minimum template - using template for AGENT BASE MODEL in 1D & 2D discrete geometry
// @author Wojciech Borkowski
//-///////////////////////////////////////////////////////////////////////////////////////

//PARAMETRY MODELU - Coś w rodzaju stałych ;-)
final String  modelName="ABMPlague"; //"Plague" to DŻUMA!
final int     randomSeed=1; //Jak 0 to pozostaje inicjacja automatyczna
final int     side=200; //DŁUGOŚĆ BOKU ŚWIATA
final float   density=0.66; //Gęstość zaludnienia
final int     duration=14; //Czas trwania infekcji!
final float   pDeath=0.33/duration; //Średnie prawdopodobieństwo śmierci w danym dniu choroby
final float   pFarTrans=0.0;   //Prawdopodobieństwo spontanicznego ruchu. 0 - totalny bezruch!
final boolean panic=false; //Czy ludzie uciekają przed pustką i śmiercią
final int     infectionPoint=100; //Moment infekcji -1 - brak!

//Symbole stanów
final int Susceptible=1;
final int Infected=2;
final int Recovered=Infected+duration;
final int Death=100;

//STATYSTYKI LICZONE W TRAKCIE SYMULACJI
int liveCount=0;

int  sumInfected=0; //Zachorowanie
int sumRecovered=0; //Wyzdrowienia
int     sumDeath=0; //Ci co umarli

int migratioStart=0; //Ci co zaczęli migrować wg. `PFarTrans`
int migrationCont=0; //Ci co migrowali (dalej) z powodu pustki wokół

FloatList deaths=new FloatList(); //Śmierci 
FloatList newcas=new FloatList(); //Nowe zachorowania
FloatList  cured=new FloatList(); //Wyleczeni 
FloatList migration=new FloatList(); //Migrujący

//PARAMETRY WIZUALIZACJI, STATYSTYKI ITP.
int cwidth=1; //DŁUGOŚĆ BOKU KOMÓRKI W WIZUALIZACJI
             //WARTOŚĆ NADANA TU JEST TYLKO WSTĘPNA
int STATUSHEIGH=150; //WYSOKOŚĆ PASKA STATUSU NA DOLE OKNA

int STEPSperVIS=1; //JAK CZĘSTO URUCHAMIAMY WIZUALIZACJĘ
int FRAMEFREQ=50; //ILE RAZY NA SEKUNDĘ URUCHAMIA SIĘ draw()

boolean WITH_VIDEO=false; //CZY CHCEMY ZAPIS DO PLIKU FILMOWEGO (wymagane RTMVideo.pde. Może nie działać pod Windows)
boolean simulationRun=true; //FLAGA Start/stop DZIAŁANIA SYMULACJI

World TheWorld;

void setup()
{
  //GRAFIKA
  float reqwidth=16*100;
  float reqheight=9*100;
  println("Set size(",reqwidth,",",reqheight,");");
  size(1200,900); //NIESTETY TU MOGĄ BYĆ TYLKO WARTOŚCI PODANE LITERALNIE CZYLI "LITERAŁY"!!!
  
  //OBLICZAMY WYMAGANE PARAMETRY OKNA 
  cwidth=(height-STATUSHEIGH)/side; //DOPASOWUJEMY ROZMIAR KOMÓREK DO OKNA JAKIE JEST
  STATUSHEIGH=int(height*0.15);
  
  noSmooth();   //Znacząco przyśpiesza wizualizacje
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  if(randomSeed!=0)
  {
    randomSeed(randomSeed); //Zasianie generatora gdy chcemy mieć powtarzalny przebieg np. 107 albo 1013
    noiseSeed(randomSeed); //Noise też wymaga zasiania
  }
  
  //INICJALIZACJA MODELU I (ewentualnie) STATYSTYK
  int wside=width/cwidth;
  TheWorld=new World(side,wside); 
  initializeModel(TheWorld); //DOKOŃCZENIE INICJALIZACJI ŚWIATA
  //initializeStats();      //ODKOMENTOWAĆ JEŚLI UŻYWAMY STATYSTYK
  //doStatistics(TheWorld); //J.W.
  
   
  //INICJALIZACJA ZAPISU FILMU  (jeśli używamy RTMVideo.pde)
  if(WITH_VIDEO) {initVideoExport(this,modelName+".mp4",FRAMEFREQ);FirstVideoFrame();}
  
  //INFORMACJE KONSOLOWE NA KONIEC FUNKCJI setup()
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height); //-myMenu.bounds.height???
  visualizeModel(TheWorld); //PIERWSZA PO INICJALIZACJI WIZUALIZACJA ŚWIATA
  
  //if(!simulationRun) //WYMAGA MODUŁU RTMEvents.pde
  //  println("PRESS 'r' or 'ESC' to start simulation");
  //else
  //  println("PRESS 's' or 'ESC' to pause simulation");
  
  NextVideoFrame(); //PIERWSZA REALNA KLATKA FILMU (o ile używamy RTMVideo.pde)
}

void draw()
{
  if(simulationRun)
  {
    modelStep(TheWorld);
    //doStatistics(TheWorld); //ODKOMENTOWAĆ JEŚLI UŻYWAMY STATYSTYK
  }                          //Używa wewnętrznej flagi określającej czy log został otwarty
  
  writeStatusLine();
  
  if(!simulationRun //Po wstrzymaniu symulacji powinna działać tylko wizualizacja
  || StepCounter % STEPSperVIS == 0 ) //Ale gdy model jest uruchomiony, wizualizacja powinna być przeprowadzana od czasu do czasu
  {
    visualizeModel(TheWorld);
    NextVideoFrame(); //FUNKCJA ZAPISU KLATKI FILMU. 
  }                   //Używa wewnętrznej flagi określającej czy filmowanie zostało otwarte

}

void writeStatusLine()
{
  fill(0);
  rectMode(CORNERS);
  rect(0,cwidth*side,width,height);fill(128);
  rectMode(CORNER);
  histogram(TheWorld.agents,0,height-16,STATUSHEIGH-16); //Histogram wg. odporności  
  textAlign(LEFT,TOP);
  text("Odporność",0,height-STATUSHEIGH);
   
  //Legenda i historie trzech zmiennych dziennych każda w swojej skali
  stroke(0,0,255);fill(0,0,200);text("nowi chorzy",300,cwidth*side+16);
  //timeline(newcas,200,height,STATUSHEIGH-16,false);
  stroke(255,0,0);fill(200,0,0);text("nowi zmarli",300,cwidth*side+32);
  //timeline(deaths,200,height,STATUSHEIGH-16,false);
  stroke(0,255,0);fill(0,200,0);text("nowo wyleczeni",300,cwidth*side+48);
  //timeline(cured, 200,height,STATUSHEIGH-16,false);
  
  //Historie trzech zmiennych we wspólnej skali
  fill(0,128,255); //Tylko kolor napisów tu możemy ustalić
  stroke(128);
  viewAxis(200,height-1,width-200,height-STATUSHEIGH);
  strokeWeight(2);
  timeline(newcas,deaths,cured, 200,height,height-cwidth*side-16,false,
           color(0,0,255),color(255,0,0),color(0,255,0));
           
  stroke(0,255,255,128);fill(0,255,255);strokeWeight(1);    
  timeline(migration, 200,height,height-cwidth*side-16,false);
  textAlign(LEFT, TOP);
  text("migranci",300,cwidth*side+48+16);
  
  fill(128);noStroke();textAlign(RIGHT, TOP);
  text("Żyją:"+liveCount+" Zachorowali:"+sumInfected+" Wyzdrowieli:"+sumRecovered+" Umarli:"+sumDeath+"     ",width,side*cwidth); //Miejsce dla NAJWAŻNIEJSZYCH STATYSTYK
  if(newcas.size()>0)
  {
    println("ST:"+StepCounter+"\tZ\t"+sumInfected+"\t"+newcas.get(newcas.size()-1)
                             +"\tW\t"+sumRecovered+"\t"+cured.get(cured.size()-1)
                             +"\tU\t"+sumDeath+"\t"+deaths.get(deaths.size()-1)
                             +"\tMs\t"+migratioStart//Ci co zaczęli migrować wg. PFarTrans
                             +"\tMc\t"+migrationCont//Ci co migrowali (dalej) z powodu pustki wokół
                             +"\tSpeed:"+frameRate);
  }
  textAlign(LEFT, BOTTOM);
  text("Dzień:"+StepCounter/*+"  Fps:"+ frameRate*/,0,side*cwidth+STATUSHEIGH-2);
}

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM MAIN TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
