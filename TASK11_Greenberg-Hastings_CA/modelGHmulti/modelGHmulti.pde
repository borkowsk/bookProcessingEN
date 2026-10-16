/// Greenberg-Hastings Model: Excitable media with 9 refractory states.
/// TWO-dimensional, SYNCHRONOUS, Moore, deterministic cellular automaton.
/// @date 2026-10-07 (last modification)
//-/////////////////////////////////////////////////////////////////////////

final int WorldSide=601; //< How many cells do we want in one line?

// Defining all 11 cell states using enum
enum CellState {
  RESTING,          //< Resting/Quiescent (0)
  EXCITED,          //< Excited state (1)
  REFRACTORY_1,     //< Initial state of refraction (2)
  REFRACTORY_2,
  REFRACTORY_3,
  REFRACTORY_4,
  REFRACTORY_5,
  REFRACTORY_6,
  REFRACTORY_7,
  REFRACTORY_8,
  REFRACTORY_9      //< The final, ninth state of refraction
}

CellState[][] WorldOld = new CellState[WorldSide][WorldSide]; //< We need two "worlds" for the old...
CellState[][] WorldNew = new CellState[WorldSide][WorldSide]; //< And for new state of the simulation.

void setup()
{
  size(601,601);    //square window
  frameRate(999); 
  noSmooth();
  
  // Initialization of the entire world to a resting state
  for(int i=0; i<WorldSide; i++) {
    for(int j=0; j<WorldSide; j++) {
      WorldOld[i][j] = CellState.RESTING;
    }
  }
  
  // Creating an asymmetrical start (broken wave) in the center of the screen
  int środekX = WorldSide / 2;
  int startY  = WorldSide / 4;
  int koniecY = 3 * (WorldSide / 4);
  
  // We draw a vertical excitation strip (wavefront line).
  for(int i = startY; i <= koniecY; i++) {
    WorldOld[i][środekX] = CellState.EXCITED;
  }
  
  // Right next to them are refraction bands—a "thick" wave tail creating asymmetry.
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
      // Mapping states to colors using a switch construct
      switch(WorldOld[i][j]) 
      {
        case EXCITED: 
          stroke(255, 0, 100); // Red/Pink for Excited
          break;
          
        case RESTING: 
          stroke(0);           // Black for Resting
          break;
          
        default: 
          // We draw all refraction states in shades of blue/turquoise
          // the further along the refraction, the lighter the color (approaching regeneration)
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
       
      // Counting neighbors in the EXCITED state (Moore neighborhood)
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

      // Greenberg-Hastings Model Rules (9 refractory states)
      switch(WorldOld[i][j]) 
      {
        case RESTING:
          // A resting cell becomes excited if it has at least one excited neighbor.
          WorldNew[i][j] = (excitedNeighbors >= 1 ? CellState.EXCITED : CellState.RESTING);
          break;
          
        case EXCITED:
          // After excitation, it automatically enters the first refractory state.
          WorldNew[i][j] = CellState.REFRACTORY_1;
          break;
          
        // Cascading transition through successive refraction states
        case REFRACTORY_1: WorldNew[i][j] = CellState.REFRACTORY_2; break;
        case REFRACTORY_2: WorldNew[i][j] = CellState.REFRACTORY_3; break;
        case REFRACTORY_3: WorldNew[i][j] = CellState.REFRACTORY_4; break;
        case REFRACTORY_4: WorldNew[i][j] = CellState.REFRACTORY_5; break;
        case REFRACTORY_5: WorldNew[i][j] = CellState.REFRACTORY_6; break;
        case REFRACTORY_6: WorldNew[i][j] = CellState.REFRACTORY_7; break;
        case REFRACTORY_7: WorldNew[i][j] = CellState.REFRACTORY_8; break;
        case REFRACTORY_8: WorldNew[i][j] = CellState.REFRACTORY_9; break;
        
        case REFRACTORY_9:
          // Exiting the final refractory state signifies full recovery and a return to the resting state.
          WorldNew[i][j] = CellState.RESTING;
          break;
      }
    }
  }
   
  // Swap the arrays 
  CellState[][] WorldTmp = WorldOld;
  WorldOld = WorldNew;
  WorldNew = WorldTmp;
   
  t++; // The next generation/step/year 
  fill(255,128);
  textSize(20); textAlign(LEFT,TOP); text("ST:"+t,0,0);
  //saveFrame("../movie/GH-######.png");
}

//For more fun ;-)
void mousePressed()
{
  int i=mouseX;
  int j=mouseY;
  WorldOld[j][i]=CellState.EXCITED;
}
