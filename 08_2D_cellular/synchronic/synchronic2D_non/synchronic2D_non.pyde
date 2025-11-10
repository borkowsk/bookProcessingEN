## "Not too many neighbors": 
## TWO-dimensional, SYNCHRONOUS, von Neumann, deterministic cellular automaton
##-##=============================================================================

'''constant int'''
WorldSide=601  ##How many cells do we want in one line?
'''constant float'''
Dens=0.15      ##0.5 or so also posible
'''constant int'''
optN=2         ##Optimum number of neighbors required

'''assumed list of list of int (inefficient!)'''
WorldOld=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##We need two "worlds" for the old  
'''assumed list of list of int (inefficient!)'''
WorldNew=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##and new state of the simulation

def setup(): # Any globals modified?
  '''block:''' 
  size(601,601)     ##square window
  frameRate(20);  
  noSmooth()
  
  for i in range(0,WorldSide,1): # loop over variable "i" ##Initialisation
    for j in range(0,WorldSide,1): # loop over variable "j" 
      if random(1.0)<Dens :
        WorldOld[i][j]=1;     


def visualisation(): # Any globals modified?
  '''block:''' 
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j"
      '''block:''' 
      if WorldOld[i][j]>0 : stroke(255,0,100)
      else :           stroke(0)
      point(j,i) ##the horizontal dimension of the array is the SECOND index
    


t=0  ##< time is global

def draw(): # Any globals modified? #
  global t, WorldOld, WorldNew
  '''block:''' 
  visualisation()
  
  for i in range(0,WorldSide,1): # loop over variable "i" ##Now the cellular automaton state change
    '''block:''' 
    ##RULE - Not too many neighbors
    right = (i+1) % WorldSide;          
    left  = (WorldSide+i-1) % WorldSide
     
    for j in range(0,WorldSide,1): # loop over variable "j" 
      '''block:''' 
      dw=(j+1) % WorldSide;   
      up=(WorldSide+j-1) % WorldSide
     
      live = (
                 (1 if WorldOld[left][j]>0  else 0) 
               + (1 if WorldOld[right][j]>0  else 0)
               + (1 if WorldOld[i][up]>0  else 0) 
               + (1 if WorldOld[i][dw]>0  else 0)             
               )
      WorldNew[i][j]=(1 if live == optN  else 0 )  ##New state 
   
  
   
  ##Swap the arrays
  '''assumed list of list of int (inefficient!)'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp
   
  t+=1 ##The next generation/step/year


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/)
