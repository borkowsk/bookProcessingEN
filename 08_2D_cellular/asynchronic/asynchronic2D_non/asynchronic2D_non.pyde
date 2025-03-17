## "Not too many neighbors": 
## Two-dimensional, von Neuman, asynchronous cellular automaton.
##-##=============================================================

'''constant int'''
Opt=2          ##How many neighbors needed?
'''constant int'''
WorldSide=600  ##Side lenght of simulation world (square)
'''constant float'''
Dens=0.95    ##Initial density in the lattice World

'''assumed list of list of int (unefficient!)'''
World=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##2 dimensional array <=> "matrix" or "lattice" 
                                            
FR=100  ##desired simulation speed

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
    #end
  else :
    #block: 
    World[WorldSide/2][WorldSide/2]=1
    #end
  #end

def visualisation(): # Any globals modified?
  '''What is it doing below?''' 
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j" 
      #block:                       
      _switchvar=World[i][j]   #block:  
      if  _switchvar== 1:stroke(255,255,0);pass ##Yellow
      elif _switchvar==0:stroke(0,0,0);pass
      else : stroke(255,0,0)  ##"emergency color" - RED
      pass
        #end 
      point(i,j)  ##or j,i
      #end
  #end

t=0  ##< time is global.

def draw(): # Any globals modified? #
  global t,World
  '''What is it doing below?''' 
  visualisation()
  
  ## Monte Carlo step
  N=WorldSide*WorldSide
  for a in range(0,N,1): # loop over variable "a"
    #block: 
    ##drawing
    i=(int(random(WorldSide)))
    j=(int(random(WorldSide)))
     
    ##Rule: "Not too many neighbors"
    right = (i+1) % WorldSide;      
    left  = (WorldSide+i-1) % WorldSide
    dw=(j+1) % WorldSide;   
    up=(WorldSide+j-1) % WorldSide
     
    ##sum of living neighbors = sum of states of neighbors
    sum =  World[left][j] + World[right][j] + World[i][up] + World[i][dw]  ##(states 0 and 1 only)
    
    ##Implementation of the rule
    if sum==Opt :
       World[i][j]=1
    else :
       World[i][j]=0
    #end
      
  t+=1  ##next step
  textSize(20);textAlign(LEFT,TOP);text("ST:"+str(t),0,0)
  #end

## https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
## @date 2025-03-17 (revived)
