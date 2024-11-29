## Two-dimensional, DETERMINISTIC cellular automaton - "SUM WITH NEIGHBOR AND TAKE MODULO" rule. SYNCHRONOUS.
##  ON A HEXAGONAL GRID - Display optimized by a change table (Changed)
##=============================================================================

WorldSize=302  ##How many elements do we want in a line?
'''assumed list of list of int (inefficient!)'''
WorldOld=[[0 for _x in range(WorldSize)] for _y in range(WorldSize)]  ##Creating tables - in Processing always using allocation!
'''assumed list of list of int (inefficient!)'''
WorldNew=[[0 for _x in range(WorldSize)] for _y in range(WorldSize)]
'''assumed list of list of boolean (inefficient!)'''
Changed=[[False for _x in range(WorldSize)] for _y in range(WorldSize)]  ##An array of change flags to draw

IDens=0.0  ##The initial density in the array
Div=7      ##What divisor in the automaton rule

CellSize=3        ##Cell height
FRAME_RATE_REQ=2  ##How many frames per second would we like

def settings(): # Is it any global variable modified inside? ##A SPECIAL FUNCTION THAT ALLOWS YOU TO USE AN EXPRESSION DETERMINING WINDOW SIZES AND OTHER WINDOW SETTINGS
  '''What should this code below do?''' 
  noSmooth()  ##If there is a `settings()` function, this command must be in it and before `size()`
  ##Window aspect ratio 3:2
  size(int(WorldSize*1.5*CellSize),int(WorldSize*CellSize) )  ## Here, the parameters must be of type `int`


def setup(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  background(0)  ##Black window background
  if IDens>0 :
    # block: 
    for i in range(0,len(WorldOld),1): # loop over variable "i" ##Seeding the array
      for j in range(0,len(WorldOld),1): # loop over variable "j" 
        # block: 
        Changed[i][j]=True
        if random(1.0)<IDens :
          WorldOld[i][j]=(int)(random(Div))  ##you need to change the type (do a "cast"), because the array stores `int` and not `float`
        else :
          WorldOld[i][j]=0
      
  
  else :
    # block: 
    for i in range(0,len(WorldOld),1): # loop over variable "i" ##Resetting the array
      for j in range(0,len(WorldOld),1): # loop over variable "j" 
        # block: 
        Changed[i][j]=True
        WorldOld[i][j]=0
      
    
    WorldOld[WorldSize/2][WorldSize/2]=1  ##Only one planted inside
  
  visualize()
  frameRate(FRAME_RATE_REQ)


def draw(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  change()
  visualize()
  fill(0,0,0,128);rect(10,height-16,20*8,16)
  fill(255)
  text("ST: "+str(frameCount)+" Fr: "+str(frameRate),10,height)


'''  "Tool" for drawing a hexagon:
 * hexagon(center x-coordinate, center y-coordinate, width, height) '''
def hexagon(x, y, gsX, gsY): # Is it any global variable modified inside? ##< Source: https:##forum.processing.org/two/discussion/21083/creating-a-simple-function-to-draw-a-hexagon.html
  '''What should this code below do?''' 
  sqrt3=sqrt(3)
  gsX/=4
  gsY/=3.5
  beginShape()
  vertex(x - gsX, y - sqrt3 * gsY)
  vertex(x + gsX, y - sqrt3 * gsY)
  vertex(x + 2 * gsX, y)
  vertex(x + gsX, y + sqrt3 * gsY)
  vertex(x - gsX, y + sqrt3 * gsY)
  vertex(x - 2 * gsX, y)
  endShape(CLOSE)


def visualize(): # Is it any global variable modified inside? ##< Visualization of the world
  '''What should this code below do?''' 
  noStroke()
  for i in range(0,len(WorldOld),1): # loop over variable "i"
    for j in range(0,len(WorldOld),1): # loop over variable "j" 
      # block: 
      _switchvar=WorldOld[i][j]    # block:   ##The selection statement allows us to select any color depending on the number in the cell
      if  _switchvar== 0:fill(0,0,0);pass ##A properly selected set of colors allows you to achieve interesting effects
      elif _switchvar==1:fill(0,255,0);pass
      elif _switchvar==2:fill(64,128,64);pass
      elif _switchvar==3:fill(128,64,128);pass
      elif _switchvar==4:fill(255,0,200);pass
      elif _switchvar==5:fill(64,0,255);pass
      elif _switchvar==6:fill(0,0,255);pass
      else : fill(255,255,255)  ##This shouldn't appear
      pass
      
      ##We will use the ability to specify screen coordinates as `float`
      offsetY=CellSize*0.50  ##Half the height of the ellipse/hexagon
      offsetX=CellSize*0.75  ##Half the width of the ellipse/hexagon
      lineIsEven=(offsetX if j%2==0 else 0)  ##The even row will be offset more!
      X=offsetX+i*1.5*CellSize+lineIsEven
      Y=offsetY+j*CellSize
      hexagon(X,Y,CellSize*1.5,CellSize)  ##hexagons representing cells
      ##ellipse(X,Y,S*1.5,S)  #or plain ellipses represent cells
      ##stroke(255,255,0);point(X,Y);noStroke()  #Centers of ellipses/hexagons
    


##change of the state of the world - here, synchronous
def change(): # Is it any global variable modified inside? #
  global WorldOld,WorldNew
  '''What should this code below do?''' 
  for i in range(0,len(WorldOld),1): # loop over variable "i"
    # block: 
     ##RIGHT AND LEFT IS THE SAME FOR THE ENTIRE COLUMN
     ##counting neighbor indexes with wrapping thanks to the remainder of division
     right = (i+1) % WorldSize;         
     left  = (WorldSize+i-1) % WorldSize
     
     for j in range(0,len(WorldOld),1): # loop over variable "j" 
       # block: 
       ##Rule - "SUM WITH YOUR NEIGHBORS AND TAKE THE MODULO"
       dw  = (j+1) % WorldSize;   
       up  = (WorldSize+j-1) % WorldSize
       ## the even row additionally takes its left neighbors, but the odd row additionally takes its right neighbors
       add = (right  if j%2==0  else left  )
       ile = ( WorldOld[i][j]
               +WorldOld[left][j]
               +WorldOld[right][j]
               +WorldOld[i][up]
               +WorldOld[add][up] ## additional top neighbor
               +WorldOld[i][dw]        
               +WorldOld[add][dw] ## additional lower neighbor
               )  ##the sum of seven taken then modulo `Div`
      
       WorldNew[i][j]=ile % Div  ##We save the new state to the second board
       Changed[i][j]=(WorldNew[i][j] !=0 or WorldOld[i][j]!=0) ## Does it need to be visualised?
     
  
   
  ##Swithing arrays - easy because you don't have to copy data, just replace their "handles".
  '''assumed list of list of int (inefficient!)'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp


##*##==============================================================================
## Author: Wojciech T. Borkowski
## Materials for the textbook "Processing in education and simulation
## https://github.com/borkowsk/sym4processing/tree/master/ProcessingWEdukacji
##*##==============================================================================
## @date 2024-11-29 (revived)
