## Processing program in mode 2 - with visible subroutines.
#*##=======================================================

def setup(): # Is it any global variable used inside?
  '''It is executed once - after starting, so...
  What should this code below do?''' 
  size(500,500)
  background(0,0,200)  # rgB
  noSmooth(); 
  ellipse(250, 250, 200, 200)


i=0;j=0  ##< two global variable.

def draw(): # Is it any global variable used inside? YES!
  global i,j
  '''What should this code below do?''' 
  if i>255 : i=0; 
  fill(0,i,0)  #rGb
  arc(250, 250, 200, 200, radians(j-13),radians(j))
  i+=10
  j+=13


# https://github.com/borkowsk/bookProcessingEN
