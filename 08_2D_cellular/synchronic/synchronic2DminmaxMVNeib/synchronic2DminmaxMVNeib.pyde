## "Min Max neighbors": Not too many neighbors, but not too few.
## TWO-dimensional, SYNCHRONOUS, vonNeuman/Moore, deterministic cellular automaton.
##-##===============================================================================

'''constant int'''
WorldSide=601    ##How many cells do we want in one line?
'''constant int'''
FM = 100         ## Desired computation rate [fps].

'''constant float'''
Dens=0.86        ##0.5, 0.75 or so are also posible.
'''constant int'''
MinN=3           ##Minimal number of neighbors required.
'''constant int'''
MaxN=4           ##Maximal number of neighbors required.

'''constant boolean'''
withMoore=False  ##With or without Moore neighbors

'''assumed list of list of int (inefficient!)'''
WorldOld=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##We need two arrays for the old  
'''assumed list of list of int (inefficient!)'''
WorldNew=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##and new state of the simulation
  

def setup(): # Any globals modified?
  '''block:''' 
  size(601,601)     ##square window
  frameRate(FM);  
  noSmooth()
  
  for i in range(0,WorldSide,1): # loop over variable "i" ##Initialisation
    for j in range(0,WorldSide,1): # loop over variable "j" 
      if random(1.0)<Dens :
        WorldOld[i][j]=1

def visualisation(): # Any globals modified?
  '''block:''' 
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j"
      '''block:''' 
      if WorldOld[i][j]>0 : stroke(255,0,100)
      else :           stroke(0)
      point(j,i)  ##the horizontal dimension of the array is the SECOND index



t=0  ##< time is global

def draw(): # Any globals modified? #
  global t, WorldNew, WorldOld
  '''block:''' 
  visualisation()
  
  for i in range(0,WorldSide,1): # loop over variable "i" ##Now the cellular automaton state change
    '''block:''' 
    ##RULE - Not too many neighbors, but not too few
    right = (i+1) % WorldSide;          
    left  = (WorldSide+i-1) % WorldSide
     
    for j in range(0,WorldSide,1): # loop over variable "j" 
      '''block:''' 
      dw=(j+1) % WorldSide;   
      up=(WorldSide+j-1) % WorldSide
      
      live = ( WorldOld[left][j] + WorldOld[right][j] + WorldOld[i][up] + WorldOld[i][dw]  ## Von Neumann neighbours
               + (WorldOld[left][up] + WorldOld[right][up] + WorldOld[left][dw] + WorldOld[right][dw]  if withMoore  else 0 ) ## Moore neighbours
               )
     
      WorldNew[i][j]=(1 if MinN <= live and live <=MaxN  else 0 )  ##New state 
   
  ##Swap the arrays
  '''assumed list of list of int (inefficient!)'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp
   
  t+=1  ##The next generation/step/year
  textSize(20); textAlign(LEFT,TOP); text("ST:"+str(t),0,0)

## https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/
## @date 2024-11-29 (revived)
