// Resizable Processing window
// From Processing.org
// It works strange sometimes!

void setup() 
{
  size(400, 400);
  surface.setResizable(true);
}

void draw() 
{
  background(255);
  line(100, 100, width-100, height-100);
}

void keyPressed() 
{
  surface.setSize(round(random(200, 500)), 
                  round(random(200, 500)));
}

/// @date 2026-10-16 ( → https://github.com/borkowsk/bookProcessingEN)
