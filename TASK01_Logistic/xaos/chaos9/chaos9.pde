//Najprostszy (prawie) układ chaotyczny
//Parametry kontroli
//double R=1.99; //Atraktor punktowy
//double R=3.1; //Atraktor okresowy dwupunktowy
//double R=3; //Punk krytyczny
//double R=3.5; //4 punkty
double R=3.55; //8 punktowy
//double R=3.565; //Jeszcze okresowy, 14? pkt.
//double R=3.5699; //???
//double R=3.571; //Tuż za granicą chaosu
//double R=3.575; //Chaos
//double R=3.58; //Chaos, 4 chmury
//double R=3.6; //Chaos - atraktor, 4 chmury i basen
//double R=4; //Chaos - sam atraktor bez basenu

double X=0.9999; //Zmienna stanu, stan układu
int FM=1000;
int Rozbieg=100;
int WvS=600; //Rozmiar okna w pionie
float G=0;
float B=255;
float Red=255;

double uklad(double x) // Xn --> Xn+1
{
  return R*x*(1-x); //implementacja układu
}

void setup()
{
  //R=3+random(1.0); //Jak chcemy stały to odkomentować
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
  X=uklad(X);
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
