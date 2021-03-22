//  Dopasowana do modelu obsługa zdarzeń
///////////////////////////////////////////////////
int searchedX=-1;
int searchedY=-1;
boolean Clicked=false;
Agent  theSelected=null; 

double minDist2Selec=MAX_INT;
double maxTransSelec=-MAX_INT;

void mouseClicked()
{
  Clicked=true;
  theSelected=null;
  searchedX=mouseX;
  searchedY=mouseY; //Searching should be implemented in visialisation!
}

void keyPressed() 
{
  println("RECIVED:'",key,"\' CODE:",int(key)); 
  switch(key)
  {
  case '1': STEPSperVIS=1;background(255,255,200);text("StPerV: "+STEPSperVIS,1,16);break;
  case '2': STEPSperVIS=2;background(255,255,200);text("StPerV: "+STEPSperVIS,1,16);break;
  case '3': STEPSperVIS=5;background(255,255,200);text("StPerV: "+STEPSperVIS,1,16);break;
  case '4': STEPSperVIS=10;background(255,255,200);text("StPerV: "+STEPSperVIS,1,16);break;
  case '5': STEPSperVIS=25;background(255,255,200);text("StPerV: "+STEPSperVIS,1,16);break;
  case '6': STEPSperVIS=50;background(255,255,200);text("StPerV: "+STEPSperVIS,1,16);break;
  case '7': STEPSperVIS=100;background(255,255,200);text("StPerV: "+STEPSperVIS,1,16);break;
  case '8': STEPSperVIS=150;background(255,255,200);text("StPerV: "+STEPSperVIS,1,16);break;
  case '9': STEPSperVIS=200;background(255,255,200);text("StPerV: "+STEPSperVIS,1,16);break;
//  case '0': STEPSperVIS=1;DeltaMC=0.2;text("DeltaMC: "+DeltaMC,1,16);break;
  case ' ': save(modelName+"."+nf((float)TheWorld.getTimeStep(),6,5)+".PNG");
            //write(world,modelName+"."+nf((float)StepCounter,6,5));//Aktualny stan ekosystemu
            break;
  case ESC: simulationRun=!simulationRun; break;
  case 's': simulationRun=false; break;
  case 'r': simulationRun=true; break;
  default:println("Command '"+key+"' unknown");
          println("USE:");
          println("1-9 for less frequent visualisation");
          println("  0 for most frequent visualisation");
          println("ESC,r,s for pause/run simulation");
          println("SPACE for dump the current screen\n"); 
  break;
  }
  
  if (key == ESC) 
  {
    key = 0;  // Fools! don't let them escape!
  }
}


///////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EVENTS TEMPLATE
///////////////////////////////////////////////////////////////////////////////////////////
