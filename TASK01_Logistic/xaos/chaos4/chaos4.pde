//Najprostszy (prawie) układ chaotyczny
double R=1.99; //Parametr kontroli
double X=0.99; //Zmienna stanu, stan układu
int FM=300;

double uklad(double x) // Xn --> Xn+1
{
  return R*x*(1-x); //implementacja układu
}

void setup()
{
  size(1500,500);
  frameRate(FM);
  line(1000,0,1000,500);
  noFill();
}

float scale(double X)
{
  return 500-(float)X*500;
}

void draw()
{
 if(frameCount<1000)
 {
  double Xp=X;
  X=uklad(X);
  println(frameCount,X);
  stroke(0,0,255);
  ellipse(frameCount,scale(X),3.0,3.0);
  stroke(255,0,0,128);
  line(frameCount-1,scale(Xp),frameCount,scale(X));
  point(1000+scale(Xp),scale(X));
  ellipse(1000+(float)Xp*500,scale(X),3.0,3.0);
 }
}
