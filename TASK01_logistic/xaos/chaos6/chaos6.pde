//Najprostszy (prawie) układ chaotyczny
//Parametry kontroli
//double R=1.99; //Atraktor punktowy
//double R=3.1; //Atraktor okresowy dwupunktowy
//double R=3; //Punk krytyczny
//double R=3.5; //4 punkty
//double R=3.55; //8 punktowy
double R=3.565; //Jeszcze okresowy, 14? pkt.
//double R=3.571; //Blisko granicy chaosu
//double R=3.575; //Chaos
//double R=3.58; //Chaos, 4 chmury
//double R=3.6; //Chaos - atraktor, 4 chmury i basen
//double R=4; //Chaos - sam atraktor bez basenu

double X=0.0001; //Zmienna stanu, stan układu
int FM=300;
int Rozbieg=100;

double uklad(double x) // Xn --> Xn+1
{
  return R*x*(1-x); //implementacja układu
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
void draw()
{
 if(N<800)
 {
  double Xp=X;
  X=uklad(X);
  //println(N,X);
  stroke(0,0,255);
  ellipse(N,scale(X),3.0,3.0);
  stroke(255,0,0,128);
  line(N-1,scale(Xp),N,scale(X));
  point(800+(float)Xp*400,scale(X));
  if(N>Rozbieg)
    ellipse(800+(float)Xp*400,scale(X),3.0,3.0);
  N++;
 }
 else
 {
   N=0; X=random(1.0);
 }
}
