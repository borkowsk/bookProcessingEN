//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: gcouple04_animation.pde
#include "processing_consts.hpp"
#include "processing_templates.hpp"
#include "processing_library.hpp"
#include "processing_inlines.hpp" //...is optional. Use when project is already compilable!
#include "processing_window.hpp"
#include "processing_console.hpp"   //...is optional. Should be deleted when not needed.
#include "project.h" //...is for you. Could be deleted when not needed.
using namespace Processing;
#include "local.h"
//==================================================================================

/** A General Systems Theory of Marriage: 
    Nonlinear Difference Equation Modeling of Marital Interaction
    John Gottman, Catherine Swanson, & Kristin Swanson
    Wt+1 = IHW(Ht)  + r1Wt + a
    Ht+1 = IWH(Wt+1)+ r2Ht + b
*/

// For model
//declared in local.h: const float IHW=0.6001,IWH=0.4001; ///< Interaction values are properties of a human relationship 
//declared in local.h: const float a=-0.001,b=-0.001,r1=0.6,r2=0.4; ///< Values describe the characters of people

float W=0.5;
float H=0.5;

// For visualisation
const float DOTSIZE=2; //WARNING! DOTSIZE below 2 not work with ellipses! pr2c TODO!
const float scale=1;

void processing_window::setup()
{
  size(1500,500);
  line(0,height/2,width,height/2); //Zero line
}

int t=0; // 't' need to be global, and keep value in between of draw() calls. 

void processing_window::draw()
{  
  if(t>=width) return; //Now nothing to do more
  
  println(t,W,H);
  
  // Visualisation
  stroke(255,0,0);
  rect(t,height/2-W*scale/2*height,DOTSIZE,DOTSIZE); //The wife is RED
  stroke(0,255,0);
  ellipse(t,height/2-H*scale/2*height,DOTSIZE,DOTSIZE); //The husband is GREEN
  
  t++; //incrementation of 't'
  
  // MODEL
  W=r1*W+a+IHW*H;
  H=r2*H+b+IWH*W;
}

// https://github->com/borkowsk/bookProcessingEN
///data/wb/SCC/public/Processing2C/scripts did it

