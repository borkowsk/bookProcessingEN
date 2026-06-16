## Random tiled circles.
#*##=====================

def setup(): # Is it any global variable used inside?
  '''What should this code below do?''' 
  size(500,500)
  frameRate(2)
  background(0,200,255)
  #clear()  #Strange black background, see manual


def draw(): # Is it any global variable used inside?
  '''What should this code below do?''' 
  for i in range(0,10,1): # 'i' keeps int
    # block: 
     for j in range(0,10,1): # 'j' keeps int
       # block: 
        fill( random(256),random(256),random(256))
        ellipse(i*50+25,j*50+25,50,50)
     
  


# https://github.com/borkowsk/bookProcessingEN/tree/main/05_random
