#  Loop in loop - printing to console.
#*# ==================================

for i in range(0,10): # "i" should be int
#BEGIN 
  print i,":", # "," at the end of print list, disables new line "emision".
  for j in range(0,10): # "j" should be int
  #BEGIN
    print j, # Console printout without new line (but space is emited instead)
    #print "*", # ...with additional '*'
  #END
  print ""
#END

# https://github.com/borkowsk/bookProcessingEN
