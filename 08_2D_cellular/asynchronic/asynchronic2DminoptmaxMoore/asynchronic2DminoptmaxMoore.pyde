## Rule: "Min:1 Best:2 Max:2 or 3 neighbors". 
## Two-dimensional, Moore, asynchronous cellular automaton
##-##============================================================================

'''constant int'''
MinN=1  ##Minimal number of neighbors allowed
'''constant int'''
OptN=1  ##Number of neighbors needed to reproduce
'''constant int'''
MaxN=2  ##Maximal number of neighbors allowed

'''constant int'''
WorldSide=600  ##Side lenght of simulation world (is square)
'''constant float'''
Dens=0.001  ##.1#Initial density in the lattice World

'''assumed list of list of int (inefficient!)'''
World=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##2 dimensional world <=> "matrix" or "lattice" or "2D array"
                                            
FR=30 ##desired simulation speed

def setup(): # Any globals modified?
  '''What is it doing below?''' 
  size(600,600)  ##squre canvas
  noSmooth()     ##much faster drawing
  frameRate(FR)
    
  if Dens>0 : ##initialisation
   #block: 
   for i in range(0,WorldSide,1): # loop over variable "i" 
     for j in range(0,WorldSide,1): # loop over variable "j" 
       if random(1.0)<Dens :
         World[i][j]=1
  
  else :
    #block: 
    World[WorldSide/2][WorldSide/2]=1
    World[WorldSide/2+1][WorldSide/2]=1
  


def visualisation(): # Any globals modified?
  '''What is it doing below?''' 
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j" 
      #block:                       
      _switchvar=World[i][j]   #block:  
      if  _switchvar== 1:stroke(255,255,0);pass
      elif _switchvar==0:stroke(0,0,0);pass
      else : stroke(255,0,0) ##"emergency color"
      pass
       
      point(i,j)
    


t=0  ##< Time is global.
  
def draw(): # Any globals modified? #
  global t
  '''What is it doing below?''' 
  visualisation()
  
  ## Monte Carlo step
  N=WorldSide*WorldSide
  for a in range(0,N,1): # loop over variable "a"
    #block: 
    ##draw the agent's indexes
    i=int(random(WorldSide))
    j=int(random(WorldSide))
     
    ##Rule: "Min-Best-Max neighbors"
    right = (i+1) % WorldSide;      
    left  = (WorldSide+i-1) % WorldSide
    dw=(j+1) % WorldSide;   
    up=(WorldSide+j-1) % WorldSide
     
    sum = (  # In Python we need brackets, when a mathematical expression takes up more than one line
          World[left][j]
        + World[right][j]
        + World[i][up]
        + World[i][dw]        
        ## corners:
        + World[left][up]
        + World[right][up]
        + World[left][dw]
        + World[right][dw]  
          ) ##sum of living neighbors = sum of states of neighbors (states 0 and 1 only)
    
    ##Implementation of the rule
    if World[i][j]==0 : ##Empty central cell
      #block: 
      if sum==OptN : ##Become... 
         World[i][j]=1  ##Become...
    
    else : ##Central cell dies of loneliness or over-density
      if sum<MinN or MaxN<sum :
         World[i][j]=0
  
  ##step counting:    
  t+=1
  textSize(20);textAlign(LEFT,TOP);text("ST:"+str(t),0,0)


##https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
## @date 2024-11-29 (revived)
