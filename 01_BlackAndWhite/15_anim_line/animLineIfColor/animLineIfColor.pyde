# Infinite line animation in colors.
#*# =============================//

def setup(): 
  '''Is it any globals used inside function?'''
  size(256,130)
  frameRate(60)

pos = 0

def draw(): 
  global pos
  background(204)
  stroke(pos,0,pos)
  line(pos, 20, pos, height-20 )
  pos+=1
  if pos > width : #already outside the window?
  #BEGIN of if dependent code
    pos = 0  #go back to initial position!
  #END of if dependent code
#END - of function

# https://github.com/borkowsk/bookProcessingEN
