## "Voter model" <=> "Nearest Neighbors Social Impact"
## One-dimensional, asynchronous cellular automaton
##-##===========================================================

'''constant int'''
WorldSize=500  ## How many cells do we want?
'''constant int'''
MCD=4   ## Monte Carlo step divider.
'''constant int'''
FR=300  ## Expected speed of the simulation.

World=[0]*(WorldSize) ## We create an array of the "world".

def singleInit(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  World[WorldSize/2]=1  ## The seed of the automaton more or less in the middle.


def densityInit(Dens): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    if random(1.0)<Dens :
      World[i]=1
    else :
      World[i]=0


def setup(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  size(500,500)  ## The window is more vertical than horizontal.
  frameRate(FR)  ## Expected speed of the simulation.
  noSmooth()     ## Antialiasing is unnecessary for cellular automata.
  ## Initialisation:
  densityInit(0.33)


def Visualisation1(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    # block:                                
    if World[i]>0 : stroke(255,255,0)  ## Non-zero cells are yellow.
    else :           stroke(0,0,255)    ## Zero cells are blue.
    point(i,t)  ## State of the 'i' cell of the automaton at time 't'.
  


def Visualisation2(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    # block:                                
    if World[i]>0 : stroke(0,255,128)  ## Non-zero cells are green.
    else :           stroke(0)          ## Zero cells are black.
    line(i,t,i,height)  ## State of the 'i' cell of the automaton at time 't'.
  


t=0  ## Global time counter, i.e. steps/generations/years.

def draw(): # Is it any global variable modified inside? #
  global t
  '''What should this code below do?''' 
  if t>height : ## Is it off screen?
    return     ## We use "emergency exit" because there is nothing to draw.
 
  Visualisation2()
  
  ## Monte Carlo or part of Monte Carlo step.
  N=WorldSize/MCD  ## At MOST 1/MCD of the automaton cells changes its state in a time step.
  for j in range(0,N,1): # 'j' has int value
    # block: 
     i=int(random(WorldSize))  ## We need to truncate the fractional part.
     
     ## Calculation of neighbors' indices taking into account the "boundary conditions". 
     right = (i+1) % WorldSize  ## Wrapping in a circle using the remainder of division operator.       
     left  = (WorldSize+i-1) % WorldSize  ## % operator works well only for positive numbers!
     cou0  = 0  ## counter of 0 state neighbors.
     cou1  = 0  ## counter of 1 state neighbors.
   
     if World[left]==0 : cou0+=1  ## Is the left neighbor not zero?
     else : cou1+=1
         
     if World[right]==0 : ## Is the right neighbor not zero?
       cou0+=1
     else : cou1+=1
       
     if World[i]==0 : ## What about me?
       cou0+=1
     else : cou1+=1
     
     ## The rule of this automaton - you assume a state. 
     ## more common in your vicinity.
     if cou0>cou1 :
       World[i]=0
     else : ##What about == ?
       World[i]=1
  
  t+=1  ## The next generation/step/year.


## https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/asynchronic
