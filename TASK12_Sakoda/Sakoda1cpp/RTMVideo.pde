///   Tool for made video from simulation 
///   It is based on strictly Processing library, so under C++ is only a dummy for linking
//*/////////////////////////////////////////////////////////////////////////////////////////
// http://funprogramming.org/VideoExport-for-Processing/examples/basic/basic.pde
//
// Trzeba zainstalować program ffmpeg żeby działało!!!

/*_onlyProcessingBlockBegin*/
import com.hamoid.*; //Oraz importujemy niezbędną biblioteką zawierającą klasę VideoExport
/*_onlyProcessingBlockEnd*/

// USAGE:
// To wywołanie musi być w setup() żeby zadziałało Video:
//
//  initVideoExport(this,FileName,int Frames)); // Klasa VideoExport musi mieć dostęp do obiektu aplikacji Processing-u
//                                              // Najlepiej wywołać na końcu setupu.
//                                              // UWAGA!!!: Okno musi mieć PARZYSTE rozmiary
//  
// a to wywołujemy dla każdej klatki
//  NextVideoFrame();//Video frame
//
// a na koniec zaś:
//  CloseVideo(); //Powinno być w exit()
//
/*_OnlyProcessingBlockBegin*/
VideoExport        videoExport;  //< KLASA z biblioteki VideoExport Abe Pazosa - trzeba zainstalować
/*_onlyProcessingBlockEnd*/
static int         videoFramesFreq=0;        ///< need be really visible globally!
static boolean     videoExportEnabled=false; ///< init will set up it for true

/*_OnlyProcessingBlockBegin*/
void initVideoExport(processing.core.PApplet parent, String Name,int Frames)
{ 
  videoFramesFreq=Frames;
  videoExport = new VideoExport(parent,Name); //Klasa VideoExport musi mieć dostęp do obiektu aplikacji Processing-u
  videoExport.setFrameRate(Frames); //Nie za szybko
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
     for(int i=0;i<videoFramesFreq;i++) //Musi trwać sekundę czy coś...
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
                     
void CloseVideo() ///< To wołamy gdy chcemy zamknąć
{  /*_OnlyProcessingBlockBegin*/
  if(videoExport!=null)
  { 
   fill(0);
   text("(c) W.Borkowski @ ISS University of Warsaw",1,height); //Może się nie zdążyć pojawić
   //powinno być jakieś "force screen update", ale nie znalazłem
   for(int i=0;i<videoFramesFreq;i++) //Musi trwać sekundę czy coś...
       videoExport.saveFrame(); //Video frame
   videoExport.saveFrame(); //Video frame - LAST
   videoExport.endMovie();  //Konec filma ;-)
  } /*_onlyProcessingBlockEnd*/
}

//*/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - MOVIE MAKER 
//*/////////////////////////////////////////////////////////////////////////////////////////
