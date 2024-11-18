# src: https://openprocessing.org/sketch/825836/

def setup():
  '''Is it any globals used inside a function?'''
  size(500,500)
#END

def draw():
   '''Is it any globals used inside a function?'''
   #background(200)
   
   if mouseX<=width/2 : #depending on mouse X position.
   #BEGIN
        fill(255,255,255,128)
   #END  
   else :
   #BEGIN
        fill(128,128)
        #fill(128,(mouseX*1.0/width)*255)#test also this!
   #END
     
   ellipse(mouseX,mouseY,50,50)
#END
