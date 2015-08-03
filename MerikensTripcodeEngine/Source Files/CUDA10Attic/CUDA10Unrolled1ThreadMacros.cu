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
__device__ __constant__ char            CUDA_base64CharTable[64];
__device__ __constant__ unsigned char   CUDA_key[12];



///////////////////////////////////////////////////////////////////////////////
// BITSLICE DES                                                              //
///////////////////////////////////////////////////////////////////////////////

#define CUDA_DES_BS_DEPTH                   32
#define CUDA_DES_NUM_THREADS_PER_BLOCK      64
#define CUDA_DES_NUM_THREADS_FOR_BITSLICE   1
#define CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK (CUDA_DES_NUM_THREADS_PER_BLOCK / CUDA_DES_NUM_THREADS_FOR_BITSLICE)

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
#define DES_VECTOR_SET(dst, ofs, src) *((DES_Vector *)((DES_Vector *)&(dst) + ((ofs) << DB_SHIFT))) = (src)

#define DES_CONSTANT_QUALIFIERS      __device__ __constant__
#define DES_FUNCTION_QUALIFIERS      __device__ __forceinline__
#define DES_SBOX_FUNCTION_QUALIFIERS __device__ __forceinline__

__device__ __shared__ DES_Vector dataBlocks[64 * CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK];
#define DB_SHIFT 6

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
__device__ __constant__ unsigned char CUDA_key7Array[CUDA_DES_BS_DEPTH];
__device__ __constant__ DES_Vector    CUDA_keyFrom49To55Array[7];

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
#define s1(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
	(t0) = ~(a5);\
	(t0) = (a1) & (t0);\
	(t1) = (a4) ^ (t0);\
	(t2) = (a3) | (a6);\
	(t3) = (a1) ^ (a3);\
	(t4) = (t2) & (t3);\
	(t5) = (a4) ^ (t4);\
	(t6) = ~(t1);\
	(t6) = (t5) & (t6);\
	(t7) = (a5) ^ (a6);\
	(t8) = (a3) ^ (t7);\
	(t9) = ~(t8);\
	(t9) = (t1) & (t9);\
	(t8) = (a6) | (t4);\
	(t4) = (t9) ^ (t8);\
	(t8) = ~(t6);\
	(t8) = (t4) & (t8);\
	(t9) = (a1) | (a6);\
	(t10) = (t4) | (t9);\
	(t11) = ~(t5);\
	(t11) = (a5) & (t11);\
	(t5) = (t10) ^ (t11);\
	(t12) = ~(t9);\
	(t12) = (a4) & (t12);\
	(t9) = (t11) ^ (t12);\
	(t12) = ~(t3);\
	(t12) = (t7) & (t12);\
	(t3) = (t9) | (t12);\
	(t12) = ~(t0);\
	(t12) = (a3) & (t12);\
	(t0) = (t1) ^ (t10);\
	(t9) = ~(t12);\
	(t9) = (t0) & (t9);\
	(t12) = ~(t9);\
	(t0) = (t2) & (t4);\
	(t4) = (t12) ^ (t0);\
	(t13) = ~(a2);\
	(t13) = (t5) & (t13);\
	(t5) = (t13) ^ (t4);\
	(out3) = (out3) ^ (t5);\
	(t12) = (t7) ^ (t9);\
	(t0) = (t11) | (t12);\
	(t5) = (t2) ^ (t0);\
	(t11) = (a1) ^ (t5);\
	(t5) = (t4) ^ (t11);\
	(t9) = (t6) | (a2);\
	(t12) = (t9) ^ (t5);\
	(out1) = (out1) ^ (t12);\
	(t13) = (t2) ^ (t10);\
	(t0) = (t3) | (t13);\
	(t13) = (t11) ^ (t0);\
	(t0) = (t7) | (t5);\
	(t5) = (t13) ^ (t0);\
	(t0) = (t8) | (a2);\
	(t6) = (t0) ^ (t5);\
	(out2) = (out2) ^ (t6);\
	(t6) = (a5) | (t1);\
	(t9) = ~(t13);\
	(t9) = (t6) & (t9);\
	(t13) = (t8) & (t11);\
	(t11) = (t9) ^ (t13);\
	(t13) = (t11) | (a2);\
	(t12) = (t13) ^ (t3);\
	(out4) = (out4) ^ (t12);\

//
// s2-016251, 44 gates, 14 regs, 13 andn, 1/9/22/61/108 stalls, 66 biop */
//
#define s2(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
	(t0) = (a2) ^ (a5);\
	(t1) = ~(a6);\
	(t1) = (a1) & (t1);\
	(t2) = ~(t1);\
	(t2) = (a5) & (t2);\
	(t1) = (a2) | (t2);\
	(t3) = ~(a6);\
	(t3) = (t0) & (t3);\
	(t4) = (a1) & (t0);\
	(t5) = (a5) ^ (t4);\
	(t6) = ~(t3);\
	(t6) = (t5) & (t6);\
	(t7) = (a3) & (a6);\
	(t8) = (t2) ^ (t3);\
	(t2) = (t1) & (t8);\
	(t3) = ~(t7);\
	(t3) = (t2) & (t3);\
	(t8) = (a3) & (t2);\
	(t2) = ~(a1);\
	(t9) = (t8) ^ (t2);\
	(t2) = (a6) ^ (t0);\
	(t0) = ~(t7);\
	(t0) = (t2) & (t0);\
	(t10) = (t9) ^ (t0);\
	(t11) = ~(t3);\
	(t11) = (a4) & (t11);\
	(t3) = (t11) ^ (t10);\
	(out2) = (out2) ^ (t3);\
	(t3) = ~(t0);\
	(t3) = (a2) & (t3);\
	(t0) = (t5) ^ (t3);\
	(t5) = ~(t0);\
	(t5) = (t9) & (t5);\
	(t9) = (a3) ^ (t2);\
	(t11) = (t5) ^ (t9);\
	(t5) = ~(a4);\
	(t5) = (t1) & (t5);\
	(t12) = (t5) ^ (t11);\
	(out1) = (out1) ^ (t12);\
	(t5) = (t8) ^ (t3);\
	(t3) = (t9) | (t5);\
	(t8) = (t1) ^ (t10);\
	(t1) = (t7) | (t8);\
	(t7) = (t3) ^ (t1);\
	(t1) = ~(t11);\
	(t1) = (t10) & (t1);\
	(t3) = (t4) ^ (t5);\
	(t4) = (t1) | (t3);\
	(t1) = ~(t9);\
	(t1) = (t6) & (t1);\
	(t3) = (t4) ^ (t1);\
	(t1) = (t3) | (a4);\
	(t4) = (t1) ^ (t7);\
	(out3) = (out3) ^ (t4);\
	(t1) = ~(t0);\
	(t1) = (t3) & (t1);\
	(t0) = (t2) | (t8);\
	(t2) = (t1) ^ (t0);\
	(t0) = (t6) | (a4);\
	(t1) = (t0) ^ (t2);\
	(out4) = (out4) ^ (t1);\

//
// s3-000426, 46 gates, 16 regs, 14 andn, 2/5/12/35/75 stalls, 68 biop
// Currently used for x86-64 SSE2
//
#define s3(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
	(t0) = ~(a2);\
	(t0) = (a1) & (t0);\
	(t1) = (a3) ^ (a6);\
	(t2) = (t0) | (t1);\
	(t0) = (a4) ^ (a6);\
	(t3) = ~(a1);\
	(t3) = (t0) & (t3);\
	(t4) = (t2) ^ (t3);\
	(t5) = (a2) ^ (t1);\
	(t6) = ~(a6);\
	(t6) = (t5) & (t6);\
	(t7) = (t2) ^ (t6);\
	(t2) = ~(t7);\
	(t2) = (t4) & (t2);\
	(t6) = (a6) & (t4);\
	(t8) = (a4) | (t6);\
	(t6) = (a1) & (t8);\
	(t8) = (t5) ^ (t6);\
	(t6) = ~(a5);\
	(t6) = (t4) & (t6);\
	(t9) = (t6) ^ (t8);\
	(out4) = (out4) ^ (t9);\
	(t6) = (t1) & (t0);\
	(t0) = (a1) ^ (a4);\
	(t9) = (t7) ^ (t0);\
	(t7) = (a3) | (t9);\
	(t9) = ~(t6);\
	(t9) = (t7) & (t9);\
	(t6) = (t3) | (t0);\
	(t0) = ~(t6);\
	(t0) = (t8) & (t0);\
	(t7) = (a4) & (a6);\
	(t8) = ~(a2);\
	(t8) = (t7) & (t8);\
	(t10) = (t0) ^ (t8);\
	(t0) = ~(a3);\
	(t0) = (t10) & (t0);\
	(t8) = (t5) | (t7);\
	(t7) = ~(t0);\
	(t7) = (t8) & (t7);\
	(t0) = (a1) ^ (t7);\
	(t7) = (t9) & (a5);\
	(t8) = (t7) ^ (t0);\
	(out2) = (out2) ^ (t8);\
	(t0) = ~(a2);\
	(t0) = (t4) & (t0);\
	(t4) = ~(a3);\
	(t4) = (t0) & (t4);\
	(t7) = (t5) ^ (t6);\
	(t6) = ~(t7);\
	(t7) = (t4) ^ (t6);\
	(t4) = ~(t2);\
	(t4) = (a5) & (t4);\
	(t2) = (t4) ^ (t7);\
	(out1) = (out1) ^ (t2);\
	(t2) = (a4) & (t1);\
	(t1) = (t5) | (t7);\
	(t4) = ~(t2);\
	(t4) = (t1) & (t4);\
	(t1) = (t3) | (t0);\
	(t0) = (t4) ^ (t1);\
	(t1) = (t10) | (a5);\
	(t2) = (t1) ^ (t0);\
	(out3) = (out3) ^ (t2);\

//
// s4, 33 gates, 11/12 regs, 9 andn, 2/21/53/86/119 stalls, 52 biop
//
#define s4(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
	(t0) = (a1) ^ (a3);\
	(t1) = (a3) ^ (a5);\
	(t2) = (a2) | (a4);\
	(t3) = (a5) ^ (t2);\
	(t2) = ~(t3);\
	(t2) = (t1) & (t2);\
	(t3) = ~(a2);\
	(t3) = (t1) & (t3);\
	(t4) = (a4) ^ (t3);\
	(t5) = (t0) | (t4);\
	(t6) = ~(t2);\
	(t6) = (t5) & (t6);\
	(t5) = (a2) ^ (t6);\
	(t7) = (t4) & (t5);\
	(t4) = ~(t7);\
	(t4) = (t1) & (t4);\
	(t1) = (t0) ^ (t5);\
	(t0) = ~(t4);\
	(t0) = (t1) & (t0);\
	(t4) = (t2) ^ (t0);\
	(t0) = (a2) ^ (a4);\
	(t2) = (a5) | (t3);\
	(t3) = (t1) ^ (t2);\
	(t1) = ~(t0);\
	(t1) = (t3) & (t1);\
	(t2) = (t6) ^ (t1);\
	(t1) = ~(t4);\
	(t1) = (a6) & (t1);\
	(t6) = (t1) ^ (t2);\
	(out1) = (out1) ^ (t6);\
	(t1) = ~(t2);\
	(t2) = ~(a6);\
	(t2) = (t4) & (t2);\
	(t6) = (t2) ^ (t1);\
	(out2) = (out2) ^ (t6);\
	(t2) = (t4) ^ (t1);\
	(t1) = ~(t0);\
	(t1) = (t2) & (t1);\
	(t0) = (t7) | (t1);\
	(t1) = (t3) ^ (t0);\
	(t0) = (t5) | (a6);\
	(t2) = (t0) ^ (t1);\
	(out3) = (out3) ^ (t2);\
	(t0) = (a6) & (t5);\
	(t2) = (t0) ^ (t1);\
	(out4) = (out4) ^ (t2);\

//
// s5-04832, 48 gates, 15/16 regs, 9 andn, 5/23/62/109/159 stalls, 72 biop
// Currently used for MMX/SSE2
//
#define s5(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
	(t1) = (a1) | (a3);\
	(t10) = ~(a6);\
	(t10) = (t1) & (t10);\
	(t6) = (a1) ^ (t10);\
	(t2) = (a3) ^ (t6);\
	(t3) = (a4) | (t2);\
	(t7) = ~(a4);\
	(t7) = (t10) & (t7);\
	(t10) = (a3) ^ (t7);\
	(t7) = (a5) & (t10);\
	(t12) = (a1) | (t2);\
	(t2) = (t7) ^ (t12);\
	(t7) = (a4) ^ (t2);\
	(t2) = (a6) ^ (t7);\
	(t4) = (t6) | (t2);\
	(t8) = (a5) & (t4);\
	(t11) = (t6) ^ (t8);\
	(t9) = (a4) & (t12);\
	(t5) = (t11) ^ (t9);\
	(t11) = ~(a1);\
	(t11) = (t4) & (t11);\
	(t4) = (t10) ^ (t11);\
	(t9) = (a5) ^ (t3);\
	(t0) = ~(t4);\
	(t0) = (t9) & (t0);\
	(t4) = ~(t0);\
	(t0) = ~(a2);\
	(t0) = (t4) & (t0);\
	(t4) = (t0) ^ (t7);\
	(out3) = (out3) ^ (t4);\
	(t7) = ~(t8);\
	(t7) = (t10) & (t7);\
	(t0) = (t11) ^ (t9);\
	(t11) = (t5) | (t0);\
	(t4) = ~(t7);\
	(t4) = (t11) & (t4);\
	(t0) = ~(t4);\
	(t0) = (t3) & (t0);\
	(t11) = (t2) & (t4);\
	(t7) = (t9) ^ (t11);\
	(t2) = (t10) & (t12);\
	(t11) = (t7) | (t2);\
	(t9) = (t8) ^ (t11);\
	(t11) = (t9) & (a2);\
	(t12) = (t11) ^ (t5);\
	(out4) = (out4) ^ (t12);\
	(t12) = (t1) ^ (t4);\
	(t2) = (a1) ^ (t12);\
	(t11) = (a4) & (t7);\
	(t8) = (t2) ^ (t11);\
	(t12) = (t0) | (a2);\
	(t11) = (t12) ^ (t8);\
	(out1) = (out1) ^ (t11);\
	(t9) = (t3) ^ (t10);\
	(t5) = ~(t8);\
	(t5) = (t9) & (t5);\
	(t4) = (t6) ^ (t7);\
	(t1) = (t5) ^ (t4);\
	(t2) = (t3) & (a2);\
	(t0) = (t2) ^ (t1);\
	(out2) = (out2) ^ (t0);\

//
// s6-000007, 46 gates, 19 regs, 8 andn, 3/19/39/66/101 stalls, 69 biop
// Currently used for x86-64 SSE2
//
#define s6(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
	(t0) = (a2) ^ (a5);\
	(t8) = (a2) | (a6);\
	(t1) = (a1) & (t8);\
	(t8) = (t0) ^ (t1);\
	(t0) = (a6) ^ (t8);\
	(t12) = ~(t0);\
	(t12) = (a5) & (t12);\
	(t11) = (a1) & (t0);\
	(t0) = (a2) ^ (t11);\
	(t4) = (a1) ^ (a3);\
	(t13) = (t0) | (t4);\
	(t2) = (t8) ^ (t13);\
	(t7) = (a3) & (t2);\
	(t6) = ~(a6);\
	(t6) = (t7) & (t6);\
	(t9) = (t12) | (t0);\
	(t0) = (t6) ^ (t9);\
	(t10) = (t0) & (a4);\
	(t5) = (t10) ^ (t2);\
	(out4) = (out4) ^ (t5);\
	(t5) = (a2) ^ (t13);\
	(t13) = ~(t5);\
	(t13) = (a6) & (t13);\
	(t10) = (a3) ^ (t13);\
	(t13) = ~(t7);\
	(t13) = (a5) & (t13);\
	(t3) = (t10) | (t13);\
	(t13) = (a1) | (t2);\
	(t2) = (t9) & (t13);\
	(t9) = (t10) ^ (t2);\
	(t13) = ~(t6);\
	(t13) = (t9) & (t13);\
	(t6) = (t12) | (a4);\
	(t12) = (t6) ^ (t13);\
	(out3) = (out3) ^ (t12);\
	(t2) = (a2) | (t4);\
	(t6) = (t0) ^ (t2);\
	(t12) = (t1) | (t3);\
	(t13) = (t6) ^ (t12);\
	(t4) = (t8) ^ (t9);\
	(t0) = ~(t4);\
	(t0) = (a5) & (t0);\
	(t1) = ~(t5);\
	(t6) = (t2) ^ (t1);\
	(t12) = (t0) ^ (t6);\
	(t9) = ~(a4);\
	(t9) = (t12) & (t9);\
	(t12) = (t9) ^ (t13);\
	(out2) = (out2) ^ (t12);\
	(t9) = (a6) ^ (t11);\
	(t8) = (a1) ^ (t10);\
	(t4) = (t9) & (t8);\
	(t5) = (t7) ^ (t6);\
	(t2) = (t4) ^ (t5);\
	(t1) = ~(a4);\
	(t1) = (t3) & (t1);\
	(t0) = (t1) ^ (t2);\
	(out1) = (out1) ^ (t0);\

//
// s7-056945, 46 gates, 16 regs, 7 andn, 10/31/62/107/156 stalls, 67 biop
// Currently used for MMX/SSE2
//
#define s7(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
	(t6) = (a4) ^ (a5);\
	(t3) = (a3) ^ (t6);\
	(t1) = (a6) & (t3);\
	(t2) = (a4) & (t6);\
	(t4) = (a2) ^ (t2);\
	(t0) = (t1) & (t4);\
	(t7) = (a6) & (t2);\
	(t5) = (a3) ^ (t7);\
	(t7) = (t4) | (t5);\
	(t8) = (a6) ^ (t6);\
	(t6) = (t7) ^ (t8);\
	(t7) = ~(t0);\
	(t7) = (a1) & (t7);\
	(t9) = (t7) ^ (t6);\
	(out4) = (out4) ^ (t9);\
	(t7) = ~(t3);\
	(t7) = (a5) & (t7);\
	(t0) = (t4) | (t7);\
	(t9) = (t1) ^ (t5);\
	(t5) = (t0) ^ (t9);\
	(t0) = (t1) ^ (t8);\
	(t1) = ~(t0);\
	(t1) = (a4) & (t1);\
	(t0) = ~(t1);\
	(t0) = (t4) & (t0);\
	(t4) = (a5) ^ (t9);\
	(t1) = (t0) ^ (t4);\
	(t9) = (t2) | (t6);\
	(t0) = (a3) & (t1);\
	(t4) = (t9) | (t0);\
	(t2) = ~(t8);\
	(t2) = (t3) & (t2);\
	(t6) = (t4) ^ (t2);\
	(t8) = ~(a1);\
	(t8) = (t6) & (t8);\
	(t9) = (t8) ^ (t5);\
	(out1) = (out1) ^ (t9);\
	(t9) = (t1) | (t6);\
	(t8) = (a6) & (t9);\
	(t3) = (a2) & (t8);\
	(t4) = (t5) ^ (t6);\
	(t2) = (t3) ^ (t4);\
	(t9) = (t0) | (t2);\
	(t5) = (t8) ^ (t9);\
	(t3) = (a5) ^ (t4);\
	(t0) = (t5) | (t3);\
	(t9) = (t0) & (a1);\
	(t5) = (t9) ^ (t1);\
	(out3) = (out3) ^ (t5);\
	(t9) = (t8) ^ (t0);\
	(t4) = (t7) | (t9);\
	(t5) = ~(t6);\
	(t3) = (t4) ^ (t5);\
	(t1) = ~(a1);\
	(t1) = (t3) & (t1);\
	(t0) = (t1) ^ (t2);\
	(out2) = (out2) ^ (t0);\

//
// s8-004798, 41 gates, 14 regs, 7 andn, 7/35/76/118/160 stalls, 59 biop
// Currently used for MMX/SSE2
//
#define s8(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
	(t8) = ~(a2);\
	(t8) = (a3) & (t8);\
	(t1) = ~(a3);\
	(t1) = (a5) & (t1);\
	(t6) = (a4) ^ (t1);\
	(t1) = (a1) & (t6);\
	(t7) = ~(t8);\
	(t7) = (t1) & (t7);\
	(t3) = ~(t6);\
	(t3) = (a2) & (t3);\
	(t9) = (a1) | (t3);\
	(t0) = ~(a3);\
	(t0) = (a2) & (t0);\
	(t4) = (a5) ^ (t0);\
	(t0) = (t9) & (t4);\
	(t2) = (t1) | (t0);\
	(t1) = (t6) ^ (t0);\
	(t0) = ~(t1);\
	(t6) = ~(t9);\
	(t6) = (a3) & (t6);\
	(t1) = (t0) ^ (t6);\
	(t9) = (t8) ^ (t1);\
	(t8) = (t7) | (a6);\
	(t6) = (t8) ^ (t9);\
	(out2) = (out2) ^ (t6);\
	(t0) = (a1) ^ (t9);\
	(t6) = (a5) & (t0);\
	(t8) = (a2) ^ (t1);\
	(t9) = (t6) ^ (t8);\
	(t1) = (t3) ^ (t9);\
	(t6) = (a4) | (t8);\
	(t3) = (t1) ^ (t6);\
	(t5) = (t4) ^ (t3);\
	(t8) = (a1) ^ (t5);\
	(t6) = (t8) & (a6);\
	(t4) = (t6) ^ (t1);\
	(out4) = (out4) ^ (t4);\
	(t6) = (t2) ^ (t9);\
	(t4) = (a2) | (t6);\
	(t3) = (t0) ^ (t4);\
	(t8) = (a5) ^ (t3);\
	(t9) = (t2) & (a6);\
	(t6) = (t9) ^ (t8);\
	(out3) = (out3) ^ (t6);\
	(t9) = (a4) | (t0);\
	(t6) = ~(t9);\
	(t6) = (t8) & (t6);\
	(t4) = (t7) | (t6);\
	(t3) = (t5) ^ (t4);\
	(t2) = (t3) | (a6);\
	(t0) = (t2) ^ (t1);\
	(out1) = (out1) ^ (t0);\

#define CLEAR_BLOCK_8(i)                                                             \
	DES_VECTOR_SET(dataBlocks[threadIdx.x + (i<<DB_SHIFT)] , 0, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(dataBlocks[threadIdx.x + (i<<DB_SHIFT)] , 1, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(dataBlocks[threadIdx.x + (i<<DB_SHIFT)] , 2, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(dataBlocks[threadIdx.x + (i<<DB_SHIFT)] , 3, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(dataBlocks[threadIdx.x + (i<<DB_SHIFT)] , 4, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(dataBlocks[threadIdx.x + (i<<DB_SHIFT)] , 5, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(dataBlocks[threadIdx.x + (i<<DB_SHIFT)] , 6, DES_VECTOR_ZERO); \
	DES_VECTOR_SET(dataBlocks[threadIdx.x + (i<<DB_SHIFT)] , 7, DES_VECTOR_ZERO); \

#define CLEAR_BLOCK()  \
	CLEAR_BLOCK_8(0);  \
	CLEAR_BLOCK_8(8);  \
	CLEAR_BLOCK_8(16); \
	CLEAR_BLOCK_8(24); \
	CLEAR_BLOCK_8(32); \
	CLEAR_BLOCK_8(40); \
	CLEAR_BLOCK_8(48); \
	CLEAR_BLOCK_8(56); \

#define w(p, q)    DES_VECTOR_XOR_FUNC(dataBlocks[p], DESContextArray[threadIdx.x].keys[q])
#define x(p)    DES_VECTOR_XOR_FUNC(dataBlocks[CUDA_expansionFunction[p]], DESContextArray[threadIdx.x].keys[keySchedule[keyScheduleIndexBase + (p)]])
#define y(p, q) DES_VECTOR_XOR_FUNC(dataBlocks[p],                         DESContextArray[threadIdx.x].keys[keySchedule[keyScheduleIndexBase + (q)]])
#define z(r)    (&dataBlocks[r])

#define EF(p) (CUDA_expansionFunction[p]<<DB_SHIFT)

DES_FUNCTION_QUALIFIERS
void DES_Crypt(volatile unsigned int keyFrom00To27, volatile unsigned int keyFrom28To48, int intSalt)
{
	DES_Vector t0;
	DES_Vector t1;
	DES_Vector t2;
	DES_Vector t3;
	DES_Vector t4;
	DES_Vector t5;
	DES_Vector t6;
	DES_Vector t7;
	DES_Vector t8;
	DES_Vector t9;
	DES_Vector t10;
	DES_Vector t11;
	DES_Vector t12;
	DES_Vector t13;

	if (threadIdx.y == 0)
		CLEAR_BLOCK();
	
	volatile DES_Vector *db = dataBlocks + threadIdx.x;
	
#define K00 ((keyFrom00To27 & (0x1U << 0)) ? 0xffffffffU : 0x0)
#define K01 ((keyFrom00To27 & (0x1U << 1)) ? 0xffffffffU : 0x0)
#define K02 ((keyFrom00To27 & (0x1U << 2)) ? 0xffffffffU : 0x0)
#define K03 ((keyFrom00To27 & (0x1U << 3)) ? 0xffffffffU : 0x0)
#define K04 ((keyFrom00To27 & (0x1U << 4)) ? 0xffffffffU : 0x0)
#define K05 ((keyFrom00To27 & (0x1U << 5)) ? 0xffffffffU : 0x0)
#define K06 ((keyFrom00To27 & (0x1U << 6)) ? 0xffffffffU : 0x0)
#define K07 ((keyFrom00To27 & (0x1U << 7)) ? 0xffffffffU : 0x0)
#define K08 ((keyFrom00To27 & (0x1U << 8)) ? 0xffffffffU : 0x0)
#define K09 ((keyFrom00To27 & (0x1U << 9)) ? 0xffffffffU : 0x0)
#define K10 ((keyFrom00To27 & (0x1U << 10)) ? 0xffffffffU : 0x0)
#define K11 ((keyFrom00To27 & (0x1U << 11)) ? 0xffffffffU : 0x0)
#define K12 ((keyFrom00To27 & (0x1U << 12)) ? 0xffffffffU : 0x0)
#define K13 ((keyFrom00To27 & (0x1U << 13)) ? 0xffffffffU : 0x0)
#define K14 ((keyFrom00To27 & (0x1U << 14)) ? 0xffffffffU : 0x0)
#define K15 ((keyFrom00To27 & (0x1U << 15)) ? 0xffffffffU : 0x0)
#define K16 ((keyFrom00To27 & (0x1U << 16)) ? 0xffffffffU : 0x0)
#define K17 ((keyFrom00To27 & (0x1U << 17)) ? 0xffffffffU : 0x0)
#define K18 ((keyFrom00To27 & (0x1U << 18)) ? 0xffffffffU : 0x0)
#define K19 ((keyFrom00To27 & (0x1U << 19)) ? 0xffffffffU : 0x0)
#define K20 ((keyFrom00To27 & (0x1U << 20)) ? 0xffffffffU : 0x0)
#define K21 ((keyFrom00To27 & (0x1U << 21)) ? 0xffffffffU : 0x0)
#define K22 ((keyFrom00To27 & (0x1U << 22)) ? 0xffffffffU : 0x0)
#define K23 ((keyFrom00To27 & (0x1U << 23)) ? 0xffffffffU : 0x0)
#define K24 ((keyFrom00To27 & (0x1U << 24)) ? 0xffffffffU : 0x0)
#define K25 ((keyFrom00To27 & (0x1U << 25)) ? 0xffffffffU : 0x0)
#define K26 ((keyFrom00To27 & (0x1U << 26)) ? 0xffffffffU : 0x0)
#define K27 ((keyFrom00To27 & (0x1U << 27)) ? 0xffffffffU : 0x0)
#define K28 ((keyFrom28To48 & (0x1U << (28 - 28))) ? 0xffffffffU : 0x0)
#define K29 ((keyFrom28To48 & (0x1U << (29 - 28))) ? 0xffffffffU : 0x0)
#define K30 ((keyFrom28To48 & (0x1U << (30 - 28))) ? 0xffffffffU : 0x0)
#define K31 ((keyFrom28To48 & (0x1U << (31 - 28))) ? 0xffffffffU : 0x0)
#define K32 ((keyFrom28To48 & (0x1U << (32 - 28))) ? 0xffffffffU : 0x0)
#define K33 ((keyFrom28To48 & (0x1U << (33 - 28))) ? 0xffffffffU : 0x0)
#define K34 ((keyFrom28To48 & (0x1U << (34 - 28))) ? 0xffffffffU : 0x0)
#define K35 ((keyFrom28To48 & (0x1U << (35 - 28))) ? 0xffffffffU : 0x0)
#define K36 ((keyFrom28To48 & (0x1U << (36 - 28))) ? 0xffffffffU : 0x0)
#define K37 ((keyFrom28To48 & (0x1U << (37 - 28))) ? 0xffffffffU : 0x0)
#define K38 ((keyFrom28To48 & (0x1U << (38 - 28))) ? 0xffffffffU : 0x0)
#define K39 ((keyFrom28To48 & (0x1U << (39 - 28))) ? 0xffffffffU : 0x0)
#define K40 ((keyFrom28To48 & (0x1U << (40 - 28))) ? 0xffffffffU : 0x0)
#define K41 ((keyFrom28To48 & (0x1U << (41 - 28))) ? 0xffffffffU : 0x0)
#define K42 ((keyFrom28To48 & (0x1U << (42 - 28))) ? 0xffffffffU : 0x0)
#define K43 ((keyFrom28To48 & (0x1U << (43 - 28))) ? 0xffffffffU : 0x0)
#define K44 ((keyFrom28To48 & (0x1U << (44 - 28))) ? 0xffffffffU : 0x0)
#define K45 ((keyFrom28To48 & (0x1U << (45 - 28))) ? 0xffffffffU : 0x0)
#define K46 ((keyFrom28To48 & (0x1U << (46 - 28))) ? 0xffffffffU : 0x0)
#define K47 ((keyFrom28To48 & (0x1U << (47 - 28))) ? 0xffffffffU : 0x0)
#define K48 ((keyFrom28To48 & (0x1U << (48 - 28))) ? 0xffffffffU : 0x0)

#define K00XOR(val) ((keyFrom00To27 & (0x1U << 0)) ? ~(val) : (val))
#define K01XOR(val) ((keyFrom00To27 & (0x1U << 1)) ? ~(val) : (val))
#define K02XOR(val) ((keyFrom00To27 & (0x1U << 2)) ? ~(val) : (val))
#define K03XOR(val) ((keyFrom00To27 & (0x1U << 3)) ? ~(val) : (val))
#define K04XOR(val) ((keyFrom00To27 & (0x1U << 4)) ? ~(val) : (val))
#define K05XOR(val) ((keyFrom00To27 & (0x1U << 5)) ? ~(val) : (val))
#define K06XOR(val) ((keyFrom00To27 & (0x1U << 6)) ? ~(val) : (val))
#define K07XOR(val) ((keyFrom00To27 & (0x1U << 7)) ? ~(val) : (val))
#define K08XOR(val) ((keyFrom00To27 & (0x1U << 8)) ? ~(val) : (val))
#define K09XOR(val) ((keyFrom00To27 & (0x1U << 9)) ? ~(val) : (val))
#define K10XOR(val) ((keyFrom00To27 & (0x1U << 10)) ? ~(val) : (val))
#define K11XOR(val) ((keyFrom00To27 & (0x1U << 11)) ? ~(val) : (val))
#define K12XOR(val) ((keyFrom00To27 & (0x1U << 12)) ? ~(val) : (val))
#define K13XOR(val) ((keyFrom00To27 & (0x1U << 13)) ? ~(val) : (val))
#define K14XOR(val) ((keyFrom00To27 & (0x1U << 14)) ? ~(val) : (val))
#define K15XOR(val) ((keyFrom00To27 & (0x1U << 15)) ? ~(val) : (val))
#define K16XOR(val) ((keyFrom00To27 & (0x1U << 16)) ? ~(val) : (val))
#define K17XOR(val) ((keyFrom00To27 & (0x1U << 17)) ? ~(val) : (val))
#define K18XOR(val) ((keyFrom00To27 & (0x1U << 18)) ? ~(val) : (val))
#define K19XOR(val) ((keyFrom00To27 & (0x1U << 19)) ? ~(val) : (val))
#define K20XOR(val) ((keyFrom00To27 & (0x1U << 20)) ? ~(val) : (val))
#define K21XOR(val) ((keyFrom00To27 & (0x1U << 21)) ? ~(val) : (val))
#define K22XOR(val) ((keyFrom00To27 & (0x1U << 22)) ? ~(val) : (val))
#define K23XOR(val) ((keyFrom00To27 & (0x1U << 23)) ? ~(val) : (val))
#define K24XOR(val) ((keyFrom00To27 & (0x1U << 24)) ? ~(val) : (val))
#define K25XOR(val) ((keyFrom00To27 & (0x1U << 25)) ? ~(val) : (val))
#define K26XOR(val) ((keyFrom00To27 & (0x1U << 26)) ? ~(val) : (val))
#define K27XOR(val) ((keyFrom00To27 & (0x1U << 27)) ? ~(val) : (val))
#define K28XOR(val) ((keyFrom28To48 & (0x1U << (28 - 28))) ? ~(val) : (val))
#define K29XOR(val) ((keyFrom28To48 & (0x1U << (29 - 28))) ? ~(val) : (val))
#define K30XOR(val) ((keyFrom28To48 & (0x1U << (30 - 28))) ? ~(val) : (val))
#define K31XOR(val) ((keyFrom28To48 & (0x1U << (31 - 28))) ? ~(val) : (val))
#define K32XOR(val) ((keyFrom28To48 & (0x1U << (32 - 28))) ? ~(val) : (val))
#define K33XOR(val) ((keyFrom28To48 & (0x1U << (33 - 28))) ? ~(val) : (val))
#define K34XOR(val) ((keyFrom28To48 & (0x1U << (34 - 28))) ? ~(val) : (val))
#define K35XOR(val) ((keyFrom28To48 & (0x1U << (35 - 28))) ? ~(val) : (val))
#define K36XOR(val) ((keyFrom28To48 & (0x1U << (36 - 28))) ? ~(val) : (val))
#define K37XOR(val) ((keyFrom28To48 & (0x1U << (37 - 28))) ? ~(val) : (val))
#define K38XOR(val) ((keyFrom28To48 & (0x1U << (38 - 28))) ? ~(val) : (val))
#define K39XOR(val) ((keyFrom28To48 & (0x1U << (39 - 28))) ? ~(val) : (val))
#define K40XOR(val) ((keyFrom28To48 & (0x1U << (40 - 28))) ? ~(val) : (val))
#define K41XOR(val) ((keyFrom28To48 & (0x1U << (41 - 28))) ? ~(val) : (val))
#define K42XOR(val) ((keyFrom28To48 & (0x1U << (42 - 28))) ? ~(val) : (val))
#define K43XOR(val) ((keyFrom28To48 & (0x1U << (43 - 28))) ? ~(val) : (val))
#define K44XOR(val) ((keyFrom28To48 & (0x1U << (44 - 28))) ? ~(val) : (val))
#define K45XOR(val) ((keyFrom28To48 & (0x1U << (45 - 28))) ? ~(val) : (val))
#define K46XOR(val) ((keyFrom28To48 & (0x1U << (46 - 28))) ? ~(val) : (val))
#define K47XOR(val) ((keyFrom28To48 & (0x1U << (47 - 28))) ? ~(val) : (val))
#define K48XOR(val) ((keyFrom28To48 & (0x1U << (48 - 28))) ? ~(val) : (val))
#define K49XOR(val) ((val) ^ CUDA_keyFrom49To55Array[0])
#define K50XOR(val) ((val) ^ CUDA_keyFrom49To55Array[1])
#define K51XOR(val) ((val) ^ CUDA_keyFrom49To55Array[2])
#define K52XOR(val) ((val) ^ CUDA_keyFrom49To55Array[3])
#define K53XOR(val) ((val) ^ CUDA_keyFrom49To55Array[4])
#define K54XOR(val) ((val) ^ CUDA_keyFrom49To55Array[5])
#define K55XOR(val) ((val) ^ CUDA_keyFrom49To55Array[6])

#define SALT 0 // intSalt

	volatile DES_Vector DB00 = db[ 0<<DB_SHIFT];
	volatile DES_Vector DB01 = db[ 1<<DB_SHIFT];
	volatile DES_Vector DB02 = db[ 2<<DB_SHIFT];
	volatile DES_Vector DB03 = 0;
	volatile DES_Vector DB04 = 0;
	volatile DES_Vector DB05 = 0;
	volatile DES_Vector DB06 = 0;
	volatile DES_Vector DB07 = 0;
	volatile DES_Vector DB08 = 0;
	volatile DES_Vector DB09 = 0;
	volatile DES_Vector DB10 = 0;
	volatile DES_Vector DB11 = 0;
	volatile DES_Vector DB12 = 0;
	volatile DES_Vector DB13 = 0;
	volatile DES_Vector DB14 = 0;
	volatile DES_Vector DB15 = db[15<<DB_SHIFT];
	volatile DES_Vector DB16 = db[16<<DB_SHIFT];
	volatile DES_Vector DB17 = db[17<<DB_SHIFT];
	volatile DES_Vector DB18 = db[18<<DB_SHIFT];
	volatile DES_Vector DB19 = 0;
	volatile DES_Vector DB20 = 0;
	volatile DES_Vector DB21 = 0;
	volatile DES_Vector DB22 = 0;
	volatile DES_Vector DB23 = 0;
	volatile DES_Vector DB24 = 0;
	volatile DES_Vector DB25 = 0;
	volatile DES_Vector DB26 = 0;
	volatile DES_Vector DB27 = 0;
	volatile DES_Vector DB28 = 0;
	volatile DES_Vector DB29 = 0;
	volatile DES_Vector DB30 = 0;
	volatile DES_Vector DB31 = db[31<<DB_SHIFT];
	for (int i = 0; i < 13; ++i) {
		// ROUND_A(0);
		if (!threadIdx.y) {
		s1(K12XOR((   1 & SALT) ? DB15 : DB31), K46XOR((   2 & SALT) ? DB16 : DB00), K33XOR((   4 & SALT) ? DB17 : DB01), K52XOR((   8 & SALT) ? DB18 : DB02), K48XOR((  16 & SALT) ? DB19 : DB03), K20XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K34XOR((  64 & SALT) ? DB19 : DB03), K55XOR(( 128 & SALT) ? DB20 : DB04), K05XOR(( 256 & SALT) ? DB21 : DB05), K13XOR(( 512 & SALT) ? DB22 : DB06), K18XOR((1024 & SALT) ? DB23 : DB07), K40XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K04XOR(                DB07       ), K32XOR(                DB08       ), K26XOR(                DB09       ), K27XOR(                DB10       ), K38XOR(                DB11       ), K54XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K53XOR(                DB11       ), K06XOR(                DB12       ), K31XOR(                DB13       ), K25XOR(                DB14       ), K19XOR(                DB15       ), K41XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K15XOR((   1 & SALT) ? DB31 : DB15), K24XOR((   2 & SALT) ? DB00 : DB16), K28XOR((   4 & SALT) ? DB01 : DB17), K43XOR((   8 & SALT) ? DB02 : DB18), K30XOR((  16 & SALT) ? DB03 : DB19), K03XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K35XOR((  64 & SALT) ? DB03 : DB19), K22XOR(( 128 & SALT) ? DB04 : DB20), K02XOR(( 256 & SALT) ? DB05 : DB21), K44XOR(( 512 & SALT) ? DB06 : DB22), K14XOR((1024 & SALT) ? DB07 : DB23), K23XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K51XOR(                DB23       ), K16XOR(                DB24       ), K29XOR(                DB25       ), K49XOR(                DB26       ), K07XOR(                DB27       ), K17XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K37XOR(                DB27       ), K08XOR(                DB28       ), K09XOR(                DB29       ), K50XOR(                DB30       ), K42XOR(                DB31       ), K21XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(0);
		if (!threadIdx.y) {
		s1(K05XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K39XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K26XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K45XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K41XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K13XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K27XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K48XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K53XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K06XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K11XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K33XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K52XOR(db[39<<DB_SHIFT]), K25XOR(db[40<<DB_SHIFT]), K19XOR(db[41<<DB_SHIFT]), K20XOR(db[42<<DB_SHIFT]), K31XOR(db[43<<DB_SHIFT]), K47XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K46XOR(db[43<<DB_SHIFT]), K54XOR(db[44<<DB_SHIFT]), K55XOR(db[45<<DB_SHIFT]), K18XOR(db[46<<DB_SHIFT]), K12XOR(db[47<<DB_SHIFT]), K34XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K08XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K17XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K21XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K36XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K23XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K49XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K28XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K15XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K24XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K37XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K07XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K16XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K44XOR(db[55<<DB_SHIFT]), K09XOR(db[56<<DB_SHIFT]), K22XOR(db[57<<DB_SHIFT]), K42XOR(db[58<<DB_SHIFT]), K00XOR(db[59<<DB_SHIFT]), K10XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K30XOR(db[59<<DB_SHIFT]), K01XOR(db[60<<DB_SHIFT]), K02XOR(db[61<<DB_SHIFT]), K43XOR(db[62<<DB_SHIFT]), K35XOR(db[63<<DB_SHIFT]), K14XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(96);
		if (!threadIdx.y) {
		s1(K46XOR((   1 & SALT) ? DB15 : DB31), K25XOR((   2 & SALT) ? DB16 : DB00), K12XOR((   4 & SALT) ? DB17 : DB01), K31XOR((   8 & SALT) ? DB18 : DB02), K27XOR((  16 & SALT) ? DB19 : DB03), K54XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K13XOR((  64 & SALT) ? DB19 : DB03), K34XOR(( 128 & SALT) ? DB20 : DB04), K39XOR(( 256 & SALT) ? DB21 : DB05), K47XOR(( 512 & SALT) ? DB22 : DB06), K52XOR((1024 & SALT) ? DB23 : DB07), K19XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K38XOR(                DB07       ), K11XOR(                DB08       ), K05XOR(                DB09       ), K06XOR(                DB10       ), K48XOR(                DB11       ), K33XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K32XOR(                DB11       ), K40XOR(                DB12       ), K41XOR(                DB13       ), K04XOR(                DB14       ), K53XOR(                DB15       ), K20XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K51XOR((   1 & SALT) ? DB31 : DB15), K03XOR((   2 & SALT) ? DB00 : DB16), K07XOR((   4 & SALT) ? DB01 : DB17), K22XOR((   8 & SALT) ? DB02 : DB18), K09XOR((  16 & SALT) ? DB03 : DB19), K35XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K14XOR((  64 & SALT) ? DB03 : DB19), K01XOR(( 128 & SALT) ? DB04 : DB20), K10XOR(( 256 & SALT) ? DB05 : DB21), K23XOR(( 512 & SALT) ? DB06 : DB22), K50XOR((1024 & SALT) ? DB07 : DB23), K02XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K30XOR(                DB23       ), K24XOR(                DB24       ), K08XOR(                DB25       ), K28XOR(                DB26       ), K43XOR(                DB27       ), K49XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K16XOR(                DB27       ), K44XOR(                DB28       ), K17XOR(                DB29       ), K29XOR(                DB30       ), K21XOR(                DB31       ), K00XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(96);
		if (!threadIdx.y) {
		s1(K32XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K11XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K53XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K48XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K13XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K40XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K54XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K20XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K25XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K33XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K38XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K05XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K55XOR(db[39<<DB_SHIFT]), K52XOR(db[40<<DB_SHIFT]), K46XOR(db[41<<DB_SHIFT]), K47XOR(db[42<<DB_SHIFT]), K34XOR(db[43<<DB_SHIFT]), K19XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K18XOR(db[43<<DB_SHIFT]), K26XOR(db[44<<DB_SHIFT]), K27XOR(db[45<<DB_SHIFT]), K45XOR(db[46<<DB_SHIFT]), K39XOR(db[47<<DB_SHIFT]), K06XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K37XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K42XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K50XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K08XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K24XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K21XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K00XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K44XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K49XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K09XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K36XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K17XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K16XOR(db[55<<DB_SHIFT]), K10XOR(db[56<<DB_SHIFT]), K51XOR(db[57<<DB_SHIFT]), K14XOR(db[58<<DB_SHIFT]), K29XOR(db[59<<DB_SHIFT]), K35XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K02XOR(db[59<<DB_SHIFT]), K30XOR(db[60<<DB_SHIFT]), K03XOR(db[61<<DB_SHIFT]), K15XOR(db[62<<DB_SHIFT]), K07XOR(db[63<<DB_SHIFT]), K43XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(192);
		if (!threadIdx.y) {
		s1(K18XOR((   1 & SALT) ? DB15 : DB31), K52XOR((   2 & SALT) ? DB16 : DB00), K39XOR((   4 & SALT) ? DB17 : DB01), K34XOR((   8 & SALT) ? DB18 : DB02), K54XOR((  16 & SALT) ? DB19 : DB03), K26XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K40XOR((  64 & SALT) ? DB19 : DB03), K06XOR(( 128 & SALT) ? DB20 : DB04), K11XOR(( 256 & SALT) ? DB21 : DB05), K19XOR(( 512 & SALT) ? DB22 : DB06), K55XOR((1024 & SALT) ? DB23 : DB07), K46XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K41XOR(                DB07       ), K38XOR(                DB08       ), K32XOR(                DB09       ), K33XOR(                DB10       ), K20XOR(                DB11       ), K05XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K04XOR(                DB11       ), K12XOR(                DB12       ), K13XOR(                DB13       ), K31XOR(                DB14       ), K25XOR(                DB15       ), K47XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K23XOR((   1 & SALT) ? DB31 : DB15), K28XOR((   2 & SALT) ? DB00 : DB16), K36XOR((   4 & SALT) ? DB01 : DB17), K51XOR((   8 & SALT) ? DB02 : DB18), K10XOR((  16 & SALT) ? DB03 : DB19), K07XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K43XOR((  64 & SALT) ? DB03 : DB19), K30XOR(( 128 & SALT) ? DB04 : DB20), K35XOR(( 256 & SALT) ? DB05 : DB21), K24XOR(( 512 & SALT) ? DB06 : DB22), K22XOR((1024 & SALT) ? DB07 : DB23), K03XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K02XOR(                DB23       ), K49XOR(                DB24       ), K37XOR(                DB25       ), K00XOR(                DB26       ), K15XOR(                DB27       ), K21XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K17XOR(                DB27       ), K16XOR(                DB28       ), K42XOR(                DB29       ), K01XOR(                DB30       ), K50XOR(                DB31       ), K29XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(192);
		if (!threadIdx.y) {
		s1(K04XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K38XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K25XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K20XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K40XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K12XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K26XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K47XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K52XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K05XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K41XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K32XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K27XOR(db[39<<DB_SHIFT]), K55XOR(db[40<<DB_SHIFT]), K18XOR(db[41<<DB_SHIFT]), K19XOR(db[42<<DB_SHIFT]), K06XOR(db[43<<DB_SHIFT]), K46XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K45XOR(db[43<<DB_SHIFT]), K53XOR(db[44<<DB_SHIFT]), K54XOR(db[45<<DB_SHIFT]), K48XOR(db[46<<DB_SHIFT]), K11XOR(db[47<<DB_SHIFT]), K33XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K09XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K14XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K22XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K37XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K49XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K50XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K29XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K16XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K21XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K10XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K08XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K42XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K17XOR(db[55<<DB_SHIFT]), K35XOR(db[56<<DB_SHIFT]), K23XOR(db[57<<DB_SHIFT]), K43XOR(db[58<<DB_SHIFT]), K01XOR(db[59<<DB_SHIFT]), K07XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K03XOR(db[59<<DB_SHIFT]), K02XOR(db[60<<DB_SHIFT]), K28XOR(db[61<<DB_SHIFT]), K44XOR(db[62<<DB_SHIFT]), K36XOR(db[63<<DB_SHIFT]), K15XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(288);
		if (!threadIdx.y) {
		s1(K45XOR((   1 & SALT) ? DB15 : DB31), K55XOR((   2 & SALT) ? DB16 : DB00), K11XOR((   4 & SALT) ? DB17 : DB01), K06XOR((   8 & SALT) ? DB18 : DB02), K26XOR((  16 & SALT) ? DB19 : DB03), K53XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K12XOR((  64 & SALT) ? DB19 : DB03), K33XOR(( 128 & SALT) ? DB20 : DB04), K38XOR(( 256 & SALT) ? DB21 : DB05), K46XOR(( 512 & SALT) ? DB22 : DB06), K27XOR((1024 & SALT) ? DB23 : DB07), K18XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K13XOR(                DB07       ), K41XOR(                DB08       ), K04XOR(                DB09       ), K05XOR(                DB10       ), K47XOR(                DB11       ), K32XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K31XOR(                DB11       ), K39XOR(                DB12       ), K40XOR(                DB13       ), K34XOR(                DB14       ), K52XOR(                DB15       ), K19XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K24XOR((   1 & SALT) ? DB31 : DB15), K00XOR((   2 & SALT) ? DB00 : DB16), K08XOR((   4 & SALT) ? DB01 : DB17), K23XOR((   8 & SALT) ? DB02 : DB18), K35XOR((  16 & SALT) ? DB03 : DB19), K36XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K15XOR((  64 & SALT) ? DB03 : DB19), K02XOR(( 128 & SALT) ? DB04 : DB20), K07XOR(( 256 & SALT) ? DB05 : DB21), K49XOR(( 512 & SALT) ? DB06 : DB22), K51XOR((1024 & SALT) ? DB07 : DB23), K28XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K03XOR(                DB23       ), K21XOR(                DB24       ), K09XOR(                DB25       ), K29XOR(                DB26       ), K44XOR(                DB27       ), K50XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K42XOR(                DB27       ), K17XOR(                DB28       ), K14XOR(                DB29       ), K30XOR(                DB30       ), K22XOR(                DB31       ), K01XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(288);
		if (!threadIdx.y) {
		s1(K31XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K41XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K52XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K47XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K12XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K39XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K53XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K19XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K55XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K32XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K13XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K04XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K54XOR(db[39<<DB_SHIFT]), K27XOR(db[40<<DB_SHIFT]), K45XOR(db[41<<DB_SHIFT]), K46XOR(db[42<<DB_SHIFT]), K33XOR(db[43<<DB_SHIFT]), K18XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K48XOR(db[43<<DB_SHIFT]), K25XOR(db[44<<DB_SHIFT]), K26XOR(db[45<<DB_SHIFT]), K20XOR(db[46<<DB_SHIFT]), K38XOR(db[47<<DB_SHIFT]), K05XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K10XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K43XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K51XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K09XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K21XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K22XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K01XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K17XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K50XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K35XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K37XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K14XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K42XOR(db[55<<DB_SHIFT]), K07XOR(db[56<<DB_SHIFT]), K24XOR(db[57<<DB_SHIFT]), K15XOR(db[58<<DB_SHIFT]), K30XOR(db[59<<DB_SHIFT]), K36XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K28XOR(db[59<<DB_SHIFT]), K03XOR(db[60<<DB_SHIFT]), K00XOR(db[61<<DB_SHIFT]), K16XOR(db[62<<DB_SHIFT]), K08XOR(db[63<<DB_SHIFT]), K44XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(384);
		if (!threadIdx.y) {
		s1(K55XOR((   1 & SALT) ? DB15 : DB31), K34XOR((   2 & SALT) ? DB16 : DB00), K45XOR((   4 & SALT) ? DB17 : DB01), K40XOR((   8 & SALT) ? DB18 : DB02), K05XOR((  16 & SALT) ? DB19 : DB03), K32XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K46XOR((  64 & SALT) ? DB19 : DB03), K12XOR(( 128 & SALT) ? DB20 : DB04), K48XOR(( 256 & SALT) ? DB21 : DB05), K25XOR(( 512 & SALT) ? DB22 : DB06), K06XOR((1024 & SALT) ? DB23 : DB07), K52XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K47XOR(                DB07       ), K20XOR(                DB08       ), K38XOR(                DB09       ), K39XOR(                DB10       ), K26XOR(                DB11       ), K11XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K41XOR(                DB11       ), K18XOR(                DB12       ), K19XOR(                DB13       ), K13XOR(                DB14       ), K31XOR(                DB15       ), K53XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K03XOR((   1 & SALT) ? DB31 : DB15), K36XOR((   2 & SALT) ? DB00 : DB16), K44XOR((   4 & SALT) ? DB01 : DB17), K02XOR((   8 & SALT) ? DB02 : DB18), K14XOR((  16 & SALT) ? DB03 : DB19), K15XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K51XOR((  64 & SALT) ? DB03 : DB19), K10XOR(( 128 & SALT) ? DB04 : DB20), K43XOR(( 256 & SALT) ? DB05 : DB21), K28XOR(( 512 & SALT) ? DB06 : DB22), K30XOR((1024 & SALT) ? DB07 : DB23), K07XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K35XOR(                DB23       ), K00XOR(                DB24       ), K17XOR(                DB25       ), K08XOR(                DB26       ), K23XOR(                DB27       ), K29XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K21XOR(                DB27       ), K49XOR(                DB28       ), K50XOR(                DB29       ), K09XOR(                DB30       ), K01XOR(                DB31       ), K37XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(384);
		if (!threadIdx.y) {
		s1(K41XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K20XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K31XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K26XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K46XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K18XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K32XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K53XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K34XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K11XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K47XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K38XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K33XOR(db[39<<DB_SHIFT]), K06XOR(db[40<<DB_SHIFT]), K55XOR(db[41<<DB_SHIFT]), K25XOR(db[42<<DB_SHIFT]), K12XOR(db[43<<DB_SHIFT]), K52XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K27XOR(db[43<<DB_SHIFT]), K04XOR(db[44<<DB_SHIFT]), K05XOR(db[45<<DB_SHIFT]), K54XOR(db[46<<DB_SHIFT]), K48XOR(db[47<<DB_SHIFT]), K39XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K42XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K22XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K30XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K17XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K00XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K01XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K37XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K49XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K29XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K14XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K16XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K50XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K21XOR(db[55<<DB_SHIFT]), K43XOR(db[56<<DB_SHIFT]), K03XOR(db[57<<DB_SHIFT]), K51XOR(db[58<<DB_SHIFT]), K09XOR(db[59<<DB_SHIFT]), K15XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K07XOR(db[59<<DB_SHIFT]), K35XOR(db[60<<DB_SHIFT]), K36XOR(db[61<<DB_SHIFT]), K24XOR(db[62<<DB_SHIFT]), K44XOR(db[63<<DB_SHIFT]), K23XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(480);
		if (!threadIdx.y) {
		s1(K27XOR((   1 & SALT) ? DB15 : DB31), K06XOR((   2 & SALT) ? DB16 : DB00), K48XOR((   4 & SALT) ? DB17 : DB01), K12XOR((   8 & SALT) ? DB18 : DB02), K32XOR((  16 & SALT) ? DB19 : DB03), K04XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K18XOR((  64 & SALT) ? DB19 : DB03), K39XOR(( 128 & SALT) ? DB20 : DB04), K20XOR(( 256 & SALT) ? DB21 : DB05), K52XOR(( 512 & SALT) ? DB22 : DB06), K33XOR((1024 & SALT) ? DB23 : DB07), K55XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K19XOR(                DB07       ), K47XOR(                DB08       ), K41XOR(                DB09       ), K11XOR(                DB10       ), K53XOR(                DB11       ), K38XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K13XOR(                DB11       ), K45XOR(                DB12       ), K46XOR(                DB13       ), K40XOR(                DB14       ), K34XOR(                DB15       ), K25XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K28XOR((   1 & SALT) ? DB31 : DB15), K08XOR((   2 & SALT) ? DB00 : DB16), K16XOR((   4 & SALT) ? DB01 : DB17), K03XOR((   8 & SALT) ? DB02 : DB18), K43XOR((  16 & SALT) ? DB03 : DB19), K44XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K23XOR((  64 & SALT) ? DB03 : DB19), K35XOR(( 128 & SALT) ? DB04 : DB20), K15XOR(( 256 & SALT) ? DB05 : DB21), K00XOR(( 512 & SALT) ? DB06 : DB22), K02XOR((1024 & SALT) ? DB07 : DB23), K36XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K07XOR(                DB23       ), K29XOR(                DB24       ), K42XOR(                DB25       ), K37XOR(                DB26       ), K24XOR(                DB27       ), K01XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K50XOR(                DB27       ), K21XOR(                DB28       ), K22XOR(                DB29       ), K10XOR(                DB30       ), K30XOR(                DB31       ), K09XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(480);
		if (!threadIdx.y) {
		s1(K13XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K47XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K34XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K53XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K18XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K45XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K04XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K25XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K06XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K38XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K19XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K41XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K05XOR(db[39<<DB_SHIFT]), K33XOR(db[40<<DB_SHIFT]), K27XOR(db[41<<DB_SHIFT]), K52XOR(db[42<<DB_SHIFT]), K39XOR(db[43<<DB_SHIFT]), K55XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K54XOR(db[43<<DB_SHIFT]), K31XOR(db[44<<DB_SHIFT]), K32XOR(db[45<<DB_SHIFT]), K26XOR(db[46<<DB_SHIFT]), K20XOR(db[47<<DB_SHIFT]), K11XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K14XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K51XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K02XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K42XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K29XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K30XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K09XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K21XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K01XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K43XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K17XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K22XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K50XOR(db[55<<DB_SHIFT]), K15XOR(db[56<<DB_SHIFT]), K28XOR(db[57<<DB_SHIFT]), K23XOR(db[58<<DB_SHIFT]), K10XOR(db[59<<DB_SHIFT]), K44XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K36XOR(db[59<<DB_SHIFT]), K07XOR(db[60<<DB_SHIFT]), K08XOR(db[61<<DB_SHIFT]), K49XOR(db[62<<DB_SHIFT]), K16XOR(db[63<<DB_SHIFT]), K24XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(576);
		if (!threadIdx.y) {
		s1(K54XOR((   1 & SALT) ? DB15 : DB31), K33XOR((   2 & SALT) ? DB16 : DB00), K20XOR((   4 & SALT) ? DB17 : DB01), K39XOR((   8 & SALT) ? DB18 : DB02), K04XOR((  16 & SALT) ? DB19 : DB03), K31XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K45XOR((  64 & SALT) ? DB19 : DB03), K11XOR(( 128 & SALT) ? DB20 : DB04), K47XOR(( 256 & SALT) ? DB21 : DB05), K55XOR(( 512 & SALT) ? DB22 : DB06), K05XOR((1024 & SALT) ? DB23 : DB07), K27XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K46XOR(                DB07       ), K19XOR(                DB08       ), K13XOR(                DB09       ), K38XOR(                DB10       ), K25XOR(                DB11       ), K41XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K40XOR(                DB11       ), K48XOR(                DB12       ), K18XOR(                DB13       ), K12XOR(                DB14       ), K06XOR(                DB15       ), K52XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K00XOR((   1 & SALT) ? DB31 : DB15), K37XOR((   2 & SALT) ? DB00 : DB16), K17XOR((   4 & SALT) ? DB01 : DB17), K28XOR((   8 & SALT) ? DB02 : DB18), K15XOR((  16 & SALT) ? DB03 : DB19), K16XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K24XOR((  64 & SALT) ? DB03 : DB19), K07XOR(( 128 & SALT) ? DB04 : DB20), K44XOR(( 256 & SALT) ? DB05 : DB21), K29XOR(( 512 & SALT) ? DB06 : DB22), K03XOR((1024 & SALT) ? DB07 : DB23), K08XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K36XOR(                DB23       ), K01XOR(                DB24       ), K14XOR(                DB25       ), K09XOR(                DB26       ), K49XOR(                DB27       ), K30XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K22XOR(                DB27       ), K50XOR(                DB28       ), K51XOR(                DB29       ), K35XOR(                DB30       ), K02XOR(                DB31       ), K10XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(576);
		if (!threadIdx.y) {
		s1(K40XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K19XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K06XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K25XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K45XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K48XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K31XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K52XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K33XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K41XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K46XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K13XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K32XOR(db[39<<DB_SHIFT]), K05XOR(db[40<<DB_SHIFT]), K54XOR(db[41<<DB_SHIFT]), K55XOR(db[42<<DB_SHIFT]), K11XOR(db[43<<DB_SHIFT]), K27XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K26XOR(db[43<<DB_SHIFT]), K34XOR(db[44<<DB_SHIFT]), K04XOR(db[45<<DB_SHIFT]), K53XOR(db[46<<DB_SHIFT]), K47XOR(db[47<<DB_SHIFT]), K38XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K43XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K23XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K03XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K14XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K01XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K02XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K10XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K50XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K30XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K15XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K42XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K51XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K22XOR(db[55<<DB_SHIFT]), K44XOR(db[56<<DB_SHIFT]), K00XOR(db[57<<DB_SHIFT]), K24XOR(db[58<<DB_SHIFT]), K35XOR(db[59<<DB_SHIFT]), K16XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K08XOR(db[59<<DB_SHIFT]), K36XOR(db[60<<DB_SHIFT]), K37XOR(db[61<<DB_SHIFT]), K21XOR(db[62<<DB_SHIFT]), K17XOR(db[63<<DB_SHIFT]), K49XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(672);
		if (!threadIdx.y) {
		s1(K26XOR((   1 & SALT) ? DB15 : DB31), K05XOR((   2 & SALT) ? DB16 : DB00), K47XOR((   4 & SALT) ? DB17 : DB01), K11XOR((   8 & SALT) ? DB18 : DB02), K31XOR((  16 & SALT) ? DB19 : DB03), K34XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K48XOR((  64 & SALT) ? DB19 : DB03), K38XOR(( 128 & SALT) ? DB20 : DB04), K19XOR(( 256 & SALT) ? DB21 : DB05), K27XOR(( 512 & SALT) ? DB22 : DB06), K32XOR((1024 & SALT) ? DB23 : DB07), K54XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K18XOR(                DB07       ), K46XOR(                DB08       ), K40XOR(                DB09       ), K41XOR(                DB10       ), K52XOR(                DB11       ), K13XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K12XOR(                DB11       ), K20XOR(                DB12       ), K45XOR(                DB13       ), K39XOR(                DB14       ), K33XOR(                DB15       ), K55XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K29XOR((   1 & SALT) ? DB31 : DB15), K09XOR((   2 & SALT) ? DB00 : DB16), K42XOR((   4 & SALT) ? DB01 : DB17), K00XOR((   8 & SALT) ? DB02 : DB18), K44XOR((  16 & SALT) ? DB03 : DB19), K17XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K49XOR((  64 & SALT) ? DB03 : DB19), K36XOR(( 128 & SALT) ? DB04 : DB20), K16XOR(( 256 & SALT) ? DB05 : DB21), K01XOR(( 512 & SALT) ? DB06 : DB22), K28XOR((1024 & SALT) ? DB07 : DB23), K37XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K08XOR(                DB23       ), K30XOR(                DB24       ), K43XOR(                DB25       ), K10XOR(                DB26       ), K21XOR(                DB27       ), K02XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K51XOR(                DB27       ), K22XOR(                DB28       ), K23XOR(                DB29       ), K07XOR(                DB30       ), K03XOR(                DB31       ), K35XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(672);
		if (!threadIdx.y) {
		s1(K19XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K53XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K40XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K04XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K55XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K27XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K41XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K31XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K12XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K20XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K25XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K47XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K11XOR(db[39<<DB_SHIFT]), K39XOR(db[40<<DB_SHIFT]), K33XOR(db[41<<DB_SHIFT]), K34XOR(db[42<<DB_SHIFT]), K45XOR(db[43<<DB_SHIFT]), K06XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K05XOR(db[43<<DB_SHIFT]), K13XOR(db[44<<DB_SHIFT]), K38XOR(db[45<<DB_SHIFT]), K32XOR(db[46<<DB_SHIFT]), K26XOR(db[47<<DB_SHIFT]), K48XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K22XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K02XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K35XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K50XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K37XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K10XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K42XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K29XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K09XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K51XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K21XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K30XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K01XOR(db[55<<DB_SHIFT]), K23XOR(db[56<<DB_SHIFT]), K36XOR(db[57<<DB_SHIFT]), K03XOR(db[58<<DB_SHIFT]), K14XOR(db[59<<DB_SHIFT]), K24XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K44XOR(db[59<<DB_SHIFT]), K15XOR(db[60<<DB_SHIFT]), K16XOR(db[61<<DB_SHIFT]), K00XOR(db[62<<DB_SHIFT]), K49XOR(db[63<<DB_SHIFT]), K28XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		if (i >= 12)
			break;

		// ROUND_B(-48);
		if (!threadIdx.y) {
		s1(K12XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K46XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K33XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K52XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K48XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K20XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K34XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K55XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K05XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K13XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K18XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K40XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K04XOR(db[39<<DB_SHIFT]), K32XOR(db[40<<DB_SHIFT]), K26XOR(db[41<<DB_SHIFT]), K27XOR(db[42<<DB_SHIFT]), K38XOR(db[43<<DB_SHIFT]), K54XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K53XOR(db[43<<DB_SHIFT]), K06XOR(db[44<<DB_SHIFT]), K31XOR(db[45<<DB_SHIFT]), K25XOR(db[46<<DB_SHIFT]), K19XOR(db[47<<DB_SHIFT]), K41XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K15XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K24XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K28XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K43XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K30XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K03XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K35XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K22XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K02XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K44XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K14XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K23XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K51XOR(db[55<<DB_SHIFT]), K16XOR(db[56<<DB_SHIFT]), K29XOR(db[57<<DB_SHIFT]), K49XOR(db[58<<DB_SHIFT]), K07XOR(db[59<<DB_SHIFT]), K17XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K37XOR(db[59<<DB_SHIFT]), K08XOR(db[60<<DB_SHIFT]), K09XOR(db[61<<DB_SHIFT]), K50XOR(db[62<<DB_SHIFT]), K42XOR(db[63<<DB_SHIFT]), K21XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(48);
		if (!threadIdx.y) {
		s1(K05XOR((   1 & SALT) ? DB15 : DB31), K39XOR((   2 & SALT) ? DB16 : DB00), K26XOR((   4 & SALT) ? DB17 : DB01), K45XOR((   8 & SALT) ? DB18 : DB02), K41XOR((  16 & SALT) ? DB19 : DB03), K13XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K27XOR((  64 & SALT) ? DB19 : DB03), K48XOR(( 128 & SALT) ? DB20 : DB04), K53XOR(( 256 & SALT) ? DB21 : DB05), K06XOR(( 512 & SALT) ? DB22 : DB06), K11XOR((1024 & SALT) ? DB23 : DB07), K33XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K52XOR(                DB07       ), K25XOR(                DB08       ), K19XOR(                DB09       ), K20XOR(                DB10       ), K31XOR(                DB11       ), K47XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K46XOR(                DB11       ), K54XOR(                DB12       ), K55XOR(                DB13       ), K18XOR(                DB14       ), K12XOR(                DB15       ), K34XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K08XOR((   1 & SALT) ? DB31 : DB15), K17XOR((   2 & SALT) ? DB00 : DB16), K21XOR((   4 & SALT) ? DB01 : DB17), K36XOR((   8 & SALT) ? DB02 : DB18), K23XOR((  16 & SALT) ? DB03 : DB19), K49XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K28XOR((  64 & SALT) ? DB03 : DB19), K15XOR(( 128 & SALT) ? DB04 : DB20), K24XOR(( 256 & SALT) ? DB05 : DB21), K37XOR(( 512 & SALT) ? DB06 : DB22), K07XOR((1024 & SALT) ? DB07 : DB23), K16XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K44XOR(                DB23       ), K09XOR(                DB24       ), K22XOR(                DB25       ), K42XOR(                DB26       ), K00XOR(                DB27       ), K10XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K30XOR(                DB27       ), K01XOR(                DB28       ), K02XOR(                DB29       ), K43XOR(                DB30       ), K35XOR(                DB31       ), K14XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(48);
		if (!threadIdx.y) {
		s1(K46XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K25XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K12XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K31XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K27XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K54XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K13XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K34XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K39XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K47XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K52XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K19XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K38XOR(db[39<<DB_SHIFT]), K11XOR(db[40<<DB_SHIFT]), K05XOR(db[41<<DB_SHIFT]), K06XOR(db[42<<DB_SHIFT]), K48XOR(db[43<<DB_SHIFT]), K33XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K32XOR(db[43<<DB_SHIFT]), K40XOR(db[44<<DB_SHIFT]), K41XOR(db[45<<DB_SHIFT]), K04XOR(db[46<<DB_SHIFT]), K53XOR(db[47<<DB_SHIFT]), K20XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K51XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K03XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K07XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K22XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K09XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K35XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K14XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K01XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K10XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K23XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K50XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K02XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K30XOR(db[55<<DB_SHIFT]), K24XOR(db[56<<DB_SHIFT]), K08XOR(db[57<<DB_SHIFT]), K28XOR(db[58<<DB_SHIFT]), K43XOR(db[59<<DB_SHIFT]), K49XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K16XOR(db[59<<DB_SHIFT]), K44XOR(db[60<<DB_SHIFT]), K17XOR(db[61<<DB_SHIFT]), K29XOR(db[62<<DB_SHIFT]), K21XOR(db[63<<DB_SHIFT]), K00XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(144);
		if (!threadIdx.y) {
		s1(K32XOR((   1 & SALT) ? DB15 : DB31), K11XOR((   2 & SALT) ? DB16 : DB00), K53XOR((   4 & SALT) ? DB17 : DB01), K48XOR((   8 & SALT) ? DB18 : DB02), K13XOR((  16 & SALT) ? DB19 : DB03), K40XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K54XOR((  64 & SALT) ? DB19 : DB03), K20XOR(( 128 & SALT) ? DB20 : DB04), K25XOR(( 256 & SALT) ? DB21 : DB05), K33XOR(( 512 & SALT) ? DB22 : DB06), K38XOR((1024 & SALT) ? DB23 : DB07), K05XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K55XOR(                DB07       ), K52XOR(                DB08       ), K46XOR(                DB09       ), K47XOR(                DB10       ), K34XOR(                DB11       ), K19XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K18XOR(                DB11       ), K26XOR(                DB12       ), K27XOR(                DB13       ), K45XOR(                DB14       ), K39XOR(                DB15       ), K06XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K37XOR((   1 & SALT) ? DB31 : DB15), K42XOR((   2 & SALT) ? DB00 : DB16), K50XOR((   4 & SALT) ? DB01 : DB17), K08XOR((   8 & SALT) ? DB02 : DB18), K24XOR((  16 & SALT) ? DB03 : DB19), K21XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K00XOR((  64 & SALT) ? DB03 : DB19), K44XOR(( 128 & SALT) ? DB04 : DB20), K49XOR(( 256 & SALT) ? DB05 : DB21), K09XOR(( 512 & SALT) ? DB06 : DB22), K36XOR((1024 & SALT) ? DB07 : DB23), K17XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K16XOR(                DB23       ), K10XOR(                DB24       ), K51XOR(                DB25       ), K14XOR(                DB26       ), K29XOR(                DB27       ), K35XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K02XOR(                DB27       ), K30XOR(                DB28       ), K03XOR(                DB29       ), K15XOR(                DB30       ), K07XOR(                DB31       ), K43XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(144);
		if (!threadIdx.y) {
		s1(K18XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K52XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K39XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K34XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K54XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K26XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K40XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K06XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K11XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K19XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K55XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K46XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K41XOR(db[39<<DB_SHIFT]), K38XOR(db[40<<DB_SHIFT]), K32XOR(db[41<<DB_SHIFT]), K33XOR(db[42<<DB_SHIFT]), K20XOR(db[43<<DB_SHIFT]), K05XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K04XOR(db[43<<DB_SHIFT]), K12XOR(db[44<<DB_SHIFT]), K13XOR(db[45<<DB_SHIFT]), K31XOR(db[46<<DB_SHIFT]), K25XOR(db[47<<DB_SHIFT]), K47XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K23XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K28XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K36XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K51XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K10XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K07XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K43XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K30XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K35XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K24XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K22XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K03XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K02XOR(db[55<<DB_SHIFT]), K49XOR(db[56<<DB_SHIFT]), K37XOR(db[57<<DB_SHIFT]), K00XOR(db[58<<DB_SHIFT]), K15XOR(db[59<<DB_SHIFT]), K21XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K17XOR(db[59<<DB_SHIFT]), K16XOR(db[60<<DB_SHIFT]), K42XOR(db[61<<DB_SHIFT]), K01XOR(db[62<<DB_SHIFT]), K50XOR(db[63<<DB_SHIFT]), K29XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(240);
		if (!threadIdx.y) {
		s1(K04XOR((   1 & SALT) ? DB15 : DB31), K38XOR((   2 & SALT) ? DB16 : DB00), K25XOR((   4 & SALT) ? DB17 : DB01), K20XOR((   8 & SALT) ? DB18 : DB02), K40XOR((  16 & SALT) ? DB19 : DB03), K12XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K26XOR((  64 & SALT) ? DB19 : DB03), K47XOR(( 128 & SALT) ? DB20 : DB04), K52XOR(( 256 & SALT) ? DB21 : DB05), K05XOR(( 512 & SALT) ? DB22 : DB06), K41XOR((1024 & SALT) ? DB23 : DB07), K32XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K27XOR(                DB07       ), K55XOR(                DB08       ), K18XOR(                DB09       ), K19XOR(                DB10       ), K06XOR(                DB11       ), K46XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K45XOR(                DB11       ), K53XOR(                DB12       ), K54XOR(                DB13       ), K48XOR(                DB14       ), K11XOR(                DB15       ), K33XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K09XOR((   1 & SALT) ? DB31 : DB15), K14XOR((   2 & SALT) ? DB00 : DB16), K22XOR((   4 & SALT) ? DB01 : DB17), K37XOR((   8 & SALT) ? DB02 : DB18), K49XOR((  16 & SALT) ? DB03 : DB19), K50XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K29XOR((  64 & SALT) ? DB03 : DB19), K16XOR(( 128 & SALT) ? DB04 : DB20), K21XOR(( 256 & SALT) ? DB05 : DB21), K10XOR(( 512 & SALT) ? DB06 : DB22), K08XOR((1024 & SALT) ? DB07 : DB23), K42XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K17XOR(                DB23       ), K35XOR(                DB24       ), K23XOR(                DB25       ), K43XOR(                DB26       ), K01XOR(                DB27       ), K07XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K03XOR(                DB27       ), K02XOR(                DB28       ), K28XOR(                DB29       ), K44XOR(                DB30       ), K36XOR(                DB31       ), K15XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(240);
		if (!threadIdx.y) {
		s1(K45XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K55XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K11XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K06XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K26XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K53XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K12XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K33XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K38XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K46XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K27XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K18XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K13XOR(db[39<<DB_SHIFT]), K41XOR(db[40<<DB_SHIFT]), K04XOR(db[41<<DB_SHIFT]), K05XOR(db[42<<DB_SHIFT]), K47XOR(db[43<<DB_SHIFT]), K32XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K31XOR(db[43<<DB_SHIFT]), K39XOR(db[44<<DB_SHIFT]), K40XOR(db[45<<DB_SHIFT]), K34XOR(db[46<<DB_SHIFT]), K52XOR(db[47<<DB_SHIFT]), K19XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K24XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K00XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K08XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K23XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K35XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K36XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K15XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K02XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K07XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K49XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K51XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K28XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K03XOR(db[55<<DB_SHIFT]), K21XOR(db[56<<DB_SHIFT]), K09XOR(db[57<<DB_SHIFT]), K29XOR(db[58<<DB_SHIFT]), K44XOR(db[59<<DB_SHIFT]), K50XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K42XOR(db[59<<DB_SHIFT]), K17XOR(db[60<<DB_SHIFT]), K14XOR(db[61<<DB_SHIFT]), K30XOR(db[62<<DB_SHIFT]), K22XOR(db[63<<DB_SHIFT]), K01XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(336);
		if (!threadIdx.y) {
		s1(K31XOR((   1 & SALT) ? DB15 : DB31), K41XOR((   2 & SALT) ? DB16 : DB00), K52XOR((   4 & SALT) ? DB17 : DB01), K47XOR((   8 & SALT) ? DB18 : DB02), K12XOR((  16 & SALT) ? DB19 : DB03), K39XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K53XOR((  64 & SALT) ? DB19 : DB03), K19XOR(( 128 & SALT) ? DB20 : DB04), K55XOR(( 256 & SALT) ? DB21 : DB05), K32XOR(( 512 & SALT) ? DB22 : DB06), K13XOR((1024 & SALT) ? DB23 : DB07), K04XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K54XOR(                DB07       ), K27XOR(                DB08       ), K45XOR(                DB09       ), K46XOR(                DB10       ), K33XOR(                DB11       ), K18XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K48XOR(                DB11       ), K25XOR(                DB12       ), K26XOR(                DB13       ), K20XOR(                DB14       ), K38XOR(                DB15       ), K05XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K10XOR((   1 & SALT) ? DB31 : DB15), K43XOR((   2 & SALT) ? DB00 : DB16), K51XOR((   4 & SALT) ? DB01 : DB17), K09XOR((   8 & SALT) ? DB02 : DB18), K21XOR((  16 & SALT) ? DB03 : DB19), K22XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K01XOR((  64 & SALT) ? DB03 : DB19), K17XOR(( 128 & SALT) ? DB04 : DB20), K50XOR(( 256 & SALT) ? DB05 : DB21), K35XOR(( 512 & SALT) ? DB06 : DB22), K37XOR((1024 & SALT) ? DB07 : DB23), K14XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K42XOR(                DB23       ), K07XOR(                DB24       ), K24XOR(                DB25       ), K15XOR(                DB26       ), K30XOR(                DB27       ), K36XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K28XOR(                DB27       ), K03XOR(                DB28       ), K00XOR(                DB29       ), K16XOR(                DB30       ), K08XOR(                DB31       ), K44XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(336);
		if (!threadIdx.y) {
		s1(K55XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K34XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K45XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K40XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K05XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K32XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K46XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K12XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K48XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K25XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K06XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K52XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K47XOR(db[39<<DB_SHIFT]), K20XOR(db[40<<DB_SHIFT]), K38XOR(db[41<<DB_SHIFT]), K39XOR(db[42<<DB_SHIFT]), K26XOR(db[43<<DB_SHIFT]), K11XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K41XOR(db[43<<DB_SHIFT]), K18XOR(db[44<<DB_SHIFT]), K19XOR(db[45<<DB_SHIFT]), K13XOR(db[46<<DB_SHIFT]), K31XOR(db[47<<DB_SHIFT]), K53XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K03XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K36XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K44XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K02XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K14XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K15XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K51XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K10XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K43XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K28XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K30XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K07XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K35XOR(db[55<<DB_SHIFT]), K00XOR(db[56<<DB_SHIFT]), K17XOR(db[57<<DB_SHIFT]), K08XOR(db[58<<DB_SHIFT]), K23XOR(db[59<<DB_SHIFT]), K29XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K21XOR(db[59<<DB_SHIFT]), K49XOR(db[60<<DB_SHIFT]), K50XOR(db[61<<DB_SHIFT]), K09XOR(db[62<<DB_SHIFT]), K01XOR(db[63<<DB_SHIFT]), K37XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(432);
		if (!threadIdx.y) {
		s1(K41XOR((   1 & SALT) ? DB15 : DB31), K20XOR((   2 & SALT) ? DB16 : DB00), K31XOR((   4 & SALT) ? DB17 : DB01), K26XOR((   8 & SALT) ? DB18 : DB02), K46XOR((  16 & SALT) ? DB19 : DB03), K18XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K32XOR((  64 & SALT) ? DB19 : DB03), K53XOR(( 128 & SALT) ? DB20 : DB04), K34XOR(( 256 & SALT) ? DB21 : DB05), K11XOR(( 512 & SALT) ? DB22 : DB06), K47XOR((1024 & SALT) ? DB23 : DB07), K38XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K33XOR(                DB07       ), K06XOR(                DB08       ), K55XOR(                DB09       ), K25XOR(                DB10       ), K12XOR(                DB11       ), K52XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K27XOR(                DB11       ), K04XOR(                DB12       ), K05XOR(                DB13       ), K54XOR(                DB14       ), K48XOR(                DB15       ), K39XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K42XOR((   1 & SALT) ? DB31 : DB15), K22XOR((   2 & SALT) ? DB00 : DB16), K30XOR((   4 & SALT) ? DB01 : DB17), K17XOR((   8 & SALT) ? DB02 : DB18), K00XOR((  16 & SALT) ? DB03 : DB19), K01XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K37XOR((  64 & SALT) ? DB03 : DB19), K49XOR(( 128 & SALT) ? DB04 : DB20), K29XOR(( 256 & SALT) ? DB05 : DB21), K14XOR(( 512 & SALT) ? DB06 : DB22), K16XOR((1024 & SALT) ? DB07 : DB23), K50XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K21XOR(                DB23       ), K43XOR(                DB24       ), K03XOR(                DB25       ), K51XOR(                DB26       ), K09XOR(                DB27       ), K15XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K07XOR(                DB27       ), K35XOR(                DB28       ), K36XOR(                DB29       ), K24XOR(                DB30       ), K44XOR(                DB31       ), K23XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(432);
		if (!threadIdx.y) {
		s1(K27XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K06XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K48XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K12XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K32XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K04XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K18XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K39XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K20XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K52XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K33XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K55XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K19XOR(db[39<<DB_SHIFT]), K47XOR(db[40<<DB_SHIFT]), K41XOR(db[41<<DB_SHIFT]), K11XOR(db[42<<DB_SHIFT]), K53XOR(db[43<<DB_SHIFT]), K38XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K13XOR(db[43<<DB_SHIFT]), K45XOR(db[44<<DB_SHIFT]), K46XOR(db[45<<DB_SHIFT]), K40XOR(db[46<<DB_SHIFT]), K34XOR(db[47<<DB_SHIFT]), K25XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K28XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K08XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K16XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K03XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K43XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K44XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K23XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K35XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K15XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K00XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K02XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K36XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K07XOR(db[55<<DB_SHIFT]), K29XOR(db[56<<DB_SHIFT]), K42XOR(db[57<<DB_SHIFT]), K37XOR(db[58<<DB_SHIFT]), K24XOR(db[59<<DB_SHIFT]), K01XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K50XOR(db[59<<DB_SHIFT]), K21XOR(db[60<<DB_SHIFT]), K22XOR(db[61<<DB_SHIFT]), K10XOR(db[62<<DB_SHIFT]), K30XOR(db[63<<DB_SHIFT]), K09XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(528);
		if (!threadIdx.y) {
		s1(K13XOR((   1 & SALT) ? DB15 : DB31), K47XOR((   2 & SALT) ? DB16 : DB00), K34XOR((   4 & SALT) ? DB17 : DB01), K53XOR((   8 & SALT) ? DB18 : DB02), K18XOR((  16 & SALT) ? DB19 : DB03), K45XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K04XOR((  64 & SALT) ? DB19 : DB03), K25XOR(( 128 & SALT) ? DB20 : DB04), K06XOR(( 256 & SALT) ? DB21 : DB05), K38XOR(( 512 & SALT) ? DB22 : DB06), K19XOR((1024 & SALT) ? DB23 : DB07), K41XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K05XOR(                DB07       ), K33XOR(                DB08       ), K27XOR(                DB09       ), K52XOR(                DB10       ), K39XOR(                DB11       ), K55XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K54XOR(                DB11       ), K31XOR(                DB12       ), K32XOR(                DB13       ), K26XOR(                DB14       ), K20XOR(                DB15       ), K11XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K14XOR((   1 & SALT) ? DB31 : DB15), K51XOR((   2 & SALT) ? DB00 : DB16), K02XOR((   4 & SALT) ? DB01 : DB17), K42XOR((   8 & SALT) ? DB02 : DB18), K29XOR((  16 & SALT) ? DB03 : DB19), K30XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K09XOR((  64 & SALT) ? DB03 : DB19), K21XOR(( 128 & SALT) ? DB04 : DB20), K01XOR(( 256 & SALT) ? DB05 : DB21), K43XOR(( 512 & SALT) ? DB06 : DB22), K17XOR((1024 & SALT) ? DB07 : DB23), K22XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K50XOR(                DB23       ), K15XOR(                DB24       ), K28XOR(                DB25       ), K23XOR(                DB26       ), K10XOR(                DB27       ), K44XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K36XOR(                DB27       ), K07XOR(                DB28       ), K08XOR(                DB29       ), K49XOR(                DB30       ), K16XOR(                DB31       ), K24XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(528);
		if (!threadIdx.y) {
		s1(K54XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K33XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K20XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K39XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K04XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K31XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K45XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K11XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K47XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K55XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K05XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K27XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K46XOR(db[39<<DB_SHIFT]), K19XOR(db[40<<DB_SHIFT]), K13XOR(db[41<<DB_SHIFT]), K38XOR(db[42<<DB_SHIFT]), K25XOR(db[43<<DB_SHIFT]), K41XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K40XOR(db[43<<DB_SHIFT]), K48XOR(db[44<<DB_SHIFT]), K18XOR(db[45<<DB_SHIFT]), K12XOR(db[46<<DB_SHIFT]), K06XOR(db[47<<DB_SHIFT]), K52XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K00XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K37XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K17XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K28XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K15XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K16XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K24XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K07XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K44XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K29XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K03XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K08XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K36XOR(db[55<<DB_SHIFT]), K01XOR(db[56<<DB_SHIFT]), K14XOR(db[57<<DB_SHIFT]), K09XOR(db[58<<DB_SHIFT]), K49XOR(db[59<<DB_SHIFT]), K30XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K22XOR(db[59<<DB_SHIFT]), K50XOR(db[60<<DB_SHIFT]), K51XOR(db[61<<DB_SHIFT]), K35XOR(db[62<<DB_SHIFT]), K02XOR(db[63<<DB_SHIFT]), K10XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(624);
		if (!threadIdx.y) {
		s1(K40XOR((   1 & SALT) ? DB15 : DB31), K19XOR((   2 & SALT) ? DB16 : DB00), K06XOR((   4 & SALT) ? DB17 : DB01), K25XOR((   8 & SALT) ? DB18 : DB02), K45XOR((  16 & SALT) ? DB19 : DB03), K48XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K31XOR((  64 & SALT) ? DB19 : DB03), K52XOR(( 128 & SALT) ? DB20 : DB04), K33XOR(( 256 & SALT) ? DB21 : DB05), K41XOR(( 512 & SALT) ? DB22 : DB06), K46XOR((1024 & SALT) ? DB23 : DB07), K13XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K32XOR(                DB07       ), K05XOR(                DB08       ), K54XOR(                DB09       ), K55XOR(                DB10       ), K11XOR(                DB11       ), K27XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K26XOR(                DB11       ), K34XOR(                DB12       ), K04XOR(                DB13       ), K53XOR(                DB14       ), K47XOR(                DB15       ), K38XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K43XOR((   1 & SALT) ? DB31 : DB15), K23XOR((   2 & SALT) ? DB00 : DB16), K03XOR((   4 & SALT) ? DB01 : DB17), K14XOR((   8 & SALT) ? DB02 : DB18), K01XOR((  16 & SALT) ? DB03 : DB19), K02XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K10XOR((  64 & SALT) ? DB03 : DB19), K50XOR(( 128 & SALT) ? DB04 : DB20), K30XOR(( 256 & SALT) ? DB05 : DB21), K15XOR(( 512 & SALT) ? DB06 : DB22), K42XOR((1024 & SALT) ? DB07 : DB23), K51XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K22XOR(                DB23       ), K44XOR(                DB24       ), K00XOR(                DB25       ), K24XOR(                DB26       ), K35XOR(                DB27       ), K16XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K08XOR(                DB27       ), K36XOR(                DB28       ), K37XOR(                DB29       ), K21XOR(                DB30       ), K17XOR(                DB31       ), K49XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		

		// ROUND_B(624);
		if (!threadIdx.y) {
		s1(K26XOR((   1 & SALT) ? db[47<<DB_SHIFT] : db[63<<DB_SHIFT]), K05XOR((   2 & SALT) ? db[48<<DB_SHIFT] : db[32<<DB_SHIFT]), K47XOR((   4 & SALT) ? db[49<<DB_SHIFT] : db[33<<DB_SHIFT]), K11XOR((   8 & SALT) ? db[50<<DB_SHIFT] : db[34<<DB_SHIFT]), K31XOR((  16 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K34XOR((  32 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), DB08, DB16, DB22, DB30);
		s2(K48XOR((  64 & SALT) ? db[51<<DB_SHIFT] : db[35<<DB_SHIFT]), K38XOR(( 128 & SALT) ? db[52<<DB_SHIFT] : db[36<<DB_SHIFT]), K19XOR(( 256 & SALT) ? db[53<<DB_SHIFT] : db[37<<DB_SHIFT]), K27XOR(( 512 & SALT) ? db[54<<DB_SHIFT] : db[38<<DB_SHIFT]), K32XOR((1024 & SALT) ? db[55<<DB_SHIFT] : db[39<<DB_SHIFT]), K54XOR((2048 & SALT) ? db[56<<DB_SHIFT] : db[40<<DB_SHIFT]), DB12, DB27, DB01, DB17);
		s3(K18XOR(db[39<<DB_SHIFT]), K46XOR(db[40<<DB_SHIFT]), K40XOR(db[41<<DB_SHIFT]), K41XOR(db[42<<DB_SHIFT]), K52XOR(db[43<<DB_SHIFT]), K13XOR(db[44<<DB_SHIFT]), DB23, DB15, DB29, DB05);
		s4(K12XOR(db[43<<DB_SHIFT]), K20XOR(db[44<<DB_SHIFT]), K45XOR(db[45<<DB_SHIFT]), K39XOR(db[46<<DB_SHIFT]), K33XOR(db[47<<DB_SHIFT]), K55XOR(db[48<<DB_SHIFT]), DB25, DB19, DB09, DB00);
		s5(K29XOR((   1 & SALT) ? db[63<<DB_SHIFT] : db[47<<DB_SHIFT]), K09XOR((   2 & SALT) ? db[32<<DB_SHIFT] : db[48<<DB_SHIFT]), K42XOR((   4 & SALT) ? db[33<<DB_SHIFT] : db[49<<DB_SHIFT]), K00XOR((   8 & SALT) ? db[34<<DB_SHIFT] : db[50<<DB_SHIFT]), K44XOR((  16 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K17XOR((  32 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), DB07, DB13, DB24, DB02);
		s6(K49XOR((  64 & SALT) ? db[35<<DB_SHIFT] : db[51<<DB_SHIFT]), K36XOR(( 128 & SALT) ? db[36<<DB_SHIFT] : db[52<<DB_SHIFT]), K16XOR(( 256 & SALT) ? db[37<<DB_SHIFT] : db[53<<DB_SHIFT]), K01XOR(( 512 & SALT) ? db[38<<DB_SHIFT] : db[54<<DB_SHIFT]), K28XOR((1024 & SALT) ? db[39<<DB_SHIFT] : db[55<<DB_SHIFT]), K37XOR((2048 & SALT) ? db[40<<DB_SHIFT] : db[56<<DB_SHIFT]), DB03, DB28, DB10, DB18);
		s7(K08XOR(db[55<<DB_SHIFT]), K30XOR(db[56<<DB_SHIFT]), K43XOR(db[57<<DB_SHIFT]), K10XOR(db[58<<DB_SHIFT]), K21XOR(db[59<<DB_SHIFT]), K02XOR(db[60<<DB_SHIFT]), DB31, DB11, DB21, DB06);
		s8(K51XOR(db[59<<DB_SHIFT]), K22XOR(db[60<<DB_SHIFT]), K23XOR(db[61<<DB_SHIFT]), K07XOR(db[62<<DB_SHIFT]), K03XOR(db[63<<DB_SHIFT]), K35XOR(db[32<<DB_SHIFT]), DB04, DB26, DB14, DB20);
		}
		

		// ROUND_A(720);
		if (!threadIdx.y) {
		s1(K19XOR((   1 & SALT) ? DB15 : DB31), K53XOR((   2 & SALT) ? DB16 : DB00), K40XOR((   4 & SALT) ? DB17 : DB01), K04XOR((   8 & SALT) ? DB18 : DB02), K55XOR((  16 & SALT) ? DB19 : DB03), K27XOR((  32 & SALT) ? DB20 : DB04), db[40<<DB_SHIFT], db[48<<DB_SHIFT], db[54<<DB_SHIFT], db[62<<DB_SHIFT]);
		s2(K41XOR((  64 & SALT) ? DB19 : DB03), K31XOR(( 128 & SALT) ? DB20 : DB04), K12XOR(( 256 & SALT) ? DB21 : DB05), K20XOR(( 512 & SALT) ? DB22 : DB06), K25XOR((1024 & SALT) ? DB23 : DB07), K47XOR((2048 & SALT) ? DB24 : DB08), db[44<<DB_SHIFT], db[59<<DB_SHIFT], db[33<<DB_SHIFT], db[49<<DB_SHIFT]);
		s3(K11XOR(                DB07       ), K39XOR(                DB08       ), K33XOR(                DB09       ), K34XOR(                DB10       ), K45XOR(                DB11       ), K06XOR(                DB12       ), db[55<<DB_SHIFT], db[47<<DB_SHIFT], db[61<<DB_SHIFT], db[37<<DB_SHIFT]);
		s4(K05XOR(                DB11       ), K13XOR(                DB12       ), K38XOR(                DB13       ), K32XOR(                DB14       ), K26XOR(                DB15       ), K48XOR(                DB16       ), db[57<<DB_SHIFT], db[51<<DB_SHIFT], db[41<<DB_SHIFT], db[32<<DB_SHIFT]);
		s5(K22XOR((   1 & SALT) ? DB31 : DB15), K02XOR((   2 & SALT) ? DB00 : DB16), K35XOR((   4 & SALT) ? DB01 : DB17), K50XOR((   8 & SALT) ? DB02 : DB18), K37XOR((  16 & SALT) ? DB03 : DB19), K10XOR((  32 & SALT) ? DB04 : DB20), db[39<<DB_SHIFT], db[45<<DB_SHIFT], db[56<<DB_SHIFT], db[34<<DB_SHIFT]);
		s6(K42XOR((  64 & SALT) ? DB03 : DB19), K29XOR(( 128 & SALT) ? DB04 : DB20), K09XOR(( 256 & SALT) ? DB05 : DB21), K51XOR(( 512 & SALT) ? DB06 : DB22), K21XOR((1024 & SALT) ? DB07 : DB23), K30XOR((2048 & SALT) ? DB08 : DB24), db[35<<DB_SHIFT], db[60<<DB_SHIFT], db[42<<DB_SHIFT], db[50<<DB_SHIFT]);
		s7(K01XOR(                DB23       ), K23XOR(                DB24       ), K36XOR(                DB25       ), K03XOR(                DB26       ), K14XOR(                DB27       ), K24XOR(                DB28       ), db[63<<DB_SHIFT], db[43<<DB_SHIFT], db[53<<DB_SHIFT], db[38<<DB_SHIFT]);
		s8(K44XOR(                DB27       ), K15XOR(                DB28       ), K16XOR(                DB29       ), K00XOR(                DB30       ), K49XOR(                DB31       ), K28XOR(                DB00       ), db[36<<DB_SHIFT], db[58<<DB_SHIFT], db[46<<DB_SHIFT], db[52<<DB_SHIFT]);
		}
		
	}
	db[ 0<<DB_SHIFT] = DB00;
	db[ 1<<DB_SHIFT] = DB01;
	db[ 2<<DB_SHIFT] = DB02;
	db[ 3<<DB_SHIFT] = DB03;
	db[ 4<<DB_SHIFT] = DB04;
	db[ 5<<DB_SHIFT] = DB05;
	db[ 6<<DB_SHIFT] = DB06;
	db[ 7<<DB_SHIFT] = DB07;
	db[ 8<<DB_SHIFT] = DB08;
	db[ 9<<DB_SHIFT] = DB09;
	db[10<<DB_SHIFT] = DB10;
	db[11<<DB_SHIFT] = DB11;
	db[12<<DB_SHIFT] = DB12;
	db[13<<DB_SHIFT] = DB13;
	db[14<<DB_SHIFT] = DB14;
	db[15<<DB_SHIFT] = DB15;
	db[16<<DB_SHIFT] = DB16;
	db[17<<DB_SHIFT] = DB17;
	db[18<<DB_SHIFT] = DB18;
	db[19<<DB_SHIFT] = DB19;
	db[20<<DB_SHIFT] = DB20;
	db[21<<DB_SHIFT] = DB21;
	db[22<<DB_SHIFT] = DB22;
	db[23<<DB_SHIFT] = DB23;
	db[24<<DB_SHIFT] = DB24;
	db[25<<DB_SHIFT] = DB25;
	db[26<<DB_SHIFT] = DB26;
	db[27<<DB_SHIFT] = DB27;
	db[28<<DB_SHIFT] = DB28;
	db[29<<DB_SHIFT] = DB29;
	db[30<<DB_SHIFT] = DB30;
	db[31<<DB_SHIFT] = DB31;
}

#define GET_TRIPCODE_CHAR_INDEX(r, t, i0, i1, i2, i3, i4, i5, pos)  \
		(  ((((r)[threadIdx.x + (i0<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << (5 + ((pos) * 6)))  \
	 	 | ((((r)[threadIdx.x + (i1<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << (4 + ((pos) * 6)))  \
		 | ((((r)[threadIdx.x + (i2<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << (3 + ((pos) * 6)))  \
		 | ((((r)[threadIdx.x + (i3<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << (2 + ((pos) * 6)))  \
		 | ((((r)[threadIdx.x + (i4<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << (1 + ((pos) * 6)))  \
		 | ((((r)[threadIdx.x + (i5<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << (0 + ((pos) * 6)))) \

#define GET_TRIPCODE_CHAR_INDEX_LAST(r, t, i0, i1, i2, i3)     \
		(  ((((r)[threadIdx.x + (i0<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << 5)  \
	 	 | ((((r)[threadIdx.x + (i1<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << 4)  \
		 | ((((r)[threadIdx.x + (i2<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << 3)  \
		 | ((((r)[threadIdx.x + (i3<<DB_SHIFT)] & (0x01 << (t))) ? (0x1) : (0x0)) << 2)) \

DES_FUNCTION_QUALIFIERS void
DES_GetTripcodeChunks(int tripcodeIndex, unsigned int *tripcodeChunkArray, int searchMode)
{
	// Perform the final permutation here.
	if (searchMode == SEARCH_MODE_FORWARD_MATCHING) {
		tripcodeChunkArray[0] =   GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
	} else if (searchMode == SEARCH_MODE_BACKWARD_MATCHING) {
		tripcodeChunkArray[0] =   GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 4)
		                        | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 3)
		                        | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 2)
		                        | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 1)
		                        | GET_TRIPCODE_CHAR_INDEX_LAST(dataBlocks, tripcodeIndex, 48, 16, 56, 24);
	} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {
		tripcodeChunkArray[0] =   GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		tripcodeChunkArray[1] =   GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 4)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 3)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 2)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 1)
								| GET_TRIPCODE_CHAR_INDEX_LAST(dataBlocks, tripcodeIndex, 48, 16, 56, 24);
	} else {
		tripcodeChunkArray[0] =   GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
								| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		tripcodeChunkArray[1] = ((tripcodeChunkArray[0] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 0);
		tripcodeChunkArray[2] = ((tripcodeChunkArray[1] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 0);
		tripcodeChunkArray[3] = ((tripcodeChunkArray[2] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 0);
		tripcodeChunkArray[4] = ((tripcodeChunkArray[3] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 0);
		tripcodeChunkArray[5] = ((tripcodeChunkArray[4] << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX_LAST(dataBlocks, tripcodeIndex, 48, 16, 56, 24);
	}
}

DES_FUNCTION_QUALIFIERS
unsigned char *DES_GetTripcode(int tripcodeIndex, unsigned char *tripcode)
{
	// Perform the final permutation as necessary.
  	tripcode[0] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 0)];
  	tripcode[1] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 0)];
  	tripcode[2] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 0)];
  	tripcode[3] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 0)];
  	tripcode[4] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0)];
  	tripcode[5] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 0)];
  	tripcode[6] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 0)];
  	tripcode[7] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 0)];
  	tripcode[8] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 0)];
	tripcode[9] = CUDA_DES_indexToCharTable[GET_TRIPCODE_CHAR_INDEX_LAST(dataBlocks, tripcodeIndex, 48, 16, 56, 24)];
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
	unsigned int keyFrom00To27,\
	int          intSalt,\
	int         searchMode) {

#define CUDA_DES_BEFORE_SEARCHING \
	GPUOutput  *output = &outputArray[blockIdx.x * CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK + threadIdx.x];\
	unsigned char        key[8];\
	BOOL         isSecondByte;\
	unsigned char        tripcodeIndex;\
	unsigned char        passCount;\
	\
	if (threadIdx.y == 0) {\
		output->numMatchingTripcodes = 0;\
	}\
	key[0] = CUDA_key[0];\
	key[1] = CUDA_key[1];\
	key[2] = CUDA_key[2];\
	key[3] = CUDA_key[3];\
	isSecondByte = IS_FIRST_BYTE_SJIS(CUDA_key[3]);\
	SET_KEY_CHAR(key[4], isSecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[4] + ((blockIdx.x  >> 6) & 63));\
	SET_KEY_CHAR(key[5], isSecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[5] + ( blockIdx.x        & 63));\
	SET_KEY_CHAR(key[6], isSecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[6] + ( threadIdx.x       & 63));\
	unsigned int keyFrom28To48 = (((unsigned int)key[6] & 0x7f) << 14) | (((unsigned int)key[5] & 0x7f) <<  7) | (((unsigned int)key[4] & 0x7f) << 0); \
	\
	for (passCount = 0; passCount < 1; ++passCount) {\
	__syncthreads();\
	DES_Crypt(keyFrom00To27, keyFrom28To48, intSalt);\
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
			output->pair.key.c[0] = key[0];\
			output->pair.key.c[1] = key[1];\
			output->pair.key.c[2] = key[2];\
			output->pair.key.c[3] = key[3];\
			output->pair.key.c[4] = key[4];\
			output->pair.key.c[5] = key[5];\
			output->pair.key.c[6] = key[6];\
			output->pair.key.c[7] = CUDA_key7Array[tripcodeIndex];\
		}\
	}\
	}\
	if (threadIdx.y == 0)\
		output->numGeneratedTripcodes = CUDA_DES_BS_DEPTH;\
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

/*
CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_ForwardMatching_1Chunk)
	unsigned int tripcodeChunk0 = tripcodeChunkArray[0];
CUDA_DES_BEFORE_SEARCHING
	if (GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 0) != ((tripcodeChunk0 >> (6 * 4)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 0) != ((tripcodeChunk0 >> (6 * 3)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 0) != ((tripcodeChunk0 >> (6 * 2)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 0) != ((tripcodeChunk0 >> (6 * 1)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0) != ((tripcodeChunk0 >> (6 * 0)) & 0x3f))
		goto skip_final_permutation;
	found = TRUE;
	goto quit_loops;
skip_final_permutation:
CUDA_DES_END_OF_SEAERCH_FUNCTION
*/

/*
CUDA_DES_DEFINE_SEARCH_FUNCTION(CUDA_PerformSearching_DES_BackwardMatching_1Chunk)
	unsigned int tripcodeChunk0 = tripcodeChunkArray[0];
CUDA_DES_BEFORE_SEARCHING
	if (GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 0) != ((tripcodeChunk0 >> (6 * 4)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 0) != ((tripcodeChunk0 >> (6 * 3)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 0) != ((tripcodeChunk0 >> (6 * 2)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 0) != ((tripcodeChunk0 >> (6 * 1)) & 0x3f))
		goto skip_final_permutation;
	if (GET_TRIPCODE_CHAR_INDEX_LAST(dataBlocks, tripcodeIndex, 48, 16, 56, 24) != ((tripcodeChunk0 >> (6 * 0)) & 0x3f))
		goto skip_final_permutation;
	found = TRUE;
	goto quit_loops;
skip_final_permutation:
CUDA_DES_END_OF_SEAERCH_FUNCTION
*/

/*
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
*/

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

/*
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
*/

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

#define SET_BIT_FOR_KEY7(var, k) if (key7 & (0x1 << (k))) (var) |= 0x1 << tripcodeIndex

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
		// Choose the first 4 characters of the key.
		SetCharactersInTripcodeKey(key, 4);
		
		// Make sure that the first 3 bytes consist of valid Shift-JIS characters.
		for (int i = 4; i < lenTripcode; ++i)
			key[i] = 'A';
		if (!IsValidKey(key))
			continue;
		unsigned int keyFrom00To27 = (((unsigned int)key[3] & 0x7f) << 21) | (((unsigned int)key[2] & 0x7f) << 14) | (((unsigned int)key[1] & 0x7f) << 7) | (((unsigned int)key[0] & 0x7f) << 0); \
		
		// Generate random bytes for the key to ensure the randomness of them.
		unsigned char randomByteForKey6 = RandomByte();
		for (int i = 4; i < lenTripcode; ++i)
			key[i] = RandomByte();
		unsigned char key7Array[CUDA_DES_BS_DEPTH];
		DES_Vector  keyFrom49To55Array[7] = {0, 0, 0, 0, 0, 0, 0};
		for (int tripcodeIndex = 0; tripcodeIndex < CUDA_DES_BS_DEPTH; ++tripcodeIndex) {
			unsigned char key7 = key7Array[tripcodeIndex] = keyCharTable_SecondByteAndOneByte[key[7] + tripcodeIndex];
			SET_BIT_FOR_KEY7(keyFrom49To55Array[0], 0);
			SET_BIT_FOR_KEY7(keyFrom49To55Array[1], 1);
			SET_BIT_FOR_KEY7(keyFrom49To55Array[2], 2);
			SET_BIT_FOR_KEY7(keyFrom49To55Array[3], 3);
			SET_BIT_FOR_KEY7(keyFrom49To55Array[4], 4);
			SET_BIT_FOR_KEY7(keyFrom49To55Array[5], 5);
			SET_BIT_FOR_KEY7(keyFrom49To55Array[6], 6);
		}

		// Create an expansion function based on the salt.
		salt[0] = CONVERT_CHAR_FOR_SALT(key[1]);
		salt[1] = CONVERT_CHAR_FOR_SALT(key[2]);
		int intSalt = charToIndexTableForDES[CONVERT_CHAR_FOR_SALT(key[1])] | (charToIndexTableForDES[CONVERT_CHAR_FOR_SALT(key[2])] << 6);
		DES_CreateExpansionFunction((char *)salt, expansionFunction);

		// Call an appropriate CUDA kernel.
		CUDA_ERROR(cudaMemcpyToSymbol(CUDA_key,               key,               lenTripcode));
		CUDA_ERROR(cudaMemcpyToSymbol(CUDA_expansionFunction, expansionFunction, sizeof(expansionFunction)));
		CUDA_ERROR(cudaMemcpyToSymbol(CUDA_key7Array,         key7Array,         sizeof(key7Array)));
		CUDA_ERROR(cudaMemcpyToSymbol(CUDA_keyFrom49To55Array, keyFrom49To55Array, sizeof(keyFrom49To55Array)));
		dim3 dimBlock(CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK, CUDA_DES_NUM_THREADS_FOR_BITSLICE);
		dim3 dimGrid(numBlocksPerGrid);
		if (searchMode == SEARCH_MODE_FLEXIBLE) {
			/*if (numTripcodeChunk <= CUDA_SIMPLE_SEARCH_THRESHOLD) {
				CUDA_PerformSearching_DES_Flexible_Simple<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					keyFrom00To27,
					intSalt,
					searchMode);
			} else {*/
				CUDA_PerformSearching_DES_Flexible<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					keyFrom00To27,
					intSalt,
					searchMode);
			//}
		} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {
			/*if (numTripcodeChunk <= CUDA_SIMPLE_SEARCH_THRESHOLD) {
				CUDA_PerformSearching_DES_ForwardAndBackwardMatching_Simple<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					keyFrom00To27,
					intSalt,
					searchMode);
			} else {*/
				CUDA_PerformSearching_DES_ForwardAndBackwardMatching<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					keyFrom00To27,
					intSalt,
					searchMode);
			//}
		} else {
			/*
			if (numTripcodeChunk == 1) {
				if (searchMode == SEARCH_MODE_FORWARD_MATCHING) {
					CUDA_PerformSearching_DES_ForwardMatching_1Chunk<<<dimGrid, dimBlock>>>(
						CUDA_outputArray,
						CUDA_keyBitmap,
						CUDA_tripcodeChunkArray,
						numTripcodeChunk,
						keyFrom00To27,
						intSalt,
						searchMode);
				} else {
					CUDA_PerformSearching_DES_BackwardMatching_1Chunk<<<dimGrid, dimBlock>>>(
						CUDA_outputArray,
						CUDA_keyBitmap,
						CUDA_tripcodeChunkArray,
						numTripcodeChunk,
						keyFrom00To27,
						intSalt,
						searchMode);
				}
			} else if (numTripcodeChunk <= CUDA_SIMPLE_SEARCH_THRESHOLD) {
				CUDA_PerformSearching_DES_ForwardOrBackwardMatching_Simple<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					keyFrom00To27,
					intSalt,
					searchMode);
			} else {*/
				CUDA_PerformSearching_DES_ForwardOrBackwardMatching<<<dimGrid, dimBlock>>>(
					CUDA_outputArray,
					CUDA_keyBitmap,
					CUDA_tripcodeChunkArray,
					numTripcodeChunk,
					keyFrom00To27,
					intSalt,
					searchMode);
			//}
		}
		CUDA_ERROR(cudaGetLastError());
		// CUDA_ERROR(cudaDeviceSynchronize()); // Check errors at kernel launch.

		// Process the output array.
		CUDA_ERROR(cudaMemcpy(outputArray, CUDA_outputArray, sizeof(GPUOutput) * sizeOutputArray, cudaMemcpyDeviceToHost));
		// We can save registers this way. Not particularly safe, though.
		for (unsigned int indexOutput = 0; indexOutput < sizeOutputArray; indexOutput++){
			GPUOutput *output = &outputArray[indexOutput];
			if (output->numMatchingTripcodes > 0)
				GenerateDESTripcode(output->pair.tripcode.c, output->pair.key.c);
		}
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
