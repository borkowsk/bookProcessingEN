# reverse countdown "for" loop.
#*#===========================

size(500,500)
#noSmooth()
             
for i in range(255,0-1,-1): # "i" should be int # REPEAT 256 times (counting backwards)
#BEGIN What this code below should do?
  stroke(i)  # Only the brightness changes unless something goes wrong :-)
  line(i,0,128,500)  # only x changes, y==0
#END

# https://github.com/borkowsk/bookProcessingEN
