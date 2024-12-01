## "Extended Moore Nowak-Latane Social Impact".
## Two-dimensional, synchronous cellular automaton with extended Moore neib.
##*##========================================================================
'''constant int'''
WorldSide=600     #Side lenght of simulation world (square)
'''constant double'''
Dens=0.40         #.01;##Initial density in the lattice World
'''constant boolean'''
withMoore=True    #neighborhood with the corners of the square
'''constant int'''
MaxStrength=100
'''constant int'''
MooreRad=2        #Radius of extended Moore neib.
'''constant double'''
Noise=0.001

FR=100  #desired simulation speed

'''assumed list of list of int (inefficient!)'''
Strength=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  #cogency

'''assumed list of list of int (inefficient!)'''
WorldOld=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  #Current attitude
'''assumed list of list of int (inefficient!)'''
WorldNew=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  #New or previous attitude

def setup(): # Any globals modified?
  '''block:'''
  size(600, 620)  #squre canvas
  noSmooth()     #much faster drawing
  frameRate(FR)
  initialisation()  #Initial state of the model

t=0
def draw(): # Any globals modified? 
  global t
  '''block:'''
  visualisation3()
  status();  
  addNoise()
  syncStep();  
  t+=1  #next step

def initialisation(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2 
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2 
      '''block:'''
      if random(1.0)<Dens :
        WorldOld[i][j]=1

      WorldNew[i][j]=-1
      Strength[i][j]=(int)(random(MaxStrength))

def addNoise(): # Any globals modified?
  '''block:'''
  N=int(WorldSide*WorldSide*Noise)
  for a in range(0,N,1): # loop over variable "a" Patt#2
    '''block:'''
    i=int(random(WorldSide))
    j=int(random(WorldSide))
    if WorldOld[i][j]==0 : WorldOld[i][j]=1
    else :  WorldOld[i][j]=0

def visualisation1(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2 
      '''block:'''                      
      _switchvar=WorldOld[i][j]   
      if  _switchvar== 1:
        stroke(255, 255, 0)  #Yellow
        
      elif _switchvar==0:
        stroke(0, 0, 0)  #Black (empty)
             
      else : 
        stroke(255, 0, 0)  #"emergency color" - RED
        
      point(i, j)

def visualisation2(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2
      if WorldOld[i][j] != WorldNew[i][j] :
        '''block:'''                      
        _switchvar=WorldOld[i][j]   
        if  _switchvar== 1:
          stroke((100+t*10)%256, (100+t*10)%256, 0)  #yellow shades
          
        elif _switchvar==0:
          stroke(0, 0, (100+t*10)%256)  #blue shades
                       
        else : 
          stroke(255, 0, 0)  #"emergency color" - RED
          
        point(i, j)

def visualisation3(): # Any globals modified?
  '''block:'''
  mult=255.0/MaxStrength

  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2
      if WorldOld[i][j] != WorldNew[i][j] :
        '''block:'''                      
        stre=mult*Strength[i][j]  #print(stre+" ")
        _switchvar=WorldOld[i][j]   
        if  _switchvar== 1:
          stroke(stre, 0, stre)  #magenta shades
           
        elif _switchvar==0:
          stroke(0, stre, stre)  #cyan shades
           
        else : 
          stroke(255, 0, 0)     #"emergency color" - RED
          
        point(i, j)

def syncStep(): # Any globals modified? 
  global WorldNew,WorldOld #Synchronous step a la classic CA
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2
    '''block:'''    # RULE: you assume a state more common in your vicinity    
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2
      '''block:'''  
      sum0  = 0; sum1  = 0  #sums of strenght "points"

      for k in range(i-MooreRad,i+MooreRad+1,1): # loop over variable "k" Patt#8
        for m in range(j-MooreRad,j+MooreRad+1,1): # loop over variable "m" Patt#8
          '''block:'''
          K=(WorldSide+k)%WorldSide  #Implement TORUS
          M=(WorldSide+m)%WorldSide  #calculation

          if WorldOld[K][M]==0  : 
            sum0+=Strength[K][M]; 
          else : 
            sum1+=Strength[K][M]

      if sum0>sum1 : 
        WorldNew[i][j]=0
      else : 
        WorldNew[i][j]=1

  #Swap the arrays
  '''assumed list of list of int (inefficient!)'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp

def status(): # Any globals modified?
  '''block:'''
  fill(128)
  noStroke()
  rect(0, height, width, -20)
  fill(255);  
  textSize(18)
  textAlign(LEFT, BOTTOM)
  text("ST:"+str(t)+"("+nf(frameRate, 0, 2)+")", 0, height)


## @date (https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/synchronic)