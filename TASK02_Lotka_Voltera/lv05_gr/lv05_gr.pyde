''' Lotka–Volterra equations
 * Model: https:##en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
 * About looping: https:##stackoverflow.com/questions/7267226/range-for-floats
'''

# This generator works exacly like C loop on floats. 
# Note!!! With same cumulative error on returned values.
def frange1(x, y, jump):
  while x < y:
    yield x
    x += jump

# This generator works even better! 
# There is no cumulative error.
def frange3(start, stop, step):
    res, n = start, 1

    while res < stop:
        yield res
        res = start + n * step
        n += 1
    


X=300 #x is the number of prey (for example, rabbits)
Y=35  #y is the number of some predator (for example, foxes)

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
Tstep=0.1  #Time step. As short as possible ;-) Why? Lets try! :-D
'''constant double'''
Tlimit=1000 #Time limit as 2/3 of width
'''constant int'''
DOTSIZE=2   #More flexible visualisation

size(1500,500)
print   "α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta 

line(Tlimit,0,Tlimit,height)
for T in frange3(0,Tlimit,Tstep): # loop over variable "T" # float TIME used as stearing variable!
  '''Purpose of the code block below is ...'''
  print   T,"X:",X," Y:",Y 
  #Visualisation:
  stroke(0,255,0) #GREEN for X
  ellipse(T,height-X,DOTSIZE,DOTSIZE)
  stroke(255,0,0) #RED for Y
  ellipse(T,height-Y,DOTSIZE,DOTSIZE)
  stroke(0,0,255) #BLUE for interaction
  point(1000+X,height-Y)
  #How X & Y changes in "infinitely short" time step
  oldX=X #Old value of X
  X= X + Tstep * (alpha*X-beta*X*Y)
  Y= Y + Tstep * (gamma*oldX*Y-delta*Y) #X has already new value, so we use oldX - old value of X


##@date 2024 (https://github.com/borkowsk/bookProcessingEN)
