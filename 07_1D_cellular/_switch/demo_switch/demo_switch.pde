// Demonstration of very useful switch-case construction.
//-/////////////////////////////////////////////////////////////

 
int num = 1;

switch(num) {
case 0: 
  println("Zero");  // Does not execute, when num==1
  break;
case 1: 
  println("One");   // Prints "One"
  break;
}

char letter = 'N';

switch(letter) {
case 'A': 
  println("Alpha");  // Does not execute, when letter=='N'
  break;
case 'B': 
  println("Bravo");  // Does not execute, when letter=='N'
  break;
default:             // Default executes if the case labels
  println("None");   // don't match the switch parameter
  break;
}

// Removing a "break" enables testing
// for more than one value at once

char alphanumeric = 'b';

switch(alphanumeric) {
case 'a':
case 'A': 
  println("Alpha");  // Does not execute
  break;
case 'b':
case 'B': 
  println("Bravo");  // Prints "Bravo", when alphanumeric == 'b' or 'B'
  break;
case '0': 
case '1': 
  println("Bit");    // Prints "Bit"
  break;  
}

// We can also put more than one instruction for each `case`

char colorcode = 'G';

switch(colorcode) {
case 'R': fill(255,0,0); stroke(128,0,0); break;
case 'G': fill(0,255,0); stroke(0,128,0); break;
case 'B': fill(0,0,255); stroke(0,0,128); break;
case 'W': fill(255); stroke(128); break;
case 'K': fill(0);   stroke(128); break;
default:  fill(200,128,0); stroke(64,64,0); break;
}  

ellipse(width/2,height/2,50,50);
  
