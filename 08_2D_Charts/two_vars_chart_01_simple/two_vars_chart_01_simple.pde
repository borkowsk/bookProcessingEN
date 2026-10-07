/// Wykres funkcji dwu zmiennych (Z=x*y) w trybie bez-proceduralnym
//-////////////////////////////////////////////////////////////////

//Globalne ustawienia
size(1000,1000);
smooth();
background(255);

float krokX=(PI*2)/width; //Jaki fragment X na jedną kolumnę okna o długości width
float krokY=(PI*2)/height; //Jaki fragment Y na jeden wiersz okna o wysokości height

//Wykres 
for(int k=0;k<width;k++) //Przejście po wszystkich kolumnach pikseli
  for(int w=0;w<height;w++) // a w nich po wszystkich wierszach
  {
    float x=k*krokX-PI;   //Przeliczenie kolumny okna na x , chcemy żeby też były ujemne
    float y=(height-w)*krokY-PI; //Przeliczenie wiersza okna na y , chcemy żeby też były ujemne
    float z=x*y; 
    if(z>0) stroke(z*32,0,0);  //Ustalenie koloru dla wyników dodatnich
    else    stroke(0,0,-z*32); // oraz dla ujemnych
    point(k,w);                //Nakreślenie punktu w odpowiednim miejscu
  }

//Na "wierzchu" rysunek układu współrzędnych
stroke(0,128,0);
line(0,height/2,width,height/2);          //Oś X
line(width,height/2,width-10,height/2-5); //Grot X
line(width,height/2,width-10,height/2+5); //Grot X c.d.
line(width/2,0,width/2,height);           //Oś Y
line(width/2,0,width/2+5,10);             //Pół grotu Y
line(width/2,0,width/2-5,10);             //Drugie pół grotu Y

// https://github.com/borkowsk/bookProcessingPL
