// Wolfram's 1D Binary Cellular Automaton
// Translated from Pascal to Processing by Copilot
// Supports 256 rules, with statistics and visualization

// ===== CONFIGURATION =====
final String 
    CA_CODE_BIN = "01101110"; // Rule code in binary
//  CA_CODE_BIN = '00011110'; // 30 - Brzydki efekt brzegowy po stronie lewej} 
//  CA_CODE_BIN = '00110011'; // 51 - Odwracanie bitów
//  CA_CODE_BIN = '01011010'; // 90
//  CA_CODE_BIN = '01101110'; // 110  
//  CA_CODE_BIN = '01111110'; // 126
//  CA_CODE_BIN = '10000001'; // 129
//  CA_CODE_BIN = '10110010'; // 178
//  CA_CODE_BIN = '11101000'; // 232
//  CA_CODE_BIN = '11111010'; // 250
//  CA_CODE_BIN = '11111110'; // 254 
final int WORLD_SIZE = 500;
final int MAX_STEPS = 800;
final float PROB_ZERO_INIT = 0.995;   // Probability of initializing with zero
final boolean MONTE_CARLO = false;    // false=synchronous, true=Monte-Carlo
final boolean TORUS = true;           // false=boundaries, true=toroidal wrapping
final boolean VISUALIZE = true;
final int FIRST_Y = 40;               // First line for visualization

// ===== INTERNAL =====
final String TEMPLATE = "111 110 101 100 011 010 001 000";  // Do not change
int caCode;
int[] world;
int[] nextWorld;
boolean[] rules = new boolean[8];
ArrayList<String> statsLog;

void setup() {
  size(520, 900);
  noSmooth();
  background(255);

  world = new int[WORLD_SIZE];
  nextWorld = new int[WORLD_SIZE];
  statsLog = new ArrayList<String>();

  makeRules();
  initRandom();

  if (VISUALIZE) {
    drawRules();
  }

  String header = "Step\tStress\t#0\t#1\tCluster0\tCluster1";
  statsLog.add(header);

  println(header);

  // Main loop
  for (int step = 0; step <= MAX_STEPS; step++) {
    if (VISUALIZE && step < height - FIRST_Y - 10) {
      drawWorld(FIRST_Y + 10 + step);
    }

    computeStatistics(step);

    // Update automaton
    if (MONTE_CARLO) {
      if (TORUS) {
        stepMonteCarlo_Torus();
      } else {
        stepMonteCarlo();
      }
    } else {
      if (TORUS) {
        stepSynchronous_Torus();
      } else {
        stepSynchronous();
      }
    }
  }

  println("Finished " + MAX_STEPS + " steps");
  noLoop();
}

// ===== RULE INITIALIZATION =====
void makeRules() {
  // Parse binary CA code into rules array
  rules[0] = (CA_CODE_BIN.charAt(7) == '1');
  rules[1] = (CA_CODE_BIN.charAt(6) == '1');
  rules[2] = (CA_CODE_BIN.charAt(5) == '1');
  rules[3] = (CA_CODE_BIN.charAt(4) == '1');
  rules[4] = (CA_CODE_BIN.charAt(3) == '1');
  rules[5] = (CA_CODE_BIN.charAt(2) == '1');
  rules[6] = (CA_CODE_BIN.charAt(1) == '1');
  rules[7] = (CA_CODE_BIN.charAt(0) == '1');

  // Convert to decimal code
  caCode = 0;
  if (rules[0]) caCode += 1;
  if (rules[1]) caCode += 2;
  if (rules[2]) caCode += 4;
  if (rules[3]) caCode += 8;
  if (rules[4]) caCode += 16;
  if (rules[5]) caCode += 32;
  if (rules[6]) caCode += 64;
  if (rules[7]) caCode += 128;
}

// ===== INITIALIZATION =====
void initZero() {
  for (int i = 0; i < WORLD_SIZE; i++) {
    world[i] = 0;
  }
}

void initRandom() {
  for (int i = 0; i < WORLD_SIZE; i++) {
    if (random(1.0) < PROB_ZERO_INIT) {
      world[i] = 0;
    } else {
      world[i] = 1;
    }
  }

  // If no 1's were generated, add one in the middle
  if (countState(1) == 0) {
    initZero();
    world[WORLD_SIZE / 2] = 1;
  }
}

// ===== VISUALIZATION =====
void drawRules() {
  // Draw the rule template (top row) and actual rules (bottom row)
  fill(0);
  textAlign(RIGHT);
  text("Rule " + caCode + " (" + CA_CODE_BIN + ")", width, 25);

  int x = 20;
  int y = 5;

  // Draw template patterns
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 3; j++) {
      if (TEMPLATE.charAt(i * 4 + j) == '1') {
        fill(255, 0, 0);
      } else {
        fill(0);
      }
      rect(x, y, 9, 9);
      x += 10;
    }
    x += 10;
  }

  x = 20;
  y = 20;

  // Draw actual rule results
  for (int j = 7; j >= 0; j--) {
    if (rules[j]) {
      fill(255, 0, 0);
    } else {
      fill(0);
    }
    rect(x, y, 9, 9);
    x += 40;
  }
}

void drawWorld(int lineY) {
  for (int i = 0; i < WORLD_SIZE; i++) {
    if (world[i] == 1) {
      stroke(255, 0, 0);
    } else {
      stroke(0, 0, 0);
    }
    point(i, lineY);
  }
}

// ===== STATISTICS =====
float computeStress() {
  // Count boundaries between different states
  int count = 0;
  for (int j = 0; j < WORLD_SIZE; j++) {
    int left = (j > 0) ? j - 1 : (TORUS ? WORLD_SIZE - 1 : j);
    int right = (j < WORLD_SIZE - 1) ? j + 1 : (TORUS ? 0 : j);

    if (world[left] != world[j]) count++;
    if (world[right] != world[j]) count++;
  }

  return (float)count / WORLD_SIZE;
}

int countState(int state) {
  int count = 0;
  for (int i = 0; i < WORLD_SIZE; i++) {
    if (world[i] == state) count++;
  }
  return count;
}

float computeClustering(int state) {
  // Fraction of cells of given state that have neighbors of same state
  int matching = 0;
  int total = 0;

  for (int j = 0; j < WORLD_SIZE; j++) {
    if (world[j] == state) {
      total++;
      int left = (j > 0) ? j - 1 : (TORUS ? WORLD_SIZE - 1 : j);
      int right = (j < WORLD_SIZE - 1) ? j + 1 : (TORUS ? 0 : j);

      if (world[left] == world[j]) matching++;
      if (world[right] == world[j]) matching++;
    }
  }

  if (total == 0) return 0;
  return (float)matching / total;
}

void computeStatistics(int step) {
  float stress = computeStress();
  int count0 = countState(0);
  int count1 = countState(1);
  float cluster0 = computeClustering(0);
  float cluster1 = computeClustering(1);

  String line = step + "\t" + nf(stress, 1, 3) + "\t" + count0 + "\t" + count1 +
                "\t" + nf(cluster0, 1, 3) + "\t" + nf(cluster1, 1, 3);
  statsLog.add(line);
  println(line);
}

// ===== AUTOMATON STEPS =====
void stepSynchronous() {
  for (int i = 0; i < WORLD_SIZE; i++) {
    int left = (i > 0) ? world[i - 1] : 0;
    int center = world[i];
    int right = (i < WORLD_SIZE - 1) ? world[i + 1] : 0;

    int index = left * 4 + center * 2 + right;
    nextWorld[i] = rules[index] ? 1 : 0;
  }

  for (int i = 0; i < WORLD_SIZE; i++) {
    world[i] = nextWorld[i];
  }
}

void stepSynchronous_Torus() {
  for (int i = 0; i < WORLD_SIZE; i++) {
    int left = (i > 0) ? world[i - 1] : world[WORLD_SIZE - 1];
    int center = world[i];
    int right = (i < WORLD_SIZE - 1) ? world[i + 1] : world[0];

    int index = left * 4 + center * 2 + right;
    nextWorld[i] = rules[index] ? 1 : 0;
  }

  for (int i = 0; i < WORLD_SIZE; i++) {
    world[i] = nextWorld[i];
  }
}

void stepMonteCarlo() {
  for (int monte = 0; monte < WORLD_SIZE; monte++) {
    int i = floor(random(WORLD_SIZE));

    int left = (i > 0) ? world[i - 1] : 0;
    int center = world[i];
    int right = (i < WORLD_SIZE - 1) ? world[i + 1] : 0;

    int index = left * 4 + center * 2 + right;
    world[i] = rules[index] ? 1 : 0;
  }
}

void stepMonteCarlo_Torus() {
  for (int monte = 0; monte < WORLD_SIZE; monte++) {
    int i = floor(random(WORLD_SIZE));

    int left = (i > 0) ? world[i - 1] : world[WORLD_SIZE - 1];
    int center = world[i];
    int right = (i < WORLD_SIZE - 1) ? world[i + 1] : world[0];

    int index = left * 4 + center * 2 + right;
    world[i] = rules[index] ? 1 : 0;
  }
}

//void draw() {
  // Nothing — everything runs in setup()
//}

// ===== UTILITY =====
String getFilename() {
  return "CA_" + caCode + "x" + MAX_STEPS +
         (TORUS ? "T" : "") +
         (MONTE_CARLO ? "M" : "") +
         ".csv";
}
