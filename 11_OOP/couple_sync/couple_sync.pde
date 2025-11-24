// An another example of using the 'singiel' class
//-///////////////////////////////////////////////

final  float DefaultR=3.5;       //two systems independent of each other, 
final  float DefaultAlpha=0.085; //by changing the alpha value we can change their mutual synchronization

final int   FR=150; //Desired frame rate

// Construct two instances of the class
singiel First =new singiel(0.33,3.69,DefaultAlpha);
singiel Second=new singiel(0.66,3.95,DefaultAlpha);
//singiel First= new singiel(random(1.0),3.55,DefaultAlpha);
//singiel Second=new singiel(random(1.0),3.75,DefaultAlpha);
//singiel First= new singiel(random(1.0),DefaultR+random(0.5),DefaultAlpha);
//singiel Second=new singiel(random(1.0),DefaultR+random(0.5),DefaultAlpha);

int ule=200; //unit of length
int radius=ule/2;

void setup()
{
  size(800,300); //4ule x 1.5ule
  frameRate(FR);
  
  // Check the randomly selected parameters
  println("F: x:",First.x1,"R:",First.r," Alpha:",First.alpha());
  println("S: x:",Second.x1,"R:",Second.r," Alpha:",Second.alpha());
  
  //Black square as a chart background
  fill(0);noStroke();
  rect(ule*1.5,ule*0.25,ule,ule);
}

void draw()
{
  //ALTERNATIVE WAYS OF COLORING
  stroke(255,min(frameCount,255)); // 1.
  //stroke(frameCount%256); // 2.
  //stroke(255-abs(First.x2-Second.x2)*255); // 3.
  //stroke(abs(First.x2-Second.x2)*255); // 4.
  //stroke(255-abs(First.x2-Second.x2)*255,min(frameCount,255),abs(First.x2-Second.x2)*255); // 5.
  //stroke(255-abs(First.x2-Second.x2)*255,frameCount%256,abs(First.x2-Second.x2)*255); // 6.
  //stroke(255-abs(First.x2-Second.x2)*255,frameCount%2*255,abs(First.x2-Second.x2)*255,min(frameCount,255)); // 7.
  
  fill(frameCount%11*25,frameCount%2*255,0,min(frameCount,255)); // 1.
  //fill(255-abs(First.x2-Second.x2)*255,frameCount%2*255,abs(First.x2-Second.x2)*255,min(frameCount,255)); // 2.
 
  point(ule*1.5+ule*First.x2,ule*1.25-ule*Second.x2);// plot point
  view(First, ule,150,radius);// visualize the transition of oscillators 
  view(Second,ule*3,150,radius);// between states
  
  // State Change Implementation Depends On Coupling
  if(DefaultAlpha>0)
    next4couple(First,Second);
  else {  
    First.next();Second.next(); 
  }
    
  //if(frameCount%FR==0) // Print approximately every second
  //  println(frameCount+"*"+ frameRate );//Process progress
}

/// @date 2025-11-24 (https://github.com/borkowsk/bookProcessingEN)
