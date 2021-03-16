// An example of using a class (complex user type)
//////////////////////////////////////////////////////
static float DefaultR=3.5;
static int   FR=10;

//Construction of the class object
singiel TheSingiel=new singiel(random(1.0),DefaultR+random(0.5),0);

void setup()
{
  size(701,501);
  frameRate(FR);
  // Access to attributes - dot notation
  println("TS.x:",TheSingiel.x1,"TS.R:",TheSingiel.r," TS.Alpha:",TheSingiel.alpha());
}

void draw()
{ //Object of type 'singiel' used as parameter
  view(TheSingiel, width/2,height/2,min(width/2,height/2));
  
  TheSingiel.next();// Method call - dot notation
}

//https://github.com/borkowsk/bookProcessingEN/
