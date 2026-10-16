//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: Sakoda1cpp.pde
#include "processing_consts.hpp"
#include "processing_templates.hpp"
#include "processing_library.hpp"
#include "processing_inlines.hpp" //...is optional. Use when project is already compilable!
#include "processing_window.hpp"
#include "processing_string.hpp"  //Processing::String class
#include "processing_console.hpp"   //...is optional. Should be deleted when not needed.
#include "project.h" //...is for you. Could be deleted when not needed.
using namespace Processing;
#include "local.h"
//==================================================================================

/// Sakoda inspired AGENT BASE MODEL utilized 1D or 2D dicrete geometry
/// implemented by Wojciech Borkowski
/// \see https://www->jasss->org/20/3/15->html
//*///////////////////////////////////////////////////////////////////////////////////////

/// Model parameters
int side=100;                 ///< side of main table
String modelName="ABMSakoda"; ///< SHORT name of model
float density=0.55;           ///< initialisation density

/// Main variable
pWorld TheWorld=new World(side); ///< ... but also will be initialised inside setup()

/// Parameters of visualisation etc...
int cwidth=8;                 ///< size of cell
int STATUSHEIGH=40;           ///< global
int STEPSperVIS=1;            ///< global
int FRAMEFREQ=20;             ///< global
bool WITH_VIDEO=true;      ///< global
bool simulationRun=true;   ///< Start/stop flag

void processing_window::setup()
{
  // Graphics
  size(800,840);
  setFrameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  // Model
  TheWorld->initializeModel();
  initializeStats(); //Wykomentowanie blokuje tworzenie pliku log!
  TheWorld->makeStatistics();
  
  // Window 
  println(String("REQUIRED SIZE OF PAINTING AREA IS ")+(cwidth*side)+String("x")+(cwidth*side+STATUSHEIGH));
  cwidth=(height-STATUSHEIGH)/side;
    
  if(WITH_VIDEO) 
  {
    initVideoExport(SAFE_THIS,modelName+ String(".mp4"),FRAMEFREQ);
    FirstVideoFrame();
  }
  
  // Finishing setup stage
  println(String("CURRENT SIZE OF PAINTING AREA IS ")+width+String("x")+height); //-myMenu->bounds->height???
  visualizeModel(TheWorld); //First time visualisation
  if(!simulationRun)
    println("PRESS 'r' or 'ESC' to start simulation");
  else
    println("PRESS 's' or 'ESC' to pause simulation");
  NextVideoFrame(); //It utilise inside variable to check if is enabled
}

void processing_window::draw()
{
  if(simulationRun)
  {
    TheWorld->modelFullStep();
  }
  
  writeStatusLine();
  
  if(!simulationRun //When simulation was stopped only visualisation should work
  || TheWorld->getTimeStep() % STEPSperVIS == 0 ) //But when model is running, visualisation shoud be done from time to time
  {
    visualizeModel(TheWorld);
    NextVideoFrame(); //It utilise inside variable to check if is enabled
  }

}

void writeStatusLine()           ///< global function
{
  fill(255);noStroke();
  rect(0,side*cwidth,width,STATUSHEIGH);
  
  fill(0);textAlign(LEFT, TOP);
  text(liveCount+String("  ")+meanStress,0,side*cwidth);
  textAlign(LEFT, BOTTOM);
  text(TheWorld->getTimeStep()+String(")  Fps:")+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

//*/////////////////////////////////////////////////////////////////////////////////////////
// https://www->researchgate->net/profile/WOJCIECH_BORKOWSKI - ABM SAKODA MAIN
// https://github->com/borkowsk/bookProcessingEN
//*/////////////////////////////////////////////////////////////////////////////////////////
///data/wb/SCC/public/Processing2C/scripts did it

