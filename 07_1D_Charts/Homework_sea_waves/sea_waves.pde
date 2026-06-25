//Fale morskie jako wykres fali
//-/////////////////////////////////////////////////////////////

float mojaFunkcja(float x)
{
  return sin(x*2)/3;
}

//Globalne ustawienia
void setup()
{
  size(1000,500);
  smooth();
  frameRate(25);
}

float startX=0;
void draw()
{
  background(0,255,255);
  wykres();
  //uklad();
  startX-=PI/50; //Jeśli program będzie działał wystarczająco długo to tu się zaczną kłopoty.
                 //Dlaczego?
}

//Procedury rysujące:
//-------------------

void uklad()
{
  stroke(0,128,0);
  //Rysunek układu współrzędnych
  line(0,250,1000,250);   //Oś X
  line(1000,250,990,245); //Grot X
  line(1000,250,990,255); //Grot X c.d.
  line(0,0,0,500);        //Oś Y
  line(0,0,5,10);         //Pół grotu Y
}

void wykres()
{
  stroke(0,0,255);        //Kolor wykresu funkcji
  
  float krokX=(PI*2)/1000; //Jaki fragment dziedziny na jedną kolumnę okna o długości 1000
  float krokY=2.0/500;     //Jaki fragment przeciwdziedziny na jeden wiersz okna o wysokości 500

  for(int k=0;k<1000;k++) //Przejście po wszystkich kolumnach pikseli
  {
    float x=k*krokX+startX;    //Przeliczenie kolumny okna na x z uwzględnieniem przesunięcia o startX 
    float y=mojaFunkcja(x);    //Obliczenie wartości funkcji dla danego x
    int  w=250-round(y/krokY); //Przeliczenie x na numer wiesza, 
                               //pamiętając, że wiersze pikseli są numerowane od góry, 
                               //a funkcja sinus ma wartości z zakresu -1 do 1
    line(k,500,k,w);           //Nakreślenie linii od dołu do punktu aktualnego
  }
}


// https://github.com/borkowsk/bookProcessingPL
