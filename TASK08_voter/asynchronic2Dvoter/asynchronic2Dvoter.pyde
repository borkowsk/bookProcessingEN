## "Voter model" <=> "Nearest Neighbors Social Impact"
## Two-dimensional, asynchronous cellular automaton
##-##=================================================================================

'''constant int'''
WorldSide=600   #Side lenght of simulation world (square)
'''constant double'''
Dens=0.50       #.01;##Initial density in the lattice World
'''constant boolean'''
withMoore=True  #neighborhood with the corners of the square

FR=1  #desired simulation speed

'''assumed list of list of int (inefficient!)'''
World=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  #2 dimensional array
                                            
def setup(): # Any globals modified?
  '''block:'''
  size(600,620)  #squre canvas
  noSmooth()     #much faster drawing
  frameRate(FR)
  initialisation()  #Initial state of the model

t=0  # time is global

def draw(): # Any globals modified? 
  global t
  '''block:'''
  visualisation()
  stepMonteCarlo()  #or other
  status();    
  t+=1  #next step

def initialisation(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" 
    for j in range(0,WorldSide,1): # loop over variable "j" 
      if random(1.0)<Dens :
        World[i][j]=1

def visualisation(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j" 
      '''block:'''                      
      _switchvar=World[i][j]  
      if  _switchvar== 1:stroke(255,255,0)  #Yellow
      elif _switchvar==0:stroke(0,0,0)
      else : stroke(255,0,0)  #"emergency color" - RED
      
      point(i,j)

def stepMonteCarlo(): # Any globals modified?  # Monte Carlo step
  '''block:'''
  '''constant int'''
  N=WorldSide*WorldSide
  for a in range(0,N,1): # loop over variable "a"
    '''block:''' ''' RULE: You assume a state more common in your vicinity '''
    i= int(random(WorldSide)); j= int(random(WorldSide))
    right= (i+1) % WorldSide; left= (WorldSide+i-1) % WorldSide
    dw= (j+1) % WorldSide; up= (WorldSide+j-1) % WorldSide
    cou0=0; cou1=0  #counters of 0 & 1 state neighbors
     
    if World[left][j]==0  : cou0+=1; 
    else : cou1+=1
    if World[right][j]==0 : cou0+=1; 
    else : cou1+=1
    if World[i][up]==0 : cou0+=1; 
    else : cou1+=1
    if World[i][dw]==0 : cou0+=1; 
    else : cou1+=1; 
     
    if withMoore :
      '''block:'''
      if World[left][up]==0 : cou0+=1; 
      else : cou1+=1
      if World[right][up]==0 : cou0+=1; 
      else : cou1+=1
      if World[left][dw]==0 : cou0+=1; 
      else : cou1+=1
      if World[right][dw]==0 : cou0+=1; 
      else : cou1+=1; 
     
    if World[i][j]==0 : cou0+=1; 
    else : cou1+=1  #Central cell
     
    if cou0>cou1 : World[i][j]=0
    else : World[i][j]=1

def status(): # Any globals modified?
  '''block:'''
  fill(128);noStroke();rect(0,height,width,-20)
  fill(random(255),random(255),random(255))
  textSize(18);textAlign(LEFT,BOTTOM)
  text("ST:"+str(t)+"("+nf(frameRate,3,2)+")",0,height)


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN/)

