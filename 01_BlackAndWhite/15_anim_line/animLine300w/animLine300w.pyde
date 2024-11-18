# "line" animation with setup()
#*# ============================

def setup(): 
  '''Is it any globals used inside function?'''
  frameRate(15)
  size(300,200)
  strokeWeight(2)  #Bold lines!


pos = 0

def draw(): 
  global pos
  background(204)
  line(pos, 20, pos, 180)
  pos+=1


# https://github.com/borkowsk/bookProcessingEN
