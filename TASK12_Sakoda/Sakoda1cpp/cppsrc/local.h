//Automagically generated file
//Dont edit!
#pragma once
#ifndef LOCAL_H
#define LOCAL_H



//All classes from Processing files
/*interface*/class simulation_world; typedef Processing::ptr<simulation_world> psimulation_world; //
class Agent; typedef Processing::ptr<Agent> pAgent; // {
class World; typedef Processing::ptr<World> pWorld; // implements simulation_world {

//All global finals (consts) from Processing files

//All global variables from Processing files
extern	int 		Number_of_identities;///< =2; < How many mutually exclusive identities are there
extern	PrintWriter 		outstat;           ///< globally visible handle to output file
extern	float 		meanStress;///< =0;          < global statistic
extern	int   		liveCount;///< =0;           < global stat.
extern	int 		searchedX;///< =-1;           < global variable
extern	int 		searchedY;///< =-1;           < global variable
extern	bool 		Clicked;///< =false;      < global variable
extern	pAgent  		theSelected;///< =null;    < global variable
extern	double 		minDist2Selec;///< =MAX_INT;   < global variable
extern	double 		maxTransSelec;///< =-MAX_INT;  < global variable
extern	int 		side;///< =100;                 < side of main table
extern	String 		modelName;///< ="ABMSakoda"; < SHORT name of model
extern	float 		density;///< =0.55;           < initialisation density
extern	pWorld 		TheWorld;///< =new World(side); < ... but also will be initialised inside setup()
extern	int 		cwidth;///< =8;                 < size of cell
extern	int 		STATUSHEIGH;///< =40;           < global
extern	int 		STEPSperVIS;///< =1;            < global
extern	int 		FRAMEFREQ;///< =20;             < global
extern	bool 		WITH_VIDEO;///< =true;      < global
extern	bool 		simulationRun;///< =true;   < Start/stop flag

//All global arrays from Processing files

//All global matrices from Processing files

//All global functions from Processing files
void	initializeAgents(smatrix<pAgent> agents);  ///< global function
void	initializeAgents(sarray<pAgent> agents);  ///< global function
void	changeAgents(sarray<pAgent> agents);  ///< global function
void	changeAgents(smatrix<pAgent> agents);  ///< global function
void	visualizeModel(pWorld world);  ///< global function
void	initializeStats();  ///< global function
void	doStatisticsOnAgents(sarray<pAgent> agents);  ///< global function
void	doStatisticsOnAgents(smatrix<pAgent> agents);  ///< global function
void	visualizeAgents(smatrix<pAgent> agents);  ///< global function
void	visualizeAgents(sarray<pAgent> agents);  ///< global function
void	FirstVideoFrame();  ///< need be really visible globally!
void	NextVideoFrame();  ///< need be really visible globally!
void	CloseVideo();  ///< To wołamy gdy chcemy zamknąć
void	writeStatusLine();  ///< global function
#endif
