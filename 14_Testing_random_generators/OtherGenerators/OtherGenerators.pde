//Program dop testowania różnych sposobów losowania
//-////////////////////////////////////////////////////////////////////////////////////////////////////////////
// https://en.wikipedia.org/wiki/Normal_distribution#Generating_values_from_normal_distribution
//-////////////////////////////////////////////////////////////////////////////////////////////////////////////

double MyRandom0()
{
  return random(0,1); //Random z Processingu
  //zamiast można wpisać inne generatory 
}

double x=0.333;
double MyRandom1()
{ //Iteracja logistyczna z chaotycznym R
  //chaos deterministyczny - słabe jako generator
  x=x*4*(1-x);
  return x;
}

long xl=123456789L;
double mianownik=(double)9223372036854775807L; // albo Long.MAX_VALUE;
//9,223,372,036,854,775,807 <--- max long 
double MyRandom2() //http://www.javamex.com/tutorials/random_numbers/xorshift.shtml#.WT6NEzekKXI
{
  //XOR SHIFT random generator
  xl ^= (xl << 21);
  xl ^= (xl >>> 35);
  xl ^= (xl << 4);
  return (Math.abs(xl)/mianownik);
}


double MyRandomM() // M od "manipulacje"
{
  //return random(0,1);
  //return Math.random(); //Druga wersja - random z Javy
  //return Math.random()*Math.random(); //Mnożenie 2 rozkładów 
  //return Math.random()*Math.random()*Math.random(); //Mnożenie 3 rozkładów
  //return Math.random()*Math.random()*Math.random()*Math.random()*Math.random()*Math.random(); //Mnożenie 6 rozkładów
  //return (Math.random()+Math.random())/2; //Dodanie 2
  //return (Math.random()+Math.random()+Math.random())/3; //Dodanie 3
  //return (Math.random()+Math.random()+Math.random()+Math.random()+Math.random()+Math.random())/6; //Dodawanie 6 rozkładów
  return (Math.random()+Math.random()+Math.random()+Math.random()+Math.random()+Math.random()+
          Math.random()+Math.random()+Math.random()+Math.random()+Math.random()+Math.random())/12; //Dodawanie 12 rozkładów
}

int NumOfBaskets=100;
int Basket[]=new int[NumOfBaskets+1];
int N=0; //Licznik losowań

//Do sensownej wizualizacji
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
    double rndval=MyRandom0(); //MyRandomM(); //Powinno być w zakresie 0..1
     
    //Testowanie spełnienia założenia.
    if(rndval<0) { println("Niemożliwe!!! rndval=",rndval); continue;}
    if(rndval>1) { println("Coś skopane :-) rndval=",rndval); continue;}
    
    //Do którego to koszyka?
    int i=(int)(rndval*NumOfBaskets);
    if(i>NumOfBaskets)
        i=NumOfBaskets; //Zabezpieczenie
    
    Basket[i]++;    //Doliczenie
    N++; //https://www.facebook.com/ModelowanieProcesowSpolecznych/posts/1406909939488446
  }
  
  background(255);    //Czyszczenie ekranu
  VisualiseBaskets(); //Rysowanie histogramu
}

void VisualiseBaskets() //Rysowanie słupków
{
  MaxBasket=0;print('*');
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
