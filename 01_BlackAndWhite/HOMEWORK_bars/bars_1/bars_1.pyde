#  4 bars example. Without FOR!!!
#  DATA. Values can be changed at will
#  In JAVA "final" means something like "constant", but there is no constants in PYTHON!!!
#  You can use names with all capital letters, but this is convention only.

'''constant float'''
D0=200.0;D1=180.0;D2=50.0;D3=25.0

# auxiliary variables
'''constant float'''
MAXD=max(D0,D1,max(D2,D3))  # max() accept only 2 or 3 parameters
curr=0

size(600,500)  #the size can be almost any
print MAXD,"in",width,"x",height,"window" #print to console!

# Bars
stroke(255);fill(0)
curr=D0/MAXD*height
rect(width/6,height-curr,width/6,curr-2)
curr=D1/MAXD*height
rect(width/6*2,height-curr,width/6,curr-2)
curr=D2/MAXD*height
rect(width/6*3,height-curr,width/6,curr-2)
curr=D3/MAXD*height
rect(width/6*4,height-curr,width/6,curr-2)

# coordinate system
stroke(128)
line(0,0,0,height-1)  #Vertical
line(0,0,5,10)  #Arrow
textAlign(LEFT,TOP);text(MAXD,0,0)  #Print max on window!

line(0,height-1,width,height-1)  #Horizontal
#line(width,height-1,width-10,height-5); //Arrow

# https://github.com/borkowsk/bookProcessingEN
