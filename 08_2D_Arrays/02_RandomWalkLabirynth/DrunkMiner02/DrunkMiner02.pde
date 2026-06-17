// Now the miner not only removes coal, but when he returns to the place 
// where he was before, he puts down a support pole (also black).
// ///////////////////////////////////////////////////////////////////////////////

// Grid size for the maze (500x500 cells to match the window size)
int cols = 500;
int rows = 500;

// 2D Array: 1 represents a solid wall (black), 0 represents a carved path (white)
int[][] grid;

// The current position of our single "carver" (the drunk miner)
int carverX;
int carverY;

void setup() 
{
  size(500, 500);
  noSmooth();
    
  grid = new int[cols][rows];

  // Initialize the grid: fill everything with solid walls (1)
  for (int x = 0; x < cols; x++) 
  {
    for (int y = 0; y < rows; y++) 
    {
      grid[x][y] = 1;
    }
  }

  // Start the carver exactly in the center of the grid
  carverX = cols / 2;
  carverY = rows / 2;

  // Carve out the starting point
  grid[carverX][carverY] = 0;
  
  background(0); // Start with a black screen (all walls)
}

void draw() 
{
  // Perform multiple simulation steps per frame to speed up the visual generation
  for (int i = 0; i < 500; i++) 
  {

    // Choose a random direction: 0 = Up, 1 = Down, 2 = Left, 3 = Right
    int direction = int(random(4));

    // Move the carver based on the chosen direction
    if (direction == 0) 
    {
      carverY--; // Move Up
    } 
    else if (direction == 1) 
    {
      carverY++; // Move Down
    } 
    else if (direction == 2) 
    {
      carverX--; // Move Left
    } 
    else if (direction == 3) 
    {
      carverX++; // Move Right
    }

    // Keep the carver inside the grid boundaries (constrain coordinates).
    // This is an often necessary operation, which is why Processing has a special function.
    carverX = constrain(carverX, 0, cols - 1);
    carverY = constrain(carverY, 0, rows - 1);

    // Carve the current cell by setting it to a path (0)
    grid[carverX][carverY] = (grid[carverX][carverY]==1?0:1);

    // Draw the newly carved path immediately using a white point
    stroke(grid[carverX][carverY]==1?0:255);
    point(carverX, carverY);
  }

  // Optional visual highlight: draw the active carver position in red
  stroke(255, 0, 0);
  point(carverX, carverY);
}
