## Ellipses example:
#*##=================

W=600   ##< Global control parameter.

def radius():
  global W
  '''The code below calculates a ramdom radius:''' 
  return int(random(W/10))


def setup(): # Is it any global variable used inside?
  '''Window initialisation''' 
  size(600,600)

def draw(): # Is it any global variable used inside?
  '''Running - visualisation and dynamics (many times per sec.).''' 
  fill(random(255),random(255),random(255),random(255))
  r=radius()
  ellipse(random(W),random(W),r,r)


# https://github.com/borkowsk/bookProcessingEN
