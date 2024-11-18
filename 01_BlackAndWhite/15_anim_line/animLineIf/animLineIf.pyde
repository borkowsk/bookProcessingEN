# infinite line animation
#*# =========================

def setup(): 
  '''Is it any globals used inside function?'''
  size(300,200)
  frameRate(60)


pos = 0

def draw(): 
  global pos
  background(204)
  line(pos, 20, pos, height-20 )
  pos+=1
  
  if pos > width : #already outside the window?
    pos = 0  #go back to initial position!


# https://github.com/borkowsk/bookProcessingEN
