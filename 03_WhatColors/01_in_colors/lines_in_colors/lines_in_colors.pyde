# 50 lines in shades of Prussian blue (cyan).
#*#==========================================

size(500,500)
background(100,0,0)

# Comment on first line below or the other!
noSmooth()  #No anti-aliasing
#smooth() #With anti-aliasing

for i in range(0,500,10): # "i" should be int # REPEAT 50x every 10
#BEGIN What this code below should do?
  stroke(0,i,i)
  line(i,i,0,500)
#END

# https://www.facebook.com/ProcessingWEdukacji/
# https://github.com/borkowsk/bookProcessingEN
