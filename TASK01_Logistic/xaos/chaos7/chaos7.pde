//The simplest (almost) chaotic system
//Control parameters
//double R=1.99; //Point attractor
//double R=3.1; //Periodic two-point attractor
//double R=3; //Critical point
//double R=3.5; //4 points (periodic)
//double R=3.55; //8 points (periodic)
double R=3.565; //Still periodic, 14? points.
//double R=3.571; //Close to the edge of chaos
//double R=3.575; //Chaos
//double R=3.58; //Chaos, 4 clouds
//double R=3.6; //Chaos - attractor, 4 clouds and a pool
//double R=4; //Chaos - only the attractor, no pool due to lack of space

double X=0.0001; //State variable, state of the system
int FM=300;
int Rozbieg=100;

double iterate(double x) // Xn --> Xn+1
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

int N=0;
float G=0;
float B=255;
void draw()
{
 if(N<800)
 {
  double Xp=X;
  X=iterate(X);
  //println(N,X);
  stroke(255,0,0,25);
  line(N-1,scale(Xp),N,scale(X));
  stroke(0,G,B,128);
  ellipse(N,scale(X),3.0,3.0);
  point(800+(float)Xp*400,scale(X));
  if(N>Rozbieg)
    ellipse(800+(float)Xp*400,scale(X),3.0,3.0);
  N++;
 }
 else
 {
   N=0; 
   X=random(1.0);
   G=random(255);B=random(255);
 }
}




/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
