//Wykres fali zdefiniowanej własną funkcją
//-///////////////////////////////////////

float mojaFunkcja(float x)
{
  return sin(x);
}

//Globalne ustawienia
void setup()
{
  size(1000,500);
  smooth();
}

float startX=0;
void draw() //używa procedur rysujących zdefiniowanych dalej.
{
  background(255);
  uklad();
  wykres();
  startX-=PI/100;
}

//Procedury rysujące:
//-------------------

void uklad()   //Rysunek układu współrzędnych
{
  stroke(0,128,0);
  line(0,250,1000,250);   //Oś X
  line(1000,250,990,245); //Grot X
  line(1000,250,990,255); //Grot X c.d.
  line(0,0,0,500);        //Oś Y
  line(0,0,5,10);         //Pół grotu Y
}

void wykres() //Właściwy wykres funkcji
{
  stroke(255,0,0);    //Kolor wykresu funkcji
  
  float krokX=(PI*2)/1000; //Jaki fragment dziedziny na jedną kolumnę okna o długości 1000
  float krokY=2.0/500;     //Jaki fragment przeciwdziedziny na jeden wiersz okna o wysokości 500

  for(int k=0;k<1000;k++) //Przejście po wszystkich kolumnach pikseli
  {
    float x=k*krokX+startX;    //Przeliczenie kolumny okna na x z uwzględnieniem przesunięcia o startX 
    float y=mojaFunkcja(x);    //Obliczenie wartości funkcji dla danego x
    int  w=250-round(y/krokY); //Przeliczenie x na numer wiesza, 
                               //pamiętając że wiersze pikseli są numerowane od góry, 
                               //a funkcja sinus ma wartości z zakresu -1 do 1
    point(k,w);                //Nakreślenie punktu w odpowiednim miejscu
  }
}

// https://github.com/borkowsk/bookProcessingPL
