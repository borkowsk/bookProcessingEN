//Automagically generated file
//Dont edit!
#pragma once
#ifndef LOCAL_H
#define LOCAL_H



//All classes from Processing files

//All global finals (consts) from Processing files
static 	const double Alpha=0.1; ///< prey growth
static 	const double Beta=0.01; ///< interaction of prey with predators
static 	const double Gamma=Beta/10.0; ///< the growth of predators depends on the number of prey
static 	const double Delta=0.1; ///< the mortality of predators
static 	const double Tstep=0.05; ///< Time step. As short as possible ;-) Why? Lets try! :-D
static 	const int   DOTSIZE=2;   ///< Size of ellipses representing data points

//All global variables from Processing files
extern	double 		X;///< =300; < x is the number of prey (for example, rabbits);
extern	double 		Y;///< =15;  < y is the number of some predator (for example, foxes);
extern	float 		Tlimit;///< =1000;       < Time limit as 2/3 of width
extern	double 		T;///< =0; < Global time variable

//All global arrays from Processing files

//All global matrices from Processing files

//All global functions from Processing files
#endif
