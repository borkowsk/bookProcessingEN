# HOMEWORK from the picture example.
#*#================================

size(500,500)
smooth()            # With line smoothing ("anti-aliasing")
rectMode(CORNERS)   # Set rectMode to CORNERS

for i in range(0,300+1,10): # "i" should be int # REPEAT EVERY TENTH!
# '''What should this code below do?'''
  fill(i,0,i)
  rect(i,i,0,500)  # And draw a "card"!


for i in range(300,0-1,-10): # "i" should be int # REPEAT EVERY TENTH BACKWARD!
# '''What should this code below do?'''
  fill(0,i,i)
  ellipse(355,150,i,i)  # And draw the "disc"
  ellipse(i,i,10,10)    # ...  and "tails".


# https://www.facebook.com/ProcessingWEdukacji/
# http://processingwedukacji.blogspot.com
# https://github.com/borkowsk/bookProcessingEN
