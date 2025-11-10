## Bounded confidence 0D - 3th attempt.
## Differences in tresholds as a function of extremes of views.
##-##=============================================================

'''constant int'''
N=50            #Number of agents
'''constant double'''
treScale=0.999  #Threshold is a function of extremes of views times Scale

minds=[0.0]*(N) #creating the minds array 
eps=[0.0]*(N) #creating the epsilons array
tre=[0.0]*(N) #creating the tresholds array

def setup(): # Any globals modified?
  '''block:'''
  size(1000,500)
  frameRate(60)
  
  #Initialisation:
  for i in range(0,N,1): # loop over variable "i"
    '''block:'''
    minds[i]=i*(1.0/(N-1))  #<0..1>
    eps[i]=random(0.001,0.01)
    #Threshold is a function of extremes of views
    tre[i]=(0.5-abs(minds[i]-0.5))*treScale  #<0..0.5*Scale>
  
  
  #Check
  print   "N:",N,"\tEpsilon: 0.001..0.01","\tTres.Scale:",treScale  
  for i in range(0,N,1): # loop over variable "i"
    print   minds[i],'\t',eps[i],'\t',tre[i] 


def visualisationA(): # Any globals modified?
  '''block:'''
  side=height/(N*2)
  step=255/N;R=255;B=0
  for i in range(0,N,1): # loop over variable "i"
    '''block:'''
    stroke(R,0,B);R-=step;B+=step
    ellipse(frameCount,(1-minds[i])*height,side,side)
  


def visualisationB(): # Any globals modified?
  '''block:''' #Alternative visualisation
  side=height/N
  for i in range(0,N,1): # loop over variable "i"
    '''block:'''
    R=minds[i]*255; B=(1-minds[i])*255
    stroke(R,0,B)
    rect(frameCount,i/(float)(N)*height,side,side)
  


def draw(): # Any globals modified?
  '''block:'''
  #Visualisation
  visualisationB()
  
  #Monte Carlo step of changes
  for i in range(0,N,1): # loop over variable "i"
    '''block:'''
    a=int(random(N))
    b=int(random(N))
    
    if abs(minds[a]-minds[b])<tre[a] :
      '''block:'''
      if minds[a] < minds[b] :
        minds[a]+=eps[a]
      else :
        if minds[a] > minds[b] :
           minds[a]-=eps[a]
    
  


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence)
