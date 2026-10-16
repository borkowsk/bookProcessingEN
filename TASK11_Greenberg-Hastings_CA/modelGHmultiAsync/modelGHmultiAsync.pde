/// Greenberg-Hastings Model asynchronously: Excitable media with 9 refractory states.
/// TWO-dimensional, ASYNCHRONOUS!!!, Moore, "semi-deterministic" cellular automaton.
/// @date 2026-10-07 (last modification)
//-///////////////////////////////////////////////////////////////////////////////////

final int WorldSide=601; //< How many cells do we want in one line?
final boolean UseWave=false; //< Create initial wave or leave world only for clicks

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

CellState[][] World = new CellState[WorldSide][WorldSide]; //< We need only one world for async mode.


void setup()
{
  size(601,601);    //square window
  frameRate(999); 
  noSmooth();
  
  // Initialization of the entire world to a resting state
  for(int i=0; i<WorldSide; i++) {
    for(int j=0; j<WorldSide; j++) {
      World[i][j] = CellState.RESTING;
    }
  }
  
  if(UseWave)
  {
    // Creating an asymmetrical start (broken wave) in the center of the screen
    int środekX = WorldSide / 2;
    int startY  = WorldSide / 4;
    int koniecY = 3 * (WorldSide / 4);
    
    // We draw a vertical excitation strip (wavefront line).
    for(int i = startY; i <= koniecY; i++) {
      World[i][środekX] = CellState.EXCITED;
    }
    
    // Right next to them are refraction bands—a "thick" wave tail creating asymmetry.
    for(int i = startY; i <= koniecY; i++) {
      World[i][środekX - 1] = CellState.REFRACTORY_1;
      World[i][środekX - 2] = CellState.REFRACTORY_2;
      World[i][środekX - 3] = CellState.REFRACTORY_3;
    }
  }
}
  
 
void visualisation()
{
  for(int i=0; i<WorldSide; i++)
    for(int j=0; j<WorldSide; j++)
    {
      // Mapping states to colors using a switch construct
      switch(World[i][j]) 
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
          int step = World[i][j].ordinal() - CellState.REFRACTORY_1.ordinal();
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
  
  for(int a=0; a<WorldSide; a++) 
  {
    for(int b=0; b<WorldSide; b++) 
    {
      int i=(int)random(WorldSide);
      int j=(int)random(WorldSide);

      // Greenberg-Hastings Model Rules (9 refractory states)
      switch(World[i][j]) 
      {
        case RESTING: 
          // This is the only state that requires checking your neighbors!
          int right = (i+1) % WorldSide;
          int left  = (WorldSide+i-1) % WorldSide;
          int dw=(j+1) % WorldSide;
          int up=(WorldSide+j-1) % WorldSide;
           
          // Counting neighbors in the EXCITED state (Moore neighborhood)
          int excitedNeighbors = (
                      (World[left][j]   == CellState.EXCITED ? 1 : 0)
                   +  (World[right][j]  == CellState.EXCITED ? 1 : 0)
                   +  (World[i][up]     == CellState.EXCITED ? 1 : 0)
                   +  (World[i][dw]     == CellState.EXCITED ? 1 : 0)    
                   +  (World[left][up]  == CellState.EXCITED ? 1 : 0)
                   +  (World[right][up] == CellState.EXCITED ? 1 : 0)
                   +  (World[left][dw]  == CellState.EXCITED ? 1 : 0)
                   +  (World[right][dw] == CellState.EXCITED ? 1 : 0)           
                   );
          // A resting cell becomes excited if it has at least one excited neighbor.
          World[i][j] = (excitedNeighbors >= 1 ? CellState.EXCITED : CellState.RESTING);
          break;
          
        case EXCITED:
          // After excitation, it automatically enters the first refractory state.
          World[i][j] = CellState.REFRACTORY_1;
          break;
          
        // Cascading transition through successive refraction states
        case REFRACTORY_1: World[i][j] = CellState.REFRACTORY_2; break;
        case REFRACTORY_2: World[i][j] = CellState.REFRACTORY_3; break;
        case REFRACTORY_3: World[i][j] = CellState.REFRACTORY_4; break;
        case REFRACTORY_4: World[i][j] = CellState.REFRACTORY_5; break;
        case REFRACTORY_5: World[i][j] = CellState.REFRACTORY_6; break;
        case REFRACTORY_6: World[i][j] = CellState.REFRACTORY_7; break;
        case REFRACTORY_7: World[i][j] = CellState.REFRACTORY_8; break;
        case REFRACTORY_8: World[i][j] = CellState.REFRACTORY_9; break;
        
        case REFRACTORY_9:
          // Exiting the final refractory state signifies full recovery and a return to the resting state.
          World[i][j] = CellState.RESTING;
          break;
      }
    }
  }

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
  World[j][i]=CellState.EXCITED;
}
