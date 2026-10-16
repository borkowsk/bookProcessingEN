//-////////////////////////////////////////////////////
// To musi być w setup() żeby było Video:
//
//  initVideoExport(this,FileName,int Frames)); //Klasa VideoExport musi mieć dostęp do obiektu aplikacji Processingu
//                         //Najlepiej wywołać na końcu setupu. Okno musi mieć PARZYSTE rozmiary
//  
//a to dla każdej klatki
//  NextVideoFrame(); //Video frame
//
//na koniec zaś:
//  CloseVideo()
//
import com.hamoid.*; //Oraz importujemy niezbędną biblioteką zawierającą klasę VideoExport

VideoExport videoExport; //KLASA z biblioteki VideoExport Abe Pazosa - trzeba zainstalować
                        //http://funprogramming.org/VideoExport-for-Processing/examples/basic/basic.pde
                        //Oraz zainstalować program ffmpeg żeby działało
int videoFramesFreq=0;           

void initVideoExport(processing.core.PApplet parent, String Name,int Frames)
{
  videoFramesFreq=Frames;
  videoExport = new VideoExport(parent,Name); //Klasa VideoExport musi mieć dostęp do obiektu aplikacji Processingu
  videoExport.setFrameRate(Frames); //Nie za szybko
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
     for(int i=0;i<videoFramesFreq;i++) //Musi trwać sekundę czy coś...
       videoExport.saveFrame(); //Video frame
  }
}

void NextVideoFrame()
{  
   if(videoExportEnabled)
     videoExport.saveFrame(); //Video frame
}
                     
void CloseVideo() //To wołamy gdy chcemy zamknąć
{
  if(videoExport!=null)
  { 
   fill(0);
   text("(c) W.Borkowski @ ISS University of Warsaw",1,height); //Raczej się nie pojawia :-(
   //powinno być jakieś "force screen update", ale nie znalazłem
   for(int i=0;i<videoFramesFreq;i++) //Musi trwać sekundę czy coś...
       videoExport.saveFrame(); //Video frame
   videoExport.saveFrame(); //Video frame - LAST
   videoExport.endMovie(); //"Koniec filma"
   videoExportEnabled=false;
   videoExport=null;
  }
}

static boolean     videoExportEnabled=false; //inicjalizacja ustawi to na "true"

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - MOVIE MAKER 
//-/////////////////////////////////////////////////////////////////////////////////////////
