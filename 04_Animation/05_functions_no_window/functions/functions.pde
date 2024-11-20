/// Demonstration of functions with different parameters.
//*//////////////////////////////////////////////////////

final float onef=1.0;

final int   onei=1;

int memory=0;

int read_memory()
{
  return memory;
}  

int function_returning_int()
{
  return onei;
}

float function_returning_float()
{
  return onef;
}

int function_receiving_int_returning_int(int x)
{
  return x*x;
}

float function_receiving_int_returning_float(int x)
{
  return sqrt(x); // Square root of an integer
}

float function_receiving_float_returning_float(float x)
{
  return sqrt(x); // Square root of a floating point number
}

void setup()
{
  noLoop();
  println(  function_returning_int() );
  println(  function_returning_float() );
  println(  function_receiving_int_returning_int(2) );
  println(  function_receiving_int_returning_float(2) );
  println(  function_receiving_float_returning_float(2.) );
  println(  X, Y ); // What is this? Undocumented variables similar to `mouseX`?
  println( "booleans:",true,false); //trueish is notrue
}

void draw() // Console only applet!
{
  surface.setVisible(false);
  exit();
}

void exit() // What should be done when window is closed?
{
  println("Thank You!");
  super.exit();
}

// https://github.com/borkowsk/bookProcessingEN
