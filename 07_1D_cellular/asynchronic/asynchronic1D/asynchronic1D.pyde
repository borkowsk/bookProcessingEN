## TODO comments clean!
## "Seeding": One-dimensional, asynchronous cellular automaton
##  (the simplest simulation of CA in functional syntax) 
####===========================================================

'''constant int'''
WorldSize = 500  ## How many cells do we want?
'''constant int'''
MCD =  4  ## Monte Carlo step divider
'''constant int'''
FR = 900  ## Expected speed of the simulation

World=[0]*(WorldSize) ## We create an array of the "world", initialised with zeros

def setup(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  size(500,1000)  ## The window is more vertical than horizontal
  frameRate(FR)   ## Expected speed of the simulation
  noSmooth()      ## Antialiasing is unnecessary for cellular automata

  World[WorldSize/2]=1  ## The seed of the automaton more or less in the middle


t=0  ## Time counter, i.e. steps/generations/years
def draw(): # Is it any global variable modified inside? #
  global t
  '''What should this code below do?''' 
  if t>height : ## Is it off screen?
  ##  return     # Alt... there is nothing to draw - we use "emergency exit" prom function. 
     t=height-1

  ##Visualisation
  for i in range(0,WorldSize,1): # 'i' has int value ## Instead WorldSize may be World.length (an attribute of any array)
    # block:                                
    if World[i]>0 : 
        stroke(255,255,0)  ## Non-zero cells are yellow
    else :           
        stroke(0,0,255)  ## Zero cells are blue
    
    point(i,t)  ## State of the 'i' cell of the automaton at time 't'
  
  
  ## Monte Carlo or part of Monte Carlo step
  N=WorldSize/MCD  ## At MOST 1/MCD of the automaton cells changes its state in a time step
  for j in range(0,N,1): # 'j' has int value
    # block: 
    i=int(random(WorldSize))  ## We need to truncate the fractional part
       
    ## Calculation of neighbors' indices taking into account the "boundary conditions" 
    right = (i+1) % WorldSize  ## Wrapping in a circle using the remainder of division operator       
    left  = (WorldSize+i-1) % WorldSize  ## This operator works intuitively only for positive numbers!
       
    ## The rule of this automaton - if you have a living neighbor, you become alive
    if World[left]>0 : ## Is the left neighbor not zero, ie is he "alive"?
       World[i]=1      ## The cell under consideration becomes alive
       
    if World[right]>0 : ## Is the right neighbor not zero?
       World[i]=1
  
   
  t+=1  ## The next generation/step/year


def exit(): # Looks like this hack does not work in Python mode.
  print "Frame rate:",frameRate,"fps" #So it never appears :-(


## https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/asynchronic
## @date 2024-11-21 (last modification)
