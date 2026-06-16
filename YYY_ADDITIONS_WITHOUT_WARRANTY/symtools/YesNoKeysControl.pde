/// Simulation control module.
/// @date 2026-06-12 (creation)
//*/////////////////////////////////////////////////////////////////////////////

void keyPressed() //key pressed example. See also: processing-3.5.4/modes/java/reference/keyPressed_.html
{
  if(key==ESC) key=0; //Do not exit on ESCAPE //<>//
  else
  if(key=='Q') key=ESC; // Exit on Q
}
