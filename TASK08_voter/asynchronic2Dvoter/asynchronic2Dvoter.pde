/// "Voter model" <=> "Nearest Neighbors Social Impact"
/// Two-dimensional, asynchronous cellular automaton
//*//////////////////////////////////////////////////////////////////////////////////

final int WorldSide=600; //Side lenght of simulation world (square)
final float Dens=0.50;   //.01;//Initial density in the lattice World
final boolean withMoore=true; //neighborhood with the corners of the square

int FR=1; //desired simulation speed

int[][] World=new int[WorldSide][WorldSide]; //2 dimensional array
                                            
void setup()
{
 size(600,620); //squre canvas
 noSmooth();    //much faster drawing
 frameRate(FR);
 initialisation(); //Initial state of the model
}

int t=0;
void draw()
{  
  visualisation();
  stepMonteCarlo(); //or other
  status();    
  t++; //next step
}

void initialisation()
{
   for(int i=0;i<WorldSide;i++) 
    for(int j=0;j<WorldSide;j++) 
      if(random(1.0)<Dens)
        World[i][j]=1;
}

void visualisation()
{
   for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++) 
    {                      
      switch(World[i][j]){ 
      case 1:stroke(255,255,0);break; //Yellow
      case 0:stroke(0,0,0);break;
      default: stroke(255,0,0); //"emergency color" - RED
      break;
      } 
      point(i,j);
    }
}

void stepMonteCarlo()  // Monte Carlo step
{
  for(int N=WorldSide*WorldSide, a=0;a<N;a++)
  {    //RULE: You assume a state more common in your vicinity
       int i= (int)random(WorldSide), j= (int)random(WorldSide);
       int right= (i+1) % WorldSide, left= (WorldSide+i-1) % WorldSide;
       int dw= (j+1) % WorldSide, up= (WorldSide+j-1) % WorldSide;
       int cou0=0, cou1=0; //counters of 0 & 1 state neighbors
       
       if(World[left][j]==0 ) cou0++; else cou1++;
       if(World[right][j]==0) cou0++; else cou1++;
       if(World[i][up]==0) cou0++; else cou1++;
       if(World[i][dw]==0) cou0++; else cou1++; 
       
       if(withMoore)
       {
         if(World[left][up]==0) cou0++; else cou1++;
         if(World[right][up]==0) cou0++; else cou1++;
         if(World[left][dw]==0) cou0++; else cou1++;
         if(World[right][dw]==0) cou0++; else cou1++; 
       }
       
       if(World[i][j]==0) cou0++; else cou1++; //Central cell
       
       if(cou0>cou1) World[i][j]=0;
       else World[i][j]=1;
   }
}

void status()
{
    fill(128);noStroke();rect(0,height,width,-20);
    fill(random(255),random(255),random(255));
    textSize(18);textAlign(LEFT,BOTTOM);
    text("ST:"+t+"("+nf(frameRate,3,2)+")",0,height);
}


// https://github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/asynchronic
