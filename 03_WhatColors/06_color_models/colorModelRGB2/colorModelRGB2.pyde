# RGB color model (red, green, blue).
# https:#en.wikipedia.org/wiki/RGB

# RGB color model. Range for all color elements will be 0..99
colorMode(RGB, 100)  # 100 is default size of Processing window

for i in range(0,100,1): # "i" should be int # BLOCK:
  for j in range(0,100,1): # "j" should be int # BLOCK:
    stroke(i, 0, j)  # RED-BLUE gradient
    point(i, j)
  


# https://github.com/borkowsk/bookProcessingEN
