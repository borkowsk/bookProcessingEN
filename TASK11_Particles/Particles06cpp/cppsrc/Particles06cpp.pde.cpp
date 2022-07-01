//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: Particles06cpp.pde
#include "processing_consts.hpp"
#include "processing_templates.hpp"
#include "processing_library.hpp"
#include "processing_inlines.hpp" //...is optional. Use when project is already compilable!
#include "processing_window.hpp"
#include "project.h" //...is for you. Could be deleted when not needed.
using namespace Processing;
#include "local.h"
//==================================================================================

/// "Naive" particles system with simplified phisics of collisions
/// (slightly modified example)
//*//////////////////////////////////////////////////////////////////////

int circles = 50;      ///< global
bool torus=true;    ///< global

bool trace=false;   ///< global
int diameter=25;       ///< global
int radius=diameter/2; ///< global
float maxspeed=1;      ///< global
int FRAMERATE=800;     ///< global
int VISFREQ=8;         ///< every N

sarray<float>   xpos = new array<float>(circles);        ///< global
sarray<float>   ypos = new array<float>(circles);        ///< global
sarray<float>   xspeed = new array<float>(circles);      ///< global
sarray<float>   yspeed = new array<float>(circles);      ///< global
sarray<bool> collision = new array<bool>(circles); ///< ???

sarray<bool> isNaive = new array<bool>(circles); ///< global
sarray<pcolor>   circolor = new array<pcolor>(circles);  ///< Atitude?
sarray<float>   wellbeing = new array<float>(circles); ///< Moving average 

bool isPositionFree(int i) ///< global
{
  for(int j=0;j<circles;j++)
      if( j!=i 
      && dist(xpos[i],ypos[i],xpos[j],ypos[j])<=diameter )
            return false;
  return true;
}

void processing_window::setup()
{
  size(900,900);
  smooth();
  background(0);
  setFrameRate(FRAMERATE);
  strokeWeight(2);

  for(int i=0;i<circles;i++)
  {
    do{
    xpos[i] = diameter/2+random(width-diameter);
    ypos[i] = diameter/2+random(height-diameter);
    }while(!isPositionFree(i));
    xspeed[i] = random(maxspeed*0.2,maxspeed)*(random(1.0)<0.5?-1:1);
    yspeed[i] = random(maxspeed*0.2,maxspeed)*(random(1.0)<0.5?-1:1);
    isNaive[i] = random(1.0)<0.5;
    circolor[i] = color(255);
    collision[i] = false;
    wellbeing[i]= random(255);
  }
}

void visualisation() ///< global
{
  if(!trace) background(0);
  else {
	 fill(0,1);rect(0,0,width,height);
	}
  
  for(int i=0;i<circles;i++)
  {
    fill(circolor[i]);
    if(isNaive[i]) 
      stroke(wellbeing[i],wellbeing[i],0);
    else 
      noStroke();
    ellipse(xpos[i],ypos[i],diameter,diameter);
  }
}

void movement() ///< global
{
  for(int i=0;i<circles;i++){
    ypos[i]+=yspeed[i];
    xpos[i]+=xspeed[i];
  }
}

/// It detects collisions with borders.
void bordersReaction() ///< global
{
  for(int i=0;i<circles;i++)
    if(torus)
    {
      if(xpos[i]<0) xpos[i]=width-xpos[i];
      else
      if(xpos[i]>width) xpos[i]-=width;
      
      if(ypos[i]<0) ypos[i]=height-ypos[i];
      else
      if(ypos[i]>height) ypos[i]-=height;
    }
    else //Borders detection should depend on circle radius!
    {
      if(ypos[i]>(height-radius) || ypos[i]<radius)
        yspeed[i]*=-1;
      
      if(xpos[i]>(width-radius) || xpos[i]<radius)
        xspeed[i]*=-1;
    } 
}

/// It detects collisions and triggers appropriate reaction procedures.
void findcollisions() ///< global
{
    for(int i=0;i<(circles-1);i++){
     for(int j=(i+1);j<circles;j++){ 
      if( dist(xpos[i],ypos[i],xpos[j],ypos[j]) < diameter )
      {
          
          physicalCollision(i,j);
          
          if(isNaive[i]) reactionOfNaive(i,j);
          else reaction(i,j);
          
          if(isNaive[j]) reactionOfNaive(j,i);
          else reaction(j,i);
          
          //Prevent multiple reactions
          collision[i]=true;
          collision[j]=true;
      }
     }
    }
    
    for(int i=0;i<circles;i++) collision[i]=false; //Clear collisions
}

/// SIMPLIFIED elastic rebound, i->e. the physical reaction to collisions
void physicalCollision(int i,int j) ///< global
{
  if(collision[i]==false){
     xspeed[i] *= -1;
     yspeed[i] *= -1;
  }
  
  if(collision[j]==false){
     xspeed[j] *= -1;
     yspeed[j] *= -1;
  }
}

/// i-th agent reacts, j-th agent supplies data only!
void reactionOfNaive(int i,int j) ///< global
{
  if(collision[i]==false){
    //... YOUR CODE
    //eg.:
    if(random(255)<wellbeing[i])
       circolor[i]=color(random(255),random(255),random(255));
    else
       circolor[i]=color(0.5*red(circolor[i])+0.5*red(circolor[j]),
                      0.5*green(circolor[i])+0.5*green(circolor[j]),
                      0.5*blue(circolor[i])+0.5*blue(circolor[j]));
  }
}

/// i-th agent reacts, j-th agent supplies data only!
void reaction(int i,int j) ///< global 
{
  if(collision[i]==false){
    //... YOUR CODE
    //eg.:
    circolor[i]=color(0.9*red(circolor[i])+0.1*red(circolor[j]),
                      0.9*green(circolor[i])+0.1*green(circolor[j]),
                      0.9*blue(circolor[i])+0.1*blue(circolor[j]));
  }
}

void processing_window::draw()
{
  if(frameCount%VISFREQ==0)
     visualisation();
  movement();
  bordersReaction();
  findcollisions();
}

// https://github->com/borkowsk/bookProcessingEN
///data/wb/SCC/public/Processing2C/scripts did it

