## "Not too many neighbors": 
## One-dimensional, SYNCHRONOUS, deterministic cellular automaton.
##-##===============================================================

'''constant int'''
WorldSize=500  ##How many cells do we want?
'''constant float'''
Dens=0.01  ##0.5 or so also posible

WorldOld=[0]*(WorldSize) ##We need two "worlds" for the old  
WorldNew=[0]*(WorldSize) ##and new state of the simulation

def setup(): # Any globals modified?
  '''block:''' 
  size(500,1000)  ##The window is more vertical than horizontal  
  frameRate(100)
  noSmooth()      ##CA look better without smooth
  
  if Dens>0 : ##Initialisation 
    for i in range(0,WorldSize,1): # 'i' has int value ##Seeding an array with a given density
      if random(1.0)<Dens :
        WorldOld[i]=1
  else : WorldOld[WorldSize/2]=1  ##... or one seed


def visualisation(): # Any globals modified?
  '''block:''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    '''block:''' 
    if WorldOld[i]>0 : stroke(255,0,100)
    else :           stroke(0)
    point(i,t)
  


t=0  ##< this is global t

def draw(): # Any globals modified? #
  global t,WorldOld,WorldNew
  '''block:''' 
  if t>height : return  ##There is no place to draw
  visualisation()

  for i in range(0,WorldSize,1): # 'i' has int value ##Now the cellular automaton state change
     '''block:''' 
     ##Rule - "I don't like to have too many neighbors"
     right = (i+1) % WorldSize  ##Wrapping around     
     left  = (WorldSize+i-1) % WorldSize  ##thanks to the remainder of the integer divide
     howMany= 0  ##How many live neighbors?
     
     if WorldOld[left]>0 : ##It is not zero, so, it is "alive"
       howMany+=1
     
     if WorldOld[right]>0 : ##It is not zero, so, it is "alive"
       howMany+=1
             
     if howMany==1 : WorldNew[i]=1  ##Only having one neighbor is correct
     else : WorldNew[i]=0  ##Otherwise, he dies of loneliness or crowds
   
   
  ##NOW THE MOST IMPORTANT - Swap the "worlds"
  '''assumed list of int'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp
   
  t+=1  ##The next generation/step/year


##https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/
