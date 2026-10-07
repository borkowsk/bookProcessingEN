//Wykres funkcji dwu zmiennych w trybie proceduralnym
//-///////////////////////////////////////////////////////

float mojaFunkcja(float x,float y) //TO JEST WIZUALIZOWANA FUNKCJA TRYGONOMETRYCZNA
{
  return cos(x)*cos(y);
}

//Globalne ustawienia
float krokX,krokY,mnozZ;
void setup()
{
  size(300,300);
  smooth();
  background(255);
  krokX=(PI*2)/width; //Jaki fragment X na jedną kolumnę okna o długości width
  krokY=(PI*2)/height; //Jaki fragment Y na jeden wiersz okna o wysokości height
  mnozZ=255;
  uklad();
  //blendMode(REPLACE);
}

int k=0; //Licznik pętli po kolumnach ukrytej w wywołaniach draw()
void draw() //Rysuje wykres kolumna po kolumnie
{
  if(k<width) //Przejście po wszystkich kolumnach pikseli
  {
    float x=k*krokX-PI;   //Przeliczenie kolumny okna na x , chcemy żeby też były ujemne
    for(int w=0;w<height;w++) // a w kolumnach przejście po wszystkich wierszach
    {
      float y=(height-w)*krokY-PI; //Przeliczenie wiersza okna na y , chcemy żeby też były ujemne
      float z=mojaFunkcja(x,y);    //Obliczenie funkcji
      if(z>0) stroke(z*mnozZ,z*mnozZ,0); //Ustalenie koloru dla wyników dodatnich
      else    stroke(0,0,-z*mnozZ); // oraz dla ujemnych
      point(k,w);            //Nakreślenie punktu w odpowiednim miejscu
    }
  }
  else
  {
      uklad();
  }
  k++; //Tu musimy sami zadbać o powiększanie licznika
}

void uklad()  //rysunek układu współrzędnych
{
  stroke(0,128,0);
  line(0,height/2,width,height/2);          //Oś X
  line(width,height/2,width-10,height/2-5); //Grot X
  line(width,height/2,width-10,height/2+5); //Grot X c.d.
  line(width/2,0,width/2,height);           //Oś Y
  line(width/2,0,width/2+5,10);             //Pół grotu Y
  line(width/2,0,width/2-5,10);             //Drugie pół grotu Y
}

// https://github.com/borkowsk/bookProcessingPL
