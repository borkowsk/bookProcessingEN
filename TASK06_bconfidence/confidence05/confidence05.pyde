## Bounded confidence 1D - 3th+4th attempts.
## Differences in tresholds as a function of extremes of views
## & with information bubles.
##-##=================================================================

'''constant int'''
N=100  #Number of agents
'''constant double'''
treScale=0.5  #Threshold is a function of extremes of views times Scale
'''constant double'''
minEps=0.001
'''constant double'''
maxEps=0.005
'''constant int'''
bub=N/2  #radius of information bubble

minds=[0.0]*(N) #creating the minds array 
eps=[0.0]*(N) #creating the epsilons array
tre=[0.0]*(N) #creating the tresholds array

classicVis=False    #Type of visualisation

def setup(): # Any globals modified? NO, only contents of lists.
  '''block:'''
  size(1000,250)
  frameRate(300)
  
  #Initialisation
  for i in range(0,N,1): # loop over variable "i"
    '''block:'''
    minds[i]=i*(1.0/(N-1)) #<0..1>
    eps[i]=random(minEps,maxEps)
    #Threshold is a function of extremes of views
    tre[i]=(0.5-abs(minds[i]-0.5))*treScale #<0..0.5*Scale>
  
  #Check
  print   "N:",N , "Epsilon:",minEps,"..",maxEps , " Tres.Scale:",treScale , ",Inf.buble:",bub  
  for i in range(0,N,1): # loop over variable "i"
    print   minds[i],eps[i],tre[i] 


def visualisationA(): # Any globals modified? NO
  '''block:'''
  side=height/(N*2)
  step=255/N;R=255;B=0
  for i in range(0,N,1): # loop over variable "i"
    '''block:'''
    stroke(R,0,B);R-=step;B+=step
    ellipse(frameCount,(1-minds[i])*height,side,side)


def visualisationB(): # Any globals modified? NO
  '''block:''' #Alternative visualisation
  side=height/N
  for i in range(0,N,1): # loop over variable "i"
    '''block:'''
    R=minds[i]*255; B=(1-minds[i])*255
    stroke(R,0,B)
    rect(frameCount,i/(float)(N)*height,side,side)


def draw(): # Any globals modified? NO, only contents of lists.
  '''block:'''
  if frameCount>width : return  #Emergency exit
  
  #Visualisation
  if classicVis : visualisationA()
  else : visualisationB()
  
  #Monte Carlo step of changes
  for i in range(0,N,1): # loop over variable "i"
    '''block:'''
    a=int(random(N))
    low=max(0,a-bub);hig=min(a+bub+1,N)
    b=int( random( low , hig ) )   #println(a,low,b,hig)

    if abs(minds[a]-minds[b])<tre[a] :
      '''block:'''
      if minds[a] < minds[b] :
        minds[a]+=eps[a]
      elif minds[a] > minds[b] :
          minds[a]-=eps[a]

#@date 2024-12-01 (https://github.com/borkowsk/bookProcessingEN/tree/main/TASK06_bconfidence)
