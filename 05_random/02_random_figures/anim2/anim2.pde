/// Simple animation example with random.
//*//////////////////////////////////////

void setup()  
{
  size(500,200);       // the size of the window.
  background(0,0,128); // thr background color.
}

void draw()
{
  stroke(random(256),random(256),random(256));
  point(random(width),random(height));
}

// https://github.com/borkowsk/bookProcessingEN
