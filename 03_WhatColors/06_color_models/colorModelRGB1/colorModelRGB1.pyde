# RGB color model (red, green, blue)
# https://en.wikipedia.org/wiki/RGB

# RGB color model. Range for all color elements will be 0..99
colorMode(RGB, 100)  # 100, because this is a default size of Processing window

for i in range(0,100,1): # "i" should be int # BLOCK:
  for j in range(0,100,1): # "j" should be int # BLOCK:
    stroke(i, j, 0)  # RED-GREEN gradient
    point(i, j)
  


# https://github.com/borkowsk/bookProcessingEN
