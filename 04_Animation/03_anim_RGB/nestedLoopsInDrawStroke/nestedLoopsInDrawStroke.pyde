# Loop in the loop in the hidden INFINITE loop.
#*##===========================================

def setup(): # Is it any global variable used inside?
# '''What should this code below do?'''
  size(256,256)
  frameRate(100)


k=0  ##< global scpoe.

def draw(): # Is it any global variable used inside?
  global k
  if k<256 :
  # BLOCK:
    for i in range(0,256,1): # "i" should be int
    # BLOCK:
      for j in range(0,256,1): # "j" should be int
      # BLOCK: 
        #stroke(k,j,i)
        #stroke(j,k,i)
        stroke(i,j,k)
        point(j,255-i)  # 2D gradient of colors
      
    print k
  
  
  if k==256 :
  # BLOCK:
    print frameRate,"fps"
  
  k+=1  # Incrementation of "k" at the end of each call of `draw()`


# https://github.com/borkowsk/bookProcessingEN
