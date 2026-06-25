//Wykres fali  z własną funkcją definiująca bez nieciągłości wykresu
//-/////////////////////////////////////////////////////////////////

float mojaFunkcja(float x)
{
  return sin(x);
}

//Globalne ustawienia
void setup()
{
  size(1000,500); smooth();
}

float startX=0;
void draw()
{
  background(255);
  uklad();
  wykres();
  startX-=PI/100;
}

void wykres()
{
  stroke(255,0,0);    //Kolor wykresu funkcji
  
  float krokX=(PI*2)/1000; //Jaki fragment dziedziny na jedną kolumnę okna o długości 1000
  float krokY=2.0/500;     //Jaki fragment przeciwdziedziny na jeden wiersz okna o wysokości 500
  int oldw=-1;
  int oldk=-1;
  
  for(int k=0;k<1000;k++) //Przejście po wszystkich kolumnach pikseli
  {
    float x=k*krokX+startX;    //Przeliczenie kolumny okna na x z uwzględnieniem przesunięcia o startX 
    float y=mojaFunkcja(x);    //Obliczenie wartości funkcji dla danego x
    int  w=250-round(y/krokY); //Przeliczenie x na numer wiesza, 
    line(oldk,oldw,k,w);       //Nakreślenie linii od punktu poprzedniego do aktualnego
    oldk=k;oldw=w;             //Zapamiętanie pozycji punktu
  }
}

void uklad()  //Rysunek układu współrzędnych
{
  stroke(0,128,0);
  line(0,250,1000,250);   //Oś X
  line(1000,250,990,245); //Grot X
  line(1000,250,990,255); //Grot X c.d.
  line(0,0,0,500);        //Oś Y
  line(0,0,5,10);         //Pół grotu Y
}

// https://github.com/borkowsk/bookProcessingPL
