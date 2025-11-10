## "Voter model with RADIUS." <=> "R*2 Neighbors Social Impact": 
## One-dimensional, asynchronous cellular automaton
##=##============================================================

'''constant int'''
WorldSize=500  ## How many cells do we want?
'''constant int'''
NeiRadius=7    ## Neighborhood radius

'''constant int'''
MCD=10  ## Monte Carlo step divider
'''constant int'''
FR=100  ## Expected speed of the simulation

World=[0]*(WorldSize) ## We create an array of the "world"

def densityInit(Dens): # Any globals modified?
  '''block:''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    if random(1.0)<Dens :
      World[i]=1
    else :
      World[i]=0


def setup(): # Any globals modified?
  '''block:''' 
  size(500,500)  ## The window is more vertical than horizontal
  frameRate(FR)  ## Expected speed of the simulation
  noSmooth()     ## Antialiasing is unnecessary for cellular automata
  ## Initialisation:
  densityInit(0.5)


def Visualisation3(): # Any globals modified?
  '''block:''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    '''block:'''                                
    if World[i]>0 : stroke(255,0,255)  ## Non-zero cells are magenta
    else :           stroke(255)  ## Zero cells are white
    point(i,t)  ## State of the 'i' cell of the automaton at time 't'
  


def Visualisation2(): # Any globals modified?
  '''block:''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    '''block:'''                                
    if World[i]>0 : stroke(0,255,128)  ## Non-zero cells are green
    else :           stroke(0)  ## Zero cells are black
    line(i,t,i,height)  ## State of the 'i' cell of the automaton at time 't'
  


t=0  ## Time counter, i.e. steps/generations/years

def draw(): # Any globals modified? #
  global t
  '''block:''' 
  if t>height : ## Is it off screen?
    return  ## We use "emergency exit" because there is nothing to draw 
 
  Visualisation3()
  
  ## Monte Carlo or part of Monte Carlo step
  N=WorldSize/MCD; 
  for j in range(0,N,1): # 'j' has int value
     '''block:''' 
     i=int(random(WorldSize))
     cou0 = 0  ## counter of 0 state neighbors
     cou1 = 0  ## counter of 1 state neighbors
     
     for r in range(1,NeiRadius+1,1): # 'r' has int value
       '''block:''' 
       ## Calculation of neighbors' indices taking into account the "boundary conditions" 
       right = (i+r) % WorldSize
       left = (WorldSize+i-r) % WorldSize

       if World[left]==0 : cou0+=1  ## Is the left neighbor not zero?
       else : cou1+=1; 
       
       if World[right]==0 : cou0+=1  ## Is the right neighbor not zero?
       else : cou1+=1
      
 
     if World[i]==0 : cou0+=1  ## What about me?
     else : cou1+=1
     
     ## Central cell assumes a state more common in its environment
     if cou0>cou1 : World[i]=0
     else :  World[i]=1
   
  t+=1  ## The next generation/step/year.


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)

