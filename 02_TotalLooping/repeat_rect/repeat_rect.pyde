#  30 white paper sheets.
#*# =====================

size(500,500)
smooth()            # Line smoothing ("anti-aliasing")
rectMode(CORNERS)   # Set rectMode to CORNERS

for i in range(0,300,10): # "i" should be int # REPEAT 30 TIMES EVERY TEN!
  rect(i,i,0,500)  # Drawing a sheet of paper

# https://github.com/borkowsk/bookProcessingEN
