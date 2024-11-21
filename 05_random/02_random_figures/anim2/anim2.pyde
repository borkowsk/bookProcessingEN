## Simple animation example with random.
#*##=====================================

def setup(): # Is it any global variable used inside?  
  '''What should this code below do?''' 
  size(500,200)        # the size of the window.
  background(0,0,128)  # thr background color.


def draw(): # Is it any global variable used inside?
  '''What should this code below do?''' 
  stroke(random(256),random(256),random(256))
  point(random(width),random(height))


# https://github.com/borkowsk/bookProcessingEN
