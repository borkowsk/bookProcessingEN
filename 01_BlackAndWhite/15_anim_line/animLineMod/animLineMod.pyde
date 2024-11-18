# Infinite line animation using remainder from integer division.
#*# ===========================================================

def setup(): 
  '''Is it any globals used inside a function?'''
  size(300,130)
  frameRate(300)

pos = 0  # < GLOBAL VARIABLE!

def draw(): 
#BEGIN 
  global pos # Global variable is used inside this function.
  background(204)
  line(pos, 20, pos, height-20 )
  pos+=1
  # If we use the remainder from integer division then 
  # when 'pos' exceeds 'width' it will return to 0 and so on
  pos=pos % width  # <=> pos %= width
#END

# https://github.com/borkowsk/bookProcessingEN
