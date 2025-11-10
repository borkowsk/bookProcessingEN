/// Demonstration of modulo logic.
//-///////////////////////////////

final int FR= 1; // Frame rate
final int FS=20; // Font size 

final int N =17; // Array size
final int M = 2; // Moving step

int i=int(random(N)); // index of RED one
int j=int(random(N)); // index of BLUE one

void setup()
{
  size(600,600);
  frameRate(FR);
  visualise();
}

void visualise()
{
  background(0,255,200);
  textSize(FS);
  float side=width/(N+2);
  float angl=(PI*2)/(N);
  fill(255);
  
  for(int ii=0;ii<N;ii++)
  { // In Processing i declared inside loop hides global i only inside loop block.
    // But it is not safe practice of coding.
    rect((ii+1)*side,side,side,side);
    arc(width/2,height/2,width/2,height/2,ii*angl,(ii+1)*angl);
  } 
  
  fill(255,0,0,200);
  ellipse((i+1.5)*side,side*1.5,side,side);
  arc(width/2,height/2,width/2,height/2,i*angl,(i+1)*angl);
  fill(0,0,255,128);
  ellipse((j+1.5)*side,side*1.5,side,side);
  arc(width/2,height/2,width/2,height/2,j*angl,(j+1)*angl);
}

void draw() // modifies global i,j
{
  visualise();
  String istr="(i+M)%N="+"("+str(i)+"+"+str(M)+")%"+str(N)+"=\t"; // How to add ints to string?
  i=(i+M)%N;
  istr+=nf(i,2,0);
  
  String jstr="(N+j-M)%N="+"("+str(N)+"+"+str(j)+"-"+str(M)+")%"+str(N)+"=\t";
  
  j=(N+j-M)%N;
  jstr+=nf(j,2,0);
  
  println(istr,"\t",jstr,(i==j?"!!!":"") );
  
  textAlign(CENTER,BOTTOM);
  fill(255,0,0);
  text(istr,width/2,height-4*FS);
  fill(0,0,255);
  text(jstr,width/2,height-2*FS);
}

 
/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
