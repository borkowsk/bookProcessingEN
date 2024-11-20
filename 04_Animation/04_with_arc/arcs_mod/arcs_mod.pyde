## Processing program in mode 2 - with visible subroutines.
#*##=======================================================

def setup(): # Is it any global variable used inside? 
  '''What should this code below do?'''
  size(500,500)
  background(0,0,200)
  noSmooth()
  ellipse(250, 250, 205, 205)

 
i=0  ##< global scope.

def draw(): # Is it any global variable used inside?
  global i
  '''What should this code below do?'''
  fill(0,i % 256 ,0)  # If we use the remainder from integer division then... 
                      # when 'i' exceeds 255 it will return to 0 and so on infinitely
  arc(250, 250, 200, 200, radians(i-2),radians(i))
  i+=2


# https://github.com/borkowsk/bookProcessingEN
