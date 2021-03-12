// "Extended Moore Nowak-Latane Social Impact"
// Two-dimensional, synchronous cellular automaton with extended Moore neib.
///////////////////////////////////////////////////////////////////////////////////////////
final int WorldSide=600;//Side lenght of simulation world (square)
final float Dens=0.40;//.01;//Initial density in the lattice World
final boolean withMoore=true;//neighborhood with the corners of the square
final int     MaxStrength=100;
final int     MooreRad=1;//Radius of extended Moore neib.
final float   Noise=0.001;

int FR=100;//desired simulation speed

int[][] Strength=new int[WorldSide][WorldSide];//cogency

int[][] WorldOld=new int[WorldSide][WorldSide];//Current attitude
int[][] WorldNew=new int[WorldSide][WorldSide];//New or previous attitude

void setup()
{
 size(600,620); //squre canvas
 noSmooth();    //much faster drawing
 frameRate(FR);
 initialisation();//Initial state of the model
}

int t=0;
void draw()
{  
  visualisation3();
  status();  
  addNoise();
  syncStep();  
  t++;//next step
}

void initialisation()
{
   for(int i=0;i<WorldSide;i++) 
    for(int j=0;j<WorldSide;j++) 
    {
      if(random(1.0)<Dens)
        WorldOld[i][j]=1;
       
      WorldNew[i][j]=-1;
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
      if(WorldOld[i][j]==0) WorldOld[i][j]=1;
                      else  WorldOld[i][j]=0;
  }
}

void visualisation1()
{
   for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++) 
    {                      
      switch(WorldOld[i][j]){ 
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
    if(WorldOld[i][j] != WorldNew[i][j])
    {                      
      switch(WorldOld[i][j]){ 
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
   
   for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++)
    if(WorldOld[i][j] != WorldNew[i][j])
    {                      
      float stre=mult*Strength[i][j];//print(stre+" ");
      switch(WorldOld[i][j]){ 
      case 1:stroke(stre,0,stre);break;//magenta shades
      case 0:stroke(0,stre,stre);break;//cyan shades
      default: stroke(255,0,0);//"emergency color" - RED
      break;
      } 
      point(i,j);
    }
}

void syncStep() //Synchronous step a la classic CA
{
  for(int i=0;i<WorldSide;i++)
  {    //RULE: you assume a state more common in your vicinity    
       for(int j=0;j<WorldSide;j++)
       {  
         int sum0  = 0, sum1  = 0;//sums of strenght "points"
                  
         for(int k=i-MooreRad;k<=i+MooreRad;k++)
           for(int m=j-MooreRad;m<=j+MooreRad;m++)
           {
              int K=(WorldSide+k)%WorldSide;//Implement TORUS
              int M=(WorldSide+m)%WorldSide;//calculation
              
              if(WorldOld[K][M]==0 ) 
                sum0+=Strength[K][M]; 
              else 
                sum1+=Strength[K][M];    
           }
           
         if(sum0>sum1) 
           WorldNew[i][j]=0;
         else 
           WorldNew[i][j]=1;
       }
   }
   
   //Swap the arrays
   int[][] WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp; 
}

void status()
{
    fill(128);noStroke();rect(0,height,width,-20);
    fill(255);
    textSize(18);textAlign(LEFT,BOTTOM);
    text("ST:"+t+"("+nf(frameRate,3,2)+")",0,height);
}


//https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
