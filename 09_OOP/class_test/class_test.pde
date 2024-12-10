/// An example of using a class (complex user type)
/// @date 2024-12-10 (last modification)
//-////////////////////////////////////////////////////
/// TODO comments clean!
final float DefaultR=3.66;
final int   FR=5;

/// Construction of the class object.
/// Ex. `singiel TheSingiel=new singiel(0.55,DefaultR,0);//singiel(float iX,float iR,float iAlpha);`
singiel TheSingiel=new singiel(random(1.0),DefaultR+random(0.5),0);


void setup()
{
  size(701,501);
  frameRate(FR);
  // Access to attributes - dot notation
  println("TS.x:",TheSingiel.x1,"TS.R:",TheSingiel.r
          //," TS.Alpha:",TheSingiel.alpha() //not important here
          );
}


void draw()
{ //Object of type 'singiel' used as parameter
  //background(200);
  view(TheSingiel, width/2,height/2,min(width/2,height/2));//view(singiel S,float v,float h,float rad)
  TheSingiel.next();// Method call - dot notation
}

// https://github.com/borkowsk/bookProcessingEN/
