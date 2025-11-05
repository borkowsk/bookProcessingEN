/// 50 lines in shades of Prussian blue (cyan).
//*/////////////////////////////////////////////

size(500,500);
background(100,0,0);

// Comment on first line below or the other!
noSmooth(); //No anti-aliasing
//smooth(); //With anti-aliasing

for(int i=0;i<500;i+=10) // REPEAT 50x every 10
{
  stroke(0,i,i);
  line(i,i,0,500);
}

// https://github.com/borkowsk/bookProcessingEN
