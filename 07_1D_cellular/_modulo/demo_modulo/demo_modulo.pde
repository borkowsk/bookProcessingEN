//Demonstration of modulo logic
final int N=17; //Array size
final int M=2;  //Moving step
final int FR=2; //Frame rate
final int FS=20;//Font size 

int i=int(random(N));//index of RED one
int j=int(random(N));//index of BLUE one

void setup()
{
  size(600,600);
  frameRate(2);
  visualise();
}

void visualise()
{
  background(0,255,200);
  textSize(FS);
  float side=width/(N+2);
  float angl=(PI*2)/(N);
  fill(255);
  
  for(int i=0;i<N;i++)
  {
    rect((i+1)*side,side,side,side);
    arc(width/2,height/2,width/2,height/2,i*angl,(i+1)*angl);
  } 
  
  fill(255,0,0,200);
  ellipse((i+1.5)*side,side*1.5,side,side);
  arc(width/2,height/2,width/2,height/2,i*angl,(i+1)*angl);
  fill(0,0,255,128);
  ellipse((j+1.5)*side,side*1.5,side,side);
  arc(width/2,height/2,width/2,height/2,j*angl,(j+1)*angl);
}



void draw()
{
  visualise();
  String istr="(i+M)%N="+"("+i+"+"+M+")%"+N+"=\t";
  i=(i+M)%N;
  istr+=nf(i,2,0);
  
  String jstr="(N+j-M)%N="+"("+N+"+"+j+"-"+M+")%"+N+"=\t";
  j=(N+j-M)%N;
  jstr+=nf(j,2,0);
  
  println(istr+"\t\t"+jstr,(i==j?"!!!":"") );
  textAlign(CENTER,BOTTOM);
  fill(255,0,0);
  text(istr,width/2,height-4*FS);
  fill(0,0,255);
  text(jstr,width/2,height-2*FS);
}
