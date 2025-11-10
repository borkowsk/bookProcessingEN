## "Seeding": the one-dimensional, asynchronous cellular automaton.
##  The simplest simulation of CA in functional syntax.
##-##==============================================================

'''constant int'''
WorldSize=500  ## How many cells do we want?
'''constant int'''
FR=100         ## Expected speed of the simulation
'''constant int'''
MCD=5          ## Monte Carlo step divider

World=[0]*(WorldSize) ## We create an array of the "world"

def setup(): # Is it any global variable modified inside?
  global World  
  '''Hi level block begins...''' 
  size(500,1000)  ## The window is more vertical than horizontal
  frameRate(FR)   ## Expected speed of the simulation
  noSmooth()      ## Antialiasing is unnecessary for cellular automata
  World[WorldSize/2]=1  ## The seed of the automaton more or less in the middle
  '''block ends...'''

def Visualisation1(): # Is it any global variable modified inside? NO
  '''Hi level block begins...''' 
  for i in range(0,WorldSize,1): # 'i' has int value ## or World.length?
    '''block begins...'''                                
    if World[i]>0 : stroke(255,255,0)  ## Non-zero cells are yellow
    else :           stroke(0,0,255)   ## Zero cells are blue
    point(i,t)  ## 'i' cell of the automaton at time 't'
    '''block ends...'''
  '''block ends...'''

def Visualisation2(): # Is it any global variable modified inside? NO
  '''Hi level block begins...''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    '''block begins...'''                                
    if World[i]>0 : stroke(0,255,128)  ## Non-zero cells are green
    else :           stroke(0)         ## Zero cells are black  
    line(i,t,i,height)  ## 'i' cell of the automaton at time 't'
    '''block ends...'''
  '''block ends...'''

t=0  ## Steps counter

def draw(): # Is it any global variable modified inside? #
  global t
  '''Hi level block begins...''' 
  if t>height : return  ## Is it off screen? -> We use "emergency exit"
  
  Visualisation2()
  
  ## Monte Carlo or part of Monte Carlo step
  N=WorldSize/MCD  ## At MOST 1/MCD of the automaton cells changes its state in a time step
  for j in range(0,N,1): # 'j' has int value
    '''block begins...''' 
    i=int(random(WorldSize))  ## We need to truncate the fractional part
       
    ## Calculation of neighbors' indices taking into account the "boundary conditions" 
    right = (i+1) % WorldSize  ## Wrapping in a circle using the remainder of division operator       
    left  = (WorldSize+i-1) % WorldSize  ## This operator works intuitively only for positive numbers!
       
    ## The rule of this automaton - if you have a living neighbor, you become alive
    if World[left]>0 or World[right]>0 : ## Is the left or right neighbor not zero, ie is he "alive"?
       World[i]=1        ## The cell under consideration becomes alive
    '''block ends...'''
   
  t+=1  ## The next generation/step/year
  '''block ends...'''


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)

