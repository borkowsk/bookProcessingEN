//-////////////////////////////////////////////////////
// To musi być w setup() żeby było Video:
//
//  initVideoExport(this,FileName,int Frames)); //The VideoExport class must have access to the Processing application object.
//                         //It is best to call it at the end of the setup. The window must have EVEN dimensions
//  
//a to dla każdej klatki
//  NextVideoFrame(); //Video frame
//
//na koniec zaś:
//  CloseVideo()
//
import com.hamoid.*; //And we import the necessary Processing library containing the VideoExport class

VideoExport videoExport; //CLASS from Abe Pazos's VideoExport library - must be installed
                        // http://funprogramming.org/VideoExport-for-Processing/examples/basic/basic.pde
                        //And install the ffmpeg program for it to work
int videoFramesFreq=0;           

void initVideoExport(processing.core.PApplet parent, String Name,int Frames)
{
  videoFramesFreq=Frames;
  videoExport = new VideoExport(parent,Name); //The VideoExport class must have access to the Processing application object.
  videoExport.setFrameRate(Frames); //Not too fast
  videoExport.startMovie();
  text(Name,1,20);
  videoExportEnabled=true;
}
                        
void FirstVideoFrame()
{
  if(videoExportEnabled)
  {  
     fill(0,128,255);
     text("(c) W.Borkowski @ ISS University of Warsaw",1,height); 
     //text(videoExport.VERSION,width/2,height);
     delay(200);
     for(int i=0;i<videoFramesFreq;i++) //It must last a second or something...
       videoExport.saveFrame(); //Video frame
  }
}

void NextVideoFrame()
{  
   if(videoExportEnabled)
     videoExport.saveFrame(); //Video frame
}
                     
void CloseVideo() //This is what we call when we want to close
{
  if(videoExport!=null)
  { 
   fill(0);
   text("(c) W.Borkowski @ ISS University of Warsaw",1,height); //It probably won't appear :-(
   //There should be some "force screen update", but I didn't find it
   for(int i=0;i<videoFramesFreq;i++) //It must last a second or something...
       videoExport.saveFrame(); //Video frame
   videoExport.saveFrame(); //Video frame - LAST
   videoExport.endMovie(); //Konec filmu ("The End" in Czech)
   videoExportEnabled=false;
   videoExport=null;
  }
}

static boolean     videoExportEnabled=false; //initialization will set this to "true"

//-/////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: MOVIE MAKER 
//-/////////////////////////////////////////////////////////////////////////////////////////
