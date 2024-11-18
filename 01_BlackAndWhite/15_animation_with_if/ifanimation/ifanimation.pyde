# src: https://openprocessing.org/sketch/825836/

def setup():
  size(400,400)
#END

def draw():
  '''Is it any globals used inside a function?'''
  #background(200)
  if mouseX<=width/2 :
  #BEGIN
    fill(255)
  #END  
  else :
  #BEGIN
    fill(0)
  #END
  ellipse(mouseX,mouseY,50,50)
#END
