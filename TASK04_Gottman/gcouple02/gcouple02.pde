//A General Systems Theory of Marriage: Nonlinear Difference Equation Modeling of Marital Interaction
//John Gottman, Catherine Swanson, & Kristin Swanson
//  Wt+1 = IHW(Ht)  + r1Wt + a
//  Ht+1 = IWH(Wt+1)+ r2Ht + b

//For model
final float IHW=0.600,IWH=0.400;                    //Interaction values are properties of a human relationship 
final float a=-0.002,b=0.002,r1=0.6,r2=0.4;         //Values describe the characters of people
float W=0.75;
float H=0.25;

//For visualisation
final float DOTSIZE=2;//bigger points
final float scale=1;
size(500,200);

for(int i=0;i<width;i+=DOTSIZE+1)
{  
  println(i,W,H);
  //Visualisation
  stroke(255,0,0);//The wife is RED
  ellipse(i,height-W*scale*height,DOTSIZE,DOTSIZE);
  stroke(0,255,0);//The husband is GREEN
  ellipse(i,height-H*scale*height,DOTSIZE,DOTSIZE);
  //MODEL
  W=r1*W+a+IHW*H;
  H=r2*H+b+IWH*W;
}

//https://github.com/borkowsk/bookProcessingEN
