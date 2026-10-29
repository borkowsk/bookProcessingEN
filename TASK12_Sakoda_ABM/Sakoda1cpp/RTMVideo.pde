///   Tool for made video from simulation 
///   It is based on strictly Processing library, so under C++ is only a dummy for linking
//*/////////////////////////////////////////////////////////////////////////////////////////
/// http://funprogramming.org/VideoExport-for-Processing/examples/basic/basic.pde
//
// You need to install ffmpeg for it to work!!!

/*_onlyProcessingBlockBegin*/
import com.hamoid.*; //And we import the necessary Processing library containing the VideoExport class
/*_onlyProcessingBlockEnd*/

// USAGE:
// This call must be in setup() for it to work Video:
//
//  initVideoExport(this,FileName,int Frames)); // The VideoExport class must have access to the Processing application object.
//                                              // It is best to call it at the end of the setup.
//                                              // NOTE!!!: The window must be EVEN in size
//  
// and we call this for each frame
//  NextVideoFrame(); //Video frame
//
// and finally:
//  CloseVideo(); //Should be called in exit()
//
/*_OnlyProcessingBlockBegin*/
VideoExport        videoExport;              ///< CLASS from Abe Pazosa's VideoExport library - must be installed
/*_onlyProcessingBlockEnd*/
static int         videoFramesFreq=0;        ///< need be really visible globally!
static boolean     videoExportEnabled=false; ///< Initialisation will set up it for true

/*_OnlyProcessingBlockBegin*/
void initVideoExport(processing.core.PApplet parent, String Name,int Frames)
{ 
  videoFramesFreq=Frames;
  videoExport = new VideoExport(parent,Name); //The VideoExport class must have access to the Processing application object.
  videoExport.setFrameRate(Frames); //Not too fast
  videoExport.startMovie();
  fill(0,128,255);text(Name,1,20);
  videoExportEnabled=true;  
}
/*_onlyProcessingBlockEnd*/

void FirstVideoFrame() ///< need be really visible globally!
{ /*_OnlyProcessingBlockBegin*/
  if(videoExportEnabled)
  {  
     fill(0,128,255);text("(c) W.Borkowski @ ISS University of Warsaw",1,height); 
     //text(videoExport.VERSION,width/2,height);
     delay(200);
     for(int i=0;i<videoFramesFreq;i++) //It must last a second or something...
       videoExport.saveFrame(); //Video frame
  } 
  /*_onlyProcessingBlockEnd*/
}

void NextVideoFrame() ///< need be really visible globally!
{  /*_OnlyProcessingBlockBegin*/
   if(videoExportEnabled)
     videoExport.saveFrame(); //Video frame
   /*_onlyProcessingBlockEnd*/  
}
                     
void CloseVideo() ///< This is what we call when we want to close
{  /*_OnlyProcessingBlockBegin*/
  if(videoExport!=null)
  { 
   fill(0);
   text("(c) W.Borkowski @ ISS University of Warsaw",1,height); //It may not show up in time
   //There should be some "force screen update", but I didn't find it
   for(int i=0;i<videoFramesFreq;i++) //It must last a second or something...
       videoExport.saveFrame(); //Video frame
   videoExport.saveFrame(); //Video frame - LAST
   videoExport.endMovie();  //Konec filma ;-)
  } /*_onlyProcessingBlockEnd*/
}

//*/////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: MOVIE MAKER 
//*/////////////////////////////////////////////////////////////////////////////////////////
