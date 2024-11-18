# Infinite line animation using remainder from integer division.
#*# ============================================================

def setup(): 
  '''Is it any globals used inside a function?'''
  size(300,130)
  frameRate(60)
#END

posX = 0  # < GLOBAL SCOPE.
posY = 0  # < GLOBAL SCOPE.

def draw(): 
#BEGIN 
  global posX,posY # Used from global scope.
  background(204)
  line(posX,posY,posX+50,posY+20 )
  
  # Different speed of change for X and Y
  posY+=2
  posX+=1
  
  # Now we use the remainder from integer division
  posX=posX % width
  posY=posY % height
#END

# https://github.com/borkowsk/bookProcessingEN
