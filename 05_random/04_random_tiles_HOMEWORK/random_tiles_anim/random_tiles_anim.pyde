## Random tiles.
#*##=============

def setup(): # Is it any global variable used inside? NO
  '''What should this code below do?''' 
  size(500,500)
  frameRate(5)


def draw(): # Is it any global variable used inside? NO
  '''What should this code below do?''' 
  for i in range(0,10,1): # 'i' keeps int
  # block: 
     for j in range(0,10,1): # 'j' keeps int
     # block: 
        fill( random(256),random(256),random(256))
        rect(i*50,j*50,50,50)
     
    


# https://github.com/borkowsk/bookProcessingEN/tree/main/05_random
