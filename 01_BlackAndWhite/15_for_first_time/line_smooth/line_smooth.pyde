#  A simple example of a "for" loop of smooth lines.
#*# ===============================================

size(500,500)
smooth()  # test noSmooth() also!

for i in range(0,150): # i should be int # REPEAT 150 TIMES
  line(i,i,500,150)    # SINGLE ACTION
  
# https://github.com/borkowsk/bookProcessingEN
