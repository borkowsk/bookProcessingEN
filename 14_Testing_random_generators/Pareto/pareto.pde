/// Program do testowania różnych sposobów losowania
//-////////////////////////////////////////////////////////////////////////////
/// http://www.javamex.com/tutorials/random_numbers/xorshift.shtml#.WT6NEzekKXI
/// https://math.stackexchange.com/questions/1777367/how-to-generate-a-random-number-from-a-pareto-distribution
//-/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// W tym wypadku rozkład Pareto, ale oparty na 64 bitowym generatorze XORshift
//-////////////////////////////////////////////////////////////////////////////

/// XOR SHIFT random generator - flat distribution (Generator losowy XOR SHIFT - rozkład płaski)
//-////////////////////////////////////////////////////////////////////////////////////////////

/// Seed...
long xl=123456789L;

/// Helper...
double mianownik=(double)9223372036854775807L; //9,223,372,036,854,775,807 <--- max long 

/// OBLICZANIE...
double MyRandom2()
{
  xl ^= (xl << 21);
  xl ^= (xl >>> 35);
  xl ^= (xl << 4);
  return (Math.abs(xl)/mianownik);
}

// Rozkład Pareto z rozkładu płaskiego
double a = 41.4104*(1-0.01); //Kształt - im większe tym ostrzej skośny rozkład
double b =  6.82053374; //Skalowanie - im większe tym większy zakres. 
                        //Wartość 6.n dobrana do zakresu 0..1
double limit = 1; //Akceptujemy tylko wartości od 0 do limit. 
                  //Większe powodują ponowne losowanie
  
double MyRandomPareto()
{
  double rndval;
  do 
  { 
   rndval = MyRandom2();
   double inv_fun_denom = Math.pow(1-rndval , 1/a);
   rndval = (b/inv_fun_denom)-b; //dodanie `-b` robi robotę
  }while(rndval>limit); //Akceptujemy tylko wartości od 0 do `limit`
  
  return rndval;
}

int NumOfBaskets=20;
int Basket[]=new int[NumOfBaskets+1];
int N=0; //Licznik losowań

//Pomocnicze zmienne do sensownej wizualizacji:
int ReqFrames=10; //Ile ramek na sekundę chcemy
int NumOfProbesPerDraw=100; //Ile losowań w jednej ramce
int MaxBasket=100; //Do skalowania słupków. Początkowo coś musi być. 

void setup()
{
  size(1000,500);
  frameRate(ReqFrames);
  for(int i=0;i<=NumOfBaskets;i++) //Resetowanie koszyków
           Basket[i]=0;
}

void draw()
{
  //Trochę losowań
  for(int s=0;s<NumOfProbesPerDraw;s++)
  {
    double rndval=MyRandomPareto(); //MyRandom1(); //Powinno być w zakresie 0..1
    
    //Testowanie spełnienia założenia:
    if(rndval<0) { println("Niemożliwe!!! rndval=",rndval); continue;}
    if(rndval>1) { println("Coś za dużo :-) rndval=",rndval); continue;}
    
    //Do którego to koszyka?
    int i=(int)(rndval*NumOfBaskets);
    if(i>NumOfBaskets)
        i=NumOfBaskets; //Zabezpieczenie
    
    Basket[i]++;    //Doliczenie
    N++;
  }
  
  background(255); //Czyszczenie ekranu
  VisualiseBaskets(); //Rysowanie histogramu
}

void VisualiseBaskets() //Rysowanie słupków
{
  for(int i=0;i<=NumOfBaskets;i++) //Aktualizacja maksimum
  if(Basket[i]>MaxBasket)
        MaxBasket=Basket[i];
 
  int StartX=width/10; //10% po obu stronach okna zostawiamy 
  int StartY=height/10;
  int WidthH=StartX*8; //użytkowa szerokość histogramu
  int HeighH=StartY*8; //... i wysokość
  int StepX=WidthH/(NumOfBaskets+1); //Szerokość jednego słupka
  
  for(int i=0;i<=NumOfBaskets;i++)
  {
    fill(255,0,255*Basket[i]/MaxBasket); //Wizualizacja kolorem
    rect(StartX+i*StepX,StartY+HeighH,StepX,-(HeighH*Basket[i]/MaxBasket));
  }
  
  fill(0);
  textSize(16);
  text("Max="+MaxBasket,0,StartY);
  text("0",StartX,StartY+HeighH+16);
  text("1",StartX+NumOfBaskets*StepX,StartY+HeighH+16);
  text("N="+N,StartX+WidthH,StartY+HeighH+16);
}
