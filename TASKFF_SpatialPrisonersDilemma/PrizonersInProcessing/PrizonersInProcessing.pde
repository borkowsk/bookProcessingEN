// Social Prisoner's Dilemma model with reproduction and optional mutations,
// And optionally using Nowak/Latané model for attitude change
//-/////////////////////////////////////////////////////////////////////////

class Agent {
    int  attitude=0;  /* 0..attitudesCount-1 */
    int  strength=0;  /* If 0 then dead */
    float stress=0;   /* Economic stress value */
}

int MAX_SIDE_LENGTH = 500;
// If initialized to "false", it starts with the form. If true, it starts immediately.
boolean isRunning=false;

int MAX_ATTITUDES_COUNT = 21;
int LastHist = 100;
int HistSize = 9;

float MIN_NOISE_LEVEL = 0;
float MAX_NOISE_LEVEL = 0.15;
float MIN_POPULATION_DENSITY = 0;
float MAX_POPULATION_DENSITY = 1;

/* General model parameters - when cooperation payoffs are small, social influence becomes decisive! */
float populationDensity = 0.5; /* Density 0..1 */
int   sideLength = 50;         /* World side length */
int   attitudesCount = 2;      /* Number of possible attitudes 2--> */
int   maxStrength = 10000;     /* Maximum strength */
int   paretoExponent = 7;      /* Degree of "Pareto" distribution >=0 - zero gives flat distribution, only maxStrength. Max: 12 */

/* Specific model parameters */
int     stepCost = 5;
int     optimumReserve = 50;
int[][] payoffMatrix = {{6, 12}, {-12, -6}}; //< PRISONER'S DILEMMA PAYOFF TABLE.

boolean useSocialInfluence = false;
boolean useCrowdingStress = false;
double  noiseLevel = 0; /* Noise, i.e., random attitude "mutations" */

String FileNameCore = "priz"; /* e.g., file name core */
PrintWriter logFile = null;

/* Visualization parameters */
int agentCellSize = 15;     /* Side length of the strongest agent */
int minAgentRenderSize = 2; /* Visual size for the weakest agents in the population */
int borderSize = 0;         /* Border around agent */

int visualizationFreq = 1; /* How many Monte Carlo steps between redraws */
int stepDelayMs = 10;      /* Delay in milliseconds for visualization */
int maxSteps = 10000;      /* Maximum steps in experiment */

/* Mandatory visualization parameters. Prefix S stands for SCREEN */
int SWIDTH = 780;    /* Main window workspace width */
int SHEIGHT = 800;   /* Main window workspace height */

Agent[][] simulationWorld;

int currentStep = 0;
int birthDeficit = 0;

/* Direction array to facilitate movement and interaction */
int[][] dxy = {{0,1},{0,-1},{1,0},{-1,0},{-1,-1},{1,1},{-1,1},{1,-1}};

PrintWriter F;
String N_filename;

double[] globalStressArr = new double[1];
double[] meanStrengthArr = new double[1];
double[] maxStrengthArr = new double[1];
int[] attitudeCounts;

int requiredWindowSize=500; //< Required width or height for world visualization alone.
void settings() {
  requiredWindowSize=(sideLength+2)*(agentCellSize+borderSize); /* Calculate required window size */
  size(requiredWindowSize, requiredWindowSize+80); /* create window */
}

void setup() {
  if(!isRunning)
  {
    createGUI(); // Form creation. Model will start upon clicking OK.
    noLoop();
  }
  else
  {
    runSimulation();
    loop();
  }
}

// Function launching the model after form confirmation
void runSimulation() {                                                  assert(MAX_SIDE_LENGTH>1);
  simulationWorld = new Agent[MAX_SIDE_LENGTH + 1][MAX_SIDE_LENGTH + 1];
  
  for(int i = 0; i <= MAX_SIDE_LENGTH; i++) {
    for(int j = 0; j <= MAX_SIDE_LENGTH; j++) {
      simulationWorld[i][j] = new Agent();
    }
  }
  attitudeCounts = new int[MAX_ATTITUDES_COUNT + 1];

  initializeWorld(simulationWorld);
  currentStep = 0;
  birthDeficit = 0;
  
  N_filename = FileNameCore
      + sideLength + "x" + sideLength  /* World side length */
      + "P" + attitudesCount           /* Number of competing attitudes 2..10 */
      + "G" + populationDensity        /* Population density 0..1 */
      + "M" + noiseLevel               /* Noise, i.e., random attitude "mutations" */
      + "m" + maxStrength              /* Max strength - must be large enough for distribution min:1, max: 1 000 000 */
      + "k" + stepCost
      + "op" + optimumReserve
      + "W(" + payoffMatrix[0][0] + ")(" + payoffMatrix[1][1] + ")(" + payoffMatrix[0][1] + ")"
      + (useSocialInfluence ? "INFL" : "no.infl")
      + "-"
      + (useCrowdingStress ? "CROWD.STR" : "crowd")
      + ".log";
  
  println("Log file is '"+N_filename+"'");    
      
  F = createWriter(N_filename);
  F.println(N_filename);
  F.println("Step\tStress\tMeanEnergy\tMaxEnergy\tAttitude counts");
}

// Populating the world. Dead agents have strength = 0
void initializeWorld(Agent[][] currentWorld) {

   int i,j,k;
   float aux; 
  for(i = 1; i <= sideLength; i++) {
    for(j = 1; j <= sideLength; j++) {
      if (random(1) < populationDensity) {
        /* Alive */ 
        currentWorld[i][j].attitude = int(random(attitudesCount));
        aux = 1; 
        for(k = 1; k <= paretoExponent; k++) {
          aux = aux * random(1); 
        }
        currentWorld[i][j].strength = 1 + int(aux * (maxStrength - 1));
        currentWorld[i][j].stress = 0; /* Not stressed yet... */
      } else {
        /* Dead */
        currentWorld[i][j].attitude = attitudesCount;
        currentWorld[i][j].stress = 0; /* Not stressed... */
        currentWorld[i][j].strength = 0; /* 0 means DEAD! */
      }
    }
  }
}

/* Helpers for visualization */
double rescale(double v, double min, double max) { 
  return (v - min) / (max - min); 
}

double applyLogScale(double v, double max) { 
  v = Math.log(v + 1); 
  return v / Math.log(max + 1); 
}

// Squares with size proportional to the logarithm of strength
void drawWorld(Agent[][] currentWorld) { 

  int    i,j;         /* Iterating over agents */
  double q,r,s,rRoz;  /* Recalculated agent properties */
  int    WRoz,ri,vi;  /* Internal size and positioning */

  rRoz = 1.0 - (double)minAgentRenderSize / agentCellSize;
  WRoz = agentCellSize - borderSize; /* Ignores border width */
  
  for(i = 1; i <= sideLength; i++) {
    for(j = 1; j <= sideLength; j++) {
      stroke(100, 100, 100);
      fill(128, 128, 128);
      rect(i * agentCellSize, j * agentCellSize, agentCellSize, agentCellSize);
      if (currentWorld[i][j].strength > 0) {
        q = rescale(currentWorld[i][j].attitude, 0, attitudesCount - 1) * 255;
        r = applyLogScale(currentWorld[i][j].strength, maxStrength) * rRoz;
        s = rescale(currentWorld[i][j].stress, 0, 1) * 255;
        ri = minAgentRenderSize + round((float)(r * (WRoz - minAgentRenderSize))); 
        vi = (agentCellSize - ri) / 2;
        stroke((float)s, 0, 0);
        fill(0, (float)(255 - q), (float)q);
        rect(i * agentCellSize + vi, j * agentCellSize + vi, ri, ri);
      } 
    }
  }
}

// Procedure for updating agent attitudes. Includes helper inner class.
void applySocialInfluence(Agent[][] currentWorld) {

  class InnerHelper {
    
    void countInfluences(int x, int y, int[] counts, Agent[][] currentWorld) {
    /* Internal procedure for counting influences */
      int left,right,top,bottom,i,j;
      left = x - 1;   if (left < 1) left = 1;
      right = x + 1;  if (right > sideLength)  right = sideLength;
      top = y - 1;    if (top < 1) top = 1;
      bottom = y + 1; if (bottom > sideLength) bottom = sideLength;
  
      for(i = left; i <= right; i++) {
        for(j = top; j <= bottom; j++) {
          if (currentWorld[i][j].strength > 0) {
            counts[currentWorld[i][j].attitude] = counts[currentWorld[i][j].attitude] + currentWorld[i][j].strength;/* !!! */
          }
        }
      }
    }
  
    int determineAttitude(int[] counts) { 
    /* Internal function for finding the maximum influence count */ 
      int max,newAttitude,i,j;
      max = 0;
      newAttitude = -1;
      j = int(random(attitudesCount));/* To avoid implicit bias */
      for(i = 0; i < attitudesCount; i++) { /* Loop ensures full array traversal */
        if (counts[j] > max) {
          max = counts[j];
          newAttitude = j;
        }
        j = (j + 1) % attitudesCount; /* Traverses entire array starting from random index */
      }
      return newAttitude;
    }
  }

  int i,j,k,l,N;
  int[] counts = new int[MAX_ATTITUDES_COUNT + 1];
  InnerHelper helper = new InnerHelper();

  N = sideLength * sideLength;
  for(k = 1; k <= N; k++) {
    for(l = 0; l <= attitudesCount; l++) {
      counts[l] = 0;
    }
    i = 1 + int(random(sideLength));
    j = 1 + int(random(sideLength));
    if (currentWorld[i][j].strength > 0) { /* Handles living agents */
      if (random(1) < noiseLevel) {
        currentWorld[i][j].attitude = int(random(attitudesCount));
      } else {
        helper.countInfluences(i, j, counts, currentWorld);
        currentWorld[i][j].attitude = helper.determineAttitude(counts);
      }
    }
  }
}

// Calculates current economic stress levels for all agents
void calculateStressLevels(Agent[][] tab) {

  int i,j;
  float reserveRatio;

  class StresHelper {
    
    int countNeighbors(int x, int y, Agent[][] tab) {
    /* Internal procedure for counting neighbors */
      int left,right,top,bottom,i,j,neighborCount;
      left = x - 1;   if (left < 1) left = 1;
      right = x + 1;  if (right > sideLength)  right = sideLength;
      top = y - 1;    if (top < 1) top = 1;
      bottom = y + 1; if (bottom > sideLength) bottom = sideLength;
      neighborCount = 0;
      for(i = left; i <= right; i++) {
        for(j = top; j <= bottom; j++) {
          if (tab[i][j].strength > 0) {
            neighborCount++;
          }
        }
      }
      return neighborCount;
    }
    
  }

 StresHelper helper = new StresHelper();

 for(i = 1; i <= sideLength; i++) { //<>//
    for(j = 1; j <= sideLength; j++) {
      if (tab[i][j].strength > 0) {
        /* Days of reserves available */
        reserveRatio = tab[i][j].strength / stepCost;
        /* Fraction of required reserve value */
        reserveRatio = reserveRatio / optimumReserve;
        /* Store for MC step */
        if (reserveRatio < 1) {
          tab[i][j].stress = 1 - reserveRatio;
        } else {
          tab[i][j].stress = 0;
        }
        /* Stressed if crowding is disliked and space is tight */
        if (useCrowdingStress &&
          (tab[i][j].stress < 0.9) &&
          (helper.countNeighbors(i, j, tab) > 7)) {
            tab[i][j].stress = tab[i][j].stress + 0.1;
        }
      }
    }
  }
}

// Metabolism, reproduction, and movement procedure
void updateMetabolismAndMovement(Agent[][] currentWorld) {

  class ZyjHelper {
    boolean tryMove(int direction, int x, int y, int[] nx, int[] ny, Agent[][] currentWorld) {
    /* Is the target cell suitable for movement? */
      nx[0] = x + dxy[direction][0];
      ny[0] = y + dxy[direction][1];
      /* Edge clamping */
      if (nx[0] < 1) nx[0] = 1;
      if (nx[0] > sideLength) nx[0] = sideLength;
      if (ny[0] < 1) ny[0] = 1;
      if (ny[0] > sideLength) ny[0] = sideLength;
      /* Can move to empty cells only */
      return (currentWorld[nx[0]][ny[0]].strength == 0);
    }
  
    void moveAgent(int x, int y, int nx, int ny, Agent[][] currentWorld) {
    /* Moves agent to designated destination */
      currentWorld[nx][ny].attitude = currentWorld[x][y].attitude;
      currentWorld[nx][ny].strength = currentWorld[x][y].strength;
      currentWorld[nx][ny].stress = currentWorld[x][y].stress;
      /* Clearing previous cell */
      currentWorld[x][y].strength = 0;
      currentWorld[x][y].stress = 0;
      currentWorld[x][y].attitude = attitudesCount;
    }
  
    void spawnNewAgent(Agent[][] currentWorld) {
    /* Creates a new agent as a clone of a random one */
       int direction,i,j,m,n,NN;
       int[] nx = new int[1];
       int[] ny = new int[1];
       NN = sideLength * sideLength * 3; /* Safety limit against infinite loops */
       while(true) { /* Until a valid pair of cells is found */
        i = 1 + int(random(sideLength));
        j = 1 + int(random(sideLength));
        direction = int(random(8));
        NN--;
        if (NN == 0) {
            birthDeficit++;
            return; /* Procedure failed to spawn */
        }
        if ((currentWorld[i][j].strength > stepCost * 2) && (tryMove(direction, i, j, nx, ny, currentWorld))) {
           m = nx[0];
           n = ny[0];
           currentWorld[i][j].strength = currentWorld[i][j].strength / 2; /* Energy split */
           currentWorld[i][j].stress = 0; /* Temporarily zero stress to prevent immediate escape */
           
           currentWorld[m][n].attitude = currentWorld[i][j].attitude;
           currentWorld[m][n].strength = currentWorld[i][j].strength;
           currentWorld[m][n].stress = currentWorld[i][j].stress;
  
           if ((noiseLevel > 0) && (random(1) < noiseLevel)) { /* OPTIONAL MUTATION */
                currentWorld[m][n].attitude = int(random(attitudesCount));
           }
           break;
        }
       }
    }
  }

 if(!isRunning) //<>//
 { 
   println("Not configured yet!");
   return; //<>//
 }

 ZyjHelper zyjHelper = new ZyjHelper();
 int direction,i,j,k,NN;
 int[] nx = new int[1];
 int[] ny = new int[1];
 
 if(birthDeficit != 0) { /* Extra attempt to spawn an agent */
  birthDeficit--;
  zyjHelper.spawnNewAgent(currentWorld);
 }
 
 NN = sideLength * sideLength;
 for(k = 1; k <= NN; k++) {
    i = 1 + int(random(sideLength));
    j = 1 + int(random(sideLength));
    if (currentWorld[i][j].attitude != attitudesCount) {
             if (currentWorld[i][j].strength <= 0) {
                      println("ALGORITHM INCONSISTENCY: Agents with strength <= 0 possess an attitude!!");
             }
    }
    if (currentWorld[i][j].strength > 0) {
        /* Check if still alive */
        currentWorld[i][j].strength = currentWorld[i][j].strength - stepCost;
        if (currentWorld[i][j].strength <= 0) {
          /* Death and decay */
          currentWorld[i][j].strength = 0;
          currentWorld[i][j].stress = 0;
          currentWorld[i][j].attitude = attitudesCount;
          /* And new life... */
          zyjHelper.spawnNewAgent(currentWorld);
        } else { /* Attempts movement if stressed */
          if (random(1) < currentWorld[i][j].stress) {
           direction = int(random(8));
           if (zyjHelper.tryMove(direction, i, j, nx, ny, currentWorld)) {
              zyjHelper.moveAgent(i, j, nx[0], ny[0], currentWorld);
           }
          }
        }
    }
 }
}

void interactCooperateDefect(Agent[][] currentWorld) {
  int direction,i,j,k,m,n,NN,p,q;
  int[] nx = new int[1];
  int[] ny = new int[1];

  class KoopHelper {
    boolean isValidNeighborCell(int direction, int x, int y, int[] nx, int[] ny, Agent[][] currentWorld) {
    /* Does the cell contain a community member? */
      nx[0] = x + dxy[direction][0];
      ny[0] = y + dxy[direction][1];
      /* Edge clamping */
      if (nx[0] < 1) nx[0] = 1;
      if (nx[0] > sideLength) nx[0] = sideLength;
      if (ny[0] < 1) ny[0] = 1;
      if (ny[0] > sideLength) ny[0] = sideLength;
      /* Can move to empty cells only */
      return (currentWorld[nx[0]][ny[0]].strength > 0);
    }
  
    int getDecision(int attitude) { /* Returns 0 (cooperate) or 1 (defect) */
       double prob;
       if (attitude == 0) {
         return 0;
       } else if (attitude == attitudesCount - 1) {
         return 1;
       } else { /* Undecided */
         prob = (double)attitude / (attitudesCount - 1);
         if (random(1) < prob) {
            return 1; /* The closer the attitude is to 0, the harder it is to defect! */
         } else {
            return 0;
         }
       }
    }
  }

KoopHelper koopHelper = new KoopHelper();

NN = sideLength * sideLength;
for(k = 1; k <= NN; k++) {
    i = 1 + int(random(sideLength));
    j = 1 + int(random(sideLength));
    if (currentWorld[i][j].strength > 0) {
      direction = int(random(8));
      if (koopHelper.isValidNeighborCell(direction, i, j, nx, ny, currentWorld)) {
         m = nx[0];
         n = ny[0];
         { /* Interaction is possible */
         p = koopHelper.getDecision(currentWorld[i][j].attitude);
         q = koopHelper.getDecision(currentWorld[m][n].attitude);
         if (p == q) { /* Played the same move! */
           currentWorld[i][j].strength = currentWorld[i][j].strength + payoffMatrix[p][q];
           currentWorld[m][n].strength = currentWorld[m][n].strength + payoffMatrix[p][q];
         } else if (p == 1) { /* First defects, second loses */
           currentWorld[i][j].strength = currentWorld[i][j].strength + payoffMatrix[0][1];
           currentWorld[m][n].strength = currentWorld[m][n].strength + payoffMatrix[1][0]; /* Should be negative */
         } else { /* p=0. First loses, second defects */
           currentWorld[i][j].strength = currentWorld[i][j].strength + payoffMatrix[1][0]; /* Should be negative */
           currentWorld[m][n].strength = currentWorld[m][n].strength + payoffMatrix[0][1];
         }
         /* Consistency enforcement after state changes */
         if (currentWorld[i][j].strength <= 0) currentWorld[i][j].strength = 1; /* Last breath */
         if (currentWorld[m][n].strength <= 0) currentWorld[m][n].strength = 1; /* Last breath */
         if (currentWorld[i][j].strength > maxStrength) currentWorld[i][j].strength = maxStrength; /* Upper bound */
         if (currentWorld[m][n].strength > maxStrength) currentWorld[m][n].strength = maxStrength; /* Upper bound */
         }
      }
    }
  }
  
}

void simulationStep(Agent[][] currentWorld) {
  /* If social influence is used */
  if (useSocialInfluence) {
        applySocialInfluence(currentWorld);
  }
  /* Prisoner's Dilemma realization - resource harvesting */
  interactCooperateDefect(currentWorld);
  /* Movement, metabolic costs, and reproduction */
  updateMetabolismAndMovement(currentWorld);
}

void calculateStatistics(Agent[][] tab, double[] stressRet, double[] meanStrengthRet, double[] maxStrengthRet, int[] attitudeCounts) {
  int i,j,N;
  double meanStrength = 0;
  double maxStrengthValue = 0;
  for(i = 0; i <= attitudesCount; i++) { attitudeCounts[i] = 0; }
  double globalStress = 0;
  N = 0;
  for(i = 1; i <= sideLength; i++) {
    for(j = 1; j <= sideLength; j++) {
      if (tab[i][j].strength > 0) {
        N = N + 1;
        globalStress = globalStress + tab[i][j].stress;
        attitudeCounts[tab[i][j].attitude] = attitudeCounts[tab[i][j].attitude] + 1;
        meanStrength = meanStrength + tab[i][j].strength;
        if (maxStrengthValue < tab[i][j].strength) {
             maxStrengthValue = tab[i][j].strength;
        }
      }
    }
  }
  attitudeCounts[attitudesCount] = N;
  if (N > 0) {
     globalStress = globalStress / N;
     meanStrength = meanStrength / N;
  }
  stressRet[0] = globalStress;
  meanStrengthRet[0] = meanStrength;
  maxStrengthRet[0] = maxStrengthValue;
}

void draw() {
  if(!isRunning) {
    println("Function draw is entered, however 'isRunning'==false!\nFirst time is expected and nothing wrong!");
    return; // Double guard: loop is disabled by noLoop(), but Processing calls draw() once on startup anyway.
  }
  
  if (currentStep <= maxSteps) {             assert(simulationWorld!=null); //<>//
    calculateStressLevels(simulationWorld);
    calculateStatistics(simulationWorld, globalStressArr, meanStrengthArr, maxStrengthArr, attitudeCounts);
    double globalStress = globalStressArr[0];
    double meanStrength = meanStrengthArr[0];
    double maxStrengthValue = maxStrengthArr[0];
    
    if (currentStep % visualizationFreq == 0) {
          drawWorld(simulationWorld);
    }
    
    /* Output display */
    fill(255);
    noStroke();
    rect(agentCellSize, requiredWindowSize, requiredWindowSize-agentCellSize*2, SHEIGHT - (sideLength + 1) * agentCellSize);
    stroke(0, 0, 0);
    fill(0, 0, 0);
    
    textSize(12); textAlign(LEFT,TOP);
    text(currentStep + " *STRESS: " + nf((float)globalStress,0,7) + " *STRENGTH: 0->mn:" + nf((float)meanStrength, 0, 3) + "->max:" + maxStrengthValue + " *Alive: " + attitudeCounts[attitudesCount] + " (deficit: " + birthDeficit + ") ",
         agentCellSize, requiredWindowSize);
    
    F.print(currentStep + "\t" + globalStress + "\t" + meanStrength + "\t" + maxStrengthValue);
    for(int i = 0; i < attitudesCount; i++) {
      double q = rescale(i, 0, attitudesCount - 1) * 255;
      fill(0, (float)(255 - q), (float)q);
      text(" " + attitudeCounts[i] + " ", agentCellSize + i * 50, (sideLength + 1) * agentCellSize + 35);
      F.print("\t" + attitudeCounts[i]);
    }
    F.println();
    F.flush();
    
    if (stepDelayMs > 0) {
      delay(stepDelayMs);
    }
    
    /* Next step */
    simulationStep(simulationWorld);
    currentStep = currentStep + 1;
  } else {
    F.println();
    F.flush();
    F.close();
    noLoop();
  }
}

/// @date 2026-10-29 ( → https://github.com/borkowsk/bookProcessingEN)
