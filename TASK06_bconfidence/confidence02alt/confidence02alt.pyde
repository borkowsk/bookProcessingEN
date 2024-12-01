## Bounded confidence 0D - second attempt alternative.
## Treshold and epsilon, alternative visualisation
##-##==================================================

'''constant int'''
N=25         #Number of agents
'''constant double'''
eps=0.005
'''constant double'''
tre=0.25

minds=[0.0]*(N) #creating an array

##for visualisation
side=0

def setup(): # Is it any global variable modified inside? 
  global side
  '''Purpose of the code block below is ...'''
  size(1000,250)
  side=height/(N)
  frameRate(190)
  
  #Initialisation:
  for i in range(0,N,1): # loop over variable "i"
    minds[i]=i*(1.0/(N-1)) #<0..1>
    
  #Check:
  print    "N:",N,"Epsilon:",eps ,"Treshold:",tre  
  for i in range(0,N,1): # loop over variable "i"
    print minds[i]," ",


def draw(): # Is it any global variable modified inside?
  '''Purpose of the code block below is ...'''
  #Alternative visualisation - minds as colors only.
  for i in range(0,N,1): # loop over variable "i"
    # block:
    R=minds[i]*255; B=(1-minds[i])*255
    stroke(R,0,B)
    rect(frameCount%width,i/(float)(N)*height,side,side)
  
  
  #Monte Carlo step of changes
  for i in range(0,N,1): # loop over variable "i"
    # block:
    a=int(random(N))
    b=int(random(N))
    
    if abs(minds[a]-minds[b])<tre :
      # block:
      if minds[a] < minds[b] :
        minds[a]+=eps
      else :
        if minds[a] > minds[b] :
          minds[a]-=eps
    
  


##@date 2024-12-01 (https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence)
