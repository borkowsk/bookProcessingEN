// Komponenty G4P odpowiadające formularzowi konfiguracyjnemu z Delphi
import g4p_controls.*;

GWindow    setupWindow;
GButton    OKButton;
GTextField RdzenStringEdit;
GTextField ZaludnienieFloatEdit, PoziomSzumuEdit;
GCheckbox  UzyjWplywuDlaPostawCheckBox, StresZageszczeniaCheckBox;
GTextField DlBokuSpinEdit, IlePostawSpinEdit1, MaxSilaSpinEdit1, RozkladSpinEdit;
GTextField KosztKrokuSpinEdit, OptimumZapasuSpinEdit;
GTextField WidthSpinEdit, HeightSpinEdit, SideSpinEdit1, VisfreqSpinEdit2;
GTextField SlabyAgentSpinEdit1, BrzegSpinEdit1, ChwilaSpinEdit2, MaxKrokSpinEdit3;
GTextField WyplataSpinEdit00, WyplataSpinEdit10, WyplataSpinEdit01, WyplataSpinEdit11;

//GButton StartButton;

void setupWindowDraw(PApplet appc, GWinData data) { //data nie uzywane bo nie ma po co :-D
  appc.background(240);
  
  // Delikatne obrysy sekcji dla przejrzystości (odpowiednik GroupBox z Delphi)
  //appc.stroke(200);
  //appc.noFill();
  //appc.rect(10, 10, 345, 310); // Ramka lewa
  //appc.rect(360, 10, 210, 220); // Ramka tabeli wypłat
}

void createGUI() {
  G4P.messagesEnabled(false);
  setupWindow = GWindow.getWindow(this, "Ustawienia symulacji", 0, 0, 600, 400, JAVA2D);
  setupWindow.noLoop(); //<>//
  setupWindow.addDrawHandler(this,"setupWindowDraw");
  
  // Etykiety i pola sterujące w oknie G4P
  OKButton = new GButton(setupWindow, 225, 355, 153, 25, "OK / Zastosuj");
  OKButton.addEventHandler(this, "OKButtonClick");
  
  //StartButton = new GButton(setupWindow, 400, 395, 153, 25, "START / RESET");
  //StartButton.addEventHandler(this, "StartButtonClick");
  
  RdzenStringEdit = new GTextField(setupWindow, 8, 280, 340, 25);
  RdzenStringEdit.setText(FileNameCore);
  RdzenStringEdit.addEventHandler(this, "RdzenStringEditChange");
  
  // Pola parametrów siatki i ekonomii
  DlBokuSpinEdit = new GTextField(setupWindow, 16, 60, 65, 22);
  DlBokuSpinEdit.setText(str(Bok));
  DlBokuSpinEdit.addEventHandler(this, "DlBokuSpinEditChange");
  
  ZaludnienieFloatEdit = new GTextField(setupWindow, 16, 120, 65, 22);
  ZaludnienieFloatEdit.setText(str((float)Zaludnienie));
  ZaludnienieFloatEdit.addEventHandler(this, "ZaludnienieFloatEditChange");

  IlePostawSpinEdit1 = new GTextField(setupWindow, 16, 90, 65, 22);
  IlePostawSpinEdit1.setText(str(IlePostaw));
  IlePostawSpinEdit1.addEventHandler(this, "IlePostawSpinEdit1Change");

  MaxSilaSpinEdit1 = new GTextField(setupWindow, 16, 150, 65, 22);
  MaxSilaSpinEdit1.setText(str(MaxSila));
  MaxSilaSpinEdit1.addEventHandler(this, "MaxSilaSpinEdit1Change");

  RozkladSpinEdit = new GTextField(setupWindow, 16, 180, 65, 22);
  RozkladSpinEdit.setText(str(Rozklad));
  RozkladSpinEdit.addEventHandler(this, "RozkladSpinEditChange");

  PoziomSzumuEdit = new GTextField(setupWindow, 16, 210, 65, 22);
  PoziomSzumuEdit.setText(str((float)PoziomSzumu));
  PoziomSzumuEdit.addEventHandler(this, "PoziomSzumuEditChange");

  KosztKrokuSpinEdit = new GTextField(setupWindow, 305, 128, 57, 22);
  KosztKrokuSpinEdit.setText(str(KosztKroku));
  KosztKrokuSpinEdit.addEventHandler(this, "KosztKrokuSpinEditChange");

  OptimumZapasuSpinEdit = new GTextField(setupWindow, 305, 160, 57, 22);
  OptimumZapasuSpinEdit.setText(str(OptimumZapasu));
  OptimumZapasuSpinEdit.addEventHandler(this, "OptimumZapasuSpinEditChange");

  // Tabela wypłat
  WyplataSpinEdit00 = new GTextField(setupWindow, 375, 60, 70, 25);
  WyplataSpinEdit00.setText(str(TabelaWyp[0][0]));
  WyplataSpinEdit00.addEventHandler(this, "WyplataSpinEdit00Change");

  WyplataSpinEdit10 = new GTextField(setupWindow, 450, 60, 70, 25);
  WyplataSpinEdit10.setText(str(TabelaWyp[1][0]));
  WyplataSpinEdit10.addEventHandler(this, "WyplataSpinEdit10Change");

  WyplataSpinEdit01 = new GTextField(setupWindow, 375, 90, 70, 25);
  WyplataSpinEdit01.setText(str(TabelaWyp[0][1]));
  WyplataSpinEdit01.addEventHandler(this, "WyplataSpinEdit01Change");

  WyplataSpinEdit11 = new GTextField(setupWindow, 450, 90, 70, 25);
  WyplataSpinEdit11.setText(str(TabelaWyp[1][1]));
  WyplataSpinEdit11.addEventHandler(this, "WyplataSpinEdit11Change");

  UzyjWplywuDlaPostawCheckBox = new GCheckbox(setupWindow, 69, 240, 185, 17, "Używaj wpływu dla postaw");
  StresZageszczeniaCheckBox = new GCheckbox(setupWindow, 344, 240, 165, 17, "Stres zageszczenia");

  // --- ETYKIETY (GLabel) ODPOWIADAJĄCE ORYGINAŁOWI Z DELPHI ---
  
  // Główne ostrzeżenie na górze
  GLabel tmp=new GLabel(setupWindow, 8, 5, 480, 30, "UWAGA! Jedynie zmiana parametrów przed uruchomieniem wątku roboczego daje pewność efektu!"); assert(tmp!=null);
  
  // Zakładka / Sekcja: Parametry pojedynczego eksperymentu (lewa strona)
  tmp=new GLabel(setupWindow, 85, 60, 180, 20,  "Długość boku świata symulacji"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 90, 180, 20,  "Liczba postaw"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 120, 180, 20, "Gęstość zaludnienia"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 150, 180, 20, "Maksymalna energia agenta"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 180, 180, 20, "Stopień rozkładu \"Pareto\""); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 85, 210, 210, 20, "Prawdopodobieństwo zmian postaw"); assert(tmp!=null);

  // Kolumna prawa: Koszt i optymalny zapas
  tmp=new GLabel(setupWindow, 365, 130, 160, 20, "Koszt utrzymania (na krok)"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 365, 160, 180, 20, "Optymalny zapas (w krokach)"); assert(tmp!=null);

  // Tabela wypłat (nagłówki osi)
  tmp=new GLabel(setupWindow, 305, 60, 70, 25, "Kooperacja"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 305, 90, 70, 25, "Rywalizacja"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 375, 30, 70, 25, "Kooperacja"); assert(tmp!=null);
  tmp=new GLabel(setupWindow, 450, 30, 70, 25, "Rywalizacja"); assert(tmp!=null);

  // Dół formularza: Rdzeń nazwy pliku
  tmp=new GLabel(setupWindow, 360, 280, 260, 25, "Rdzeń nazwy pliku wyjściowego"); assert(tmp!=null);

  G4P.messagesEnabled(true);
  setupWindow.loop();
}

// Obsługa zdarzeń zmian i przycisków w G4P odwzorowująca logikę Delphi
public void OKButtonClick(GButton button, GEvent event) {
  if (event == GEvent.CLICKED) { //<>//
    println("OK clicked - simulation will start.");
    ileTrzeba=(Bok+2)*(Rozmiar+Brzeg);
    UzyjWplywuDlaPostaw = UzyjWplywuDlaPostawCheckBox.isSelected();
    if(UzyjWplywuDlaPostaw) println("Social influence on attitudes is active.");
    StresZageszczenia = StresZageszczeniaCheckBox.isSelected();
    if(StresZageszczenia) println("Overcrowding stress is active.");
    uruchomSymulacje(); assert(SwiatSymulacji!=null);
    //setupWindow.hide();  //tego nie ma?
    //setupWindow.close(); //a to nie działa :-/
    //setupWindow.dispose(); //i to też nie działa...
    setupWindow.forceClose(); //A to nareszcie działa!
    isRunning=true;
    loop(); //Teraz już można uruchomić symulację.
  }
}

//public void StartButtonClick(GButton button, GEvent event) {
//  if (event == GEvent.CLICKED) {
//    numerkroku = 0;
//    deficytzycia = 0;
    
//    // Generowanie nazwy pliku logu
//    String logName = FileNameCore + Bok + "x" + Bok + "P" + IlePostaw + "G" + Zaludnienie + "M" + PoziomSzumu + "m" + MaxSila + "k" + KosztKroku + "op" + OptimumZapasu + ".log";
//    logFile = createWriter(logName);
//    logFile.println("Krok\tStres\tEnergiaSr\tEnergiaMax\tLiczby wyznawców");
    
//    Inicjacja(SwiatSymulacji);
//    isRunning = true;
//  }
//}

public void RdzenStringEditChange(GTextField field, GEvent event) {
  FileNameCore = field.getText();
}

public void DlBokuSpinEditChange(GTextField field, GEvent event) {
  try { Bok = int( field.getText() ); } catch(Exception e) {}
}

public void IlePostawSpinEdit1Change(GTextField field, GEvent event) {
  try { IlePostaw = int(field.getText()); } catch(Exception e) {}
}

public void MaxSilaSpinEdit1Change(GTextField field, GEvent event) {
  try { MaxSila = int(field.getText()); } catch(Exception e) {}
}

public void RozkladSpinEditChange(GTextField field, GEvent event) {
  try { Rozklad = int(field.getText()); } catch(Exception e) {}
}

public void KosztKrokuSpinEditChange(GTextField field, GEvent event) {
  try { KosztKroku = int(field.getText()); } catch(Exception e) {}
}

public void OptimumZapasuSpinEditChange(GTextField field, GEvent event) {
  try { OptimumZapasu = int(field.getText()); } catch(Exception e) {}
}

public void WyplataSpinEdit00Change(GTextField field, GEvent event) {
  try { TabelaWyp[0][0] = int(field.getText()); } catch(Exception e) {}
}

public void WyplataSpinEdit11Change(GTextField field, GEvent event) {
  try { TabelaWyp[1][1] = int(field.getText()); } catch(Exception e) {}
}

public void PoziomSzumuEditChange(GTextField field, GEvent event) {
  try { PoziomSzumu = float( field.getText() ); } catch(Exception e) {}
}

public void ZaludnienieFloatEditChange(GTextField field, GEvent event) {
  try { Zaludnienie = float( field.getText() ); } catch(Exception e) {}
}

public void WyplataSpinEdit01Change(GTextField field, GEvent event) {
  try {
    int val = int(field.getText());
    TabelaWyp[0][1] = val;
    TabelaWyp[1][0] = -val;
    WyplataSpinEdit10.setText(str(-val));
  } catch(Exception e) {}
}

public void WyplataSpinEdit10Change(GTextField field, GEvent event) {
  try {
    int val = int(field.getText());
    TabelaWyp[0][1] = val;
    TabelaWyp[1][0] = -val;
    WyplataSpinEdit01.setText(str(-val));
  } catch(Exception e) {}
}
