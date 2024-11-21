// Transparent random squares.
//*///////////////////////////

float W=.0; // global variable

void setup() // uses external W
{
  size(800,600);  // window size
  frameRate(200); // animation speed
  // Once you know what dimensions of the window are, 
  W=width/8;      // We can calculate 'W'
}

// Our own function
int side() // uses external W
{
  return int( random(W) );
}

// visualisation
void draw()
{
  float alfa=128+random(128); // random opacity (local variable)
  stroke(random(255),random(255),random(255),alfa); // same opacity
  fill(random(255),random(255),random(255),alfa); // for stroke & fill
  float s=side(); // side of the square (local variable)
  rect(random(width-s),random(height-s),s,s); // Think, why "-s" ?
}

// https://github.com/borkowsk/bookProcessingEN
// https://github.com/borkowsk/bookProcessingPL
