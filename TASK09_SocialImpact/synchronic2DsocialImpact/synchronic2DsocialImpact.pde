/// "Cellular Nowak-Latane Social Impact" <=> "Nearest Neighb. Social Impact with strenght"
/// Two-dimensional, synchronous cellular automaton
//*/////////////////////////////////////////////////////////////////////////////////////////

final int     WorldSide=600;    //Side lenght of simulation world (square)
final float   Dens=0.50;        //.01;//Initial density in the lattice World
final boolean withMoore=true;   //neighborhood with the corners of the square
final int     MaxStrength=100;

int FR=20; //desired simulation speed

int[][] Strength=new int[WorldSide][WorldSide]; //cogency/credibility

int[][] WorldOld=new int[WorldSide][WorldSide]; //Current attitude
int[][] WorldNew=new int[WorldSide][WorldSide]; //New or previous attitude

void setup()
{
  size(600, 620); //squre canvas
  noSmooth();    //much faster drawing
  frameRate(FR);
  initialisation(); //Initial state of the model
}

int t=0; // is global

void draw() // modifies global t
{  
  visualisation3();
  status(); 
  syncStep(); 
  t++; //next step
}

void initialisation()
{
  for (int i=0; i<WorldSide; i++) 
    for (int j=0; j<WorldSide; j++) 
    {
      if (random(1.0)<Dens)
      {
        WorldOld[i][j]=1;
      }
      WorldNew[i][j]=-1;
      Strength[i][j]=(int)(random(MaxStrength));
    }
}

void visualisation1()
{
  for (int i=0; i<WorldSide; i++)
    for (int j=0; j<WorldSide; j++) 
    {                      
      switch(WorldOld[i][j]) { 
      case 1:
        stroke(255, 255, 0); //Yellow
        break; 
      case 0:
        stroke(0, 0, 0); //black
        break;
      default: 
        stroke(255, 0, 0); //"emergency color" - RED
        break;
      } 
      point(i, j);
    }
}

void visualisation2()
{
  for (int i=0; i<WorldSide; i++)
    for (int j=0; j<WorldSide; j++)
      if (WorldOld[i][j] != WorldNew[i][j])
      {                      
        switch(WorldOld[i][j]) { 
        case 1:
          stroke((100+t*10)%256, (100+t*10)%256, 0); //yellow shades
          break; 
        case 0:
          stroke(0, 0, (100+t*10)%256); //blue shades
          break; 
        default: 
          stroke(255, 0, 0); //"emergency color" - RED
          break;
        } 
        point(i, j);
      }
}

void visualisation3()
{
  float mult=255.0/MaxStrength;

  for (int i=0; i<WorldSide; i++)
    for (int j=0; j<WorldSide; j++)
      if (WorldOld[i][j] != WorldNew[i][j])
      {                      
        float stre=mult*Strength[i][j]; //print(stre+" ");
        switch(WorldOld[i][j]) { 
        case 1:
          stroke(stre, 0, stre); //magenta shades
          break; 
        case 0:
          stroke(0, stre, stre); //cyan shades
          break; 
        default: 
          stroke(255, 0, 0);         //"emergency color" - RED
          break;
        } 
        point(i, j);
      }
}

void syncStep() // uses global WorldOld,WorldNew 
{ //Synchronous step a la classic CA.
  for (int i=0; i<WorldSide; i++)
  { // RULE: you assume a state more common in your vicinity
    int right = (i+1) % WorldSide, left  = (WorldSide+i-1) % WorldSide;      

    for (int j=0; j<WorldSide; j++)
    {
      int dw=(j+1) % WorldSide, up=(WorldSide+j-1) % WorldSide;   
      int sum0  = 0; //sum of 0 strenght of neighbors
      int sum1  = 0; //sum of 1 strenght of neighbors

      if (WorldOld[left][j]==0 ) sum0+=Strength[left][j]; 
      else sum1+=Strength[left][j];
      if (WorldOld[right][j]==0) sum0+=Strength[right][j]; 
      else sum1+=Strength[right][j];
      if (WorldOld[i][up]==0) sum0+=Strength[i][up]; 
      else sum1+=Strength[i][up];
      if (WorldOld[i][dw]==0) sum0+=Strength[i][dw]; 
      else sum1+=Strength[i][dw];

      if (withMoore)
      {
        if (WorldOld[left][up]==0) sum0+=Strength[left][up]; 
        else sum1+=Strength[left][up];
        if (WorldOld[right][up]==0) sum0+=Strength[right][up]; 
        else sum1+=Strength[right][up];
        if (WorldOld[left][dw]==0) sum0+=Strength[left][dw]; 
        else sum1+=Strength[left][dw];
        if (WorldOld[right][dw]==0) sum0+=Strength[right][dw]; 
        else sum1+=Strength[right][dw];
      }

      if (WorldOld[i][j]==0) sum0+=Strength[i][j]; //SELF INFLUENCE
      else sum1+=Strength[i][j];

      if (sum0!=sum1) //What about equal? 
      {
        if (sum0>sum1) WorldNew[i][j]=0; //WITHOUT OUTSIDE if WE HAVE SMALL BIAS HERE!
        else WorldNew[i][j]=1;
      } else  WorldNew[i][j]=WorldOld[i][j];
    }
  }

  // Swap the arrays
  int[][] WorldTmp=WorldOld;
  WorldOld=WorldNew;
  WorldNew=WorldTmp;
}

void status()
{
  fill(random(128));
  noStroke();
  rect(0, height, width, -20);
  fill(random(255));
  textSize(18);
  textAlign(LEFT, BOTTOM);
  text("ST:"+t+"("+nf(frameRate,0, 2)+")", 0, height);
}


//@date 2024 https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
