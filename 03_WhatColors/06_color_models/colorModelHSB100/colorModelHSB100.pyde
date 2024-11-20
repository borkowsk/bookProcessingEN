# HSB color model (hue, saturation, brightness) 
# or HSL (hue, saturation, lightness) or HSV (hue, saturation, value)
# https://en.wikipedia.org/wiki/HSL_and_HSV 
# https://pl.wikipedia.org/wiki/HSL

# Alternative color model. Range for all color elements will be 0..99
colorMode(HSB, 100)  # 100 is default size of Processing window

for i in range(0,100,1): # "i" should be int # BLOCK:
  for j in range(0,100,1): # "j" should be int # BLOCK:
    stroke(i, j, 75)  # lightness 75%
    point(i, j)
  


# https://github.com/borkowsk/bookProcessingEN
