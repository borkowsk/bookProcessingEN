## Rule: "Min=Best:1 Max:2 neig.". 
## Two-dimensional, von Neuman, asynchronous cellular automaton.
##-##============================================================

'''constant int'''
WorldSide=600         ##Side lenght of simulation world (square)
'''constant float'''
Dens=0.0              ##.1#Initial density in the lattice World

'''assumed list of list of int (unefficient!)'''
World=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##2 dimensional array <=> "matrix" or "lattice" 

FR=50  ##desired simulation speed
                                                                                      
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
  #END
  else :
    #block: 
    World[WorldSide/2][WorldSide/2]=1
    World[WorldSide/2+1][WorldSide/2]=1
  #END
#END

def visualisation(): # Any globals modified?
  '''What is it doing below?''' 
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j" 
      #block:                       
      _switchvar=World[i][j]   #block:  
      if  _switchvar== 1:stroke(255,255,0);pass
      elif _switchvar==0:stroke(0,0,0);pass
      else : stroke(255,0,0);pass ##"emergency color"
      #END 
      point(i,j)
    #END
#END

t=0  ##< Time counter is global.

def draw(): # Any globals modified? #
  global t
  '''What is it doing below?''' 
  visualisation()
  
  ## Monte Carlo step
  N=WorldSide*WorldSide
  for a in range(0,N,1): # loop over variable "a"
    #block: 
    ##draw the agent's indexes...
    i=int(random(WorldSide))
    j=int(random(WorldSide))

    ##Rule: "as you see!"
    right = (i+1) % WorldSide;      
    left  = (WorldSide+i-1) % WorldSide
    dw    = (j+1) % WorldSide;   
    up    = (WorldSide+j-1) % WorldSide
     
    sum = World[left][j] + World[right][j] + World[i][up] + World[i][dw]  ##sum of living neighbors = sum of states of neighbors (states 0 and 1 only)
    #print sum,' ',

    ##Implementation of the rule
    if World[i][j]==0 : ##Empty central cell
      #block: 
      if sum==1 : ##Become...
         World[i][j]=1  ##Become...
      #END
    else :
      #block: 
      if sum>2 : ##Central cell dies
         World[i][j]=0
      #END 
  #END
      
  t+=1  ##next step
  textSize(20);textAlign(LEFT,TOP);text("ST:"+str(t),0,0)
  if t==100 : ##After hundred steps...
      print   frameRate,"fps" 
#END

##https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
## @date 2024-11-26 (revived)
