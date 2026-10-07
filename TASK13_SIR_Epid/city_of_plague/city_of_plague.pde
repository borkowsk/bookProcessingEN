// ABM epidemic model with enviroment 
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

//PARAMETRY MODELU
int side=200; //DŁUGOŚĆ BOKU ŚWIATA - PIONOWEGO. Poziomy jest x2
float density=0.66; //Gęstość zaludnienia na "terenach mieszkalnych"
                           
final float  PDeath=0.15;     //Średnie prawdopodobieństwo śmierci w danym KROKU(12h!) 
                              //choroby. Teraz krok to 12 godzin.
final int    Duration=14;     //Czas trwania infekcji! W krokach symulacji. 
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

World TheWorld=new World(side); //INICJALIZACJA JEST KOŃCZONA 
                               //W FUNKCJI setup()

//STATYSTYKI LICZONE W TRAKCIE SYMULACJI
int liveCount=0;
int sumInfected=0; //Zachorowanie
int sumRecovered=0; //Wyzdrowienia
int sumDeath=0; //Ci co umarli
FloatList deaths=new FloatList(); //Historia śmierci 
FloatList newcas=new FloatList(); //Historia nowych zachorowań
FloatList  cured=new FloatList(); //Historia wyleczeń 

//PARAMETRY WIZUALIZACJI, STATYSTYKI ITP.
int cwidth=3;  //DŁUGOŚĆ BOKU KOMÓRKI W WIZUALIZACJI
               //WARTOŚĆ NADANA TU JEST TYLKO WSTĘPNA
int STATUSHEIGH=150; //WYSOKOŚĆ PASKA STATUSU NA DOLE OKNA
int STEPSperVIS=1; //JAK CZĘSTO URUCHAMIAMY WIZUALIZACJĘ
int FRAMEFREQ=2; //ILE RAZY NA SEKUNDĘ URUCHAMIA SIĘ draw()

//boolean WITH_VIDEO=false; //CZY CHCEMY ZAPIS DO PLIKU FILMOWEGO (wymagany modu… RTMVideo.pde)
boolean simulationRun=true; //FLAGA Start/Stop DZIAŁANIA SYMULACJI

void setup()
{
  //GRAFIKA
  pixelDensity(1); //1 or 2, expecially for "Retina" (HERE?)
  size(1200,750); //NIESTETY TU MOGĄ BYĆ TYLKO WARTOŚCI PODANE LITERALNIE CZYLI "LITERAŁY"!!!
  pixelDensity(1); //1 or 2, expecially for MAC "Retina"
  println("Width:",width,"Height:",height,"displayDensity:",displayDensity());
  noSmooth();   //Znacząco przyśpiesza wizualizacje
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  //randomSeed(-1013); //Zasianie generatora gdy chcemy mieć powtarzalny przebieg np. 107 albo 1013
  
  //INICJALIZACJA MODELU I (ewentualnie) STATYSTYK
  initializeModel(TheWorld); //DOKOŃCZENIE INICJALIZACJI ŚWIATA
  //initializeStats();      //ODKOMENTOWAĆ JEŚLI UŻYWAMY STATYSTYK
  //doStatistics(TheWorld); //J.W.
  
  //OBLICZAMY WYMAGANY ROZMIAR OKNA DLA size() 
  println(modelName+": REQUIRED SIZE OF PAINTING AREA IS "
          +(cwidth*side*2)+"x"+(cwidth*side+STATUSHEIGH)); //Tu brakowało 2
          
  cwidth=(height-STATUSHEIGH)/side; //DOPASOWUJEMY ROZMIAR KOMÓREK DO OKNA JAKIE JEST
  
  //INICJALIZACJA ZAPISU FILMU  (jeśli używamy RTMVideo.pde)
  //if(WITH_VIDEO) {initVideoExport(this,modelName+".mp4",FRAMEFREQ);FirstVideoFrame();}
  
  //INFORMACJE KONSOLOWE NA KONIEC FUNKCJI setup()
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height); //-myMenu.bounds.height???
  visualizeModel(TheWorld); //PIERWSZA PO INICJALIZACJI WIZUALIZACJA ŚWIATA
  
  //if(!simulationRun) //WYMAGA MODUŁU RTMEvents.pde
  //  println("PRESS 'r' or 'ESC' to start simulation");
  //else
  //  println("PRESS 's' or 'ESC' to pause simulation");
  
  //NextVideoFrame(); //PIERWSZA REALNA KLATKA FILMU (o ile używamy RTMVideo.pde)
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
    //NextVideoFrame(); //FUNKCJA ZAPISU KLATKI FILMU. 
  }                    //Używa wewnętrznej flagi określającej czy film został otwarty

}

void writeStatusLine()
{
  fill(0);rect(0,side*cwidth,width,STATUSHEIGH);fill(128);
  histogram(TheWorld.agents,0,height-16,STATUSHEIGH-16); //Histogram wg. odporności  
  
                                                                  // Albo historie trzech zmiennych dziennych 
  //Legenda                                                       // w swojej skali
  stroke(0,0,255);fill(0,0,200);text("nowi chorzy",300,height-16); //timeline(newcas,200,height,STATUSHEIGH-16,false);
  stroke(255,0,0);fill(200,0,0);text("nowi zmarli",300,height-32); //timeline(deaths,200,height,STATUSHEIGH-16,false);
  stroke(0,255,0);fill(0,200,0);text("nowo wyleczeni",300,height-48); //timeline(cured, 200,height,STATUSHEIGH-16,false);
  
  //Historie trzech zmiennych we wspólnej skali
  stroke(0,0,255);fill(0,0,255);
  timeline(newcas,deaths,cured, 200,height,STATUSHEIGH-16,false,color(0,0,255),color(255,0,0),color(0,255,0));
  
  fill(128);noStroke();
  textAlign(RIGHT, TOP);
  text("Żyją:"+liveCount+" Zachorowali:"+sumInfected+" Wyzdrowieli:"+sumRecovered+" Umarli:"+sumDeath+"     ",width,side*cwidth); //Miejsce dla NAJWAŻNIEJSZYCH STATYSTYK
  println("ST:"+StepCounter+"\tZ\t"+sumInfected+"\t"+newcas.get(newcas.size()-1)
                           +"\tW\t"+sumRecovered+"\t"+cured.get(cured.size()-1)
                           +"\tU\t"+sumDeath+"\t"+deaths.get(deaths.size()-1)
                           +"\t");
  textAlign(LEFT, BOTTOM);
  text(StepCounter+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM MAIN TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
