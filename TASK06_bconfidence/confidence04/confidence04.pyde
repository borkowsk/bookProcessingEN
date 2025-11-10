##  Bounded confidence 1D.
##  "because of information bubles"
##-##================================

'''constant int'''
N=25         #Number of agents
'''constant double'''
eps=0.007
'''constant double'''
tre=0.20
'''constant int'''
bub=N/7     #radius of information bubble

minds=[0.0]*(N) #creating an array 

def setup(): # Any globals modified?
  '''block:'''
  size(1000,250)
  frameRate(60)
  
  #Initialisation
  for i in range(0,N,1): # loop over variable "i"
    minds[i]=i*(1.0/(N-1))
    
  #Check
  print   "N:",N , "Epsilon:",eps , "Treshold:",tre , "bubleR=",bub 
  for i in range(0,N,1): # loop over variable "i"
    print minds[i]," ",

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
  if frameCount>width : return  #Emergency exit
  
  #Visualisation:
  visualisationA()
  
  #Monte Carlo step of changes:
  for i in range(0,N,1): # loop over variable "i"
    '''block:'''
    a=int(random(N))
    low=max(0,a-bub);hig=min(a+bub+1,N)  #an alternative way to solve the problem of the world's boundaries
    b=int( random( low , hig ) )    #println(a,low,b,hig)
    
    if abs(minds[b]-minds[a])<tre :
      '''block:'''
      if minds[a] < minds[b] :
        minds[a]+=eps
      else :
        if minds[a] > minds[b] :
          minds[a]-=eps


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence)
