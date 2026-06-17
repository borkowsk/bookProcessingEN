//Najprostszy (prawie) układ chaotyczny
double R=3.000; //Parametr kontroli
double X=0.99; //Zmienna stanu, stan układu

double uklad(double x) // Xn --> Xn+1
{
  return R*x*(1-x); //implementacja układu
}

void setup()
{
  size(1000,1000);
  frameRate(300);
}

float scaleY(double X)
{
  return 1000-(float)X*1000;
}

int N=0;
int Rozbieg=400;
void draw()
{
 if(N<1000)
 {
    X=uklad(X);

    if(N<Rozbieg)
      point(((float)R-3)*1000,scaleY(X));
      else
      ellipse(((float)R-3)*1000,scaleY(X),2.0,2.0);
    N++;
 }
 else
 {
     R=random(1)+3;X=random(1);
     stroke((float)X*255,random(255),((float)R-3)*255);
     fill((float)X*255,random(255),((float)R-3)*255);
     N=0;
 }
}
