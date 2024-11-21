# Transparent random squares.
#*##========================

W=.0  # global variable

def setup(): # Is it any global variable used inside?
  global W
  '''What should this code below do?''' 
  size(800,600)   # window size
  frameRate(200)  # animation speed
  # Once you know what dimensions of the window are, 
  W=width/8       # We can calculate 'W'


# Our own function
def side(): # Should return int
  global W
  '''What should this code below do?''' 
  return int( random(W) )


# visualisation
def draw(): # Is it any global variable used inside?
  '''What should this code below do?''' 
  alfa=128+random(128)  # random opacity (local variable)
  stroke(random(255),random(255),random(255),alfa)  # same opacity
  fill(random(255),random(255),random(255),alfa)  # for stroke & fill
  s=side()  # side of the square (local variable)
  rect(random(width-s),random(height-s),s,s)  # Think, why "-s" ?


# https://github.com/borkowsk/bookProcessingEN
# https://github.com/borkowsk/bookProcessingPL
