/* Magda Roszczyńska - 
Gdy termit nie ma nic na plecach, idzie, sprawdza czy przed nim lub obok niego jest drewienko. 
Jeżeli jest to z pewnym prawdopodobieństwem go bierze i idzie dalej.
Jeżeli termit ma coś na plecach sprawdza, czy przed nim, lub obok niego jest podobne drewienko.
Jeżeli jest to z pewnym prawdopodobieństwem zrzuca drewienko */

/* PRZETŁUMACZONE Z APLIKACJI Delphi NA Processing ZA POMOCĄ GEMINI */

int wizual = 5; /* Co ile kroków rysować? */
int n_termity = 10;
int Last = 65;
int czas = 0;
int szerokosc = 10;
int n_przedmiotow = 2; /* Ile typów przedmiotów */
double gestosc = 0.2;
double skret = 0.2;
double w = 0.9; /* prawdopodobienstwo zostawienia/wzięcia przedmiotu */

class termit {
  int x;
  int y;
  int k; /* kierunek ruchu */
  int c; /* co nosi termit */
}

class lok {
  int x;
  int y;
}

int[][] world = new int[Last + 1][Last + 1];
termit[] kopiec = new termit[n_termity + 1];
lok[] tablica_przejscia = new lok[4];

int step = 0;

void settings() {
  size(Last * szerokosc + szerokosc + 5, Last * szerokosc + 80);
}

void setup() {
  for (int i = 0; i < 4; i++) {
    tablica_przejscia[i] = new lok();
  }
  for (int i = 1; i <= n_termity; i++) {
    kopiec[i] = new termit();
  }

  step = 0;
  init(world, kopiec);
}

int koloruj_r(int n) {
  if (n > 0) {
   return round(n * 255.0 / n_przedmiotow);
  } else {
   return 255;
  }
}

int koloruj_g(int n) {
  if (n > 0) {
   return 255 - round(n * 255.0 / n_przedmiotow);
  } else {
   return 255;
  }
}

int koloruj_b(int n) {
  if (n > 0) {
   return 255;
  } else {
   return 255;
  }
}

void rysowanie(int[][] world_arg, termit[] kopiec_arg) {
int i, j, m, k;
 m = 0;
 k = 0;
 for (i = 0; i <= Last; i++) {
  for (j = 0; j <= Last; j++) {
   if (world_arg[i][j] < 0) {
    k = k + 1;
   } else {
    if (world_arg[i][j] > 0) {
     m = m + 1;
     if (kopiec_arg[world_arg[i][j]].c > 0) {
      k = k + 1;
     }
    }
   }
  }
 }

 for (i = 0; i <= Last; i++) {
  for (j = 0; j <= Last; j++) {
    if (world_arg[i][j] <= 0) {
     stroke(255, 255, 255);
     fill(koloruj_r(-world_arg[i][j]), koloruj_g(-world_arg[i][j]), koloruj_b(-world_arg[i][j]));
    } else {
     stroke(0, 0, 0);
     fill(koloruj_r(kopiec_arg[world_arg[i][j]].c), koloruj_g(kopiec_arg[world_arg[i][j]].c), koloruj_b(kopiec_arg[world_arg[i][j]].c));
    }
    rect(szerokosc * i, szerokosc * j, szerokosc, szerokosc);
   }
 }

 fill(255, 255, 255);
 stroke(255, 255, 255);
 rect(10, Last * szerokosc + 10, width - 20, 50); /* Czyszczenie panelu tekstowego */

 fill(0);
 textSize(12);
 text("Liczba termitów: " + m, 10, Last * szerokosc + 25);
 text("Liczba drewienek: " + k, 10, Last * szerokosc + 45);
}

void init(int[][] world_arg, termit[] kopiec_arg) {
int i, j, x, y;
 tablica_przejscia[0].x = 0;
 tablica_przejscia[0].y = -1;
 tablica_przejscia[1].x = 1;
 tablica_przejscia[1].y = 0;
 tablica_przejscia[2].x = 0;
 tablica_przejscia[2].y = 1;
 tablica_przejscia[3].x = -1;
 tablica_przejscia[3].y = 0;

 for (i = 0; i <= Last; i++) {
  for (j = 0; j <= Last; j++) {
   if (random(1) < gestosc) {
    world_arg[i][j] = (int(random(n_przedmiotow)) + 1) * (-1);
   } else {
    world_arg[i][j] = 0;
   }
  }
 }

 for (i = 1; i <= n_termity; i++) {
  do {
    x = int(random(Last + 1));
    y = int(random(Last + 1));
   } while (world_arg[x][y] != 0);
   world_arg[x][y] = i;
   kopiec_arg[i].x = x;
   kopiec_arg[i].y = y;
   kopiec_arg[i].c = 0;
   kopiec_arg[i].k = int(random(4));
  }

rysowanie(world_arg, kopiec_arg);
}

void krok(int[][] world_arg, termit[] kopiec_arg) {
int k_idx, i, g, h, l, t;
 for (k_idx = 1; k_idx <= n_termity; k_idx++) {
   i = int(random(n_termity)) + 1;
   g = -((world_arg[(kopiec_arg[i].x + tablica_przejscia[kopiec_arg[i].k].x + Last + 1) % (Last + 1)][(kopiec_arg[i].y + tablica_przejscia[kopiec_arg[i].k].y + Last + 1) % (Last + 1)]));
   h = -(world_arg[(kopiec_arg[i].x + tablica_przejscia[((kopiec_arg[i].k + 1) % 4)].x + Last + 1) % (Last + 1)][(kopiec_arg[i].y + tablica_przejscia[((kopiec_arg[i].k + 1) % 4)].y + Last + 1) % (Last + 1)]);
   l = -(world_arg[(kopiec_arg[i].x + tablica_przejscia[((kopiec_arg[i].k + 3) % 4)].x + Last + 1) % (Last + 1)][(kopiec_arg[i].y + tablica_przejscia[((kopiec_arg[i].k + 3) % 4)].y + Last + 1) % (Last + 1)]);
   t = -(world_arg[(kopiec_arg[i].x + tablica_przejscia[((kopiec_arg[i].k + 2) % 4)].x + Last + 1) % (Last + 1)][(kopiec_arg[i].y + tablica_przejscia[((kopiec_arg[i].k + 2) % 4)].y + Last + 1) % (Last + 1)]);

   if (kopiec_arg[i].c == 0) {
       if ((g > 0) && (h <= 0) && (l <= 0)) {
        if (random(1) < w) {
          world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
          kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[kopiec_arg[i].k].x + Last + 1) % (Last + 1);
          kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[kopiec_arg[i].k].y + Last + 1) % (Last + 1);
          kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
          world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
         } else {
          if (random(1) < 0.5) {
           kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
          } else {
           kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
          }
         }
       } else if ((g <= 0) && (h > 0) && (l <= 0)) {
         if (random(1) < w) {
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
           kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 1) % 4].x + Last + 1) % (Last + 1);
           kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 1) % 4].y + Last + 1) % (Last + 1);
           kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
           kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
          } else {
          if (random(1) < 0.5) {
           kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
          } else {
           kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
          }
         }
        } else if ((g <= 0) && (h <= 0) && (l > 0)) {
          if (random(1) < w) {
            world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
            kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 3) % 4].x + Last + 1) % (Last + 1);
            kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 3) % 4].y + Last + 1) % (Last + 1);
            kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
            kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
            world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
           } else {
           if (random(1) < 0.5) {
            kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
           } else {
            kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
           }
          }
         } else if ((g > 0) && (h > 0) && (l <= 0)) {
           if (random(1) < w) {
            if (random(1) < 0.5) {
              world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
              kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[kopiec_arg[i].k].x + Last + 1) % (Last + 1);
              kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[kopiec_arg[i].k].y + Last + 1) % (Last + 1);
              kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
              world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
             } else {
              world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
              kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 1) % 4].x + Last + 1) % (Last + 1);
              kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 1) % 4].y + Last + 1) % (Last + 1);
              kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
              kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
              world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
             }
           } else {
            if (random(1) < 0.5) {
             kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
            } else {
             kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
            }
           }
          } else if ((g > 0) && (h <= 0) && (l > 0)) {
            if (random(1) < w) {
             if (random(1) < 0.5) {
              world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
              kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[kopiec_arg[i].k].x + Last + 1) % (Last + 1);
              kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[kopiec_arg[i].k].y + Last + 1) % (Last + 1);
              kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
              world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
             } else {
              world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
              kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 3) % 4].x + Last + 1) % (Last + 1);
              kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 3) % 4].y + Last + 1) % (Last + 1);
              kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
              kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
              world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
             }
            } else {
             if (random(1) < 0.5) {
              kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
             } else {
              kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
             }
            }
           } else if ((g <= 0) && (h > 0) && (l > 0)) {
             if (random(1) < w) {
              if (random(1) < 0.5) {
                world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
                kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 1) % 4].x + Last + 1) % (Last + 1);
                kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 1) % 4].y + Last + 1) % (Last + 1);
                kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
                kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
                world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
               } else {
                world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
                kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 3) % 4].x + Last + 1) % (Last + 1);
                kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 3) % 4].y + Last + 1) % (Last + 1);
                kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
                kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
                world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
               }
              } else {
              if (random(1) < 0.5) {
               kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
              } else {
               kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
              }
             }
            } else if ((g > 0) && (h > 0) && (l > 0)) {
              if (random(1) < w) {
               if (random(1) < 0.33) {
                  world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
                  kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[kopiec_arg[i].k].x + Last + 1) % (Last + 1);
                  kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[kopiec_arg[i].k].y + Last + 1) % (Last + 1);
                  kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
                  world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
                 } else if (random(1) > 0.66) {
                   world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
                   kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 3) % 4].x + Last + 1) % (Last + 1);
                   kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 3) % 4].y + Last + 1) % (Last + 1);
                   kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
                   kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
                   world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
                  } else {
                   world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
                   kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 1) % 4].x + Last + 1) % (Last + 1);
                   kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 1) % 4].y + Last + 1) % (Last + 1);
                   kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
                   kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
                   world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
                  }
               } else {
               if (random(1) < 0.5) {
                kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
               } else {
                kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
               }
              }
             } else if ((g == 0) && (h <= 0) && (l <= 0)) {
               world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
               kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[kopiec_arg[i].k].x + Last + 1) % (Last + 1);
               kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[kopiec_arg[i].k].y + Last + 1) % (Last + 1);
               world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
               if (random(1) < skret) {
                 if (random(1) < 0.5) {
                  kopiec_arg[i].k = ((kopiec_arg[i].k + 1) % 4);
                 } else {
                  kopiec_arg[i].k = ((kopiec_arg[i].k + 3) % 4);
                 }
               }
              } else {
               if (random(1) < 0.5) {
                kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
               } else {
                kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
               }
              }
    } else {
     if ((g == kopiec_arg[i].c) || (h == kopiec_arg[i].c) || (l == kopiec_arg[i].c)) {
      if (random(1) < w) {
         if (t < 0) {
          if (random(1) < 0.5) {
           kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
          } else {
           kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
          }
         } else {
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = -kopiec_arg[i].c;
           kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 2) % 4].x + Last + 1) % (Last + 1);
           kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 2) % 4].y + Last + 1) % (Last + 1);
           kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
           kopiec_arg[i].k = (kopiec_arg[i].k + 2) % 4;
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
          }
       } else {
       if (random(1) < 0.5) {
        kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
       } else {
        kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
       }
      }
     } else if ((g == 0) && (h != kopiec_arg[i].c) && (l != kopiec_arg[i].c)) {
       if (random(1) > w) {
        world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = -kopiec_arg[i].c;
        kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[kopiec_arg[i].k].x + Last + 1) % (Last + 1);
        kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[kopiec_arg[i].k].y + Last + 1) % (Last + 1);
        kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
        world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
        } else {
         world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = 0;
         kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[kopiec_arg[i].k].x + Last + 1) % (Last + 1);
         kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[kopiec_arg[i].k].y + Last + 1) % (Last + 1);
         world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
        }
      } else if (g < 0) {
        if (t < 0) {
         if (random(1) < 0.5) {
          kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
         } else {
          kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
         }
        } else {
         if (random(1) > w) {
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = -kopiec_arg[i].c;
           kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 2) % 4].x + Last + 1) % (Last + 1);
           kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 2) % 4].y + Last + 1) % (Last + 1);
           kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
           kopiec_arg[i].k = (kopiec_arg[i].k + 2) % 4;
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
          } else {
          if (random(1) < 0.5) {
           kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
          } else {
           kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
          }
         }
        }
       } else if (t >= 0) {
         if (random(1) > w) {
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = -kopiec_arg[i].c;
           kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[(kopiec_arg[i].k + 2) % 4].x + Last + 1) % (Last + 1);
           kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[(kopiec_arg[i].k + 2) % 4].y + Last + 1) % (Last + 1);
           kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
           kopiec_arg[i].k = (kopiec_arg[i].k + 2) % 4;
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
          } else {
          if (random(1) < 0.5) {
           kopiec_arg[i].k = ((kopiec_arg[i].k + 1) % 4);
          } else {
           kopiec_arg[i].k = ((kopiec_arg[i].k + 3) % 4);
          }
         }
        } else {
         if (random(1) < w) {
          if (random(1) < 0.5) {
           kopiec_arg[i].k = (kopiec_arg[i].k + 1) % 4;
          } else {
           kopiec_arg[i].k = (kopiec_arg[i].k + 3) % 4;
          }
         } else {
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = -kopiec_arg[i].c;
           kopiec_arg[i].x = (kopiec_arg[i].x + tablica_przejscia[kopiec_arg[i].k].x + Last + 1) % (Last + 1);
           kopiec_arg[i].y = (kopiec_arg[i].y + tablica_przejscia[kopiec_arg[i].k].y + Last + 1) % (Last + 1);
           kopiec_arg[i].c = -world_arg[kopiec_arg[i].x][kopiec_arg[i].y];
           world_arg[kopiec_arg[i].x][kopiec_arg[i].y] = i;
          }
     }
  }
 }
}

void draw() {
  if (step % wizual == 0) {
    rysowanie(world, kopiec);
    fill(255);
    stroke(255);
    rect(10, Last * szerokosc + 60, 150, 15);
    fill(0);
    textSize(12);
    text("Krok: " + step, 10, Last * szerokosc + 70);
  }

  krok(world, kopiec);
  step = step + 1;
}
