# ANIM "line()"  
#*# =============

def setup(): # It is executed only once
  '''Is it any globals used inside function?'''
  frameRate(16)  #How many call of draw() per second


pos = 0  # < GLOBAL scope!

def draw(): # It is executed in an invisible loop
  global pos
  background(204)  # This library routine clears the window
  line(pos, 20, pos, 80)  # This draw line in the 'pos'-ition
  pos+=1  # pos=pos + 1; - so here 'pos' is incremented.


# https://github.com/borkowsk/bookProcessingEN
