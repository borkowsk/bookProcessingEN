/// This 2D Falling Sand model simulates basic cellular automata physics 
/// where sand grains fall downward or slide diagonally into vacant spaces. 
/// However, the current implementation features perfectly slippery sand that cannot 
/// build realistic piles or trigger avalanches, as grains never stack past their 
/// natural resting threshold. 
/// Additionally, the movement logic inherently favors one diagonal direction over 
/// the other, lacking the randomized behavior needed for symmetrical sand distribution.
//-/////////////////////////////////////////////////////////////////////////////////////

// Grid dimensions (Width = 500, Height = 600)
// Using different values forces careful handling of coordinates: array[x][y] vs point(x, y)
int cols = 300;
int rows = 600;

// 2D Array: 0 means empty space, 1 means a grain of sand
int[][] grid;

void setup()
{
  size(300, 600);
  grid = new int[cols][rows];
  Initialisation();
}

void draw()
{
  background(0); // Clear screen with black background

  // Allow user to add sand by clicking or dragging the mouse
  if (mousePressed)
  {
    if (mouseX >= 0 && mouseX < cols && mouseY >= 0 && mouseY < rows)
    {
      grid[mouseX][mouseY] = 1;
    }
  }

  ChangeState();
  Visualization();
}

// Fills the grid with initial data (spawns some sand at the top center)
void Initialisation()
{
  for (int x = 0; x < cols; x++)
  {
    for (int y = 0; y < rows; y++)
    {
      grid[x][y] = 0; // Start with an empty grid
    }
  }

  // Spawn a small starting pyramid of sand in the upper-middle area
  int centre=width/2;
  for (int x = centre-50; x < centre+50; x++)
  {
    for (int y = 10; y < 50; y++)
    {
      if (random(1) > 0.3)
      {
        grid[x][y] = 1;
      }
    }
  }
}

// Processes physics logic for every grain of sand
void ChangeState()
{
  // Create a next-state buffer to avoid processing the same grain multiple times in one frame
  int[][] nextGrid = new int[cols][rows];

  // Copy static elements (like bottom row) to the next state buffer
  for (int x = 0; x < cols; x++)
  {
    nextGrid[x][rows - 1] = grid[x][rows - 1];
  }

  // Iterate from bottom to top (rows-2 down to 0) so falling sand behaves naturally
  for (int y = rows - 2; y >= 0; y--)
  {
    for (int x = 0; x < cols; x++)
    {

      if (grid[x][y] == 1)
      { // If there is a grain of sand

        // Check directly below
        if (grid[x][y + 1] == 0 && nextGrid[x][y + 1] == 0)
        {
          nextGrid[x][y + 1] = 1; // Fall straight down
        }
        // Check diagonally down-left (ensure we don't go out of bounds on the left)
        else if (x > 0 && grid[x - 1][y + 1] == 0 && nextGrid[x - 1][y + 1] == 0)
        {
          nextGrid[x - 1][y + 1] = 1; // Fall down-left
        }
        // Check diagonally down-right (ensure we don't go out of bounds on the right)
        else if (x < cols - 1 && grid[x + 1][y + 1] == 0 && nextGrid[x + 1][y + 1] == 0)
        {
          nextGrid[x + 1][y + 1] = 1; // Fall down-right
        }
        // Nowhere to go -> sand stays in the same place
        else
        {
          nextGrid[x][y] = 1;
        }
      }
    }
  }

  // Update the main grid with the newly calculated state
  grid = nextGrid;
}

// Renders the sand grains on the screen using points
void Visualization() {
  stroke(235, 190, 100); // Set sand color (yellowish/gold)

  for (int x = 0; x < cols; x++)
  {
    for (int y = 0; y < rows; y++)
    {
      if (grid[x][y] == 1)
      {
        // Processing coordinates mapping: point(Width_Coordinate, Height_Coordinate)
        // Matches perfectly with array layout: grid[x][y]
        point(x, y);
      }
    }
  }
}
