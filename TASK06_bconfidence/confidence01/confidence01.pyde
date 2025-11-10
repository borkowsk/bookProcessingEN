## Bounded confidence 0D - first attempt.
## Only epsilon as a model parameter.
##-##====================================

'''constant int'''
N=25       #Number of agents
'''constant double'''
eps=0.001  #speed of changes

minds=[0.0]*(N) #creating an array 

## for visualisation:
side=0  #diameter of circles 

def setup(): # Is it any global variable modified inside? YES!!!
  global side
  '''Purpose of the code block below is to initialize window and simylation'''
  size(1000,250)
  side=height/(N*2)
  frameRate(100)
  
  # Initialisation
  for i in range(0,N,1): # loop over variable "i"
    minds[i]=i*(1.0/(N-1))  #<0..1) or minds[i]=random(1.0)
    
  # Check
  for i in range(0,N,1): # loop over variable "i"
    print str(minds[i])+" ",



def draw(): # Is it any global variable modified inside? NO. Only content of `minds`
  '''Purpose of the code block below is ...'''
  # Visualisation
  step=255.0/N;R=255;B=0
  for i in range(0,N,1): # loop over variable "i"
    # block:
    stroke(R,0,B);R-=step;B+=step
    ellipse(frameCount%width,(1-minds[i])*height,side,side)
  
  
  # Monte Carlo step of changes
  for i in range(0,N,1): # loop over variable "i"
    # block:
    a=int(random(N))
    b=int(random(N))
    
    if minds[a] < minds[b] :
       minds[a]+=eps
    else :
       if minds[a] > minds[b] :
          minds[a]-=eps
  
 # end of draw()


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence)
