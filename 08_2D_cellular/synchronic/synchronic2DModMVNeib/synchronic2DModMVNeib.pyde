## "Modulo from neighbors states"
## TWO-dimensional, SYNCHRONOUS, vonNeuman/Moore, deterministic cellular automaton
##-##===============================================================================

'''constant int'''
WorldSide=602    ##How many cells do we want in one line?
'''constant int'''
FR = 10          ##Desired fps.
'''constant float'''
Dens=0           ##.001; #0.5 or so also posible.

'''constant int'''
Div=7            ##Divider for remainder operation.
'''constant boolean'''
vonNeuman=False  ##With or without von Neumann neighbors.
'''constant boolean'''
withMoore=True   ##With or without Moore neighbors.
'''constant boolean'''
withMe=True      ##False or True

'''assumed list of list of int (inefficient!)'''
WorldOld=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##We need two arrays for the old  .
'''assumed list of list of int (inefficient!)'''
WorldNew=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  ##and new state of the simulation.

'''constant boolean'''
traceVA=False  ##virgin areas trace ON/OFF.


def setup(): # Any globals modified?
  '''block:'''
  size(601,621)     ##square window
  frameRate(FR);  
  noSmooth()
  
  initialisation()


def initialisation(): # Any globals modified? ##< set up the world
  '''block:'''
  if Dens>0 :
    '''block:'''
    for i in range(0,len(WorldOld),1): # loop over variable "i" 
      for j in range(0,len(WorldOld),1): # loop over variable "j" 
        '''block:'''
        if not traceVA  : 
          WorldNew[i][j]=-1  ##Something different from any possible state
        
        if random(1.0)<Dens :
          WorldOld[i][j]=int(random(Div))
        else :
          WorldOld[i][j]=0
  else :
    '''block:'''
    if not traceVA  :
      for i in range(0,len(WorldOld),1): # loop over variable "i"
        for j in range(0,len(WorldOld),1): # loop over variable "j" 
          WorldNew[i][j]=-1 ##Something different from any possible state
        
    WorldOld[len(WorldOld)/2][len(WorldOld)/2]=1


def visualisation(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i"
    for j in range(0,WorldSide,1): # loop over variable "j"
      ##Print only when changed!!!
      if WorldOld[i][j] != WorldNew[i][j]  : ##WorldNew have step-1 content after swap 
        '''block:'''
        _switchvar=WorldOld[i][j]  
        if  _switchvar== 6:stroke(128,255,255)
        elif _switchvar==5:stroke(128,128,255)
        elif _switchvar==4:stroke(0,128,0)
        elif _switchvar==3:stroke(128,128,0)
        elif _switchvar==2:stroke(255,0,0)
        elif _switchvar==1:stroke(0,0,255)
        elif _switchvar==0:stroke(0,0,0)
        else : stroke(255,255,255)  ##emergency color
        ##case N:stroke( , , )  #for more colors
        
        
        point(i,j)  ##or j,i ?

t=0

def draw(): # Any globals modified? #
  global t,WorldOld,WorldNew
  '''block:'''
  visualisation()
  
  for i in range(0,WorldSide,1): # loop over variable "i" ##Now the cellular automaton state change
    '''block:'''
    ##RULE - modulo from states
    right = (i+1) % WorldSide;          
    left  = (WorldSide+i-1) % WorldSide
     
    for j in range(0,WorldSide,1): # loop over variable "j" 
      '''block:'''
      dw=(j+1) % WorldSide;   
      up=(WorldSide+j-1) % WorldSide
      
      states=(WorldOld[i][j]  if withMe  else 0)  ##Self
      
      if vonNeuman :
        states +=( ## von Neumann
               +  WorldOld[left][j]
               +  WorldOld[right][j]
               +  WorldOld[i][up]
               +  WorldOld[i][dw] )
              
      if withMoore  :
        states +=( WorldOld[left][up]
               +  WorldOld[right][up]
               +  WorldOld[left][dw]
               +  WorldOld[right][dw] )
    
      WorldNew[i][j]=states % Div   ##New state 
   
  ##Swap the arrays:
  '''assumed list of list of int (inefficient!)'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp
   
  t+=1  ##The next generation/step/year
  textSize(18)
  fill(128);noStroke();             rect(0,height-20,width,20)
  fill(255);textAlign(LEFT,BOTTOM); text(str(t)+"("+str(frameRate)+")",0,height)

##https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/
## @date 2024-11-29 (revived)
