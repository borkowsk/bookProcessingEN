//Lotka–Volterra equations
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
//
float X=100;//x is the number of prey (for example, rabbits);
float Y=10;//y is the number of some predator (for example, foxes);

//α, β, γ, δ are positive real parameters describing the interaction of the two species.
final float alpha=0.1;//Prey growth
final float beta=0.01;//interaction of prey with predators
final float gamma=0.001;//the growth of predators depends on the number of pray
final float delta=0.1;//the mortality of predators
//α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 is perfectly stable if Xo=100, Yo=10;

float Tstep=0.1;//Time step. As short as possible ;-)
int N=25;//Number if steps

println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);
for(int i=0;i<N;i++)
{
  float oldX=X;//Local variable is valid only inside its block of code
  println(i,"X:",X," Y:",Y);
  //How X & Y changes in "infinitely short" time step
  X=X + Tstep * (alpha*X-beta*X*Y);
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y);
}

//https://github.com/borkowsk/bookProcessingEN
