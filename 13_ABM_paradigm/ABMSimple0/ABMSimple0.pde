/// Simple example of Agent Base Model. Mandatory procedures.
//*//////////////////////////////////////////////////////////

void setup()
{
  size(500,520);
  
  theWorld=new World();
  theWorld.initialise();
  
  println(Model,"Ready!");
}

void draw()
{
  background(128);
  
  visualise(theWorld);
  theWorld.update();
  
  text(str(frameCount)+"("+str(frameRate)+")",0,height);
}

void exit()
{
  println("The end");
  super.exit();
}

/// @date 2025-11-24 (https://github.com/borkowsk/bookProcessingEN/)
