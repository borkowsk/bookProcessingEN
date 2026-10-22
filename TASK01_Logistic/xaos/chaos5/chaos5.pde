//The simplest (almost) chaotic system
//Control parameters
//double R=1.99; //Point attractor
//double R=3.1; //Periodic two-point attractor
//double R=3; //Critical point
//double R=3.5; //4 points (periodic)
//double R=3.55; //8 points (periodic)
//double R=3.565; //Still periodic, 14? points.
double R=3.571; //Close to the edge of chaos
//double R=3.575; //Chaos
//double R=3.58; //Chaos, 4 clouds
//double R=3.6; //Chaos - attractor, 4 clouds and a pool
//double R=4; //Chaos - only the attractor, no pool due to lack of space

double X=0.0001; //State variable, state of the system
int FM=300;
int Rozbieg=100;

double uklad(double x) // Xn --> Xn+1
{
  return R*x*(1-x); //state change implementation
}

void setup()
{
  size(1200,400);
  frameRate(FM);
  line(800,0,800,400);
  noFill();
}

float scale(double X)
{
  return 400-(float)X*400;
}

void draw()
{
 if(frameCount<800)
 {
  double Xp=X;
  X=uklad(X);
  println(frameCount,X);
  stroke(0,0,255);
  ellipse(frameCount,scale(X),3.0,3.0);
  stroke(255,0,0,128);
  line(frameCount-1,scale(Xp),frameCount,scale(X));
  point(800+(float)Xp*400,scale(X));
  if(frameCount>Rozbieg)
  {
    ellipse(800+(float)Xp*400,scale(X),3.0,3.0);
  }
 }
}
