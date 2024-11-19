#  Drawing lines example.
#*# =====================

size(500,500)
noSmooth()  # Without line smoothing ("anti-aliasing")

for i in range(0,200): # "i" should be int # REPEAT 100 times, but try `range(0,200,2)`
  line(i,50,i,450)
  
# https://github.com/borkowsk/bookProcessingEN
