//"Monte-Carlo Forest fire" 
//Model "pożaru lasu" - bardzo klasyczny, w wersji autorskiej Monte Carlo 
//-//////////////////////////////////////////////////////////////////////

//Parametry modelu
int N=50;               //Bok macierzy
int FireTimeDiv=10;     //Jak długo pali się drzewo (podział według wieku/rozmiaru)
float IgnitionP = 0.75; //Prawdopodobieństwo przeniesienia ognia
float InitT=  0.750;    //Ile drzew na początku (gęstość lasu)

//2D "Świat" drzew
int World[][] = new int[N][N];

//Dla wizualizacji
int S=20;       //szerokość i wysokość komórki

//Do celów statystycznych
int Step=0;

//Inicjalizacja
void setup()
{
  size(900,930);
  S=width/N; //Długość boku komórki (w wizualizacji)
 
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
    if(random(0,1)<InitT)
     //World[i][j]=100;
     //World[i][j]=(int)random(100); //ROZKŁAD PŁASKI? RACZEJ NIEREALISTYCZNY!
     World[i][j]=(int)(20*(random(1)+random(1)+random(1)+random(1)+random(1))); //MOŻE JEDNAK ROZKŁAD GAUSSA?
    else
     World[i][j]=0;
}

void draw()
{
  doVisualisation();
  doMonteCarloStep();
}

void doVisualisation()
{
 for(int i=0;i<N;i++) //Wizualizacja
  for(int j=0;j<N;j++)
  {
    if(World[i][j]==0) //Wolna lub spalona komórka
    {
      fill(0,0,0);
    }
    else
    if(World[i][j]>0) //Jakieś drzewo
    {
      int col=30+(int)World[i][j];
      if(col>255) col=255;
      fill(0,col,0);
    }
    else //Pali się!
    {
      fill(random(255),random(255),0);
    }
    
    rect(i*S,j*S,S,S);
  } 
}

void keyPressed() //Zapłon w losowym miejscu!
{
    int i=(int)random(N);
    int j=(int)random(N);
    World[i][j]=-World[i][j]/FireTimeDiv - 1; //At least one step
}

void mouseClicked()
{
  int i=mouseX/S;
  int j=mouseY/S;
  World[i][j]=-World[i][j]/FireTimeDiv - 1; //At least one step
}

void doMonteCarloStep()
{
  Step++;
  int M=N*N;
  for(int m=0;m<M;m++) //Processing rozróżnia WIELKOŚĆ LITER w nazwach. Jednak korzystanie z tej możliwości nie jest dobrą praktyką.
  {
    int i=(int)random(N);
    int j=(int)random(N);
    
    if(World[i][j]<0) //Ujemna wartość oznacza, że ​​nadal płonie!
    {
       //Podpal sąsiada!
       int a=(N+i+(int)random(-1.99,1.99))%N;
       int b=(N+j+(int)random(-1.99,1.99))%N;
       
       if(World[a][b]>0
       && random(0,1)<IgnitionP)
       {
         World[a][b]=-World[a][b]/FireTimeDiv - 1; //At least one step
         //print("!");
       }
       
       //Płoń dalej!
       World[i][j]++; //Aż do 0
       if(World[i][j]>0) print("?");
    }
  }
}
