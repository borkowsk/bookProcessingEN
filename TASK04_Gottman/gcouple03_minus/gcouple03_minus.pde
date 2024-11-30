/** A General Systems Theory of Marriage: 
*    Nonlinear Difference Equation Modeling of Marital Interaction
*    John Gottman, Catherine Swanson, & Kristin Swanson
*    Wt+1 = IHW(Ht)  + r1Wt + a
*    Ht+1 = IWH(Wt+1)+ r2Ht + b
*/

//For model:
final float IHW=0.6001,IWH=0.4001;  //Interaction values are properties of a human relationship 
final float a=-0.001,b=-0.001,r1=0.6,r2=0.4;  //Values describe the characters of people
float W=0.5;
float H=0.5;

//For visualisation
final float DOTSIZE=1;
final float scale=1;
size(1500,500);
line(0,height/2,width,height/2);//Zero line

for(int i=0;i<width;i++)
{  
  println(i,W,H); //Step states...
  //Visualisation:
  stroke(255,0,0);
  ellipse(i,height/2-W*scale/2*height,DOTSIZE,DOTSIZE); //The wife is RED
  stroke(0,255,0);
  ellipse(i,height/2-H*scale/2*height,DOTSIZE,DOTSIZE); //The husband is GREEN
  //MODEL:
  W=r1*W+a+IHW*H;
  H=r2*H+b+IWH*W;
}

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
