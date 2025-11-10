## "Not too many neighbors": 
## The one-dimensional, asynchronous cellular automaton.
##-##====================================================

'''constant int'''
WorldSize=500  ## How many cells do we want?
'''constant int'''
MCD=3          ## Monte Carlo step divider
'''constant int'''
FR=300         ## Expected speed of the simulation

World=[0]*(WorldSize) ## Here it creates an array of the "world"

def setup(): # Any global variable modified? #
  global World
  '''Hi level block begins...''' 
  size(500,1000)  ## The window is more vertical than horizontal
  frameRate(FR)   ## Expected speed of the simulation
  noSmooth()      ## Antialiasing is unnecessary for cellular automata
  ## Initialisation
  World[WorldSize/2]=1  ## The seed of the automaton more or less in the middle
  '''block ended.'''

def Visualisation1(): # Any global variable modified?
  '''Hi level block begins...''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    '''block begins...'''                                
    if World[i]>0 : stroke(255,255,0)  ## Non-zero cells are yellow
    else :           stroke(0,0,255)    ## Zero cells are blue
    point(i,t)  ## State of the 'i' cell of the automaton at time 't'
    '''block ended.'''
  '''block ended.'''

def Visualisation2(): # Any global variable modified?
  '''Hi level block begins...''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    '''block begins...'''                                
    if World[i]>0 : stroke(0,255,128)  ## Non-zero cells are green
    else :           stroke(0)  ## Zero cells are black
    line(i,t,i,height)  ## State of the 'i' cell of the automaton at time 't'
    '''block ended.'''
  '''block ended.'''

t=0  ## Time counter, i.e. steps/generations/years

def draw(): # Any global variable modified? YES
  global t
  '''Hi level block begins...''' 
  if t>height : ## Is it off screen?
    return     ## We use "emergency exit" because there is nothing to draw 
 
  Visualisation1()
  
  ## Monte Carlo or part of Monte Carlo step
  N=WorldSize/MCD  ## At MOST 1/MCD of the automaton cells changes its state in a time step
  for j in range(0,N,1): # 'j' has int value
       '''block begins...''' 
       i=int(random(WorldSize))  ## We need to truncate the fractional part
       
       ## Calculation of neighbors' indices taking into account the "boundary conditions" 
       right = (i+1) % WorldSize  ## Wrapping in a circle using the remainder of division operator       
       left  = (WorldSize+i-1) % WorldSize  ## This operator works intuitively only for positive numbers!
       lcou  = 0  ## counter of live neighbors
       
       if World[left]>0 : ## Is the left neighbor not zero, ie is he "alive"?
         lcou+=1;    
       
       if World[right]>0 : ## Is the right neighbor not zero?
         lcou+=1; 
       
       ## The rule of this automaton - if you have ONE living neighbor, you are alive
       if lcou==1 :
         World[i]=1
       else :
         World[i]=0
       '''block ended.'''

  t+=1  ## The next generation/step/year
  '''block ended.'''


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)

