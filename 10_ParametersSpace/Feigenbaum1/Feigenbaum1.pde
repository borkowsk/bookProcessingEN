//Najprostszy (prawie) układ chaotyczny
double R=3.000; //Parametr kontroli
double X=0.99; //Zmienna stanu, stan układu

double uklad(double x) // Xn --> Xn+1
{
  return R*x*(1-x); //implementacja układu
}

void setup()
{
  size(1000,500);
  frameRate(300);
}

float scaleY(double X)
{
  return 500-(float)X*500;
}

int N=0;
int Rozbieg=200;
void draw()
{
 if(N<1000)
 {
    X=uklad(X);

    if(N<Rozbieg)
      point(((float)R-3)*1000,scaleY(X));
      else
      ellipse(((float)R-3)*1000,scaleY(X),3.0,3.0);
    N++;
 }
 else
 {
     stroke(random(255),random(255),random(255));
     R=random(1)+3;X=random(1);
     N=0;
 }
}
