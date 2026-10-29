//The simplest (almost) chaotic system
//Control parameters
//double R=1.99; //Point attractor
//double R=3.1; //Periodic two-point attractor
//double R=3; //Critical point
//double R=3.5; //4 points (periodic)
double R=3.55; //8 points (periodic)
//double R=3.565; //Still periodic, 14? points.
//double R=3.5699; //???
//double R=3.571; //Just beyond the border of chaos
//double R=3.575; //Chaos
//double R=3.58; //Chaos, 4 clouds
//double R=3.6; //Chaos - attractor, 4 clouds and a pool
//double R=4; //Chaos - only the attractor, no pool due to lack of space

double X=0.9999; //State variable, state of the system
int FM=1000;
int Rozbieg=100;
int WvS=600; //Vertical window size
float G=0;
float B=255;
float Red=255;

double iterate(double x) // Xn --> Xn+1
{
  return R*x*(1-x); //state change implementation
}

void setup()
{
  //R=3+random(1.0); //If we want to do it this way, we can uncomment it.
  size(1800,600);
  frameRate(FM);
  line(2*WvS,0,2*WvS,WvS);
  textAlign(LEFT, BOTTOM);
  text("0.0",0,WvS);
  textAlign(RIGHT, BOTTOM);
  text(WvS*2,WvS*2,WvS);
  fill(0);
  textAlign(LEFT, TOP);
  text("1.0",WvS*2,0);
  textAlign(LEFT, BOTTOM);
  text("0.0",WvS*2,WvS);
  noFill();
  //noSmooth();
  stroke(0,G,B);
  rectMode(CENTER);
  rect(0,scale(X),4.0,4.0);
  rect(2*WvS,scale(X),5,5);
  println("req.FM:",FM," X=",X," R=",R);
}

float scale(double X)
{
  return WvS-(float)X*WvS;
}

int N=0;
void draw()
{
 if(N<2*WvS)
 {
  double Xp=X;
  X=iterate(X);
  //println(N,X);
  stroke(Red,0,0,25);
  line(N-1,scale(Xp),N,scale(X));
  stroke(0,G,B);
  ellipse(N,scale(X),4.0,4.0);
  point(2*WvS+(float)Xp*WvS,scale(X));
  if(N>Rozbieg)
    ellipse(2*WvS+(float)Xp*WvS,scale(X),4.0,4.0);
  N++;
 }
 else
 {
   N=0; 
   X=random(1.0);
   G=random(255);B=random(255);Red=random(255);
   stroke(0,G,B);
   rect(0,scale(X),4.0,4.0);
   rect(2*WvS,scale(X),5,5);
   println("realFM:",frameRate,"\tX=",X);
 }
}




/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
