//Control parameters
int W=600;

int radius()
{
  return int(random(W/10));
}

//Initialisation
void setup()
{
  //size(W,W);//NIE DZIAŁA W MODZIE JavaScript !!!
  size(600,600);
}

//Running - visualisation and dynamics (about 30 times per sec.)
void draw()
{
  fill(random(255),random(255),random(255),random(255));
  float r=radius();
  ellipse(random(W),random(W),r,r);
}
