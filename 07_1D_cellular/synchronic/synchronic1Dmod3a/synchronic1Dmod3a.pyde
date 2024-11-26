## "sum of alives neig. modulo 3": 
## One-dimensional, SYNCHRONOUS, deterministic cellular automaton.
##-##==============================================================

'''constant int'''
WorldSize=500  ##How many cells do we want?
'''constant float'''
Dens=0.0  ##0.5 or so also posible

WorldOld=[0]*(WorldSize) ##We need two lists for the old  
WorldNew=[0]*(WorldSize) ##and new state of the simulation

def setup(): # Any globals modified?
  '''block:''' 
  size(500,1000); 
  frameRate(30)
  noSmooth()  ##CA look better without smooth
  
  if Dens>0 :
    '''block:''' 
    for i in range(0,WorldSize,1): # 'i' has int value
      if random(1.0)<Dens :
        WorldOld[i]=1
  else :
    '''block:''' 
    WorldOld[WorldSize/2]=1

def visualisation(): # Any globals modified?
  '''block:''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    '''block:'''  ## The selection instruction allows us 
    ## to choose any color depending on the number in the cell
    _switchvar=WorldOld[i]   #switch block:
    if  _switchvar== 2:stroke(0,255,0);pass
    elif _switchvar==1:stroke(255,0,255);pass
    elif _switchvar==0:stroke(0,0,0);pass
    else : stroke(0,0,255)  ##It shouldn't appear!
    pass
    point(i,t)  ##current state
    line(i,t,i,999)  ##Reflect the current state to the bottom of the canvas

t=0  ##< this is global!

def draw(): # Any globals modified? #
  global t,WorldOld,WorldNew
  '''block:''' 
  if t>height-8: return
  
  visualisation()
  
  for i in range(0,WorldSize,1): # 'i' has int value ##Now the cellular automaton state change
     '''block:'''   ##Rule: "SUM YOUR STATE WITH YOUR NEIGHBORS AND TAKE MODULO 3"
     right = (i+1) % WorldSize;      
     left  = (WorldSize+i-1) % WorldSize
     
     sum = 0
     if WorldOld[i]>0 :
       sum+=1
     if WorldOld[left]>0 :
       sum+=1
     if WorldOld[right]>0 :  
       sum+=1
       
     WorldNew[i]=sum % 3  ##We save the new state on the second array
   
  ##NOW THE MOST IMPORTANT - Swap the "worlds"
  '''assumed list of int'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp
   
  t+=1  ##The next generation/step/year

##https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/
