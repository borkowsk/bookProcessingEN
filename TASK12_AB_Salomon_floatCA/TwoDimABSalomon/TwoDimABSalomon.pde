// AB model of Sorin Solomon
// 2D version translated from Delphi
// The model keeps two values per cell:
// A = active/occupied state
// B = resource/wealth value

class ABCell {
  float a;   // state A
  float b;   // state B
}

final int WORLD_SIZE = 300;
final int MAX_STEP = 10000;

final int A_START = 5;
final float A_STEP = 0.05;
final float A_PROB = 0.0000035;   // probability of spontaneous A creation

final int B_START = 6;
final float B_STEP = 0.01;
final float AB_STEP = 6.0;
final int VIS_FREQ = 10;

ABCell[][] now;
ABCell[][] next;

int currentStep = 0;
boolean simulationRunning = true;

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

void initWorld(ABCell[][] world) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    for (int j = 0; j < WORLD_SIZE; j++) {
      world[i][j] = new ABCell();
      world[i][j].b = randomB(B_START);
      world[i][j].a = 0;
    }
  }

  for (int i = 0; i < A_START; i++) {
    int posX = floor(random(WORLD_SIZE));
    int posY = floor(random(WORLD_SIZE));
    world[posX][posY].a = 1;
  }
}

color colorFromA(float aValue) {
  return color(int((aValue * 255.0) % 256),
               int((aValue * 255.0) % 256),
               int((aValue * 255.0) % 256));
}

color colorFromB(float bValue) {
  float v = logBase(1.0 + bValue, 10.0);
  
  int r = int((v * 8.0) % 256);
  int g = int((v * 2.0) % 256);
  int b = int((v * 64.0) % 256);
  
  return color(r, g, b);
}

void drawWorld(int offsetX, int offsetY, ABCell[][] world) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    for (int j = 0; j < WORLD_SIZE; j++) {
      if (world[i][j].a > 0.1) {
        stroke(colorFromA(world[i][j].a));
      } else {
        stroke(colorFromB(world[i][j].b));
      }
      point(offsetX + i, offsetY + j);
    }
  }
}

void produceBbyA(ABCell[][] world) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    for (int j = 0; j < WORLD_SIZE; j++) {
      world[i][j].b = world[i][j].b + world[i][j].b * world[i][j].a * AB_STEP;
    }
  }
}

void changeB(ABCell[][] current, ABCell[][] nextWorld) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    for (int j = 0; j < WORLD_SIZE; j++) {
      // Get neighborhood bounds (with wrapping or clamping)
      int a = (i > 0) ? i - 1 : i;
      int b = (i < WORLD_SIZE - 1) ? i + 1 : i;
      int p = (j > 0) ? j - 1 : j;
      int q = (j < WORLD_SIZE - 1) ? j + 1 : j;

      float sum = 0;
      int count = 0;

      for (int k = a; k <= b; k++) {
        for (int l = p; l <= q; l++) {
          sum += current[k][l].b;
          count++;
        }
      }

      nextWorld[i][j].b = (sum / count) * (1.0 - B_STEP);
    }
  }
}

void changeA(ABCell[][] current, ABCell[][] nextWorld) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    for (int j = 0; j < WORLD_SIZE; j++) {
      if (random(1.0) > A_PROB) {
        nextWorld[i][j].a = current[i][j].a * (1.0 - A_STEP);
      } else {
        if (current[i][j].a > 0) {
          nextWorld[i][j].a = 0;
        } else {
          nextWorld[i][j].a = 1;
        }
      }
    }
  }
}

void copyWorld(ABCell[][] target, ABCell[][] source) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    for (int j = 0; j < WORLD_SIZE; j++) {
      target[i][j].a = source[i][j].a;
      target[i][j].b = source[i][j].b;
    }
  }
}

void settings() {
  size(WORLD_SIZE + 8, WORLD_SIZE + 50);
  noSmooth();
}

void setup() {
  background(255);
  frameRate(30);  // Control animation speed

  now = new ABCell[WORLD_SIZE][WORLD_SIZE];
  next = new ABCell[WORLD_SIZE][WORLD_SIZE];

  for (int i = 0; i < WORLD_SIZE; i++) {
    for (int j = 0; j < WORLD_SIZE; j++) {
      now[i][j] = new ABCell();
      next[i][j] = new ABCell();
    }
  }

  initWorld(now);
  drawWorld(4, 4, now);
}

void draw() {
  if (!simulationRunning || currentStep >= MAX_STEP) {
    return;
  }

  currentStep++;

  produceBbyA(now);
  changeB(now, next);
  changeA(now, next);
  copyWorld(now, next);

  if (currentStep % VIS_FREQ == 0) {
    background(255);
    drawWorld(4, 4, now);

    // Display step counter
    fill(0);
    textSize(12);
    text("Step: " + currentStep + " / " + MAX_STEP, 10, height - 5);
  }

  // Stop simulation when done
  if (currentStep >= MAX_STEP) {
    simulationRunning = false;
    println("Simulation finished at step " + currentStep);
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    currentStep = 0;
    simulationRunning = true;
    background(255);
    initWorld(now);
    drawWorld(1, 1, now);
  } else if (key == 'p' || key == 'P') {
    simulationRunning = !simulationRunning;
  }
}
