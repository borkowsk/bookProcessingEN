#  A "for" loop with the + = operation drawing every other line.
#*# ============================================================

size(500,500)
smooth()  # With line smoothing ("anti-aliasing")

for i in range(0,200,2): # "i" should be int # From 0 to 200 every 2 means 100 times.
  line(i,i,0,500)
  
# https://github.com/borkowsk/bookProcessingEN
