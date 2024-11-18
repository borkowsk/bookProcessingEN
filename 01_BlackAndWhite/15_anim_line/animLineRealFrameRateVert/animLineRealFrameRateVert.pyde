# Infinite line animation.
#*# ======================

def setup(): 
  '''Is it any globals used inside a function?'''
  size(400,300)
  frameRate(9999)  # unrealisticly high frame rate!
  stroke(255)
#END

pos = 0  # < GLOBAL VARIABLE.

def draw(): 
#BEGIN 
  global pos  # < This global variable is used inside `draw()`
  background(0)  # what happens when this line is commented out?
  stroke(random(255))
  line(0,pos,width, pos)
  pos+=1
  if pos > height : # already outside the window?
  #BEGIN
    pos = 0  # go back to initial position!
    print frameRate # real frame rate in last cycle.
  #END
#END

# https://github.com/borkowsk/bookProcessingEN
