## Processing program in mode 2 - with visible subroutines.
#*##=======================================================

def setup(): # Is it any global variable used inside? NO! 
  '''What should this code below do? It is executed once - after starting'''
  size(500,500)
  background(0,0,200)  # rgB
  noSmooth(); 
  ellipse(250, 250, 205, 205)


i=0  # Global variable "i"

def draw(): # Is it any global variable used inside? YES! 
  # It is executed in an invisible loop:
  global i
  fill(0,i,0)  #rGb
  # 'arc' expects an account in radians. 
  # Angles in degrees have to be convert with the function 'radians'
  arc(250, 250, 200, 200, radians(i-10),radians(i))
  i+=10


# https://github.com/borkowsk/bookProcessingEN
