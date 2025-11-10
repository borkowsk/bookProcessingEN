## "Voter model" <=> "Nearest Neighbors Social Impact".
## Two-dimensional, synchronous cellular automaton.
##-##=================================================================================

'''constant int'''
WorldSide=600    #Side lenght of simulation world (square)
'''constant double'''
Dens=0.50        #.01;##Initial density in the lattice World
'''constant boolean'''
withMoore=True   #neighborhood with the corners of the square

FR=1  #desired simulation speed

'''assumed list of list of int (inefficient!)'''
WorldOld=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]
'''assumed list of list of int (inefficient!)'''
WorldNew=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]

def setup(): # Any globals modified?
  '''block:'''
  size(600,620)  #squre canvas
  noSmooth()     #much faster drawing
  frameRate(FR)
  initialisation()  #Initial state of the model

t=0  # time is global.

def draw(): # Any globals modified? YES
  global t
  '''block:'''
  visualisation2()
  syncStep()
  status();    
  t+=1  #next step

def initialisation(): # Any globals modified? NO, content of lists only.
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" 
    for j in range(0,WorldSide,1): # loop over variable "j" 
      '''block:'''
      if random(1.0)<Dens :
        WorldOld[i][j]=1
      WorldNew[i][j]=-1;  

def visualisation(): # Any globals modified? NO
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j" 
      '''block:'''                      
      _switchvar=WorldOld[i][j]  
      if  _switchvar== 1:stroke(255,255,0)  #Yellow
      elif _switchvar==0:stroke(0,0,0)      #Black
      else : stroke(255,0,0)        #"emergency color" - RED
      
      point(i,j)

def visualisation2(): # Any globals modified? NO
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j"
      if WorldOld[i][j] != WorldNew[i][j] : # Only WHEN changed!
        '''block:'''                      
        _switchvar=WorldOld[i][j]  
        if  _switchvar== 1:stroke((100+t*10)%256,(100+t*10)%256,0)  #yellow shades
        elif _switchvar==0:stroke(0,0,(100+t*10)%256)  #blue shades
        else : stroke(255,0,0)                 #"emergency color" - RED
        
        point(i,j)

## Synchronous step a la classic CA
def syncStep(): # Any globals modified? YES
  global WorldOld,WorldNew
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i"
    '''block:'''  # RULE: you assume a state more common in your vicinity
    right = (i+1) % WorldSide; left  = (WorldSide+i-1) % WorldSide;      

    for j in range(0,WorldSide,1): # loop over variable "j"
      '''block:'''
      dw=(j+1) % WorldSide; up=(WorldSide+j-1) % WorldSide;   
      cou0  = 0  #counter of 0 state neighbors
      cou1  = 0  #counter of 1 state neighbors
     
      if WorldOld[left][j]==0  : cou0+=1; 
      else : cou1+=1
      if WorldOld[right][j]==0 : cou0+=1; 
      else : cou1+=1
      if WorldOld[i][up]==0 : cou0+=1; 
      else : cou1+=1
      if WorldOld[i][dw]==0 : cou0+=1; 
      else : cou1+=1
     
      if withMoore :
        '''block:'''
        if WorldOld[left][up]==0 : cou0+=1; 
        else : cou1+=1
        if WorldOld[right][up]==0 : cou0+=1; 
        else : cou1+=1
        if WorldOld[left][dw]==0 : cou0+=1; 
        else : cou1+=1
        if WorldOld[right][dw]==0 : cou0+=1; 
        else : cou1+=1; 
     
      if WorldOld[i][j]==0 : cou0+=1; 
      else : cou1+=1
     
      if cou0>cou1 : WorldNew[i][j]=0
      else : WorldNew[i][j]=1
   
  # Swap the arrays
  '''assumed list of list of int (inefficient!)'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp; 

def status(): # Any globals modified? NO
  '''block:'''
  fill(128);noStroke();rect(0,height,width,-20)
  fill(random(255),random(255),random(255))
  textSize(18);textAlign(LEFT,BOTTOM)
  text("ST:"+str(t)+"("+nf(frameRate,3,2)+")",0,height)


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/)

