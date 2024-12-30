/// Ellipses example:
//*//////////////////

int W=600;  ///< Global control parameter.

int radius() // uses global W
{
  return int(random(W/10));
}

// Initialisation:
void setup()
{
  size(600,600);
}

// Running - visualisation and dynamics (many times per sec.).
void draw()
{
  fill(random(255),random(255),random(255),random(255));
  float r=radius();
  ellipse(random(W),random(W),r,r);
}

// https://github.com/borkowsk/bookProcessingEN
