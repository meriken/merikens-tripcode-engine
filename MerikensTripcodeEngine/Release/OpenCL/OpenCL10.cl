// Meriken's Tripcode Engine 1.1.2
// Copyright (c) 2011-2014 Meriken//XXX <meriken.2ch@gmail.com>
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
#define OPENCL_DES_BS_DEPTH         32

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

typedef unsigned int vtype;

#define vnot(dst, a)     (dst) =  (~(a))
#define vand(dst, a, b)  (dst) =  ((a) & (b))
#define vor(dst, a, b)   (dst) =  ((a) | (b))
#define vxor(dst, a, b)  (dst) =  ((a) ^ (b))
#define vandn(dst, a, b) (dst) =  (~(b) & (a))
#define vsel(x, y, z, w) (x) = bitselect((y), (z), (w))

#define DES_NUM_BITS_IN_KEY 56

#define DES_DATA_BLOCKS_SPACE __private
#define DES_KEYS_SPACE        __local



///////////////////////////////////////////////////////////////////////////////
// DES                                                                       //
///////////////////////////////////////////////////////////////////////////////

void s1(vtype var0, vtype var1, vtype var2, vtype var3, vtype var4, vtype var5, DES_DATA_BLOCKS_SPACE vtype *out1, DES_DATA_BLOCKS_SPACE vtype *out2, DES_DATA_BLOCKS_SPACE vtype *out3, DES_DATA_BLOCKS_SPACE vtype *out4)
{
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
	
	vsel(var6, var2, var1, var4); 
	vxor(var7, var1, var2); 
	vor(var8, var0, var3); 
	vxor(var9, var7, var8); 
	vsel(var10, var4, var6, var9); 
	vxor(var11, var3, var10); 
	vxor(var12, var0, var11); 
	vsel(var0, var12, var8, var6); 
	vsel(var13, var7, var9, var4); 
	vxor(var14, var0, var13); 
	vsel(var0, var8, var12, var14); 
	vsel(var8, var11, var12, var4); 
	vsel(var15, var0, var14, var8); 
	vxor(var16, var6, var15); 
	vsel(var15, var9, var11, var0); 
	vsel(var0, var6, var9, var12); 
	vsel(var11, var4, var0, var16); 
	vxor(var4, var15, var11); 
	vsel(var15, var12, var0, var2); 
	vsel(var0, var3, var6, var16); 
	vsel(var6, var4, var15, var0); 
	vnot(var0, var6); 
	vsel(var6, var0, var4, var5); 
	vxor(*out1, *out1, var6); 
	vsel(var4, var0, var2, var11); 
	vsel(var0, var15, var1, var9); 
	vsel(var1, var4, var3, var0); 
	vxor(var3, var16, var1); 
	vsel(var4, var3, var12, var5); 
	vxor(*out2, *out2, var4); 
	vsel(var4, var8, var13, var1); 
	vsel(var6, var0, var12, var10); 
	vxor(var0, var4, var6); 
	vsel(var4, var0, var16, var5); 
	vxor(*out4, *out4, var4); 
	vxor(var0, var12, var3); 
	vsel(var3, var2, var0, var1); 
	vsel(var0, var3, var7, var6); 
	vsel(var1, var0, var14, var5); 
	vxor(*out3, *out3, var1); 
}

void s2(vtype var0, vtype var1, vtype var2, vtype var3, vtype var4, vtype var5, DES_DATA_BLOCKS_SPACE vtype *out1, DES_DATA_BLOCKS_SPACE vtype *out2, DES_DATA_BLOCKS_SPACE vtype *out3, DES_DATA_BLOCKS_SPACE vtype *out4)
{
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

	vsel(var6, var0, var2, var5); 
	vsel(var7, var5, var6, var4); 
	vsel(var8, var2, var3, var7); 
	vxor(var9, var0, var8); 
	vxor(var8, var4, var5); 
	vxor(var10, var9, var8); 
	vsel(var11, var3, var9, var5); 
	vnot(var12, var11); 
	vxor(var13, var6, var12); 
	vxor(var6, var8, var13); 
	vsel(var14, var6, var10, var1); 
	vxor(*out2, *out2, var14); 
	vxor(var6, var3, var7); 
	vsel(var14, var9, var5, var8); 
	vsel(var15, var13, var6, var14); 
	vsel(var16, var13, var6, var4); 
	vxor(var17, var2, var6); 
	vsel(var6, var16, var17, var0); 
	vsel(var16, var9, var10, var13); 
	vsel(var9, var3, var6, var4); 
	vxor(var3, var16, var9); 
	vxor(var17, var12, var3); 
	vsel(var3, var17, var6, var1); 
	vxor(*out1, *out1, var3); 
	vsel(var3, var6, var17, var8); 
	vsel(var8, var10, var13, var0); 
	vsel(var0, var3, var8, var14); 
	vsel(var3, var16, var17, var6); 
	vsel(var6, var8, var2, var7); 
	vsel(var2, var3, var6, var4); 
	vsel(var3, var15, var2, var1); 
	vxor(*out4, *out4, var3); 
	vsel(var2, var8, var9, var5); 
	vsel(var3, var11, var0, var2); 
	vxor(var2, var6, var3); 
	vsel(var3, var0, var2, var1); 
	vxor(*out3, *out3, var3); 
}                      

void s3(vtype var0, vtype var1, vtype var2, vtype var3, vtype var4, vtype var5, DES_DATA_BLOCKS_SPACE vtype *out1, DES_DATA_BLOCKS_SPACE vtype *out2, DES_DATA_BLOCKS_SPACE vtype *out3, DES_DATA_BLOCKS_SPACE vtype *out4)
{
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

	vsel(var6, var3, var2, var4); 
	vxor(var7, var5, var6); 
	vxor(var6, var1, var7); 
	vsel(var8, var2, var5, var6); 
	vsel(var9, var4, var2, var7); 
	vsel(var10, var4, var7, var1); 
	vsel(var11, var9, var3, var10); 
	vxor(var12, var8, var11); 
	vsel(var8, var6, var10, var3); 
	vsel(var13, var8, var12, var2); 
	vnot(var2, var13); 
	vsel(var14, var12, var2, var0); 
	vxor(*out2, *out2, var14); 
	vxor(var14, var9, var12); 
	vsel(var12, var1, var7, var11); 
	vsel(var11, var13, var1, var4); 
	vsel(var13, var14, var12, var11); 
	vxor(var14, var9, var2); 
	vsel(var2, var14, var8, var6); 
	vxor(var8, var12, var2); 
	vxor(var15, var11, var8); 
	vsel(var16, var3, var5, var7); 
	vsel(var7, var14, var16, var10); 
	vsel(var10, var8, var5, var14); 
	vsel(var14, var7, var11, var10); 
	vsel(var7, var14, var15, var0); 
	vxor(*out1, *out1, var7); 
	vsel(var7, var2, var8, var4); 
	vsel(var4, var16, var9, var3); 
	vsel(var3, var7, var14, var4); 
	vsel(var7, var6, var3, var0); 
	vxor(*out4, *out4, var7); 
	vsel(var3, var2, var1, var12); 
	vsel(var1, var3, var4, var5); 
	vxor(var2, var11, var1); 
	vsel(var1, var2, var13, var0); 
	vxor(*out3, *out3, var1); 
} 

void s4(vtype var0, vtype var1, vtype var2, vtype var3, vtype var4, vtype var5, DES_DATA_BLOCKS_SPACE vtype *out1, DES_DATA_BLOCKS_SPACE vtype *out2, DES_DATA_BLOCKS_SPACE vtype *out3, DES_DATA_BLOCKS_SPACE vtype *out4)
{
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
	
	vsel(var6, var4, var2, var0); 
	vsel(var7, var6, var0, var3); 
	vxor(var8, var2, var7); 
	vsel(var9, var0, var8, var1); 
	vsel(var8, var2, var4, var0); 
	vxor(var10, var3, var8); 
	vsel(var11, var10, var2, var4); 
	vxor(var2, var9, var11); 
	vnot(var4, var2); 
	vsel(var9, var3, var1, var7); 
	vxor(var7, var0, var6); 
	vsel(var0, var4, var9, var7); 
	vxor(var6, var8, var0); 
	vnot(var0, var6); 
	vsel(var12, var7, var0, var3); 
	vsel(var13, var11, var10, var8); 
	vsel(var8, var4, var13, var1); 
	vxor(var11, var12, var8); 
	vsel(var8, var11, var2, var5); 
	vxor(*out3, *out3, var8); 
	vsel(var2, var4, var11, var5); 
	vxor(*out4, *out4, var2); 
	vsel(var2, var1, var3, var10); 
	vsel(var1, var9, var2, var7); 
	vxor(var2, var0, var1); 
	vxor(var1, var11, var2); 
	vsel(var2, var0, var1, var5); 
	vxor(*out1, *out1, var2); 
	vsel(var0, var1, var6, var5); 
	vxor(*out2, *out2, var0); 
} 

void s5(vtype var0, vtype var1, vtype var2, vtype var3, vtype var4, vtype var5, DES_DATA_BLOCKS_SPACE vtype *out1, DES_DATA_BLOCKS_SPACE vtype *out2, DES_DATA_BLOCKS_SPACE vtype *out3, DES_DATA_BLOCKS_SPACE vtype *out4)
{
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
	
	vsel(var6, var0, var2, var4); 
	vnot(var7, var6); 
	vsel(var8, var7, var0, var2); 
	vxor(var9, var1, var8); 
	vxor(var10, var4, var5); 
	vxor(var11, var9, var10); 
	vsel(var12, var2, var7, var1); 
	vsel(var2, var1, var11, var9); 
	vsel(var13, var5, var6, var2); 
	vsel(var14, var13, var4, var0); 
	vxor(var15, var12, var14); 
	vsel(var16, var10, var15, var9); 
	vsel(var17, var5, var0, var16); 
	vsel(var18, var2, var5, var17); 
	vxor(var2, var15, var18); 
	vsel(var19, var2, var15, var3); 
	vxor(*out3, *out3, var19); 
	vsel(var15, var7, var13, var16); 
	vsel(var7, var18, var6, var0); 
	vxor(var0, var15, var7); 
	vsel(var6, var0, var11, var3); 
	vxor(*out2, *out2, var6); 
	vsel(var6, var0, var7, var5); 
	vsel(var13, var6, var14, var1); 
	vsel(var14, var12, var1, var11); 
	vsel(var1, var13, var14, var0); 
	vsel(var16, var4, var0, var11); 
	vsel(var0, var9, var2, var15); 
	vsel(var2, var16, var0, var13); 
	vsel(var0, var18, var13, var14); 
	vsel(var4, var7, var10, var16); 
	vxor(var7, var0, var4); 
	vsel(var0, var1, var7, var3); 
	vxor(*out4, *out4, var0); 
	vsel(var0, var12, var8, var5); 
	vsel(var1, var9, var11, var17); 
	vsel(var4, var0, var1, var6); 
	vsel(var0, var4, var2, var3); 
	vxor(*out1, *out1, var0); 
} 

void s6(vtype var0, vtype var1, vtype var2, vtype var3, vtype var4, vtype var5, DES_DATA_BLOCKS_SPACE vtype *out1, DES_DATA_BLOCKS_SPACE vtype *out2, DES_DATA_BLOCKS_SPACE vtype *out3, DES_DATA_BLOCKS_SPACE vtype *out4)
{
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
	
	vsel(var6, var0, var3, var4); 
	vxor(var7, var1, var6); 
	vsel(var8, var7, var3, var2); 
	vxor(var9, var0, var8); 
	vxor(var10, var4, var9); 
	vnot(var11, var10); 
	vsel(var12, var9, var10, var3); 
	vsel(var13, var2, var3, var12); 
	vxor(var14, var7, var13); 
	vxor(var7, var10, var14); 
	vsel(var15, var3, var9, var12); 
	vxor(var12, var2, var15); 
	vsel(var15, var3, var2, var10); 
	vsel(var2, var12, var15, var14); 
	vsel(var3, var11, var15, var14); 
	vsel(var14, var4, var12, var2); 
	vsel(var16, var3, var10, var14); 
	vsel(var14, var11, var16, var5); 
	vxor(*out1, *out1, var14); 
	vsel(var11, var9, var16, var1); 
	vsel(var1, var0, var3, var11); 
	vxor(var0, var7, var1); 
	vsel(var9, var7, var0, var5); 
	vxor(*out4, *out4, var9); 
	vsel(var7, var12, var8, var10); 
	vsel(var9, var7, var15, var13); 
	vxor(var10, var0, var9); 
	vxor(var9, var6, var10); 
	vsel(var6, var4, var16, var3); 
	vsel(var3, var9, var10, var6); 
	vnot(var4, var3); 
	vsel(var3, var4, var9, var5); 
	vxor(*out2, *out2, var3); 
	vsel(var3, var6, var0, var10); 
	vsel(var0, var1, var7, var8); 
	vxor(var1, var3, var0); 
	vsel(var0, var2, var1, var5); 
	vxor(*out3, *out3, var0); 
}                      

void s7(vtype var0, vtype var1, vtype var2, vtype var3, vtype var4, vtype var5, DES_DATA_BLOCKS_SPACE vtype *out1, DES_DATA_BLOCKS_SPACE vtype *out2, DES_DATA_BLOCKS_SPACE vtype *out3, DES_DATA_BLOCKS_SPACE vtype *out4)
{
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
	
	vsel(var6, var1, var5, var2); 
	vxor(var7, var3, var6); 
	vsel(var6, var2, var4, var1); 
	vsel(var8, var5, var1, var3); 
	vsel(var9, var6, var8, var4); 
	vxor(var6, var7, var9); 
	vxor(var10, var4, var5); 
	vxor(var11, var1, var2); 
	vsel(var12, var2, var9, var3); 
	vsel(var9, var11, var12, var7); 
	vxor(var13, var10, var9); 
	vsel(var14, var13, var6, var0); 
	vxor(*out1, *out1, var14); 
	vxor(var14, var1, var13); 
	vsel(var15, var14, var4, var11); 
	vsel(var16, var13, var15, var5); 
	vsel(var15, var7, var14, var5); 
	vsel(var5, var15, var11, var10); 
	vxor(var10, var8, var5); 
	vsel(var5, var7, var10, var1); 
	vnot(var1, var4); 
	vsel(var4, var1, var14, var12); 
	vxor(var1, var5, var4); 
	vsel(var7, var1, var16, var0); 
	vxor(*out2, *out2, var7); 
	vxor(var7, var11, var1); 
	vsel(var1, var16, var7, var5); 
	vsel(var5, var1, var6, var4); 
	vsel(var1, var5, var10, var0); 
	vxor(*out3, *out3, var1); 
	vsel(var1, var14, var13, var9); 
	vxor(var4, var14, var7); 
	vsel(var5, var1, var4, var3); 
	vsel(var1, var16, var6, var13); 
	vsel(var3, var5, var2, var1); 
	vnot(var1, var3); 
	vsel(var2, var5, var1, var0); 
	vxor(*out4, *out4, var2); 
}                     

void s8(vtype var0, vtype var1, vtype var2, vtype var3, vtype var4, vtype var5, DES_DATA_BLOCKS_SPACE vtype *out1, DES_DATA_BLOCKS_SPACE vtype *out2, DES_DATA_BLOCKS_SPACE vtype *out3, DES_DATA_BLOCKS_SPACE vtype *out4)
{
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
	
	vsel(var6, var4, var0, var2); 
	vxor(var7, var3, var6); 
	vsel(var6, var2, var3, var4); 
	vsel(var8, var1, var4, var0); 
	vsel(var9, var7, var6, var8); 
	vxor(var6, var1, var9); 
	vsel(var8, var7, var3, var2); 
	vsel(var3, var4, var8, var1); 
	vsel(var10, var0, var6, var3); 
	vsel(var11, var2, var4, var1); 
	vxor(var2, var10, var11); 
	vsel(var12, var6, var4, var7); 
	vsel(var7, var12, var0, var8); 
	vxor(var8, var2, var7); 
	vsel(var12, var8, var2, var5); 
	vxor(*out3, *out3, var12); 
	vsel(var12, var11, var8, var4); 
	vxor(var4, var3, var12); 
	vxor(var3, var6, var4); 
	vnot(var8, var3); 
	vsel(var13, var9, var1, var12); 
	vsel(var12, var8, var13, var7); 
	vxor(var14, var4, var12); 
	vsel(var4, var14, var6, var5); 
	vxor(*out2, *out2, var4); 
	vsel(var4, var10, var11, var13); 
	vsel(var6, var9, var4, var2); 
	vxor(var4, var8, var6); 
	vsel(var6, var8, var4, var5); 
	vxor(*out4, *out4, var6); 
	vsel(var4, var9, var1, var2); 
	vor(var1, var0, var7); 
	vxor(var0, var4, var1); 
	vxor(var1, var12, var0); 
	vsel(var0, var1, var3, var5); 
	vxor(*out1, *out1, var0); 
}

unsigned int keyFunc(const unsigned int keyFirst28bits, DES_KEYS_SPACE const vtype *k, int j)
{
	return (j < 28) ? ((keyFirst28bits & (0x1U << j)) ? 0xffffffffU : 0x00000000U) : k[j - 28];
}

#define w(p, q)  (db[p]                    ^ keyFunc(keyFirst28bits, k, (q) & 0x3f))
#define z(r)     (db + (r))

void DES_Crypt(DES_DATA_BLOCKS_SPACE vtype *db, DES_KEYS_SPACE const vtype *k, const unsigned int keyFirst28bits)
{
	for (int i = 0; i < 64; ++i)
		db[i] = 0x00000000;

	int iterations           = 25;
	int roundsAndSwapped     = 8; 
	int round = 0;
	int DB00, DB01, DB02, DB03, DB04, DB05;
	int DB10, DB11, DB12, DB13, DB14, DB15;

start:
	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					DB00 = w(EF00, 12); DB01 = w(EF01, 46); DB02 = w(EF02, 33); DB03 = w(EF03, 52); DB04 = w(EF04, 48); DB05 = w(EF05, 20);
					DB10 = w(EF06, 34); DB11 = w(EF07, 55); DB12 = w(EF08,  5); DB13 = w(EF09, 13); DB14 = w(EF10, 18); DB15 = w(EF11, 40);
				} else {
					DB00 = w(EF00,  5); DB01 = w(EF01, 39); DB02 = w(EF02, 26); DB03 = w(EF03, 45); DB04 = w(EF04, 41); DB05 = w(EF05, 13);
					DB10 = w(EF06, 27); DB11 = w(EF07, 48); DB12 = w(EF08, 53); DB13 = w(EF09,  6); DB14 = w(EF10, 11); DB15 = w(EF11, 33);
				}
			} else {
				if (round == 2) {
					DB00 = w(EF00, 46); DB01 = w(EF01, 25); DB02 = w(EF02, 12); DB03 = w(EF03, 31); DB04 = w(EF04, 27); DB05 = w(EF05, 54);
					DB10 = w(EF06, 13); DB11 = w(EF07, 34); DB12 = w(EF08, 39); DB13 = w(EF09, 47); DB14 = w(EF10, 52); DB15 = w(EF11, 19);
				} else {
					DB00 = w(EF00, 32); DB01 = w(EF01, 11); DB02 = w(EF02, 53); DB03 = w(EF03, 48); DB04 = w(EF04, 13); DB05 = w(EF05, 40);
					DB10 = w(EF06, 54); DB11 = w(EF07, 20); DB12 = w(EF08, 25); DB13 = w(EF09, 33); DB14 = w(EF10, 38); DB15 = w(EF11,  5);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					DB00 = w(EF00, 18); DB01 = w(EF01, 52); DB02 = w(EF02, 39); DB03 = w(EF03, 34); DB04 = w(EF04, 54); DB05 = w(EF05, 26);
					DB10 = w(EF06, 40); DB11 = w(EF07,  6); DB12 = w(EF08, 11); DB13 = w(EF09, 19); DB14 = w(EF10, 55); DB15 = w(EF11, 46);
				} else {
					DB00 = w(EF00,  4); DB01 = w(EF01, 38); DB02 = w(EF02, 25); DB03 = w(EF03, 20); DB04 = w(EF04, 40); DB05 = w(EF05, 12);
					DB10 = w(EF06, 26); DB11 = w(EF07, 47); DB12 = w(EF08, 52); DB13 = w(EF09,  5); DB14 = w(EF10, 41); DB15 = w(EF11, 32);
				}
			} else {
				if (round == 6) {
					DB00 = w(EF00, 45); DB01 = w(EF01, 55); DB02 = w(EF02, 11); DB03 = w(EF03,  6); DB04 = w(EF04, 26); DB05 = w(EF05, 53);
					DB10 = w(EF06, 12); DB11 = w(EF07, 33); DB12 = w(EF08, 38); DB13 = w(EF09, 46); DB14 = w(EF10, 27); DB15 = w(EF11, 18);
				} else {
					DB00 = w(EF00, 31); DB01 = w(EF01, 41); DB02 = w(EF02, 52); DB03 = w(EF03, 47); DB04 = w(EF04, 12); DB05 = w(EF05, 39);
					DB10 = w(EF06, 53); DB11 = w(EF07, 19); DB12 = w(EF08, 55); DB13 = w(EF09, 32); DB14 = w(EF10, 13); DB15 = w(EF11,  4);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					DB00 = w(EF00, 55); DB01 = w(EF01, 34); DB02 = w(EF02, 45); DB03 = w(EF03, 40); DB04 = w(EF04,  5); DB05 = w(EF05, 32);
					DB10 = w(EF06, 46); DB11 = w(EF07, 12); DB12 = w(EF08, 48); DB13 = w(EF09, 25); DB14 = w(EF10,  6); DB15 = w(EF11, 52);
				} else {
					DB00 = w(EF00, 41); DB01 = w(EF01, 20); DB02 = w(EF02, 31); DB03 = w(EF03, 26); DB04 = w(EF04, 46); DB05 = w(EF05, 18);
					DB10 = w(EF06, 32); DB11 = w(EF07, 53); DB12 = w(EF08, 34); DB13 = w(EF09, 11); DB14 = w(EF10, 47); DB15 = w(EF11, 38);
				}
			} else {
				if (round == 10) {
					DB00 = w(EF00, 27); DB01 = w(EF01,  6); DB02 = w(EF02, 48); DB03 = w(EF03, 12); DB04 = w(EF04, 32); DB05 = w(EF05,  4);
					DB10 = w(EF06, 18); DB11 = w(EF07, 39); DB12 = w(EF08, 20); DB13 = w(EF09, 52); DB14 = w(EF10, 33); DB15 = w(EF11, 55);
				} else {
					DB00 = w(EF00, 13); DB01 = w(EF01, 47); DB02 = w(EF02, 34); DB03 = w(EF03, 53); DB04 = w(EF04, 18); DB05 = w(EF05, 45);
					DB10 = w(EF06,  4); DB11 = w(EF07, 25); DB12 = w(EF08,  6); DB13 = w(EF09, 38); DB14 = w(EF10, 19); DB15 = w(EF11, 41);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					DB00 = w(EF00, 54); DB01 = w(EF01, 33); DB02 = w(EF02, 20); DB03 = w(EF03, 39); DB04 = w(EF04,  4); DB05 = w(EF05, 31);
					DB10 = w(EF06, 45); DB11 = w(EF07, 11); DB12 = w(EF08, 47); DB13 = w(EF09, 55); DB14 = w(EF10,  5); DB15 = w(EF11, 27);
				} else {
					DB00 = w(EF00, 40); DB01 = w(EF01, 19); DB02 = w(EF02,  6); DB03 = w(EF03, 25); DB04 = w(EF04, 45); DB05 = w(EF05, 48);
					DB10 = w(EF06, 31); DB11 = w(EF07, 52); DB12 = w(EF08, 33); DB13 = w(EF09, 41); DB14 = w(EF10, 46); DB15 = w(EF11, 13);
				}
			} else {
				if (round == 14) {
					DB00 = w(EF00, 26); DB01 = w(EF01,  5); DB02 = w(EF02, 47); DB03 = w(EF03, 11); DB04 = w(EF04, 31); DB05 = w(EF05, 34);
					DB10 = w(EF06, 48); DB11 = w(EF07, 38); DB12 = w(EF08, 19); DB13 = w(EF09, 27); DB14 = w(EF10, 32); DB15 = w(EF11, 54);
				} else {
					DB00 = w(EF00, 19); DB01 = w(EF01, 53); DB02 = w(EF02, 40); DB03 = w(EF03,  4); DB04 = w(EF04, 55); DB05 = w(EF05, 27);
					DB10 = w(EF06, 41); DB11 = w(EF07, 31); DB12 = w(EF08, 12); DB13 = w(EF09, 20); DB14 = w(EF10, 25); DB15 = w(EF11, 47);
				}
			}
		}	
	}
	s1(DB00, DB01, DB02, DB03, DB04, DB05, z(40), z(48), z(54), z(62));
    s2(DB10, DB11, DB12, DB13, DB14, DB15, z(44), z(59), z(33), z(49)); 

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					DB00 = w(   7,  4); DB01 = w(   8, 32); DB02 = w(   9, 26); DB03 = w(  10, 27); DB04 = w(  11, 38); DB05 = w(  12, 54);
					DB10 = w(  11, 53); DB11 = w(  12,  6); DB12 = w(  13, 31); DB13 = w(  14, 25); DB14 = w(  15, 19); DB15 = w(  16, 41);
				} else {
					DB00 = w(   7, 52); DB01 = w(   8, 25); DB02 = w(   9, 19); DB03 = w(  10, 20); DB04 = w(  11, 31); DB05 = w(  12, 47);
					DB10 = w(  11, 46); DB11 = w(  12, 54); DB12 = w(  13, 55); DB13 = w(  14, 18); DB14 = w(  15, 12); DB15 = w(  16, 34);
				}
			} else {
				if (round == 2) {
					DB00 = w(   7, 38); DB01 = w(   8, 11); DB02 = w(   9,  5); DB03 = w(  10,  6); DB04 = w(  11, 48); DB05 = w(  12, 33);
					DB10 = w(  11, 32); DB11 = w(  12, 40); DB12 = w(  13, 41); DB13 = w(  14,  4); DB14 = w(  15, 53); DB15 = w(  16, 20);
				} else {
					DB00 = w(   7, 55); DB01 = w(   8, 52); DB02 = w(   9, 46); DB03 = w(  10, 47); DB04 = w(  11, 34); DB05 = w(  12, 19);
					DB10 = w(  11, 18); DB11 = w(  12, 26); DB12 = w(  13, 27); DB13 = w(  14, 45); DB14 = w(  15, 39); DB15 = w(  16,  6);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					DB00 = w(   7, 41); DB01 = w(   8, 38); DB02 = w(   9, 32); DB03 = w(  10, 33); DB04 = w(  11, 20); DB05 = w(  12,  5);
					DB10 = w(  11,  4); DB11 = w(  12, 12); DB12 = w(  13, 13); DB13 = w(  14, 31); DB14 = w(  15, 25); DB15 = w(  16, 47);
				} else {
					DB00 = w(   7, 27); DB01 = w(   8, 55); DB02 = w(   9, 18); DB03 = w(  10, 19); DB04 = w(  11,  6); DB05 = w(  12, 46);
					DB10 = w(  11, 45); DB11 = w(  12, 53); DB12 = w(  13, 54); DB13 = w(  14, 48); DB14 = w(  15, 11); DB15 = w(  16, 33);
				}
			} else {
				if (round == 6) {
					DB00 = w(   7, 13); DB01 = w(   8, 41); DB02 = w(   9,  4); DB03 = w(  10,  5); DB04 = w(  11, 47); DB05 = w(  12, 32);
					DB10 = w(  11, 31); DB11 = w(  12, 39); DB12 = w(  13, 40); DB13 = w(  14, 34); DB14 = w(  15, 52); DB15 = w(  16, 19);
				} else {
					DB00 = w(   7, 54); DB01 = w(   8, 27); DB02 = w(   9, 45); DB03 = w(  10, 46); DB04 = w(  11, 33); DB05 = w(  12, 18);
					DB10 = w(  11, 48); DB11 = w(  12, 25); DB12 = w(  13, 26); DB13 = w(  14, 20); DB14 = w(  15, 38); DB15 = w(  16,  5);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					DB00 = w(   7, 47); DB01 = w(   8, 20); DB02 = w(   9, 38); DB03 = w(  10, 39); DB04 = w(  11, 26); DB05 = w(  12, 11);
					DB10 = w(  11, 41); DB11 = w(  12, 18); DB12 = w(  13, 19); DB13 = w(  14, 13); DB14 = w(  15, 31); DB15 = w(  16, 53);
				} else {
					DB00 = w(   7, 33); DB01 = w(   8,  6); DB02 = w(   9, 55); DB03 = w(  10, 25); DB04 = w(  11, 12); DB05 = w(  12, 52);
					DB10 = w(  11, 27); DB11 = w(  12,  4); DB12 = w(  13,  5); DB13 = w(  14, 54); DB14 = w(  15, 48); DB15 = w(  16, 39);
				}
			} else {
				if (round == 10) {
					DB00 = w(   7, 19); DB01 = w(   8, 47); DB02 = w(   9, 41); DB03 = w(  10, 11); DB04 = w(  11, 53); DB05 = w(  12, 38);
					DB10 = w(  11, 13); DB11 = w(  12, 45); DB12 = w(  13, 46); DB13 = w(  14, 40); DB14 = w(  15, 34); DB15 = w(  16, 25);
				} else {
					DB00 = w(   7,  5); DB01 = w(   8, 33); DB02 = w(   9, 27); DB03 = w(  10, 52); DB04 = w(  11, 39); DB05 = w(  12, 55);
					DB10 = w(  11, 54); DB11 = w(  12, 31); DB12 = w(  13, 32); DB13 = w(  14, 26); DB14 = w(  15, 20); DB15 = w(  16, 11);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					DB00 = w(   7, 46); DB01 = w(   8, 19); DB02 = w(   9, 13); DB03 = w(  10, 38); DB04 = w(  11, 25); DB05 = w(  12, 41);
					DB10 = w(  11, 40); DB11 = w(  12, 48); DB12 = w(  13, 18); DB13 = w(  14, 12); DB14 = w(  15,  6); DB15 = w(  16, 52);
				} else {
					DB00 = w(   7, 32); DB01 = w(   8,  5); DB02 = w(   9, 54); DB03 = w(  10, 55); DB04 = w(  11, 11); DB05 = w(  12, 27);
					DB10 = w(  11, 26); DB11 = w(  12, 34); DB12 = w(  13,  4); DB13 = w(  14, 53); DB14 = w(  15, 47); DB15 = w(  16, 38);
				}
			} else {
				if (round == 14) {
					DB00 = w(   7, 18); DB01 = w(   8, 46); DB02 = w(   9, 40); DB03 = w(  10, 41); DB04 = w(  11, 52); DB05 = w(  12, 13);
					DB10 = w(  11, 12); DB11 = w(  12, 20); DB12 = w(  13, 45); DB13 = w(  14, 39); DB14 = w(  15, 33); DB15 = w(  16, 55);
				} else {
					DB00 = w(   7, 11); DB01 = w(   8, 39); DB02 = w(   9, 33); DB03 = w(  10, 34); DB04 = w(  11, 45); DB05 = w(  12,  6);
					DB10 = w(  11,  5); DB11 = w(  12, 13); DB12 = w(  13, 38); DB13 = w(  14, 32); DB14 = w(  15, 26); DB15 = w(  16, 48);
				}
			}
		}	
	}
	s3(DB00, DB01, DB02, DB03, DB04, DB05, z(55), z(47), z(61), z(37));
	s4(DB10, DB11, DB12, DB13, DB14, DB15, z(57), z(51), z(41), z(32));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					DB00 = w(EF24, 15); DB01 = w(EF25, 24); DB02 = w(EF26, 28); DB03 = w(EF27, 43); DB04 = w(EF28, 30); DB05 = w(EF29,  3);
					DB10 = w(EF30, 35); DB11 = w(EF31, 22); DB12 = w(EF32,  2); DB13 = w(EF33, 44); DB14 = w(EF34, 14); DB15 = w(EF35, 23);
				} else {
					DB00 = w(EF24,  8); DB01 = w(EF25, 17); DB02 = w(EF26, 21); DB03 = w(EF27, 36); DB04 = w(EF28, 23); DB05 = w(EF29, 49);
					DB10 = w(EF30, 28); DB11 = w(EF31, 15); DB12 = w(EF32, 24); DB13 = w(EF33, 37); DB14 = w(EF34,  7); DB15 = w(EF35, 16);
				}
			} else {
				if (round == 2) {
					DB00 = w(EF24, 51); DB01 = w(EF25,  3); DB02 = w(EF26,  7); DB03 = w(EF27, 22); DB04 = w(EF28,  9); DB05 = w(EF29, 35);
					DB10 = w(EF30, 14); DB11 = w(EF31,  1); DB12 = w(EF32, 10); DB13 = w(EF33, 23); DB14 = w(EF34, 50); DB15 = w(EF35,  2);
				} else {
					DB00 = w(EF24, 37); DB01 = w(EF25, 42); DB02 = w(EF26, 50); DB03 = w(EF27,  8); DB04 = w(EF28, 24); DB05 = w(EF29, 21);
					DB10 = w(EF30,  0); DB11 = w(EF31, 44); DB12 = w(EF32, 49); DB13 = w(EF33,  9); DB14 = w(EF34, 36); DB15 = w(EF35, 17);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					DB00 = w(EF24, 23); DB01 = w(EF25, 28); DB02 = w(EF26, 36); DB03 = w(EF27, 51); DB04 = w(EF28, 10); DB05 = w(EF29,  7);
					DB10 = w(EF30, 43); DB11 = w(EF31, 30); DB12 = w(EF32, 35); DB13 = w(EF33, 24); DB14 = w(EF34, 22); DB15 = w(EF35,  3);
				} else {
					DB00 = w(EF24,  9); DB01 = w(EF25, 14); DB02 = w(EF26, 22); DB03 = w(EF27, 37); DB04 = w(EF28, 49); DB05 = w(EF29, 50);
					DB10 = w(EF30, 29); DB11 = w(EF31, 16); DB12 = w(EF32, 21); DB13 = w(EF33, 10); DB14 = w(EF34,  8); DB15 = w(EF35, 42);
				}
			} else {
				if (round == 6) {
					DB00 = w(EF24, 24); DB01 = w(EF25,  0); DB02 = w(EF26,  8); DB03 = w(EF27, 23); DB04 = w(EF28, 35); DB05 = w(EF29, 36);
					DB10 = w(EF30, 15); DB11 = w(EF31,  2); DB12 = w(EF32,  7); DB13 = w(EF33, 49); DB14 = w(EF34, 51); DB15 = w(EF35, 28);
				} else {
					DB00 = w(EF24, 10); DB01 = w(EF25, 43); DB02 = w(EF26, 51); DB03 = w(EF27,  9); DB04 = w(EF28, 21); DB05 = w(EF29, 22);
					DB10 = w(EF30,  1); DB11 = w(EF31, 17); DB12 = w(EF32, 50); DB13 = w(EF33, 35); DB14 = w(EF34, 37); DB15 = w(EF35, 14);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					DB00 = w(EF24,  3); DB01 = w(EF25, 36); DB02 = w(EF26, 44); DB03 = w(EF27,  2); DB04 = w(EF28, 14); DB05 = w(EF29, 15);
					DB10 = w(EF30, 51); DB11 = w(EF31, 10); DB12 = w(EF32, 43); DB13 = w(EF33, 28); DB14 = w(EF34, 30); DB15 = w(EF35,  7);
				} else {
					DB00 = w(EF24, 42); DB01 = w(EF25, 22); DB02 = w(EF26, 30); DB03 = w(EF27, 17); DB04 = w(EF28,  0); DB05 = w(EF29,  1);
					DB10 = w(EF30, 37); DB11 = w(EF31, 49); DB12 = w(EF32, 29); DB13 = w(EF33, 14); DB14 = w(EF34, 16); DB15 = w(EF35, 50);
				}
			} else {
				if (round == 10) {
					DB00 = w(EF24, 28); DB01 = w(EF25,  8); DB02 = w(EF26, 16); DB03 = w(EF27,  3); DB04 = w(EF28, 43); DB05 = w(EF29, 44);
					DB10 = w(EF30, 23); DB11 = w(EF31, 35); DB12 = w(EF32, 15); DB13 = w(EF33,  0); DB14 = w(EF34,  2); DB15 = w(EF35, 36);
				} else {
					DB00 = w(EF24, 14); DB01 = w(EF25, 51); DB02 = w(EF26,  2); DB03 = w(EF27, 42); DB04 = w(EF28, 29); DB05 = w(EF29, 30);
					DB10 = w(EF30,  9); DB11 = w(EF31, 21); DB12 = w(EF32,  1); DB13 = w(EF33, 43); DB14 = w(EF34, 17); DB15 = w(EF35, 22);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					DB00 = w(EF24,  0); DB01 = w(EF25, 37); DB02 = w(EF26, 17); DB03 = w(EF27, 28); DB04 = w(EF28, 15); DB05 = w(EF29, 16);
					DB10 = w(EF30, 24); DB11 = w(EF31,  7); DB12 = w(EF32, 44); DB13 = w(EF33, 29); DB14 = w(EF34,  3); DB15 = w(EF35,  8);
				} else {
					DB00 = w(EF24, 43); DB01 = w(EF25, 23); DB02 = w(EF26,  3); DB03 = w(EF27, 14); DB04 = w(EF28,  1); DB05 = w(EF29,  2);
					DB10 = w(EF30, 10); DB11 = w(EF31, 50); DB12 = w(EF32, 30); DB13 = w(EF33, 15); DB14 = w(EF34, 42); DB15 = w(EF35, 51);
				}
			} else {
				if (round == 14) {
					DB00 = w(EF24, 29); DB01 = w(EF25,  9); DB02 = w(EF26, 42); DB03 = w(EF27,  0); DB04 = w(EF28, 44); DB05 = w(EF29, 17);
					DB10 = w(EF30, 49); DB11 = w(EF31, 36); DB12 = w(EF32, 16); DB13 = w(EF33,  1); DB14 = w(EF34, 28); DB15 = w(EF35, 37);
				} else {
					DB00 = w(EF24, 22); DB01 = w(EF25,  2); DB02 = w(EF26, 35); DB03 = w(EF27, 50); DB04 = w(EF28, 37); DB05 = w(EF29, 10);
					DB10 = w(EF30, 42); DB11 = w(EF31, 29); DB12 = w(EF32,  9); DB13 = w(EF33, 51); DB14 = w(EF34, 21); DB15 = w(EF35, 30);
				}
			}
		}	
	}
	s5(DB00, DB01, DB02, DB03, DB04, DB05, z(39), z(45), z(56), z(34));
	s6(DB10, DB11, DB12, DB13, DB14, DB15, z(35), z(60), z(42), z(50));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					DB00 = w(  23, 51); DB01 = w(  24, 16); DB02 = w(  25, 29); DB03 = w(  26, 49); DB04 = w(  27,  7); DB05 = w(  28, 17);
					DB10 = w(  27, 37); DB11 = w(  28,  8); DB12 = w(  29,  9); DB13 = w(  30, 50); DB14 = w(  31, 42); DB15 = w(   0, 21);
				} else {
					DB00 = w(  23, 44); DB01 = w(  24,  9); DB02 = w(  25, 22); DB03 = w(  26, 42); DB04 = w(  27,  0); DB05 = w(  28, 10);
					DB10 = w(  27, 30); DB11 = w(  28,  1); DB12 = w(  29,  2); DB13 = w(  30, 43); DB14 = w(  31, 35); DB15 = w(   0, 14);
				}
			} else {
				if (round == 2) {
					DB00 = w(  23, 30); DB01 = w(  24, 24); DB02 = w(  25,  8); DB03 = w(  26, 28); DB04 = w(  27, 43); DB05 = w(  28, 49);
					DB10 = w(  27, 16); DB11 = w(  28, 44); DB12 = w(  29, 17); DB13 = w(  30, 29); DB14 = w(  31, 21); DB15 = w(   0,  0);
				} else {
					DB00 = w(  23, 16); DB01 = w(  24, 10); DB02 = w(  25, 51); DB03 = w(  26, 14); DB04 = w(  27, 29); DB05 = w(  28, 35);
					DB10 = w(  27,  2); DB11 = w(  28, 30); DB12 = w(  29,  3); DB13 = w(  30, 15); DB14 = w(  31,  7); DB15 = w(   0, 43);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					DB00 = w(  23,  2); DB01 = w(  24, 49); DB02 = w(  25, 37); DB03 = w(  26,  0); DB04 = w(  27, 15); DB05 = w(  28, 21);
					DB10 = w(  27, 17); DB11 = w(  28, 16); DB12 = w(  29, 42); DB13 = w(  30,  1); DB14 = w(  31, 50); DB15 = w(   0, 29);
				} else {
					DB00 = w(  23, 17); DB01 = w(  24, 35); DB02 = w(  25, 23); DB03 = w(  26, 43); DB04 = w(  27,  1); DB05 = w(  28,  7);
					DB10 = w(  27,  3); DB11 = w(  28,  2); DB12 = w(  29, 28); DB13 = w(  30, 44); DB14 = w(  31, 36); DB15 = w(   0, 15);
				}
			} else {
				if (round == 6) {
					DB00 = w(  23,  3); DB01 = w(  24, 21); DB02 = w(  25,  9); DB03 = w(  26, 29); DB04 = w(  27, 44); DB05 = w(  28, 50);
					DB10 = w(  27, 42); DB11 = w(  28, 17); DB12 = w(  29, 14); DB13 = w(  30, 30); DB14 = w(  31, 22); DB15 = w(   0,  1);
				} else {
					DB00 = w(  23, 42); DB01 = w(  24,  7); DB02 = w(  25, 24); DB03 = w(  26, 15); DB04 = w(  27, 30); DB05 = w(  28, 36);
					DB10 = w(  27, 28); DB11 = w(  28,  3); DB12 = w(  29,  0); DB13 = w(  30, 16); DB14 = w(  31,  8); DB15 = w(   0, 44);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					DB00 = w(  23, 35); DB01 = w(  24,  0); DB02 = w(  25, 17); DB03 = w(  26,  8); DB04 = w(  27, 23); DB05 = w(  28, 29);
					DB10 = w(  27, 21); DB11 = w(  28, 49); DB12 = w(  29, 50); DB13 = w(  30,  9); DB14 = w(  31,  1); DB15 = w(   0, 37);
				} else {
					DB00 = w(  23, 21); DB01 = w(  24, 43); DB02 = w(  25,  3); DB03 = w(  26, 51); DB04 = w(  27,  9); DB05 = w(  28, 15);
					DB10 = w(  27,  7); DB11 = w(  28, 35); DB12 = w(  29, 36); DB13 = w(  30, 24); DB14 = w(  31, 44); DB15 = w(   0, 23);
				}
			} else {
				if (round == 10) {
					DB00 = w(  23,  7); DB01 = w(  24, 29); DB02 = w(  25, 42); DB03 = w(  26, 37); DB04 = w(  27, 24); DB05 = w(  28,  1);
					DB10 = w(  27, 50); DB11 = w(  28, 21); DB12 = w(  29, 22); DB13 = w(  30, 10); DB14 = w(  31, 30); DB15 = w(   0,  9);
				} else {
					DB00 = w(  23, 50); DB01 = w(  24, 15); DB02 = w(  25, 28); DB03 = w(  26, 23); DB04 = w(  27, 10); DB05 = w(  28, 44);
					DB10 = w(  27, 36); DB11 = w(  28,  7); DB12 = w(  29,  8); DB13 = w(  30, 49); DB14 = w(  31, 16); DB15 = w(   0, 24);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					DB00 = w(  23, 36); DB01 = w(  24,  1); DB02 = w(  25, 14); DB03 = w(  26,  9); DB04 = w(  27, 49); DB05 = w(  28, 30);
					DB10 = w(  27, 22); DB11 = w(  28, 50); DB12 = w(  29, 51); DB13 = w(  30, 35); DB14 = w(  31,  2); DB15 = w(   0, 10);
				} else {
					DB00 = w(  23, 22); DB01 = w(  24, 44); DB02 = w(  25,  0); DB03 = w(  26, 24); DB04 = w(  27, 35); DB05 = w(  28, 16);
					DB10 = w(  27,  8); DB11 = w(  28, 36); DB12 = w(  29, 37); DB13 = w(  30, 21); DB14 = w(  31, 17); DB15 = w(   0, 49);
				}
			} else {
				if (round == 14) {
					DB00 = w(  23,  8); DB01 = w(  24, 30); DB02 = w(  25, 43); DB03 = w(  26, 10); DB04 = w(  27, 21); DB05 = w(  28,  2);
					DB10 = w(  27, 51); DB11 = w(  28, 22); DB12 = w(  29, 23); DB13 = w(  30,  7); DB14 = w(  31,  3); DB15 = w(   0, 35);
				} else {
					DB00 = w(  23,  1); DB01 = w(  24, 23); DB02 = w(  25, 36); DB03 = w(  26,  3); DB04 = w(  27, 14); DB05 = w(  28, 24);
					DB10 = w(  27, 44); DB11 = w(  28, 15); DB12 = w(  29, 16); DB13 = w(  30,  0); DB14 = w(  31, 49); DB15 = w(   0, 28);
				}
			}
		}	
	}
	s7(DB00, DB01, DB02, DB03, DB04, DB05, z(63), z(43), z(53), z(38));
	s8(DB10, DB11, DB12, DB13, DB14, DB15, z(36), z(58), z(46), z(52));

	if (roundsAndSwapped == 0x100)
		goto next;

swap:
	++round;

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					DB00 = w(EF00+32, 12); DB01 = w(EF01+32, 46); DB02 = w(EF02+32, 33); DB03 = w(EF03+32, 52); DB04 = w(EF04+32, 48); DB05 = w(EF05+32, 20);
					DB10 = w(EF06+32, 34); DB11 = w(EF07+32, 55); DB12 = w(EF08+32,  5); DB13 = w(EF09+32, 13); DB14 = w(EF10+32, 18); DB15 = w(EF11+32, 40);
				} else {
					DB00 = w(EF00+32,  5); DB01 = w(EF01+32, 39); DB02 = w(EF02+32, 26); DB03 = w(EF03+32, 45); DB04 = w(EF04+32, 41); DB05 = w(EF05+32, 13);
					DB10 = w(EF06+32, 27); DB11 = w(EF07+32, 48); DB12 = w(EF08+32, 53); DB13 = w(EF09+32,  6); DB14 = w(EF10+32, 11); DB15 = w(EF11+32, 33);
				}
			} else {
				if (round == 2) {
					DB00 = w(EF00+32, 46); DB01 = w(EF01+32, 25); DB02 = w(EF02+32, 12); DB03 = w(EF03+32, 31); DB04 = w(EF04+32, 27); DB05 = w(EF05+32, 54);
					DB10 = w(EF06+32, 13); DB11 = w(EF07+32, 34); DB12 = w(EF08+32, 39); DB13 = w(EF09+32, 47); DB14 = w(EF10+32, 52); DB15 = w(EF11+32, 19);
				} else {
					DB00 = w(EF00+32, 32); DB01 = w(EF01+32, 11); DB02 = w(EF02+32, 53); DB03 = w(EF03+32, 48); DB04 = w(EF04+32, 13); DB05 = w(EF05+32, 40);
					DB10 = w(EF06+32, 54); DB11 = w(EF07+32, 20); DB12 = w(EF08+32, 25); DB13 = w(EF09+32, 33); DB14 = w(EF10+32, 38); DB15 = w(EF11+32,  5);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					DB00 = w(EF00+32, 18); DB01 = w(EF01+32, 52); DB02 = w(EF02+32, 39); DB03 = w(EF03+32, 34); DB04 = w(EF04+32, 54); DB05 = w(EF05+32, 26);
					DB10 = w(EF06+32, 40); DB11 = w(EF07+32,  6); DB12 = w(EF08+32, 11); DB13 = w(EF09+32, 19); DB14 = w(EF10+32, 55); DB15 = w(EF11+32, 46);
				} else {
					DB00 = w(EF00+32,  4); DB01 = w(EF01+32, 38); DB02 = w(EF02+32, 25); DB03 = w(EF03+32, 20); DB04 = w(EF04+32, 40); DB05 = w(EF05+32, 12);
					DB10 = w(EF06+32, 26); DB11 = w(EF07+32, 47); DB12 = w(EF08+32, 52); DB13 = w(EF09+32,  5); DB14 = w(EF10+32, 41); DB15 = w(EF11+32, 32);
				}
			} else {
				if (round == 6) {
					DB00 = w(EF00+32, 45); DB01 = w(EF01+32, 55); DB02 = w(EF02+32, 11); DB03 = w(EF03+32,  6); DB04 = w(EF04+32, 26); DB05 = w(EF05+32, 53);
					DB10 = w(EF06+32, 12); DB11 = w(EF07+32, 33); DB12 = w(EF08+32, 38); DB13 = w(EF09+32, 46); DB14 = w(EF10+32, 27); DB15 = w(EF11+32, 18);
				} else {
					DB00 = w(EF00+32, 31); DB01 = w(EF01+32, 41); DB02 = w(EF02+32, 52); DB03 = w(EF03+32, 47); DB04 = w(EF04+32, 12); DB05 = w(EF05+32, 39);
					DB10 = w(EF06+32, 53); DB11 = w(EF07+32, 19); DB12 = w(EF08+32, 55); DB13 = w(EF09+32, 32); DB14 = w(EF10+32, 13); DB15 = w(EF11+32,  4);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					DB00 = w(EF00+32, 55); DB01 = w(EF01+32, 34); DB02 = w(EF02+32, 45); DB03 = w(EF03+32, 40); DB04 = w(EF04+32,  5); DB05 = w(EF05+32, 32);
					DB10 = w(EF06+32, 46); DB11 = w(EF07+32, 12); DB12 = w(EF08+32, 48); DB13 = w(EF09+32, 25); DB14 = w(EF10+32,  6); DB15 = w(EF11+32, 52);
				} else {
					DB00 = w(EF00+32, 41); DB01 = w(EF01+32, 20); DB02 = w(EF02+32, 31); DB03 = w(EF03+32, 26); DB04 = w(EF04+32, 46); DB05 = w(EF05+32, 18);
					DB10 = w(EF06+32, 32); DB11 = w(EF07+32, 53); DB12 = w(EF08+32, 34); DB13 = w(EF09+32, 11); DB14 = w(EF10+32, 47); DB15 = w(EF11+32, 38);
				}
			} else {
				if (round == 10) {
					DB00 = w(EF00+32, 27); DB01 = w(EF01+32,  6); DB02 = w(EF02+32, 48); DB03 = w(EF03+32, 12); DB04 = w(EF04+32, 32); DB05 = w(EF05+32,  4);
					DB10 = w(EF06+32, 18); DB11 = w(EF07+32, 39); DB12 = w(EF08+32, 20); DB13 = w(EF09+32, 52); DB14 = w(EF10+32, 33); DB15 = w(EF11+32, 55);
				} else {
					DB00 = w(EF00+32, 13); DB01 = w(EF01+32, 47); DB02 = w(EF02+32, 34); DB03 = w(EF03+32, 53); DB04 = w(EF04+32, 18); DB05 = w(EF05+32, 45);
					DB10 = w(EF06+32,  4); DB11 = w(EF07+32, 25); DB12 = w(EF08+32,  6); DB13 = w(EF09+32, 38); DB14 = w(EF10+32, 19); DB15 = w(EF11+32, 41);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					DB00 = w(EF00+32, 54); DB01 = w(EF01+32, 33); DB02 = w(EF02+32, 20); DB03 = w(EF03+32, 39); DB04 = w(EF04+32,  4); DB05 = w(EF05+32, 31);
					DB10 = w(EF06+32, 45); DB11 = w(EF07+32, 11); DB12 = w(EF08+32, 47); DB13 = w(EF09+32, 55); DB14 = w(EF10+32,  5); DB15 = w(EF11+32, 27);
				} else {
					DB00 = w(EF00+32, 40); DB01 = w(EF01+32, 19); DB02 = w(EF02+32,  6); DB03 = w(EF03+32, 25); DB04 = w(EF04+32, 45); DB05 = w(EF05+32, 48);
					DB10 = w(EF06+32, 31); DB11 = w(EF07+32, 52); DB12 = w(EF08+32, 33); DB13 = w(EF09+32, 41); DB14 = w(EF10+32, 46); DB15 = w(EF11+32, 13);
				}
			} else {
				if (round == 14) {
					DB00 = w(EF00+32, 26); DB01 = w(EF01+32,  5); DB02 = w(EF02+32, 47); DB03 = w(EF03+32, 11); DB04 = w(EF04+32, 31); DB05 = w(EF05+32, 34);
					DB10 = w(EF06+32, 48); DB11 = w(EF07+32, 38); DB12 = w(EF08+32, 19); DB13 = w(EF09+32, 27); DB14 = w(EF10+32, 32); DB15 = w(EF11+32, 54);
				} else {
					DB00 = w(EF00+32, 19); DB01 = w(EF01+32, 53); DB02 = w(EF02+32, 40); DB03 = w(EF03+32,  4); DB04 = w(EF04+32, 55); DB05 = w(EF05+32, 27);
					DB10 = w(EF06+32, 41); DB11 = w(EF07+32, 31); DB12 = w(EF08+32, 12); DB13 = w(EF09+32, 20); DB14 = w(EF10+32, 25); DB15 = w(EF11+32, 47);
				}
			}
		}	
	}
	s1(DB00, DB01, DB02, DB03, DB04, DB05, z(40-32), z(48-32), z(54-32), z(62-32));
    s2(DB10, DB11, DB12, DB13, DB14, DB15, z(44-32), z(59-32), z(33-32), z(49-32)); 

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					DB00 = w(   7+32,  4); DB01 = w(   8+32, 32); DB02 = w(   9+32, 26); DB03 = w(  10+32, 27); DB04 = w(  11+32, 38); DB05 = w(  12+32, 54);
					DB10 = w(  11+32, 53); DB11 = w(  12+32,  6); DB12 = w(  13+32, 31); DB13 = w(  14+32, 25); DB14 = w(  15+32, 19); DB15 = w(  16+32, 41);
				} else {
					DB00 = w(   7+32, 52); DB01 = w(   8+32, 25); DB02 = w(   9+32, 19); DB03 = w(  10+32, 20); DB04 = w(  11+32, 31); DB05 = w(  12+32, 47);
					DB10 = w(  11+32, 46); DB11 = w(  12+32, 54); DB12 = w(  13+32, 55); DB13 = w(  14+32, 18); DB14 = w(  15+32, 12); DB15 = w(  16+32, 34);
				}
			} else {
				if (round == 2) {
					DB00 = w(   7+32, 38); DB01 = w(   8+32, 11); DB02 = w(   9+32,  5); DB03 = w(  10+32,  6); DB04 = w(  11+32, 48); DB05 = w(  12+32, 33);
					DB10 = w(  11+32, 32); DB11 = w(  12+32, 40); DB12 = w(  13+32, 41); DB13 = w(  14+32,  4); DB14 = w(  15+32, 53); DB15 = w(  16+32, 20);
				} else {
					DB00 = w(   7+32, 55); DB01 = w(   8+32, 52); DB02 = w(   9+32, 46); DB03 = w(  10+32, 47); DB04 = w(  11+32, 34); DB05 = w(  12+32, 19);
					DB10 = w(  11+32, 18); DB11 = w(  12+32, 26); DB12 = w(  13+32, 27); DB13 = w(  14+32, 45); DB14 = w(  15+32, 39); DB15 = w(  16+32,  6);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					DB00 = w(   7+32, 41); DB01 = w(   8+32, 38); DB02 = w(   9+32, 32); DB03 = w(  10+32, 33); DB04 = w(  11+32, 20); DB05 = w(  12+32,  5);
					DB10 = w(  11+32,  4); DB11 = w(  12+32, 12); DB12 = w(  13+32, 13); DB13 = w(  14+32, 31); DB14 = w(  15+32, 25); DB15 = w(  16+32, 47);
				} else {
					DB00 = w(   7+32, 27); DB01 = w(   8+32, 55); DB02 = w(   9+32, 18); DB03 = w(  10+32, 19); DB04 = w(  11+32,  6); DB05 = w(  12+32, 46);
					DB10 = w(  11+32, 45); DB11 = w(  12+32, 53); DB12 = w(  13+32, 54); DB13 = w(  14+32, 48); DB14 = w(  15+32, 11); DB15 = w(  16+32, 33);
				}
			} else {
				if (round == 6) {
					DB00 = w(   7+32, 13); DB01 = w(   8+32, 41); DB02 = w(   9+32,  4); DB03 = w(  10+32,  5); DB04 = w(  11+32, 47); DB05 = w(  12+32, 32);
					DB10 = w(  11+32, 31); DB11 = w(  12+32, 39); DB12 = w(  13+32, 40); DB13 = w(  14+32, 34); DB14 = w(  15+32, 52); DB15 = w(  16+32, 19);
				} else {
					DB00 = w(   7+32, 54); DB01 = w(   8+32, 27); DB02 = w(   9+32, 45); DB03 = w(  10+32, 46); DB04 = w(  11+32, 33); DB05 = w(  12+32, 18);
					DB10 = w(  11+32, 48); DB11 = w(  12+32, 25); DB12 = w(  13+32, 26); DB13 = w(  14+32, 20); DB14 = w(  15+32, 38); DB15 = w(  16+32,  5);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					DB00 = w(   7+32, 47); DB01 = w(   8+32, 20); DB02 = w(   9+32, 38); DB03 = w(  10+32, 39); DB04 = w(  11+32, 26); DB05 = w(  12+32, 11);
					DB10 = w(  11+32, 41); DB11 = w(  12+32, 18); DB12 = w(  13+32, 19); DB13 = w(  14+32, 13); DB14 = w(  15+32, 31); DB15 = w(  16+32, 53);
				} else {
					DB00 = w(   7+32, 33); DB01 = w(   8+32,  6); DB02 = w(   9+32, 55); DB03 = w(  10+32, 25); DB04 = w(  11+32, 12); DB05 = w(  12+32, 52);
					DB10 = w(  11+32, 27); DB11 = w(  12+32,  4); DB12 = w(  13+32,  5); DB13 = w(  14+32, 54); DB14 = w(  15+32, 48); DB15 = w(  16+32, 39);
				}
			} else {
				if (round == 10) {
					DB00 = w(   7+32, 19); DB01 = w(   8+32, 47); DB02 = w(   9+32, 41); DB03 = w(  10+32, 11); DB04 = w(  11+32, 53); DB05 = w(  12+32, 38);
					DB10 = w(  11+32, 13); DB11 = w(  12+32, 45); DB12 = w(  13+32, 46); DB13 = w(  14+32, 40); DB14 = w(  15+32, 34); DB15 = w(  16+32, 25);
				} else {
					DB00 = w(   7+32,  5); DB01 = w(   8+32, 33); DB02 = w(   9+32, 27); DB03 = w(  10+32, 52); DB04 = w(  11+32, 39); DB05 = w(  12+32, 55);
					DB10 = w(  11+32, 54); DB11 = w(  12+32, 31); DB12 = w(  13+32, 32); DB13 = w(  14+32, 26); DB14 = w(  15+32, 20); DB15 = w(  16+32, 11);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					DB00 = w(   7+32, 46); DB01 = w(   8+32, 19); DB02 = w(   9+32, 13); DB03 = w(  10+32, 38); DB04 = w(  11+32, 25); DB05 = w(  12+32, 41);
					DB10 = w(  11+32, 40); DB11 = w(  12+32, 48); DB12 = w(  13+32, 18); DB13 = w(  14+32, 12); DB14 = w(  15+32,  6); DB15 = w(  16+32, 52);
				} else {
					DB00 = w(   7+32, 32); DB01 = w(   8+32,  5); DB02 = w(   9+32, 54); DB03 = w(  10+32, 55); DB04 = w(  11+32, 11); DB05 = w(  12+32, 27);
					DB10 = w(  11+32, 26); DB11 = w(  12+32, 34); DB12 = w(  13+32,  4); DB13 = w(  14+32, 53); DB14 = w(  15+32, 47); DB15 = w(  16+32, 38);
				}
			} else {
				if (round == 14) {
					DB00 = w(   7+32, 18); DB01 = w(   8+32, 46); DB02 = w(   9+32, 40); DB03 = w(  10+32, 41); DB04 = w(  11+32, 52); DB05 = w(  12+32, 13);
					DB10 = w(  11+32, 12); DB11 = w(  12+32, 20); DB12 = w(  13+32, 45); DB13 = w(  14+32, 39); DB14 = w(  15+32, 33); DB15 = w(  16+32, 55);
				} else {
					DB00 = w(   7+32, 11); DB01 = w(   8+32, 39); DB02 = w(   9+32, 33); DB03 = w(  10+32, 34); DB04 = w(  11+32, 45); DB05 = w(  12+32,  6);
					DB10 = w(  11+32,  5); DB11 = w(  12+32, 13); DB12 = w(  13+32, 38); DB13 = w(  14+32, 32); DB14 = w(  15+32, 26); DB15 = w(  16+32, 48);
				}
			}
		}	
	}
	s3(DB00, DB01, DB02, DB03, DB04, DB05, z(55-32), z(47-32), z(61-32), z(37-32));
	s4(DB10, DB11, DB12, DB13, DB14, DB15, z(57-32), z(51-32), z(41-32), z(32-32));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					DB00 = w(EF24+32, 15); DB01 = w(EF25+32, 24); DB02 = w(EF26+32, 28); DB03 = w(EF27+32, 43); DB04 = w(EF28+32, 30); DB05 = w(EF29+32,  3);
					DB10 = w(EF30+32, 35); DB11 = w(EF31+32, 22); DB12 = w(EF32+32,  2); DB13 = w(EF33+32, 44); DB14 = w(EF34+32, 14); DB15 = w(EF35+32, 23);
				} else {
					DB00 = w(EF24+32,  8); DB01 = w(EF25+32, 17); DB02 = w(EF26+32, 21); DB03 = w(EF27+32, 36); DB04 = w(EF28+32, 23); DB05 = w(EF29+32, 49);
					DB10 = w(EF30+32, 28); DB11 = w(EF31+32, 15); DB12 = w(EF32+32, 24); DB13 = w(EF33+32, 37); DB14 = w(EF34+32,  7); DB15 = w(EF35+32, 16);
				}
			} else {
				if (round == 2) {
					DB00 = w(EF24+32, 51); DB01 = w(EF25+32,  3); DB02 = w(EF26+32,  7); DB03 = w(EF27+32, 22); DB04 = w(EF28+32,  9); DB05 = w(EF29+32, 35);
					DB10 = w(EF30+32, 14); DB11 = w(EF31+32,  1); DB12 = w(EF32+32, 10); DB13 = w(EF33+32, 23); DB14 = w(EF34+32, 50); DB15 = w(EF35+32,  2);
				} else {
					DB00 = w(EF24+32, 37); DB01 = w(EF25+32, 42); DB02 = w(EF26+32, 50); DB03 = w(EF27+32,  8); DB04 = w(EF28+32, 24); DB05 = w(EF29+32, 21);
					DB10 = w(EF30+32,  0); DB11 = w(EF31+32, 44); DB12 = w(EF32+32, 49); DB13 = w(EF33+32,  9); DB14 = w(EF34+32, 36); DB15 = w(EF35+32, 17);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					DB00 = w(EF24+32, 23); DB01 = w(EF25+32, 28); DB02 = w(EF26+32, 36); DB03 = w(EF27+32, 51); DB04 = w(EF28+32, 10); DB05 = w(EF29+32,  7);
					DB10 = w(EF30+32, 43); DB11 = w(EF31+32, 30); DB12 = w(EF32+32, 35); DB13 = w(EF33+32, 24); DB14 = w(EF34+32, 22); DB15 = w(EF35+32,  3);
				} else {
					DB00 = w(EF24+32,  9); DB01 = w(EF25+32, 14); DB02 = w(EF26+32, 22); DB03 = w(EF27+32, 37); DB04 = w(EF28+32, 49); DB05 = w(EF29+32, 50);
					DB10 = w(EF30+32, 29); DB11 = w(EF31+32, 16); DB12 = w(EF32+32, 21); DB13 = w(EF33+32, 10); DB14 = w(EF34+32,  8); DB15 = w(EF35+32, 42);
				}
			} else {
				if (round == 6) {
					DB00 = w(EF24+32, 24); DB01 = w(EF25+32,  0); DB02 = w(EF26+32,  8); DB03 = w(EF27+32, 23); DB04 = w(EF28+32, 35); DB05 = w(EF29+32, 36);
					DB10 = w(EF30+32, 15); DB11 = w(EF31+32,  2); DB12 = w(EF32+32,  7); DB13 = w(EF33+32, 49); DB14 = w(EF34+32, 51); DB15 = w(EF35+32, 28);
				} else {
					DB00 = w(EF24+32, 10); DB01 = w(EF25+32, 43); DB02 = w(EF26+32, 51); DB03 = w(EF27+32,  9); DB04 = w(EF28+32, 21); DB05 = w(EF29+32, 22);
					DB10 = w(EF30+32,  1); DB11 = w(EF31+32, 17); DB12 = w(EF32+32, 50); DB13 = w(EF33+32, 35); DB14 = w(EF34+32, 37); DB15 = w(EF35+32, 14);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					DB00 = w(EF24+32,  3); DB01 = w(EF25+32, 36); DB02 = w(EF26+32, 44); DB03 = w(EF27+32,  2); DB04 = w(EF28+32, 14); DB05 = w(EF29+32, 15);
					DB10 = w(EF30+32, 51); DB11 = w(EF31+32, 10); DB12 = w(EF32+32, 43); DB13 = w(EF33+32, 28); DB14 = w(EF34+32, 30); DB15 = w(EF35+32,  7);
				} else {
					DB00 = w(EF24+32, 42); DB01 = w(EF25+32, 22); DB02 = w(EF26+32, 30); DB03 = w(EF27+32, 17); DB04 = w(EF28+32,  0); DB05 = w(EF29+32,  1);
					DB10 = w(EF30+32, 37); DB11 = w(EF31+32, 49); DB12 = w(EF32+32, 29); DB13 = w(EF33+32, 14); DB14 = w(EF34+32, 16); DB15 = w(EF35+32, 50);
				}
			} else {
				if (round == 10) {
					DB00 = w(EF24+32, 28); DB01 = w(EF25+32,  8); DB02 = w(EF26+32, 16); DB03 = w(EF27+32,  3); DB04 = w(EF28+32, 43); DB05 = w(EF29+32, 44);
					DB10 = w(EF30+32, 23); DB11 = w(EF31+32, 35); DB12 = w(EF32+32, 15); DB13 = w(EF33+32,  0); DB14 = w(EF34+32,  2); DB15 = w(EF35+32, 36);
				} else {
					DB00 = w(EF24+32, 14); DB01 = w(EF25+32, 51); DB02 = w(EF26+32,  2); DB03 = w(EF27+32, 42); DB04 = w(EF28+32, 29); DB05 = w(EF29+32, 30);
					DB10 = w(EF30+32,  9); DB11 = w(EF31+32, 21); DB12 = w(EF32+32,  1); DB13 = w(EF33+32, 43); DB14 = w(EF34+32, 17); DB15 = w(EF35+32, 22);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					DB00 = w(EF24+32,  0); DB01 = w(EF25+32, 37); DB02 = w(EF26+32, 17); DB03 = w(EF27+32, 28); DB04 = w(EF28+32, 15); DB05 = w(EF29+32, 16);
					DB10 = w(EF30+32, 24); DB11 = w(EF31+32,  7); DB12 = w(EF32+32, 44); DB13 = w(EF33+32, 29); DB14 = w(EF34+32,  3); DB15 = w(EF35+32,  8);
				} else {
					DB00 = w(EF24+32, 43); DB01 = w(EF25+32, 23); DB02 = w(EF26+32,  3); DB03 = w(EF27+32, 14); DB04 = w(EF28+32,  1); DB05 = w(EF29+32,  2);
					DB10 = w(EF30+32, 10); DB11 = w(EF31+32, 50); DB12 = w(EF32+32, 30); DB13 = w(EF33+32, 15); DB14 = w(EF34+32, 42); DB15 = w(EF35+32, 51);
				}
			} else {
				if (round == 14) {
					DB00 = w(EF24+32, 29); DB01 = w(EF25+32,  9); DB02 = w(EF26+32, 42); DB03 = w(EF27+32,  0); DB04 = w(EF28+32, 44); DB05 = w(EF29+32, 17);
					DB10 = w(EF30+32, 49); DB11 = w(EF31+32, 36); DB12 = w(EF32+32, 16); DB13 = w(EF33+32,  1); DB14 = w(EF34+32, 28); DB15 = w(EF35+32, 37);
				} else {
					DB00 = w(EF24+32, 22); DB01 = w(EF25+32,  2); DB02 = w(EF26+32, 35); DB03 = w(EF27+32, 50); DB04 = w(EF28+32, 37); DB05 = w(EF29+32, 10);
					DB10 = w(EF30+32, 42); DB11 = w(EF31+32, 29); DB12 = w(EF32+32,  9); DB13 = w(EF33+32, 51); DB14 = w(EF34+32, 21); DB15 = w(EF35+32, 30);
				}
			}
		}	
	}
	s5(DB00, DB01, DB02, DB03, DB04, DB05, z(39-32), z(45-32), z(56-32), z(34-32));
	s6(DB10, DB11, DB12, DB13, DB14, DB15, z(35-32), z(60-32), z(42-32), z(50-32));


	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					DB00 = w(  23+32, 51); DB01 = w(  24+32, 16); DB02 = w(  25+32, 29); DB03 = w(  26+32, 49); DB04 = w(  27+32,  7); DB05 = w(  28+32, 17);
					DB10 = w(  27+32, 37); DB11 = w(  28+32,  8); DB12 = w(  29+32,  9); DB13 = w(  30+32, 50); DB14 = w(  31+32, 42); DB15 = w(   0+32, 21);
				} else {
					DB00 = w(  23+32, 44); DB01 = w(  24+32,  9); DB02 = w(  25+32, 22); DB03 = w(  26+32, 42); DB04 = w(  27+32,  0); DB05 = w(  28+32, 10);
					DB10 = w(  27+32, 30); DB11 = w(  28+32,  1); DB12 = w(  29+32,  2); DB13 = w(  30+32, 43); DB14 = w(  31+32, 35); DB15 = w(   0+32, 14);
				}
			} else {
				if (round == 2) {
					DB00 = w(  23+32, 30); DB01 = w(  24+32, 24); DB02 = w(  25+32,  8); DB03 = w(  26+32, 28); DB04 = w(  27+32, 43); DB05 = w(  28+32, 49);
					DB10 = w(  27+32, 16); DB11 = w(  28+32, 44); DB12 = w(  29+32, 17); DB13 = w(  30+32, 29); DB14 = w(  31+32, 21); DB15 = w(   0+32,  0);
				} else {
					DB00 = w(  23+32, 16); DB01 = w(  24+32, 10); DB02 = w(  25+32, 51); DB03 = w(  26+32, 14); DB04 = w(  27+32, 29); DB05 = w(  28+32, 35);
					DB10 = w(  27+32,  2); DB11 = w(  28+32, 30); DB12 = w(  29+32,  3); DB13 = w(  30+32, 15); DB14 = w(  31+32,  7); DB15 = w(   0+32, 43);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					DB00 = w(  23+32,  2); DB01 = w(  24+32, 49); DB02 = w(  25+32, 37); DB03 = w(  26+32,  0); DB04 = w(  27+32, 15); DB05 = w(  28+32, 21);
					DB10 = w(  27+32, 17); DB11 = w(  28+32, 16); DB12 = w(  29+32, 42); DB13 = w(  30+32,  1); DB14 = w(  31+32, 50); DB15 = w(   0+32, 29);
				} else {
					DB00 = w(  23+32, 17); DB01 = w(  24+32, 35); DB02 = w(  25+32, 23); DB03 = w(  26+32, 43); DB04 = w(  27+32,  1); DB05 = w(  28+32,  7);
					DB10 = w(  27+32,  3); DB11 = w(  28+32,  2); DB12 = w(  29+32, 28); DB13 = w(  30+32, 44); DB14 = w(  31+32, 36); DB15 = w(   0+32, 15);
				}
			} else {
				if (round == 6) {
					DB00 = w(  23+32,  3); DB01 = w(  24+32, 21); DB02 = w(  25+32,  9); DB03 = w(  26+32, 29); DB04 = w(  27+32, 44); DB05 = w(  28+32, 50);
					DB10 = w(  27+32, 42); DB11 = w(  28+32, 17); DB12 = w(  29+32, 14); DB13 = w(  30+32, 30); DB14 = w(  31+32, 22); DB15 = w(   0+32,  1);
				} else {
					DB00 = w(  23+32, 42); DB01 = w(  24+32,  7); DB02 = w(  25+32, 24); DB03 = w(  26+32, 15); DB04 = w(  27+32, 30); DB05 = w(  28+32, 36);
					DB10 = w(  27+32, 28); DB11 = w(  28+32,  3); DB12 = w(  29+32,  0); DB13 = w(  30+32, 16); DB14 = w(  31+32,  8); DB15 = w(   0+32, 44);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					DB00 = w(  23+32, 35); DB01 = w(  24+32,  0); DB02 = w(  25+32, 17); DB03 = w(  26+32,  8); DB04 = w(  27+32, 23); DB05 = w(  28+32, 29);
					DB10 = w(  27+32, 21); DB11 = w(  28+32, 49); DB12 = w(  29+32, 50); DB13 = w(  30+32,  9); DB14 = w(  31+32,  1); DB15 = w(   0+32, 37);
				} else {
					DB00 = w(  23+32, 21); DB01 = w(  24+32, 43); DB02 = w(  25+32,  3); DB03 = w(  26+32, 51); DB04 = w(  27+32,  9); DB05 = w(  28+32, 15);
					DB10 = w(  27+32,  7); DB11 = w(  28+32, 35); DB12 = w(  29+32, 36); DB13 = w(  30+32, 24); DB14 = w(  31+32, 44); DB15 = w(   0+32, 23);
				}
			} else {
				if (round == 10) {
					DB00 = w(  23+32,  7); DB01 = w(  24+32, 29); DB02 = w(  25+32, 42); DB03 = w(  26+32, 37); DB04 = w(  27+32, 24); DB05 = w(  28+32,  1);
					DB10 = w(  27+32, 50); DB11 = w(  28+32, 21); DB12 = w(  29+32, 22); DB13 = w(  30+32, 10); DB14 = w(  31+32, 30); DB15 = w(   0+32,  9);
				} else {
					DB00 = w(  23+32, 50); DB01 = w(  24+32, 15); DB02 = w(  25+32, 28); DB03 = w(  26+32, 23); DB04 = w(  27+32, 10); DB05 = w(  28+32, 44);
					DB10 = w(  27+32, 36); DB11 = w(  28+32,  7); DB12 = w(  29+32,  8); DB13 = w(  30+32, 49); DB14 = w(  31+32, 16); DB15 = w(   0+32, 24);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					DB00 = w(  23+32, 36); DB01 = w(  24+32,  1); DB02 = w(  25+32, 14); DB03 = w(  26+32,  9); DB04 = w(  27+32, 49); DB05 = w(  28+32, 30);
					DB10 = w(  27+32, 22); DB11 = w(  28+32, 50); DB12 = w(  29+32, 51); DB13 = w(  30+32, 35); DB14 = w(  31+32,  2); DB15 = w(   0+32, 10);
				} else {
					DB00 = w(  23+32, 22); DB01 = w(  24+32, 44); DB02 = w(  25+32,  0); DB03 = w(  26+32, 24); DB04 = w(  27+32, 35); DB05 = w(  28+32, 16);
					DB10 = w(  27+32,  8); DB11 = w(  28+32, 36); DB12 = w(  29+32, 37); DB13 = w(  30+32, 21); DB14 = w(  31+32, 17); DB15 = w(   0+32, 49);
				}
			} else {
				if (round == 14) {
					DB00 = w(  23+32,  8); DB01 = w(  24+32, 30); DB02 = w(  25+32, 43); DB03 = w(  26+32, 10); DB04 = w(  27+32, 21); DB05 = w(  28+32,  2);
					DB10 = w(  27+32, 51); DB11 = w(  28+32, 22); DB12 = w(  29+32, 23); DB13 = w(  30+32,  7); DB14 = w(  31+32,  3); DB15 = w(   0+32, 35);
				} else {
					DB00 = w(  23+32,  1); DB01 = w(  24+32, 23); DB02 = w(  25+32, 36); DB03 = w(  26+32,  3); DB04 = w(  27+32, 14); DB05 = w(  28+32, 24);
					DB10 = w(  27+32, 44); DB11 = w(  28+32, 15); DB12 = w(  29+32, 16); DB13 = w(  30+32,  0); DB14 = w(  31+32, 49); DB15 = w(   0+32, 28);
				}
			}
		}	
	}
	s7(DB00, DB01, DB02, DB03, DB04, DB05, z(63-32), z(43-32), z(53-32), z(38-32));
	s8(DB10, DB11, DB12, DB13, DB14, DB15, z(36-32), z(58-32), z(46-32), z(52-32));

	++round;

	if (--roundsAndSwapped)
		goto start;
	round -= 17;
	roundsAndSwapped = 0x108;
	if (--iterations)
		goto swap;
	return;

next:
	round -= 15;
	roundsAndSwapped = 8;
	iterations--;
	goto start;
}

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
		DES_keys[i - 28] = 0xffffffff      \
		
#define SET_BIT_FOR_KEY(i, j, k)            \
	if (key[j] & (0x1 << (k)))              \
		DES_keys[i - 28] |= 0x1 << tripcodeIndex \

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
		__constant const unsigned char      * const keyCharTableForKey7,                                   \
 		__constant const unsigned char      * const smallKeyBitmap,                                        \
 		__global   const unsigned char      * const keyBitmap,                                             \
		__global   const PartialKeyFrom3To6 * const partialKeyFrom3To6Array,                               \
		__local    const unsigned int       * const localBuffer,                                           \
                   const unsigned int               keyFirst28bits                                         \
	) {                                                                                                    \
		__global              GPUOutput     *output = &outputArray[get_global_id(0)];                      \
		__private             unsigned char  key[8];                                                       \
							  unsigned char  tripcodeIndex;                                                \
		DES_DATA_BLOCKS_SPACE vtype          DES_dataBlocks[64];                                           \
		DES_KEYS_SPACE        vtype          *DES_keys = localBuffer + 29 * get_local_id(0);               \
		__global unsigned char *partialKeyFrom3To6 = partialKeyFrom3To6Array[get_global_id(0)].partialKeyFrom3To6; \
		output->numMatchingTripcodes = 0;                                                                  \
		                                                                                                   \
		for (int i = 0; i < DES_NUM_BITS_IN_KEY; ++i)                                                      \
			DES_keys[i] = 0x0;                                                                             \
																										   \
		key[0] = keyInfo->partialKeyAndRandomBytes[0];                                                     \
		key[1] = keyInfo->partialKeyAndRandomBytes[1];                                                     \
		key[2] = keyInfo->partialKeyAndRandomBytes[2];                                                     \
		key[3] = keyInfo->partialKeyAndRandomBytes[3];                                                     \
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
			key[7] = keyCharTableForKey7[keyInfo->partialKeyAndRandomBytes[7] + (tripcodeIndex & 0x3f)];  \
			SET_BIT_FOR_KEY(49, 7, 0);                                                                     \
			SET_BIT_FOR_KEY(50, 7, 1);                                                                     \
			SET_BIT_FOR_KEY(51, 7, 2);                                                                     \
			SET_BIT_FOR_KEY(52, 7, 3);                                                                     \
			SET_BIT_FOR_KEY(53, 7, 4);                                                                     \
			SET_BIT_FOR_KEY(54, 7, 5);                                                                     \
			SET_BIT_FOR_KEY(55, 7, 6);                                                                     \
		}                                                                                                  \
		                                                                                                   \
		DES_Crypt(DES_dataBlocks, (DES_KEYS_SPACE const vtype *)DES_keys, keyFirst28bits);                 \
		                                                                                                   \
		BOOL found = FALSE;                                                                                \

#define OPENCL_DES_END_OF_SEAERCH_FUNCTION                                                                             \
	quit_loops:                                                                                                        \
		if (found == TRUE) {                                                                                           \
			output->numMatchingTripcodes = 1;                                                                          \
			DES_GetTripcode(DES_dataBlocks, tripcodeIndex, output->pair.tripcode.c);                                   \
			output->pair.key.c[0] = key[0];                                                                           \
			output->pair.key.c[1] = key[1];                                                                            \
			output->pair.key.c[2] = key[2];                                                                            \
			output->pair.key.c[3] = key[3];                                                                            \
			output->pair.key.c[4] = key[4];                                                                            \
			output->pair.key.c[5] = key[5];                                                                            \
			output->pair.key.c[6] = key[6];                                                                            \
			output->pair.key.c[7] = keyCharTableForKey7[keyInfo->partialKeyAndRandomBytes[7] + (tripcodeIndex & 0x3f)]; \
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
