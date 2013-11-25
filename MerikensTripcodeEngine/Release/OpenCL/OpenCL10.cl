// Meriken's Tripcode Engine 1.1
// Copyright (c) 2011-2013 Meriken//XXX <meriken.2ch@gmail.com>
//
// The initial versions of this software were based on:
// CUDA SHA-1 Tripper 0.2.1
// Copyright (c) 2009 Horo/.IBXjcg
// 
// A potion of the code that deals with DES decryption is adopted from:
// John the Ripper password cracker
// Copyright (c) 1996-2002, 2005, 2010 by Solar Designer
//
// A potion of the code that deals with SHA-1 hash generation is adopted from:
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
// CONSTANTS AND TYPES                                                       //
///////////////////////////////////////////////////////////////////////////////

// 64bit unsigned long is slightly faster than 32bit unsigned int on 7970.
// The display driver becomes unresponsive with 128bit uint4.

// The following are defined in MTF_OpenCL_DES.cpp as necessary.
// #define UNROLL_MAIN_LOOP
// #define USE_UNSIGNED_LONG

typedef unsigned char BOOL;
#define TRUE  (1)
#define FALSE (0)

#define MAX_LEN_TRIPCODE            12
#define MAX_LEN_TRIPCODE_KEY        12
#define MAX_LEN_EXPANDED_PATTERN    MAX_LEN_TRIPCODE
#define SMALL_KEY_BITMAP_LEN_STRING 2
#define SMALL_KEY_BITMAP_SIZE       (64 * 64)
#define KEY_BITMAP_LEN_STRING       4
#define DES_SIZE_EXPANSION_FUNCTION 96

#ifdef USE_UNSIGNED_LONG
#define OPENCL_DES_BS_DEPTH         64
#else
#define OPENCL_DES_BS_DEPTH         32
#endif

#ifdef MAXIMIZE_KEY_SPACE

#define IS_FIRST_BYTE_SJIS(c)         \
	(   (0x81 <= (c) && (c) <= 0x84)  \
	 || (0x88 <= (c) && (c) <= 0x9f)  \
	 || (0xe0 <= (c) && (c) <= 0xea)) \

#else

#define IS_FIRST_BYTE_SJIS(c)         \
	(   (0x89 <= (c) && (c) <= 0x97)  \
	 || (0x99 <= (c) && (c) <= 0x9f)  \
 	 || (0xe0 <= (c) && (c) <= 0xe9)) \

#endif

#define IS_ONE_BYTE_KEY_CHAR(c)       \
	(   (0x21 <= (c) && (c) <= 0x24)  \
	 || (0x26 <= (c) && (c) <= 0x2a)  \
	 || (0x2d <= (c) && (c) <= 0x7e)  \
	 || (0xa1 <= (c) && (c) <= 0xdf)) \

typedef struct {
	// unsigned int length;
	unsigned char c[MAX_LEN_TRIPCODE];
} Tripcode;

typedef struct {
	// unsigned int length;
	unsigned char c[MAX_LEN_TRIPCODE_KEY];
} TripcodeKey;

typedef struct {
	Tripcode    tripcode;
	TripcodeKey key;
} TripcodeKeyPair;

typedef struct {
	unsigned char pos;
	unsigned char c[MAX_LEN_EXPANDED_PATTERN + 1];
} ExpandedPattern;

typedef struct {
	unsigned int  numGeneratedTripcodes;
	unsigned char numMatchingTripcodes;
	TripcodeKeyPair pair;
} GPUOutput;

typedef struct KeyInfo {
	unsigned char partialKeyAndRandomBytes[10];
	unsigned char expansioinFunction[DES_SIZE_EXPANSION_FUNCTION];
} KeyInfo;

typedef struct PartialKeyFrom3To6 {
	unsigned char partialKeyFrom3To6[4];
} PartialKeyFrom3To6;

__constant const char base64CharTable[64] = {
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
	'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
	'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
	'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '/',
};

__constant const char indexToCharTable[64] =
//	"./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
{
	/* 00 */ '.', '/',
	/* 02 */ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
	/* 12 */ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 
	/* 28 */ 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	/* 38 */ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
	/* 54 */ 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
};

#ifdef USE_UNSIGNED_LONG
typedef unsigned long vtype;
#else
typedef unsigned int vtype;
#endif

#define vnot(dst, a)     (dst) =  (~(a))
#define vand(dst, a, b)  (dst) =  ((a) & (b))
#define vor(dst, a, b)   (dst) =  ((a) | (b))
#define vxor(dst, a, b)  (dst) =  ((a) ^ (b))
#define vandn(dst, a, b) (dst) =  (~(b) & (a))
#define vsel(x, y, z, w) (x) = bitselect((y), (z), (w))

#define DES_NUM_BITS_IN_KEY 56

#define DES_DATA_BLOCKS_SPACE __private
#define DES_KEYS_SPACE        __private



///////////////////////////////////////////////////////////////////////////////
// DES                                                                       //
///////////////////////////////////////////////////////////////////////////////

#define s1(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
{\
	var0 = (a1); \
	var1 = (a2); \
	var2 = (a3); \
	var3 = (a4); \
	var4 = (a5); \
	var5 = (a6); \
	\
	vsel(var6, var2, var1, var4); \
	vxor(var7, var1, var2); \
	vor(var8, var0, var3); \
	vxor(var9, var7, var8); \
	vsel(var10, var4, var6, var9); \
	vxor(var11, var3, var10); \
	vxor(var12, var0, var11); \
	vsel(var0, var12, var8, var6); \
	vsel(var13, var7, var9, var4); \
	vxor(var14, var0, var13); \
	vsel(var0, var8, var12, var14); \
	vsel(var8, var11, var12, var4); \
	vsel(var15, var0, var14, var8); \
	vxor(var16, var6, var15); \
	vsel(var15, var9, var11, var0); \
	vsel(var0, var6, var9, var12); \
	vsel(var11, var4, var0, var16); \
	vxor(var4, var15, var11); \
	vsel(var15, var12, var0, var2); \
	vsel(var0, var3, var6, var16); \
	vsel(var6, var4, var15, var0); \
	vnot(var0, var6); \
	vsel(var6, var0, var4, var5); \
	vxor(out1, out1, var6); \
	vsel(var4, var0, var2, var11); \
	vsel(var0, var15, var1, var9); \
	vsel(var1, var4, var3, var0); \
	vxor(var3, var16, var1); \
	vsel(var4, var3, var12, var5); \
	vxor(out2, out2, var4); \
	vsel(var4, var8, var13, var1); \
	vsel(var6, var0, var12, var10); \
	vxor(var0, var4, var6); \
	vsel(var4, var0, var16, var5); \
	vxor(out4, out4, var4); \
	vxor(var0, var12, var3); \
	vsel(var3, var2, var0, var1); \
	vsel(var0, var3, var7, var6); \
	vsel(var1, var0, var14, var5); \
	vxor(out3, out3, var1); \
}\

#define s2(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
{\
	var0 = (a1); \
	var1 = (a2); \
	var2 = (a3); \
	var3 = (a4); \
	var4 = (a5); \
	var5 = (a6); \
	\
	vsel(var6, var0, var2, var5); \
	vsel(var7, var5, var6, var4); \
	vsel(var8, var2, var3, var7); \
	vxor(var9, var0, var8); \
	vxor(var8, var4, var5); \
	vxor(var10, var9, var8); \
	vsel(var11, var3, var9, var5); \
	vnot(var12, var11); \
	vxor(var13, var6, var12); \
	vxor(var6, var8, var13); \
	vsel(var14, var6, var10, var1); \
	vxor(out2, out2, var14); \
	vxor(var6, var3, var7); \
	vsel(var14, var9, var5, var8); \
	vsel(var15, var13, var6, var14); \
	vsel(var16, var13, var6, var4); \
	vxor(var17, var2, var6); \
	vsel(var6, var16, var17, var0); \
	vsel(var16, var9, var10, var13); \
	vsel(var9, var3, var6, var4); \
	vxor(var3, var16, var9); \
	vxor(var17, var12, var3); \
	vsel(var3, var17, var6, var1); \
	vxor(out1, out1, var3); \
	vsel(var3, var6, var17, var8); \
	vsel(var8, var10, var13, var0); \
	vsel(var0, var3, var8, var14); \
	vsel(var3, var16, var17, var6); \
	vsel(var6, var8, var2, var7); \
	vsel(var2, var3, var6, var4); \
	vsel(var3, var15, var2, var1); \
	vxor(out4, out4, var3); \
	vsel(var2, var8, var9, var5); \
	vsel(var3, var11, var0, var2); \
	vxor(var2, var6, var3); \
	vsel(var3, var0, var2, var1); \
	vxor(out3, out3, var3); \
}                      \

#define s3(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
{\
	var0 = (a1); \
	var1 = (a2); \
	var2 = (a3); \
	var3 = (a4); \
	var4 = (a5); \
	var5 = (a6); \
	\
	vsel(var6, var3, var2, var4); \
	vxor(var7, var5, var6); \
	vxor(var6, var1, var7); \
	vsel(var8, var2, var5, var6); \
	vsel(var9, var4, var2, var7); \
	vsel(var10, var4, var7, var1); \
	vsel(var11, var9, var3, var10); \
	vxor(var12, var8, var11); \
	vsel(var8, var6, var10, var3); \
	vsel(var13, var8, var12, var2); \
	vnot(var2, var13); \
	vsel(var14, var12, var2, var0); \
	vxor(out2, out2, var14); \
	vxor(var14, var9, var12); \
	vsel(var12, var1, var7, var11); \
	vsel(var11, var13, var1, var4); \
	vsel(var13, var14, var12, var11); \
	vxor(var14, var9, var2); \
	vsel(var2, var14, var8, var6); \
	vxor(var8, var12, var2); \
	vxor(var15, var11, var8); \
	vsel(var16, var3, var5, var7); \
	vsel(var7, var14, var16, var10); \
	vsel(var10, var8, var5, var14); \
	vsel(var14, var7, var11, var10); \
	vsel(var7, var14, var15, var0); \
	vxor(out1, out1, var7); \
	vsel(var7, var2, var8, var4); \
	vsel(var4, var16, var9, var3); \
	vsel(var3, var7, var14, var4); \
	vsel(var7, var6, var3, var0); \
	vxor(out4, out4, var7); \
	vsel(var3, var2, var1, var12); \
	vsel(var1, var3, var4, var5); \
	vxor(var2, var11, var1); \
	vsel(var1, var2, var13, var0); \
	vxor(out3, out3, var1); \
} \

#define s4(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
{  \
	var0 = (a1); \
	var1 = (a2); \
	var2 = (a3); \
	var3 = (a4); \
	var4 = (a5); \
	var5 = (a6); \
	\
	vsel(var6, var4, var2, var0); \
	vsel(var7, var6, var0, var3); \
	vxor(var8, var2, var7); \
	vsel(var9, var0, var8, var1); \
	vsel(var8, var2, var4, var0); \
	vxor(var10, var3, var8); \
	vsel(var11, var10, var2, var4); \
	vxor(var2, var9, var11); \
	vnot(var4, var2); \
	vsel(var9, var3, var1, var7); \
	vxor(var7, var0, var6); \
	vsel(var0, var4, var9, var7); \
	vxor(var6, var8, var0); \
	vnot(var0, var6); \
	vsel(var12, var7, var0, var3); \
	vsel(var13, var11, var10, var8); \
	vsel(var8, var4, var13, var1); \
	vxor(var11, var12, var8); \
	vsel(var8, var11, var2, var5); \
	vxor(out3, out3, var8); \
	vsel(var2, var4, var11, var5); \
	vxor(out4, out4, var2); \
	vsel(var2, var1, var3, var10); \
	vsel(var1, var9, var2, var7); \
	vxor(var2, var0, var1); \
	vxor(var1, var11, var2); \
	vsel(var2, var0, var1, var5); \
	vxor(out1, out1, var2); \
	vsel(var0, var1, var6, var5); \
	vxor(out2, out2, var0); \
} \

#define s5(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
{\
	var0 = (a1); \
	var1 = (a2); \
	var2 = (a3); \
	var3 = (a4); \
	var4 = (a5); \
	var5 = (a6); \
	\
	vsel(var6, var0, var2, var4); \
	vnot(var7, var6); \
	vsel(var8, var7, var0, var2); \
	vxor(var9, var1, var8); \
	vxor(var10, var4, var5); \
	vxor(var11, var9, var10); \
	vsel(var12, var2, var7, var1); \
	vsel(var2, var1, var11, var9); \
	vsel(var13, var5, var6, var2); \
	vsel(var14, var13, var4, var0); \
	vxor(var15, var12, var14); \
	vsel(var16, var10, var15, var9); \
	vsel(var17, var5, var0, var16); \
	vsel(var18, var2, var5, var17); \
	vxor(var2, var15, var18); \
	vsel(var19, var2, var15, var3); \
	vxor(out3, out3, var19); \
	vsel(var15, var7, var13, var16); \
	vsel(var7, var18, var6, var0); \
	vxor(var0, var15, var7); \
	vsel(var6, var0, var11, var3); \
	vxor(out2, out2, var6); \
	vsel(var6, var0, var7, var5); \
	vsel(var13, var6, var14, var1); \
	vsel(var14, var12, var1, var11); \
	vsel(var1, var13, var14, var0); \
	vsel(var16, var4, var0, var11); \
	vsel(var0, var9, var2, var15); \
	vsel(var2, var16, var0, var13); \
	vsel(var0, var18, var13, var14); \
	vsel(var4, var7, var10, var16); \
	vxor(var7, var0, var4); \
	vsel(var0, var1, var7, var3); \
	vxor(out4, out4, var0); \
	vsel(var0, var12, var8, var5); \
	vsel(var1, var9, var11, var17); \
	vsel(var4, var0, var1, var6); \
	vsel(var0, var4, var2, var3); \
	vxor(out1, out1, var0); \
} \

#define s6(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
{\
	var0 = (a1); \
	var1 = (a2); \
	var2 = (a3); \
	var3 = (a4); \
	var4 = (a5); \
	var5 = (a6); \
	\
	vsel(var6, var0, var3, var4); \
	vxor(var7, var1, var6); \
	vsel(var8, var7, var3, var2); \
	vxor(var9, var0, var8); \
	vxor(var10, var4, var9); \
	vnot(var11, var10); \
	vsel(var12, var9, var10, var3); \
	vsel(var13, var2, var3, var12); \
	vxor(var14, var7, var13); \
	vxor(var7, var10, var14); \
	vsel(var15, var3, var9, var12); \
	vxor(var12, var2, var15); \
	vsel(var15, var3, var2, var10); \
	vsel(var2, var12, var15, var14); \
	vsel(var3, var11, var15, var14); \
	vsel(var14, var4, var12, var2); \
	vsel(var16, var3, var10, var14); \
	vsel(var14, var11, var16, var5); \
	vxor(out1, out1, var14); \
	vsel(var11, var9, var16, var1); \
	vsel(var1, var0, var3, var11); \
	vxor(var0, var7, var1); \
	vsel(var9, var7, var0, var5); \
	vxor(out4, out4, var9); \
	vsel(var7, var12, var8, var10); \
	vsel(var9, var7, var15, var13); \
	vxor(var10, var0, var9); \
	vxor(var9, var6, var10); \
	vsel(var6, var4, var16, var3); \
	vsel(var3, var9, var10, var6); \
	vnot(var4, var3); \
	vsel(var3, var4, var9, var5); \
	vxor(out2, out2, var3); \
	vsel(var3, var6, var0, var10); \
	vsel(var0, var1, var7, var8); \
	vxor(var1, var3, var0); \
	vsel(var0, var2, var1, var5); \
	vxor(out3, out3, var0); \
}                      \

#define s7(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
{\
	var0 = (a1); \
	var1 = (a2); \
	var2 = (a3); \
	var3 = (a4); \
	var4 = (a5); \
	var5 = (a6); \
	\
	vsel(var6, var1, var5, var2); \
	vxor(var7, var3, var6); \
	vsel(var6, var2, var4, var1); \
	vsel(var8, var5, var1, var3); \
	vsel(var9, var6, var8, var4); \
	vxor(var6, var7, var9); \
	vxor(var10, var4, var5); \
	vxor(var11, var1, var2); \
	vsel(var12, var2, var9, var3); \
	vsel(var9, var11, var12, var7); \
	vxor(var13, var10, var9); \
	vsel(var14, var13, var6, var0); \
	vxor(out1, out1, var14); \
	vxor(var14, var1, var13); \
	vsel(var15, var14, var4, var11); \
	vsel(var16, var13, var15, var5); \
	vsel(var15, var7, var14, var5); \
	vsel(var5, var15, var11, var10); \
	vxor(var10, var8, var5); \
	vsel(var5, var7, var10, var1); \
	vnot(var1, var4); \
	vsel(var4, var1, var14, var12); \
	vxor(var1, var5, var4); \
	vsel(var7, var1, var16, var0); \
	vxor(out2, out2, var7); \
	vxor(var7, var11, var1); \
	vsel(var1, var16, var7, var5); \
	vsel(var5, var1, var6, var4); \
	vsel(var1, var5, var10, var0); \
	vxor(out3, out3, var1); \
	vsel(var1, var14, var13, var9); \
	vxor(var4, var14, var7); \
	vsel(var5, var1, var4, var3); \
	vsel(var1, var16, var6, var13); \
	vsel(var3, var5, var2, var1); \
	vnot(var1, var3); \
	vsel(var2, var5, var1, var0); \
	vxor(out4, out4, var2); \
}                     \

#define s8(a1, a2, a3, a4, a5, a6, out1, out2, out3, out4)\
{\
	var0 = (a1); \
	var1 = (a2); \
	var2 = (a3); \
	var3 = (a4); \
	var4 = (a5); \
	var5 = (a6); \
	\
	vsel(var6, var4, var0, var2); \
	vxor(var7, var3, var6); \
	vsel(var6, var2, var3, var4); \
	vsel(var8, var1, var4, var0); \
	vsel(var9, var7, var6, var8); \
	vxor(var6, var1, var9); \
	vsel(var8, var7, var3, var2); \
	vsel(var3, var4, var8, var1); \
	vsel(var10, var0, var6, var3); \
	vsel(var11, var2, var4, var1); \
	vxor(var2, var10, var11); \
	vsel(var12, var6, var4, var7); \
	vsel(var7, var12, var0, var8); \
	vxor(var8, var2, var7); \
	vsel(var12, var8, var2, var5); \
	vxor(out3, out3, var12); \
	vsel(var12, var11, var8, var4); \
	vxor(var4, var3, var12); \
	vxor(var3, var6, var4); \
	vnot(var8, var3); \
	vsel(var13, var9, var1, var12); \
	vsel(var12, var8, var13, var7); \
	vxor(var14, var4, var12); \
	vsel(var4, var14, var6, var5); \
	vxor(out2, out2, var4); \
	vsel(var4, var10, var11, var13); \
	vsel(var6, var9, var4, var2); \
	vxor(var4, var8, var6); \
	vsel(var6, var8, var4, var5); \
	vxor(out4, out4, var6); \
	vsel(var4, var9, var1, var2); \
	vor(var1, var0, var7); \
	vxor(var0, var4, var1); \
	vxor(var1, var12, var0); \
	vsel(var0, var1, var3, var5); \
	vxor(out1, out1, var0); \
}                      \



#ifndef UNROLL_MAIN_LOOP

#define x(p)                           (db[expansionFunction[p]] ^ k[keySchedule[keyScheduleIndexBase + (p)]])
#define y(p, q, keyScheduleIndexBase)  (db[p]                    ^ k[keySchedule[keyScheduleIndexBase + (q)]])
#define z(r)                          *(db + (r))

#define ROUND_A(base) \
	s1(y(EF00,  0, base), y(EF01,  1, base), y(EF02,  2, base), y(EF03,  3, base), y(EF04,  4, base), y(EF05,  5, base), z(40), z(48), z(54), z(62)); \
	s2(y(EF06,  6, base), y(EF07,  7, base), y(EF08,  8, base), y(EF09,  9, base), y(EF10, 10, base), y(EF11, 11, base), z(44), z(59), z(33), z(49)); \
	s3(y(   7, 12, base), y(   8, 13, base), y(   9, 14, base), y(  10, 15, base), y(  11, 16, base), y(  12, 17, base), z(55), z(47), z(61), z(37)); \
	s4(y(  11, 18, base), y(  12, 19, base), y(  13, 20, base), y(  14, 21, base), y(  15, 22, base), y(  16, 23, base), z(57), z(51), z(41), z(32)); \
	s5(y(EF24, 24, base), y(EF25, 25, base), y(EF26, 26, base), y(EF27, 27, base), y(EF28, 28, base), y(EF29, 29, base), z(39), z(45), z(56), z(34)); \
	s6(y(EF30, 30, base), y(EF31, 31, base), y(EF32, 32, base), y(EF33, 33, base), y(EF34, 34, base), y(EF35, 35, base), z(35), z(60), z(42), z(50)); \
	s7(y(  23, 36, base), y(  24, 37, base), y(  25, 38, base), y(  26, 39, base), y(  27, 40, base), y(  28, 41, base), z(63), z(43), z(53), z(38)); \
	s8(y(  27, 42, base), y(  28, 43, base), y(  29, 44, base), y(  30, 45, base), y(  31, 46, base), y(   0, 47, base), z(36), z(58), z(46), z(52)); \

#define ROUND_B(base) \
	s1(y(EF48, 48, base), y(EF49, 49, base), y(EF50, 50, base), y(EF51, 51, base), y(EF52, 52, base), y(EF53, 53, base), z( 8), z(16), z(22), z(30)); \
	s2(y(EF54, 54, base), y(EF55, 55, base), y(EF56, 56, base), y(EF57, 57, base), y(EF58, 58, base), y(EF59, 59, base), z(12), z(27), z( 1), z(17)); \
	s3(y(  39, 60, base), y(  40, 61, base), y(  41, 62, base), y(  42, 63, base), y(  43, 64, base), y(  44, 65, base), z(23), z(15), z(29), z( 5)); \
	s4(y(  43, 66, base), y(  44, 67, base), y(  45, 68, base), y(  46, 69, base), y(  47, 70, base), y(  48, 71, base), z(25), z(19), z( 9), z( 0)); \
	s5(y(EF72, 72, base), y(EF73, 73, base), y(EF74, 74, base), y(EF75, 75, base), y(EF76, 76, base), y(EF77, 77, base), z( 7), z(13), z(24), z( 2)); \
	s6(y(EF78, 78, base), y(EF79, 79, base), y(EF80, 80, base), y(EF81, 81, base), y(EF82, 82, base), y(EF83, 83, base), z( 3), z(28), z(10), z(18)); \
	s7(y(  55, 84, base), y(  56, 85, base), y(  57, 86, base), y(  58, 87, base), y(  59, 88, base), y(  60, 89, base), z(31), z(11), z(21), z( 6)); \
	s8(y(  59, 90, base), y(  60, 91, base), y(  61, 92, base), y(  62, 93, base), y(  63, 94, base), y(  32, 95, base), z( 4), z(26), z(14), z(20)); \

__constant const unsigned char keySchedule[0x300] = {
	12, 46, 33, 52, 48, 20, //  0
	34, 55,  5, 13, 18, 40, //  6
	 4, 32, 26, 27,	38, 54, // 12
	53,  6, 31, 25, 19, 41, // 18
	15, 24, 28, 43, 30,  3, // 24
	35, 22,  2, 44, 14, 23, // 30
	51, 16, 29, 49,  7, 17, // 36
	37,  8,  9, 50, 42, 21, // 42

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

#endif



void DES_Crypt(DES_DATA_BLOCKS_SPACE vtype *db, DES_KEYS_SPACE vtype *k)
{
	vtype var0;
	vtype var1;
	vtype var2;
	vtype var3; 
	vtype var4; 
	vtype var5; 
	vtype var6; 
	vtype var7; 
	vtype var8; 
	vtype var9; 
	vtype var10; 
	vtype var11; 
	vtype var12; 
	vtype var13; 
	vtype var14; 
	vtype var15; 
	vtype var16; 
	vtype var17; 
	vtype var18; 
	vtype var19;
	
	for (int i = 0; i < 64; ++i)
		db[i] = 0x00000000;
	
#ifdef UNROLL_MAIN_LOOP
	for (int i = 0; i < 13; ++i) {
		// ROUND_A(0);
		s1(K12XOR(db[EF00]), db[EF01] ^ k[46], db[EF02] ^ k[33], db[EF03] ^ k[52], db[EF04] ^ k[48], K20XOR(db[EF05]), db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[34], db[EF07] ^ k[55], db[EF08] ^ k[ 5], K13XOR(db[EF09]), K18XOR(db[EF10]), db[EF11] ^ k[40], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[ 4], db[   8] ^ k[32], db[   9] ^ k[26], db[  10] ^ k[27], db[  11] ^ k[38], db[  12] ^ k[54], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[53], db[  12] ^ k[ 6], db[  13] ^ k[31], db[  14] ^ k[25], K19XOR(db[  15]), db[  16] ^ k[41], db[57], db[51], db[41], db[32]);
		s5(K15XOR(db[EF24]), db[EF25] ^ k[24], db[EF26] ^ k[28], db[EF27] ^ k[43], db[EF28] ^ k[30], db[EF29] ^ k[ 3], db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[35], db[EF31] ^ k[22], db[EF32] ^ k[ 2], db[EF33] ^ k[44], K14XOR(db[EF34]), db[EF35] ^ k[23], db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[51], K16XOR(db[  24]), db[  25] ^ k[29], db[  26] ^ k[49], K07XOR(db[  27]), K17XOR(db[  28]), db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[37], K08XOR(db[  28]), K09XOR(db[  29]), db[  30] ^ k[50], db[  31] ^ k[42], db[   0] ^ k[21], db[36], db[58], db[46], db[52]);

		// ROUND_B(0);
		s1(db[EF48] ^ k[ 5], db[EF49] ^ k[39], db[EF50] ^ k[26], db[EF51] ^ k[45], db[EF52] ^ k[41], K13XOR(db[EF53]), db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[27], db[EF55] ^ k[48], db[EF56] ^ k[53], db[EF57] ^ k[ 6], K11XOR(db[EF58]), db[EF59] ^ k[33], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[52], db[  40] ^ k[25], K19XOR(db[  41]), K20XOR(db[  42]), db[  43] ^ k[31], db[  44] ^ k[47], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[46], db[  44] ^ k[54], db[  45] ^ k[55], K18XOR(db[  46]), K12XOR(db[  47]), db[  48] ^ k[34], db[25], db[19], db[ 9], db[ 0]);
		s5(K08XOR(db[EF72]), K17XOR(db[EF73]), db[EF74] ^ k[21], db[EF75] ^ k[36], db[EF76] ^ k[23], db[EF77] ^ k[49], db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[28], K15XOR(db[EF79]), db[EF80] ^ k[24], db[EF81] ^ k[37], K07XOR(db[EF82]), K16XOR(db[EF83]), db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[44], K09XOR(db[  56]), db[  57] ^ k[22], db[  58] ^ k[42], db[  59] ^ k[ 0], K10XOR(db[  60]), db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[30], db[  60] ^ k[ 1], db[  61] ^ k[ 2], db[  62] ^ k[43], db[  63] ^ k[35], K14XOR(db[  32]), db[ 4], db[26], db[14], db[20]);

		// ROUND_A(96);
		s1(db[EF00] ^ k[46], db[EF01] ^ k[25], K12XOR(db[EF02]), db[EF03] ^ k[31], db[EF04] ^ k[27], db[EF05] ^ k[54], db[40], db[48], db[54], db[62]);
		s2(K13XOR(db[EF06]), db[EF07] ^ k[34], db[EF08] ^ k[39], db[EF09] ^ k[47], db[EF10] ^ k[52], K19XOR(db[EF11]), db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[38], K11XOR(db[   8]), db[   9] ^ k[ 5], db[  10] ^ k[ 6], db[  11] ^ k[48], db[  12] ^ k[33], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[32], db[  12] ^ k[40], db[  13] ^ k[41], db[  14] ^ k[ 4], db[  15] ^ k[53], K20XOR(db[  16]), db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[51], db[EF25] ^ k[ 3], K07XOR(db[EF26]), db[EF27] ^ k[22], K09XOR(db[EF28]), db[EF29] ^ k[35], db[39], db[45], db[56], db[34]);
		s6(K14XOR(db[EF30]), db[EF31] ^ k[ 1], K10XOR(db[EF32]), db[EF33] ^ k[23], db[EF34] ^ k[50], db[EF35] ^ k[ 2], db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[30], db[  24] ^ k[24], K08XOR(db[  25]), db[  26] ^ k[28], db[  27] ^ k[43], db[  28] ^ k[49], db[63], db[43], db[53], db[38]);
		s8(K16XOR(db[  27]), db[  28] ^ k[44], K17XOR(db[  29]), db[  30] ^ k[29], db[  31] ^ k[21], db[   0] ^ k[ 0], db[36], db[58], db[46], db[52]);

		// ROUND_B(96);
		s1(db[EF48] ^ k[32], K11XOR(db[EF49]), db[EF50] ^ k[53], db[EF51] ^ k[48], K13XOR(db[EF52]), db[EF53] ^ k[40], db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[54], K20XOR(db[EF55]), db[EF56] ^ k[25], db[EF57] ^ k[33], db[EF58] ^ k[38], db[EF59] ^ k[ 5], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[55], db[  40] ^ k[52], db[  41] ^ k[46], db[  42] ^ k[47], db[  43] ^ k[34], K19XOR(db[  44]), db[23], db[15], db[29], db[ 5]);
		s4(K18XOR(db[  43]), db[  44] ^ k[26], db[  45] ^ k[27], db[  46] ^ k[45], db[  47] ^ k[39], db[  48] ^ k[ 6], db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[37], db[EF73] ^ k[42], db[EF74] ^ k[50], K08XOR(db[EF75]), db[EF76] ^ k[24], db[EF77] ^ k[21], db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[ 0], db[EF79] ^ k[44], db[EF80] ^ k[49], K09XOR(db[EF81]), db[EF82] ^ k[36], K17XOR(db[EF83]), db[ 3], db[28], db[10], db[18]);
		s7(K16XOR(db[  55]), K10XOR(db[  56]), db[  57] ^ k[51], K14XOR(db[  58]), db[  59] ^ k[29], db[  60] ^ k[35], db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[ 2], db[  60] ^ k[30], db[  61] ^ k[ 3], K15XOR(db[  62]), K07XOR(db[  63]), db[  32] ^ k[43], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(192);
		s1(K18XOR(db[EF00]), db[EF01] ^ k[52], db[EF02] ^ k[39], db[EF03] ^ k[34], db[EF04] ^ k[54], db[EF05] ^ k[26], db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[40], db[EF07] ^ k[ 6], K11XOR(db[EF08]), K19XOR(db[EF09]), db[EF10] ^ k[55], db[EF11] ^ k[46], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[41], db[   8] ^ k[38], db[   9] ^ k[32], db[  10] ^ k[33], K20XOR(db[  11]), db[  12] ^ k[ 5], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[ 4], K12XOR(db[  12]), K13XOR(db[  13]), db[  14] ^ k[31], db[  15] ^ k[25], db[  16] ^ k[47], db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[23], db[EF25] ^ k[28], db[EF26] ^ k[36], db[EF27] ^ k[51], K10XOR(db[EF28]), K07XOR(db[EF29]), db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[43], db[EF31] ^ k[30], db[EF32] ^ k[35], db[EF33] ^ k[24], db[EF34] ^ k[22], db[EF35] ^ k[ 3], db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[ 2], db[  24] ^ k[49], db[  25] ^ k[37], db[  26] ^ k[ 0], K15XOR(db[  27]), db[  28] ^ k[21], db[63], db[43], db[53], db[38]);
		s8(K17XOR(db[  27]), K16XOR(db[  28]), db[  29] ^ k[42], db[  30] ^ k[ 1], db[  31] ^ k[50], db[   0] ^ k[29], db[36], db[58], db[46], db[52]);

		// ROUND_B(192);
		s1(db[EF48] ^ k[ 4], db[EF49] ^ k[38], db[EF50] ^ k[25], K20XOR(db[EF51]), db[EF52] ^ k[40], K12XOR(db[EF53]), db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[26], db[EF55] ^ k[47], db[EF56] ^ k[52], db[EF57] ^ k[ 5], db[EF58] ^ k[41], db[EF59] ^ k[32], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[27], db[  40] ^ k[55], K18XOR(db[  41]), K19XOR(db[  42]), db[  43] ^ k[ 6], db[  44] ^ k[46], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[45], db[  44] ^ k[53], db[  45] ^ k[54], db[  46] ^ k[48], K11XOR(db[  47]), db[  48] ^ k[33], db[25], db[19], db[ 9], db[ 0]);
		s5(K09XOR(db[EF72]), K14XOR(db[EF73]), db[EF74] ^ k[22], db[EF75] ^ k[37], db[EF76] ^ k[49], db[EF77] ^ k[50], db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[29], K16XOR(db[EF79]), db[EF80] ^ k[21], K10XOR(db[EF81]), K08XOR(db[EF82]), db[EF83] ^ k[42], db[ 3], db[28], db[10], db[18]);
		s7(K17XOR(db[  55]), db[  56] ^ k[35], db[  57] ^ k[23], db[  58] ^ k[43], db[  59] ^ k[ 1], K07XOR(db[  60]), db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[ 3], db[  60] ^ k[ 2], db[  61] ^ k[28], db[  62] ^ k[44], db[  63] ^ k[36], K15XOR(db[  32]), db[ 4], db[26], db[14], db[20]);

		// ROUND_A(288);
		s1(db[EF00] ^ k[45], db[EF01] ^ k[55], K11XOR(db[EF02]), db[EF03] ^ k[ 6], db[EF04] ^ k[26], db[EF05] ^ k[53], db[40], db[48], db[54], db[62]);
		s2(K12XOR(db[EF06]), db[EF07] ^ k[33], db[EF08] ^ k[38], db[EF09] ^ k[46], db[EF10] ^ k[27], K18XOR(db[EF11]), db[44], db[59], db[33], db[49]);
		s3(K13XOR(db[   7]), db[   8] ^ k[41], db[   9] ^ k[ 4], db[  10] ^ k[ 5], db[  11] ^ k[47], db[  12] ^ k[32], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[31], db[  12] ^ k[39], db[  13] ^ k[40], db[  14] ^ k[34], db[  15] ^ k[52], K19XOR(db[  16]), db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[24], db[EF25] ^ k[ 0], K08XOR(db[EF26]), db[EF27] ^ k[23], db[EF28] ^ k[35], db[EF29] ^ k[36], db[39], db[45], db[56], db[34]);
		s6(K15XOR(db[EF30]), db[EF31] ^ k[ 2], K07XOR(db[EF32]), db[EF33] ^ k[49], db[EF34] ^ k[51], db[EF35] ^ k[28], db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[ 3], db[  24] ^ k[21], K09XOR(db[  25]), db[  26] ^ k[29], db[  27] ^ k[44], db[  28] ^ k[50], db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[42], K17XOR(db[  28]), K14XOR(db[  29]), db[  30] ^ k[30], db[  31] ^ k[22], db[   0] ^ k[ 1], db[36], db[58], db[46], db[52]);

		// ROUND_B(288);
		s1(db[EF48] ^ k[31], db[EF49] ^ k[41], db[EF50] ^ k[52], db[EF51] ^ k[47], K12XOR(db[EF52]), db[EF53] ^ k[39], db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[53], K19XOR(db[EF55]), db[EF56] ^ k[55], db[EF57] ^ k[32], K13XOR(db[EF58]), db[EF59] ^ k[ 4], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[54], db[  40] ^ k[27], db[  41] ^ k[45], db[  42] ^ k[46], db[  43] ^ k[33], K18XOR(db[  44]), db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[48], db[  44] ^ k[25], db[  45] ^ k[26], K20XOR(db[  46]), db[  47] ^ k[38], db[  48] ^ k[ 5], db[25], db[19], db[ 9], db[ 0]);
		s5(K10XOR(db[EF72]), db[EF73] ^ k[43], db[EF74] ^ k[51], K09XOR(db[EF75]), db[EF76] ^ k[21], db[EF77] ^ k[22], db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[ 1], K17XOR(db[EF79]), db[EF80] ^ k[50], db[EF81] ^ k[35], db[EF82] ^ k[37], K14XOR(db[EF83]), db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[42], K07XOR(db[  56]), db[  57] ^ k[24], K15XOR(db[  58]), db[  59] ^ k[30], db[  60] ^ k[36], db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[28], db[  60] ^ k[ 3], db[  61] ^ k[ 0], K16XOR(db[  62]), K08XOR(db[  63]), db[  32] ^ k[44], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(384);
		s1(db[EF00] ^ k[55], db[EF01] ^ k[34], db[EF02] ^ k[45], db[EF03] ^ k[40], db[EF04] ^ k[ 5], db[EF05] ^ k[32], db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[46], K12XOR(db[EF07]), db[EF08] ^ k[48], db[EF09] ^ k[25], db[EF10] ^ k[ 6], db[EF11] ^ k[52], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[47], K20XOR(db[   8]), db[   9] ^ k[38], db[  10] ^ k[39], db[  11] ^ k[26], K11XOR(db[  12]), db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[41], K18XOR(db[  12]), K19XOR(db[  13]), K13XOR(db[  14]), db[  15] ^ k[31], db[  16] ^ k[53], db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[ 3], db[EF25] ^ k[36], db[EF26] ^ k[44], db[EF27] ^ k[ 2], K14XOR(db[EF28]), K15XOR(db[EF29]), db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[51], K10XOR(db[EF31]), db[EF32] ^ k[43], db[EF33] ^ k[28], db[EF34] ^ k[30], K07XOR(db[EF35]), db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[35], db[  24] ^ k[ 0], K17XOR(db[  25]), K08XOR(db[  26]), db[  27] ^ k[23], db[  28] ^ k[29], db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[21], db[  28] ^ k[49], db[  29] ^ k[50], K09XOR(db[  30]), db[  31] ^ k[ 1], db[   0] ^ k[37], db[36], db[58], db[46], db[52]);

		// ROUND_B(384);
		s1(db[EF48] ^ k[41], K20XOR(db[EF49]), db[EF50] ^ k[31], db[EF51] ^ k[26], db[EF52] ^ k[46], K18XOR(db[EF53]), db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[32], db[EF55] ^ k[53], db[EF56] ^ k[34], K11XOR(db[EF57]), db[EF58] ^ k[47], db[EF59] ^ k[38], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[33], db[  40] ^ k[ 6], db[  41] ^ k[55], db[  42] ^ k[25], K12XOR(db[  43]), db[  44] ^ k[52], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[27], db[  44] ^ k[ 4], db[  45] ^ k[ 5], db[  46] ^ k[54], db[  47] ^ k[48], db[  48] ^ k[39], db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[42], db[EF73] ^ k[22], db[EF74] ^ k[30], K17XOR(db[EF75]), db[EF76] ^ k[ 0], db[EF77] ^ k[ 1], db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[37], db[EF79] ^ k[49], db[EF80] ^ k[29], K14XOR(db[EF81]), K16XOR(db[EF82]), db[EF83] ^ k[50], db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[21], db[  56] ^ k[43], db[  57] ^ k[ 3], db[  58] ^ k[51], K09XOR(db[  59]), K15XOR(db[  60]), db[31], db[11], db[21], db[ 6]);
		s8(K07XOR(db[  59]), db[  60] ^ k[35], db[  61] ^ k[36], db[  62] ^ k[24], db[  63] ^ k[44], db[  32] ^ k[23], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(480);
		s1(db[EF00] ^ k[27], db[EF01] ^ k[ 6], db[EF02] ^ k[48], K12XOR(db[EF03]), db[EF04] ^ k[32], db[EF05] ^ k[ 4], db[40], db[48], db[54], db[62]);
		s2(K18XOR(db[EF06]), db[EF07] ^ k[39], K20XOR(db[EF08]), db[EF09] ^ k[52], db[EF10] ^ k[33], db[EF11] ^ k[55], db[44], db[59], db[33], db[49]);
		s3(K19XOR(db[   7]), db[   8] ^ k[47], db[   9] ^ k[41], K11XOR(db[  10]), db[  11] ^ k[53], db[  12] ^ k[38], db[55], db[47], db[61], db[37]);
		s4(K13XOR(db[  11]), db[  12] ^ k[45], db[  13] ^ k[46], db[  14] ^ k[40], db[  15] ^ k[34], db[  16] ^ k[25], db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[28], K08XOR(db[EF25]), K16XOR(db[EF26]), db[EF27] ^ k[ 3], db[EF28] ^ k[43], db[EF29] ^ k[44], db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[23], db[EF31] ^ k[35], K15XOR(db[EF32]), db[EF33] ^ k[ 0], db[EF34] ^ k[ 2], db[EF35] ^ k[36], db[35], db[60], db[42], db[50]);
		s7(K07XOR(db[  23]), db[  24] ^ k[29], db[  25] ^ k[42], db[  26] ^ k[37], db[  27] ^ k[24], db[  28] ^ k[ 1], db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[50], db[  28] ^ k[21], db[  29] ^ k[22], K10XOR(db[  30]), db[  31] ^ k[30], K09XOR(db[   0]), db[36], db[58], db[46], db[52]);

		// ROUND_B(480);
		s1(K13XOR(db[EF48]), db[EF49] ^ k[47], db[EF50] ^ k[34], db[EF51] ^ k[53], K18XOR(db[EF52]), db[EF53] ^ k[45], db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[ 4], db[EF55] ^ k[25], db[EF56] ^ k[ 6], db[EF57] ^ k[38], K19XOR(db[EF58]), db[EF59] ^ k[41], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[ 5], db[  40] ^ k[33], db[  41] ^ k[27], db[  42] ^ k[52], db[  43] ^ k[39], db[  44] ^ k[55], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[54], db[  44] ^ k[31], db[  45] ^ k[32], db[  46] ^ k[26], K20XOR(db[  47]), K11XOR(db[  48]), db[25], db[19], db[ 9], db[ 0]);
		s5(K14XOR(db[EF72]), db[EF73] ^ k[51], db[EF74] ^ k[ 2], db[EF75] ^ k[42], db[EF76] ^ k[29], db[EF77] ^ k[30], db[ 7], db[13], db[24], db[ 2]);
		s6(K09XOR(db[EF78]), db[EF79] ^ k[21], db[EF80] ^ k[ 1], db[EF81] ^ k[43], K17XOR(db[EF82]), db[EF83] ^ k[22], db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[50], K15XOR(db[  56]), db[  57] ^ k[28], db[  58] ^ k[23], K10XOR(db[  59]), db[  60] ^ k[44], db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[36], K07XOR(db[  60]), K08XOR(db[  61]), db[  62] ^ k[49], K16XOR(db[  63]), db[  32] ^ k[24], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(576);
		s1(db[EF00] ^ k[54], db[EF01] ^ k[33], K20XOR(db[EF02]), db[EF03] ^ k[39], db[EF04] ^ k[ 4], db[EF05] ^ k[31], db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[45], K11XOR(db[EF07]), db[EF08] ^ k[47], db[EF09] ^ k[55], db[EF10] ^ k[ 5], db[EF11] ^ k[27], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[46], K19XOR(db[   8]), K13XOR(db[   9]), db[  10] ^ k[38], db[  11] ^ k[25], db[  12] ^ k[41], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[40], db[  12] ^ k[48], K18XOR(db[  13]), K12XOR(db[  14]), db[  15] ^ k[ 6], db[  16] ^ k[52], db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[ 0], db[EF25] ^ k[37], K17XOR(db[EF26]), db[EF27] ^ k[28], K15XOR(db[EF28]), K16XOR(db[EF29]), db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[24], K07XOR(db[EF31]), db[EF32] ^ k[44], db[EF33] ^ k[29], db[EF34] ^ k[ 3], K08XOR(db[EF35]), db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[36], db[  24] ^ k[ 1], K14XOR(db[  25]), K09XOR(db[  26]), db[  27] ^ k[49], db[  28] ^ k[30], db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[22], db[  28] ^ k[50], db[  29] ^ k[51], db[  30] ^ k[35], db[  31] ^ k[ 2], K10XOR(db[   0]), db[36], db[58], db[46], db[52]);

		// ROUND_B(576);
		s1(db[EF48] ^ k[40], K19XOR(db[EF49]), db[EF50] ^ k[ 6], db[EF51] ^ k[25], db[EF52] ^ k[45], db[EF53] ^ k[48], db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[31], db[EF55] ^ k[52], db[EF56] ^ k[33], db[EF57] ^ k[41], db[EF58] ^ k[46], K13XOR(db[EF59]), db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[32], db[  40] ^ k[ 5], db[  41] ^ k[54], db[  42] ^ k[55], K11XOR(db[  43]), db[  44] ^ k[27], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[26], db[  44] ^ k[34], db[  45] ^ k[ 4], db[  46] ^ k[53], db[  47] ^ k[47], db[  48] ^ k[38], db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[43], db[EF73] ^ k[23], db[EF74] ^ k[ 3], K14XOR(db[EF75]), db[EF76] ^ k[ 1], db[EF77] ^ k[ 2], db[ 7], db[13], db[24], db[ 2]);
		s6(K10XOR(db[EF78]), db[EF79] ^ k[50], db[EF80] ^ k[30], K15XOR(db[EF81]), db[EF82] ^ k[42], db[EF83] ^ k[51], db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[22], db[  56] ^ k[44], db[  57] ^ k[ 0], db[  58] ^ k[24], db[  59] ^ k[35], K16XOR(db[  60]), db[31], db[11], db[21], db[ 6]);
		s8(K08XOR(db[  59]), db[  60] ^ k[36], db[  61] ^ k[37], db[  62] ^ k[21], K17XOR(db[  63]), db[  32] ^ k[49], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(672);
		s1(db[EF00] ^ k[26], db[EF01] ^ k[ 5], db[EF02] ^ k[47], K11XOR(db[EF03]), db[EF04] ^ k[31], db[EF05] ^ k[34], db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[48], db[EF07] ^ k[38], K19XOR(db[EF08]), db[EF09] ^ k[27], db[EF10] ^ k[32], db[EF11] ^ k[54], db[44], db[59], db[33], db[49]);
		s3(K18XOR(db[   7]), db[   8] ^ k[46], db[   9] ^ k[40], db[  10] ^ k[41], db[  11] ^ k[52], K13XOR(db[  12]), db[55], db[47], db[61], db[37]);
		s4(K12XOR(db[  11]), K20XOR(db[  12]), db[  13] ^ k[45], db[  14] ^ k[39], db[  15] ^ k[33], db[  16] ^ k[55], db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[29], K09XOR(db[EF25]), db[EF26] ^ k[42], db[EF27] ^ k[ 0], db[EF28] ^ k[44], K17XOR(db[EF29]), db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[49], db[EF31] ^ k[36], K16XOR(db[EF32]), db[EF33] ^ k[ 1], db[EF34] ^ k[28], db[EF35] ^ k[37], db[35], db[60], db[42], db[50]);
		s7(K08XOR(db[  23]), db[  24] ^ k[30], db[  25] ^ k[43], K10XOR(db[  26]), db[  27] ^ k[21], db[  28] ^ k[ 2], db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[51], db[  28] ^ k[22], db[  29] ^ k[23], K07XOR(db[  30]), db[  31] ^ k[ 3], db[   0] ^ k[35], db[36], db[58], db[46], db[52]);

		// ROUND_B(672);
		s1(K19XOR(db[EF48]), db[EF49] ^ k[53], db[EF50] ^ k[40], db[EF51] ^ k[ 4], db[EF52] ^ k[55], db[EF53] ^ k[27], db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[41], db[EF55] ^ k[31], K12XOR(db[EF56]), K20XOR(db[EF57]), db[EF58] ^ k[25], db[EF59] ^ k[47], db[12], db[27], db[ 1], db[17]);
		s3(K11XOR(db[  39]), db[  40] ^ k[39], db[  41] ^ k[33], db[  42] ^ k[34], db[  43] ^ k[45], db[  44] ^ k[ 6], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[ 5], K13XOR(db[  44]), db[  45] ^ k[38], db[  46] ^ k[32], db[  47] ^ k[26], db[  48] ^ k[48], db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[22], db[EF73] ^ k[ 2], db[EF74] ^ k[35], db[EF75] ^ k[50], db[EF76] ^ k[37], K10XOR(db[EF77]), db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[42], db[EF79] ^ k[29], K09XOR(db[EF80]), db[EF81] ^ k[51], db[EF82] ^ k[21], db[EF83] ^ k[30], db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[ 1], db[  56] ^ k[23], db[  57] ^ k[36], db[  58] ^ k[ 3], K14XOR(db[  59]), db[  60] ^ k[24], db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[44], K15XOR(db[  60]), K16XOR(db[  61]), db[  62] ^ k[ 0], db[  63] ^ k[49], db[  32] ^ k[28], db[ 4], db[26], db[14], db[20]);

		if (i >= 12)
			break;

		// ROUND_B(-48);
		s1(K12XOR(db[EF48]), db[EF49] ^ k[46], db[EF50] ^ k[33], db[EF51] ^ k[52], db[EF52] ^ k[48], K20XOR(db[EF53]), db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[34], db[EF55] ^ k[55], db[EF56] ^ k[ 5], K13XOR(db[EF57]), K18XOR(db[EF58]), db[EF59] ^ k[40], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[ 4], db[  40] ^ k[32], db[  41] ^ k[26], db[  42] ^ k[27], db[  43] ^ k[38], db[  44] ^ k[54], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[53], db[  44] ^ k[ 6], db[  45] ^ k[31], db[  46] ^ k[25], K19XOR(db[  47]), db[  48] ^ k[41], db[25], db[19], db[ 9], db[ 0]);
		s5(K15XOR(db[EF72]), db[EF73] ^ k[24], db[EF74] ^ k[28], db[EF75] ^ k[43], db[EF76] ^ k[30], db[EF77] ^ k[ 3], db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[35], db[EF79] ^ k[22], db[EF80] ^ k[ 2], db[EF81] ^ k[44], K14XOR(db[EF82]), db[EF83] ^ k[23], db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[51], K16XOR(db[  56]), db[  57] ^ k[29], db[  58] ^ k[49], K07XOR(db[  59]), K17XOR(db[  60]), db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[37], K08XOR(db[  60]), K09XOR(db[  61]), db[  62] ^ k[50], db[  63] ^ k[42], db[  32] ^ k[21], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(48);
		s1(db[EF00] ^ k[ 5], db[EF01] ^ k[39], db[EF02] ^ k[26], db[EF03] ^ k[45], db[EF04] ^ k[41], K13XOR(db[EF05]), db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[27], db[EF07] ^ k[48], db[EF08] ^ k[53], db[EF09] ^ k[ 6], K11XOR(db[EF10]), db[EF11] ^ k[33], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[52], db[   8] ^ k[25], K19XOR(db[   9]), K20XOR(db[  10]), db[  11] ^ k[31], db[  12] ^ k[47], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[46], db[  12] ^ k[54], db[  13] ^ k[55], K18XOR(db[  14]), K12XOR(db[  15]), db[  16] ^ k[34], db[57], db[51], db[41], db[32]);
		s5(K08XOR(db[EF24]), K17XOR(db[EF25]), db[EF26] ^ k[21], db[EF27] ^ k[36], db[EF28] ^ k[23], db[EF29] ^ k[49], db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[28], K15XOR(db[EF31]), db[EF32] ^ k[24], db[EF33] ^ k[37], K07XOR(db[EF34]), K16XOR(db[EF35]), db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[44], K09XOR(db[  24]), db[  25] ^ k[22], db[  26] ^ k[42], db[  27] ^ k[ 0], K10XOR(db[  28]), db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[30], db[  28] ^ k[ 1], db[  29] ^ k[ 2], db[  30] ^ k[43], db[  31] ^ k[35], K14XOR(db[   0]), db[36], db[58], db[46], db[52]);

		// ROUND_B(48);
		s1(db[EF48] ^ k[46], db[EF49] ^ k[25], K12XOR(db[EF50]), db[EF51] ^ k[31], db[EF52] ^ k[27], db[EF53] ^ k[54], db[ 8], db[16], db[22], db[30]);
		s2(K13XOR(db[EF54]), db[EF55] ^ k[34], db[EF56] ^ k[39], db[EF57] ^ k[47], db[EF58] ^ k[52], K19XOR(db[EF59]), db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[38], K11XOR(db[  40]), db[  41] ^ k[ 5], db[  42] ^ k[ 6], db[  43] ^ k[48], db[  44] ^ k[33], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[32], db[  44] ^ k[40], db[  45] ^ k[41], db[  46] ^ k[ 4], db[  47] ^ k[53], K20XOR(db[  48]), db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[51], db[EF73] ^ k[ 3], K07XOR(db[EF74]), db[EF75] ^ k[22], K09XOR(db[EF76]), db[EF77] ^ k[35], db[ 7], db[13], db[24], db[ 2]);
		s6(K14XOR(db[EF78]), db[EF79] ^ k[ 1], K10XOR(db[EF80]), db[EF81] ^ k[23], db[EF82] ^ k[50], db[EF83] ^ k[ 2], db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[30], db[  56] ^ k[24], K08XOR(db[  57]), db[  58] ^ k[28], db[  59] ^ k[43], db[  60] ^ k[49], db[31], db[11], db[21], db[ 6]);
		s8(K16XOR(db[  59]), db[  60] ^ k[44], K17XOR(db[  61]), db[  62] ^ k[29], db[  63] ^ k[21], db[  32] ^ k[ 0], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(144);
		s1(db[EF00] ^ k[32], K11XOR(db[EF01]), db[EF02] ^ k[53], db[EF03] ^ k[48], K13XOR(db[EF04]), db[EF05] ^ k[40], db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[54], K20XOR(db[EF07]), db[EF08] ^ k[25], db[EF09] ^ k[33], db[EF10] ^ k[38], db[EF11] ^ k[ 5], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[55], db[   8] ^ k[52], db[   9] ^ k[46], db[  10] ^ k[47], db[  11] ^ k[34], K19XOR(db[  12]), db[55], db[47], db[61], db[37]);
		s4(K18XOR(db[  11]), db[  12] ^ k[26], db[  13] ^ k[27], db[  14] ^ k[45], db[  15] ^ k[39], db[  16] ^ k[ 6], db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[37], db[EF25] ^ k[42], db[EF26] ^ k[50], K08XOR(db[EF27]), db[EF28] ^ k[24], db[EF29] ^ k[21], db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[ 0], db[EF31] ^ k[44], db[EF32] ^ k[49], K09XOR(db[EF33]), db[EF34] ^ k[36], K17XOR(db[EF35]), db[35], db[60], db[42], db[50]);
		s7(K16XOR(db[  23]), K10XOR(db[  24]), db[  25] ^ k[51], K14XOR(db[  26]), db[  27] ^ k[29], db[  28] ^ k[35], db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[ 2], db[  28] ^ k[30], db[  29] ^ k[ 3], K15XOR(db[  30]), K07XOR(db[  31]), db[   0] ^ k[43], db[36], db[58], db[46], db[52]);

		// ROUND_B(144);
		s1(K18XOR(db[EF48]), db[EF49] ^ k[52], db[EF50] ^ k[39], db[EF51] ^ k[34], db[EF52] ^ k[54], db[EF53] ^ k[26], db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[40], db[EF55] ^ k[ 6], K11XOR(db[EF56]), K19XOR(db[EF57]), db[EF58] ^ k[55], db[EF59] ^ k[46], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[41], db[  40] ^ k[38], db[  41] ^ k[32], db[  42] ^ k[33], K20XOR(db[  43]), db[  44] ^ k[ 5], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[ 4], K12XOR(db[  44]), K13XOR(db[  45]), db[  46] ^ k[31], db[  47] ^ k[25], db[  48] ^ k[47], db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[23], db[EF73] ^ k[28], db[EF74] ^ k[36], db[EF75] ^ k[51], K10XOR(db[EF76]), K07XOR(db[EF77]), db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[43], db[EF79] ^ k[30], db[EF80] ^ k[35], db[EF81] ^ k[24], db[EF82] ^ k[22], db[EF83] ^ k[ 3], db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[ 2], db[  56] ^ k[49], db[  57] ^ k[37], db[  58] ^ k[ 0], K15XOR(db[  59]), db[  60] ^ k[21], db[31], db[11], db[21], db[ 6]);
		s8(K17XOR(db[  59]), K16XOR(db[  60]), db[  61] ^ k[42], db[  62] ^ k[ 1], db[  63] ^ k[50], db[  32] ^ k[29], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(240);
		s1(db[EF00] ^ k[ 4], db[EF01] ^ k[38], db[EF02] ^ k[25], K20XOR(db[EF03]), db[EF04] ^ k[40], K12XOR(db[EF05]), db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[26], db[EF07] ^ k[47], db[EF08] ^ k[52], db[EF09] ^ k[ 5], db[EF10] ^ k[41], db[EF11] ^ k[32], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[27], db[   8] ^ k[55], K18XOR(db[   9]), K19XOR(db[  10]), db[  11] ^ k[ 6], db[  12] ^ k[46], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[45], db[  12] ^ k[53], db[  13] ^ k[54], db[  14] ^ k[48], K11XOR(db[  15]), db[  16] ^ k[33], db[57], db[51], db[41], db[32]);
		s5(K09XOR(db[EF24]), K14XOR(db[EF25]), db[EF26] ^ k[22], db[EF27] ^ k[37], db[EF28] ^ k[49], db[EF29] ^ k[50], db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[29], K16XOR(db[EF31]), db[EF32] ^ k[21], K10XOR(db[EF33]), K08XOR(db[EF34]), db[EF35] ^ k[42], db[35], db[60], db[42], db[50]);
		s7(K17XOR(db[  23]), db[  24] ^ k[35], db[  25] ^ k[23], db[  26] ^ k[43], db[  27] ^ k[ 1], K07XOR(db[  28]), db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[ 3], db[  28] ^ k[ 2], db[  29] ^ k[28], db[  30] ^ k[44], db[  31] ^ k[36], K15XOR(db[   0]), db[36], db[58], db[46], db[52]);

		// ROUND_B(240);
		s1(db[EF48] ^ k[45], db[EF49] ^ k[55], K11XOR(db[EF50]), db[EF51] ^ k[ 6], db[EF52] ^ k[26], db[EF53] ^ k[53], db[ 8], db[16], db[22], db[30]);
		s2(K12XOR(db[EF54]), db[EF55] ^ k[33], db[EF56] ^ k[38], db[EF57] ^ k[46], db[EF58] ^ k[27], K18XOR(db[EF59]), db[12], db[27], db[ 1], db[17]);
		s3(K13XOR(db[  39]), db[  40] ^ k[41], db[  41] ^ k[ 4], db[  42] ^ k[ 5], db[  43] ^ k[47], db[  44] ^ k[32], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[31], db[  44] ^ k[39], db[  45] ^ k[40], db[  46] ^ k[34], db[  47] ^ k[52], K19XOR(db[  48]), db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[24], db[EF73] ^ k[ 0], K08XOR(db[EF74]), db[EF75] ^ k[23], db[EF76] ^ k[35], db[EF77] ^ k[36], db[ 7], db[13], db[24], db[ 2]);
		s6(K15XOR(db[EF78]), db[EF79] ^ k[ 2], K07XOR(db[EF80]), db[EF81] ^ k[49], db[EF82] ^ k[51], db[EF83] ^ k[28], db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[ 3], db[  56] ^ k[21], K09XOR(db[  57]), db[  58] ^ k[29], db[  59] ^ k[44], db[  60] ^ k[50], db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[42], K17XOR(db[  60]), K14XOR(db[  61]), db[  62] ^ k[30], db[  63] ^ k[22], db[  32] ^ k[ 1], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(336);
		s1(db[EF00] ^ k[31], db[EF01] ^ k[41], db[EF02] ^ k[52], db[EF03] ^ k[47], K12XOR(db[EF04]), db[EF05] ^ k[39], db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[53], K19XOR(db[EF07]), db[EF08] ^ k[55], db[EF09] ^ k[32], K13XOR(db[EF10]), db[EF11] ^ k[ 4], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[54], db[   8] ^ k[27], db[   9] ^ k[45], db[  10] ^ k[46], db[  11] ^ k[33], K18XOR(db[  12]), db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[48], db[  12] ^ k[25], db[  13] ^ k[26], K20XOR(db[  14]), db[  15] ^ k[38], db[  16] ^ k[ 5], db[57], db[51], db[41], db[32]);
		s5(K10XOR(db[EF24]), db[EF25] ^ k[43], db[EF26] ^ k[51], K09XOR(db[EF27]), db[EF28] ^ k[21], db[EF29] ^ k[22], db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[ 1], K17XOR(db[EF31]), db[EF32] ^ k[50], db[EF33] ^ k[35], db[EF34] ^ k[37], K14XOR(db[EF35]), db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[42], K07XOR(db[  24]), db[  25] ^ k[24], K15XOR(db[  26]), db[  27] ^ k[30], db[  28] ^ k[36], db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[28], db[  28] ^ k[ 3], db[  29] ^ k[ 0], K16XOR(db[  30]), K08XOR(db[  31]), db[   0] ^ k[44], db[36], db[58], db[46], db[52]);

		// ROUND_B(336);
		s1(db[EF48] ^ k[55], db[EF49] ^ k[34], db[EF50] ^ k[45], db[EF51] ^ k[40], db[EF52] ^ k[ 5], db[EF53] ^ k[32], db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[46], K12XOR(db[EF55]), db[EF56] ^ k[48], db[EF57] ^ k[25], db[EF58] ^ k[ 6], db[EF59] ^ k[52], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[47], K20XOR(db[  40]), db[  41] ^ k[38], db[  42] ^ k[39], db[  43] ^ k[26], K11XOR(db[  44]), db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[41], K18XOR(db[  44]), K19XOR(db[  45]), K13XOR(db[  46]), db[  47] ^ k[31], db[  48] ^ k[53], db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[ 3], db[EF73] ^ k[36], db[EF74] ^ k[44], db[EF75] ^ k[ 2], K14XOR(db[EF76]), K15XOR(db[EF77]), db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[51], K10XOR(db[EF79]), db[EF80] ^ k[43], db[EF81] ^ k[28], db[EF82] ^ k[30], K07XOR(db[EF83]), db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[35], db[  56] ^ k[ 0], K17XOR(db[  57]), K08XOR(db[  58]), db[  59] ^ k[23], db[  60] ^ k[29], db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[21], db[  60] ^ k[49], db[  61] ^ k[50], K09XOR(db[  62]), db[  63] ^ k[ 1], db[  32] ^ k[37], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(432);
		s1(db[EF00] ^ k[41], K20XOR(db[EF01]), db[EF02] ^ k[31], db[EF03] ^ k[26], db[EF04] ^ k[46], K18XOR(db[EF05]), db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[32], db[EF07] ^ k[53], db[EF08] ^ k[34], K11XOR(db[EF09]), db[EF10] ^ k[47], db[EF11] ^ k[38], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[33], db[   8] ^ k[ 6], db[   9] ^ k[55], db[  10] ^ k[25], K12XOR(db[  11]), db[  12] ^ k[52], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[27], db[  12] ^ k[ 4], db[  13] ^ k[ 5], db[  14] ^ k[54], db[  15] ^ k[48], db[  16] ^ k[39], db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[42], db[EF25] ^ k[22], db[EF26] ^ k[30], K17XOR(db[EF27]), db[EF28] ^ k[ 0], db[EF29] ^ k[ 1], db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[37], db[EF31] ^ k[49], db[EF32] ^ k[29], K14XOR(db[EF33]), K16XOR(db[EF34]), db[EF35] ^ k[50], db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[21], db[  24] ^ k[43], db[  25] ^ k[ 3], db[  26] ^ k[51], K09XOR(db[  27]), K15XOR(db[  28]), db[63], db[43], db[53], db[38]);
		s8(K07XOR(db[  27]), db[  28] ^ k[35], db[  29] ^ k[36], db[  30] ^ k[24], db[  31] ^ k[44], db[   0] ^ k[23], db[36], db[58], db[46], db[52]);

		// ROUND_B(432);
		s1(db[EF48] ^ k[27], db[EF49] ^ k[ 6], db[EF50] ^ k[48], K12XOR(db[EF51]), db[EF52] ^ k[32], db[EF53] ^ k[ 4], db[ 8], db[16], db[22], db[30]);
		s2(K18XOR(db[EF54]), db[EF55] ^ k[39], K20XOR(db[EF56]), db[EF57] ^ k[52], db[EF58] ^ k[33], db[EF59] ^ k[55], db[12], db[27], db[ 1], db[17]);
		s3(K19XOR(db[  39]), db[  40] ^ k[47], db[  41] ^ k[41], K11XOR(db[  42]), db[  43] ^ k[53], db[  44] ^ k[38], db[23], db[15], db[29], db[ 5]);
		s4(K13XOR(db[  43]), db[  44] ^ k[45], db[  45] ^ k[46], db[  46] ^ k[40], db[  47] ^ k[34], db[  48] ^ k[25], db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[28], K08XOR(db[EF73]), K16XOR(db[EF74]), db[EF75] ^ k[ 3], db[EF76] ^ k[43], db[EF77] ^ k[44], db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[23], db[EF79] ^ k[35], K15XOR(db[EF80]), db[EF81] ^ k[ 0], db[EF82] ^ k[ 2], db[EF83] ^ k[36], db[ 3], db[28], db[10], db[18]);
		s7(K07XOR(db[  55]), db[  56] ^ k[29], db[  57] ^ k[42], db[  58] ^ k[37], db[  59] ^ k[24], db[  60] ^ k[ 1], db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[50], db[  60] ^ k[21], db[  61] ^ k[22], K10XOR(db[  62]), db[  63] ^ k[30], K09XOR(db[  32]), db[ 4], db[26], db[14], db[20]);

		// ROUND_A(528);
		s1(K13XOR(db[EF00]), db[EF01] ^ k[47], db[EF02] ^ k[34], db[EF03] ^ k[53], K18XOR(db[EF04]), db[EF05] ^ k[45], db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[ 4], db[EF07] ^ k[25], db[EF08] ^ k[ 6], db[EF09] ^ k[38], K19XOR(db[EF10]), db[EF11] ^ k[41], db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[ 5], db[   8] ^ k[33], db[   9] ^ k[27], db[  10] ^ k[52], db[  11] ^ k[39], db[  12] ^ k[55], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[54], db[  12] ^ k[31], db[  13] ^ k[32], db[  14] ^ k[26], K20XOR(db[  15]), K11XOR(db[  16]), db[57], db[51], db[41], db[32]);
		s5(K14XOR(db[EF24]), db[EF25] ^ k[51], db[EF26] ^ k[ 2], db[EF27] ^ k[42], db[EF28] ^ k[29], db[EF29] ^ k[30], db[39], db[45], db[56], db[34]);
		s6(K09XOR(db[EF30]), db[EF31] ^ k[21], db[EF32] ^ k[ 1], db[EF33] ^ k[43], K17XOR(db[EF34]), db[EF35] ^ k[22], db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[50], K15XOR(db[  24]), db[  25] ^ k[28], db[  26] ^ k[23], K10XOR(db[  27]), db[  28] ^ k[44], db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[36], K07XOR(db[  28]), K08XOR(db[  29]), db[  30] ^ k[49], K16XOR(db[  31]), db[   0] ^ k[24], db[36], db[58], db[46], db[52]);

		// ROUND_B(528);
		s1(db[EF48] ^ k[54], db[EF49] ^ k[33], K20XOR(db[EF50]), db[EF51] ^ k[39], db[EF52] ^ k[ 4], db[EF53] ^ k[31], db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[45], K11XOR(db[EF55]), db[EF56] ^ k[47], db[EF57] ^ k[55], db[EF58] ^ k[ 5], db[EF59] ^ k[27], db[12], db[27], db[ 1], db[17]);
		s3(db[  39] ^ k[46], K19XOR(db[  40]), K13XOR(db[  41]), db[  42] ^ k[38], db[  43] ^ k[25], db[  44] ^ k[41], db[23], db[15], db[29], db[ 5]);
		s4(db[  43] ^ k[40], db[  44] ^ k[48], K18XOR(db[  45]), K12XOR(db[  46]), db[  47] ^ k[ 6], db[  48] ^ k[52], db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[ 0], db[EF73] ^ k[37], K17XOR(db[EF74]), db[EF75] ^ k[28], K15XOR(db[EF76]), K16XOR(db[EF77]), db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[24], K07XOR(db[EF79]), db[EF80] ^ k[44], db[EF81] ^ k[29], db[EF82] ^ k[ 3], K08XOR(db[EF83]), db[ 3], db[28], db[10], db[18]);
		s7(db[  55] ^ k[36], db[  56] ^ k[ 1], K14XOR(db[  57]), K09XOR(db[  58]), db[  59] ^ k[49], db[  60] ^ k[30], db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[22], db[  60] ^ k[50], db[  61] ^ k[51], db[  62] ^ k[35], db[  63] ^ k[ 2], K10XOR(db[  32]), db[ 4], db[26], db[14], db[20]);

		// ROUND_A(624);
		s1(db[EF00] ^ k[40], K19XOR(db[EF01]), db[EF02] ^ k[ 6], db[EF03] ^ k[25], db[EF04] ^ k[45], db[EF05] ^ k[48], db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[31], db[EF07] ^ k[52], db[EF08] ^ k[33], db[EF09] ^ k[41], db[EF10] ^ k[46], K13XOR(db[EF11]), db[44], db[59], db[33], db[49]);
		s3(db[   7] ^ k[32], db[   8] ^ k[ 5], db[   9] ^ k[54], db[  10] ^ k[55], K11XOR(db[  11]), db[  12] ^ k[27], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[26], db[  12] ^ k[34], db[  13] ^ k[ 4], db[  14] ^ k[53], db[  15] ^ k[47], db[  16] ^ k[38], db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[43], db[EF25] ^ k[23], db[EF26] ^ k[ 3], K14XOR(db[EF27]), db[EF28] ^ k[ 1], db[EF29] ^ k[ 2], db[39], db[45], db[56], db[34]);
		s6(K10XOR(db[EF30]), db[EF31] ^ k[50], db[EF32] ^ k[30], K15XOR(db[EF33]), db[EF34] ^ k[42], db[EF35] ^ k[51], db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[22], db[  24] ^ k[44], db[  25] ^ k[ 0], db[  26] ^ k[24], db[  27] ^ k[35], K16XOR(db[  28]), db[63], db[43], db[53], db[38]);
		s8(K08XOR(db[  27]), db[  28] ^ k[36], db[  29] ^ k[37], db[  30] ^ k[21], K17XOR(db[  31]), db[   0] ^ k[49], db[36], db[58], db[46], db[52]);

		// ROUND_B(624);
		s1(db[EF48] ^ k[26], db[EF49] ^ k[ 5], db[EF50] ^ k[47], K11XOR(db[EF51]), db[EF52] ^ k[31], db[EF53] ^ k[34], db[ 8], db[16], db[22], db[30]);
		s2(db[EF54] ^ k[48], db[EF55] ^ k[38], K19XOR(db[EF56]), db[EF57] ^ k[27], db[EF58] ^ k[32], db[EF59] ^ k[54], db[12], db[27], db[ 1], db[17]);
		s3(K18XOR(db[  39]), db[  40] ^ k[46], db[  41] ^ k[40], db[  42] ^ k[41], db[  43] ^ k[52], K13XOR(db[  44]), db[23], db[15], db[29], db[ 5]);
		s4(K12XOR(db[  43]), K20XOR(db[  44]), db[  45] ^ k[45], db[  46] ^ k[39], db[  47] ^ k[33], db[  48] ^ k[55], db[25], db[19], db[ 9], db[ 0]);
		s5(db[EF72] ^ k[29], K09XOR(db[EF73]), db[EF74] ^ k[42], db[EF75] ^ k[ 0], db[EF76] ^ k[44], K17XOR(db[EF77]), db[ 7], db[13], db[24], db[ 2]);
		s6(db[EF78] ^ k[49], db[EF79] ^ k[36], K16XOR(db[EF80]), db[EF81] ^ k[ 1], db[EF82] ^ k[28], db[EF83] ^ k[37], db[ 3], db[28], db[10], db[18]);
		s7(K08XOR(db[  55]), db[  56] ^ k[30], db[  57] ^ k[43], K10XOR(db[  58]), db[  59] ^ k[21], db[  60] ^ k[ 2], db[31], db[11], db[21], db[ 6]);
		s8(db[  59] ^ k[51], db[  60] ^ k[22], db[  61] ^ k[23], K07XOR(db[  62]), db[  63] ^ k[ 3], db[  32] ^ k[35], db[ 4], db[26], db[14], db[20]);

		// ROUND_A(720);
		s1(K19XOR(db[EF00]), db[EF01] ^ k[53], db[EF02] ^ k[40], db[EF03] ^ k[ 4], db[EF04] ^ k[55], db[EF05] ^ k[27], db[40], db[48], db[54], db[62]);
		s2(db[EF06] ^ k[41], db[EF07] ^ k[31], K12XOR(db[EF08]), K20XOR(db[EF09]), db[EF10] ^ k[25], db[EF11] ^ k[47], db[44], db[59], db[33], db[49]);
		s3(K11XOR(db[   7]), db[   8] ^ k[39], db[   9] ^ k[33], db[  10] ^ k[34], db[  11] ^ k[45], db[  12] ^ k[ 6], db[55], db[47], db[61], db[37]);
		s4(db[  11] ^ k[ 5], K13XOR(db[  12]), db[  13] ^ k[38], db[  14] ^ k[32], db[  15] ^ k[26], db[  16] ^ k[48], db[57], db[51], db[41], db[32]);
		s5(db[EF24] ^ k[22], db[EF25] ^ k[ 2], db[EF26] ^ k[35], db[EF27] ^ k[50], db[EF28] ^ k[37], K10XOR(db[EF29]), db[39], db[45], db[56], db[34]);
		s6(db[EF30] ^ k[42], db[EF31] ^ k[29], K09XOR(db[EF32]), db[EF33] ^ k[51], db[EF34] ^ k[21], db[EF35] ^ k[30], db[35], db[60], db[42], db[50]);
		s7(db[  23] ^ k[ 1], db[  24] ^ k[23], db[  25] ^ k[36], db[  26] ^ k[ 3], K14XOR(db[  27]), db[  28] ^ k[24], db[63], db[43], db[53], db[38]);
		s8(db[  27] ^ k[44], K15XOR(db[  28]), K16XOR(db[  29]), db[  30] ^ k[ 0], db[  31] ^ k[49], db[   0] ^ k[28], db[36], db[58], db[46], db[52]);
	}
#else
	int iterations           = 25;
	int roundsAndSwapped     = 8; 
	int keyScheduleIndexBase = 0;

start:
	ROUND_A(keyScheduleIndexBase);

	if (roundsAndSwapped == 0x100)
		goto next;

swap:
	ROUND_B(keyScheduleIndexBase);

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
#endif
}

#ifdef USE_UNSIGNED_LONG

#define GET_TRIPCODE_CHAR_INDEX(r, t, i0, i1, i2, i3, i4, i5, pos)          \
	(  ((((r)[i0] & (0x1L << (t))) ? (0x1L) : (0x0)) << (5 + ((pos) * 6)))  \
	 | ((((r)[i1] & (0x1L << (t))) ? (0x1L) : (0x0)) << (4 + ((pos) * 6)))  \
	 | ((((r)[i2] & (0x1L << (t))) ? (0x1L) : (0x0)) << (3 + ((pos) * 6)))  \
	 | ((((r)[i3] & (0x1L << (t))) ? (0x1L) : (0x0)) << (2 + ((pos) * 6)))  \
	 | ((((r)[i4] & (0x1L << (t))) ? (0x1L) : (0x0)) << (1 + ((pos) * 6)))  \
	 | ((((r)[i5] & (0x1L << (t))) ? (0x1L) : (0x0)) << (0 + ((pos) * 6)))) \

#define GET_TRIPCODE_CHAR_INDEX_LAST(r, t, i0, i1, i2, i3)  \
	(  ((((r)[i0] & (0x1L << (t))) ? (0x1L) : (0x0)) << 5)  \
	 | ((((r)[i1] & (0x1L << (t))) ? (0x1L) : (0x0)) << 4)  \
	 | ((((r)[i2] & (0x1L << (t))) ? (0x1L) : (0x0)) << 3)  \
	 | ((((r)[i3] & (0x1L << (t))) ? (0x1L) : (0x0)) << 2)) \

#define SET_ALL_BITS_FOR_KEY(i, j, k)     \
	if (key[j] & (0x1 << (k)))            \
		DES_keys[i] = 0xffffffffffffffffL \
		
#define SET_BIT_FOR_KEY(i, j, k)             \
	if (key[j] & (0x1L << (k)))              \
		DES_keys[i] |= 0x1L << tripcodeIndex \

#else

#define GET_TRIPCODE_CHAR_INDEX(r, t, i0, i1, i2, i3, i4, i5, pos)         \
	(  ((((r)[i0] & (0x01 << (t))) ? (0x1) : (0x0)) << (5 + ((pos) * 6)))  \
	 | ((((r)[i1] & (0x01 << (t))) ? (0x1) : (0x0)) << (4 + ((pos) * 6)))  \
	 | ((((r)[i2] & (0x01 << (t))) ? (0x1) : (0x0)) << (3 + ((pos) * 6)))  \
	 | ((((r)[i3] & (0x01 << (t))) ? (0x1) : (0x0)) << (2 + ((pos) * 6)))  \
	 | ((((r)[i4] & (0x01 << (t))) ? (0x1) : (0x0)) << (1 + ((pos) * 6)))  \
	 | ((((r)[i5] & (0x01 << (t))) ? (0x1) : (0x0)) << (0 + ((pos) * 6)))) \

#define GET_TRIPCODE_CHAR_INDEX_LAST(r, t, i0, i1, i2, i3) \
	(  ((((r)[i0] & (0x01 << (t))) ? (0x1) : (0x0)) << 5)  \
	 | ((((r)[i1] & (0x01 << (t))) ? (0x1) : (0x0)) << 4)  \
	 | ((((r)[i2] & (0x01 << (t))) ? (0x1) : (0x0)) << 3)  \
	 | ((((r)[i3] & (0x01 << (t))) ? (0x1) : (0x0)) << 2)) \

#define SET_ALL_BITS_FOR_KEY(i, j, k) \
	if (key[j] & (0x1 << (k)))        \
		DES_keys[i] = 0xffffffff      \
		
#define SET_BIT_FOR_KEY(i, j, k)            \
	if (key[j] & (0x1 << (k)))              \
		DES_keys[i] |= 0x1 << tripcodeIndex \

#endif

void DES_GetTripcode(DES_DATA_BLOCKS_SPACE vtype *DES_dataBlocks, int tripcodeIndex, __global unsigned char *tripcode)
{
	// Perform the final permutation as necessary.
  	tripcode[0] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 0)];
  	tripcode[1] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 0)];
  	tripcode[2] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 0)];
  	tripcode[3] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 0)];
  	tripcode[4] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0)];
  	tripcode[5] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 0)];
  	tripcode[6] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 0)];
  	tripcode[7] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 0)];
  	tripcode[8] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 0)];
	tripcode[9] = indexToCharTable[GET_TRIPCODE_CHAR_INDEX_LAST(DES_dataBlocks, tripcodeIndex, 48, 16, 56, 24)];
}

#define SET_KEY_CHAR(var, flag, table, value)   \
	if (!(flag)) {                              \
		var = (table)[(value)];                 \
		isSecondByte = IS_FIRST_BYTE_SJIS(var); \
	} else {                                    \
		var = keyCharTable_SecondByte[(value)]; \
		isSecondByte = FALSE;                   \
	}                                           \
		
#define OPENCL_DES_DEFINE_SEARCH_FUNCTION(functionName)                                                    \
	__kernel void functionName(                                                                            \
		__global   GPUOutput                * const outputArray,                                           \
		__constant KeyInfo                  *       keyInfo,                                               \
		__global   const unsigned int       * const tripcodeChunkArray,                                    \
				   const unsigned int               numTripcodeChunk,                                      \
 		__constant const unsigned char      * const keyCharTable_OneByte,                                  \
		__constant const unsigned char      * const keyCharTable_FirstByte,                                \
		__constant const unsigned char      * const keyCharTable_SecondByte,                               \
 		__constant const unsigned char      * const smallKeyBitmap,                                        \
 		__global   const unsigned char      * const keyBitmap,                                             \
		__global   const PartialKeyFrom3To6 * const partialKeyFrom3To6Array                                \
	) {                                                                                                    \
		__global              GPUOutput     *output = &outputArray[get_global_id(0)];                      \
		__private             unsigned char  key[8];                                                       \
							  unsigned char  tripcodeIndex;                                                \
		DES_DATA_BLOCKS_SPACE vtype          DES_dataBlocks[64];                                           \
		DES_KEYS_SPACE        vtype          DES_keys[DES_NUM_BITS_IN_KEY];                                \
		__global unsigned char *partialKeyFrom3To6 = partialKeyFrom3To6Array[get_global_id(0)].partialKeyFrom3To6; \
		                                                                                                   \
		output->numMatchingTripcodes = 0;                                                                  \
		                                                                                                   \
		for (int i = 0; i < DES_NUM_BITS_IN_KEY; ++i)                                                      \
			DES_keys[i] = 0x0;                                                                             \
			                                                                                               \
		key[0] = keyInfo->partialKeyAndRandomBytes[0];                                                     \
		SET_ALL_BITS_FOR_KEY( 0, 0, 0);                                                                    \
		SET_ALL_BITS_FOR_KEY( 1, 0, 1);                                                                    \
		SET_ALL_BITS_FOR_KEY( 2, 0, 2);                                                                    \
		SET_ALL_BITS_FOR_KEY( 3, 0, 3);                                                                    \
		SET_ALL_BITS_FOR_KEY( 4, 0, 4);                                                                    \
		SET_ALL_BITS_FOR_KEY( 5, 0, 5);                                                                    \
		SET_ALL_BITS_FOR_KEY( 6, 0, 6);                                                                    \
	                                                                                                       \
		key[1] = keyInfo->partialKeyAndRandomBytes[1];                                                     \
		SET_ALL_BITS_FOR_KEY( 7, 1, 0);                                                                    \
		SET_ALL_BITS_FOR_KEY( 8, 1, 1);                                                                    \
		SET_ALL_BITS_FOR_KEY( 9, 1, 2);                                                                    \
		SET_ALL_BITS_FOR_KEY(10, 1, 3);                                                                    \
		SET_ALL_BITS_FOR_KEY(11, 1, 4);                                                                    \
		SET_ALL_BITS_FOR_KEY(12, 1, 5);                                                                    \
		SET_ALL_BITS_FOR_KEY(13, 1, 6);                                                                    \
		                                                                                                   \
		key[2] = keyInfo->partialKeyAndRandomBytes[2];                                                     \
		SET_ALL_BITS_FOR_KEY(14, 2, 0);                                                                    \
		SET_ALL_BITS_FOR_KEY(15, 2, 1);                                                                    \
		SET_ALL_BITS_FOR_KEY(16, 2, 2);                                                                    \
		SET_ALL_BITS_FOR_KEY(17, 2, 3);                                                                    \
		SET_ALL_BITS_FOR_KEY(18, 2, 4);                                                                    \
		SET_ALL_BITS_FOR_KEY(19, 2, 5);                                                                    \
		SET_ALL_BITS_FOR_KEY(20, 2, 6);                                                                    \
		                                                                                                   \
		key[3] = partialKeyFrom3To6[0];                                                                    \
		SET_ALL_BITS_FOR_KEY(21, 3, 0);                                                                    \
		SET_ALL_BITS_FOR_KEY(22, 3, 1);                                                                    \
		SET_ALL_BITS_FOR_KEY(23, 3, 2);                                                                    \
		SET_ALL_BITS_FOR_KEY(24, 3, 3);                                                                    \
		SET_ALL_BITS_FOR_KEY(25, 3, 4);                                                                    \
		SET_ALL_BITS_FOR_KEY(26, 3, 5);                                                                    \
		SET_ALL_BITS_FOR_KEY(27, 3, 6);                                                                    \
		                                                                                                   \
		key[4] = partialKeyFrom3To6[1];                                                                    \
		SET_ALL_BITS_FOR_KEY(28, 4, 0);                                                                    \
		SET_ALL_BITS_FOR_KEY(29, 4, 1);                                                                    \
		SET_ALL_BITS_FOR_KEY(30, 4, 2);                                                                    \
		SET_ALL_BITS_FOR_KEY(31, 4, 3);                                                                    \
		SET_ALL_BITS_FOR_KEY(32, 4, 4);                                                                    \
		SET_ALL_BITS_FOR_KEY(33, 4, 5);                                                                    \
		SET_ALL_BITS_FOR_KEY(34, 4, 6);                                                                    \
	                                                                                                       \
		key[5] = partialKeyFrom3To6[2];                                                                    \
		SET_ALL_BITS_FOR_KEY(35, 5, 0);                                                                    \
		SET_ALL_BITS_FOR_KEY(36, 5, 1);                                                                    \
		SET_ALL_BITS_FOR_KEY(37, 5, 2);                                                                    \
		SET_ALL_BITS_FOR_KEY(38, 5, 3);                                                                    \
		SET_ALL_BITS_FOR_KEY(39, 5, 4);                                                                    \
		SET_ALL_BITS_FOR_KEY(40, 5, 5);                                                                    \
		SET_ALL_BITS_FOR_KEY(41, 5, 6);                                                                    \
		                                                                                                   \
		key[6] = partialKeyFrom3To6[3];                                                                    \
		SET_ALL_BITS_FOR_KEY(42, 6, 0);                                                                    \
		SET_ALL_BITS_FOR_KEY(43, 6, 1);                                                                    \
		SET_ALL_BITS_FOR_KEY(44, 6, 2);                                                                    \
		SET_ALL_BITS_FOR_KEY(45, 6, 3);                                                                    \
		SET_ALL_BITS_FOR_KEY(46, 6, 4);                                                                    \
		SET_ALL_BITS_FOR_KEY(47, 6, 5);                                                                    \
		SET_ALL_BITS_FOR_KEY(48, 6, 6);                                                                    \
		                                                                                                   \
		for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {                    \
			key[7] = keyCharTable_FirstByte[keyInfo->partialKeyAndRandomBytes[7] + (tripcodeIndex & 63)];  \
			SET_BIT_FOR_KEY(49, 7, 0);                                                                     \
			SET_BIT_FOR_KEY(50, 7, 1);                                                                     \
			SET_BIT_FOR_KEY(51, 7, 2);                                                                     \
			SET_BIT_FOR_KEY(52, 7, 3);                                                                     \
			SET_BIT_FOR_KEY(53, 7, 4);                                                                     \
			SET_BIT_FOR_KEY(54, 7, 5);                                                                     \
			SET_BIT_FOR_KEY(55, 7, 6);                                                                     \
		}                                                                                                  \
		                                                                                                   \
		DES_Crypt(DES_dataBlocks, DES_keys);                                                               \
		                                                                                                   \
		BOOL found = FALSE;                                                                                \

#define OPENCL_DES_END_OF_SEAERCH_FUNCTION                                                                             \
	quit_loops:                                                                                                        \
		if (found == TRUE) {                                                                                           \
			output->numMatchingTripcodes = 1;                                                                          \
			DES_GetTripcode(DES_dataBlocks, tripcodeIndex, output->pair.tripcode.c);                                   \
			output->pair.key.c[0] = key[0];                                                                            \
			output->pair.key.c[1] = key[1];                                                                            \
			output->pair.key.c[2] = key[2];                                                                            \
			output->pair.key.c[3] = key[3];                                                                            \
			output->pair.key.c[4] = key[4];                                                                            \
			output->pair.key.c[5] = key[5];                                                                            \
			output->pair.key.c[6] = key[6];                                                                            \
			output->pair.key.c[7] = keyCharTable_FirstByte[keyInfo->partialKeyAndRandomBytes[7] + (tripcodeIndex & 63)]; \
		}                                                                                                              \
		output->numGeneratedTripcodes = OPENCL_DES_BS_DEPTH;                                                           \
	}                                                                                                                  \



#define OPENCL_DES_USE_SMALL_KEY_BITMAP                                           \
	if (smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]) \
		continue;                                                                 \

#define OPENCL_DES_USE_KEY_BITMAP                                                 \
	if (keyBitmap[tripcodeChunk >> ((5 - KEY_BITMAP_LEN_STRING) * 6)])            \
		continue;                                                                 \

#define OPENCL_DES_PERFORM_LINEAR_SEARCH                                          \
	for (int j = 0; j < numTripcodeChunk; ++j) {                                  \
		if (tripcodeChunkArray[j] == tripcodeChunk) {                             \
			found = TRUE;                                                         \
			goto quit_loops;                                                      \
		}                                                                         \
	}                                                                             \

#define OPENCL_DES_PERFORM_BINARY_SEARCH                                    \
	int lower = 0, upper = numTripcodeChunk - 1, middle = lower;            \
	while (tripcodeChunk != tripcodeChunkArray[middle] && lower <= upper) { \
		middle = (lower + upper) >> 1;                                      \
		if (tripcodeChunk > tripcodeChunkArray[middle]) {                   \
			lower = middle + 1;                                             \
		} else {                                                            \
			upper = middle - 1;                                             \
		}                                                                   \
	}                                                                       \
	if (tripcodeChunk == tripcodeChunkArray[middle]) {                      \
		found = TRUE;                                                       \
		goto quit_loops;                                                    \
	}                                                                       \



OPENCL_DES_DEFINE_SEARCH_FUNCTION(OpenCL_DES_PerformSearching_ForwardMatching_1Chunk)
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		if (GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 0) != ((tripcodeChunkArray[0] >> (6 * 4)) & 0x3f)) continue;
		if (GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 0) != ((tripcodeChunkArray[0] >> (6 * 3)) & 0x3f)) continue;
		if (GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 0) != ((tripcodeChunkArray[0] >> (6 * 2)) & 0x3f)) continue;
		if (GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 0) != ((tripcodeChunkArray[0] >> (6 * 1)) & 0x3f)) continue;
		if (GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0) != ((tripcodeChunkArray[0] >> (6 * 0)) & 0x3f)) continue;
		found = TRUE;
		goto quit_loops;
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

OPENCL_DES_DEFINE_SEARCH_FUNCTION(OpenCL_DES_PerformSearching_ForwardMatching_Simple)
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		OPENCL_DES_USE_SMALL_KEY_BITMAP
		OPENCL_DES_PERFORM_LINEAR_SEARCH
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

OPENCL_DES_DEFINE_SEARCH_FUNCTION(OpenCL_DES_PerformSearching_ForwardMatching)
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		OPENCL_DES_USE_SMALL_KEY_BITMAP
		OPENCL_DES_USE_KEY_BITMAP
		OPENCL_DES_PERFORM_BINARY_SEARCH
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

OPENCL_DES_DEFINE_SEARCH_FUNCTION(OpenCL_DES_PerformSearching_BackwardMatching_Simple)
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 4)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 3)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 2)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 1)
		                             | GET_TRIPCODE_CHAR_INDEX_LAST(DES_dataBlocks, tripcodeIndex, 48, 16, 56, 24);
		OPENCL_DES_USE_SMALL_KEY_BITMAP
		OPENCL_DES_PERFORM_LINEAR_SEARCH
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

OPENCL_DES_DEFINE_SEARCH_FUNCTION(OpenCL_DES_PerformSearching_BackwardMatching)
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 4)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 3)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 2)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 1)
		                             | GET_TRIPCODE_CHAR_INDEX_LAST(DES_dataBlocks, tripcodeIndex, 48, 16, 56, 24);
		OPENCL_DES_USE_SMALL_KEY_BITMAP
		OPENCL_DES_USE_KEY_BITMAP
		OPENCL_DES_PERFORM_BINARY_SEARCH
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

OPENCL_DES_DEFINE_SEARCH_FUNCTION(OpenCL_DES_PerformSearching_ForwardAndBackwardMatching_Simple)
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		OPENCL_DES_USE_SMALL_KEY_BITMAP
		OPENCL_DES_PERFORM_LINEAR_SEARCH
	}
	
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 4)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 3)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 2)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 1)
		                             | GET_TRIPCODE_CHAR_INDEX_LAST(DES_dataBlocks, tripcodeIndex, 48, 16, 56, 24);
		OPENCL_DES_USE_SMALL_KEY_BITMAP
		OPENCL_DES_PERFORM_LINEAR_SEARCH
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

OPENCL_DES_DEFINE_SEARCH_FUNCTION(OpenCL_DES_PerformSearching_ForwardAndBackwardMatching)
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		OPENCL_DES_USE_SMALL_KEY_BITMAP
		OPENCL_DES_USE_KEY_BITMAP
		OPENCL_DES_PERFORM_BINARY_SEARCH
	}
	
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 4)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 3)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 2)
		                             | GET_TRIPCODE_CHAR_INDEX     (DES_dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 1)
		                             | GET_TRIPCODE_CHAR_INDEX_LAST(DES_dataBlocks, tripcodeIndex, 48, 16, 56, 24);
		OPENCL_DES_USE_SMALL_KEY_BITMAP
		OPENCL_DES_USE_KEY_BITMAP
		OPENCL_DES_PERFORM_BINARY_SEARCH
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

OPENCL_DES_DEFINE_SEARCH_FUNCTION(OpenCL_DES_PerformSearching_Flexible_Simple)
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		if (!smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]) { OPENCL_DES_PERFORM_LINEAR_SEARCH }

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 0);
		if (!smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]) { OPENCL_DES_PERFORM_LINEAR_SEARCH }

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 0);
		if (!smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]) { OPENCL_DES_PERFORM_LINEAR_SEARCH }

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 0);
		if (!smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]) { OPENCL_DES_PERFORM_LINEAR_SEARCH }

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 0);
		if (!smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]) { OPENCL_DES_PERFORM_LINEAR_SEARCH }

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX_LAST(DES_dataBlocks, tripcodeIndex, 48, 16, 56, 24);
		if (!smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]) { OPENCL_DES_PERFORM_LINEAR_SEARCH }
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

OPENCL_DES_DEFINE_SEARCH_FUNCTION(OpenCL_DES_PerformSearching_Flexible)
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		if (   !smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]
		    && !     keyBitmap[tripcodeChunk >> ((5 -       KEY_BITMAP_LEN_STRING) * 6)]) {
			OPENCL_DES_PERFORM_BINARY_SEARCH
		}

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 0);
		if (   !smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]
		    && !     keyBitmap[tripcodeChunk >> ((5 -       KEY_BITMAP_LEN_STRING) * 6)]) {
			OPENCL_DES_PERFORM_BINARY_SEARCH
		}

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 0);
		if (   !smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]
		    && !     keyBitmap[tripcodeChunk >> ((5 -       KEY_BITMAP_LEN_STRING) * 6)]) {
			OPENCL_DES_PERFORM_BINARY_SEARCH
		}

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 0);
		if (   !smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]
		    && !     keyBitmap[tripcodeChunk >> ((5 -       KEY_BITMAP_LEN_STRING) * 6)]) {
			OPENCL_DES_PERFORM_BINARY_SEARCH
		}

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 0);
		if (   !smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]
		    && !     keyBitmap[tripcodeChunk >> ((5 -       KEY_BITMAP_LEN_STRING) * 6)]) {
			OPENCL_DES_PERFORM_BINARY_SEARCH
		}

		tripcodeChunk = ((tripcodeChunk << 6) & 0x3fffffff) | GET_TRIPCODE_CHAR_INDEX_LAST(DES_dataBlocks, tripcodeIndex, 48, 16, 56, 24);
		if (   !smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]
		    && !     keyBitmap[tripcodeChunk >> ((5 -       KEY_BITMAP_LEN_STRING) * 6)]) {
			OPENCL_DES_PERFORM_BINARY_SEARCH
		}
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION
