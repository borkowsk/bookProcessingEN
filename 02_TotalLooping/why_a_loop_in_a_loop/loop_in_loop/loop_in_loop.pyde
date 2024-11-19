#  Loop in loop. The role of code blocks (made by curly intendation).
#*# =================================================================

for i in range(0,10): # "i" should be int
#BEGIN OUTSIDE LOOP BLOCK.
  for j in range(0,10): # "j" should be int
  #BEGIN INSIDE LOOP BLOCK.
    print i,j # Console printout
  #END
#END

# More clearly pytonish:
println("Pytonish...")
for i in range(0,10): # "i" should be int
  for j in range(0,10): # "j" should be int
    print i,j # Console printout  

# https://github.com/borkowsk/bookProcessingEN
