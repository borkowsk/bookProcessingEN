//Automagically generated file
//Dont edit!
#pragma once
#ifndef LOCAL_H
#define LOCAL_H



//All classes from Processing files

//All global finals (consts) from Processing files
static 	const int     WorldSide=501;  ///< How many cells do we want in one line?
static 	const bool sync=false;     ///< Synchronous or asynchronous update    !!!!!!!
static 	const float   Dens=150.15;    ///< When >=1, simetric horizontal line is created
static 	const int     MinN=2;         ///< Minimal number of neighbors required
static 	const int     OptN=3;         ///< The number of neighbors needed to revive the cell
static 	const int     MaxN=3;         ///< Maximal number of neighbors required
static 	const bool withM=true;     ///< With Moore neighbors
static 	const bool traceVA=true;   ///< virgin areas trace ON/OFF

//All global variables from Processing files
extern	int 		FR;///< =999;                   < globally visible
extern	int 		t;///< =0; < steps counter as "time"
extern	int 		liveCounter;///< =0;  < globally visible. The only statistics for the model so far.

//All global arrays from Processing files

//All global matrices from Processing files

//All global functions from Processing files
void	status();  ///< globally visible
void	initialisation();  ///< globally visible
void	visualisationSY();  ///< globally visible
void	visualisationAS();  ///< globally visible
void	synchronicStep();  ///< globally visible
void	stepMonteCarlo();  ///< globally visible
#endif
