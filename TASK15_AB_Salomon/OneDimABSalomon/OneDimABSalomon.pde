// AB model of Sorin Solomon
// 1D version translated from Delphi
// The model keeps two values per cell:
// A = active/occupied state
// B = resource/wealth value

class ABCell {
  float a;   // state A
  float b;   // state B
}

final int WORLD_SIZE = 600;
final int MAX_STEP = 10000;

final int   A_START = 1;
final float A_STEP = 0.015;
final float A_THRESHOLD = 0.0001;
final float A_PROB = 0.000015;   // probability of spontaneous A creation

final int   B_START = 6;
final float B_STEP = 0.005;
final float AB_STEP = 0.66;

final int   VIS_FREQ = 15;

ABCell[] now;
ABCell[] next;
int totalA;

float logBase(float value, float base) {
  return log(value) / log(base);
}

float randomB(int n) {
  float result = 1.0;
  for (int i = 0; i < n; i++) {
    result *= random(1.0);
  }
  return result;
}

void initWorld(ABCell[] world) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    world[i] = new ABCell();
    world[i].b = randomB(B_START);
    world[i].a = 0;
  }

  for (int i = 0; i < A_START; i++) {
    int pos = floor(random(WORLD_SIZE));
    world[pos].a = 1;
  }
}

color colorFromB(float bValue) {
  float v = logBase(1.0 + bValue, 10.0);

  int r = int((v * 8.0) % 256);
  int g = int((v * 2.0) % 256);
  int blue = int((v * 64.0) % 256);

  return color(r, g, blue);
}

void drawScale(int x, int y, int widthPx, int heightPx, float maxB) {
  noStroke();fill(255);//,255,0);
  rect(x,y,widthPx+130,heightPx+25);
  y+=5;
  
  fill(0); textAlign(LEFT,CENTER);
  // Draw a simple scale on the right side
  text("Min=0", x + widthPx + 60, y);

  for (int i = 0; i <= heightPx; i++) {
    float value = 1.0 + (maxB / heightPx) * i;
    color curcol=colorFromB(value);
    stroke(curcol);
    line(x, y + i, x + widthPx, y + i);
    if (i % 16 == 0) {
      fill(curcol);
      text(" --  " + value /*nf(value, 4, 2)*/, x + widthPx + 10, y + i);
    }
  }

  text("Max=" + maxB /*nf(maxB, 4, 2)*/, x + widthPx, y + heightPx + 12);
}

void drawWorld(int y, ABCell[] world) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    if (world[i].a > 0) {
      stroke(255);
    } else {
      stroke(colorFromB(world[i].b));
    }
    point(i, y);
  }
  //println(y);
}

void changeB(ABCell[] current, ABCell[] nextWorld) {
  nextWorld[0].b = (current[0].b + current[1].b) / 2.0 * (1.0 - B_STEP);

  for (int i = 1; i < WORLD_SIZE - 1; i++) {
    nextWorld[i].b = (current[i - 1].b + current[i].b + current[i + 1].b) / 3.0 * (1.0 - B_STEP);
  }

  nextWorld[WORLD_SIZE - 1].b =
    (current[WORLD_SIZE - 2].b + current[WORLD_SIZE - 1].b) / 2.0 * (1.0 - B_STEP);
}

void changeA(ABCell[] current, ABCell[] nextWorld) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    if (current[i].a > A_THRESHOLD) {
      nextWorld[i].a = current[i].a * (1.0 - A_STEP);
    } else {
      nextWorld[i].a = 0;
    }

    if (random(1.0) <= A_PROB) {
      nextWorld[i].a = 1;
      totalA++;
    }
  }
}

void produceBbyA(ABCell[] world) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    if (world[i].a > A_THRESHOLD) {
      world[i].b = world[i].b + world[i].b * world[i].a * AB_STEP;
    }
  }
}

void copyWorld(ABCell[] target, ABCell[] source) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    target[i].a = source[i].a;
    target[i].b = source[i].b;
  }
}

float findMaxB(ABCell[] world) {
  float maxValue = 0.0;
  for (int i = 0; i < WORLD_SIZE; i++) {
    if (world[i].b > maxValue) {
      maxValue = world[i].b;
    }
  }
  return maxValue;
}

void settings() {
  size(WORLD_SIZE + 180, MAX_STEP / VIS_FREQ + 50);
  noSmooth();
}

void setup() {
  background(255);
  frameRate(300);
  //noLoop();

  now = new ABCell[WORLD_SIZE];
  next = new ABCell[WORLD_SIZE];

  for (int i = 0; i < WORLD_SIZE; i++) {
    now[i] = new ABCell();
    next[i] = new ABCell();
  }

  totalA = A_START;
  initWorld(now);

  drawWorld(0, now);
}

int     step = 1;
float maxAll =-1;

void draw() {
  if (step <= MAX_STEP) {
    produceBbyA(now);

    changeB(now, next);
    changeA(now, next);

    copyWorld(now, next);

    if (step % VIS_FREQ == 0) {
      int y=step / VIS_FREQ;
      //stroke(255,step%256,0);line(0,y,width,y);
      drawWorld(y, now);
    }

    step++;
  }
  else
  {
    int y=(step / VIS_FREQ)+1;
    stroke(255,0,255);line(0,y,width,y);
    drawWorld(y, now);
  }

  float maxB = findMaxB(now);
  
  if(maxB>maxAll)
        maxAll=maxB;

  // Print summary
  fill(255);noStroke();
  rect(0,height-40,width,height);
  fill(0);
  text("Number of A = " + totalA + "   Current MaxB = " + maxB, 10, height - 10);
  drawScale(WORLD_SIZE + 10, 0, 20, WORLD_SIZE, maxAll);
}
