#  Loop in loop - note the multi-instruction code blocks.
#*# =====================================================

#noStroke() #ellipses without outlines

for i in range(0,10): # "i" should be int
#BEGIN
  for j in range(0,10): # "j" should be int
  #BEGIN
    print i,j #Console printout
    #fill(i*20,j*20,0) #Test colors: RED+GREEN = shades of red & green & yellow
    ellipse(i*10,j*10,4,4)  #"Dots" on window
  #END
#END

# https://github.com/borkowsk/bookProcessingEN
