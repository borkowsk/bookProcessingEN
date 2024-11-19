#  Squares of 'i'.
#*# =============

size(100,250)
background(0);stroke(255)

for i in range(0,16): # "i" should be int #REPEAT 16 TIMES
#BEGIN block of code by intendantion.
    print i*i # calculate square of i
    ellipse(i,250-i*i,2,2)  # better visible than point(i,250-i*i)
#END

# https://github.com/borkowsk/bookProcessingEN
