## Two-dimensional, DETERMINISTIC cellular automaton - "SUM WITH NEIGHBOR AND TAKE MODULO" rule. 
## Asynchronous steps ON A HEXAGONAL GRID.
##===============================================================================================

WorldSize=50  ##How many elements do we want in a line?
IDens=0.00    ##Initial density in the array (0 means initialization in the middle)
Div=5

'''assumed list of list of int (inefficient!)'''
World=[[0 for _x in range(WorldSize)] for _y in range(WorldSize)]; 

CellSize=10  ##We will use the ability to specify screen coordinates as `float`

def settings(): # Is it any global variable modified inside?  ##A SPECIAL FUNCTION THAT ALLOWS YOU TO USE AN EXPRESSION DETERMINING WINDOW SIZES AND OTHER WINDOW SETTINGS
  '''What should this code below do?''' 
  ##noSmooth()  #If there is a `settings()` function, this command must be in it before calling `size()`
  ##Window aspect ratio 3:2
  size(int(WorldSize*1.5*CellSize),int(WorldSize*CellSize) )  ## Tu akurat parametry muszą być typu `int`


## CLASSIC `setup()` IS RUN AFTER `settings()`
def setup(): # Is it any global variable modified inside? 
  '''What should this code below do?''' 
  initialize()  ## World initialization...
  visualize()   ## and the first visualization of the world.
  visualise_connections()  ##visualization of connections, i.e. possible interactions of cells
  frameRate(2)  ##Very slow



def draw(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  if frameCount<2 : 
    # block:   
    delay(1000*3)  ## For n-seconds, the initial state - i.e. visualization of connections
    background(8)
  
  change()      ## changing the state of the world...
  visualize()   ## and another visualization of the world
  fill(255)
  text("ST:"+str(frameCount),0,10)



def initialize(): # Is it any global variable modified inside? ## World initialization
  '''What should this code below do?''' 
  if IDens>0 :
    # block: 
    for i in range(0,len(World),1): # loop over variable "i" ##Seeding the array
      for j in range(0,len(World),1): # loop over variable "j" 
        if random(1.0)<IDens :
          World[i][j]=int(random(Div))
  
  else :
    # block: 
    World[WorldSize/2][WorldSize/2]=int(random(Div))  ## Only one seed.
  



def visualize(): # Is it any global variable modified inside? ##< Visualization of the world
  '''What should this code below do?''' 
  noStroke()
  for i in range(0,len(World),1): # loop over variable "i"
    for j in range(0,len(World),1): # loop over variable "j" 
      # block: 
      _switchvar=World[i][j]   # block:  ##The selection statement allows us to select any color depending on the number in the cell
      if  _switchvar== 3:fill(128,128,0);pass
      elif _switchvar==2:fill(255,0,0);pass
      elif _switchvar==1:fill(0,0,255);pass
      elif _switchvar==0:fill(0,0,0);pass
      else :
             fill(0,255,0)  ##This shouldn't appear!
      pass
      
      
      ##We will use the ability to specify screen coordinates as `float`
      offsetY=CellSize*0.5  ##Half the height of the ellipse
      offsetX=offsetY*1.5   ##Half the width of the ellipse
      lineIsEven=(offsetX if j%2==0 else 0)  ##Each even row will be offset more!
      X=offsetX+i*1.5*CellSize+lineIsEven
      Y=offsetY+j*CellSize
      hexagon(X,Y,CellSize*1.5,CellSize)    ##hexagons represent cells
      ##ellipse(X,Y,CellSize*1.5,CellSize)  #or ellipses represent cells
      ##stroke(255,255,0);point(X,Y);noStroke()  #Centers of ellipses
    


def visualise_connections(): # Is it any global variable modified inside? ##< Connection visualization
  '''What should this code below do?''' 
  for i in range(1,len(World)-1,1): # loop over variable "i"
    for j in range(0,len(World)-1,1): # loop over variable "j" 
      # block:     
      ##We will again use the option of specifying screen coordinates as `float`
      offsetY=CellSize*0.5  ##Half the height of the ellipse
      offsetX=offsetY*1.5   ##Half the width of the ellipse
      X=offsetX+i*1.5*CellSize+(offsetX if j%2==0 else 0)
      Y=offsetY+j*CellSize
      
      right = (i+1) % WorldSize;      
      left  = (WorldSize+i-1) % WorldSize
      dw    = (j+1) % WorldSize
      ##int up    = (WorldSize+j-1) % WorldSize
      add   = (right  if j%2==0  else left  )  ## even vs. odd
      stroke(255,0,255)
      X1=offsetX+right*1.5*CellSize+(offsetX if j%2==0 else 0)
      line(X,Y,X1,Y)
      
      if i==1 :
        # block: 
         stroke(255,0,0)
         X1=offsetX+left*1.5*CellSize+(offsetX if j%2==0 else 0)
         line(X,Y,X1,Y)
      
      
      ## Different color for even and odd rows
      if j%2==0 : stroke(0,255,255)
      else : stroke(255,255,0);             
      
      ##World[add][dw]
      Y1=offsetY+dw*CellSize
      X1=offsetX+i*1.5*CellSize+(offsetX if dw%2==0 else 0)
      line(X,Y,X1,Y1)
      ##World[i][dw]
      X1=offsetX+add*1.5*CellSize+(offsetX if dw%2==0 else 0)
      line(X,Y,X1,Y1)
    


def change(): # Is it any global variable modified inside? ## changing the state of the world - here asynchronous Monte Carlo
  '''What should this code below do?''' 
  for a in range(0,len(World)*len(World),1): # loop over variable "a" ##As many draws as cells
    # block: 
     ##Cell/agent randomization
     i=int(random(len(World)))
     j=int(random(len(World)))
     
     ##Rule - "SUM WITH YOUR NEIGHBORS AND TAKE THE MODULO"
     right = (i+1) % WorldSize;      
     left  = (WorldSize+i-1) % WorldSize; 
     dw    = (j+1) % WorldSize
     up    = (WorldSize+j-1) % WorldSize
     ''' The even row additionally takes the upper and lower left neighbors, 
        but the odd row also takes right-handers  '''
     add   = (right   if j%2==0  else left )
     ile   = ( 
                 World[i][j]
               + World[left][j]
               + World[right][j]
               + World[i][up]
               + World[add][up] ## additional upper
               + World[i][dw]  
               + World[add][dw] ## additional lower
               )  ##the sum of seven taken then modulo `Div`
     World[i][j]=ile % Div ##We save the new state to the world table
   



'''  hexagon(center x-coordinate, center y-coordinate, width, height)
 *  Source: https:##forum.processing.org/two/discussion/21083/creating-a-simple-function-to-draw-a-hexagon.html '''
def hexagon(x, y, gsX, gsY): # Is it any global variable modified inside?         ##< "Tool" for drawing a hexagon
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


##-##==============================================================================
## Autor: Wojciech T. Borkowski
## Materials for the textbook "Processing in education and simulation
## https://github.com/borkowsk/sym4processing/tree/master/ProcessingWEdukacji
##-##==============================================================================
## @date 2024-11-29 (revived)
