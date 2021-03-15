// Przykład użycia klasy
////////////////////////////////////
static float DefaultR=3.5;
static int   FR=10;

singiel TheSingiel=new singiel(random(1.0),DefaultR+random(0.5),0);

void setup()
{
  size(701,501);
  frameRate(FR);
  
  println("TS.x:",TheSingiel.x1,"TS.R:",TheSingiel.r," TS.Alpha:",TheSingiel.alpha());
}

void draw()
{
  view(TheSingiel, width/2,height/2,min(width/2,height/2));
  
  TheSingiel.next();
}
