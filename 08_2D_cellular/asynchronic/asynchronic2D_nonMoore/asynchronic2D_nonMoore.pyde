## "Not too many neighbors": 
## Two-dimensional, Moore, asynchronous cellular automaton
##-##=================================================================================

'''constant int'''
Opt=3               ##How many neighbors allowed?
'''constant int'''
WorldSide=600       ##Side lenght of simulation world (square)
'''constant float'''
Dens=0.5            ##.01#Initial density in the lattice World
##final boolean withMoore=True  #TODO neighborhood with the corners of the square

'''assumed list of list of int'''
World=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##2 dimensional array <=> "matrix" or "lattice" 
                                            
FR=100  ##desired simulation speed

def setup(): # Any globals modified? NO, but...
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
  


def visualisation(): # Any globals modified? NO
  '''What is it doing below?''' 
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j" 
      #block:                       
      _switchvar=World[i][j]   #block:  
      if  _switchvar== 1:stroke(255,255,0)  ##Yellow
      elif _switchvar==0:stroke(0,0,0)
      else : stroke(255,0,0)  ##"emergency color" - RED
      
      ## Now color is chosen, so ready to plot a point.
      point(i,j)
    


t=0  ##< time is global!

def draw(): # Any globals modified? # YES
  global t
  '''What is it doing below?''' 
  visualisation()
  
  ## Monte Carlo step
  N=WorldSide*WorldSide
  for a in range(0,N,1): # loop over variable "a"
    #block: 
    ##Losowanie agenta 
    i=int(random(WorldSide))
    j=int(random(WorldSide))
     
    ##Rule: "Not too many neighbors" needs idexes of the neighborhood...
    right = (i+1) % WorldSide;      
    left  = (WorldSide+i-1) % WorldSide
    dw    = (j+1) % WorldSide;   
    up    = (WorldSide+j-1) % WorldSide
    
    ##Then sum of living neighbors...  
    sum =  World[left][j]
    + World[right][j]
    + World[i][up]
    + World[i][dw]  
    ## withMoore ? with corners?
    + World[left][up]
    + World[right][up]
    + World[left][dw]
    + World[right][dw] 
      ##= sum of states of neighbors (states 0 and 1 only)
    
    ##And final implementation of the rule comparing sum to the expected optimal.
    if sum==Opt :
       World[i][j]=1
    else :
       World[i][j]=0
  
      
  t+=1  ##next step
  textSize(20);textAlign(LEFT,TOP);text("ST:"+str(t),0,0)
   
  if t%10==0 : 
    print    frameRate, "fps"  


## https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
## @date 2024-11-26 (revived)
