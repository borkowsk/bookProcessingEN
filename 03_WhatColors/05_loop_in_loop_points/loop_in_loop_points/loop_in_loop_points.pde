/// Loop in loop - note the curly braces {}

size(256,256);

for(int i=0;i<256;i++)
{
  for(int j=0;j<256;j++)
  { 
    //Choose only one of the stroke() statements
    //stroke(i,0,0); //RED only    
    //stroke(0,j,0); //GREEN only
    //stroke(0,0,j); //BLUE only
    //stroke(i,j,0); //RED+GREEN = shades of red & green & yellow
    stroke(i,0,j);   //RED+BLUE = shades of magenta
    //stroke(0,j,i); //GREEN+BLUE = shades of cyan
    point(j,255-i);  //2D gradient of colors
  }
}

// https://github.com/borkowsk/bookProcessingEN
