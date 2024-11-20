## Loop in the loop in the hidden INFINITE loop.
#*##=============================================

def setup(): # Is it any global variable used inside?
# '''What should this code below do?'''
  size(256,256)


k=0  ##< global scope variable.

def draw(): # Is it any global variable used inside?
# BLOCK:
  global k  # It changes every step.
  if k<256 :
  # BLOCK:
    for i in range(0,256,1): # "i" should be int
    # BLOCK:
      for j in range(0,256,1): # "j" should be int
      # BLOCK: 
        stroke(k,j,i)
        point(j,255-i)  #2D gradient of colors
      
    
    
    k+=1; println(k)
  


# https://github.com/borkowsk/bookProcessingEN
