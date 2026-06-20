/// Greenberg-Hastings Model: Excitable media with 9 refractory states.
/// TWO-dimensional, SYNCHRONOUS, Moore, deterministic cellular automaton.
//-/////////////////////////////////////////////////////////////////////////

final int WorldSide=601; // How many cells do we want in one line?

// Definicja wszystkich 11 stanów przy użyciu enum
enum CellState {
  RESTING,          // Stan spoczynku (0)
  EXCITED,          // Stan pobudzenia (1)
  REFRACTORY_1,     // Pierwszy stan refrakcji (2)
  REFRACTORY_2,
  REFRACTORY_3,
  REFRACTORY_4,
  REFRACTORY_5,
  REFRACTORY_6,
  REFRACTORY_7,
  REFRACTORY_8,
  REFRACTORY_9      // Ostatni, dziewiąty stan refrakcji
}

CellState[][] WorldOld = new CellState[WorldSide][WorldSide]; 
CellState[][] WorldNew = new CellState[WorldSide][WorldSide];


void setup()
{
  size(601,601);    //square window
  frameRate(999); 
  noSmooth();
  
  // 1. Inicjalizacja całego świata stanem spoczynku
  for(int i=0; i<WorldSide; i++) {
    for(int j=0; j<WorldSide; j++) {
      WorldOld[i][j] = CellState.RESTING;
    }
  }
  
  // 2. Tworzenie asymetrycznego startu (urwanej fali) na środku ekranu
  int środekX = WorldSide / 2;
  int startY  = WorldSide / 4;
  int koniecY = 3 * (WorldSide / 4);
  
  // Pionowy pasek pobudzenia
  for(int i = startY; i <= koniecY; i++) {
    WorldOld[i][środekX] = CellState.EXCITED;
  }
  
  // Tuż obok paski refrakcji - „gruby” ogon fali dający asymetrię
  for(int i = startY; i <= koniecY; i++) {
    WorldOld[i][środekX - 1] = CellState.REFRACTORY_1;
    WorldOld[i][środekX - 2] = CellState.REFRACTORY_2;
    WorldOld[i][środekX - 3] = CellState.REFRACTORY_3;
  }
}
  
  
void visualisation()
{
  for(int i=0; i<WorldSide; i++)
    for(int j=0; j<WorldSide; j++)
    {
      // Mapowanie stanów na kolory przy użyciu switch
      switch(WorldOld[i][j]) 
      {
        case EXCITED: 
          stroke(255, 0, 100); // Różowy/Czerwony dla pobudzenia
          break;
          
        case RESTING: 
          stroke(0);           // Czarny dla spoczynku
          break;
          
        default: 
          // Wszystkie stany refrakcji rysujemy w odcieniach niebieskiego/turkusu
          // im dalsza refrakcja, tym jaśniejszy kolor (zbliża się do regeneracji)
          int step = WorldOld[i][j].ordinal() - CellState.REFRACTORY_1.ordinal();
          stroke(0, 50 + (step * 20), 255); 
          break;
      }
      
      point(j,i); //the horizontal dimension of the array is the SECOND index
    }
}


int t=0;
void draw() // modifies global t,WorldOld,WorldNew
{  
  visualisation(); 
  
  for(int i=0; i<WorldSide; i++) 
  {
    int right = (i+1) % WorldSide;
    int left  = (WorldSide+i-1) % WorldSide;
     
    for(int j=0; j<WorldSide; j++) 
    {
      int dw=(j+1) % WorldSide;
      int up=(WorldSide+j-1) % WorldSide;
       
      // Zliczanie pobudzonych sąsiadów
      int excitedNeighbors = (
                  (WorldOld[left][j]   == CellState.EXCITED ? 1 : 0)
               +  (WorldOld[right][j]  == CellState.EXCITED ? 1 : 0)
               +  (WorldOld[i][up]     == CellState.EXCITED ? 1 : 0)
               +  (WorldOld[i][dw]     == CellState.EXCITED ? 1 : 0)    
               +  (WorldOld[left][up]  == CellState.EXCITED ? 1 : 0)
               +  (WorldOld[right][up] == CellState.EXCITED ? 1 : 0)
               +  (WorldOld[left][dw]  == CellState.EXCITED ? 1 : 0)
               +  (WorldOld[right][dw] == CellState.EXCITED ? 1 : 0)           
               );

      // REGUŁY MODELU GREENBERGA-HASTINGSA (9 stanów refrakcji)
      switch(WorldOld[i][j]) 
      {
        case RESTING:
          // Komórka w spoczynku pobudza się, jeśli ma przynajmniej jednego pobudzonego sąsiada
          WorldNew[i][j] = (excitedNeighbors >= 1 ? CellState.EXCITED : CellState.RESTING);
          break;
          
        case EXCITED:
          // Po pobudzeniu automatycznie wpada w pierwszy stan refrakcji
          WorldNew[i][j] = CellState.REFRACTORY_1;
          break;
          
        // Kaskadowe przechodzenie przez kolejne stany refrakcji
        case REFRACTORY_1: WorldNew[i][j] = CellState.REFRACTORY_2; break;
        case REFRACTORY_2: WorldNew[i][j] = CellState.REFRACTORY_3; break;
        case REFRACTORY_3: WorldNew[i][j] = CellState.REFRACTORY_4; break;
        case REFRACTORY_4: WorldNew[i][j] = CellState.REFRACTORY_5; break;
        case REFRACTORY_5: WorldNew[i][j] = CellState.REFRACTORY_6; break;
        case REFRACTORY_6: WorldNew[i][j] = CellState.REFRACTORY_7; break;
        case REFRACTORY_7: WorldNew[i][j] = CellState.REFRACTORY_8; break;
        case REFRACTORY_8: WorldNew[i][j] = CellState.REFRACTORY_9; break;
        
        case REFRACTORY_9:
          // Ostatni stan refrakcji oznacza pełną regenerację i powrót do spoczynku
          WorldNew[i][j] = CellState.RESTING;
          break;
      }
    }
  }
   
  //Zamiana tablic (Swap)
  CellState[][] WorldTmp = WorldOld;
  WorldOld = WorldNew;
  WorldNew = WorldTmp;
   
  t++; 
  fill(255,128);
  textSize(20); textAlign(LEFT,TOP); text("ST:"+t,0,0);
}

//For more fun ;-)
void mousePressed()
{
  int i=mouseX;
  int j=mouseY;
  WorldOld[j][i]=CellState.EXCITED;
}
