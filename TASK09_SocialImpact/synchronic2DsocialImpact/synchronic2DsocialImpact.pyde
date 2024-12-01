## "Cellular Nowak-Latane Social Impact" <=> "Nearest Neighb. Social Impact with strenght"
## Two-dimensional, synchronous cellular automaton
##*##=======================================================================================

'''constant int'''
WorldSide=600     #Side lenght of simulation world (square)
'''constant double'''
Dens=0.50         #.01;##Initial density in the lattice World
'''constant boolean'''
withMoore=True    #neighborhood with the corners of the square
'''constant int'''
MaxStrength=100

FR=20  #desired simulation speed

'''assumed list of list of int (inefficient!)'''
Strength=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  #cogency/credibility

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

t=0  # is global

def draw(): # Any globals modified? 
  global t
  '''block:'''
  visualisation2()
  status(); 
  syncStep(); 
  t+=1  #next step

def initialisation(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2 
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2 
      '''block:'''
      if random(1.0)<Dens :
        '''block:'''
        WorldOld[i][j]=1
      WorldNew[i][j]=-1
      Strength[i][j]=(int)(random(MaxStrength))

def visualisation1(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2 
      '''block:'''                      
      _switchvar=WorldOld[i][j]   
      if  _switchvar== 1:
        stroke(255, 255, 0)  #Yellow
         
      elif _switchvar==0:
        stroke(0, 0, 0)  #black
        
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
          stroke(255, 0, 0)          #"emergency color" - RED
          
        point(i, j)

def syncStep(): # Any globals modified? 
  global WorldOld,WorldNew 
  '''block:''' #Synchronous step a la classic CA.
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2
    '''block:''' # RULE: you assume a state more common in your vicinity
    right = (i+1) % WorldSide; left  = (WorldSide+i-1) % WorldSide;      

    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2
      '''block:'''
      dw=(j+1) % WorldSide; up=(WorldSide+j-1) % WorldSide;   
      sum0  = 0  #sum of 0 strenght of neighbors
      sum1  = 0  #sum of 1 strenght of neighbors

      if WorldOld[left][j]==0  : sum0+=Strength[left][j]; 
      else : sum1+=Strength[left][j]
      if WorldOld[right][j]==0 : sum0+=Strength[right][j]; 
      else : sum1+=Strength[right][j]
      if WorldOld[i][up]==0 : sum0+=Strength[i][up]; 
      else : sum1+=Strength[i][up]
      if WorldOld[i][dw]==0 : sum0+=Strength[i][dw]; 
      else : sum1+=Strength[i][dw]

      if withMoore :
        '''block:'''
        if WorldOld[left][up]==0 : sum0+=Strength[left][up]; 
        else : sum1+=Strength[left][up]
        if WorldOld[right][up]==0 : sum0+=Strength[right][up]; 
        else : sum1+=Strength[right][up]
        if WorldOld[left][dw]==0 : sum0+=Strength[left][dw]; 
        else : sum1+=Strength[left][dw]
        if WorldOld[right][dw]==0 : sum0+=Strength[right][dw]; 
        else : sum1+=Strength[right][dw]

      if WorldOld[i][j]==0 : sum0+=Strength[i][j]  #SELF INFLUENCE
      else : sum1+=Strength[i][j]

      if sum0!=sum1 : #What about equal? 
        '''block:'''
        if sum0>sum1 : WorldNew[i][j]=0  #WITHOUT OUTSIDE if WE HAVE SMALL BIAS HERE!
        else : WorldNew[i][j]=1

  # Swap the arrays
  '''assumed list of list of int (inefficient!)'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp

def status(): # Any globals modified?
  '''block:'''
  fill(random(128))
  noStroke()
  rect(0, height, width, -20)
  fill(random(255))
  textSize(18)
  textAlign(LEFT, BOTTOM)
  text("ST:"+str(t)+"("+nf(frameRate,0, 2)+")", 0, height)


##@date 2024 https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
