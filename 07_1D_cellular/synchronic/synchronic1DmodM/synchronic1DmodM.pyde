## "sum of the states [of neighbors] modulo M": 
## One-dimensional, SYNCHRONOUS, deterministic cellular automaton
##-##===================================================================

'''constant int'''
WorldSize=500  ##How many cells do we want?
'''constant float'''
Dens=0.0       ##Also 0.5 or so also posible

'''constant int'''
Divider=5      ##By how much we divide? (modulo!)
'''constant boolean'''
self=True    ##Do we include the state of the middle cell

WorldOld=[0]*(WorldSize) ##We need two worlds for the old  
WorldNew=[0]*(WorldSize) ##and new state of the simulation

def setup(): # Any sideeffects on globals? NO, but...
  '''What is purpose of this block below?''' 
  size(500,1000); 
  frameRate(100)
  noSmooth()  ##CA look better without smooth
  
  if Dens>0 :
   #block: 
   for i in range(0,len(WorldOld),1): # loop over variable "i" ##seeding...
    if random(1.0)<Dens :
      WorldOld[i]=int(random(3))
  else :
    #block: 
    WorldOld[WorldSize/2]=1

def visualisation(): # Any sideeffects on globals? NO
  '''What is purpose of this block below?''' 
  for i in range(0,len(WorldOld),1): # loop over variable "i"
    #block:  ##color selection
    _switchvar=WorldOld[i]   #block:  
    if  _switchvar== 4:stroke(255,255,0)
    elif _switchvar==3:stroke(0,255,0)
    elif _switchvar==2:stroke(255,0,0)
    elif _switchvar==1:stroke(0,0,255)
    elif _switchvar==0:stroke(0,0,0)
    ##case *:stroke(*,*,*); 
    ##case 5:stroke(255,0,255); 
    else : stroke(128,255,128)  ##It shouldn't appear!
    
    
    point(i,t)  ##current state
    line(i,999,i,994)  ##& at the bottom

t=0  ##< is global.

def draw(): # Any sideeffects on globals? # YES
  global t,WorldOld,WorldNew
  '''What is purpose of this block below?''' 
  if t>994 : return  ##There is nothing left to draw
  
  visualisation()

  for i in range(0,WorldSize,1): # loop over variable "i"
    #block:   ##RULE: "sum of the states [of neighbors] modulo M"
     right = (i+1) % WorldSize;      
     morer = (i+2) % WorldSize;     
     left  = (WorldSize+i-1) % WorldSize
     morel = (WorldSize+i-2) % WorldSize
     stsum = (WorldOld[i]  if self  else 0 )
     
     stsum+=WorldOld[left]+WorldOld[right]+WorldOld[morel]+WorldOld[morer]  ##sum of four from five cells 
  
     WorldNew[i]=stsum % Divider  ##... taken then modulo DIVIDER
   
  ##NOW THE MOST IMPORTANT - Swap the arrays
  '''assumed list of int'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp
 
  t+=1 ##The next generation/step/year


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)

