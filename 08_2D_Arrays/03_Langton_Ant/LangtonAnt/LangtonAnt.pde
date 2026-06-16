// Grid size for the simulation (500x500 cells to match the window size)
int cols = 500;
int rows = 500;

// 2D Array: 0 means White cell, 1 means Black cell
int[][] grid;

// The current position of the ant
int antX;
int antY;

// The current direction of the ant: 0 = Up, 1 = Right, 2 = Down, 3 = Left
// This clockwise order makes turning right (+1) and left (-1) mathematically simple
int antDir;

void setup() 
{
  size(500, 500);
  noSmooth();

  grid = new int[cols][rows];

  // Initialize the grid: fill everything with White cells (0)
  for (int x = 0; x < cols; x++) 
  {
    for (int y = 0; y < rows; y++) 
    {
      grid[x][y] = 0;
    }
  }

  // Start the ant exactly in the center of the grid
  antX = cols / 2;
  antY = rows / 2;

  // Start facing Up (0)
  antDir = 0;

  background(255); // Start with a white screen
}

void draw() 
{
  // Perform multiple simulation steps per frame to see the emergence of the "highway" faster
  for (int i = 0; i < 20; i++) 
  {

    // Rule 1: If the ant is on a WHITE cell (0) -> turn RIGHT, flip to BLACK (1)
    if (grid[antX][antY] == 0) 
    {
      antDir = (antDir + 1) % 4; // Turn clockwise
      grid[antX][antY] = 1;      // Flip state

      // Draw the updated cell immediately
      stroke(0); // Black pixel
      point(antX, antY);
    }
    // Rule 2: If the ant is on a BLACK cell (1) -> turn LEFT, flip to WHITE (0)
    else if (grid[antX][antY] == 1) 
    {
      antDir = (antDir + 3) % 4; // Turn counter-clockwise (adding 3 is equivalent to subtracting 1 in modulo 4)
      grid[antX][antY] = 0;      // Flip state

      // Draw the updated cell immediately
      stroke(255); // White pixel
      point(antX, antY);
    }

    // Move the ant forward one step based on its current direction
    if (antDir == 0) 
    {
      antY--; // Move Up
    } 
    else if (antDir == 1) 
    {
      antX++; // Move Right
    } 
    else if (antDir == 2) 
    {
      antY++; // Move Down
    } 
    else if (antDir == 3) 
    {
      antX--; // Move Left
    }

    // Keep the ant inside the grid boundaries to prevent ArrayIndexOutOfBoundsException
    if (antX < 0 || antX >= cols || antY < 0 || antY >= rows) 
    {
      // If the ant hits the wall, wrap around to the other side (toroidal grid)
      antX = (antX + cols) % cols;
      antY = (antY + rows) % rows;
    }
  }

  // Visual highlight: draw the active ant position in red so students can track it
  stroke(255, 0, 0);
  point(antX, antY);
}
