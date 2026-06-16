// 1. Declaration and Creation using 'new' (50x50 grid)
int cols = 50;
int rows = 50;
int[][] grid = new int[cols][rows];

// Set the window size to 200x200 pixels
size(200, 200);
background(255); // White background
noStroke();      // Remove borders from rectangles for a cleaner look

// Calculate the size of each cell in pixels
// 200 pixels / 50 cells = 4 pixels per cell
int cellSize = width / cols;

// 2. Randomly fill the grid with 0s and 1s
for (int x = 0; x < cols; x++) 
{
  for (int y = 0; y < rows; y++) 
  {
    // int(random(2)) generates 0 or 1 (since 2 is exclusive)
    grid[x][y] = int(random(2));
  }
}

// 3. Display the grid in the window using rectangles
for (int x = 0; x < cols; x++) 
{
  for (int y = 0; y < rows; y++) 
  {
    // Set color based on cell value: 1 = Black, 0 = White
    if (grid[x][y] == 1) 
      fill(128);
    else 
      fill(255,255,0);

    // Draw the rectangle at the correct pixel position
    // x * cellSize and y * cellSize map the grid index to window coordinates
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }
}
