## "sum of states modulo 3": 
## One-dimensional, SYNCHRONOUS, deterministic cellular automaton
##-##=========================================================================

'''constant int'''
WorldSize=500  ##How many cells do we want?
'''constant float'''
Dens=0.015     ##0.5 or so also posible

'''constant boolean'''
withMe=True  ##self awareness - what about own state of cell in new state calculation?

WorldOld=[0]*(WorldSize) ##We need two arrays/lists for the old  
WorldNew=[0]*(WorldSize) ##and new state of the simulation

def setup(): # Any sideeffects on globals? NO
  '''What is purpose of this block below?''' 
  size(500,1000); 
  frameRate(100)
  noSmooth()  ##CA look better without smooth
  
  if Dens>0 :
    #block: 
   for i in range(0,WorldSize,1): # 'i' has int value
    if random(1.0)<Dens :
      WorldOld[i]=1
  else :
    #block: 
    WorldOld[WorldSize/2]=1

def visualisation(): # Any sideeffects on globals?
  '''What is purpose of this block below?''' 
  for i in range(0,WorldSize,1): # 'i' has int value
    #block:  ## The selection instruction allows us 
    ## to choose any color depending on the number in the cell
    _switchvar=WorldOld[i]   #block:  
    if  _switchvar== 2:stroke(255,0,0);pass
    elif _switchvar==1:stroke(0,0,255);pass
    elif _switchvar==0:stroke(0,0,0);pass
    else : stroke(0,255,0)  ##It shouldn't appear!
    pass
    point(i,t)  ##current state
    line(i,999,i,994)  ##Reflect the current state at the bottom of the canvas

t=0  ##< GLOBAl!

def draw(): # Any sideeffects on globals? # YES
  global t,WorldOld,WorldNew
  '''What is purpose of this block below?''' 
  if t>994 : return
  visualisation()
  
  for i in range(0,WorldSize,1): # 'i' has int value ##Now the cellular automaton state change
     #block: 
     ## "Rule - "SUM YOUR STATE WITH YOUR NEIGHBORS AND TAKE MODULO 3"
     right = (i+1) % WorldSize;      
     left  = (WorldSize+i-1) % WorldSize
     sum = 0
     
     if withMe : 
       sum+=WorldOld[i]
       
     sum+=WorldOld[left]
     sum+=WorldOld[right]
       
     WorldNew[i]=sum % 3 ##We save the new state on the second array
   
  ##NOW THE MOST IMPORTANT - Swap the arrays
  '''assumed list of int'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp
 
  t+=1  ##The next generation/step/year


 
## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)

