## "Extended Moore Nowak-Latane Social Impact" with noise & bias for 1
## Two-dimensional, asynchronous cellular automaton with extended Moore neib.
##*##=======================================================================================

'''constant int'''
WorldSide=300   #Side lenght of simulation world (square)
'''constant double'''
Dens=0.20  #.01;##Initial density of 1 in the Attitude
'''constant int'''
MaxStrength=100

'''constant int'''
Bias=10     #Bias for 1
'''constant double'''
Noise=0.05  #Ratio of random swithes of attitudes
'''constant int'''
MooreRad=1  #Radius of extended Moore neib.


FR=100  #desired simulation speed

'''assumed list of list of int (inefficient!)'''
Strength=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  #cogency

'''assumed list of list of int (inefficient!)'''
Attitude=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  #Current attitude

def setup(): # Any globals modified?
  '''block:'''
  size(300,320)  #squre canvas
  noSmooth()     #much faster drawing
  frameRate(FR)
  initialisation()  #Initial state of the model

t=0         # is global
Adopted=0   # is global

def draw(): # Any globals modified? 
  global t
  '''block:'''
  visualisation3()
  status();  
  addNoise()
  asyncStep();  
  t+=1  #next step

def initialisation(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2 
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2 
      '''block:'''
      if random(1.0)<Dens :
        Attitude[i][j]=1
       
      Strength[i][j]=int(random(MaxStrength))

def addNoise(): # Any globals modified?
  '''block:'''
  N=int(WorldSide*WorldSide*Noise)
  for a in range(0,N,1): # loop over variable "a" Patt#2
    '''block:'''
    i=int(random(WorldSide))
    j=int(random(WorldSide))
    if Attitude[i][j]==0 : Attitude[i][j]=1; 
    else :  Attitude[i][j]=0

def visualisation1(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2 
      '''block:'''                      
      _switchvar=Attitude[i][j]  
      if  _switchvar== 1:stroke(255,255,0)  #Yellow
      elif _switchvar==0:stroke(0,0,0)
      else : stroke(255,0,0)  #"emergency color" - RED
      
    point(i,j)

def visualisation2(): # Any globals modified?
  '''block:'''
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2
      '''block:'''                      
      _switchvar=Attitude[i][j]  
      if  _switchvar== 1:stroke((100+t*10)%256,(100+t*10)%256,0)  #yellow shades
      elif _switchvar==0:stroke(0,0,(100+t*10)%256)  #blue shades
      else : stroke(255,0,0)  #"emergency color" - RED
      
      point(i,j)

def visualisation3(): # Any globals modified? 
  global Adopted
  '''block:'''
  mult=255.0/MaxStrength
  Adopted=0  #Simplest statistics
  for i in range(0,WorldSide,1): # loop over variable "i" Patt#2
    for j in range(0,WorldSide,1): # loop over variable "j" Patt#2
      '''block:'''                      
      stre=mult*Strength[i][j]  #print(stre+" ")
      _switchvar=Attitude[i][j]  
      if  _switchvar== 1:stroke(stre,0,stre);Adopted+=1  #magenta shades
      elif _switchvar==0:stroke(0,stre,stre)  #cyan shades
      else : stroke(255,0,0)  #"emergency color" - RED
      
      point(i,j)

def asyncStep(): # Any globals modified? # asynchronous step
  '''block:'''
  N=WorldSide*WorldSide
  for a in range(0,N,1): # loop over variable "a" Patt#2
    '''block:'''      
    i=int(random(WorldSide))
    j=int(random(WorldSide))
    # RULE: you assume a state more common in your vicinity     
    sum0  = 0; sum1  = Bias  #sums of strenght "points"
          
    for k in range(i-MooreRad,i+MooreRad+1,1): # loop over variable "k" Patt#8
      for m in range(j-MooreRad,j+MooreRad+1,1): # loop over variable "m" Patt#8
        '''block:'''
        K=(WorldSide+k)%WorldSide  #Implement TORUS
        M=(WorldSide+m)%WorldSide  #calculation
      
        if Attitude[K][M]==0  : 
          sum0+=Strength[K][M]; 
        else : 
          sum1+=Strength[K][M];    
   
    if sum0>sum1 : 
      Attitude[i][j]=0
    else : 
      Attitude[i][j]=1
   

def status(): # Any globals modified?
  '''block:'''
  fill(128);noStroke();rect(0,height,width,-20)

  fill(255)
  textSize(18);textAlign(LEFT,BOTTOM)
  text("ST:"+str(t)+"("+nfs(frameRate,0,2)+"fps) Adopted:"+str(Adopted),0,height)


## @date 2024-12-20 (https://github.com/borkowsk/bookProcessingEN/)
## TASK09_SocialImpact/asynchronic2DsocImpNoise/asynchronic2DsocImpNoise.pyde
