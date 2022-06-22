/// 150 ellipses -> cone

size(500,500);
background(0); //Black background (0 brightness)
stroke(200);

for(int i=0;i<150;i++) //REPEAT 150 times
   ellipse(100+i,100+i,1+i,1+i); //"i" modifies every parameter
 
// https://github.com/borkowsk/bookProcessingEN
