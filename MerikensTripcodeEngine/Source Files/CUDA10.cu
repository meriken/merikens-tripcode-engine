// Meriken's Tripcode Engine 1.1 Beta 1
// Copyright (c) 2011-2013 Meriken//XXX <meriken.2ch@gmail.com>
//
// The initial versions of this software were based on:
// CUDA SHA-1 Tripper 0.2.1
// Copyright (c) 2009 Horo/.IBXjcg
// 
// The code that deals with DES decryption is partially adopted from:
// John the Ripper password cracker
// Copyright (c) 1996-2002, 2005, 2010 by Solar Designer
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



// TO DO: Use smallKeyBitmap[]!



///////////////////////////////////////////////////////////////////////////////
// INCLUDE FILE(S)                                                           //
///////////////////////////////////////////////////////////////////////////////

#include "MerikensTripcodeEngine.h"



///////////////////////////////////////////////////////////////////////////////
// VARIABLES FOR CUDA CODES                                                  //
///////////////////////////////////////////////////////////////////////////////

__device__ __constant__ unsigned char   CUDA_keyCharTable_OneByte[SIZE_KEY_CHAR_TABLE];
__device__ __constant__ unsigned char   CUDA_keyCharTable_FirstByte  [SIZE_KEY_CHAR_TABLE];
__device__ __constant__ unsigned char   CUDA_keyCharTable_SecondByte [SIZE_KEY_CHAR_TABLE];
__device__ __constant__ char    CUDA_base64CharTable[64];
__device__ __constant__ unsigned char   CUDA_key[12];



///////////////////////////////////////////////////////////////////////////////
// BITSLICE DES                                                              //
///////////////////////////////////////////////////////////////////////////////

typedef int           DES_ARCH_WORD;
typedef int           DES_ARCH_WORD_32;
#define DES_ARCH_SIZE 4
#define DES_ARCH_BITS 32

typedef int           DES_Vector;
// #define CUDA_DES_BS_DEPTH  DES_ARCH_BITS
#define DES_VECTOR_ZERO               0
#define DES_VECTOR_ONES               ~(DES_Vector)0

#define DES_VECTOR_NOT(dst, a)        (dst) =  ~(a)
#define DES_VECTOR_AND(dst, a, b)     (dst) =   (a) &  (b)
#define DES_VECTOR_OR(dst, a, b)      (dst) =   (a) |  (b)
#define DES_VECTOR_AND_NOT(dst, a, b) (dst) =   (a) & ~(b)
#define DES_VECTOR_XOR_NOT(dst, a, b) (dst) = ~((a) ^  (b))
#define DES_VECTOR_NOT_OR(dst, a, b)  (dst) = ~((a) |  (b))
#define DES_VECTOR_SEL(dst, a, b, c)  (dst) = (((a) & ~(c)) ^ ((b) & (c)))
#define DES_VECTOR_XOR_FUNC(a, b)              ((a) ^  (b))
#define DES_VECTOR_XOR(dst, a, b)     (dst) = DES_VECTOR_XOR_FUNC((a), (b))
#define DES_VECTOR_SET(dst, ofs, src) *((DES_Vector *)((DES_Vector *)&(dst) + (ofs))) = (src)

#define DES_CONSTANT_QUALIFIERS      __device__ __constant__
#define DES_FUNCTION_QUALIFIERS      __device__ __forceinline__
#define DES_SBOX_FUNCTION_QUALIFIERS __device__ __forceinline__

// All bitslice DES parameters combined into one struct for more efficient
// cache usage and multi-threading.
struct DESContext {
	DES_Vector keys[56];       // 224 bytes
	DES_Vector dataBlocks[64]; // 256 bytes
	unsigned int dummy[1];     // This is necessary to reduce the number of bank conflicts in shared memory.
};
__shared__ struct DESContext DESContextArray[CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK];

const unsigned char expansionTable[48] = {
	31,  0,  1,  2,  3,  4,
	 3,  4,  5,  6,  7,  8,
	 7,  8,  9, 10, 11, 12,
	11, 12, 13, 14, 15, 16,
	15, 16, 17, 18, 19, 20,
	19, 20, 21, 22, 23, 24,
	23, 24, 25, 26, 27, 28,
	27, 28, 29, 30, 31,  0
};

__device__ __constant__ unsigned char CUDA_expansionFunction[96];

const char charToIndexTableForDES[0x100] = {
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x00, 0x01,
	0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
	0x0a, 0x0b, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12,
	0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a,
	0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x21, 0x22,
	0x23, 0x24, 0x25, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c,
	0x2d, 0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34,
	0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c,
	0x3d, 0x3e, 0x3f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
};

DES_CONSTANT_QUALIFIERS char CUDA_DES_indexToCharTable[64] =
//	"./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
{
	/* 00 */ '.', '/',
	/* 02 */ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
	/* 12 */ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 
	/* 28 */ 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	/* 38 */ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
	/* 54 */ 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
};

DES_CONSTANT_QUALIFIERS unsigned char keySchedule[DES_SIZE_KEY_SCHEDULE] = {
	12, 46, 33, 52, 48, 20, 34, 55,  5, 13, 18, 40,  4, 32, 26, 27,
	38, 54, 53,  6, 31, 25, 19, 41, 15, 24, 28, 43, 30,  3, 35, 22,
	 2, 44, 14, 23, 51, 16, 29, 49,  7, 17, 37,  8,  9, 50, 42, 21,
	 5, 39, 26, 45, 41, 13, 27, 48, 53,  6, 11, 33, 52, 25, 19, 20,
	31, 47, 46, 54, 55, 18, 12, 34,  8, 17, 21, 36, 23, 49, 28, 15,
	24, 37,  7, 16, 44,  9, 22, 42,  0, 10, 30,  1,  2, 43, 35, 14,
	46, 25, 12, 31, 27, 54, 13, 34, 39, 47, 52, 19, 38, 11,  5,  6,
	48, 33, 32, 40, 41,  4, 53, 20, 51,  3,  7, 22,  9, 35, 14,  1,
	10, 23, 50,  2, 30, 24,  8, 28, 43, 49, 16, 44, 17, 29, 21,  0,
	32, 11, 53, 48, 13, 40, 54, 20, 25, 33, 38,  5, 55, 52, 46, 47,
	34, 19, 18, 26, 27, 45, 39,  6, 37, 42, 50,  8, 24, 21,  0, 44,
	49,  9, 36, 17, 16, 10, 51, 14, 29, 35,  2, 30,  3, 15,  7, 43,
	18, 52, 39, 34, 54, 26, 40,  6, 11, 19, 55, 46, 41, 38, 32, 33,
	20,  5,  4, 12, 13, 31, 25, 47, 23, 28, 36, 51, 10,  7, 43, 30,
	35, 24, 22,  3,  2, 49, 37,  0, 15, 21, 17, 16, 42,  1, 50, 29,
	 4, 38, 25, 20, 40, 12, 26, 47, 52,  5, 41, 32, 27, 55, 18, 19,
	 6, 46, 45, 53, 54, 48, 11, 33,  9, 14, 22, 37, 49, 50, 29, 16,
	21, 10,  8, 42, 17, 35, 23, 43,  1,  7,  3,  2, 28, 44, 36, 15,
	45, 55, 11,  6, 26, 53, 12, 33, 38, 46, 27, 18, 13, 41,  4,  5,
	47, 32, 31, 39, 40, 34, 52, 19, 24,  0,  8, 23, 35, 36, 15,  2,
	 7, 49, 51, 28,  3, 21,  9, 29, 44, 50, 42, 17, 14, 30, 22,  1,
	31, 41, 52, 47, 12, 39, 53, 19, 55, 32, 13,  4, 54, 27, 45, 46,
	33, 18, 48, 25, 26, 20, 38,  5, 10, 43, 51,  9, 21, 22,  1, 17,
	50, 35, 37, 14, 42,  7, 24, 15, 30, 36, 28,  3,  0, 16,  8, 44,
	55, 34, 45, 40,  5, 32, 46, 12, 48, 25,  6, 52, 47, 20, 38, 39,
	26, 11, 41, 18, 19, 13, 31, 53,  3, 36, 44,  2, 14, 15, 51, 10,
	43, 28, 30,  7, 35,  0, 17,  8, 23, 29, 21, 49, 50,  9,  1, 37,
	41, 20, 31, 26, 46, 18, 32, 53, 34, 11, 47, 38, 33,  6, 55, 25,
	12, 52, 27,  4,  5, 54, 48, 39, 42, 22, 30, 17,  0,  1, 37, 49,
	29, 14, 16, 50, 21, 43,  3, 51,  9, 15,  7, 35, 36, 24, 44, 23,
	27,  6, 48, 12, 32,  4, 18, 39, 20, 52, 33, 55, 19, 47, 41, 11,
	53, 38, 13, 45, 46, 40, 34, 25, 28,  8, 16,  3, 43, 44, 23, 35,
	15,  0,  2, 36,  7, 29, 42, 37, 24,  1, 50, 21, 22, 10, 30,  9,
	13, 47, 34, 53, 18, 45,  4, 25,  6, 38, 19, 41,  5, 33, 27, 52,
	39, 55, 54, 31, 32, 26, 20, 11, 14, 51,  2, 42, 29, 30,  9, 21,
	 1, 43, 17, 22, 50, 15, 28, 23, 10, 44, 36,  7,  8, 49, 16, 24,
	54, 33, 20, 39,  4, 31, 45, 11, 47, 55,  5, 27, 46, 19, 13, 38,
	25, 41, 40, 48, 18, 12,  6, 52,  0, 37, 17, 28, 15, 16, 24,  7,
	44, 29,  3,  8, 36,  1, 14,  9, 49, 30, 22, 50, 51, 35,  2, 10,
	40, 19,  6, 25, 45, 48, 31, 52, 33, 41, 46, 13, 32,  5, 54, 55,
	11, 27, 26, 34,  4, 53, 47, 38, 43, 23,  3, 14,  1,  2, 10, 50,
	30, 15, 42, 51, 22, 44,  0, 24, 35, 16,  8, 36, 37, 21, 17, 49,
	26,  5, 47, 11, 31, 34, 48, 38, 19, 27, 32, 54, 18, 46, 40, 41,
	52, 13, 12, 20, 45, 39, 33, 55, 29,  9, 42,  0, 44, 17, 49, 36,
	16,  1, 28, 37,  8, 30, 43, 10, 21,  2, 51, 22, 23,  7,  3, 35,
	19, 53, 40,  4, 55, 27, 41, 31, 12, 20, 25, 47, 11, 39, 33, 34,
	45,  6,  5, 13, 38, 32, 26, 48, 22,  2, 35, 50, 37, 10, 42, 29,
	 9, 51, 21, 30,  1, 23, 36,  3, 14, 24, 44, 15, 16,  0, 49, 28,
};

void DES_CreateExpansionFunction(char *saltString, unsigned char *expansionFunction)
{
	unsigned char saltChar1 = '.', saltChar2 = '.';
	DES_ARCH_WORD salt;
	DES_ARCH_WORD mask;
	int src, dst;

	if (saltString[0]) {
		saltChar1 = saltString[0];
		if (saltString[1])
			saltChar2 = saltString[1];
	}
	salt =    charToIndexTableForDES[saltChar1]
	       | (charToIndexTableForDES[saltChar2] << 6);

	mask = 1;
	for (dst = 0; dst < 48; dst++) {
		if (dst == 24) mask = 1;

		if (salt & mask) {
			if (dst < 24) src = dst + 24; else src = dst - 24;
		} else src = dst;

		expansionFunction[dst     ] = expansionTable[src];
		expansionFunction[dst + 48] = expansionTable[src] + 32;

		mask <<= 1;
	}
}

DES_FUNCTION_QUALIFIERS void
DES_ClearKeys(int charIndex)
{
	for (int i = 0; i < 7; ++i)
		DESContextArray[threadIdx.x].keys[charIndex * 7 + i] = 0;
}

// Bitslice DES S-boxes for x86 with MMX/SSE2/AVX and for typical RISC
// architectures.  These use AND, OR, XOR, NOT, and AND-NOT gates.
//
// Gate counts: 49 44 46 33 48 46 46 41
// Average: 44.125
//
// Several same-gate-count expressions for each S-box are included (for use on
// different CPUs/GPUs).
//
// These Boolean expressions corresponding to DES S-boxes have been generated
// by Roman Rusakov <roman_rus at openwall.com> for use in Openwall's
// John the Ripper password cracker: http://www.openwall.com/john/
// Being mathematical formulas, they are not copyrighted and are free for reuse
// by anyone.
//
// This file (a specific representation of the S-box expressions, surrounding
// logic) is Copyright (c) 2011 by Solar Designer <solar at openwall.com>.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted.  (This is a heavily cut-down "BSD license".)
//
// The effort has been sponsored by Rapid7: http://www.rapid7.com

//
// s1-00484, 49 gates, 17 regs, 11 andn, 4/9/39/79/120 stalls, 74 biop
// Currently used for MMX/SSE2 and x86-64 SSE2
//
DES_SBOX_FUNCTION_QUALIFIERS void
s1(
	DES_Vector arg1,
	DES_Vector arg2,
	DES_Vector arg3,
	DES_Vector arg4,
	DES_Vector arg5,
	DES_Vector arg6,
    DES_Vector *out1,
    DES_Vector *out2,
    DES_Vector *out3,
    DES_Vector *out4
) {
	asm("{                      \n\t"
	    ".reg .u32 t0;          \n\t"
	    ".reg .u32 t1;          \n\t"
	    ".reg .u32 t2;          \n\t"
	    ".reg .u32 t3;          \n\t"
	    ".reg .u32 t4;          \n\t"
	    ".reg .u32 t5;          \n\t"
	    ".reg .u32 t6;          \n\t"
	    ".reg .u32 t7;          \n\t"
	    ".reg .u32 t8;          \n\t"
	    ".reg .u32 t9;          \n\t"
	    ".reg .u32 t10;         \n\t"
	    ".reg .u32 t11;         \n\t"
	    ".reg .u32 t12;         \n\t"
	    ".reg .u32 t13;         \n\t"
	    
	    "not.b32 t0,  %8;      \n\t"
	    "and.b32 t0,  %4, t0;  \n\t"
	    "xor.b32 t1,  %7, t0;  \n\t"
	    "or.b32  t2,  %6, %9; \n\t"
	    "xor.b32 t3,  %4, %6; \n\t"
	    "and.b32 t4,  t2,  t3;  \n\t"
	    "xor.b32 t5,  %7, t4;  \n\t"
	    "not.b32 t6,  t1;       \n\t"
	    "and.b32 t6,  t5,  t6;  \n\t"

	    "xor.b32 t7,  %8, %9; \n\t"
	    "xor.b32 t8,  %6, t7;  \n\t"
	    "not.b32 t9,  t8;       \n\t"
	    "and.b32 t9,  t1,  t9;  \n\t"
	    "or.b32  t8,  %9, t4;  \n\t"
	    "xor.b32 t4,  t9,  t8;  \n\t"
	    "not.b32 t8,  t6;       \n\t"
	    "and.b32 t8,  t4,  t8;  \n\t"

	    "or.b32  t9,  %4, %9; \n\t"
	    "or.b32  t10, t4,  t9;  \n\t"
	    "not.b32 t11, t5;       \n\t"
	    "and.b32 t11, %8, t11; \n\t"
	    "xor.b32 t5,  t10, t11; \n\t"

	    "not.b32 t12, t9;       \n\t"
		"and.b32 t12, %7, t12; \n\t"
	    "xor.b32 t9,  t11, t12; \n\t"
	    "not.b32 t12, t3;       \n\t"
	    "and.b32 t12, t7,  t12; \n\t"
	    "or.b32  t3,  t9,  t12; \n\t"

	    "not.b32 t12, t0;       \n\t"
	    "and.b32 t12, %6, t12; \n\t"
	    "xor.b32 t0,  t1,  t10; \n\t"
	    "not.b32 t9,  t12;      \n\t"
	    "and.b32 t9,  t0,  t9;  \n\t"
	    "not.b32 t12, t9;       \n\t"
	    "and.b32 t0,  t2,  t4;  \n\t"
	    "xor.b32 t4,  t12, t0;  \n\t"
	    "not.b32 t13, %5;      \n\t"
	    "and.b32 t13, t5,  t13; \n\t"
	    "xor.b32 t5,  t13, t4;  \n\t"
	    "xor.b32 %2, %2, t5;  \n\t"
	
	    "xor.b32 t12, t7,  t9;  \n\t"
	    "or.b32  t0,  t11, t12; \n\t"
	    "xor.b32 t5,  t2,  t0;  \n\t"
	    "xor.b32 t11, %4, t5;  \n\t"
	    "xor.b32 t5,  t4,  t11; \n\t"
	    "or.b32  t9,  t6,  %5; \n\t"
	    "xor.b32 t12, t9,  t5;  \n\t"
	    "xor.b32 %0, %0, t12; \n\t"
	
	    "xor.b32 t13, t2,  t10; \n\t"
	    "or.b32  t0,  t3,  t13; \n\t"
	    "xor.b32 t13, t11, t0;  \n\t"
	    "or.b32  t0,  t7,  t5;  \n\t"
	    "xor.b32 t5,  t13, t0;  \n\t"
	    "or.b32  t0,  t8,  %5; \n\t"
	    "xor.b32 t6,  t0,  t5;  \n\t"
	    "xor.b32 %1, %1, t6;  \n\t"

	    "or.b32  t6,  %8, t1;  \n\t"
	    "not.b32 t9,  t13;      \n\t"
	    "and.b32 t9,  t6,  t9;  \n\t"
	    "and.b32 t13, t8,  t11; \n\t"
	    "xor.b32 t11, t9,  t13; \n\t"
	    "or.b32  t13, t11, %5; \n\t"
	    "xor.b32 t12, t13, t3;  \n\t"
	    "xor.b32 %3, %3, t12;   \n\t"
	    "}                      \n\t"

	    : "+r"(*out1),  // %0
	      "+r"(*out2),  // %1
	      "+r"(*out3),  // %2
	      "+r"(*out4)   // %3
	      
	    : "r"(arg1)     // %4
	      "r"(arg2)     // %5
	      "r"(arg3)     // %6
	      "r"(arg4)     // %7
	      "r"(arg5)     // %8
	      "r"(arg6));   // %9
}

//
// s2-016251, 44 gates, 14 regs, 13 andn, 1/9/22/61/108 stalls, 66 biop */
//
DES_SBOX_FUNCTION_QUALIFIERS void
s2(DES_Vector a1, DES_Vector a2, DES_Vector a3, DES_Vector a4, DES_Vector a5, DES_Vector a6,
    DES_Vector * out1, DES_Vector * out2, DES_Vector * out3, DES_Vector * out4)
{
	asm("{                      \n\t"
	    ".reg .u32 t0;          \n\t"
	    ".reg .u32 t1;          \n\t"
	    ".reg .u32 t2;          \n\t"
	    ".reg .u32 t3;          \n\t"
	    ".reg .u32 t4;          \n\t"
	    ".reg .u32 t5;          \n\t"
	    ".reg .u32 t6;          \n\t"
	    ".reg .u32 t7;          \n\t"
	    ".reg .u32 t8;          \n\t"
	    ".reg .u32 t9;          \n\t"
	    ".reg .u32 t10;         \n\t"
	    ".reg .u32 t11;         \n\t"
	    ".reg .u32 t12;         \n\t"

		"xor.b32 t0, %5, %8;    \n\t"

		"not.b32 t1, %9;        \n\t"
		"and.b32 t1, %4, t1;    \n\t"
		"not.b32 t2, t1;        \n\t"
		"and.b32 t2, %8, t2;    \n\t"
		"or.b32  t1, %5, t2;    \n\t"

		"not.b32 t3, %9;        \n\t"
		"and.b32 t3, t0, t3;    \n\t"
		"and.b32 t4, %4, t0;    \n\t"
		"xor.b32 t5, %8, t4;    \n\t"
		"not.b32 t6, t3;        \n\t"
		"and.b32 t6, t5, t6;    \n\t"

		"and.b32 t7, %6, %9;    \n\t"
		"xor.b32 t8, t2, t3;    \n\t"
		"and.b32 t2, t1, t8;    \n\t"
		"not.b32 t3, t7;        \n\t"
		"and.b32 t3, t2, t3;    \n\t"

		"and.b32 t8, %6, t2;    \n\t"
		"not.b32 t2, %4;        \n\t"
		"xor.b32 t9, t8, t2;    \n\t"
		"xor.b32 t2, %9, t0;    \n\t"
		"not.b32 t0, t7;        \n\t"
		"and.b32 t0, t2, t0;    \n\t"
		"xor.b32 t10, t9, t0;   \n\t"
		"not.b32 t11, t3;       \n\t"
		"and.b32 t11, %7, t11;  \n\t"
		"xor.b32 t3, t11, t10;  \n\t"
		"xor.b32 %1, %1, t3;    \n\t"

		"not.b32 t3, t0;        \n\t"
		"and.b32 t3, %5, t3;    \n\t"
		"xor.b32 t0, t5, t3;    \n\t"
		"not.b32 t5, t0;        \n\t"
		"and.b32 t5, t9, t5;    \n\t"
		"xor.b32 t9, %6, t2;    \n\t"
		"xor.b32 t11, t5, t9;   \n\t"
		"not.b32 t5, %7;        \n\t"
		"and.b32 t5, t1, t5;    \n\t"
		"xor.b32 t12, t5, t11;  \n\t"
		"xor.b32 %0, %0, t12;   \n\t"

		"xor.b32 t5, t8, t3;    \n\t"
		"or.b32  t3, t9, t5;    \n\t"
		"xor.b32 t8, t1, t10;   \n\t"
		"or.b32  t1, t7, t8;    \n\t"
		"xor.b32 t7, t3, t1;    \n\t"

		"not.b32 t1, t11;       \n\t"
		"and.b32 t1, t10, t1;   \n\t"
		"xor.b32 t3, t4, t5;    \n\t"
		"or.b32  t4, t1, t3;    \n\t"
		"not.b32 t1, t9;        \n\t"
		"and.b32 t1, t6, t1;    \n\t"
		"xor.b32 t3, t4, t1;    \n\t"
		"or.b32  t1, t3, %7;    \n\t"
		"xor.b32 t4, t1, t7;    \n\t"
		"xor.b32 %2, %2, t4;    \n\t"

		"not.b32 t1, t0;        \n\t"
		"and.b32 t1, t3, t1;    \n\t"
		"or.b32  t0, t2, t8;    \n\t"
		"xor.b32 t2, t1, t0;    \n\t"
		"or.b32  t0, t6, %7;    \n\t"
		"xor.b32 t1, t0, t2;    \n\t"
		"xor.b32 %3, %3, t1;    \n\t"
		
		"}                      \n\t"

	    : "+r"(*out1), // %0
	      "+r"(*out2), // %1
	      "+r"(*out3), // %2
	      "+r"(*out4)  // %3
	      
	    : "r"(a1)      // %4
	      "r"(a2)      // %5
	      "r"(a3)      // %6
	      "r"(a4)      // %7
	      "r"(a5)      // %8
	      "r"(a6));    // %9
}

//
// s3-000426, 46 gates, 16 regs, 14 andn, 2/5/12/35/75 stalls, 68 biop
// Currently used for x86-64 SSE2
//
DES_SBOX_FUNCTION_QUALIFIERS void
s3(DES_Vector a1, DES_Vector a2, DES_Vector a3, DES_Vector a4, DES_Vector a5, DES_Vector a6,
    DES_Vector * out1, DES_Vector * out2, DES_Vector * out3, DES_Vector * out4)
{
	asm("{                      \n\t"
	    ".reg .u32 t0;          \n\t"
	    ".reg .u32 t1;          \n\t"
	    ".reg .u32 t2;          \n\t"
	    ".reg .u32 t3;          \n\t"
	    ".reg .u32 t4;          \n\t"
	    ".reg .u32 t5;          \n\t"
	    ".reg .u32 t6;          \n\t"
	    ".reg .u32 t7;          \n\t"
	    ".reg .u32 t8;          \n\t"
	    ".reg .u32 t9;          \n\t"
	    ".reg .u32 t10;         \n\t"

		"not.b32 t0, %5;        \n\t"
		"and.b32 t0, %4, t0;    \n\t"
		"xor.b32 t1, %6, %9;    \n\t"
		"or.b32  t2, t0, t1;    \n\t"
		"xor.b32 t0, %7, %9;    \n\t"
		"not.b32 t3, %4;        \n\t"
		"and.b32 t3, t0, t3;    \n\t"
		"xor.b32 t4, t2, t3;    \n\t"

		"xor.b32 t5, %5, t1;    \n\t"
		"not.b32 t6, %9;        \n\t"
		"and.b32 t6, t5, t6;    \n\t"
		"xor.b32 t7, t2, t6;    \n\t"
		"not.b32 t2, t7;        \n\t"
		"and.b32 t2, t4, t2;    \n\t"

		"and.b32 t6, %9, t4;    \n\t"
		"or.b32  t8, %7, t6;    \n\t"
		"and.b32 t6, %4, t8;    \n\t"
		"xor.b32 t8, t5, t6;    \n\t"
		"not.b32 t6, %8;        \n\t"
		"and.b32 t6, t4, t6;    \n\t"
		"xor.b32 t9, t6, t8;    \n\t"
		"xor.b32 %3, %3, t9;    \n\t"

		"and.b32 t6, t1, t0;    \n\t"
		"xor.b32 t0, %4, %7;    \n\t"
		"xor.b32 t9, t7, t0;    \n\t"
		"or.b32  t7, %6, t9;    \n\t"
		"not.b32 t9, t6;        \n\t"
		"and.b32 t9, t7, t9;    \n\t"

		"or.b32  t6, t3, t0;    \n\t"
		"not.b32 t0, t6;        \n\t"
		"and.b32 t0, t8, t0;    \n\t"
		"and.b32 t7, %7, %9;    \n\t"
		"not.b32 t8, %5;        \n\t"
		"and.b32 t8, t7, t8;    \n\t"
		"xor.b32 t10, t0, t8;   \n\t"

		"not.b32 t0, %6;        \n\t"
		"and.b32 t0, t10, t0;   \n\t"
		"or.b32  t8, t5, t7;    \n\t"
		"not.b32 t7, t0;        \n\t"
		"and.b32 t7, t8, t7;    \n\t"
		"xor.b32 t0, %4, t7;    \n\t"
		"and.b32 t7, t9, %8;    \n\t"
		"xor.b32 t8, t7, t0;    \n\t"
		"xor.b32 %1, %1, t8;    \n\t"

		"not.b32 t0, %5;        \n\t"
		"and.b32 t0, t4, t0;    \n\t"
		"not.b32 t4, %6;        \n\t"
		"and.b32 t4, t0, t4;    \n\t"
		"xor.b32 t7, t5, t6;    \n\t"
		"not.b32 t6, t7;        \n\t"
		"xor.b32 t7, t4, t6;    \n\t"
		"not.b32 t4, t2;        \n\t"
		"and.b32 t4, %8, t4;    \n\t"
		"xor.b32 t2, t4, t7;    \n\t"
		"xor.b32 %0, %0, t2;    \n\t"

		"and.b32 t2, %7, t1;    \n\t"
		"or.b32  t1, t5, t7;    \n\t"
		"not.b32 t4, t2;        \n\t"
		"and.b32 t4, t1, t4;    \n\t"
		"or.b32  t1, t3, t0;    \n\t"
		"xor.b32 t0, t4, t1;    \n\t"
		"or.b32  t1, t10, %8;   \n\t"
		"xor.b32 t2, t1, t0;    \n\t"
		"xor.b32 %2, %2, t2;    \n\t"
		
		"}                      \n\t"

	    : "+r"(*out1), // %0
	      "+r"(*out2), // %1
	      "+r"(*out3), // %2
	      "+r"(*out4)  // %3
	      
	    : "r"(a1)      // %4
	      "r"(a2)      // %5
	      "r"(a3)      // %6
	      "r"(a4)      // %7
	      "r"(a5)      // %8
	      "r"(a6));    // %9
}

//
// s4, 33 gates, 11/12 regs, 9 andn, 2/21/53/86/119 stalls, 52 biop
//
DES_SBOX_FUNCTION_QUALIFIERS void
s4(DES_Vector a1, DES_Vector a2, DES_Vector a3, DES_Vector a4, DES_Vector a5, DES_Vector a6,
    DES_Vector * out1, DES_Vector * out2, DES_Vector * out3, DES_Vector * out4)
{
	asm("{                      \n\t"

	    ".reg .u32 t0;          \n\t"
	    ".reg .u32 t1;          \n\t"
	    ".reg .u32 t2;          \n\t"
	    ".reg .u32 t3;          \n\t"
	    ".reg .u32 t4;          \n\t"
	    ".reg .u32 t5;          \n\t"
	    ".reg .u32 t6;          \n\t"
	    ".reg .u32 t7;          \n\t"
	
		"xor.b32 t0, %4, %6;    \n\t"
		"xor.b32 t1, %6, %8;    \n\t"
		"or.b32  t2, %5, %7;    \n\t"
		"xor.b32 t3, %8, t2;    \n\t"
		"not.b32 t2, t3;        \n\t"
		"and.b32 t2, t1, t2;    \n\t"
		"not.b32 t3, %5;        \n\t"
		"and.b32 t3, t1, t3;    \n\t"
		"xor.b32 t4, %7, t3;    \n\t"
		"or.b32  t5, t0, t4;    \n\t"
		"not.b32 t6, t2;        \n\t"
		"and.b32 t6, t5, t6;    \n\t"
		"xor.b32 t5, %5, t6;    \n\t"

		"and.b32 t7, t4, t5;    \n\t"
		"not.b32 t4, t7;        \n\t"
		"and.b32 t4, t1, t4;    \n\t"
		"xor.b32 t1, t0, t5;    \n\t"
		"not.b32 t0, t4;        \n\t"
		"and.b32 t0, t1, t0;    \n\t"
		"xor.b32 t4, t2, t0;    \n\t"

		"xor.b32 t0, %5, %7;    \n\t"
		"or.b32  t2, %8, t3;    \n\t"
		"xor.b32 t3, t1, t2;    \n\t"
		"not.b32 t1, t0;        \n\t"
		"and.b32 t1, t3, t1;    \n\t"
		"xor.b32 t2, t6, t1;    \n\t"
		"not.b32 t1, t4;        \n\t"
		"and.b32 t1, %9, t1;    \n\t"
		"xor.b32 t6, t1, t2;    \n\t"
		"xor.b32 %0, %0, t6;    \n\t"

		"not.b32 t1, t2;        \n\t"
		"not.b32 t2, %9;        \n\t"
		"and.b32 t2, t4, t2;    \n\t"
		"xor.b32 t6, t2, t1;    \n\t"
		"xor.b32 %1, %1, t6;    \n\t"

		"xor.b32 t2, t4, t1;    \n\t"
		"not.b32 t1, t0;        \n\t"
		"and.b32 t1, t2, t1;    \n\t"
		"or.b32  t0, t7, t1;    \n\t"
		"xor.b32 t1, t3, t0;    \n\t"
		"or.b32  t0, t5, %9;    \n\t"
		"xor.b32 t2, t0, t1;    \n\t"
		"xor.b32 %2, %2, t2;    \n\t"

		"and.b32 t0, %9, t5;    \n\t"
		"xor.b32 t2, t0, t1;    \n\t"
		"xor.b32 %3, %3, t2;    \n\t"
		
		"}                      \n\t"

	    : "+r"(*out1), // %0
	      "+r"(*out2), // %1
	      "+r"(*out3), // %2
	      "+r"(*out4)  // %3
	      
	    : "r"(a1)      // %4
	      "r"(a2)      // %5
	      "r"(a3)      // %6
	      "r"(a4)      // %7
	      "r"(a5)      // %8
	      "r"(a6));    // %9
}

//
// s5-04832, 48 gates, 15/16 regs, 9 andn, 5/23/62/109/159 stalls, 72 biop
// Currently used for MMX/SSE2
//
DES_SBOX_FUNCTION_QUALIFIERS void
s5(DES_Vector a1, DES_Vector a2, DES_Vector a3, DES_Vector a4, DES_Vector a5, DES_Vector a6,
    DES_Vector * out1, DES_Vector * out2, DES_Vector * out3, DES_Vector * out4)
{
	asm("{                      \n\t"

	    ".reg .u32 t0;          \n\t"
	    ".reg .u32 t1;          \n\t"
	    ".reg .u32 t2;          \n\t"
	    ".reg .u32 t3;          \n\t"
	    ".reg .u32 t4;          \n\t"
	    ".reg .u32 t5;          \n\t"
	    ".reg .u32 t6;          \n\t"
	    ".reg .u32 t7;          \n\t"
	    ".reg .u32 t8;          \n\t"
	    ".reg .u32 t9;          \n\t"
	    ".reg .u32 t10;          \n\t"
	    ".reg .u32 t11;          \n\t"
	    ".reg .u32 t12;          \n\t"
	
		"or.b32 t1, %4, %6; \n\t"
		"not.b32 t10, %9; \n\t"
		"and.b32 t10, t1, t10; \n\t"
		"xor.b32 t6, %4, t10; \n\t"
		"xor.b32 t2, %6, t6; \n\t"
		"or.b32 t3, %7, t2; \n\t"
		"not.b32 t7, %7; \n\t"
		"and.b32 t7, t10, t7; \n\t"
		"xor.b32 t10, %6, t7; \n\t"
		"and.b32 t7, %8, t10; \n\t"
		"or.b32 t12, %4, t2; \n\t"
		"xor.b32 t2, t7, t12; \n\t"
		"xor.b32 t7, %7, t2; \n\t"
		"xor.b32 t2, %9, t7; \n\t"
		"or.b32 t4, t6, t2; \n\t"
		"and.b32 t8, %8, t4; \n\t"
		"xor.b32 t11, t6, t8; \n\t"
		"and.b32 t9, %7, t12; \n\t"
		"xor.b32 t5, t11, t9; \n\t"
		"not.b32 t11, %4; \n\t"
		"and.b32 t11, t4, t11; \n\t"
		"xor.b32 t4, t10, t11; \n\t"
		"xor.b32 t9, %8, t3; \n\t"
		"not.b32 t0, t4; \n\t"
		"and.b32 t0, t9, t0; \n\t"
		"not.b32 t4, t0; \n\t"
		"not.b32 t0, %5; \n\t"
		"and.b32 t0, t4, t0; \n\t"
		"xor.b32 t4, t0, t7; \n\t"
		"xor.b32 %2, %2, t4; \n\t"
		"not.b32 t7, t8; \n\t"
		"and.b32 t7, t10, t7; \n\t"
		"xor.b32 t0, t11, t9; \n\t"
		"or.b32 t11, t5, t0; \n\t"
		"not.b32 t4, t7; \n\t"
		"and.b32 t4, t11, t4; \n\t"
		"not.b32 t0, t4; \n\t"
		"and.b32 t0, t3, t0; \n\t"
		"and.b32 t11, t2, t4; \n\t"
		"xor.b32 t7, t9, t11; \n\t"
		"and.b32 t2, t10, t12; \n\t"
		"or.b32 t11, t7, t2; \n\t"
		"xor.b32 t9, t8, t11; \n\t"
		"and.b32 t11, t9, %5; \n\t"
		"xor.b32 t12, t11, t5; \n\t"
		"xor.b32 %3, %3, t12; \n\t"
		"xor.b32 t12, t1, t4; \n\t"
		"xor.b32 t2, %4, t12; \n\t"
		"and.b32 t11, %7, t7; \n\t"
		"xor.b32 t8, t2, t11; \n\t"
		"or.b32 t12, t0, %5; \n\t"
		"xor.b32 t11, t12, t8; \n\t"
		"xor.b32 %0, %0, t11; \n\t"
		"xor.b32 t9, t3, t10; \n\t"
		"not.b32 t5, t8; \n\t"
		"and.b32 t5, t9, t5; \n\t"
		"xor.b32 t4, t6, t7; \n\t"
		"xor.b32 t1, t5, t4; \n\t"
		"and.b32 t2, t3, %5; \n\t"
		"xor.b32 t0, t2, t1; \n\t"
		"xor.b32 %1, %1, t0; \n\t"

		"}                      \n\t"

	    : "+r"(*out1), // %0
	      "+r"(*out2), // %1
	      "+r"(*out3), // %2
	      "+r"(*out4)  // %3
	      
	    : "r"(a1)      // %4
	      "r"(a2)      // %5
	      "r"(a3)      // %6
	      "r"(a4)      // %7
	      "r"(a5)      // %8
	      "r"(a6));    // %9
}

//
// s6-000007, 46 gates, 19 regs, 8 andn, 3/19/39/66/101 stalls, 69 biop
// Currently used for x86-64 SSE2
//
DES_SBOX_FUNCTION_QUALIFIERS void
s6(DES_Vector a1, DES_Vector a2, DES_Vector a3, DES_Vector a4, DES_Vector a5, DES_Vector a6,
    DES_Vector * out1, DES_Vector * out2, DES_Vector * out3, DES_Vector * out4)
{
	asm("{                      \n\t"
	    ".reg .u32 t0;          \n\t"
	    ".reg .u32 t1;          \n\t"
	    ".reg .u32 t2;          \n\t"
	    ".reg .u32 t3;          \n\t"
	    ".reg .u32 t4;          \n\t"
	    ".reg .u32 t5;          \n\t"
	    ".reg .u32 t6;          \n\t"
	    ".reg .u32 t7;          \n\t"
	    ".reg .u32 t8;          \n\t"
	    ".reg .u32 t9;          \n\t"
	    ".reg .u32 t10;         \n\t"
	    ".reg .u32 t11;         \n\t"
	    ".reg .u32 t12;         \n\t"
	    ".reg .u32 t13;         \n\t"
	    
		"xor.b32 t0, %5, %8; \n\t"

		"or.b32 t8, %5, %9; \n\t"
		"and.b32 t1, %4, t8; \n\t"
		"xor.b32 t8, t0, t1; \n\t"
		"xor.b32 t0, %9, t8; \n\t"
		"not.b32 t12, t0; \n\t"
		"and.b32 t12, %8, t12; \n\t"

		"and.b32 t11, %4, t0; \n\t"
		"xor.b32 t0, %5, t11; \n\t"
		"xor.b32 t4, %4, %6; \n\t"
		"or.b32 t13, t0, t4; \n\t"
		"xor.b32 t2, t8, t13; \n\t"

		"and.b32 t7, %6, t2; \n\t"
		"not.b32 t6, %9; \n\t"
		"and.b32 t6, t7, t6; \n\t"
		"or.b32 t9, t12, t0; \n\t"
		"xor.b32 t0, t6, t9; \n\t"
		"and.b32 t10, t0, %7; \n\t"
		"xor.b32 t5, t10, t2; \n\t"
		"xor.b32 %3, %3, t5; \n\t"

		"xor.b32 t5, %5, t13; \n\t"
		"not.b32 t13, t5; \n\t"
		"and.b32 t13, %9, t13; \n\t"
		"xor.b32 t10, %6, t13; \n\t"
		"not.b32 t13, t7; \n\t"
		"and.b32 t13, %8, t13; \n\t"
		"or.b32 t3, t10, t13; \n\t"

		"or.b32 t13, %4, t2; \n\t"
		"and.b32 t2, t9, t13; \n\t"
		"xor.b32 t9, t10, t2; \n\t"
		"not.b32 t13, t6; \n\t"
		"and.b32 t13, t9, t13; \n\t"
		"or.b32 t6, t12, %7; \n\t"
		"xor.b32 t12, t6, t13; \n\t"
		"xor.b32 %2, %2, t12; \n\t"

		"or.b32 t2, %5, t4; \n\t"
		"xor.b32 t6, t0, t2; \n\t"
		"or.b32 t12, t1, t3; \n\t"
		"xor.b32 t13, t6, t12; \n\t"

		"xor.b32 t4, t8, t9; \n\t"
		"not.b32 t0, t4; \n\t"
		"and.b32 t0, %8, t0; \n\t"
		"not.b32 t1, t5; \n\t"
		"xor.b32 t6, t2, t1; \n\t"
		"xor.b32 t12, t0, t6; \n\t"
		"not.b32 t9, %7; \n\t"
		"and.b32 t9, t12, t9; \n\t"
		"xor.b32 t12, t9, t13; \n\t"
		"xor.b32 %1, %1, t12; \n\t"

		"xor.b32 t9, %9, t11; \n\t"
		"xor.b32 t8, %4, t10; \n\t"
		"and.b32 t4, t9, t8; \n\t"
		"xor.b32 t5, t7, t6; \n\t"
		"xor.b32 t2, t4, t5; \n\t"
		"not.b32 t1, %7; \n\t"
		"and.b32 t1, t3, t1; \n\t"
		"xor.b32 t0, t1, t2; \n\t"
		"xor.b32 %0, %0, t0; \n\t"

	    "}                      \n\t"

	    : "+r"(*out1),  // %0
	      "+r"(*out2),  // %1
	      "+r"(*out3),  // %2
	      "+r"(*out4)   // %3
	      
	    : "r"(a1)     // %4
	      "r"(a2)     // %5
	      "r"(a3)     // %6
	      "r"(a4)     // %7
	      "r"(a5)     // %8
	      "r"(a6));   // %9
}

//
// s7-056945, 46 gates, 16 regs, 7 andn, 10/31/62/107/156 stalls, 67 biop
// Currently used for MMX/SSE2
//
DES_SBOX_FUNCTION_QUALIFIERS void
s7(DES_Vector a1, DES_Vector a2, DES_Vector a3, DES_Vector a4, DES_Vector a5, DES_Vector a6,
    DES_Vector * out1, DES_Vector * out2, DES_Vector * out3, DES_Vector * out4)
{
	asm("{                      \n\t"
	    ".reg .u32 t0;          \n\t"
	    ".reg .u32 t1;          \n\t"
	    ".reg .u32 t2;          \n\t"
	    ".reg .u32 t3;          \n\t"
	    ".reg .u32 t4;          \n\t"
	    ".reg .u32 t5;          \n\t"
	    ".reg .u32 t6;          \n\t"
	    ".reg .u32 t7;          \n\t"
	    ".reg .u32 t8;          \n\t"
	    ".reg .u32 t9;          \n\t"
	    
		"xor.b32 t6, %7, %8; \n\t"
		"xor.b32 t3, %6, t6; \n\t"
		"and.b32 t1, %9, t3; \n\t"
		"and.b32 t2, %7, t6; \n\t"
		"xor.b32 t4, %5, t2; \n\t"
		"and.b32 t0, t1, t4; \n\t"

		"and.b32 t7, %9, t2; \n\t"
		"xor.b32 t5, %6, t7; \n\t"
		"or.b32 t7, t4, t5; \n\t"
		"xor.b32 t8, %9, t6; \n\t"
		"xor.b32 t6, t7, t8; \n\t"
		"not.b32 t7, t0; \n\t"
		"and.b32 t7, %4, t7; \n\t"
		"xor.b32 t9, t7, t6; \n\t"
		"xor.b32 %3, %3, t9; \n\t"

		"not.b32 t7, t3; \n\t"
		"and.b32 t7, %8, t7; \n\t"
		"or.b32 t0, t4, t7; \n\t"
		"xor.b32 t9, t1, t5; \n\t"
		"xor.b32 t5, t0, t9; \n\t"

		"xor.b32 t0, t1, t8; \n\t"
		"not.b32 t1, t0; \n\t"
		"and.b32 t1, %7, t1; \n\t"
		"not.b32 t0, t1; \n\t"
		"and.b32 t0, t4, t0; \n\t"
		"xor.b32 t4, %8, t9; \n\t"
		"xor.b32 t1, t0, t4; \n\t"

		"or.b32 t9, t2, t6; \n\t"
		"and.b32 t0, %6, t1; \n\t"
		"or.b32 t4, t9, t0; \n\t"
		"not.b32 t2, t8; \n\t"
		"and.b32 t2, t3, t2; \n\t"
		"xor.b32 t6, t4, t2; \n\t"
		"not.b32 t8, %4; \n\t"
		"and.b32 t8, t6, t8; \n\t"
		"xor.b32 t9, t8, t5; \n\t"
		"xor.b32 %0, %0, t9; \n\t"

		"or.b32 t9, t1, t6; \n\t"
		"and.b32 t8, %9, t9; \n\t"
		"and.b32 t3, %5, t8; \n\t"
		"xor.b32 t4, t5, t6; \n\t"
		"xor.b32 t2, t3, t4; \n\t"

		"or.b32 t9, t0, t2; \n\t"
		"xor.b32 t5, t8, t9; \n\t"
		"xor.b32 t3, %8, t4; \n\t"
		"or.b32 t0, t5, t3; \n\t"
		"and.b32 t9, t0, %4; \n\t"
		"xor.b32 t5, t9, t1; \n\t"
		"xor.b32 %2, %2, t5; \n\t"

		"xor.b32 t9, t8, t0; \n\t"
		"or.b32 t4, t7, t9; \n\t"
		"not.b32 t5, t6; \n\t"
		"xor.b32 t3, t4, t5; \n\t"
		"not.b32 t1, %4; \n\t"
		"and.b32 t1, t3, t1; \n\t"
		"xor.b32 t0, t1, t2; \n\t"
		"xor.b32 %1, %1, t0; \n\t"


	    "}                      \n\t"

	    : "+r"(*out1),  // %0
	      "+r"(*out2),  // %1
	      "+r"(*out3),  // %2
	      "+r"(*out4)   // %3
	      
	    : "r"(a1)     // %4
	      "r"(a2)     // %5
	      "r"(a3)     // %6
	      "r"(a4)     // %7
	      "r"(a5)     // %8
	      "r"(a6));   // %9
}

//
// s8-004798, 41 gates, 14 regs, 7 andn, 7/35/76/118/160 stalls, 59 biop
// Currently used for MMX/SSE2
//
DES_SBOX_FUNCTION_QUALIFIERS void
s8(DES_Vector a1, DES_Vector a2, DES_Vector a3, DES_Vector a4, DES_Vector a5, DES_Vector a6,
    DES_Vector * out1, DES_Vector * out2, DES_Vector * out3, DES_Vector * out4)
{
	asm("{                      \n\t"
	    ".reg .u32 t0;          \n\t"
	    ".reg .u32 t1;          \n\t"
	    ".reg .u32 t2;          \n\t"
	    ".reg .u32 t3;          \n\t"
	    ".reg .u32 t4;          \n\t"
	    ".reg .u32 t5;          \n\t"
	    ".reg .u32 t6;          \n\t"
	    ".reg .u32 t7;          \n\t"
	    ".reg .u32 t8;          \n\t"
	    ".reg .u32 t9;          \n\t"
	    
		"not.b32 t8, %5; \n\t"
		"and.b32 t8, %6, t8; \n\t"
		"not.b32 t1, %6; \n\t"
		"and.b32 t1, %8, t1; \n\t"
		"xor.b32 t6, %7, t1; \n\t"
		"and.b32 t1, %4, t6; \n\t"
		"not.b32 t7, t8; \n\t"
		"and.b32 t7, t1, t7; \n\t"

		"not.b32 t3, t6; \n\t"
		"and.b32 t3, %5, t3; \n\t"
		"or.b32 t9, %4, t3; \n\t"
		"not.b32 t0, %6; \n\t"
		"and.b32 t0, %5, t0; \n\t"
		"xor.b32 t4, %8, t0; \n\t"
		"and.b32 t0, t9, t4; \n\t"
		"or.b32 t2, t1, t0; \n\t"

		"xor.b32 t1, t6, t0; \n\t"
		"not.b32 t0, t1; \n\t"
		"not.b32 t6, t9; \n\t"
		"and.b32 t6, %6, t6; \n\t"
		"xor.b32 t1, t0, t6; \n\t"
		"xor.b32 t9, t8, t1; \n\t"
		"or.b32 t8, t7, %9; \n\t"
		"xor.b32 t6, t8, t9; \n\t"
		"xor.b32 %1, %1, t6; \n\t"

		"xor.b32 t0, %4, t9; \n\t"
		"and.b32 t6, %8, t0; \n\t"
		"xor.b32 t8, %5, t1; \n\t"
		"xor.b32 t9, t6, t8; \n\t"
		"xor.b32 t1, t3, t9; \n\t"

		"or.b32 t6, %7, t8; \n\t"
		"xor.b32 t3, t1, t6; \n\t"
		"xor.b32 t5, t4, t3; \n\t"
		"xor.b32 t8, %4, t5; \n\t"
		"and.b32 t6, t8, %9; \n\t"
		"xor.b32 t4, t6, t1; \n\t"
		"xor.b32 %3, %3, t4; \n\t"

		"xor.b32 t6, t2, t9; \n\t"
		"or.b32 t4, %5, t6; \n\t"
		"xor.b32 t3, t0, t4; \n\t"
		"xor.b32 t8, %8, t3; \n\t"
		"and.b32 t9, t2, %9; \n\t"
		"xor.b32 t6, t9, t8; \n\t"
		"xor.b32 %2, %2, t6; \n\t"

		"or.b32  t9, %7, t0; \n\t"
		"not.b32 t6, t9; \n\t"
		"and.b32 t6, t8, t6; \n\t"
		"or.b32  t4, t7, t6; \n\t"
		"xor.b32 t3, t5, t4; \n\t"
		"or.b32  t2, t3, %9; \n\t"
		"xor.b32 t0, t2, t1; \n\t"
		"xor.b32 %0, %0, t0; \n\t"

	    "}                      \n\t"

	    : "+r"(*out1),  // %0
	      "+r"(*out2),  // %1
	      "+r"(*out3),  // %2
	      "+r"(*out4)   // %3
	      
	    : "r"(a1)     // %4
	      "r"(a2)     // %5
	      "r"(a3)     // %6
	      "r"(a4)     // %7
	      "r"(a5)     // %8
	      "r"(a6));   // %9
}

#define CLEAR_BLOCK_8(i)                                                             \
	DES_VECTOR_SET(DESContextArray[threadIdx.x].dataBlocks[i] , 0, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(DESContextArray[threadIdx.x].dataBlocks[i] , 1, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(DESContextArray[threadIdx.x].dataBlocks[i] , 2, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(DESContextArray[threadIdx.x].dataBlocks[i] , 3, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(DESContextArray[threadIdx.x].dataBlocks[i] , 4, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(DESContextArray[threadIdx.x].dataBlocks[i] , 5, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(DESContextArray[threadIdx.x].dataBlocks[i] , 6, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(DESContextArray[threadIdx.x].dataBlocks[i] , 7, DES_VECTOR_ZERO); \

#define CLEAR_BLOCK()  \
	CLEAR_BLOCK_8(0);  \
	CLEAR_BLOCK_8(8);  \
	CLEAR_BLOCK_8(16); \
	CLEAR_BLOCK_8(24); \
	CLEAR_BLOCK_8(32); \
	CLEAR_BLOCK_8(40); \
	CLEAR_BLOCK_8(48); \
	CLEAR_BLOCK_8(56); \

#define x(p)    DES_VECTOR_XOR_FUNC(DESContextArray[threadIdx.x].dataBlocks[CUDA_expansionFunction[p]], DESContextArray[threadIdx.x].keys[keySchedule[keyScheduleIndexBase + (p)]])
#define y(p, q) DES_VECTOR_XOR_FUNC(DESContextArray[threadIdx.x].dataBlocks[p],                         DESContextArray[threadIdx.x].keys[keySchedule[keyScheduleIndexBase + (q)]])
#define z(r)    (&DESContextArray[threadIdx.x].dataBlocks[r])

DES_FUNCTION_QUALIFIERS
void DES_Crypt()
{
	unsigned char iterations;
	short roundsAndSwapped; 
	short keyScheduleIndexBase = 0;

	if (threadIdx.y == 0)
		CLEAR_BLOCK();
	
	roundsAndSwapped = 8;
	iterations = 25;

start:
	__syncthreads();
	switch (threadIdx.y) {
	case 0: s1(x( 0),     x( 1),     x( 2),     x( 3),     x( 4),     x( 5),     z(40), z(48), z(54), z(62)); break;
	case 1: s2(x( 6),     x( 7),     x( 8),     x( 9),     x(10),     x(11),     z(44), z(59), z(33), z(49)); break;
	case 2: s3(y( 7, 12), y( 8, 13), y( 9, 14), y(10, 15), y(11, 16), y(12, 17), z(55), z(47), z(61), z(37)); break;
	case 3: s4(y(11, 18), y(12, 19), y(13, 20), y(14, 21), y(15, 22), y(16, 23), z(57), z(51), z(41), z(32)); break;
	case 4: s5(x(24),     x(25),     x(26),     x(27),     x(28),     x(29),     z(39), z(45), z(56), z(34)); break;
	case 5: s6(x(30),     x(31),     x(32),     x(33),     x(34),     x(35),     z(35), z(60), z(42), z(50)); break;
	case 6: s7(y(23, 36), y(24, 37), y(25, 38),	y(26, 39), y(27, 40), y(28, 41), z(63), z(43), z(53), z(38)); break;
	case 7: s8(y(27, 42), y(28, 43), y(29, 44), y(30, 45), y(31, 46), y( 0, 47), z(36), z(58), z(46), z(52)); break;
	}
	__syncthreads();

	if (roundsAndSwapped == 0x100)
		goto next;

swap:
	__syncthreads();
	switch (threadIdx.y) {
	case 0: s1(x(48),     x(49),     x(50),     x(51),     x(52),     x(53),     z( 8), z(16), z(22), z(30)); break;
	case 1: s2(x(54),     x(55),     x(56),     x(57),     x(58),     x(59),     z(12), z(27), z( 1), z(17)); break;
	case 2: s3(y(39, 60), y(40, 61), y(41, 62), y(42, 63), y(43, 64), y(44, 65), z(23), z(15), z(29), z( 5)); break;
	case 3: s4(y(43, 66), y(44, 67), y(45, 68), y(46, 69), y(47, 70), y(48, 71), z(25), z(19), z( 9), z( 0)); break;
	case 4: s5(x(72),     x(73),     x(74),     x(75),     x(76),     x(77),     z( 7), z(13), z(24), z( 2)); break;
	case 5: s6(x(78),     x(79),     x(80),     x(81),     x(82),     x(83),     z( 3), z(28), z(10), z(18)); break;
	case 6: s7(y(55, 84), y(56, 85), y(57, 86), y(58, 87), y(59, 88), y(60, 89), z(31), z(11), z(21), z( 6)); break;
	case 7: s8(y(59, 90), y(60, 91), y(61, 92), y(62, 93), y(63, 94), y(32, 95), z( 4), z(26), z(14), z(20)); break;
	}	
	__syncthreads();

	keyScheduleIndexBase += 96;

	if (--roundsAndSwapped)
		goto start;
	keyScheduleIndexBase -= (0x300 + 48);
	roundsAndSwapped = 0x108;
	if (--iterations)
		goto swap;
	return;

next:
	keyScheduleIndexBase -= (0x300 - 48);
	roundsAndSwapped = 8;
	iterations--;
	goto start;
}

#define GET_TRIPCODE_CHAR_INDEX(r, t, i0, i1, i2, i3, i4, i5, pos)  \
		(  ((((r)[i0] & (0x01 << (t))) ? (0x1) : (0x0)) << (5 + ((pos) * 6)))  \
	 	 | ((((r)[i1] & (0x01 << (t))) ? (0x1) : (0x0)) << (4 + ((pos) * 6)))  \
		 | ((((r)[i2] & (0x01 << (t))) ? (0x1) : (0x0)) << (3 + ((pos) * 6)))  \
		 | ((((r)[i3] & (0x01 << (t))) ? (0x1) : (0x0)) << (2 + ((pos) * 6)))  \
		 | ((((r)[i4] & (0x01 << (t))) ? (0x1) : (0x0)) << (1 + ((pos) * 6)))  \
		 | ((((r)[i5] & (0x01 << (t))) ? (0x1) : (0x0)) << (0 + ((pos) * 6)))) \

#define GET_TRIPCODE_CHAR_INDEX_LAST(r, t, i0, i1, i2, i3)     \
		(  ((((r)[i0] & (0x01 << (t))) ? (0x1) : (0x0)) << 5)  \
	 	 | ((((r)[i1] & (0x01 << (t))) ? (0x1) : (0x0)) << 4)  \
		 | ((((r)[i2] & (0x01 << (t))) ? (0x1) : (0x0)) << 3)  \
		 | ((((r)[i3] & (0x01 << (t))) ? (0x1) : (0x0)) << 2)) \

DES_FUNCTION_QUALIFIERS void
DES_GetTripcodeChunks(int tripcodeIndex, unsigned int *tripcodeChunkArray, int searchMode)
{
	// Perform the final permutation here.
	if (searchMode == SEARCH_MODE_FORWARD_MATCHING) {
		tripcodeChunkArray[0] =   GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
	} else if (searchMode == SEARCH_MODE_BACKWARD_MATCHING) {
		tripcodeChunkArray[0] =   GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 4)
		                        | GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 3)
		                        | GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 2)
		                        | GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 1)
		                        | GET_TRIPCODE_CHAR_INDEX_LAST(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 48, 16, 56, 24);
	} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {
		tripcodeChunkArray[0] =   GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		tripcodeChunkArray[1] =   GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 4)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 3)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 2)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 1)
								| GET_TRIPCODE_CHAR_INDEX_LAST(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 48, 16, 56, 24);
	} else {
		tripcodeChunkArray[0] =   GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
								| GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		tripcodeChunkArray[1] = ((tripcodeChunkArray[0] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 0);
		tripcodeChunkArray[2] = ((tripcodeChunkArray[1] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 0);
		tripcodeChunkArray[3] = ((tripcodeChunkArray[2] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 0);
		tripcodeChunkArray[4] = ((tripcodeChunkArray[3] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 0);
		tripcodeChunkArray[5] = ((tripcodeChunkArray[4] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX_LAST(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 48, 16, 56, 24);
	}
}

DES_FUNCTION_QUALIFIERS
unsigned char *DES_GetTripcode(int tripcodeIndex, unsigned char *tripcode)
{
	// Perform the final permutation as necessary.
  	tripcode[0] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 0)];
  	tripcode[1] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 0)];
  	tripcode[2] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 0)];
  	tripcode[3] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 0)];
  	tripcode[4] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0)];
  	tripcode[5] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 0)];
  	tripcode[6] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 0)];
  	tripcode[7] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 0)];
  	tripcode[8] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 0)];
	tripcode[9] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX_LAST(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 48, 16, 56, 24)];
 	tripcode[10] = '\0';

	return tripcode;
}

#define SET_KEY_CHAR(var, flag, table, value)             \
	if (!(flag)) {                                        \
		var = (table)[(value)];                           \
		isSecondByte = IS_FIRST_BYTE_SJIS(var);           \
	} else {                                              \
		var = CUDA_keyCharTable_SecondByte[(value)];          \
		isSecondByte = FALSE;                             \
	}

#define CUDA_DES_DEFINE_SEARCH_FUNCTION(functionName) \
__global__ void functionName(\
	GPUOutput *outputArray,\
	unsigned char      *keyBitmap,\
	unsigned int     *tripcodeChunkArray,\
	unsigned int      numTripcodeChunk,\
	int         searchMode) {

#define SET_ALL_BITS_FOR_KEY(i, j, k)                                  \
	if (key[j] & (0x1 << (k)))                                         \
		DESContextArray[threadIdx.x].keys[i] = 0xffffffff;             \

#define SET_BIT_FOR_KEY(i, j, k)                                       \
	if (key[j] & (0x1 << (k)))                                         \
		DESContextArray[threadIdx.x].keys[i] |= 0x1 << tripcodeIndex;  \

#define CUDA_DES_BEFORE_SEARCHING \
	GPUOutput  *output = &outputArray[blockIdx.x * CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK + threadIdx.x];\
	unsigned char        key[8];\
	BOOL         isSecondByte, isKey6SecondByte;\
	unsigned char        tripcodeIndex;\
	unsigned char        passCount;\
	\
	if (threadIdx.y == 0) {\
		output->numMatchingTripcodes = 0;\
		key[0] = CUDA_key[0];\
		key[1] = CUDA_key[1];\
		key[2] = CUDA_key[2];\
		isSecondByte = IS_FIRST_BYTE_SJIS(CUDA_key[2]);\
		SET_KEY_CHAR(key[3], isSecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[3] + ((blockIdx.x  >> 6) & 63));\
		SET_KEY_CHAR(key[4], isSecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[4] + ( blockIdx.x        & 63));\
		SET_KEY_CHAR(key[5], isSecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[5] + ( threadIdx.x       & 63));\
		isKey6SecondByte = isSecondByte;\
	}\
		                            \
	DES_ClearKeys(0);               \
	SET_ALL_BITS_FOR_KEY( 0, 0, 0); \
	SET_ALL_BITS_FOR_KEY( 1, 0, 1); \
	SET_ALL_BITS_FOR_KEY( 2, 0, 2); \
	SET_ALL_BITS_FOR_KEY( 3, 0, 3); \
	SET_ALL_BITS_FOR_KEY( 4, 0, 4); \
	SET_ALL_BITS_FOR_KEY( 5, 0, 5); \
	SET_ALL_BITS_FOR_KEY( 6, 0, 6); \
		                            \
	DES_ClearKeys(1);               \
	SET_ALL_BITS_FOR_KEY( 7, 1, 0); \
	SET_ALL_BITS_FOR_KEY( 8, 1, 1); \
	SET_ALL_BITS_FOR_KEY( 9, 1, 2); \
	SET_ALL_BITS_FOR_KEY(10, 1, 3); \
	SET_ALL_BITS_FOR_KEY(11, 1, 4); \
	SET_ALL_BITS_FOR_KEY(12, 1, 5); \
	SET_ALL_BITS_FOR_KEY(13, 1, 6); \
		                            \
	DES_ClearKeys(2);               \
	SET_ALL_BITS_FOR_KEY(14, 2, 0); \
	SET_ALL_BITS_FOR_KEY(15, 2, 1); \
	SET_ALL_BITS_FOR_KEY(16, 2, 2); \
	SET_ALL_BITS_FOR_KEY(17, 2, 3); \
	SET_ALL_BITS_FOR_KEY(18, 2, 4); \
	SET_ALL_BITS_FOR_KEY(19, 2, 5); \
	SET_ALL_BITS_FOR_KEY(20, 2, 6); \
		                            \
	DES_ClearKeys(3);               \
	SET_ALL_BITS_FOR_KEY(21, 3, 0); \
	SET_ALL_BITS_FOR_KEY(22, 3, 1); \
	SET_ALL_BITS_FOR_KEY(23, 3, 2); \
	SET_ALL_BITS_FOR_KEY(24, 3, 3); \
	SET_ALL_BITS_FOR_KEY(25, 3, 4); \
	SET_ALL_BITS_FOR_KEY(26, 3, 5); \
	SET_ALL_BITS_FOR_KEY(27, 3, 6); \
		                            \
	DES_ClearKeys(4);               \
	SET_ALL_BITS_FOR_KEY(28, 4, 0); \
	SET_ALL_BITS_FOR_KEY(29, 4, 1); \
	SET_ALL_BITS_FOR_KEY(30, 4, 2); \
	SET_ALL_BITS_FOR_KEY(31, 4, 3); \
	SET_ALL_BITS_FOR_KEY(32, 4, 4); \
	SET_ALL_BITS_FOR_KEY(33, 4, 5); \
	SET_ALL_BITS_FOR_KEY(34, 4, 6); \
		                            \
	DES_ClearKeys(5);               \
	SET_ALL_BITS_FOR_KEY(35, 5, 0); \
	SET_ALL_BITS_FOR_KEY(36, 5, 1); \
	SET_ALL_BITS_FOR_KEY(37, 5, 2); \
	SET_ALL_BITS_FOR_KEY(38, 5, 3); \
	SET_ALL_BITS_FOR_KEY(39, 5, 4); \
	SET_ALL_BITS_FOR_KEY(40, 5, 5); \
	SET_ALL_BITS_FOR_KEY(41, 5, 6); \
		                            \
	for (passCount = 0; passCount < CUDA_DES_MAX_PASS_COUNT; ++passCount) {\
		__syncthreads();\
		\
		if (threadIdx.y == 0) {\
			SET_KEY_CHAR(key[6], isKey6SecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[6] + ((passCount & 0xf)  | ((threadIdx.x & 0xc0) >> 2)));\
			DES_ClearKeys(6);               \
			SET_ALL_BITS_FOR_KEY(42, 6, 0);      \
			SET_ALL_BITS_FOR_KEY(43, 6, 1);      \
			SET_ALL_BITS_FOR_KEY(44, 6, 2);      \
			SET_ALL_BITS_FOR_KEY(45, 6, 3);      \
			SET_ALL_BITS_FOR_KEY(46, 6, 4);      \
			SET_ALL_BITS_FOR_KEY(47, 6, 5);      \
			SET_ALL_BITS_FOR_KEY(48, 6, 6);      \
			\
			DES_ClearKeys(7);               \
			if (isSecondByte) {\
				for (tripcodeIndex = 0; tripcodeIndex < CUDA_DES_BS_DEPTH; ++tripcodeIndex) {\
					key[7] = CUDA_keyCharTable_SecondByte[CUDA_key[7] + (tripcodeIndex & 63)];\
					SET_BIT_FOR_KEY(49, 7, 0);      \
					SET_BIT_FOR_KEY(50, 7, 1);      \
					SET_BIT_FOR_KEY(51, 7, 2);      \
					SET_BIT_FOR_KEY(52, 7, 3);      \
					SET_BIT_FOR_KEY(53, 7, 4);      \
					SET_BIT_FOR_KEY(54, 7, 5);      \
					SET_BIT_FOR_KEY(55, 7, 6);      \
				}\
			} else {\
				for (tripcodeIndex = 0; tripcodeIndex < CUDA_DES_BS_DEPTH; ++tripcodeIndex) {\
					key[7] = CUDA_keyCharTable_FirstByte [CUDA_key[7] + (tripcodeIndex & 63)];\
					SET_BIT_FOR_KEY(49, 7, 0);      \
					SET_BIT_FOR_KEY(50, 7, 1);      \
					SET_BIT_FOR_KEY(51, 7, 2);      \
					SET_BIT_FOR_KEY(52, 7, 3);      \
					SET_BIT_FOR_KEY(53, 7, 4);      \
					SET_BIT_FOR_KEY(54, 7, 5);      \
					SET_BIT_FOR_KEY(55, 7, 6);      \
				}\
			}\
		}\
		\
		__syncthreads();\
		DES_Crypt();\
		\
		__syncthreads();\
		if (threadIdx.y == 0) {\
			BOOL found = FALSE;\
			for (tripcodeIndex = 0; tripcodeIndex < CUDA_DES_BS_DEPTH; ++tripcodeIndex) {

#define CUDA_DES_END_OF_SEAERCH_FUNCTION \
			}\
quit_loops:\
			if (found == TRUE) {\
				output->numMatchingTripcodes  = 1;\
				DES_GetTripcode(tripcodeIndex, output->pair.tripcode.c);\
				output->pair.key.c[0] = key[0];\
				output->pair.key.c[1] = key[1];\
				output->pair.key.c[2] = key[2];\
				output->pair.key.c[3] = key[3];\
				output->pair.key.c[4] = key[4];\
				output->pair.key.c[5] = key[5];\
				output->pair.key.c[6] = key[6];\
				output->pair.key.c[7] = (isSecondByte)\
												? (CUDA_keyCharTable_SecondByte[CUDA_key[7] + (tripcodeIndex & 63)])\
												: (CUDA_keyCharTable_FirstByte [CUDA_key[7] + (tripcodeIndex & 63)]);\
			}\
		}\
	}\
	if (threadIdx.y == 0)\
		output->numGeneratedTripcodes = CUDA_DES_BS_DEPTH * CUDA_DES_MAX_PASS_COUNT;\
}

CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_ForwardOrBackwardMatching_Simple)
	unsigned int tripcodeChunk;
CUDA_DES_BEFORE_SEARCHING
	DES_GetTripcodeChunks(tripcodeIndex, &tripcodeChunk, searchMode);
	for (int j = 0; j < numTripcodeChunk; ++j){
		if (tripcodeChunkArray[j] == tripcodeChunk) {
			found = TRUE;
			goto quit_loops;
		}
	}
CUDA_DES_END_OF_SEAERCH_FUNCTION

CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_ForwardOrBackwardMatching)
	unsigned int tripcodeChunk;
CUDA_DES_BEFORE_SEARCHING
	DES_GetTripcodeChunks(tripcodeIndex, &tripcodeChunk, searchMode);
	if (keyBitmap[tripcodeChunk >> ((5 - KEY_BITMAP_LEN_STRING) * 6)])
		continue;
	for (int j = 0; j < numTripcodeChunk; ++j){
		int lower = 0, upper = numTripcodeChunk - 1, middle = lower;
		while (tripcodeChunk != tripcodeChunkArray[middle] && lower <= upper) {
			middle = (lower + upper) >> 1;
			if (tripcodeChunk > tripcodeChunkArray[middle]) {
				lower = middle + 1;
			} else {
				upper = middle - 1;
			}
		}
		if (tripcodeChunk == tripcodeChunkArray[middle]) {
			found = TRUE;
			goto quit_loops;
		}
	}
CUDA_DES_END_OF_SEAERCH_FUNCTION

CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_ForwardMatching_1Chunk)
	unsigned int tripcodeChunk0 = tripcodeChunkArray[0];
CUDA_DES_BEFORE_SEARCHING
	if (GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 0) != ((tripcodeChunk0 >> (6 * 4)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 0) != ((tripcodeChunk0 >> (6 * 3)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 0) != ((tripcodeChunk0 >> (6 * 2)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 0) != ((tripcodeChunk0 >> (6 * 1)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0) != ((tripcodeChunk0 >> (6 * 0)) & 0x3f))
		goto skip_final_permutation;
	found = TRUE;
	goto quit_loops;
skip_final_permutation:
CUDA_DES_END_OF_SEAERCH_FUNCTION

CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_BackwardMatching_1Chunk)
	unsigned int tripcodeChunk0 = tripcodeChunkArray[0];
CUDA_DES_BEFORE_SEARCHING
	if (GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 0) != ((tripcodeChunk0 >> (6 * 4)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 0) != ((tripcodeChunk0 >> (6 * 3)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 0) != ((tripcodeChunk0 >> (6 * 2)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 0) != ((tripcodeChunk0 >> (6 * 1)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX_LAST(DESContextArray[threadIdx.x].dataBlocks, tripcodeIndex, 48, 16, 56, 24) != ((tripcodeChunk0 >> (6 * 0)) & 0x3f))
		goto skip_final_permutation;
	found = TRUE;
	goto quit_loops;
skip_final_permutation:
CUDA_DES_END_OF_SEAERCH_FUNCTION

CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_Flexible_Simple)
	unsigned int generatedTripcodeChunkArray[6];
CUDA_DES_BEFORE_SEARCHING
	DES_GetTripcodeChunks(tripcodeIndex, generatedTripcodeChunkArray, searchMode);
	for (int pos = 0; pos < 6; ++pos) {
		for (int j = 0; j < numTripcodeChunk; ++j){
			if (tripcodeChunkArray[j] == generatedTripcodeChunkArray[pos]) {
				found = TRUE;
				goto quit_loops;
			}
		}
	}
CUDA_DES_END_OF_SEAERCH_FUNCTION

CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_Flexible)
	unsigned int generatedTripcodeChunkArray[6];
CUDA_DES_BEFORE_SEARCHING
	DES_GetTripcodeChunks(tripcodeIndex, generatedTripcodeChunkArray, searchMode);
	for (int pos = 0; pos < 6; ++pos) {
		unsigned int generatedTripcodeChunk = generatedTripcodeChunkArray[pos];
		if (keyBitmap[generatedTripcodeChunk >> ((5 - KEY_BITMAP_LEN_STRING) * 6)])
			continue;
		for (int j = 0; j < numTripcodeChunk; ++j){
			int lower = 0, upper = numTripcodeChunk - 1, middle = lower;
			while (generatedTripcodeChunk != tripcodeChunkArray[middle] && lower <= upper) {
				middle = (lower + upper) >> 1;
				if (generatedTripcodeChunk > tripcodeChunkArray[middle]) {
					lower = middle + 1;
				} else {
					upper = middle - 1;
				}
			}
			if (generatedTripcodeChunk == tripcodeChunkArray[middle]) {
				found = TRUE;
				goto quit_loops;
			}
		}
	}
CUDA_DES_END_OF_SEAERCH_FUNCTION

CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_ForwardAndBackwardMatching_Simple)
	unsigned int generatedTripcodeChunkArray[6];
CUDA_DES_BEFORE_SEARCHING
	DES_GetTripcodeChunks(tripcodeIndex, generatedTripcodeChunkArray, searchMode);
	//
	for (int j = 0; j < numTripcodeChunk; ++j){
		if (tripcodeChunkArray[j] == generatedTripcodeChunkArray[0]) {
			found = TRUE;
			goto quit_loops;
		}
	}
	//
	for (int j = 0; j < numTripcodeChunk; ++j){
		if (tripcodeChunkArray[j] == generatedTripcodeChunkArray[1]) {
			found = TRUE;
			goto quit_loops;
		}
	}
CUDA_DES_END_OF_SEAERCH_FUNCTION

CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_ForwardAndBackwardMatching)
	unsigned int generatedTripcodeChunkArray[6];
	unsigned int generatedTripcodeChunk;
CUDA_DES_BEFORE_SEARCHING
	DES_GetTripcodeChunks(tripcodeIndex, generatedTripcodeChunkArray, searchMode);
	//
	generatedTripcodeChunk = generatedTripcodeChunkArray[0];
	if (!keyBitmap[generatedTripcodeChunk >> ((5 - KEY_BITMAP_LEN_STRING) * 6)]) {
		for (int j = 0; j < numTripcodeChunk; ++j){
			int lower = 0, upper = numTripcodeChunk - 1, middle = lower;
			while (generatedTripcodeChunk != tripcodeChunkArray[middle] && lower <= upper) {
				middle = (lower + upper) >> 1;
				if (generatedTripcodeChunk > tripcodeChunkArray[middle]) {
					lower = middle + 1;
				} else {
					upper = middle - 1;
				}
			}
			if (generatedTripcodeChunk == tripcodeChunkArray[middle]) {
				found = TRUE;
				goto quit_loops;
			}
		}
	}
	//
	generatedTripcodeChunk = generatedTripcodeChunkArray[1];
	if (!keyBitmap[generatedTripcodeChunk >> ((5 - KEY_BITMAP_LEN_STRING) * 6)]) {
		for (int j = 0; j < numTripcodeChunk; ++j) {
			int lower = 0, upper = numTripcodeChunk - 1, middle = lower;
			while (generatedTripcodeChunk != tripcodeChunkArray[middle] && lower <= upper) {
				middle = (lower + upper) >> 1;
				if (generatedTripcodeChunk > tripcodeChunkArray[middle]) {
					lower = middle + 1;
				} else {
					upper = middle - 1;
				}
			}
			if (generatedTripcodeChunk == tripcodeChunkArray[middle]) {
				found = TRUE;
				goto quit_loops;
			}
		}
	}
CUDA_DES_END_OF_SEAERCH_FUNCTION



///////////////////////////////////////////////////////////////////////////////
// CUDA SEARCH THREAD FOR 10 CHARACTER TRIPCODES                             //
///////////////////////////////////////////////////////////////////////////////

unsigned WINAPI Thread_SearchForDESTripcodesOnCUDADevice(LPVOID info)
{
	cudaError_t     cudaError;
	cudaDeviceProp  CUDADeviceProperties;
	unsigned int    numBlocksPerSM;
	unsigned int    numBlocksPerGrid;
	GPUOutput      *outputArray = NULL;
	GPUOutput      *CUDA_outputArray = NULL;
	unsigned int   *CUDA_tripcodeChunkArray = NULL;
	unsigned char  *CUDA_keyBitmap = NULL;
	unsigned int    sizeOutputArray;
	unsigned char   key[MAX_LEN_TRIPCODE + 1];
	unsigned char   salt[3];
	unsigned char   expansionFunction[96];
	char            status[LEN_LINE_BUFFER_FOR_SCREEN] = "";
	int             optimizationPhase    = CUDA_OPTIMIZATION_PHASE_NUM_BLOCKS;
	int             optimizationSubphase = 0;
	double          timeElapsedInOptimizationSubphase = 0;
	static int      numBlocksTableForOptimization[] = {8, 16, 32, 48, 64, 96, 128, 160, 192, 224, 256, 0};
	double          numGeneratedTripcodes = 0;
	double          speedInPreviousSubphase = 0;
	double          speedInCurrentSubphase = 0;
	DWORD           startingTime;
	DWORD           endingTime;
	double          deltaTime;

	key[lenTripcode] = '\0';
	salt[2]          = '\0';
	
	CUDA_ERROR(cudaSetDevice(((CUDADeviceSearchThreadInfo *)info)->CUDADeviceIndex));
	CUDA_ERROR(cudaGetDeviceProperties(&CUDADeviceProperties, ((CUDADeviceSearchThreadInfo *)info)->CUDADeviceIndex));
	if (CUDADeviceProperties.computeMode == cudaComputeModeProhibited) {
		sprintf(status, "[disabled]");
		UpdateCUDADeviceStatus(((CUDADeviceSearchThreadInfo *)info), FALSE, status);
		return 0;
	}

	if (options.CUDANumBlocksPerSM == CUDA_NUM_BLOCKS_PER_SM_NIL) {
		numBlocksPerSM = numBlocksTableForOptimization[optimizationSubphase];
	} else {
		numBlocksPerSM = options.CUDANumBlocksPerSM;
	}
	numBlocksPerGrid = numBlocksPerSM * CUDADeviceProperties.multiProcessorCount;
	sizeOutputArray = CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK * numBlocksPerGrid;
	outputArray = (GPUOutput *)malloc(sizeof(GPUOutput) * sizeOutputArray);
	ERROR0(outputArray == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	cudaError = cudaMalloc((void **)&CUDA_outputArray, sizeof(GPUOutput) * sizeOutputArray);
	ERROR0(cudaError == cudaErrorMemoryAllocation, ERROR_NO_MEMORY, "Not enough memory.");
	CUDA_ERROR(cudaError);
	cudaError = cudaMalloc((void **)&CUDA_keyBitmap, KEY_BITMAP_SIZE);
	ERROR0(cudaError == cudaErrorMemoryAllocation, ERROR_NO_MEMORY, "Not enough memory.");
	CUDA_ERROR(cudaError);
	cudaError = cudaMalloc((void **)&CUDA_tripcodeChunkArray, sizeof(unsigned int) * numTripcodeChunk); 
	ERROR0(cudaError == cudaErrorMemoryAllocation, ERROR_NO_MEMORY, "Not enough memory.");
	CUDA_ERROR(cudaError);

	CUDA_ERROR(cudaMemcpy(CUDA_tripcodeChunkArray, tripcodeChunkArray, sizeof(unsigned int) * numTripcodeChunk, cudaMemcpyHostToDevice));
	CUDA_ERROR(cudaMemcpy(CUDA_keyBitmap, keyBitmap, KEY_BITMAP_SIZE, cudaMemcpyHostToDevice));
	CUDA_ERROR(cudaMemcpyToSymbol(CUDA_base64CharTable,      base64CharTable,      sizeof(base64CharTable)));
	CUDA_ERROR(cudaMemcpyToSymbol(CUDA_keyCharTable_OneByte, keyCharTable_OneByte, SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(CUDA_keyCharTable_FirstByte,   keyCharTable_FirstByte,   SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(CUDA_keyCharTable_SecondByte,  keyCharTable_SecondByte,  SIZE_KEY_CHAR_TABLE));
	
	startingTime = timeGetTime();

	while (!GetTerminationState()) {
		// Choose the first 3 characters of the key.
		SetCharactersInTripcodeKey(key, 3);
		
		// Make sure that the first 3 bytes consist of valid Shift-JIS characters.
		for (int i = 3; i < lenTripcode; ++i)
			key[i] = 'A';
		if (!IsValidKey(key))
			continue;
		
		// Generate random bytes for the key to ensure the randomness of them.
		unsigned char randomByteForKey6 = RandomByte();
		for (int i = 3; i < lenTripcode; ++i)
			key[i] = RandomByte();
		
		// Create an expansion function based on the salt.
		salt[0] = CONVERT_CHAR_FOR_SALT(key[1]);
		salt[1] = CONVERT_CHAR_FOR_SALT(key[2]);
		DES_CreateExpansionFunction((char *)salt, expansionFunction);

		// Call an appropriate CUDA kernel.
		CUDA_ERROR(cudaMemcpyToSymbol(CUDA_key,               key,               lenTripcode));
		CUDA_ERROR(cudaMemcpyToSymbol(CUDA_expansionFunction, expansionFunction, sizeof(expansionFunction)));
		dim3 dimBlock(CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK, CUDA_DES_NUM_THREADS_FOR_BITSLICE);
		dim3 dimGrid(numBlocksPerGrid);
		if (searchMode == SEARCH_MODE_FLEXIBLE) {
			if (numTripcodeChunk <= CUDA_SIMPLE_SEARCH_THRESHOLD) {
				CUDA_PerformSearching_DES_Flexible_Simple<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					searchMode);
			} else {
				CUDA_PerformSearching_DES_Flexible<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					searchMode);
			}
		} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {
			if (numTripcodeChunk <= CUDA_SIMPLE_SEARCH_THRESHOLD) {
				CUDA_PerformSearching_DES_ForwardAndBackwardMatching_Simple<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					searchMode);
			} else {
				CUDA_PerformSearching_DES_ForwardAndBackwardMatching<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					searchMode);
			}
		} else {
			if (numTripcodeChunk == 1) {
				if (searchMode == SEARCH_MODE_FORWARD_MATCHING) {
					CUDA_PerformSearching_DES_ForwardMatching_1Chunk<<<dimGrid, dimBlock>>>(
						CUDA_outputArray,
						CUDA_keyBitmap,
						CUDA_tripcodeChunkArray,
						numTripcodeChunk,
						searchMode);
				} else {
					CUDA_PerformSearching_DES_BackwardMatching_1Chunk<<<dimGrid, dimBlock>>>(
						CUDA_outputArray,
						CUDA_keyBitmap,
						CUDA_tripcodeChunkArray,
						numTripcodeChunk,
						searchMode);
				}
			} else if (numTripcodeChunk <= CUDA_SIMPLE_SEARCH_THRESHOLD) {
				CUDA_PerformSearching_DES_ForwardOrBackwardMatching_Simple<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					searchMode);
			} else {
				CUDA_PerformSearching_DES_ForwardOrBackwardMatching<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					searchMode);
			}
		}
		CUDA_ERROR(cudaGetLastError());
		// CUDA_ERROR(cudaDeviceSynchronize()); // Check errors at kernel launch.

		// Process the output array.
		CUDA_ERROR(cudaMemcpy(outputArray, CUDA_outputArray, sizeof(GPUOutput) * sizeOutputArray, cudaMemcpyDeviceToHost));
		numGeneratedTripcodes += ProcessGPUOutput(key, outputArray, sizeOutputArray, FALSE);
		
		// Optimization
		endingTime = timeGetTime();
		deltaTime = (endingTime >= startingTime)
						? ((double)endingTime - (double)startingTime                     ) * 0.001
						: ((double)endingTime - (double)startingTime + (double)0xffffffff) * 0.001;
		while (GetPauseState() && !GetTerminationState())
			Sleep(PAUSE_INTERVAL);
		startingTime = timeGetTime();
		timeElapsedInOptimizationSubphase += deltaTime;
		speedInCurrentSubphase = numGeneratedTripcodes / timeElapsedInOptimizationSubphase;
		//
		if (optimizationPhase == CUDA_OPTIMIZATION_PHASE_NUM_BLOCKS) {
			if (options.CUDANumBlocksPerSM != CUDA_NUM_BLOCKS_PER_SM_NIL) {
				optimizationPhase     = CUDA_OPTIMIZATION_PHASE_COMPLETED;
				optimizationSubphase  = 0;
				numGeneratedTripcodes = 0;
				timeElapsedInOptimizationSubphase = 0;
			} else if (timeElapsedInOptimizationSubphase >= CUDA_OPTIMIZATION_SUBPHASE_DURATION) {
				if (   optimizationSubphase > 0
				    && (   speedInPreviousSubphase > speedInCurrentSubphase
					    || fabs(speedInPreviousSubphase - speedInCurrentSubphase) / speedInPreviousSubphase < CUDA_OPTIMIZATION_THRESHOLD)) {
					numBlocksPerSM = numBlocksTableForOptimization[(speedInPreviousSubphase > speedInCurrentSubphase) ? (optimizationSubphase - 1) : (optimizationSubphase)];
					optimizationPhase = CUDA_OPTIMIZATION_PHASE_COMPLETED;
					optimizationSubphase = 0;
					numGeneratedTripcodes = 0;
				} else if (numBlocksTableForOptimization[optimizationSubphase + 1] > 0) {
					numBlocksPerSM = numBlocksTableForOptimization[++optimizationSubphase];
					timeElapsedInOptimizationSubphase = 0;
					numGeneratedTripcodes = 0;
					speedInPreviousSubphase = speedInCurrentSubphase;
				} else {
					optimizationPhase = CUDA_OPTIMIZATION_PHASE_COMPLETED;
					optimizationSubphase = 0;
					numGeneratedTripcodes = 0;
				}
				timeElapsedInOptimizationSubphase = 0;
				numGeneratedTripcodes = 0;
				numBlocksPerGrid = numBlocksPerSM * CUDADeviceProperties.multiProcessorCount;
				sizeOutputArray = CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK * numBlocksPerGrid;
				free(outputArray);
				outputArray = (GPUOutput *)malloc(sizeof(GPUOutput) * sizeOutputArray);
				ERROR0(outputArray == NULL, ERROR_NO_MEMORY, "Not enough memory.");
				CUDA_ERROR(cudaFree(CUDA_outputArray));
				cudaError = cudaMalloc((void **)&CUDA_outputArray, sizeof(GPUOutput) * sizeOutputArray);
				ERROR0(cudaError == cudaErrorMemoryAllocation, ERROR_NO_MEMORY, "Not enough memory.");
				CUDA_ERROR(cudaError);
			}
		}
		//
		sprintf(status,
			    "%s%.1lfM TPS, %d blocks/SM",
				(optimizationPhase != CUDA_OPTIMIZATION_PHASE_COMPLETED) ? "[optimizing...] " : "",
				speedInCurrentSubphase / 1000000,
				numBlocksPerSM);
		UpdateCUDADeviceStatus(((CUDADeviceSearchThreadInfo *)info), (optimizationPhase != CUDA_OPTIMIZATION_PHASE_COMPLETED), status);
	}

	RELEASE_AND_SET_TO_NULL(CUDA_outputArray,        cudaFree);
	RELEASE_AND_SET_TO_NULL(CUDA_tripcodeChunkArray, cudaFree);
	RELEASE_AND_SET_TO_NULL(CUDA_keyBitmap,          cudaFree);
	RELEASE_AND_SET_TO_NULL(outputArray,             free);
}
