//Automagically generated file
//Dont edit!
#pragma once
#ifndef LOCAL_H
#define LOCAL_H



//All classes from Processing files

//All global finals (consts) from Processing files
static 	const int       SEED=111;   ///< seed for random number generator
static 	const int          N=100;   ///< Number of agents
static 	const float treScale=0.5;   ///<  Threshold is a function of extremes of views times Scale
static 	const float   minEps=0.001; ///< minimal epsilon. 
static 	const float   maxEps=0.005; ///< maximal epsilon.
static 	const int        bub=N/2;   ///< radius of information bubble

//All global variables from Processing files
extern	bool 		classicVis;///< =true;    < Type of visualisation

//All global arrays from Processing files
extern	sarray<float> minds;///< =new float[N]; < creating the minds array 
extern	sarray<float>   eps;///< =new float[N]; < creating the epsilons array
extern	sarray<float>   tre;///< =new float[N]; < creating the tresholds array

//All global matrices from Processing files

//All global functions from Processing files
void	visualisationA();  ///< Basic visualisation
void	visualisationB();  ///< Alternative visualisation
#endif
