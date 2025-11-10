## "sum of the states [of neighbors] modulo 4": 
## One-dimensional, SYNCHRONOUS, deterministic cellular automaton
##-##===========================================================================

'''constant int'''
WorldSize=500  ##How many cells do we want?
'''constant float'''
Dens=0.0       ##0.005 or 0.5 or similars are also posible

WorldOld=[0]*(WorldSize) ##We need two worlds for the old  
WorldNew=[0]*(WorldSize) ##and new state of the simulation

def setup(): # Any sideeffects on globals?
  '''What is purpose of this block below?''' 
  size(500,1000)
  frameRate(100)
  noSmooth()  ##CA look better without smooth
  if Dens>0 :
    #block: 
   for i in range(0,len(WorldOld),1): # loop over variable "i"
    if random(1.0)<Dens :
      WorldOld[i]=1
  else :
    #block: 
    WorldOld[WorldSize/2]=1

def visualisation(): # Any sideeffects on globals?
  '''What is purpose of this block below?''' 
  for i in range(0,len(WorldOld),1): # loop over variable "i"
    #block: 
    ## The selection instruction allows us 
    ## to choose any color depending on the number in the cell
    _switchvar=WorldOld[i]   #block: 
    if  _switchvar== 3:stroke(0,255,0)
    elif _switchvar==2:stroke(255,0,0)
    elif _switchvar==1:stroke(0,0,255)
    elif _switchvar==0:stroke(0,0,0)
    else : stroke(255,255,0)  ##It shouldn't appear!
    
    point(i,t)  ##current state
    line(i,999,i,994)  ##Reflect the current state at the bottom of the canvas

t=0  ##< is global!

def draw(): # Any sideeffects on globals? #
  global t,WorldOld,WorldNew
  '''What is purpose of this block below?''' 
  if t>994 : return
  visualisation()
  
  ##Now the cellular automaton state change
  for i in range(0,len(WorldOld),1): # loop over variable "i"
    #block: 
     ##RULE - sum of the states of neighbors modulo 4  
     right = (i+1) % WorldSize; 
     morer = (i+2) % WorldSize;     
     left  = (WorldSize+i-1) % WorldSize
     morel = (WorldSize+i-2) % WorldSize
     sumState = 0  ##The sum of the states
     
     ##We always add the WHOLE state, no matter, if it is zero or "alive"
     sumState+=WorldOld[left]
     sumState+=WorldOld[right]
     sumState+=WorldOld[morel]
     sumState+=WorldOld[morer]
     sumState+=WorldOld[i]  ##center cell
     ##Sum modulo 4 or 5 !      
     WorldNew[i]=sumState % 4;  
   
  ##NOW THE MOST IMPORTANT - Swap the arrays
  '''assumed list of int'''
  WorldTmp=WorldOld; WorldOld=WorldNew; WorldNew=WorldTmp
 
  t+=1 ##The next generation/step/year


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)

