// "environment" czyli mapa środowiska życia agentów
//-/////////////////////////////////////////////////////////

//Environment "tiles" - niestety enum w Processingu jest obiektem co jest czasem bez sensu!
//Dlatego używamy po prostu "stałych" 
final int Env_FLAT=0;
final int Env_WORK=100;
final int Env_SHOP=120;
final int Env_ROAD=200;
final int Env_REST=300;

float limit=105;
float fcars=0.05;
int   streetcount=0;
int   avenuecount=0;

void initializeEnv(int[][] env)
{
  limit=10;
  sierpinskiCarpetRect(env,Env_WORK,0,0,env[0].length,env.length);
  limit=1;
  street(env,0,env.length); //Ulice są poziome
  avenue(env,0,env[0].length); //Aleje są pionowe
  //println(streetcount,avenuecount); DEBUG
}

void fillblock(int[][] env,int val,int x1,int y1,int x2,int y2)
{
  for(int a=x1;a<x2;a++)
   for(int b=y1;b<y2;b++)
     env[b][a]=val;
}

void avenue(int[][] env,float start,float end)
{
  float len=end-start; //Szerokość pasa zabudowy
  float weight=len*fcars; //Szerokość alei
  if(weight<limit) return; //Czy nie za wąska dla samochodu?
  avenuecount++; //Zliczenie
  
  float center=(start+end)/2;
  
  fillblock(env,Env_ROAD,round(center-weight/2),0,round(center+weight/2),env.length); //Aleje są pionowe
  
  avenue(env,start,center-weight/2);
  avenue(env,center+weight/2,end);
}

void street(int[][] env,float start,float end)
{
  float len=end-start; //Szerokość pasa zabudowy
  float weight=len*fcars; //Szerokość ulicy
  if(weight<limit) return; //Czy nie za wąska dla samochodu?
  streetcount++; //Zliczenie
  
  float center=(start+end)/2;
  
  fillblock(env,Env_ROAD,0,round(center-weight/2),env[0].length,round(center+weight/2)); //Ulice są poziome
  
  street(env,start,center-weight/2);
  street(env,center+weight/2,end);
}

void sierpinskiCarpetRect(int[][] env,int val,int x, int y, int sizex, int sizey)
{
   if (sizey < limit)
      return; // println(sizex,sizey);
   
   sizex = sizex / 3; 
   sizey = sizey / 3; 
   
   fillblock(env,val,x+sizex, y+sizey, x+2*sizex, y+2*sizey); //Wycięcie

   //Wywołania rekurencyjne dla 8 kwadratowych sąsiedztw
   //Po rogach
   sierpinskiCarpetRect(env,val,x        ,        y,sizex,sizey);
   sierpinskiCarpetRect(env,val,x+2*sizex,y+2*sizey,sizex,sizey);
   sierpinskiCarpetRect(env,val,x        ,y+2*sizey,sizex,sizey);
   sierpinskiCarpetRect(env,val,x+2*sizex,y        ,sizex,sizey);
   //Po bokach
   sierpinskiCarpetRect(env,val,x        ,y+sizey  ,sizex,sizey);
   sierpinskiCarpetRect(env,val,x+sizex  ,y        ,sizex,sizey);
   sierpinskiCarpetRect(env,val,x+2*sizex,y+sizey  ,sizex,sizey);
   sierpinskiCarpetRect(env,val,x+sizex  ,y+2*sizey,sizex,sizey);
}
