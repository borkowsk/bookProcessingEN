//Lotka–Volterra equations
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
//
float X=300;//x is the number of prey (for example, rabbits);
float Y=35;//y is the number of some predator (for example, foxes);

//α, β, γ, δ are positive real parameters describing the interaction of the two species.
final float alpha=0.1;//Prey growth
final float beta=0.01;//interaction of prey with predators
final float gamma=beta/10.0;//the growth of predators depends on the number of pray
final float delta=0.1;//the mortality of predators
//α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 is perfectly stable if Xo=100, Yo=10;

final float Tstep=0.01;//Time step. As short as possible ;-) Why? Lets try! :-D
final float Tlimit=1000;//Time limit as 2/3 of width
final int   DOTSIZE=2;//More flexible visualisation
size(1500,500);
println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);

line(Tlimit,0,Tlimit,height);
for(float T=0;T<Tlimit;T+=Tstep)// float TIME used as stearing variable!
{
  //println(T,"X:",X," Y:",Y);
  //Visualisation
  stroke(0,255,0);//GREEN for X
  ellipse(T,height-X,DOTSIZE,DOTSIZE);
  stroke(255,0,0);//RED for Y
  ellipse(T,height-Y,DOTSIZE,DOTSIZE);
  stroke(0,0,255);//BLUE for interaction
  point(1000+X,height-Y);
  //How X & Y changes in "infinitely short" time step
  float oldX=X;//Old value of X
  X= X + Tstep * (alpha*X-beta*X*Y);
  Y= Y + Tstep * (gamma*oldX*Y-delta*Y);//X has already new value, so we use oldX - old value of X
}

//https://github.com/borkowsk/bookProcessingEN
