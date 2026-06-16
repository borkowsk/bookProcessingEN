/// Random number generator - second test.
/// Of course the draw range can be changed.
//*/////////////////////////////////////////

for(int i=0;i<100;i++)
{
  float a=random(1.0); // A random number in the range 0..1
  println(a); // ... printed on the console
  point (i,a*100);
}

// https://github.com/borkowsk/bookProcessingEN
