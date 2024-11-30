''' Lotka–Volterra equations calculated in double precision.
 *  https:##en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
 '''
 
from adhoclib import frange #floating point loop prosthesis

X=300  #x is the number of prey (for example, rabbits)
Y=15   #y is the number of some predator (for example, foxes)

##α, β, γ, δ are positive real parameters describing the interaction of the two species.
'''constant double'''
alpha=0.1 #prey growth
'''constant double'''
beta=0.01 #interaction of prey with predators
'''constant double'''
gamma=beta/10.0 #the growth of predators depends on the number of prey
'''constant double'''
delta=0.1 #the mortality of predators
##α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 is perfectly stable if Xo=100, Yo=10

'''constant double'''
Tstep=0.01  #Time step. As short as possible ;-) Why? Lets try! :-D
'''constant double'''
Tlimit=1000 #Time limit expected to be 2/3 of width

'''constant int'''
DOTSIZE=2   #More flexible visualisation

size(1500,500)
print   "α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta 

line((float)(Tlimit),0,(float)(Tlimit),height) # see reference for `line`.

for T in frange(0,Tlimit,Tstep): # loop over variable "T" # double TIME used as stearing variable!
  '''Purpose of the code block below is ...'''
  #print('.') #println(T,"X:",X," Y:",Y)
  #float mirrors of variables because of graphics requairements
  Xf=(float)(X)
  Yf=(float)(Y)
  Tf=(float)(T)
  #Visualisation:
  stroke(0,255,0) #GREEN for X
  ellipse(Tf,height-Xf,DOTSIZE,DOTSIZE)
  stroke(255,0,0) #RED for Y
  ellipse(Tf,height-Yf,DOTSIZE,DOTSIZE)
  stroke(0,0,255) #BLUE for interaction
  point(1000+Xf,height-Yf)
  #How X & Y changes in "infinitely short" time step:
  oldX=X  #Old value of X
  X=X + Tstep * (alpha*X-beta*X*Y)
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y)


print   "DONE" 

##@date 2024 (https://github.com/borkowsk/bookProcessingEN)
