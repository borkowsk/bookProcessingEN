// Infinite line animation using remainder from integer division.
//*///////////////////////////////////////////////////////////////

void setup() 
{
  size(300,130);
  frameRate(60);
}

int posX = 0; ///< GLOBAL SCOPE.
int posY = 0; ///< GLOBAL SCOPE.

void draw() 
{ //extern posX,posY; // Used from global scope.
  background(204);
  line(posX,posY,posX+50,posY+20 );
  
  // Different speed of change for X and Y
  posY+=2;
  posX+=1;
  
  // Now we use the remainder from integer division
  posX=posX % width;
  posY=posY % height;
}

// https://github.com/borkowsk/bookProcessingEN
