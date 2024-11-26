## "sum of the states [of neighbors] modulo M": 
## One-dimensional, SYNCHRONOUS, deterministic cellular automaton.
##-##===============================================================

'''constant int'''
WorldSize=1000  ## How many cells do we want?
'''constant float'''
Dens=0.005      ## 0.5 or so also posible.

'''constant int'''
Divider=4       ## By how much we divide.
'''constant boolean'''
self=False      ## Do we include the middle cell?
'''constant boolean'''
far=True        ## Do we include the far cells?
'''constant boolean'''
alives=True     ## Do we summ alives cell? Othervise all states.

WorldOld=[0]*(WorldSize) ## We need two arrays for the old.
WorldNew=[0]*(WorldSize) ## and new state of the simulation.

def setup(): # Any sideeffects on globals? NO, but...
  '''What is purpose of this block below?''' 
  size(1000,1000); 
  frameRate(100)
  noSmooth()  ## CA look better without smooth.
  
  if Dens>0 :
    #block: 
   for i in range(0,len(WorldOld),1): # loop over "i"
    if random(1.0)<Dens :
      WorldOld[i]=int(random(3))
  else :
    #block: 
    WorldOld[WorldSize/2]=1

def visualisation(): # Any sideeffects on globals? NO
  '''What is purpose of this block below?''' 
  for i in range(0,len(WorldOld),1): # loop over "i"
    #block:  ##color selection
    _switchvar=WorldOld[i]   #block:  
    if  _switchvar== 6:stroke(0,255,255); 
    elif _switchvar==5:stroke(255,0,255); 
    elif _switchvar==4:stroke(255,255,0)
    elif _switchvar==3:stroke(0,255,0)
    elif _switchvar==2:stroke(255,0,0)
    elif _switchvar==1:stroke(0,0,255)
    elif _switchvar==0:stroke(0,0,0)
    ##case *:stroke(*,*,*); 
    else : stroke(255,255,255)  ## It shouldn't appear!
    
    ## current state as point
    point(i,t)   
    line(i,t,i,height)  ## & line to the bottom


def alive(state): # => int 
  '''What is purpose of this block below?''' 
  return (1  if state>0  else 0 )

t=0  ##< is global!

def draw(): # Any sideeffects on globals? # YES
  global t,WorldOld,WorldNew
  '''What is purpose of this block below?''' 
  if t>994 : return
  visualisation()

  for i in range(0,WorldSize,1): # loop over "i" ## Compute new state loop
    #block:  ## RULE: "sum of something modulo M" 
    ## self - Do we include the middle cell? 
    ## far - Do we include the far cells? 
    ## alives - Do we summ alives cells? Otherwise all states.
    right = (i+1) % WorldSize;      
    left  = (WorldSize+i-1) % WorldSize;       
    sum = 0; 
   
    if self : 
      sum+=(alive(WorldOld[i])  if alives  else WorldOld[i] )
   
    sum+=(alive(WorldOld[left])   if alives  else WorldOld[left] )
    sum+=(alive(WorldOld[right])  if alives  else WorldOld[right])
   
    if far :
      #block: 
      morer = (i+2) % WorldSize;    
      morel = (WorldSize+i-2) % WorldSize
      sum+=(alive(WorldOld[morel])  if alives  else WorldOld[morel] )
      sum+=(alive(WorldOld[morer])  if alives  else WorldOld[morer] );             
    ##... taken then modulo DIVIDER
    WorldNew[i]=sum % Divider; 
   
  ## NOW THE MOST IMPORTANT - Swap the worlds
  '''assumed list of int'''
  WorldTmp=WorldOld; WorldOld=WorldNew; WorldNew=WorldTmp
  ## The next generation/step/year
  t+=1; 


## https://github.com/borkowsk/bookProcessingEN
## https://github.com/borkowsk/bookProcessingEN/tree/main/07_1D_cellular/synchronic/
## @date 2024-11-26 (revived)
