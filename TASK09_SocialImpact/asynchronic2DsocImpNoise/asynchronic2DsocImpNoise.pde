// "Extended Moore Nowak-Latane Social Impact" with noise & bias for 1
// Two-dimensional, asynchronous cellular automaton with extended Moore neib.
///////////////////////////////////////////////////////////////////////////////////////////

final int     WorldSide=500;//Side lenght of simulation world (square)
final float   Dens=0.20;//.01;//Initial density of 1 in the Attitude
final int     MaxStrength=100;

final int     Bias=10;   //Bias for 1
final float   Noise=0.05; //Ratio of random swithes of attitudes
final int     MooreRad=1;//Radius of extended Moore neib.


int FR=100;//desired simulation speed

int[][] Strength=new int[WorldSide][WorldSide];//cogency

int[][] Attitude=new int[WorldSide][WorldSide];//Current attitude

void setup()
{
 size(500,520); //squre canvas
 noSmooth();    //much faster drawing
 frameRate(FR);
 initialisation();//Initial state of the model
}

int t=0;
int Adopted=0;
void draw()
{  
  visualisation3();
  status();  
  addNoise();
  asyncStep();  
  t++;//next step
}

void initialisation()
{
   for(int i=0;i<WorldSide;i++) 
    for(int j=0;j<WorldSide;j++) 
    {
      if(random(1.0)<Dens)
        Attitude[i][j]=1;
       
      Strength[i][j]=(int)random(MaxStrength);
    }
}

void addNoise()
{
  int N=int(WorldSide*WorldSide*Noise);
  for(int a=0;a<N;a++)
  {
      int i=int(random(WorldSide));
      int j=int(random(WorldSide));
      if(Attitude[i][j]==0) Attitude[i][j]=1;
                      else  Attitude[i][j]=0;
  }
}

void visualisation1()
{
   for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++) 
    {                      
      switch(Attitude[i][j]){ 
      case 1:stroke(255,255,0);break;//Yellow
      case 0:stroke(0,0,0);break;
      default: stroke(255,0,0);//"emergency color" - RED
      break;
      } 
      point(i,j);
    }
}

void visualisation2()
{
   for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++)
    {                      
      switch(Attitude[i][j]){ 
      case 1:stroke((100+t*10)%256,(100+t*10)%256,0);break;//yellow shades
      case 0:stroke(0,0,(100+t*10)%256);break;//blue shades
      default: stroke(255,0,0);//"emergency color" - RED
      break;
      } 
      point(i,j);
    }
}

void visualisation3()
{
   float mult=255.0/MaxStrength;
   Adopted=0;//Simplest statistics
   for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++)
    {                      
      float stre=mult*Strength[i][j];//print(stre+" ");
      switch(Attitude[i][j]){ 
      case 1:stroke(stre,0,stre);Adopted++;break;//magenta shades
      case 0:stroke(0,stre,stre);break;//cyan shades
      default: stroke(255,0,0);//"emergency color" - RED
      break;
      } 
      point(i,j);
    }
}

void asyncStep() //asynchronous step
{
  int N=WorldSide*WorldSide;
  for(int a=0;a<N;a++)
  {      
         int i=int(random(WorldSide));
         int j=int(random(WorldSide));
         //RULE: you assume a state more common in your vicinity     
         int sum0  = 0, sum1  = Bias;//sums of strenght "points"
                  
         for(int k=i-MooreRad;k<=i+MooreRad;k++)
           for(int m=j-MooreRad;m<=j+MooreRad;m++)
           {
              int K=(WorldSide+k)%WorldSide;//Implement TORUS
              int M=(WorldSide+m)%WorldSide;//calculation
              
              if(Attitude[K][M]==0 ) 
                sum0+=Strength[K][M]; 
              else 
                sum1+=Strength[K][M];    
           }
           
         if(sum0>sum1) 
           Attitude[i][j]=0;
         else 
           Attitude[i][j]=1;
  }
}
   

void status()
{
    fill(128);noStroke();rect(0,height,width,-20);
    fill(255);
    textSize(18);textAlign(LEFT,BOTTOM);
    text("ST:"+t+"("+nf(frameRate,3,2)+") Adopted:"+Adopted,0,height);
}


//https://github.com/borkowsk/bookProcessingEN/

