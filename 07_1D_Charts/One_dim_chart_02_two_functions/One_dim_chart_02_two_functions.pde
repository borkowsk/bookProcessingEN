//Wykresy funkcji sinus i cosinus w trybie bez-proceduralnym
//-/////////////////////////////////////////////////////////

//Globalne ustawienia
size(1000,500);
smooth();
background(255);
stroke(0,128,0);

//Rysunek układu współrzędnych
line(0,250,1000,250);   //Oś X
line(1000,250,990,245); //Grot X
line(1000,250,990,255); //Grot X c.d.
line(0,0,0,500);        //Oś Y
line(0,0,5,10);         //Pół grotu Y

float stepX=(PI*2)/1000; //What portion of the domain corresponds to a single window column with a length of 1000?
float stepY=2.0/500;     //Which portion of the codomain corresponds to a single row of a window with a height of 500?

stroke(255,0,0);    //Kolor wykresu funkcji sinus

//Wykres sinus(x) 
for(int k=0;k<1000;k++) //Przejście po wszystkich kolumnach pikseli
{
  float x=k*stepX;      //Converting a window column to `x` 
  float y=sin(x);       //Obliczenie wartości funkcji dla danego x
  int  w=250-round(y/stepY); //Conversion of `x` into a row number, 
                             //pamiętając że wiersze pikseli są numerowane od góry, 
                             //a funkcja sinus ma wartości z zakresu -1 do 1
  point(k,w);            //Nakreślenie punktu w odpowiednim miejscu
}

stroke(0,0,255);    //Kolor wykresu funkcji cosinus

//Wykres cosinus(x) 
for(int k=0;k<1000;k++) //Przejście po wszystkich kolumnach pikseli
{
  float x=k*stepX;      //Converting a window column to `x` 
  float y=cos(x);       //Obliczenie wartości funkcji dla danego x
  int  w=250-round(y/stepY); //Conversion of `x` into a row number, 
                            //pamiętając że wiersze pikseli są numerowane od góry, 
                            //a funkcja sinus ma wartości z zakresu -1 do 1
  point(k,w);            //Nakreślenie punktu w odpowiednim miejscu
}

/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
