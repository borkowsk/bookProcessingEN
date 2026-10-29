/// @file
/// @brief Ant sorting
/// @details
/// The implementation in ALGO was authored by Magda Roszczyńska (who did not yet 
/// hold a PhD at the time). Then it was ported into Delphi, and then into Processing.
/// Model definition:
///  - When a termite is not carrying anything, it moves around and checks whether 
///    there is a piece of wood in front of or next to it.
///  - If it finds one, it picks it up with a certain probability and continues on its way.
///  - If a termite is carrying something, it checks whether there is a similar 
///    piece of wood in front of or next to it.
///  - If it finds one, it drops the piece of wood with a certain probability.
///
/// TRANSLATED FROM A Delphi APPLICATION TO Processing USING GEMINI.


int N_termits = 10;
int Last = 65;
int N_items = 4; /* How many types of items/"wood types"? */

double Density = 0.2; /* the probability of a small piece of wood lying in a given location */
double Change_prob = 0.2; /* probability of a change in the direction of movement */
double w = 0.95; /* probability of leaving/taking an item */

int Width = 10;
int Frame_rate=1000; /* How many frames per second would we want? */
int Vis_frequency = 5; /* Every how many simulation steps should I draw? */

class termit {
  int x;
  int y;
  int k; /* direction of movement */
  int c; /* What does a termite carry on its back? */
}

class direction {
  int x;
  int y;
}

int[][]     world = new int[Last + 1][Last + 1];
termit[]    mound = new termit[N_termits + 1];        ///< termite mound or anthill
direction[] transitions_table = new direction[4];

int step = 0;

void settings() {
  size(Last * Width + Width + 5, Last * Width + 80);
}

void setup() {
  frameRate(Frame_rate);
  
  for (int i = 0; i < 4; i++) {
    transitions_table[i] = new direction();
  }
  for (int i = 1; i <= N_termits; i++) {
    mound[i] = new termit();
  }

  step = 0;
  init(world, mound);
}

int color_in_r(int n) {
  if (n > 0) {
   return round(n * 255.0 / N_items);
  } else {
   return 255;
  }
}

int color_in_g(int n) {
  if (n > 0) {
   return 255 - round(n * 255.0 / N_items);
  } else {
   return 255;
  }
}

int color_in_b(int n) {
  if (n > 0) {
   return 255;
  } else {
   return 255;
  }
}

void drawing(int[][] world_arg, termit[] mound_arg) {
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
     if (mound_arg[world_arg[i][j]].c > 0) {
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
     fill(color_in_r(-world_arg[i][j]), color_in_g(-world_arg[i][j]), color_in_b(-world_arg[i][j]));
    } else {
     stroke(0, 0, 0);
     fill(color_in_r(mound_arg[world_arg[i][j]].c), color_in_g(mound_arg[world_arg[i][j]].c), color_in_b(mound_arg[world_arg[i][j]].c));
    }
    rect(Width * i, Width * j, Width, Width);
   }
 }

 fill(255, 255, 255);
 stroke(255, 255, 255);
 rect(10, Last * Width + 10, width - 20, 50); /* Clearing the text panel */

 fill(0);
 textSize(12);
 text("Number of termites: " + m, 10, Last * Width + 25);
 text("Number of items: " + k, 10, Last * Width + 45);
}

void init(int[][] world_arg, termit[] mound_arg) {
 int i, j, x, y;
 transitions_table[0].x = 0;
 transitions_table[0].y = -1;
 transitions_table[1].x = 1;
 transitions_table[1].y = 0;
 transitions_table[2].x = 0;
 transitions_table[2].y = 1;
 transitions_table[3].x = -1;
 transitions_table[3].y = 0;

 for (i = 0; i <= Last; i++) {
  for (j = 0; j <= Last; j++) {
   if (random(1) < Density) {
    world_arg[i][j] = (int(random(N_items)) + 1) * (-1);
   } else {
    world_arg[i][j] = 0;
   }
  }
 }

 for (i = 1; i <= N_termits; i++) {
  do {
    x = int(random(Last + 1));
    y = int(random(Last + 1));
   } while (world_arg[x][y] != 0);
   world_arg[x][y] = i;
   mound_arg[i].x = x;
   mound_arg[i].y = y;
   mound_arg[i].c = 0;
   mound_arg[i].k = int(random(4));
  }

 drawing(world_arg, mound_arg);
}

void step(int[][] world_arg, termit[] mound_arg) {
 int k_idx, i, g, h, l, t;
 for (k_idx = 1; k_idx <= N_termits; k_idx++) {
   i = int(random(N_termits)) + 1;
   g = -((world_arg[(mound_arg[i].x + transitions_table[mound_arg[i].k].x + Last + 1) % (Last + 1)][(mound_arg[i].y + transitions_table[mound_arg[i].k].y + Last + 1) % (Last + 1)]));
   h = -(world_arg[(mound_arg[i].x + transitions_table[((mound_arg[i].k + 1) % 4)].x + Last + 1) % (Last + 1)][(mound_arg[i].y + transitions_table[((mound_arg[i].k + 1) % 4)].y + Last + 1) % (Last + 1)]);
   l = -(world_arg[(mound_arg[i].x + transitions_table[((mound_arg[i].k + 3) % 4)].x + Last + 1) % (Last + 1)][(mound_arg[i].y + transitions_table[((mound_arg[i].k + 3) % 4)].y + Last + 1) % (Last + 1)]);
   t = -(world_arg[(mound_arg[i].x + transitions_table[((mound_arg[i].k + 2) % 4)].x + Last + 1) % (Last + 1)][(mound_arg[i].y + transitions_table[((mound_arg[i].k + 2) % 4)].y + Last + 1) % (Last + 1)]);

   if (mound_arg[i].c == 0) {
       if ((g > 0) && (h <= 0) && (l <= 0)) {
        if (random(1) < w) {
          world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
          mound_arg[i].x = (mound_arg[i].x + transitions_table[mound_arg[i].k].x + Last + 1) % (Last + 1);
          mound_arg[i].y = (mound_arg[i].y + transitions_table[mound_arg[i].k].y + Last + 1) % (Last + 1);
          mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
          world_arg[mound_arg[i].x][mound_arg[i].y] = i;
         } else {
          if (random(1) < 0.5) {
           mound_arg[i].k = (mound_arg[i].k + 1) % 4;
          } else {
           mound_arg[i].k = (mound_arg[i].k + 3) % 4;
          }
         }
       } else if ((g <= 0) && (h > 0) && (l <= 0)) {
         if (random(1) < w) {
           world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
           mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 1) % 4].x + Last + 1) % (Last + 1);
           mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 1) % 4].y + Last + 1) % (Last + 1);
           mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
           mound_arg[i].k = (mound_arg[i].k + 1) % 4;
           world_arg[mound_arg[i].x][mound_arg[i].y] = i;
          } else {
          if (random(1) < 0.5) {
           mound_arg[i].k = (mound_arg[i].k + 1) % 4;
          } else {
           mound_arg[i].k = (mound_arg[i].k + 3) % 4;
          }
         }
        } else if ((g <= 0) && (h <= 0) && (l > 0)) {
          if (random(1) < w) {
            world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
            mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 3) % 4].x + Last + 1) % (Last + 1);
            mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 3) % 4].y + Last + 1) % (Last + 1);
            mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
            mound_arg[i].k = (mound_arg[i].k + 3) % 4;
            world_arg[mound_arg[i].x][mound_arg[i].y] = i;
           } else {
           if (random(1) < 0.5) {
            mound_arg[i].k = (mound_arg[i].k + 1) % 4;
           } else {
            mound_arg[i].k = (mound_arg[i].k + 3) % 4;
           }
          }
         } else if ((g > 0) && (h > 0) && (l <= 0)) {
           if (random(1) < w) {
            if (random(1) < 0.5) {
              world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
              mound_arg[i].x = (mound_arg[i].x + transitions_table[mound_arg[i].k].x + Last + 1) % (Last + 1);
              mound_arg[i].y = (mound_arg[i].y + transitions_table[mound_arg[i].k].y + Last + 1) % (Last + 1);
              mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
              world_arg[mound_arg[i].x][mound_arg[i].y] = i;
             } else {
              world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
              mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 1) % 4].x + Last + 1) % (Last + 1);
              mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 1) % 4].y + Last + 1) % (Last + 1);
              mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
              mound_arg[i].k = (mound_arg[i].k + 1) % 4;
              world_arg[mound_arg[i].x][mound_arg[i].y] = i;
             }
           } else {
            if (random(1) < 0.5) {
             mound_arg[i].k = (mound_arg[i].k + 1) % 4;
            } else {
             mound_arg[i].k = (mound_arg[i].k + 3) % 4;
            }
           }
          } else if ((g > 0) && (h <= 0) && (l > 0)) {
            if (random(1) < w) {
             if (random(1) < 0.5) {
              world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
              mound_arg[i].x = (mound_arg[i].x + transitions_table[mound_arg[i].k].x + Last + 1) % (Last + 1);
              mound_arg[i].y = (mound_arg[i].y + transitions_table[mound_arg[i].k].y + Last + 1) % (Last + 1);
              mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
              world_arg[mound_arg[i].x][mound_arg[i].y] = i;
             } else {
              world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
              mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 3) % 4].x + Last + 1) % (Last + 1);
              mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 3) % 4].y + Last + 1) % (Last + 1);
              mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
              mound_arg[i].k = (mound_arg[i].k + 3) % 4;
              world_arg[mound_arg[i].x][mound_arg[i].y] = i;
             }
            } else {
             if (random(1) < 0.5) {
              mound_arg[i].k = (mound_arg[i].k + 1) % 4;
             } else {
              mound_arg[i].k = (mound_arg[i].k + 3) % 4;
             }
            }
           } else if ((g <= 0) && (h > 0) && (l > 0)) {
             if (random(1) < w) {
              if (random(1) < 0.5) {
                world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
                mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 1) % 4].x + Last + 1) % (Last + 1);
                mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 1) % 4].y + Last + 1) % (Last + 1);
                mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
                mound_arg[i].k = (mound_arg[i].k + 1) % 4;
                world_arg[mound_arg[i].x][mound_arg[i].y] = i;
               } else {
                world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
                mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 3) % 4].x + Last + 1) % (Last + 1);
                mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 3) % 4].y + Last + 1) % (Last + 1);
                mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
                mound_arg[i].k = (mound_arg[i].k + 3) % 4;
                world_arg[mound_arg[i].x][mound_arg[i].y] = i;
               }
              } else {
              if (random(1) < 0.5) {
               mound_arg[i].k = (mound_arg[i].k + 1) % 4;
              } else {
               mound_arg[i].k = (mound_arg[i].k + 3) % 4;
              }
             }
            } else if ((g > 0) && (h > 0) && (l > 0)) {
              if (random(1) < w) {
               if (random(1) < 0.33) {
                  world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
                  mound_arg[i].x = (mound_arg[i].x + transitions_table[mound_arg[i].k].x + Last + 1) % (Last + 1);
                  mound_arg[i].y = (mound_arg[i].y + transitions_table[mound_arg[i].k].y + Last + 1) % (Last + 1);
                  mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
                  world_arg[mound_arg[i].x][mound_arg[i].y] = i;
                 } else if (random(1) > 0.66) {
                   world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
                   mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 3) % 4].x + Last + 1) % (Last + 1);
                   mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 3) % 4].y + Last + 1) % (Last + 1);
                   mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
                   mound_arg[i].k = (mound_arg[i].k + 3) % 4;
                   world_arg[mound_arg[i].x][mound_arg[i].y] = i;
                  } else {
                   world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
                   mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 1) % 4].x + Last + 1) % (Last + 1);
                   mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 1) % 4].y + Last + 1) % (Last + 1);
                   mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
                   mound_arg[i].k = (mound_arg[i].k + 1) % 4;
                   world_arg[mound_arg[i].x][mound_arg[i].y] = i;
                  }
               } else {
               if (random(1) < 0.5) {
                mound_arg[i].k = (mound_arg[i].k + 1) % 4;
               } else {
                mound_arg[i].k = (mound_arg[i].k + 3) % 4;
               }
              }
             } else if ((g == 0) && (h <= 0) && (l <= 0)) {
               world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
               mound_arg[i].x = (mound_arg[i].x + transitions_table[mound_arg[i].k].x + Last + 1) % (Last + 1);
               mound_arg[i].y = (mound_arg[i].y + transitions_table[mound_arg[i].k].y + Last + 1) % (Last + 1);
               world_arg[mound_arg[i].x][mound_arg[i].y] = i;
               if (random(1) < Change_prob) {
                 if (random(1) < 0.5) {
                  mound_arg[i].k = ((mound_arg[i].k + 1) % 4);
                 } else {
                  mound_arg[i].k = ((mound_arg[i].k + 3) % 4);
                 }
               }
              } else {
               if (random(1) < 0.5) {
                mound_arg[i].k = (mound_arg[i].k + 1) % 4;
               } else {
                mound_arg[i].k = (mound_arg[i].k + 3) % 4;
               }
              }
    } else {
     if ((g == mound_arg[i].c) || (h == mound_arg[i].c) || (l == mound_arg[i].c)) {
      if (random(1) < w) {
         if (t < 0) {
          if (random(1) < 0.5) {
           mound_arg[i].k = (mound_arg[i].k + 1) % 4;
          } else {
           mound_arg[i].k = (mound_arg[i].k + 3) % 4;
          }
         } else {
           world_arg[mound_arg[i].x][mound_arg[i].y] = -mound_arg[i].c;
           mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 2) % 4].x + Last + 1) % (Last + 1);
           mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 2) % 4].y + Last + 1) % (Last + 1);
           mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
           mound_arg[i].k = (mound_arg[i].k + 2) % 4;
           world_arg[mound_arg[i].x][mound_arg[i].y] = i;
          }
       } else {
       if (random(1) < 0.5) {
        mound_arg[i].k = (mound_arg[i].k + 1) % 4;
       } else {
        mound_arg[i].k = (mound_arg[i].k + 3) % 4;
       }
      }
     } else if ((g == 0) && (h != mound_arg[i].c) && (l != mound_arg[i].c)) {
       if (random(1) > w) {
        world_arg[mound_arg[i].x][mound_arg[i].y] = -mound_arg[i].c;
        mound_arg[i].x = (mound_arg[i].x + transitions_table[mound_arg[i].k].x + Last + 1) % (Last + 1);
        mound_arg[i].y = (mound_arg[i].y + transitions_table[mound_arg[i].k].y + Last + 1) % (Last + 1);
        mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
        world_arg[mound_arg[i].x][mound_arg[i].y] = i;
        } else {
         world_arg[mound_arg[i].x][mound_arg[i].y] = 0;
         mound_arg[i].x = (mound_arg[i].x + transitions_table[mound_arg[i].k].x + Last + 1) % (Last + 1);
         mound_arg[i].y = (mound_arg[i].y + transitions_table[mound_arg[i].k].y + Last + 1) % (Last + 1);
         world_arg[mound_arg[i].x][mound_arg[i].y] = i;
        }
      } else if (g < 0) {
        if (t < 0) {
         if (random(1) < 0.5) {
          mound_arg[i].k = (mound_arg[i].k + 1) % 4;
         } else {
          mound_arg[i].k = (mound_arg[i].k + 3) % 4;
         }
        } else {
         if (random(1) > w) {
           world_arg[mound_arg[i].x][mound_arg[i].y] = -mound_arg[i].c;
           mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 2) % 4].x + Last + 1) % (Last + 1);
           mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 2) % 4].y + Last + 1) % (Last + 1);
           mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
           mound_arg[i].k = (mound_arg[i].k + 2) % 4;
           world_arg[mound_arg[i].x][mound_arg[i].y] = i;
          } else {
          if (random(1) < 0.5) {
           mound_arg[i].k = (mound_arg[i].k + 1) % 4;
          } else {
           mound_arg[i].k = (mound_arg[i].k + 3) % 4;
          }
         }
        }
       } else if (t >= 0) {
         if (random(1) > w) {
           world_arg[mound_arg[i].x][mound_arg[i].y] = -mound_arg[i].c;
           mound_arg[i].x = (mound_arg[i].x + transitions_table[(mound_arg[i].k + 2) % 4].x + Last + 1) % (Last + 1);
           mound_arg[i].y = (mound_arg[i].y + transitions_table[(mound_arg[i].k + 2) % 4].y + Last + 1) % (Last + 1);
           mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
           mound_arg[i].k = (mound_arg[i].k + 2) % 4;
           world_arg[mound_arg[i].x][mound_arg[i].y] = i;
          } else {
          if (random(1) < 0.5) {
           mound_arg[i].k = ((mound_arg[i].k + 1) % 4);
          } else {
           mound_arg[i].k = ((mound_arg[i].k + 3) % 4);
          }
         }
        } else {
         if (random(1) < w) {
          if (random(1) < 0.5) {
           mound_arg[i].k = (mound_arg[i].k + 1) % 4;
          } else {
           mound_arg[i].k = (mound_arg[i].k + 3) % 4;
          }
         } else {
           world_arg[mound_arg[i].x][mound_arg[i].y] = -mound_arg[i].c;
           mound_arg[i].x = (mound_arg[i].x + transitions_table[mound_arg[i].k].x + Last + 1) % (Last + 1);
           mound_arg[i].y = (mound_arg[i].y + transitions_table[mound_arg[i].k].y + Last + 1) % (Last + 1);
           mound_arg[i].c = -world_arg[mound_arg[i].x][mound_arg[i].y];
           world_arg[mound_arg[i].x][mound_arg[i].y] = i;
          }
     }
   }
 }
}

void draw() {
  if (step % Vis_frequency == 0) {
    drawing(world, mound);
    fill(255);
    stroke(255);
    rect(10, Last * Width + 60, 150, 15);
    fill(0);
    textSize(12);
    text("Step: " + step, 10, Last * Width + 70);
  }

  step(world, mound);
  step = step + 1;
}





/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
