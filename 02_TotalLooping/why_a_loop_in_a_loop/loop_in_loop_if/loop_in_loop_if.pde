/// Loop in loop with use of inequalities.
//*////////////////////////////////////////

//noStroke(); // ellipses without outlines

for(int i=0;i<10;i++)
{
  for(int j=0;j<10;j++)
    if( i+j > 5) // Print only when the condition is met.
    {
      println(i,j); // Console printout
      ellipse(i*10,j*10,4,4); // "Dots" on window
    }
}

// https://github.com/borkowsk/bookProcessingEN
