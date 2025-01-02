## Sakoda inspired asynchronous AGENT BASE MODEL 
## utilized 2D discrete geometry (but prepared also for 1D)
##*##=========================================================
from adhoclib import * 


## Model parameters
side=50  #side of main table
modelName="Sakoda0ABM"
density=0.55

## Parameters of visualisation etc...
cwidth=16  #size of cell
STATUSHEIGH=40  #Height of the status bar
STEPSperVIS=1  #How often to visualize the simulation world?
FRAMEFREQ=5  #Expected speed of the animation

TheWorld = World.make_World0(side)  #Create a simulation world#
##Which still needs to be initialized in the setup()

def setup(): # Is it any global variable modified inside?
  global side,density,cwidth,STATUSHEIGH,STEPSperVIS,FRAMEFREQ,modelName  ##MANUALLY!!!
  '''Purpose of the code block below is ...'''
  # Graphics initialization
  size(800, 840)  #Variables cannot be used here unfortunately :-(
  background(255, 255, 200)  #They can already be used here, but what for?
  strokeWeight(2)
  frameRate(FRAMEFREQ)  #It will come in handy here...

  # Does the window size match the program's expectations?
  print "REQUIRED SIZE OF PAINTING AREA IS ", str(cwidth*side)+"x"+str(cwidth*side+STATUSHEIGH)
  print "CURRENT SIZE OF PAINTING AREA IS ", str(width)+"x"+str(height)
  cwidth=(height-STATUSHEIGH)/side  #Adjusting the size of the agents. 
  #At most, the entire window will not be filled.

  # Finally, we deal with the MODEL itself
  TheWorld.initializeModel(density)  #Initialisation of the World
  visualizeModel(TheWorld,cwidth)  #The first visualization


def draw(): # Is it any global variable modified inside?
  global side,density,cwidth,STATUSHEIGH,STEPSperVIS,FRAMEFREQ,modelName  
  '''Purpose of the code block below is ...'''
  TheWorld.modelStep()  #The next simulation step

  # Visualization doesn't have to be at every step  
  if TheWorld.StepCounter % STEPSperVIS == 0  :
    visualizeModel(TheWorld,cwidth)

  # Drawing the status bar is not that expensive, so every step.
  statusLine()


def statusLine(): # Is it any global variable modified inside?
  global side,density,cwidth,STATUSHEIGH,STEPSperVIS,FRAMEFREQ,modelName    
  '''Purpose of the code block below is ...'''
  fill(255)
  noStroke()
  # Cleaning is the most expensive, so let's cut it down!
  rect(0, side*cwidth, width/6, STATUSHEIGH)
  fill(0)
  textAlign(LEFT, TOP)
  textAlign(LEFT, BOTTOM)
  # Not much to write yet
  text(str(TheWorld.StepCounter)+")  Fps:"+str(frameRate), 0, side*cwidth+STATUSHEIGH-2)


## Expected interface for a world class
class simulation_world : #@INTERFACE simulation_world   # For documentation only
  '''Purpose of the code block below is ...'''
  def    initializeModel(self): pass ### is an object method.
  def    changeState(self): pass ### is an object method.
  def    makeStatistics(self): pass ### is an object method.
  def    modelFullStep(self): pass ### is an object method.
  def   getTimeStep(self): pass ### is an object method.
#def __INIT__(self):
  # fc:0

  #@END_OF_CLASS

##*##=======================================================================================
##  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM SAKODA0 MAIN 
##  https://github.com/borkowsk/bookProcessingEN
##*##=======================================================================================
## jigle.awk .pde classes preprocessing by borkowsk @ github.
## Translated by pde2pyde Fri, 20 Dec 2024 20:30:09 +0100
