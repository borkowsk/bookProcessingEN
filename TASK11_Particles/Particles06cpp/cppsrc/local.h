//Automagically generated file
//Dont edit!
#pragma once
#ifndef LOCAL_H
#define LOCAL_H



//All classes from Processing files

//All global finals (consts) from Processing files

//All global variables from Processing files
extern	int 		circles ;///< = 50;      < global
extern	bool 		torus;///< =true;    < global
extern	bool 		trace;///< =false;   < global
extern	int 		diameter;///< =25;       < global
extern	int 		radius;///< =diameter/2; < global
extern	float 		maxspeed;///< =1;      < global
extern	int 		FRAMERATE;///< =800;     < global
extern	int 		VISFREQ;///< =8;         < every N

//All global arrays from Processing files
extern	sarray<float>   xpos ;///< = new float[circles];        < global
extern	sarray<float>   ypos ;///< = new float[circles];        < global
extern	sarray<float>   xspeed ;///< = new float[circles];      < global
extern	sarray<float>   yspeed ;///< = new float[circles];      < global
extern	sarray<bool> collision ;///< = new boolean[circles]; < ???
extern	sarray<bool> isNaive ;///< = new boolean[circles]; < global
color[]   circolor ;///< = new color[circles];  < Atitude?
extern	sarray<float>   wellbeing ;///< = new float[circles]; < Moving average 

//All global matrices from Processing files

//All global functions from Processing files
bool	isPositionFree(int i);  ///< global
void	visualisation();  ///< global
void	movement();  ///< global
void	bordersReaction();  ///< global
void	findcollisions();  ///< global
void	physicalCollision(int i,int j);  ///< global
void	reactionOfNaive(int i,int j);  ///< global
void	reaction(int i,int j);  ///< global 
#endif
