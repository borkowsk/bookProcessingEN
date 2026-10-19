// G4P components corresponding to the Delphi configuration form
import g4p_controls.*;

GWindow    setupWindow;
GButton    OKButton;
GTextField fileCoreTextField;
GTextField densityTextField, noiseTextField;
GCheckbox  socialInfluenceCheckBox, crowdingStressCheckBox;
GTextField sideLengthTextField, attitudesCountTextField, maxStrengthTextField, distributionTextField;
GTextField stepCostTextField, optimumReserveTextField;
GTextField WidthSpinEdit, HeightSpinEdit, SideSpinEdit1, VisfreqSpinEdit2;
GTextField weakAgentTextField, borderTextField, delayTextField, maxStepsTextField;
GTextField payoffMatrixTextField00, payoffMatrixTextField10, payoffMatrixTextField01, payoffMatrixTextField11;

//GButton StartButton;

void drawSetupWindow(PApplet appc, GWinData data) { // data not used because there's no need :-D
  appc.background(240);
  
  // Subtle section outlines for clarity (equivalent of GroupBox in Delphi)
  //appc.stroke(200);
  //appc.noFill();
  //appc.rect(10, 10, 345, 310); // Left frame
  //appc.rect(360, 10, 210, 220); // Payoff table frame
}

void createGUI() {
  G4P.messagesEnabled(false);
  setupWindow = GWindow.getWindow(this, "Simulation Settings", 0, 0, 600, 400, JAVA2D);
  setupWindow.noLoop(); //<>//
  setupWindow.addDrawHandler(this,"drawSetupWindow");
  
  // Labels and control fields in the G4P window
  OKButton = new GButton(setupWindow, 225, 355, 153, 25, "OK / Apply");
  OKButton.addEventHandler(this, "OKButtonClick");
  
  //StartButton = new GButton(setupWindow, 400, 395, 153, 25, "START / RESET");
  //StartButton.addEventHandler(this, "StartButtonClick");
  
  fileCoreTextField = new GTextField(setupWindow, 8, 280, 340, 25);
  fileCoreTextField.setText(FileNameCore);
  fileCoreTextField.addEventHandler(this, "onFileCoreChanged");
  
  // Grid and economic parameter fields
  sideLengthTextField = new GTextField(setupWindow, 16, 60, 65, 22);
  sideLengthTextField.setText(str(sideLength));
  sideLengthTextField.addEventHandler(this, "onSideLengthChanged");
  
  densityTextField = new GTextField(setupWindow, 16, 120, 65, 22);
  densityTextField.setText(str((float)populationDensity));
  densityTextField.addEventHandler(this, "onDensityChanged");

  attitudesCountTextField = new GTextField(setupWindow, 16, 90, 65, 22);
  attitudesCountTextField.setText(str(attitudesCount));
  attitudesCountTextField.addEventHandler(this, "onAttitudesCountChanged");

  maxStrengthTextField = new GTextField(setupWindow, 16, 150, 65, 22);
  maxStrengthTextField.setText(str(maxStrength));
  maxStrengthTextField.addEventHandler(this, "onMaxStrengthChanged");

  distributionTextField = new GTextField(setupWindow, 16, 180, 65, 22);
  distributionTextField.setText(str(paretoExponent));
  distributionTextField.addEventHandler(this, "onDistributionChanged");

  noiseTextField = new GTextField(setupWindow, 16, 210, 65, 22);
  noiseTextField.setText(str((float)noiseLevel));
  noiseTextField.addEventHandler(this, "onNoiseLevelChanged");

  stepCostTextField = new GTextField(setupWindow, 305, 128, 57, 22);
  stepCostTextField.setText(str(stepCost));
  stepCostTextField.addEventHandler(this, "onStepCostChanged");

  optimumReserveTextField = new GTextField(setupWindow, 305, 160, 57, 22);
  optimumReserveTextField.setText(str(optimumReserve));
  optimumReserveTextField.addEventHandler(this, "onOptimumReserveChanged");

  // Payoff table
  payoffMatrixTextField00 = new GTextField(setupWindow, 375, 60, 70, 25);
  payoffMatrixTextField00.setText(str(payoffMatrix[0][0]));
  payoffMatrixTextField00.addEventHandler(this, "onPayoff00Changed");

  payoffMatrixTextField10 = new GTextField(setupWindow, 450, 60, 70, 25);
  payoffMatrixTextField10.setText(str(payoffMatrix[1][0]));
  payoffMatrixTextField10.addEventHandler(this, "onPayoff10Changed");

  payoffMatrixTextField01 = new GTextField(setupWindow, 375, 90, 70, 25);
  payoffMatrixTextField01.setText(str(payoffMatrix[0][1]));
  payoffMatrixTextField01.addEventHandler(this, "onPayoff01Changed");

  payoffMatrixTextField11 = new GTextField(setupWindow, 450, 90, 70, 25);
  payoffMatrixTextField11.setText(str(payoffMatrix[1][1]));
  payoffMatrixTextField11.addEventHandler(this, "onPayoff11Changed");

  socialInfluenceCheckBox = new GCheckbox(setupWindow, 69, 240, 185, 17, "Use social influence for attitudes");
  crowdingStressCheckBox = new GCheckbox(setupWindow, 344, 240, 165, 17, "Crowding stress");

  // --- LABELS (GLabel) CORRESPONDING TO THE DELPHI ORIGINAL ---
  
  // Main warning at the top
  GLabel tmp=new GLabel(setupWindow, 8, 5, 480, 30, "ATTENTION! Only changing parameters before starting the worker thread guarantees effect!"); assert(tmp!=null);
  
  // Tab / Section: Single experiment parameters (left side)
  tmp=new GLabel(setupWindow, 85, 60, 180, 20,  "Simulation world side length"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 90, 180, 20,  "Number of attitudes"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 120, 180, 20, "Population density"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 150, 180, 20, "Maximum agent energy"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 180, 180, 20, "\"Pareto\" distribution degree"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 210, 210, 20, "Probability of attitude changes"); assert(tmp!=null);

  // Right column: Cost and optimal reserve
  tmp=new GLabel(setupWindow, 365, 130, 160, 20, "Maintenance cost (per step)"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 365, 160, 180, 20, "Optimal reserve (in steps)"); assert(tmp!=null);

  // Payoff table (axis headers)
  tmp=new GLabel(setupWindow, 305, 60, 70, 25, "Cooperation"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 305, 90, 70, 25, "Defection"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 375, 30, 70, 25, "Cooperation"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 450, 30, 70, 25, "Defection"); assert(tmp!=null);

  // Form bottom: Output file name core
  tmp=new GLabel(setupWindow, 360, 280, 260, 25, "Output file name core"); assert(tmp!=null);

  G4P.messagesEnabled(true);
  setupWindow.loop();
}

// Event handler for changes and buttons in G4P mirroring Delphi logic
public void OKButtonClick(GButton button, GEvent event) {
  if (event == GEvent.CLICKED) { //<>//
    println("OK clicked - simulation will start.");
    requiredWindowSize=(sideLength+2)*(agentCellSize+borderSize);
    useSocialInfluence = socialInfluenceCheckBox.isSelected();
    if(useSocialInfluence) println("Social influence on attitudes is active.");
    useCrowdingStress = crowdingStressCheckBox.isSelected();
    if(useCrowdingStress) println("Overcrowding stress is active.");
    runSimulation(); assert(simulationWorld!=null);
    //setupWindow.hide();  // doesn't exist?
    //setupWindow.close(); // doesn't work :-/
    //setupWindow.dispose(); // doesn't work either...
    setupWindow.forceClose(); // Finally works!
    isRunning=true;
    loop(); // Now the simulation can start.
  }
}

//public void StartButtonClick(GButton button, GEvent event) {
//  if (event == GEvent.CLICKED) {
//    currentStep = 0;
//    birthDeficit = 0;
    
//    // Log file name generation
//    String logName = FileNameCore + sideLength + "x" + sideLength + "P" + attitudesCount + "G" + populationDensity + "M" + noiseLevel + "m" + maxStrength + "k" + stepCost + "op" + optimumReserve + ".log";
//    logFile = createWriter(logName);
//    logFile.println("Step\tStress\tMeanEnergy\tMaxEnergy\tAttitude counts");
    
//    initializeWorld(simulationWorld);
//    isRunning = true;
//  }
//}

public void onFileCoreChanged(GTextField field, GEvent event) {
  FileNameCore = field.getText();
}

public void onSideLengthChanged(GTextField field, GEvent event) {
  try { sideLength = int( field.getText() ); } catch(Exception e) {}
}

public void onAttitudesCountChanged(GTextField field, GEvent event) {
  try { attitudesCount = int(field.getText()); } catch(Exception e) {}
}

public void onMaxStrengthChanged(GTextField field, GEvent event) {
  try { maxStrength = int(field.getText()); } catch(Exception e) {}
}

public void onDistributionChanged(GTextField field, GEvent event) {
  try { paretoExponent = int(field.getText()); } catch(Exception e) {}
}

public void onStepCostChanged(GTextField field, GEvent event) {
  try { stepCost = int(field.getText()); } catch(Exception e) {}
}

public void onOptimumReserveChanged(GTextField field, GEvent event) {
  try { optimumReserve = int(field.getText()); } catch(Exception e) {}
}

public void onPayoff00Changed(GTextField field, GEvent event) {
  try { payoffMatrix[0][0] = int(field.getText()); } catch(Exception e) {}
}

public void onPayoff11Changed(GTextField field, GEvent event) {
  try { payoffMatrix[1][1] = int(field.getText()); } catch(Exception e) {}
}

public void onNoiseLevelChanged(GTextField field, GEvent event) {
  try { noiseLevel = float( field.getText() ); } catch(Exception e) {}
}

public void onDensityChanged(GTextField field, GEvent event) {
  try { populationDensity = float( field.getText() ); } catch(Exception e) {}
}

public void onPayoff01Changed(GTextField field, GEvent event) {
  try {
    int val = int(field.getText());
    payoffMatrix[0][1] = val;
    payoffMatrix[1][0] = -val;
    payoffMatrixTextField10.setText(str(-val));
  } catch(Exception e) {}
}

public void onPayoff10Changed(GTextField field, GEvent event) {
  try {
    int val = int(field.getText());
    payoffMatrix[0][1] = val;
    payoffMatrix[1][0] = -val;
    payoffMatrixTextField01.setText(str(-val));
  } catch(Exception e) {}
}
