# Loop in loop. Note the code blocks!
#*#=================================

size(256,256)

for i in range(0,256,1): # "i" should be int
#BEGIN What this code below should do?
  for j in range(0,256,1): # "j" should be int
  #BEGIN 
    # Choose only one of the `stroke()` statements:
    #stroke(i,0,0) # RED only    
    #stroke(0,j,0) # GREEN only
    #stroke(0,0,j) # BLUE only
    #stroke(i,j,0) # RED+GREEN = shades of red & green & yellow
    stroke(i,0,j)  # RED+BLUE = shades of magenta
    #stroke(0,j,i) # GREEN+BLUE = shades of cyan
    point(j,255-i) # 2D gradient of colors
  #END
#END

# More pytonish:
for i in range(0,256,1): 
  for j in range(0,256,1): 
    # Choose only one of the `stroke()` statements:
    #stroke(i,0,0) # RED only    
    #stroke(0,j,0) # GREEN only
    #stroke(0,0,j) # BLUE only
    stroke(i,j,0)  # RED+GREEN = shades of red & green & yellow
    #stroke(i,0,j) # RED+BLUE = shades of magenta
    #stroke(0,j,i) # GREEN+BLUE = shades of cyan
    point(j,255-i) #2D gradient of colors

# https://github.com/borkowsk/bookProcessingEN
