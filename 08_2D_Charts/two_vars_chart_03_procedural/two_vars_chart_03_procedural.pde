//Wykres funkcji dwu zmiennych w trybie proceduralnym
//-///////////////////////////////////////////////////////

float mojaFunkcja(float x,float y) //TO JEST WIZUALIZOWANA FUNKCJA TRYGONOMETRYCZNA
{
  return cos(x)*cos(y);
}

//Globalne ustawienia
float stepX,stepY,mnozZ;
void setup()
{
  size(300,300);
  smooth();
  background(255);
  stepX=(PI*2)/width; //Which segment of X corresponds to a single window column of length 'width'?
  stepY=(PI*2)/height; //Which Y-segment corresponds to a single row of a window with height `height`?
  mnozZ=255;
  axes();
  //blendMode(REPLACE);
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
      float z=mojaFunkcja(x,y);    //Obliczenie funkcji
      if(z>0) stroke(z*mnozZ,z*mnozZ,0); //Ustalenie koloru dla wyników dodatnich
      else    stroke(0,0,-z*mnozZ); // oraz dla ujemnych
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
