//Najprostszy (prawie) układ chaotyczny
double r=3.000; //Parametr kontroli
double X=0.99; //Zmienna stanu, stan układu

double uklad(double x) // Xn --> Xn+1
{
  return r*x*(1-x); //implementacja układu
}

void setup()
{
  size(1000,1000);
  rectMode(CENTER);
  frameRate(1000);
}

float scaleY(double X)
{
  return 1000-(float)X*1000;
}

float R=255,G=255,B=255;
int N=0;
int Y=0;
int Rozbieg=400;
void draw()
{
 if(N<1000)
 {
    X=uklad(X);

    if(N<Rozbieg)
      point(((float)r-3)*1000,scaleY(X));
      else
      {
        if(N==Rozbieg) noStroke();
        rect(((float)r-3)*1000,scaleY(X),1,2.0);
      }
    N++;
 }
 else
 {
     r=random(1)+3;X=random(1);
     R=((float)r-3)*255;G=255;B=-255*((float)r-4);
     stroke(R,G,B,50);
     fill(R,0,B,50);
     N=0;
 }
}
