# HSB color model (hue, saturation, brightness) 
# or HSL (hue, saturation, lightness) or HSV (hue, saturation, value)
# https://en.wikipedia.org/wiki/HSL_and_HSV 
# https://pl.wikipedia.org/wiki/HSL

size(256,256)

# Alternative color model. Default range 0.255.
colorMode(HSB)  # 256 is a default size of scale

for i in range(0,256,1): # "i" should be int # BLOCK:
  for j in range(0,256,1): # "j" should be int # BLOCK:
    stroke(i, j, 256)  # Maximal lightness
    point(i, j)
  


# https://github.com/borkowsk/bookProcessingEN
