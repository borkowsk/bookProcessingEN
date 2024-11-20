/// 150 ellipses -> cone.
//*//////////////////////

size(500,500);
background(0,0,128); // Dark blue background.
stroke(200);

for(int i=0;i<150;i++) // REPEAT 150 times
{
   stroke(i,0,0); // from black to dark red
   ellipse(100+i,100+i,1+i,1+i);
}

// https://github.com/borkowsk/bookProcessingEN
