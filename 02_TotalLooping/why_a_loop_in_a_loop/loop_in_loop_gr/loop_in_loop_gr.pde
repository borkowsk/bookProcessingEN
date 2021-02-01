//Loop in loop - note the curly braces {}
//noStroke();//ellipses without outlines
for(int i=0;i<10;i++)
{
  for(int j=0;j<10;j++)
  {
    println(i,j);//Console printout
    //fill(i*20,j*20,0);//RED+GREEN = shades of red & green & yellow
    ellipse(i*10,j*10,4,4);//"Dots" on window
  }
}

//https://github.com/borkowsk/bookProcessingEN
