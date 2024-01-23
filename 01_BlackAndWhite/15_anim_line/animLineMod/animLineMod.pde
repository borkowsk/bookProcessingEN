// infinite line animation using remainder from integer division
//*////////////////////////////////////////////////////////////////

void setup() 
{
  size(300,130);
  frameRate(300);
}

int pos = 0;

void draw() 
{
  background(204);
  line(pos, 20, pos, height-20 );
  pos++;
  // If we use the remainder from integer division then 
  // when 'pos' exceeds 'width' it will return to 0 and so on
  pos=pos % width; // <=> pos %= width;
}

// https://github.com/borkowsk/bookProcessingEN
