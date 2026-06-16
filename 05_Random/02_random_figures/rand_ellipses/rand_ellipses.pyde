## Transparent Random Circles.
#*##==========================

W=0.0   ##< global variable

def setup(): # Is it any global variable used inside? #
  global W
  '''What should this code below do?''' 
  size(800,600)   # window size
  frameRate(100)  # animation speed
  noStroke()      # no contours
  # Once you know what dimensions of the window are, 
  W=width/16      # we can calculate 'W'


# Our own function:
def diameter(): # Should return int #
  global W
  '''What should this code below do?''' 
  return int( random(W) )  #convert from float to int


# visualisation:
def draw(): # Is it any global variable used inside? YES, but these are system variables.
  '''What should this code below do?''' 
  alfa=random(128)  # With random opacity of the fill
  fill(random(255),random(255),random(255),alfa)
  d=diameter()  #Diameter of a circle
  ellipse(random(width),random(height),d,d)


# https://github.com/borkowsk/bookProcessingEN
# https://github.com/borkowsk/bookProcessingPL
