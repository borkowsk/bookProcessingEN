/// Simulation control module.
/// @date 2025-01-13 (modification)
//*/////////////////////////////////////////////////////////////////////////////

void keyPressed() //when key pressed, the numbers 1 to 9 change the speed and 'Q' ends the simulation.
{
  if(key==ESC) key=0; //Do not exit on ESCAPE //<>//
  else
  switch(key){
    case '1': frameRate(1); break; 
    case '2': frameRate(2); break;
    case '3': frameRate(3); break;
    case '4': frameRate(4); break;
    case '5': frameRate(5); break;
    case '6': frameRate(10); break;
    case '7': frameRate(100); break;
    case '8': frameRate(200); break;
    case '9': frameRate(1000); break;
    case '0': frameRate(DEFAULT_FRAME_RATE); break;
    case 'Q': key=ESC;
  }
}
