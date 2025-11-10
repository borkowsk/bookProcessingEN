## FALLING SPIDERS.
##*##===============

'''constant int'''
FR   = 10  ## How many frames per second
'''constant int'''
Num  = 10  ## How many spiders

'''constant float'''
minv = 10.0  ## The slightest movement of the spider
'''constant float'''
maxv = 50.0  ## What the greatest movement of the spider

y0=0.0  ## Starting height = height/D

h=[0.0]*(Num) ## Vertical position
x=[0.0]*(Num) ## Horizontal position
v=[0.0]*(Num) ## Vertical speed in pixels per second!

def setup(): # Is it any global variable modified inside? #
  global y0,h,x,v
  '''What should this code below do?''' 
  size(500,500)
  y0=height/20
  
  noSmooth()
  frameRate(FR)
  stroke(255)
  fill(0)
    
  for i in range(0,Num,1): # 'i' has int value ## Initialize Positions and Speeds
    # block: 
    h[i]=y0   ## Initial vertical positions         
    x[i]=random(width)  ## Horizontal positions
    v[i]=random(minv,maxv)  ## Vertical speeds
  

              
def draw(): # Is it any global variable modified inside? #
  global h,x,v
  '''What should this code below do?''' 
  ## Visualisation
  background(0,0,200)  ## rgB
  line(0,y0,width,y0)  ## horizontal "rope"
  
  for i in range(0,Num,1): # 'i' has int value ## Visualisation
    if h[i]<height-3 :
      # block: 
      line(x[i],y0,x[i],h[i])
      ellipse(x[i],h[i],5,5)
    
    else :
      # block: 
      ellipse(x[i],h[i],7,3)
      v[i]=0
    
  
  for i in range(0,Num,1): # 'i' has int value ## Change of positions
    # block: 
    h[i]+=v[i]/FR  ## Speed is in pixels per second!
  


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
