/* Model społecznego dylematu więźnia z rozmnażaniem i opcjonalnymi mutacjami */
/* Oraz opcjonalnie z uzyciem modelu Nowaka/Latane do zmiany postaw */

class Agent {
    int  poglad=0;  /* 0..IlePostaw-1 */
    int    sila=0;  /* Jeśli 0 to martwy */
    float stres=0;  /* Wartosc stresu ekonomicznego */
}

int MaxBok = 500;
// Jeśli jest zainicjowany na "false" to startuje formularzem. Jak na true to od razu rusza.
boolean isRunning=false;

int MaxIlePostaw = 21;
int LastHist = 100;
int HistSize = 9;

float MinPoziomSzumu = 0;
float MaxPoziomSzumu = 0.15;
float MinZaludnienie = 0;
float MaxZaludnienie = 1;

/* Ogólne parametry modelu - gdy zyski ze wspolpracy male, wplyw ma decydujace znaczenie! */
int Bok = 50;   /* Długość boku świata */
int IlePostaw = 2; /* Liczba możliwych pogladów 2--> */
float Zaludnienie = 0.5; /* Zaludnienie 0..1 */
int MaxSila = 10000;/* Najwieksza sila  */
int Rozklad = 7;   /* Stopien rozkładu "Pareto" >=0 - zero daje brak rozkladu, same MaxSila. Max: 12 */

/* Specyficzne parametry modelu */
int KosztKroku = 5;
int OptimumZapasu = 50;
int[][] TabelaWyp = {{6, 12}, {-12, -6}}; //< TABELA WYPŁAT DYLEMATU WIEŹNIA.

boolean UzyjWplywuDlaPostaw = false;
boolean StresZageszczenia = false;

double PoziomSzumu = 0; /* Szum czyli losowe "mutacje" poglądów */
String FileNameCore = "priz";/* np. rdzeń nazwy pliku */
PrintWriter logFile = null;

/* Wizualizacyjne */
int Rozmiar = 15;  /* Długość boku najsiliejszego agenta */
int NajmRoz = 2; /* Jaki rozmiar wizualizacyjny mają najslabsi agenci w populacji */
int Brzeg = 0;  /* Obwodka wokół agenta */

int CzestoscWizualizacji = 1; /* Co ile kroków Monte Carlo odrysowawywać */
int Chwila = 10; /* Ile milisekund dla oka po wizualizacji */
int MaxKrok = 10000;   /* Ile maksymalnie kroków w eksperymencie */

/* Obowiązkowe parametry wizualizacji. Przedrostek S od SCREEN */
int SWIDTH = 780;    /* Szerokość obszaru roboczego głównego okna */
int SHEIGHT = 800;   /* Wysokość obszaru roboczego głównego okna */

Agent[][] SwiatSymulacji;

int numerkroku = 0;
int deficytzycia = 0;

/* Tablica kierunków do ułatwienia ruchu i interakcji */
int[][] dxy = {{0,1},{0,-1},{1,0},{-1,0},{-1,-1},{1,1},{-1,1},{1,-1}};

PrintWriter F;
String N_filename;
double[] StresGlobalny_arr = new double[1];
double[] SilaSrednia_arr = new double[1];
double[] SilaMax_arr = new double[1];
int[] Wyznawcy;

int ileTrzeba=500; //< Szerokość lub wysokość konieczna na samą wizualizację świata.
void settings() {
  ileTrzeba=(Bok+2)*(Rozmiar+Brzeg);
  size(ileTrzeba, ileTrzeba+80);
}

void setup() {
  if(!isRunning)
  {
    createGUI(); //Tworzenie formularza. Model powstanie dopiero na kliknięcie OK.
    noLoop();
  }
  else
  {
    uruchomSymulacje();
    loop();
  }
}

// Funkcja uruchamiająca model po zatwierdzeniu formularza
void uruchomSymulacje() {                                  assert(MaxBok>1);
  SwiatSymulacji = new Agent[MaxBok + 1][MaxBok + 1];
  
  for(int i = 0; i <= MaxBok; i++) {
    for(int j = 0; j <= MaxBok; j++) {
      SwiatSymulacji[i][j] = new Agent();
    }
  }
  Wyznawcy = new int[MaxIlePostaw + 1];

  Inicjacja(SwiatSymulacji);
  numerkroku = 0;
  deficytzycia = 0;
  
  N_filename = FileNameCore
      + Bok + "x" + Bok  /* Długość boku świata */
      + "P" + IlePostaw   /* Liczba konkurujących pogladów 2..10 */
      + "G" + Zaludnienie /* Zaludnienie zaludnienia 0..1 */
      + "M" + PoziomSzumu /* Szum czyli losowe "mutacje" poglądów */
      + "m" + MaxSila   /* Najwieksza sila - musi byc odpowiednio duża do rozkładu min:1, max: 1 000 000 */
      + "k" + KosztKroku
      + "op" + OptimumZapasu
      + "W(" + TabelaWyp[0][0] + ")(" + TabelaWyp[1][1] + ")(" + TabelaWyp[0][1] + ")"
      + (UzyjWplywuDlaPostaw ? "WPLY" : "b.wpl")
      + "-"
      + (StresZageszczenia ? "S.ZAG" : "tlok")
      + ".log";
  
  println("Log file is '"+N_filename+"'");    
      
  F = createWriter(N_filename);
  F.println(N_filename);
  F.println("Krok\tStres\tEnergiaSr\tEnergiaMax\tLiczby wyznawców");
}

void Inicjacja(Agent[][] TenSwiat) {
/* Wypełnianie świata. Nieżywe mają siłę = 0 */
   int i,j,k;
   float pomoc; 
  for(i = 1; i <= Bok; i++) {
    for(j = 1; j <= Bok; j++) {
      if (random(1) < Zaludnienie) {
        /* Żywy */ 
        TenSwiat[i][j].poglad = int(random(IlePostaw));
        pomoc = 1; 
        for(k = 1; k <= Rozklad; k++) {
          pomoc = pomoc * random(1); 
        }
        TenSwiat[i][j].sila = 1 + int(pomoc * (MaxSila - 1));
        TenSwiat[i][j].stres = 0; /* Na razie nie zestresowany... */
      } else {
        /* Martwy */
        TenSwiat[i][j].poglad = IlePostaw;
        TenSwiat[i][j].stres = 0; /* Nie zestresowany... */
        TenSwiat[i][j].sila = 0; /* Bo 0 znaczy MARTWY!!! */
      }
    }
  }
}

double Przeskaluj(double v, double min, double max) { 
/* Do wizualizacji */
  return (v - min) / (max - min); 
}

double Przelogarytmuj(double v, double max) { 
/* Do wizualizacji */
  v = Math.log(v + 1); 
  return v / Math.log(max + 1); 
}

void Wizualizacja(Agent[][] TenSwiat) { 
/* Kwadratami o wielkosci proporcjonalnej do logarytmu sily */ 
  int i,j;    /* Przechodzenie po agentach */
  double q,r,s,rRoz;  /* Przeliczone cechy agenta */
  int WRoz,ri,vi;/* Rozmiar wewnętrzny i pozycjonowanie */

  rRoz = 1.0 - (double)NajmRoz / Rozmiar;
  WRoz = Rozmiar - Brzeg; /* Nie uwaględniamy szerokości obwódki (Bord), ale to specyfika ALGO */
  
  for(i = 1; i <= Bok; i++) {
    for(j = 1; j <= Bok; j++) {
      stroke(100, 100, 100);
      fill(128, 128, 128);
      rect(i * Rozmiar, j * Rozmiar, Rozmiar, Rozmiar);
      if (TenSwiat[i][j].sila > 0) {
        q = Przeskaluj(TenSwiat[i][j].poglad, 0, IlePostaw - 1) * 255;
        r = Przelogarytmuj(TenSwiat[i][j].sila, MaxSila) * rRoz;
        s = Przeskaluj(TenSwiat[i][j].stres, 0, 1) * 255;
        ri = NajmRoz + round((float)(r * (WRoz - NajmRoz))); 
        vi = (Rozmiar - ri) / 2;
        stroke((float)s, 0, 0);
        fill(0, (float)(255 - q), (float)q);
        rect(i * Rozmiar + vi, j * Rozmiar + vi, ri, ri);
      } 
    }
  }
}

void OpcjonalnyWplywSpoleczny(Agent[][] TenSwiat) {
/* Procedura zmiany poglądów agentów. Zawiera procedury pomocnicze. */

  class InnerHelper {
    
    void ZliczWplywy(int x, int y, int[] Liczniki,Agent[][] TenSwiat) {
    /* Wewnetrzna procedura dla zliczania wplywów */
      int lewo,prawo,gora,dol,i,j;
      lewo = x - 1;   if (lewo < 1) lewo = 1;
      prawo = x + 1;  if (prawo > Bok)  prawo = Bok;
      gora = y - 1;   if (gora < 1) gora = 1;
      dol = y + 1;    if (dol > Bok) dol = Bok;
  
      for(i = lewo; i <= prawo; i++) {
        for(j = gora; j <= dol; j++) {
          if (TenSwiat[i][j].sila > 0) {
            Liczniki[TenSwiat[i][j].poglad] = Liczniki[TenSwiat[i][j].poglad] + TenSwiat[i][j].sila;/* !!! */
          }
        }
      }
    }
  
    int Ustalpoglad(int[] Liczniki) { 
    /* Wewnetrzna funkcja dla KrokSymulacji, znajdująca nawiększy licznik */ 
      int max,nowy,i,j;
      max = 0;
      nowy = -1;
      j = int(random(IlePostaw));/* Zeby uniknac niejawnego bias-owania */
      for(i = 0; i < IlePostaw; i++) { /* Petla tylko dba o przejrzenioe calej tablicy */
        if (Liczniki[j] > max) {
          max = Liczniki[j];
          nowy = j;
        }
        j = (j + 1) % IlePostaw; /* Zeby obejsc cala tablice zaczynajac z losowego miesjca */
      }
      return nowy;
    }
  }

  int i,j,k,l,N;
  int[] liczniki = new int[MaxIlePostaw + 1];
  InnerHelper helper = new InnerHelper();

  N = Bok * Bok;
  for(k = 1; k <= N; k++) {
    for(l = 0; l <= IlePostaw; l++) {
      liczniki[l] = 0;
    }
    i = 1 + int(random(Bok));
    j = 1 + int(random(Bok));
    if (TenSwiat[i][j].sila > 0) { /* Bo bywają też martwi... */
      if (random(1) < PoziomSzumu) {
        TenSwiat[i][j].poglad = int(random(IlePostaw));
      } else {
        helper.ZliczWplywy(i, j, liczniki,TenSwiat);
        TenSwiat[i][j].poglad = helper.Ustalpoglad(liczniki);
      }
    }
  }
}

void PoliczStresy(Agent[][] Tab) {
/* Oblicza aktualne stresy ekonomiczne dla wszystkich agentów */
  int i,j;
  float Wartosc;

  class StresHelper {
    
    int ZliczSasiadow(int x, int y,Agent[][] Tab) {
    /* Wewnetrzna procedura zliczajaca sasiadow */
       int lewo,prawo,gora,dol,i,j,licznik;
      lewo = x - 1;   if (lewo < 1) lewo = 1;
      prawo = x + 1;  if (prawo > Bok)  prawo = Bok;
      gora = y - 1;   if (gora < 1) gora = 1;
      dol = y + 1;    if (dol > Bok) dol = Bok;
      licznik = 0;
      for(i = lewo; i <= prawo; i++) {
        for(j = gora; j <= dol; j++) {
          if (Tab[i][j].sila > 0) {
            licznik++;
          }
        }
      }
      return licznik;
    }
    
  }

 StresHelper helper = new StresHelper();

 for(i = 1; i <= Bok; i++) { //<>//
    for(j = 1; j <= Bok; j++) {
      if (Tab[i][j].sila > 0) {
        /* Na ile dni ma zapas */
        Wartosc = Tab[i][j].sila / KosztKroku;
        /* Jaka to czesc wartosci wymaganej? */
        Wartosc = Wartosc / OptimumZapasu;
        /* Zapamietaj na Krok MC */
        if (Wartosc < 1) {
          Tab[i][j].stres = 1 - Wartosc;
        } else {
          Tab[i][j].stres = 0;
        }
        /* Jeśli nie lubią zbytniej ciasnoty to się wtedy stresują */
        if (StresZageszczenia &&
          (Tab[i][j].stres < 0.9) &&
          (helper.ZliczSasiadow(i, j,Tab) > 7)) {
            Tab[i][j].stres = Tab[i][j].stres + 0.1;
        }
      }
    }
  }
}

void ZyjIUmieraj(Agent[][] TenSwiat) {
/* Procedura metabolizmu, rozmnażania i poruszania */

  class ZyjHelper {
    boolean SprobujRuchu(int kierunek, int x, int y, int[] nx, int[] ny,Agent[][] TenSwiat) {
    /* Czy pole nadaje sie do ruchu? */
      nx[0] = x + dxy[kierunek][0];
      ny[0] = y + dxy[kierunek][1];
      /* Zamkniecie z krawedziami */
      if (nx[0] < 1) nx[0] = 1;
      if (nx[0] > Bok) nx[0] = Bok;
      if (ny[0] < 1) ny[0] = 1;
      if (ny[0] > Bok) ny[0] = Bok;
      /* Mozna się przesunąc tylko na puste pole */
      return (TenSwiat[nx[0]][ny[0]].sila == 0);
    }
  
    void Przesuwaj(int x, int y, int nx, int ny, Agent[][] TenSwiat) {
    /* Przemieszcza agenta w zadane miejsce */
      TenSwiat[nx][ny].poglad = TenSwiat[x][y].poglad;
      TenSwiat[nx][ny].sila = TenSwiat[x][y].sila;
      TenSwiat[nx][ny].stres = TenSwiat[x][y].stres;
      /* Parowanie sladu */
      TenSwiat[x][y].sila = 0;
      TenSwiat[x][y].stres = 0;
      TenSwiat[x][y].poglad = IlePostaw;
    }
  
    void ZasiejNowego(Agent[][] TenSwiat) {
    /* Tworzy nowego agenta jako kopie losowego */
       int kierunek,i,j,m,n,NN;
       int[] nx = new int[1];
       int[] ny = new int[1];
       NN = Bok * Bok * 3; /* Zabezpieczenie na nieskonczonosc */
       while(true) { /* Tak długo aż nie będzie pary pól spełniających kryteria */
        i = 1 + int(random(Bok));
        j = 1 + int(random(Bok));
        kierunek = int(random(8));
        NN--;
        if (NN == 0) {
            deficytzycia++;
            return; /* Ta procedura już nie da rady */
        }
        if ((TenSwiat[i][j].sila > KosztKroku * 2) && (SprobujRuchu(kierunek, i, j, nx, ny,TenSwiat))) {
           m = nx[0];
           n = ny[0];
           TenSwiat[i][j].sila = TenSwiat[i][j].sila / 2; /* Bo dzieli się energią */
           TenSwiat[i][j].stres = 0; /* Przez chwilę nie ma stresu, żeby nie uciekli */
           
           TenSwiat[m][n].poglad = TenSwiat[i][j].poglad;
           TenSwiat[m][n].sila = TenSwiat[i][j].sila;
           TenSwiat[m][n].stres = TenSwiat[i][j].stres;
  
           if ((PoziomSzumu > 0) && (random(1) < PoziomSzumu)) { /* EWENTUALNA MUTACJA */
                TenSwiat[m][n].poglad = int(random(IlePostaw));
           }
           break;
        }
       }
    }
  }

 if(!isRunning) //<>//
 { 
   println("Jeszcze nie skonfigurowano!");
   return; //<>//
 }

 ZyjHelper zyjHelper = new ZyjHelper();
 int kierunek,i,j,k,m,n,NN;
 int[] nx = new int[1];
 int[] ny = new int[1];
 
 if(deficytzycia != 0) { /* Dodatkowa próba zasiania nowego */
  deficytzycia--;
  zyjHelper.ZasiejNowego(TenSwiat);
 }
 
 NN = Bok * Bok;
 for(k = 1; k <= NN; k++) {
    i = 1 + int(random(Bok));
    j = 1 + int(random(Bok));
    if (TenSwiat[i][j].poglad != IlePostaw) {
             if (TenSwiat[i][j].sila <= 0) {
                      println("NIESPÓJNOŚC ALGORYTMU: Agenci z siłą <=0 mają postawę!!");
             }
    }
    if (TenSwiat[i][j].sila > 0) {
        /* Czy aby jeszcze żyje */
        TenSwiat[i][j].sila = TenSwiat[i][j].sila - KosztKroku;
        if (TenSwiat[i][j].sila <= 0) {
          /* Śmierc i rozkład */
          TenSwiat[i][j].sila = 0;
          TenSwiat[i][j].stres = 0;
          TenSwiat[i][j].poglad = IlePostaw;
          /* I nowe życie... */
          zyjHelper.ZasiejNowego(TenSwiat);
        } else { /* Ostatecznie próbuje ruchu jesli jest w stresie */
          if (random(1) < TenSwiat[i][j].stres) {
           kierunek = int(random(8));
           if (zyjHelper.SprobujRuchu(kierunek, i, j, nx, ny,TenSwiat)) {
              zyjHelper.Przesuwaj(i, j, nx[0], ny[0],TenSwiat);
           }
          }
        }
    }
 }
}

void KooperujRywalizuj(Agent[][] TenSwiat) {
  int kierunek,i,j,k,m,n,NN,p,q;
  int[] nx = new int[1];
  int[] ny = new int[1];

  class KoopHelper {
    boolean SprobujPole(int kierunek, int x, int y, int[] nx, int[] ny,Agent[][] TenSwiat) {
    /* Czy pole zawiera wspolczlonka spoleczenstwa? */
      nx[0] = x + dxy[kierunek][0];
      ny[0] = y + dxy[kierunek][1];
      /* Zamkniecie z krawedziami */
      if (nx[0] < 1) nx[0] = 1;
      if (nx[0] > Bok) nx[0] = Bok;
      if (ny[0] < 1) ny[0] = 1;
      if (ny[0] > Bok) ny[0] = Bok;
      /* Mozna się przesunąc tylko na puste pole */
      return (TenSwiat[nx[0]][ny[0]].sila > 0);
    }
  
    int Decyzja(int poglad) { /* Zwraca 0 (koop) albo 1 (rywalizacja) */
       double prob;
       if (poglad == 0) {
         return 0;
       } else if (poglad == IlePostaw - 1) {
         return 1;
       } else { /* Niezdecydowany - a to juz trudna sprawa */
         prob = (double)poglad / (IlePostaw - 1);
         if (random(1) < prob) {
            return 1; /* Im poglad bliższy 0 tym trudniej wylosowac rywalizacje! */
         } else {
            return 0;
         }
       }
    }
  }

KoopHelper koopHelper = new KoopHelper();

NN = Bok * Bok;
for(k = 1; k <= NN; k++) {
    i = 1 + int(random(Bok));
    j = 1 + int(random(Bok));
    if (TenSwiat[i][j].sila > 0) {
      kierunek = int(random(8));
      if (koopHelper.SprobujPole(kierunek, i, j, nx, ny,TenSwiat)) {
         m = nx[0];
         n = ny[0];
         { /* Jakas interakcja jest mozliwa */
         p = koopHelper.Decyzja(TenSwiat[i][j].poglad);
         q = koopHelper.Decyzja(TenSwiat[m][n].poglad);
         if (p == q) { /* Zagrali to samo! */
           TenSwiat[i][j].sila = TenSwiat[i][j].sila + TabelaWyp[p][q];
           TenSwiat[m][n].sila = TenSwiat[m][n].sila + TabelaWyp[p][q];
         } else if (p == 1) { /* Pierwszy rywalizuje, to drugi jest frajer */
           TenSwiat[i][j].sila = TenSwiat[i][j].sila + TabelaWyp[0][1];
           TenSwiat[m][n].sila = TenSwiat[m][n].sila + TabelaWyp[1][0]; /* powinno byc ujemne */
         } else { /* p=0. Pierwszy jest frajer, to drugi rywalizuje */
           TenSwiat[i][j].sila = TenSwiat[i][j].sila + TabelaWyp[1][0]; /* powinno byc ujemne */
           TenSwiat[m][n].sila = TenSwiat[m][n].sila + TabelaWyp[0][1];
         }
         /* Cos sie zmienilo. Trzeba zadbac o ogolna spojnosc. */
         if (TenSwiat[i][j].sila <= 0) TenSwiat[i][j].sila = 1; /* Ostatni dech */
         if (TenSwiat[m][n].sila <= 0) TenSwiat[m][n].sila = 1; /* Ostatni dech */
         if (TenSwiat[i][j].sila > MaxSila) TenSwiat[i][j].sila = MaxSila; /* Nie za dużo */
         if (TenSwiat[m][n].sila > MaxSila) TenSwiat[m][n].sila = MaxSila; /* Nie za dużo */
         }
      }
    }
  }
  
}

void KrokSymulacji(Agent[][] TenSwiat) {
  /* Jeśli używamy wpływu społecznego */
  if (UzyjWplywuDlaPostaw) {
        OpcjonalnyWplywSpoleczny(TenSwiat);
  }
  /* Realizacja społecznego dylematu więźnia - zdobywanie zasobów */
  KooperujRywalizuj(TenSwiat);
  /* Wykonanie ewentualnych ruchów i aplikacja kosztów utrzymania i rozmnażanie */
  ZyjIUmieraj(TenSwiat);
}

void PoliczStatystyki(Agent[][] Tab, double[] StresRet, double[] SilaSredniaRet, double[] SilaMaxRet, int[] Wyznawcy) {
  int i,j,N;
  double SilaSrednia = 0;
  double SilaMax = 0;
  for(i = 0; i <= IlePostaw; i++) { Wyznawcy[i] = 0; }
  double StresGlobalny = 0;
  N = 0; /* Tak łatwiej */
  for(i = 1; i <= Bok; i++) {
    for(j = 1; j <= Bok; j++) {
      if (Tab[i][j].sila > 0) {
        N = N + 1;
        StresGlobalny = StresGlobalny + Tab[i][j].stres;
        Wyznawcy[Tab[i][j].poglad] = Wyznawcy[Tab[i][j].poglad] + 1;
        SilaSrednia = SilaSrednia + Tab[i][j].sila;
        if (SilaMax < Tab[i][j].sila) {
             SilaMax = Tab[i][j].sila;
        }
      }
    }
  }
  Wyznawcy[IlePostaw] = N;
  if (N > 0) {
     StresGlobalny = StresGlobalny / N;
     SilaSrednia = SilaSrednia / N;
  }
  StresRet[0] = StresGlobalny;
  SilaSredniaRet[0] = SilaSrednia;
  SilaMaxRet[0] = SilaMax;
}

void draw() {
  if(!isRunning) {
    println("Function draw is entered, however 'isRunning'==false!\nFirst time is expected and nothing wrong!");
    return; //Zabezpieczenie podwójne, bo przeciez jest noLoop() , ale Processing nawet gdy pętla wyłączona to raz na początku wchodzi do draw().
  }
  
  if (numerkroku <= MaxKrok) {             assert(SwiatSymulacji!=null); //<>//
    PoliczStresy(SwiatSymulacji);
    PoliczStatystyki(SwiatSymulacji, StresGlobalny_arr, SilaSrednia_arr, SilaMax_arr, Wyznawcy);
    double StresGlobalny = StresGlobalny_arr[0];
    double SilaSrednia = SilaSrednia_arr[0];
    double SilaMax = SilaMax_arr[0];
    
    if (numerkroku % CzestoscWizualizacji == 0) {
          Wizualizacja(SwiatSymulacji);
    }
    
    /* Wypisywanie */
    fill(255);
    noStroke();
    rect(Rozmiar, ileTrzeba, ileTrzeba-Rozmiar*2, SHEIGHT - (Bok + 1) * Rozmiar);
    stroke(0, 0, 0);
    fill(0, 0, 0);
    
    textSize(12); textAlign(LEFT,TOP);
    text(numerkroku + " *STRES: " + nf((float)StresGlobalny,0,7) + " *SIŁA: 0->mn:" + nf((float)SilaSrednia, 0, 3) + "->max:" + SilaMax + " *Żywych: " + Wyznawcy[IlePostaw] + " (deficyt: " + deficytzycia + ") ",
         Rozmiar,ileTrzeba);
    
    F.print(numerkroku + "\t" + StresGlobalny + "\t" + SilaSrednia + "\t" + SilaMax);
    for(int i = 0; i < IlePostaw; i++) {
      double q = Przeskaluj(i, 0, IlePostaw - 1) * 255;
      fill(0, (float)(255 - q), (float)q);
      text(" " + Wyznawcy[i] + " ", Rozmiar + i * 50, (Bok + 1) * Rozmiar + 35);
      F.print("\t" + Wyznawcy[i]);
    }
    F.println();
    F.flush();
    
    if (Chwila > 0) {
      delay(Chwila);
    }
    
    /* Kolejny krok */
    KrokSymulacji(SwiatSymulacji);
    numerkroku = numerkroku + 1;
  } else {
    F.println();
    F.flush();
    F.close();
    noLoop();
  }
}
