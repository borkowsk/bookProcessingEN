## Ellipses example:
#*##=================

W=600   ##< Global control parameter.

def radius():
  global W
  '''What should this code below do?''' 
  return int(random(W/10))


# Initialisation:
def setup(): # Is it any global variable used inside?
  '''What should this code below do?''' 
  size(600,600)


# Running - visualisation and dynamics (about 60 times per sec.).
def draw(): # Is it any global variable used inside?
  '''What should this code below do?''' 
  fill(random(255),random(255),random(255),random(255))
  r=radius()
  ellipse(random(W),random(W),r,r)


# https://github.com/borkowsk/bookProcessingEN
