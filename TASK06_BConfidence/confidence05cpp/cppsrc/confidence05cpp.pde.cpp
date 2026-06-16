//Processing to C++ converter /data/wb/SCC/public/Processing2C/scripts/procesing2cpp.sh
//Source: confidence05cpp.pde
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

/// Bounded confidence 1D - 3th+4th attempt
/// Differences in tresholds as a function of extremes of views
/// & with information bubles
//*/////////////////////////////////////////////////////////////////////////////////////

//declared in local.h: const int       SEED=111;   ///< seed for random number generator
//declared in local.h: const int          N=100;   ///< Number of agents
//declared in local.h: const float treScale=0.5;   ///<  Threshold is a function of extremes of views times Scale
//declared in local.h: const float   minEps=0.001; ///< minimal epsilon. 
//declared in local.h: const float   maxEps=0.005; ///< maximal epsilon.
//declared in local.h: const int        bub=N/2;   ///< radius of information bubble

sarray<float> minds=new array<float>(N); ///< creating the minds array 
sarray<float>   eps=new array<float>(N); ///< creating the epsilons array
sarray<float>   tre=new array<float>(N); ///< creating the tresholds array

bool classicVis=true;    ///< Type of visualisation

void processing_window::setup()
{
  size(1000,250);
  setFrameRate(300);
  randomSeed(SEED);
  
  // Initialisation
  for(int i=0;i<N;i++)
  {
    minds[i]=i*(1.0/(N-1)); //<0..1>
    eps[i]=random(minEps,maxEps); //print(eps[i],"");
    // Threshold is a function of extremes of views
    tre[i]=(0.5-std::abs(minds[i]-0.5))*treScale; println(tre[i]);//<0..0.5*Scale>
  }
  
  // Check
  println(String("N:")+N , String("Epsilon:")+minEps+String("..")+maxEps , String("Tres.Scale:")+treScale , String("Inf.buble:")+bub );
  for(int i=0;i<N;i++)
    println(minds[i],eps[i],tre[i]);
}

void processing_window::draw()
{
  if(frameCount>width) return; //Emergency exit
  
  // Which visualisation?
  if(classicVis) visualisationA();
  else visualisationB();
  
  // Monte Carlo step of changes
  for(int i=0;i<N;i++)
  {
    int a=int(random(N));
    int low=max(0,a-bub),hig=min(a+bub+1,N);
    int b=int( random( low , hig ) );  //println(a,low,b,hig);

    if(std::abs(minds[a]-minds[b])<tre[a])
    {
      if(minds[a] < minds[b])
        minds[a]+=eps[a];
      else
      if(minds[a] > minds[b])
        minds[a]-=eps[a];
    }
  }
}

void visualisationA()  ///< Basic visualisation
{
  int side=height/(N*2);
  float step=255/N,R=255,B=0;
  for(int i=0;i<N;i++)
  {
    stroke(R,0,B);R-=step;B+=step;
    rect(frameCount,(1-minds[i])*height,side,side);
  }
}

void visualisationB()  ///< Alternative visualisation
{ 
  int side=height/N;
  for(int i=0;i<N;i++)
  {
    float R=minds[i]*255, B=(1-minds[i])*255;
    stroke(R,0,B);
    rect(frameCount,i/(float)N*height,side,side);
  }
}

// https://github->com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence
///data/wb/SCC/public/Processing2C/scripts did it

