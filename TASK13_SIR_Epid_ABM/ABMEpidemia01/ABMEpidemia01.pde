// ABM minimum template - using template for AGENT BASE MODEL in 1D & 2D discrete geometry
//   >>>>   TYLKO NIEZBĘDNE MODUŁY <<<<
// @author Wojciech Borkowski
//-///////////////////////////////////////////////////////////////////////////////////////

//PARAMETRY MODELU
int side=200; //DŁUGOŚĆ BOKU ŚWIATA
String modelName="ABMEpidemia";
float density=0.66;

World TheWorld=new World(side); //INICJALIZACJA JEST KOŃCZONA 
                               //W FUNKCJI setup()

//STAŁE MODELU
final int Duration=7; //Czas trwania infekcji!
//final int Empty=0; //ZBĘDNE. Zamiast tego jest null w komórce tablicy uchwytów do agentów
final int Susceptible=1;
final int Infected=2;
final int Recovered=Infected+Duration;
final float PTransfer=0.330; //Prawdopodobieństwo zarażenia agenta w pojedynczej interakcji
final float PDeath=0.05;    //Średnie prawdopodobieństwo śmierci w danym dniu choroby

//STATYSTYKI LICZONE W TRAKCIE SYMULACJI
int liveCount=0;
int sumInfected=0; //Zachorowanie
int sumRecovered=0; //Wyzdrowienia
int sumDeath=0; //Ci co umarli
                               
//PARAMETRY WIZUALIZACJI, STATYSTYKI ITP.
int cwidth=3; //DŁUGOŚĆ BOKU KOMÓRKI W WIZUALIZACJI
              //WARTOŚĆ NADANA TU JEST TYLKO WSTĘPNA
int STATUSHEIGH=40; //WYSOKOŚĆ PASKA STATUSU NA DOLE OKNA

int STEPSperVIS=1; //JAK CZĘSTO URUCHAMIAMY WIZUALIZACJĘ
int FRAMEFREQ=10; //ILE RAZY NA SEKUNDĘ URUCHAMIA SIĘ draw()

//boolean WITH_VIDEO=false; //CZY CHCEMY ZAPIS DO PLIKU FILMOWEGO (wymagany modu… RTMVideo.pde)
boolean simulationRun=true; //FLAGA Start/stop DZIAŁANIA SYMULACJI

void setup()
{
  //GRAFIKA
  size(600,640); //NIESTETY TU MOGĄ BYĆ TYLKO WARTOŚCI PODANE LITERALNIE CZYLI "LITERAŁY"!!!
  noSmooth();   //Znacząco przyśpiesza wizualizacje
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //INICJALIZACJA MODELU I (ewentualnie) STATYSTYK
  initializeModel(TheWorld); //ZAKOŃCZENIE INICJALIZACJI ŚWIATA
  //initializeStats();      //ODKOMENTOWAĆ JEŚLI UŻYWAMY STATYSTYK
  //doStatistics(TheWorld); //J.W.
  
  //OBLICZAMY WYMAGANY ROZMIAR OKNA DLA size() 
  println(modelName+": REQUIRED SIZE OF PAINTING AREA IS "
          +(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
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
  fill(255);rect(0,side*cwidth,width,STATUSHEIGH);
  fill(0);noStroke();
  textAlign(LEFT, TOP);
  text(liveCount+" Zachorowali:"+sumInfected+" Wyzdrowieli:"+sumRecovered+" Umarli:"+sumDeath,
       0,side*cwidth); //Miejsce dla NAJWAŻNIEJSZYCH STATYSTYK
  println("ST:"+StepCounter+"\tZ\t"+sumInfected+"\tW\t"+sumRecovered+"\tU\t"+sumDeath);
  textAlign(LEFT, BOTTOM);
  text(StepCounter+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM MAIN TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
