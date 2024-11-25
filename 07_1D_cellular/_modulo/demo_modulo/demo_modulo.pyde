## Demonstration of modulo logic.
##-##============================

'''constant int'''
FR= 1  ## Frame rate
'''constant int'''
FS=20  ## Font size 

'''constant int'''
N =17  ## Array size
'''constant int'''
M = 2  ## Moving step

i=int(random(N))  ## index of RED one
j=int(random(N))  ## index of BLUE one

def setup(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  size(600,600)
  frameRate(FR)
  visualise()


def visualise(): # Is it any global variable modified inside?
  '''What should this code below do?''' 
  background(0,255,200)
  textSize(FS)
  side=width/(N+2)
  angl=(PI*2)/(N)
  fill(255)
  
  for ii in range(0,N,1): # 'ii' has int value
    # block:  ## In JAVA Processing `i` declared inside loop hides global `i` only inside loop block.
    ## But it is not safe practice of coding. And is not allowed in Python code!
    rect((ii+1)*side,side,side,side)
    arc(width/2,height/2,width/2,height/2,ii*angl,(ii+1)*angl)
   
  
  fill(255,0,0,200)
  ellipse((i+1.5)*side,side*1.5,side,side)
  arc(width/2,height/2,width/2,height/2,i*angl,(i+1)*angl)
  fill(0,0,255,128)
  ellipse((j+1.5)*side,side*1.5,side,side)
  arc(width/2,height/2,width/2,height/2,j*angl,(j+1)*angl)


def draw(): # Is it any global variable modified inside? #
  global i,j
  '''What should this code below do?''' 
  visualise()
  istr="(i+M)%N="+"("+str(i)+"+"+str(M)+")%"+str(N)+"=\t"  ## How to add ints to string?
  i=(i+M)%N
  istr+=nf(i,2,0)
  
  jstr="(N+j-M)%N="+"("+str(N)+"+"+str(j)+"-"+str(M)+")%"+str(N)+"=\t"
  
  j=(N+j-M)%N
  jstr+=nf(j,2,0)
  
  print istr,"\t",jstr,("!!!" if i==j else "") 
  
  textAlign(CENTER,BOTTOM)
  fill(255,0,0)
  text(istr,width/2,height-4*FS)
  fill(0,0,255)
  text(jstr,width/2,height-2*FS)


## https://github.com/borkowsk/bookProcessingEN
## @date 2024-11-25 (last modification) 
