# Randomized a/nimation example.
#*##=============================

def setup(): # Is it any global variable used inside? NO  
  '''What should this code below do?''' 
  size(500,200)        # We set the size of the window,
  background(0,0,128)  # its background color 
  stroke(255,255,0)    # and the color of the points


def draw(): # Is it any global variable used inside? YES
  '''SYSTEM VARIABLES NEED NOT SPECIAL DECLARATIONS.'''
  '''What should this code below do?''' 
  point(random(width),random(height))


# https://github.com/borkowsk/bookProcessingEN
