# ANIM "line()" in default configuration
#*# ====================================

pos = 0  #GLOBAL variable!

def draw(): #It is executed in an invisible loop
  global pos
  background(128)  #This library routine clears the window with color
  line(pos, 20, pos, 80)  #This library routine draw a line
  pos+=1  #What happen here?


# https://github.com/borkowsk/bookProcessingEN
