# Identifiers changing map (from Polish version)

## Oto propozycja anglojęzycznych odpowiedników dla polskich identyfikatorów 
znajdujących się w plikach PrizonersInProcessing.pde oraz SetupFormForPrizonersG4P.pde:

* 1. Pola klasy Agent
- pogląd $\rightarrow$ attitude (lub opinion)
- sila $\rightarrow$ strength (lub energy)
- stres $\rightarrow$ stress


* 2. Zmienne i stałe globalne (Parametry symulacji i środowisko)
- MaxBok $\rightarrow$ MAX_SIDE_LENGTH
- MaxIlePostaw $\rightarrow$ MAX_ATTITUDES_COUNT
- MinPoziomSzumu / MaxPoziomSzumu $\rightarrow$ MIN_NOISE_LEVEL / MAX_NOISE_LEVEL
- MinZaludnienie / MaxZaludnienie $\rightarrow$ MIN_POPULATION_DENSITY / MAX_POPULATION_DENSITY
- Bok $\rightarrow$ sideLength (lub gridSize)
- IlePostaw $\rightarrow$ attitudesCount
- Zaludnienie $\rightarrow$ populationDensity
- MaxSila $\rightarrow$ maxStrength
- Rozklad $\rightarrow$ paretoExponent (lub distributionPower)
- KosztKroku $\rightarrow$ stepCost
- OptimumZapasu $\rightarrow$ optimumReserve
- TabelaWyp $\rightarrow$ payoffMatrix
- UzyjWplywuDlaPostaw $\rightarrow$ useSocialInfluence
- StresZageszczenia $\rightarrow$ useCrowdingStress
- PoziomSzumu $\rightarrow$ noiseLevel
- Rozmiar $\rightarrow$ agentCellSize
- NajmRoz $\rightarrow$ minAgentRenderSize
- Brzeg $\rightarrow$ borderSize
- CzestoscWizualizacji $\rightarrow$ visualizationFrequency
- Chwila $\rightarrow$ stepDelayMs
- MaxKrok $\rightarrow$ maxSteps
- SwiatSymulacji $\rightarrow$ simulationWorld
- numerkroku $\rightarrow$ currentStep
- deficytzycia $\rightarrow$ birthDeficit
- Wyznawcy $\rightarrow$ attitudeCounts (lub followersCount)
- ileTrzeba $\rightarrow$ requiredWindowSize
- StresGlobalny_arr $\rightarrow$ globalStress
- ArrSilaSrednia_arr $\rightarrow$ meanStrengthArrSila
- Max_arr $\rightarrow$ maxStrengthArr

* 3. Nazwy funkcji i metod
- uruchomSymulacje $\rightarrow$ runSimulation
- Inicjacja $\rightarrow$ initializeWorld
- Przeskaluj $\rightarrow$ rescale (lub normalize)
- Przelogarytmuj $\rightarrow$ applyLogScale
- Wizualizacja $\rightarrow$ drawWorld (lub renderWorld)
- OpcjonalnyWplywSpoleczny $\rightarrow$ applySocialInfluence
- PoliczStresy $\rightarrow$ calculateStressLevels
- ZyjIUmieraj $\rightarrow$ updateMetabolismAndMovement
- KooperujRywalizuj $\rightarrow$ interactCooperateDefect
- KrokSymulacji $\rightarrow$ simulationStep
- PoliczStatystyki $\rightarrow$ calculateStatistics

* 4. Funkcje i zmienne pomocnicze (wewnątrz metod)

W OpcjonalnyWplywSpoleczny / InnerHelper:

- ZliczWplywy $\rightarrow$ countInfluences
- Ustalpoglad $\rightarrow$ determineAttitude
- Liczniki / liczniki $\rightarrow$ counts
- lewo, prawo, gora, dol $\rightarrow$ left, right, top, bottom
- nowy $\rightarrow$ newAttitude

W PoliczStresy / StresHelper:

- ZliczSasiadow $\rightarrow$ countNeighbors
- licznik $\rightarrow$ neighborCount
- Wartosc $\rightarrow$ reserveRatio

W ZyjIUmieraj / ZyjHelper:

- SprobujRuchu $\rightarrow$ tryMove
- Przesuwaj $\rightarrow$ moveAgent
- ZasiejNowego $\rightarrow$ spawnNewAgent
- kierunek $\rightarrow$ direction

W KooperujRywalizuj / KoopHelper:

- SprobujPole $\rightarrow$ isValidNeighborCell
- Decyzja $\rightarrow$ getDecision

* 5. Komponenty i zdarzenia GUI (SetupFormForPrizonersG4P.pde)
- RdzenStringEdit $\rightarrow$ fileCoreTextField
- ZaludnienieFloatEdit $\rightarrow$ densityTextField
- PoziomSzumuEdit $\rightarrow$ noiseTextField
- UzyjWplywuDlaPostawCheckBox $\rightarrow$ socialInfluenceCheckBoxStres
- ZageszczeniaCheckBox $\rightarrow$ crowdingStressCheckBox
- DlBokuSpinEdit $\rightarrow$ sideLengthTextField
- IlePostawSpinEdit1 $\rightarrow$ attitudesCountTextFieldMax
- SilaSpinEdit1 $\rightarrow$ maxStrengthTextField
- RozkladSpinEdit $\rightarrow$ distributionTextField
- KosztKrokuSpinEdit $\rightarrow$ stepCostTextField
- OptimumZapasuSpinEdit $\rightarrow$ optimumReserveTextField
- WyplataSpinEdit00 $\ldots$ WyplataSpinEdit11 $\rightarrow$ payoffMatrixTextField00 $\ldots$ payoffMatrixTextField11
- SlabyAgentSpinEdit1, BrzegSpinEdit1, ChwilaSpinEdit2, MaxKrokSpinEdit3 $\rightarrow$ weakAgentTextField, borderTextField, delayTextField, maxStepsTextField
- setupWindowDraw $\rightarrow$ drawSetupWindow
- RdzenStringEditChange $\rightarrow$ onFileCoreChanged
- DlBokuSpinEditChange $\rightarrow$ onSideLengthChanged
- IlePostawSpinEdit1Change $\rightarrow$ onAttitudesCountChanged
- MaxSilaSpinEdit1Change $\rightarrow$ onMaxStrengthChanged
- RozkladSpinEditChange $\rightarrow$ onDistributionChanged
- KosztKrokuSpinEditChange $\rightarrow$ onStepCostChangedOptimumZapasuSpinEditChange $\rightarrow$ onOptimumReserveChanged
- WyplataSpinEdit00Change $\ldots$ WyplataSpinEdit11Change $\rightarrow$ onPayoff00Changed $\ldots$ onPayoff11Changed
- PoziomSzumuEditChange $\rightarrow$ onNoiseLevelChanged
