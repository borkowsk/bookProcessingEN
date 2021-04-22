//"line" animation with setup()
/////////////////////////////////

void setup() 
{
  frameRate(15);
  size(300,200);
  strokeWeight(2);//Bold lines!
}

int pos = 0;

void draw() 
{
  background(204);
  line(pos, 20, pos, 180);
  pos++;
}

//https://github.com/borkowsk/bookProcessingEN

