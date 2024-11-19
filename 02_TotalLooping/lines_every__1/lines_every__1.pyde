#  Drawing lines with different shades.
#*# ===================================

size(500,500)
#noSmooth() #Test without smoothing or with it!

for i in range(0,200): # "i" should be int #REPEAT 200 times
  stroke(i) # block of code is defined by intendation in Python.
  line(i,i,0,500)

# https://github.com/borkowsk/bookProcessingEN
