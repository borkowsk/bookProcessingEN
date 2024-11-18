# Infinite line animation.
#*# ======================

def setup(): 
  '''Is it any globals used inside a function?'''
  size(300,200)
  frameRate(9999)  #Unrealistic :-)
#END

pos = 0  # < GLOBAL VARIABLE

def draw(): 
#BEGIN 
  global pos #used global variable `pos`.
  background(0)
  stroke(255)
  line(pos, 20, pos, height-20 )
  pos+=1
  
  if pos > width : # already outside the window?
  #BEGIN
    pos = 0  # go back to initial position!
    print frameRate # Real frame rate in last cycle
  #END
#END

# https://github.com/borkowsk/bookProcessingEN
