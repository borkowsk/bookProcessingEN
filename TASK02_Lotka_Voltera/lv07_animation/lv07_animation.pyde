''' Lotka–Volterra equations
 *  See: https:##en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
'''

X=300 #< x is the number of prey (for example, rabbits)
Y=15  #< y is the number of some predator (for example, foxes)

##α, β, γ, δ are positive real parameters describing the interaction of the two species.
'''constant double'''
Alpha=0.1       #< prey growth
'''constant double'''
Beta=0.01       #< interaction of prey with predators
'''constant double'''
Gamma=Beta/10.0 #< the growth of predators depends on the number of prey
'''constant double'''
Delta=0.1       #< the mortality of predators
## α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 is perfectly stable if Xo=100, Yo=10

'''constant double'''
Tstep=0.05 #< Time step. As short as possible ;-) Why? Lets try! :-D
'''constant int'''
DOTSIZE=2   #< Size of ellipses representing data points

Tlimit=1000       #< Time limit as 2/3 of width

def setup(): # Is it any global variable modified inside? #/< modifies global Tlimit
  '''Purpose of the code block below is ...'''
  size(1500,500)
  frameRate(500) #How many times per second draw is executed
  print   "α=",Alpha,"β=",Beta,"γ=",Gamma,"δ=",Delta 
  Tlimit=width/3*2
  line(Tlimit,0,Tlimit,height)


## for(double T=0;T<Tlimit;T+=Tstep) # double TIME used as stearing variable in a hidden loop of draw()!
T=0 #< Global time variable

def draw(): # Is it any global variable modified inside? 
  global T,X,Y
  '''Purpose of the code block below is ...'''
  if T<Tlimit :
    # block:
    #println(T,"X:",X," Y:",Y)
    #float mirrors of variables because of graphics requarements
    Xf=(float)(X)
    Yf=(float)(Y)
    Tf=(float)(T) 
    #Visualisation:
    stroke(0,255,0) #GREEN for X
    ellipse(Tf,height-Xf,DOTSIZE,DOTSIZE)
    stroke(255,0,0) #RED for Y
    ellipse(Tf,height-Yf,DOTSIZE,DOTSIZE)
    stroke(0,0,255) #BLUE for interaction
    point(Tlimit+Xf,height-Yf)
    #How X & Y changes in "infinitely short" time step
    oldX=X #Old value of X
    X= X + Tstep * (Alpha*X-Beta*X*Y)
    Y= Y + Tstep * (Gamma*oldX*Y-Delta*Y)
  
  
  T+=Tstep


## https://github.com/borkowsk/bookProcessingEN
