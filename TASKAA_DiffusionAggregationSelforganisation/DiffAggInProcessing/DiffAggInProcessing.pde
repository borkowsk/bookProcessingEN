// Program CA_2D_agregacja; 
/* Program CA symulacja dyfuzji z agregacją */ 
/* Przełożony z Delphi za pomoca Gemini */

final int Last = 100;  /* Rozmiar tablicy - Musi byc większe niż 1 i najwyzej 160 */ 
final int Bok = 5;     /* Rozmiar komórki */ 
final float Prob0 = 0.800;    /* Prawdopodobienstwo 0 w inicjalizacjilosowej */ 

final String IniFile = "";    /* "2DCA_dane.txt"; */    /* Nazwa pliku z danymi */ 

int[][] Swiat = new int[Last + 1][Last + 1]; 
/* Globalna zmienna reprezentująca Świat */ 
int krok; 

/* RÓŻNE FUNKCJE INICJUJĄCE DO ROZSĄDNEGO WYBORU */ 

void setup() {
  size(510, 510);
  frameRate(30);
  noStroke();

  println("          Automat komórkowy \"Dyfuzja i agregacja\" o " + Last + "x" + Last + " komórkach");

  /* Wariantowa inicjalizacja przestrzeni symulacji */ 
  if (IniFile.equals("")) { 
    LosujCały(); 
    Swiat[Last / 2][Last / 2] = 2; 
    /*
    LosujCzęść(1, Last, 1, Last / 2); 
    ZerujCzęść(1, Last, Last / 2 + 1, Last); 
    Przesłona(Last / 2 + 1); 
    */     
  } else { 
    ZerujCałe(); 
    WczytajPlik(IniFile); 
  } 
  
  Wypisz(); 
  krok = 0; 
}

void draw() {
  /* Właściwa pętla symulacji */
  ZróbKrokMonteCarlo(); 
  krok = krok + 1; 
  Wypisz(); 
  print("\r"+nf(krok, 3) + ")     "); 
}

void ZerujCałe() { 
/* Wyzerowanie "Swiat"a */ 
  for (int i = 1; i <= Last; i++) 
    for (int j = 1; j <= Last; j++) 
      Swiat[i][j] = 0; 
} 

void ZerujCzęść(int xp, int xk, int yp, int yk) { 
/* Wyzerowanie kawałka "Swiat"a */ 
  for (int i = xp; i <= xk; i++) 
    for (int j = yp; j <= yk; j++) 
      Swiat[i][j] = 0; 
} 

void LosujCały() { 
/* Wylosowanie cząstek "Swiat"a */ 
  for (int i = 1; i <= Last; i++) 
    for (int j = 1; j <= Last; j++) 
      if (random(1.0) < Prob0) 
        Swiat[i][j] = 0; 
      else 
        Swiat[i][j] = 1; 
} 

void LosujCzęść(int xp, int xk, int yp, int yk) { 
/* Losowanie cząstek w prostokącie */ 
  for (int i = xp; i <= xk; i++) 
    for (int j = yp; j <= yk; j++) 
      if (random(1.0) < Prob0) 
        Swiat[i][j] = 0; 
      else 
        Swiat[i][j] = 1; 
} 

void Przesłona(int pozycja) { 
/* Rysuje przesłone na 2/3 szerokości Świata */ 
  for (int i = 1; i <= Last / 3; i++) { 
    Swiat[i][pozycja] = 2; 
    Swiat[Last - i][pozycja] = 2; 
  } 
} 

int minVal(int a, int b) { 
/* Matematyczne minimum z dwu liczb całkowitych */ 
  if (a > b) 
    return b; 
  else 
    return a; 
} 

int maxVal(int a, int b) { 
/* Matematyczne maximum z dwu liczb całkowitych */ 
  if (a < b) 
    return b; 
  else 
    return a; 
} 

void WczytajPlik(String nazwa) { 
/* Wczytuje plik z danymi. * oznaczają 1, X=2, reszta 0 */ 
  String[] linie = loadStrings(nazwa);
  if (linie == null) return;

  int j = 1; 
  for (String bufor : linie) {
    if (j > Last) break;
    int len = minVal(bufor.length(), Last);
    for (int i = 1; i <= len; i++) { 
      char c = bufor.charAt(i - 1);
      if (c == '*') 
        Swiat[i][j] = 1; 
      else if (c == 'X' || c == 'x') 
        Swiat[i][j] = 2; 
      else 
        Swiat[i][j] = 0; 
    } 
    j++; 
  } 
} 

void PatrzObok(int xo, int yo, int[] result) { 
/* Losuje sąsiednią komórkę, dbając o to, żeby nie wyjść za tablice */ 
/* Niezbyt optymalne, ale skuteczne */ 
  int x = xo + int(random(3)) - 1; 
  int y = yo + int(random(3)) - 1; 
  if (x < 1) x = 1; 
  if (x > Last) x = Last; 
  if (y < 1) y = 1; 
  if (y > Last) y = Last; 
  result[0] = x;
  result[1] = y;
} 

boolean MaSasiada2(int xo, int yo) { 
/* Sprawdzenie czy jest w sąsiedztwie Moora jakaś 2-ka */
  boolean flaga = false; 
  for (int i = maxVal(1, xo - 1); i <= minVal(xo + 1, Last); i++) 
    for (int j = maxVal(1, yo - 1); j <= minVal(yo + 1, Last); j++) 
      if (Swiat[i][j] == 2) 
        flaga = true; 
  return flaga; 
} 

void ZróbKrokMonteCarlo() { 
/* Własciwy krok modelu */ 
  int[] newPos = new int[2];
  for (int k = 1; k <= Last * Last; k++) { 
    int xo = int(random(Last)) + 1; 
    int yo = int(random(Last)) + 1; 
    if (Swiat[xo][yo] == 1) {
      if (MaSasiada2(xo, yo)) { 
        Swiat[xo][yo] = 2; 
      } else { 
        PatrzObok(xo, yo, newPos); 
        int xn = newPos[0];
        int yn = newPos[1];
        if (Swiat[xn][yn] == 0) { 
          Swiat[xn][yn] = Swiat[xo][yo]; 
          Swiat[xo][yo] = 0; 
        } 
      } 
    }
  } 
} 

void Wypisz() { 
  for (int i = 1; i <= Last; i++) {
    for (int j = 1; j <= Last; j++) { 
      if (Swiat[i][j] == 0) 
        fill(0, 0, 0); 
      else if (Swiat[i][j] == 1) 
        fill(255, 0, 0); 
      else 
        fill(0, 0, 255); 
      rect(i * Bok, j * Bok, Bok, Bok); 
    } 
  }
}

void exit() {
  println();
  println("Dziękuje i polecam się na przyszłość");
  super.exit();
}
