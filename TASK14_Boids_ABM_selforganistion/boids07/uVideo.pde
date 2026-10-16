/// Tool for made video from simulation. ( "rtmVideo.pde" )
/// @note This optional source file could be copied or linked from OPTIONALS directory.
/// @date 2026-10-05 (Last modification)
//-////////////////////////////////////////////////////////////////////////////////////

/// @defgroup Generally usable functions
/// @{
//-/////////////////////////////////////

//* PL: Narzędzie do tworzenia wideo z symulacji
//*////////////////////////////////////////////////////////////////////////////////////
/// See: http://funprogramming.org/VideoExport-for-Processing/examples/basic/basic.pde
//*
/// USAGE: Apart from the "hamoid" library, you also need to install 
/// the ffmpeg program to make it work !!! 

/*_onlyProcessingBlockBegin*/
import com.hamoid.*; //!< Here we import the necessary library containing the `VideoExport` class
/*_onlyProcessingBlockEnd*/

/// USAGE
//* UŻYCIE:
/// This initVideoExport function call must be in setup() for the Video module to work:
//* To wywołanie funkcji initVideoExport musi być w setup(), aby moduł Video zadziałał:
///
///  initVideoExport(this,FileName,Frames)); // The VideoExport class must have access to
///                                          // the Processing application object
///                                          // It's best to run at the end of the setup().
///                                          // NOTE !!!: The window must be EVEN sizes
//
//                                          // Klasa VideoExport musi mieć dostęp do 
//                                          // obiektu aplikacji Processingu
//                                          // Najlepiej wywołać na koncu setupu. 
//                                          // UWAGA!!!: Okno musi mieć PARZYSTE rozmiary
///  
/// We call Next Video Frame for each frame of the movie, most often in the draw () function:
//* NextVideoFrame wywołujemy dla każdej klatki filmu, najczęściej w funkcji draw():
///
///  NextVideoFrame();//Video frame
///
/// ... and at the end of the video we call CloseVideo:
//* ... a na koniec filmu wywołujemy CloseVideo:
///
///  CloseVideo(); // Ideally in exit ()
//*                // Najlepiej w exit()
///

/*_OnlyProcessingBlockBegin*/
VideoExport        videoExport;              //* Obiekt KLASY z dodatkowej biblioteki - trzeba zainstalować (NIE MA GO W C++)
/*_onlyProcessingBlockEnd*/
                                             //*  CLASS object from additional library - must be installed
static int         videoFramesFreq=0;        ///< How many frames per second for the movie. It doesn't have to be the same as in frameRate!
                                             //*  Ile klatek w sekundzie filmu. Nie musi być to samo co w frameRate!   
static boolean     videoExportEnabled=false; ///< Has film making been initiated?
                                             //*   Czy tworzenie filmu zostało zainicjowane?
String copyrightNote="(c) W.Borkowski @ ISS University of Warsaw"; ///< Change it to your copyright. Best in setup().
                                       
                                                                   //*  To zmień na swój copyright. Najlepiej w setup().  

/// The beginning of the movie file
//*  Początek pliku filmowego
void initVideoExport(processing.core.PApplet parent, String Name,int Frames) {   ///< @note GLOBAL dummy in C++
  /*_OnlyProcessingBlockBegin*/
  videoFramesFreq=Frames;
  videoExport = new VideoExport(parent,Name); //Klasa VideoExport musi mieć dostep do obiektu aplikacji Processingu
  videoExport.setFrameRate(Frames); //Nie za szybko
  videoExport.startMovie();
  fill(0,128,255);text(Name,1,20);
  videoExportEnabled=true;
  /*_onlyProcessingBlockEnd*/
}

                
/// Initial second sequence for title and copyright
//* Początkowa sekundowa sekwencja na tytuł i copyright
void FirstVideoFrame()                                                          ///< @note GLOBAL dummy in C++
{ /*_OnlyProcessingBlockBegin*/
  if(videoExportEnabled)
  {  
     fill(0,128,255);text(copyrightNote,1,height); 
     //text(videoExport.VERSION,width/2,height);
     delay(200);
     for(int i=0;i<videoFramesFreq;i++) //Musi trwać sekundę czy coś...
       videoExport.saveFrame(); //Video frame
  }
  /*_onlyProcessingBlockEnd*/
}

/// Each subsequent frame of the movie
//* Każda kolejna klatka filmu
void NextVideoFrame()                                                           ///< @note GLOBAL dummy in C++
{  /*_OnlyProcessingBlockBegin*/
   if(videoExportEnabled)
     videoExport.saveFrame(); //Video frame
   /*_onlyProcessingBlockEnd*/  
}
                     
/// This is what we call when we want to close the movie file.
/// This function adds an ending second sequence with an author's note
//* PL: To wołamy gdy chcemy zamknąć plik filmu.
//* PL: Funkcja dodaje kończącą sekundową sekwencje z notą autorską.
/// NOTE: there should be some "force screen update", but not found
/// If you x-click the window while drawing, it is the last frame
/// will probably be incomplete
//* UWAGA: powinno być jakieś "force screen update", ale nie znalazłem
//* Jeśli kliknięcie x okna nastąpi w trakcie rysowania to ostatnia klatka
//* będzie prawdopodobnie niekompletna.
void CloseVideo()                                                               ///< @note GLOBAL dummy in C++
{ /*_OnlyProcessingBlockBegin*/
  if(videoExport!=null)
  { 
   fill(255);
   textAlign(BOTTOM,LEFT);
   text(copyrightNote,1,height);
   delay(200);

   for(int i=0;i<videoFramesFreq;i++) //Have to last about one second
       videoExport.saveFrame(); //Video frames for final freeze
       
   videoExport.saveFrame(); //Video frame - LAST
   videoExport.endMovie();  //Koniec filma
  }
  /*_onlyProcessingBlockEnd*/
}

//*/////////////////////////////////////////////////////////////////////////////
//*  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - OPTIONAL TOOLS 
//*  - FUNCTIONS & CLASSES
//*  https://github.com/borkowsk/sym4processing
/// @}
//*/////////////////////////////////////////////////////////////////////////////
