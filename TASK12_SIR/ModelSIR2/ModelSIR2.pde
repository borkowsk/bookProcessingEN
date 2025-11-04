// Dwuwymiarowy, probalilistyczny (kroki MC) automat komórkowy - reguła SIR
// Zasiewanie tablicy na początku z zadaną gęstością zdrowych oraz pojedynczą komórką zarażona
// LICZBA INTERAKCJI 4: CHOROBA JEST BARDZO KRÓTKA ALE BARDZO ZARAŹLIWA
////////////////////////////////////////////////////////////////////////////////////////////////

int WorldSize=400;//Ile chcemy elementów w linii i ile linii (tablica kwadratowa)

int[][] World=new int[WorldSize][WorldSize];//Tworzenie tablicy świata - w Processingu zawsze za pomocą alokacji

float IDens=0.99;//Początkowa gęstość w tablicy - jaka jest gęstość progowa,
                 //przy której epidemia zaatakuje ZAWSZE cały świat? (o ile już się zacznie)
                 //Choć mogą być małe rejony które ominęła.

//Coś w rodzaju stałych
final int Empty=0; 
final int Susceptible=1;
final int Infected=2;
final int Recovered=3;

void setup()
{
 size(400,400);    //Okno kwadratowe
 noSmooth();       //Znacząco przyśpiesza
 
 if(IDens>0)
  {
   for(int i=0;i<World.length;i++) //Zasiewanie tablicy
    for(int j=0;j<World.length;j++) 
      if(random(1.0)<IDens)
        World[i][j]=Susceptible;
      else
        World[i][j]=Empty;//Dla pewności, gdyby Empty nie było zero.
  }
 
 World[WorldSize/2][WorldSize/2]=Infected;
  
 frameRate(100);
}

int t=0;

void draw()
{  
  for(int i=0;i<World.length;i++)//Wizualizacja czyli "rysowanie na ekranie" 
    for(int j=0;j<World.length;j++) 
    {
      switch(World[i][j]){ //Instrukcja wyboru pozwala nam wybrać dowolny kolor w zależności od liczby w konmórce
      case 3:stroke(0,255,0);break;
      case 2:stroke(255,0,0);break;
      case 1:stroke(0,0,255);break;
      case 0:stroke(0,0,0);break;
      default: stroke(255);//To się pojawiac nie powinno
      break;
      } 
      point(i,j);
    }
  
  //Zmiana stanu automatu - krok Monte Carlo
  //STANY: Empty=0; Susceptible=1; Infected=2; Recovered=3;
  for(int a=0;a<World.length*World.length;a++)//Tyle losowań ile komórek
  {
       //Losowanie agenta 
       int i=(int)random(World.length);
       int j=(int)random(World.length);
       
       //Jesli pusty lub zdrowy zdrowy to nic nie robi
       if(World[i][j]!=Infected) continue;
       
       //Wyliczenie lokalizacji sąsiadów
       int right = (i+1) % WorldSize;      
       int left  = (WorldSize+i-1) % WorldSize;
       int dw=(j+1) % WorldSize;   
       int up=(WorldSize+j-1) % WorldSize;
       
       for(int b=0;b<4;b++)//Więcej interakcji
       {
         int neigh=(int)random(4);
         
         switch(neigh) //Tu trzeba bardzo uważac żeby się nie pomylić w indeksach
         {
         case 0: if(World[left] [j]==Susceptible) World[left][j]=Infected;  break;
         case 1: if(World[right][j]==Susceptible) World[right][j]=Infected;  break;
         case 2: if(World[i][up]==Susceptible) World[i][up]=Infected;break;
         case 3: if(World[i][dw]==Susceptible) World[i][dw]=Infected;break;
         default: println("Ups!",neigh);break;
         } 
       }
       World[i][j]=Recovered;
   }
      
   t++;//Kolejne pokolenie/krok/rok
   text("ST:"+t,0,10);
}

//////////////////////////////////////////////////////////////////////////////////
// Autor: Wojciech T. Borkowski
// Materiały do podręcznika "Processing w edukacji i symulacji
// https://github.com/borkowsk/sym4processing/tree/master/ProcessingWEdukacji
//////////////////////////////////////////////////////////////////////////////////
