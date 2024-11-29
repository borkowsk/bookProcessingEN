## "Not too many neighbors": 
## TWO-dimensional, SYNCHRONOUS, von Neumann, deterministic cellular automaton
##-##=============================================================================

'''constant int'''
Opt=1          ##Optimum number of neighbors required
'''constant int'''
WorldSide=601  ##How many cells do we want in one line?
'''constant float'''
Dens=0.001         ##.005#0.5 or so also posible

'''assumed list of list of int (inefficient!)'''
WorldOld=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##We need two worlds for the old  
'''assumed list of list of int (inefficient!)'''
WorldNew=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##and new state of the simulation

FR=200  ##Desired speed frame per second [fps]


def setup(): # Any globals modified?
  '''block:''' 
  size(601,601)     ##square window
  frameRate(FR);  
  noSmooth()
  
  if Dens>0 :
    '''block:''' 
    for i in range(0,WorldSide,1): # loop over variable "i" ##Initialisation
      for j in range(0,WorldSide,1): # loop over variable "j" 
        if random(1.0)<Dens :
          WorldOld[i][j]=1
  else : WorldOld[WorldSide/2][WorldSide/2]=1


def visualisation(): # Any globals modified?
  '''block:''' 
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j"   ## if(WorldOld[i][j]!=WorldNew[i][j]) ???
      '''block:''' 
      if WorldOld[i][j]>0 : stroke(255,0,100)
      else :           stroke(0)
      point(j,i) ##The horizontal dimension of the array 
                 ##is the SECOND index!


t=0  ## time is global


def draw(): # Any globals modified? #
  global t,WorldOld,WorldNew
  '''block:''' 
  visualisation()
  
  for i in range(0,WorldSide,1): # loop over variable "i"##Now the cellular automaton state change
       '''block:''' 
       ##RULE - Not too many von Neumann neighbors
       right = (i+1) % WorldSide;          
       left  = (WorldSide+i-1) % WorldSide
       
       for j in range(0,WorldSide,1): # loop over variable "j" 
         '''block:''' 
         dw=(j+1) % WorldSide;   
         up=(WorldSide+j-1) % WorldSide
         
         live =((1 if WorldOld[left][j]>0  else 0)
                 +  (1 if WorldOld[right][j]>0  else 0)
                 +  (1 if WorldOld[i][up]>0  else 0)
                 +  (1 if WorldOld[i][dw]>0  else 0)     
                 +  (1 if WorldOld[left][up]>0  else 0)
                 +  (1 if WorldOld[right][up]>0  else 0)
                 +  (1 if WorldOld[left][dw]>0  else 0)
                 +  (1 if WorldOld[right][dw]>0  else 0) 
                  )
      
         WorldNew[i][j]=(1 if live == Opt  else 0 ) ##New state 
   
  ##Swap the arrays
  '''assumed list of list of int (inefficient!)'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp
   
  t+=1  ##The next generation/step/year
  fill(random(255));textSize(20);textAlign(LEFT,TOP);text("ST:"+str(t),0,0)

##https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/

## @date 2024-11-29 (revived)
