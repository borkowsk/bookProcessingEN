# Circle sectors.
#*#=============

size(500,500)
background(0,0,200)  # rgB - BLUE
noSmooth()  # No line smoothing

ellipse(250, 250, 200, 200)  # The ellipse underneath
for i in range(0,256,10): # "i" should be int # Repeat every 10
#BEGIN What this code below should do?
  fill(0,i,0)  # rGb - GREEN
  arc(250, 250, 200, 200, radians(i-10),radians(i))  # Sectors
#END

# https://www.facebook.com/ProcessingWEdukacji/
# http://processingwedukacji.blogspot.com
# https://github.com/borkowsk/bookProcessingEN
