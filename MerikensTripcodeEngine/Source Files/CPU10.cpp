// Meriken's Tripcode Engine 2.0.0
// Copyright (c) 2011-2015 Meriken.Z. <meriken.2ch@gmail.com>
//
// The initial versions of this software were based on:
// CUDA SHA-1 Tripper 0.2.1
// Copyright (c) 2009 Horo/.IBXjcg
// 
// The code that deals with DES decryption is partially adopted from:
// John the Ripper password cracker
// Copyright (c) 1996-2002, 2005, 2010 by Solar Designer
// DeepLearningJohnDoe's fork of Meriken's Tripcode Engine
// Copyright (c) 2015 by <deeplearningjohndoe at gmail.com>
//
// The code that deals with SHA-1 hash generation is partially adopted from:
// sha_digest-2.2
// Copyright (C) 2009 Jens Thoms Toerring <jt@toerring.de>
// VecTripper 
// Copyright (C) 2011 tmkk <tmkk@smoug.net>
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.



///////////////////////////////////////////////////////////////////////////////
// INCLUDE FILE(S)                                                           //
///////////////////////////////////////////////////////////////////////////////

#include "MerikensTripcodeEngine.h"



///////////////////////////////////////////////////////////////////////////////
// BITSLICE DES                                                              //
///////////////////////////////////////////////////////////////////////////////

#define USE_ASSEMBLY_FUNCTION

#define VECTOR_SIZE 16
typedef __declspec(align(VECTOR_SIZE)) __m128i DES_Vector;
#define VECTOR_ELEMENTS m128i_i32
#define CPU_DES_MAIN_LOOP CPU_DES_MainLoop

#include "CPU10.h"




///////////////////////////////////////////////////////////////////////////////
// TABLES                                                                    //
///////////////////////////////////////////////////////////////////////////////

unsigned char charTableForKagami[256] = {
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '.',  '\0',
	'0',  '\0', '\0', '\0', '\0', '\0', '\0', '\0', '8',  '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', 'A',  '\0', '\0', '\0', '\0', '\0', '\0', 'H',  'I',  '\0', '\0', '\0', 'M',  '\0', 'O',
	'\0', '\0', '\0', '\0', 'T',  'U',  'V',  'W',  'X',  'Y',  '\0', '\0', '\0', '\0', '\0', '\0', 
	'\0', '\0', 'd',  '\0', 'b',  '\0', '\0', '\0', '\0', 'i',  '\0', '\0', 'l',  '\0', '\0', 'o',
	'q',  'p',  '\0', '\0', '\0', '\0', 'v',  'w',  'x',  '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
	'\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0',
};

// The following table was adopted from:
// http://sourceforge.jp/projects/naniya/wiki/2chtrip#h2-Salt.E7.94.9F.E6.88.90.E8.A6.8F.E5.89.87

unsigned char charTableForSeed[256] = {
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '/',
	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
	'G', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
	'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e',
	'f', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
	'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
};



///////////////////////////////////////////////////////////////////////////////
// THREAD                                                                    //
///////////////////////////////////////////////////////////////////////////////

extern void CPU_DES_MainLoop_AVX2();

unsigned WINAPI Thread_SearchForDESTripcodesOnCPU(LPVOID threadParams)
{
	// ERROR0(!SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_BELOW_NORMAL), ERROR_SEARCH_THREAD, "SetThreadPriority() failed.");

	if (options.isAVX2Enabled && IsAVX2Supported()) {
		CPU_DES_MainLoop_AVX2();
	} else {
		CPU_DES_MainLoop();
	}
	return 0;
}
