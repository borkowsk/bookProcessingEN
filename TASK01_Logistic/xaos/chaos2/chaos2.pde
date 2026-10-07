//Najprostszy (prawie) układ chaotyczny
double R=3.001; //Parametr kontroli
double X=0.99; //Zmienna stanu, stan układu

double uklad(double x) // Xn --> Xn+1
{
  return R*x*(1-x); //implementacja układu
}

void setup()
{
  size(1000,500);
  frameRate(200);
}

float scale(double X)
{
  return 500-(float)X*500;
}

int N=0;
void draw()
{
 if(N<1000)
 {
    double Xp=X;
    X=uklad(X);
    //println(frameCount,X);
    ellipse(N,scale(X),3.0,3.0);
    N++;
 }
 else
 {
     stroke(random(255),random(255),random(255));
     R=random(1)+3;
     X=random(1);
     N=0;
 }
}
