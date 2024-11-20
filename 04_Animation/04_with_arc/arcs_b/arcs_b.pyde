## Processing program in mode 2 - with visible subroutines.
#*##=======================================================

def setup(): # Is it any global variable used inside?
  '''What should this code below do?''' 
  size(500,500)
  background(0,0,200)  # rgB
  noSmooth()  # no antialiasing
  ellipse(250, 250, 205, 205)


i=0  # global variable used inside `draw()`

def draw(): # Is it any global variable used inside? YES! "i"
  global i
  '''What should this code below do?''' 
  if i>255 : i=0  # "one line if".
  fill(0,i,0)    # rGb
  arc(250, 250, 200, 200, radians(i-10),radians(i))
  i+=10


# https://github.com/borkowsk/bookProcessingEN
