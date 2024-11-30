/** A General Systems Theory of Marriage: Nonlinear Difference 
 *  Equation Modeling of Marital Interaction
 *  John Gottman, Catherine Swanson, & Kristin Swanson
 *  Wt+1 = IHW(Ht)  + r1Wt + a
 *  Ht+1 = IWH(Wt+1)+ r2Ht + b
*/
final float a=1.1,b=0.9,r1=0.1,r2=0.1;

float W=0.5;
float H=0.5;

// float IHW,IWH; //?

for(int i=0;i<width;i++)
{  
  println(i,W,H);
  W=r1*W+a; //+IHW*H;
  H=r2*H+b; //+IWH*W;
}

text("DONE",30,50);

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
