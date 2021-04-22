//Two statement in a loop

size(500,500);//Larger window size needed
noSmooth();//Without smoothing outlines

for(int i=0;i<256;i++) //REPEAT 256 TIMES
{ //code block START
  stroke(i);
  line(i*2,i*2,0,500);
} //END

//https://github.com/borkowsk/bookProcessingEN

