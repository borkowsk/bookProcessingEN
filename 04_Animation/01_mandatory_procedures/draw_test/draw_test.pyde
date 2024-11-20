# `draw()` mandatory only.
#*########################

i=0  # Global needed inside `draw()`

def draw(): # It is executed in an invisible loop
# BLOCK:
  global i # Note that external variable is used inside!
  strokeWeight(3)
  stroke(255,0,255)
  fill(i,0,0)
  ellipse(50,50,99,99)
  i+=1  # Incrementation of "i"


# https:#github.com/borkowsk/bookProcessingEN
