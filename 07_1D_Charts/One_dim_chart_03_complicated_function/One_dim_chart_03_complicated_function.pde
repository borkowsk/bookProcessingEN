// Wykres funkcji złożonej w trybie nie-proceduralnym
//-///////////////////////////////////////////////////////

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

stroke(255,0,0);    //Kolor wykresu funkcji

float stepX=(PI*2)/1000; //What portion of the domain corresponds to a single window column with a length of 1000?
float stepY=2.0/500;     //Which portion of the codomain corresponds to a single row of a window with a height of 500?
println('x','\t','y');   //Nagłówki kolumn na konsoli

for(int k=0;k<1000;k++)  //Przejście po wszystkich kolumnach pikseli
{
  float x=k*stepX;       //Converting a window column to `x` 
  float y=sin(x)*cos(x*2);       //Obliczenie wartości funkcji dla danego x
  int  w=250-round(y/stepY); //Conversion of `x` into a row number, 
                             //pamiętając że wiersze pikseli są numerowane od góry, 
                             //a funkcja sinus ma wartości z zakresu -1 do 1
  point(k,w);            //Nakreślenie punktu w odpowiednim miejscu
  println(x,'\t',y);     //Wydrukowanie wartości na konsoli
  //Wartości z konsoli można zaznaczyć (Ctrl-A) i przekopiować do schowka (Ctrl-C)
}

/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
