#  Two statement inside a loop.
#*# ===========================

size(500,500)  # Larger window size needed
noSmooth()     # Without smoothing outlines

for i in range(0,256): # i should be int # REPEAT 256 TIMES
#BEGIN # code block START
  stroke(i)
  line(i*2,i*2,0,500)
#END # code block END

# https://github.com/borkowsk/bookProcessingEN
