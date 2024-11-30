/** Lotka–Volterra equations
 *  https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
 */

float X=100; //x is the number of prey (for example, rabbits);
float Y=10;  //y is the number of some predator (for example, foxes);

// α, β, γ, δ are positive real parameters describing 
// the interaction of the two species.
final float alpha=0.1;    //prey growth. The name `alpha` can be used until you want to use the `alpha` processing function.l
final float beta=0.01;    //interaction of prey with predators
final float gamma=0.001;  //the growth of predators depends on the number of prey
final float delta=0.1;    //the mortality of predators
//α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 is perfectly stable if Xo=100, Yo=10;

float Tstep=0.01; //Time step. As short as possible ;-)
int   N=25;       //Number if steps

println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);
for(int i=0;i<N;i++)
{
  float oldX=X; //Local variable is valid only inside its block of code
  println(i,"X:",X," Y:",Y);
  //How X & Y changes in "infinitely short" time step
  X= X + Tstep * (alpha*X-beta*X*Y);     //Prey
  Y= Y + Tstep * (gamma*oldX*Y-delta*Y); //Predator
}

text("DONE",30,50);

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
