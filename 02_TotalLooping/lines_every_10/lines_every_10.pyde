#  A "for" loop with counting every 10.
#*# ===================================

size(500,500)
#noSmooth() # Comment off this line or this one below
smooth()  # This is the default graphic state

for i in range(0,500,10): # "i" should be int # REPEAT 50 times (every 10)
  line(i,i,0,500)
  
# https://github.com/borkowsk/bookProcessingEN
