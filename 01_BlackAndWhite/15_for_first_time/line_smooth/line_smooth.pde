/// A simple example of a "for" loop of smooth lines.
//*//////////////////////////////////////////////////

size(500,500);
smooth(); // test noSmooth() also!

for(int i=0;i<150;i++) // REPEAT 150 TIMES
  line(i,i,500,150);   // SINGLE ACTION
  
// https://github.com/borkowsk/bookProcessingEN
