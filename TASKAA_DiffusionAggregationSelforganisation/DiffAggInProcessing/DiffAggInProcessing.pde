// Program CA_2D_aggregation; 
// CA program – simulation of diffusion with aggregation.
// Translated from Delphi using Gemini.

final int   Last = 100;       /* Array size - Must be greater than 1 and at most 160 */ 
final int   Side = 5;         /* Cell size */ 
final float Prob0 = 0.800;    /* Probability of 0 in random initialization */ 

final boolean IsShutter = false;
final String IniFile = "";    /* "2DCA_dane.txt"; */    /* Data file name */ 

int[][] World = new int[Last + 1][Last + 1]; /* A global variable representing the World */ 

int StepCounter; 

void setup() {
  size(510, 510);
  frameRate(30);
  noStroke();
  // "Diffusion and Aggregation" cellular automaton with 100x100 cells
  println("         \"Diffusion and Aggregation\" cellular automaton with " + Last + "x" + Last + " cells");

  /* Variant-based initialization of the simulation space */ 
  if (IniFile.equals("")) { 
    
    if(!IsShutter){
      RandomAll(); 
      World[Last / 2][Last / 2] = 2; 
    }else{
      RandomPart(1, Last, 1, Last / 2); 
      ResetPart(1, Last, Last / 2 + 1, Last);
      Shutter(Last / 2 + 1); 
    }
    
  } else { 
    ResetAll(); 
    LoadIniFile(IniFile); 
  } 
  
  Visualize(); 
  StepCounter = 0; 
}

void draw() {
  /* The actual simulation loop */
  TakeMonteCarloStep(); 
  StepCounter = StepCounter + 1; 
  Visualize(); 
  print("\r"+nf(StepCounter, 3) + ")     "); 
}

/* VARIOUS INITIALIZATION FUNCTIONS FOR A SENSIBLE CHOICE */ 

void ResetAll() { /* Resetting the entire "World" */ 
  for (int i = 1; i <= Last; i++) 
    for (int j = 1; j <= Last; j++) 
      World[i][j] = 0; 
} 

void ResetPart(int xp, int xk, int yp, int yk) { /* Resetting a piece of  the "World" */ 
  for (int i = xp; i <= xk; i++) 
    for (int j = yp; j <= yk; j++) 
      World[i][j] = 0; 
} 

void RandomAll() { /* Random drawing particles of the "World" */
  for (int i = 1; i <= Last; i++) 
    for (int j = 1; j <= Last; j++) 
      if (random(1.0) < Prob0) 
        World[i][j] = 0; 
      else 
        World[i][j] = 1; 
} 

void RandomPart(int xp, int xk, int yp, int yk) { /* Sampling particles within a rectangle */ 
  for (int i = xp; i <= xk; i++) 
    for (int j = yp; j <= yk; j++) 
      if (random(1.0) < Prob0) 
        World[i][j] = 0; 
      else 
        World[i][j] = 1; 
} 

void Shutter(int pozycja) { /* It draws a wall/curtain (?) across 2/3 of the width of the World */ 
  for (int i = 1; i <= Last / 3; i++) { 
    World[i][pozycja] = 2; 
    World[Last - i][pozycja] = 2; 
  } 
} 

int minVal(int a, int b) { /* The mathematical minimum of two integers */ 
  if (a > b) 
    return b; 
  else 
    return a; 
} 

int maxVal(int a, int b) { /* The mathematical maximum of two integers */ 
  if (a < b) 
    return b; 
  else 
    return a; 
} 

void LoadIniFile(String nazwa) { /* Loading the data file. `*` represents 1, `X` represents 2, and everything else is 0. */ 
  
  String[] linie = loadStrings(nazwa);
  if (linie == null) return;

  int j = 1; 
  for (String bufor : linie) {
    if (j > Last) break;
    int len = minVal(bufor.length(), Last);
    for (int i = 1; i <= len; i++) { 
      char c = bufor.charAt(i - 1);
      if (c == '*') 
        World[i][j] = 1; 
      else if (c == 'X' || c == 'x') 
        World[i][j] = 2; 
      else 
        World[i][j] = 0; 
    } 
    j++; 
  } 
} 

void LookAside(int xo, int yo, int[] result) { /* Selects a neighboring cell at random, ensuring it stays within the bounds of the array. */ 
  /* Not exactly optimal, but effective */ 
  int x = xo + int(random(3)) - 1; 
  int y = yo + int(random(3)) - 1; 
  
  if (x < 1) x = 1; 
  if (x > Last) x = Last; 
  if (y < 1) y = 1; 
  if (y > Last) y = Last; 
  result[0] = x;
  result[1] = y;
} 

boolean HasANeighbor2(int xo, int yo) { /* Checking whether there is (any) two (?) in Moore's vicinity. */
  boolean flaga = false; 
  for (int i = maxVal(1, xo - 1); i <= minVal(xo + 1, Last); i++) 
    for (int j = maxVal(1, yo - 1); j <= minVal(yo + 1, Last); j++) 
      if (World[i][j] == 2) 
        flaga = true; 
  return flaga; 
} 

void TakeMonteCarloStep() { /* Here is the model step */ 
  int[] newPos = new int[2];
  for (int k = 1; k <= Last * Last; k++) { 
    int xo = int(random(Last)) + 1; 
    int yo = int(random(Last)) + 1; 
    if (World[xo][yo] == 1) {
      if (HasANeighbor2(xo, yo)) { 
        World[xo][yo] = 2; 
      } else { 
        LookAside(xo, yo, newPos); 
        int xn = newPos[0];
        int yn = newPos[1];
        if (World[xn][yn] == 0) { 
          World[xn][yn] = World[xo][yo]; 
          World[xo][yo] = 0; 
        } 
      } 
    }
  } 
} 

void Visualize() { 
  for (int i = 1; i <= Last; i++) {
    for (int j = 1; j <= Last; j++) { 
      if (World[i][j] == 0) 
        fill(0, 0, 0); 
      else if (World[i][j] == 1) 
        fill(255, 0, 0); 
      else 
        fill(0, 0, 255); 
      rect(i * Side, j * Side, Side, Side); 
    } 
  }
}

void exit() {
  println();
  println("Thank you, and I’m happy to help again in the future.");
  super.exit();
}





/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
