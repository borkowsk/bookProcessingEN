//Wykres funkcji sercokrztałtnej dwu zmiennych w trybie proceduralnym
//-///////////////////////////////////////////////////////////////////

float sqr(float x)
{
  return x*x;
}

float mojaFunkcja(float x,float y) //TO JEST WIZUALIZOWANA FUNKCJA TRYGONOMETRYCZNA
{
  float a=2.5,c=-1.25;
  x+=2; y+=0.01;
  return sqr(sqr(x)+sqr(y)-a*x)-sqr(x)*sqr(y)+c;
}

//Globalne ustawienia
float stepX,stepY,mnozZ;
void setup()
{
  size(500,500);
  noSmooth();
  background(255);
  stepX=(PI*2)/width; //Which segment X for a single window column of length `width`
  stepY=(PI*2)/height; //Which Y-segment corresponds to a single row in a window of height `height`
  mnozZ=255;
  axes();
  //blendMode(DARKEST); //todobrzedziałatlkoprzy-Smooth
}

int k=0; //Licznik pętli po kolumnach ukrytej w wywołaniach draw()
void draw() //Rysuje wykres kolumna po kolumnie
{
  if(k<width) //Przejście po wszystkich kolumnach pikseli
  {
    float x=k*stepX-PI;   //Convert the window column to x; we want it to include negative values ​​as well.
    for(int w=0;w<height;w++) // a w kolumnach przejście po wszystkich wierszach
    {
      float y=(height-w)*stepY-PI; //Converting the window row to a y-coordinate; we want these to be negative as well.
      float z=mojaFunkcja(y,x);       //Obliczenie funkcji (zamieniamy x z y żeby "serce" miało "poprawne" połozenie)
      if(z>0) stroke(z*mnozZ,z*mnozZ,0); //Ustalenie koloru dla wyników dodatnich
      else    stroke(-z*mnozZ,0,0); // oraz dla ujemnych
      point(k,w);            //Nakreślenie punktu w odpowiednim miejscu
    }
  }
  else
  {
     axes();
  }
  k++; //Tu musimy sami zadbać o powiększanie licznika
}

void axes()  //rysunek układu współrzędnych
{
  stroke(0,128,0);
  line(0,height/2,width,height/2);          //Oś X
  line(width,height/2,width-10,height/2-5); //Grot X
  line(width,height/2,width-10,height/2+5); //Grot X c.d.
  line(width/2,0,width/2,height);           //Oś Y
  line(width/2,0,width/2+5,10);             //Pół grotu Y
  line(width/2,0,width/2-5,10);             //Drugie pół grotu Y
}




/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
