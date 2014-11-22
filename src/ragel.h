/*
 *  Copyright 2001-2007 Adrian Thurston <thurston@complang.org>
 */

#ifndef _RAGEL_H
#define _RAGEL_H

#include <stdio.h>
#include <iostream>
#include <fstream>
#include <string>
#include "vector.h"
#include "config.h"
#include "common.h"

#define PROGNAME "ragel"

#define MAIN_MACHINE "main"

/* Target output style. */
enum CodeStyle
{
	GenBinaryVarLoop,
	GenBinaryGotoLoop,
	GenBinaryGotoExp,
	GenFlatGotoLoop,
	GenFlatGotoExp,
	GenSwitchGotoLoop,
	GenSwitchGotoExp,
	GenIpGoto
};

/* To what degree are machine minimized. */
enum MinimizeLevel {
	MinimizeApprox,
	MinimizeStable,
	MinimizePartition1,
	MinimizePartition2
};

enum MinimizeOpt {
	MinimizeNone,
	MinimizeEnd,
	MinimizeMostOps,
	MinimizeEveryOp
};

/* Target implementation */
enum RubyImplEnum
{
	MRI,
	Rubinius
};

/* Error reporting format. */
enum ErrorFormat {
	ErrorFormatGNU,
	ErrorFormatMSVC,
};

struct colm_location;

InputLoc makeInputLoc( const char *fileName, int line = 0, int col = 0 );
InputLoc makeInputLoc( const struct colm_location *loc );
std::ostream &operator<<( std::ostream &out, const InputLoc &loc );

/* Error reporting. */
std::ostream &error();
std::ostream &error( const InputLoc &loc ); 
std::ostream &warning( const InputLoc &loc ); 

void xmlEscapeHost( std::ostream &out, const char *data, long len );

/* IO filenames and stream. */
extern int gblErrorCount;

std::ostream &error();

#endif
