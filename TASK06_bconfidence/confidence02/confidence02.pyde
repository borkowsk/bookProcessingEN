## Bounded confidence 0D - second attempt.
## Treshold and epsilon.
##-##======================================

'''constant int'''
N=25         #Number of agents
'''constant double'''
eps=0.002    #pace of change
'''constant double'''
tre=1.0/2    #Treshold

minds=[0.0]*(N) #creating an array 

##for visualisation
side=0

def setup(): # Is it any global variable modified inside? YES
  global side
  '''Purpose of the code block below is ...'''
  size(1000,250)
  side=height/(N*2)
  frameRate(600)
  
  #Initialisation
  for i in range(0,N,1): # loop over variable "i"
    minds[i]=i*(1.0/(N-1)) #<0..1>
    
  #Check
  print   "N:",str(N),"Epsilon:",str(eps),"Treshold:",str(tre)
  this.surface.setTitle("confidence02 "+str(tre) ) # Modification of window title.
  for i in range(0,N,1): # loop over variable "i"
    print minds[i]," ",


def draw(): # Is it any global variable modified inside? NO
  '''Purpose of the code block below is ...'''
  #Visualisation:
  step=255/N;R=255;B=0
  for i in range(0,N,1): # loop over variable "i"
    # block:
    stroke(R,0,B);R-=step;B+=step
    ellipse(frameCount,(1-minds[i])*height,side,side)
  
  
  #Monte Carlo step of changes
  for i in range(0,N,1): # loop over variable "i"
    # block:
    a=int(random(N))
    b=int(random(N))
    
    if abs(minds[a]-minds[b]) < tre  :
      # block:
      if minds[a] < minds[b] :
        minds[a]+=eps
      elif minds[a] > minds[b] : #We can use elif instead of `else if`
          minds[a]-=eps
    
  
 #End of draw()

## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence)
