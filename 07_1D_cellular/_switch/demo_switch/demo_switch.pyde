## Demonstration of very useful switch-case construction.
##-##===========================================================
 
num = 1

_switchvar=num    # block: 
if  _switchvar== 0: 
  print   "Zero"   ## Does not execute, when num==1
  pass
elif _switchvar==1: 
  print   "One"    ## Prints "One"
  pass


letter = 'N'

_switchvar=letter    # block: 
if  _switchvar== 'A': 
  print   "Alpha"   ## Does not execute, when letter=='N'
  pass
elif _switchvar=='B': 
  print   "Bravo"   ## Does not execute, when letter=='N'
  pass
else :              ## Default executes if the case labels
  print   "None"    ## don't match the switch parameter
  pass


## Removing a "break" enables testing
## for more than one value at once

alphanumeric = 'b'

_switchvar=alphanumeric    # block: 
if   _switchvar== 'a' or _switchvar== 'A' : 
  print   "Alpha"   ## Does not execute
  pass
elif _switchvar== 'b' or _switchvar== 'B' : 
  print   "Bravo"   ## Prints "Bravo", when alphanumeric == 'b' or 'B'
  pass
elif _switchvar== '0' or _switchvar== '1' : 
  print   "Bit"     ## Prints "Bit"
  pass  


## We can also put more than one instruction for each `case`

colorcode = 'G'

_switchvar=colorcode    # block: 
if  _switchvar== 'R': fill(255,0,0); stroke(128,0,0); pass
elif _switchvar=='G': fill(0,255,0); stroke(0,128,0); pass
elif _switchvar=='B': fill(0,0,255); stroke(0,0,128); pass
elif _switchvar=='W': fill(255); stroke(128); pass
elif _switchvar=='K': fill(0);   stroke(128); pass
else :  fill(200,128,0); stroke(64,64,0); pass
  

ellipse(width/2,height/2,50,50)
  
 
## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)

