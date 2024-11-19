/// A "for" loop with counting every 10.
//*//////////////////////////////////////

size(500,500);
//noSmooth(); // Comment off this line or this one below
smooth(); // This is the default graphic state

for(int i=0;i<500;i+=10) // REPEAT 50 times (every 10)
  line(i,i,0,500);
  
// https://github.com/borkowsk/bookProcessingEN
