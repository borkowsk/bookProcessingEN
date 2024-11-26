## "sum of living neighbors modulo 3": 
## One-dimensional, SYNCHRONOUS, deterministic cellular automaton
##-##=======================================================================

'''constant int'''
WorldSize=500  ##How many cells do we want?
'''constant float'''
Dens=0.002     ##0.5 or so also posible

'''constant boolean'''
withMe=False   ##Own cell is taking to account.
'''constant boolean'''
withMore=True  ##More far cells are taking to account.

WorldOld=[0]*(WorldSize) ##We need two worlds for the old  
WorldNew=[0]*(WorldSize) ##and new state of the simulation

def setup(): # Any sideeffects on globals?
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
    if  _switchvar== 2:stroke(255,0,0) #"pass", in fact not needed :-)
    elif _switchvar==1:stroke(0,0,255)
    elif _switchvar==0:stroke(0,0,0)
    else : stroke(0,255,0)  ##It shouldn't appear!
    
    point(i,t)  ##current state
    line(i,999,i,994)  ##Reflect the current state at the bottom of the canvas

t=0  ##< is global!

def draw(): # Any sideeffects on globals? #
  global t,WorldOld,WorldNew
  '''What is purpose of this block below?''' 
  if t>994 : return
 
  visualisation()
  
  for i in range(0,WorldSize,1): # 'i' has int value##Now the cellular automaton state change
    #block: 
    ##RULE - sum of living neighbors (distance 2) modulo 3
    right = (i+1) % WorldSize;      
    left  = (WorldSize+i-1) % WorldSize
    morer = (i+2) % WorldSize  ##More right 
    morel = (WorldSize+i-2) % WorldSize ## More left
    howMany= 0 ##How many live neighbors?
   
    if WorldOld[left]>0 : ##It is not zero, so, it is "alive"
      howMany+=1
   
    if WorldOld[right]>0 : ##It is not zero, so, it is "alive"
      howMany+=1
    
    if withMore :
      #block: 
      if WorldOld[morel]>0 : ##It is not zero, so, it is "alive"
         howMany+=1
      if WorldOld[morer]>0 : ##It is not zero, so, it is "alive"
         howMany+=1; 
    ##What about me?
    if withMe and WorldOld[i]>0 : howMany+=1
    ##Now MODULO! We save the new state on the second array     
    WorldNew[i]=howMany % 3
   
  ##NOW THE MOST IMPORTANT - Swap the arrays
  '''assumed list of int'''
  WorldTmp=WorldOld
  WorldOld=WorldNew; WorldNew=WorldTmp
   
  t+=1 ##The next generation/step/year

## https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/
## @date 2024-11-26 (revived)
