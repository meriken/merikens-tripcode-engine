// Meriken's Tripcode Engine 2.0.0
// Copyright (c) 2011-2015 Meriken.Z. <meriken.2ch@gmail.com>
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



// #define EXPERIMENTAL



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
#define MEDIUM_KEY_BITMAP_LEN_STRING 3
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

typedef unsigned long vtype;

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

#ifdef EXPERIMENTAL

#define var14 var4
#define var15 var5 
#define var16 var6
#define var17 var7
#define var18 var8
#define var19 var9

#endif

#define s1(out1, out2, out3, out4) \
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
	vxor(*out1, *out1, var6); \
	vsel(var4, var0, var2, var11); \
	vsel(var0, var15, var1, var9); \
	vsel(var1, var4, var3, var0); \
	vxor(var3, var16, var1); \
	vsel(var4, var3, var12, var5); \
	vxor(*out2, *out2, var4); \
	vsel(var4, var8, var13, var1); \
	vsel(var6, var0, var12, var10); \
	vxor(var0, var4, var6); \
	vsel(var4, var0, var16, var5); \
	vxor(*out4, *out4, var4); \
	vxor(var0, var12, var3); \
	vsel(var3, var2, var0, var1); \
	vsel(var0, var3, var7, var6); \
	vsel(var1, var0, var14, var5); \
	vxor(*out3, *out3, var1); \

#define s2(out1, out2, out3, out4) \
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
	vxor(*out2, *out2, var14); \
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
	vxor(*out1, *out1, var3); \
	vsel(var3, var6, var17, var8); \
	vsel(var8, var10, var13, var0); \
	vsel(var0, var3, var8, var14); \
	vsel(var3, var16, var17, var6); \
	vsel(var6, var8, var2, var7); \
	vsel(var2, var3, var6, var4); \
	vsel(var3, var15, var2, var1); \
	vxor(*out4, *out4, var3); \
	vsel(var2, var8, var9, var5); \
	vsel(var3, var11, var0, var2); \
	vxor(var2, var6, var3); \
	vsel(var3, var0, var2, var1); \
	vxor(*out3, *out3, var3); \

#define s3(out1, out2, out3, out4) \
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
	vxor(*out2, *out2, var14); \
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
	vxor(*out1, *out1, var7); \
	vsel(var7, var2, var8, var4); \
	vsel(var4, var16, var9, var3); \
	vsel(var3, var7, var14, var4); \
	vsel(var7, var6, var3, var0); \
	vxor(*out4, *out4, var7); \
	vsel(var3, var2, var1, var12); \
	vsel(var1, var3, var4, var5); \
	vxor(var2, var11, var1); \
	vsel(var1, var2, var13, var0); \
	vxor(*out3, *out3, var1); \

#define s4(out1, out2, out3, out4) \
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
	vxor(*out3, *out3, var8); \
	vsel(var2, var4, var11, var5); \
	vxor(*out4, *out4, var2); \
	vsel(var2, var1, var3, var10); \
	vsel(var1, var9, var2, var7); \
	vxor(var2, var0, var1); \
	vxor(var1, var11, var2); \
	vsel(var2, var0, var1, var5); \
	vxor(*out1, *out1, var2); \
	vsel(var0, var1, var6, var5); \
	vxor(*out2, *out2, var0); \
/*
label_05D5:
  v_xor_b32     v87, s8, v50                                // 00001754: 3AAE6408
  v_xor_b32     v85, s7, v65                                // 00001758: 3AAA8207
  v_bfe_i32     v68, v0, 7, 1                               // 0000175C: D2920044 02050F00
  v_xor_b32     v81, v68, v48                               // 00001764: 3AA26144
  v_bfe_i32     v69, v0, 9, 1                               // 00001768: D2920045 02051300
  v_xor_b32     v88, v69, v46                               // 00001770: 3AB05D45
  v_xor_b32     v86, 0x33333333, v63                        // 00001774: 3AAC7EFF 33333333
  v_mov_b32     v71, v61                                    // 0000177C: 7E8E033D
label_05E0:
  v_bfi_b32     v72, v88, v81, v87                          // 00001780: D2940048 055EA358
  v_not_b32     v73, v72                                    // 00001788: 7E926F48
  v_bfi_b32     v74, v81, v87, v73                          // 0000178C: D294004A 0526AF51
  v_xor_b32     v75, v85, v74                               // 00001794: 3A969555
  v_xor_b32     v76, v88, v71                               // 00001798: 3A988F58
  v_xor_b32     v77, v75, v76                               // 0000179C: 3A9A994B
  v_bfi_b32     v78, v75, v77, v85                          // 000017A0: D294004E 05569B4B
  v_bfi_b32     v79, v78, v72, v71                          // 000017A8: D294004F 051E914E
  v_bfi_b32     v80, v87, v88, v79                          // 000017B0: D2940050 053EB157
  v_bfi_b32     v69, v85, v73, v81                          // 000017B8: D2940045 05469355
  v_xor_b32     v81, v80, v69                               // 000017C0: 3AA28B50
  v_bfi_b32     v82, v75, v81, v76                          // 000017C4: D2940052 0532A34B
  v_bfi_b32     v83, v82, v87, v71                          // 000017CC: D2940053 051EAF52
  v_bfi_b32     v78, v83, v71, v78                          // 000017D4: D294004E 053A8F53
  v_xor_b32     v84, v81, v78                               // 000017DC: 3AA89D51
  v_bfi_b32     v81, v86, v81, v84                          // 000017E0: D2940051 0552A356
  v_xor_b32     v9, v81, v9                                 // 000017E8: 3A121351
  v_bfi_b32     v73, v82, v79, v73                          // 000017EC: D2940049 05269F52
  v_bfi_b32     v66, v87, v72, v78                          // 000017F4: D2940042 053A9157
  v_xor_b32     v72, v73, v66                               // 000017FC: 3A908549
  v_bfi_b32     v79, v86, v77, v72                          // 00001800: D294004F 05229B56
  v_xor_b32     v20, v79, v20                               // 00001808: 3A28294F
  v_bfi_b32     v79, v71, v66, v72                          // 0000180C: D294004F 05228547
  v_bfi_b32     v80, v85, v80, v79                          // 00001814: D2940050 053EA155
  v_bfi_b32     v67, v77, v85, v69                          // 0000181C: D2940043 0516AB4D
  v_bfi_b32     v81, v72, v67, v80                          // 00001824: D2940051 05428748
  v_bfi_b32     v70, v77, v72, v88                          // 0000182C: D2940046 0562914D
  v_bfi_b32     v66, v70, v76, v66                          // 00001834: D2940042 050A9946
  v_bfi_b32     v67, v67, v80, v78                          // 0000183C: D2940043 053AA143
  v_xor_b32     v66, v66, v67                               // 00001844: 3A848742
  v_bfi_b32     v66, v86, v66, v81                          // 00001848: D2940042 05468556
  v_xor_b32     v31, v66, v31                               // 00001850: 3A3E3F42
  v_bfi_b32     v66, v73, v84, v75                          // 00001854: D2940042 052EA949
  v_bfi_b32     v66, v80, v66, v70                          // 0000185C: D2940042 051A8550
  v_bfi_b32     v67, v71, v74, v69                          // 00001864: D2940043 05169547
  v_bfi_b32     v69, v83, v77, v75                          // 0000186C: D2940045 052E9B53
  v_bfi_b32     v67, v79, v69, v67                          // 00001874: D2940043 050E8B4F
  v_bfi_b32     v66, v86, v66, v67                          // 0000187C: D2940042 050E8556
  v_xor_b32     v26, v66, v26                               // 00001884: 3A343542
*/

#define s5(out1, out2, out3, out4) \
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
	vxor(*out3, *out3, var19); \
	vsel(var15, var7, var13, var16); \
	vsel(var7, var18, var6, var0); \
	vxor(var0, var15, var7); \
	vsel(var6, var0, var11, var3); \
	vxor(*out2, *out2, var6); \
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
	vxor(*out4, *out4, var0); \
	vsel(var0, var12, var8, var5); \
	vsel(var1, var9, var11, var17); \
	vsel(var4, var0, var1, var6); \
	vsel(var0, var4, var2, var3); \
	vxor(*out1, *out1, var0); \

#define s6(out1, out2, out3, out4) \
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
	vxor(*out1, *out1, var14); \
	vsel(var11, var9, var16, var1); \
	vsel(var1, var0, var3, var11); \
	vxor(var0, var7, var1); \
	vsel(var9, var7, var0, var5); \
	vxor(*out4, *out4, var9); \
	vsel(var7, var12, var8, var10); \
	vsel(var9, var7, var15, var13); \
	vxor(var10, var0, var9); \
	vxor(var9, var6, var10); \
	vsel(var6, var4, var16, var3); \
	vsel(var3, var9, var10, var6); \
	vnot(var4, var3); \
	vsel(var3, var4, var9, var5); \
	vxor(*out2, *out2, var3); \
	vsel(var3, var6, var0, var10); \
	vsel(var0, var1, var7, var8); \
	vxor(var1, var3, var0); \
	vsel(var0, var2, var1, var5); \
	vxor(*out3, *out3, var0); \

#define s7(out1, out2, out3, out4)\
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
	vxor(*out1, *out1, var14); \
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
	vxor(*out2, *out2, var7); \
	vxor(var7, var11, var1); \
	vsel(var1, var16, var7, var5); \
	vsel(var5, var1, var6, var4); \
	vsel(var1, var5, var10, var0); \
	vxor(*out3, *out3, var1); \
	vsel(var1, var14, var13, var9); \
	vxor(var4, var14, var7); \
	vsel(var5, var1, var4, var3); \
	vsel(var1, var16, var6, var13); \
	vsel(var3, var5, var2, var1); \
	vnot(var1, var3); \
	vsel(var2, var5, var1, var0); \
	vxor(*out4, *out4, var2); \                    

#define s8(out1, out2, out3, out4)\
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
	vxor(*out3, *out3, var12); \
	vsel(var12, var11, var8, var4); \
	vxor(var4, var3, var12); \
	vxor(var3, var6, var4); \
	vnot(var8, var3); \
	vsel(var13, var9, var1, var12); \
	vsel(var12, var8, var13, var7); \
	vxor(var14, var4, var12); \
	vsel(var4, var14, var6, var5); \
	vxor(*out2, *out2, var4); \
	vsel(var4, var10, var11, var13); \
	vsel(var6, var9, var4, var2); \
	vxor(var4, var8, var6); \
	vsel(var6, var8, var4, var5); \
	vxor(*out4, *out4, var6); \
	vsel(var4, var9, var1, var2); \
	vor(var1, var0, var7); \
	vxor(var0, var4, var1); \
	vxor(var1, var12, var0); \
	vsel(var0, var1, var3, var5); \
	vxor(*out1, *out1, var0); \

#define z(r) (db + (r))

#define K00XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  0)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K01XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  1)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K02XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  2)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K03XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  3)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K04XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  4)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K05XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  5)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K06XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  6)); if (var6) (dest) = ~(val); else (dest) = (val)

/*
#define K07XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  7)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K08XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  8)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K09XOR(dest, val) var6 = (keyFrom00To27 & (0x1U <<  9)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K10XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 10)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K11XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 11)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K12XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 12)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K13XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 13)); if (var6) (dest) = ~(val); else (dest) = (val)

#define K14XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 14)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K15XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 15)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K16XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 16)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K17XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 17)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K18XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 18)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K19XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 19)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K20XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 20)); if (var6) (dest) = ~(val); else (dest) = (val)
*/

#define K21XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 21)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K22XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 22)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K23XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 23)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K24XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 24)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K25XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 25)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K26XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 26)); if (var6) (dest) = ~(val); else (dest) = (val)
#define K27XOR(dest, val) var6 = (keyFrom00To27 & (0x1U << 27)); if (var6) (dest) = ~(val); else (dest) = (val)

#define K28XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (28 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K29XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (29 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K30XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (30 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K31XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (31 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K32XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (32 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K33XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (33 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K34XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (34 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)

#define K35XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (35 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K36XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (36 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K37XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (37 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K38XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (38 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K39XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (39 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K40XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (40 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K41XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (41 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)

#define K42XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (42 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K43XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (43 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K44XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (44 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K45XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (45 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K46XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (46 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K47XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (47 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)
#define K48XOR(dest, val) var6 = (keyFrom28To48 & (0x1U << (48 - 28))); if (var6) (dest) = ~(val); else (dest) = (val)

void DES_Crypt(volatile vtype *db, unsigned int keyFrom00To27, volatile unsigned int keyFrom28To48)
{
	// NumVgprs = 88/89;
	// We could go further with different s2 (opencl_sboxes-s.h) and s5 (nonstd.c)

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
#ifndef EXPERIMENTAL
	 vtype var14; 
	 vtype var15; 
	 vtype var16; 
	 vtype var17; 
	 vtype var18; 
	 vtype var19; 
#endif


	for (int i = 0; i < 64; ++i)
		db[i] = 0x00000000;

	 int iterations           = 25;
	 int roundsAndSwapped     = 8; 
	 int round = 0;


	/*
	unsigned int K48 = ((keyFrom28To48 & (0x1U << (48 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K47 = ((keyFrom28To48 & (0x1U << (47 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K46 = ((keyFrom28To48 & (0x1U << (46 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K45 = ((keyFrom28To48 & (0x1U << (45 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K44 = ((keyFrom28To48 & (0x1U << (44 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K43 = ((keyFrom28To48 & (0x1U << (43 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K42 = ((keyFrom28To48 & (0x1U << (42 - 28))) ? 0xffffffffU : 0x00000000U);

	unsigned int K41 = ((keyFrom28To48 & (0x1U << (41 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K40 = ((keyFrom28To48 & (0x1U << (40 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K39 = ((keyFrom28To48 & (0x1U << (39 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K38 = ((keyFrom28To48 & (0x1U << (38 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K37 = ((keyFrom28To48 & (0x1U << (37 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K36 = ((keyFrom28To48 & (0x1U << (36 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K35 = ((keyFrom28To48 & (0x1U << (35 - 28))) ? 0xffffffffU : 0x00000000U);

	unsigned int K34 = ((keyFrom28To48 & (0x1U << (34 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K33 = ((keyFrom28To48 & (0x1U << (33 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K32 = ((keyFrom28To48 & (0x1U << (32 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K31 = ((keyFrom28To48 & (0x1U << (31 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K30 = ((keyFrom28To48 & (0x1U << (30 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K29 = ((keyFrom28To48 & (0x1U << (29 - 28))) ? 0xffffffffU : 0x00000000U);
	unsigned int K28 = ((keyFrom28To48 & (0x1U << (28 - 28))) ? 0xffffffffU : 0x00000000U);

	keyCache[0] = ((keyFrom28To48 & (0x1U << (28 - 28))) ? 0xffffffffU : 0x00000000U);
	keyCache[1] = ((keyFrom28To48 & (0x1U << (29 - 28))) ? 0xffffffffU : 0x00000000U);
	keyCache[2] = ((keyFrom28To48 & (0x1U << (30 - 28))) ? 0xffffffffU : 0x00000000U);
	keyCache[3] = ((keyFrom28To48 & (0x1U << (31 - 28))) ? 0xffffffffU : 0x00000000U);
	keyCache[4] = ((keyFrom28To48 & (0x1U << (32 - 28))) ? 0xffffffffU : 0x00000000U);
	keyCache[5] = ((keyFrom28To48 & (0x1U << (33 - 28))) ? 0xffffffffU : 0x00000000U);
	keyCache[6] = ((keyFrom28To48 & (0x1U << (34 - 28))) ? 0xffffffffU : 0x00000000U);
	*/

start:
	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K12XOR(var0, db[EF00]); K46XOR(var1, db[EF01]); K33XOR(var2, db[EF02]); K52XOR(var3, db[EF03]); K48XOR(var4, db[EF04]); K20XOR(var5, db[EF05]);
				} else {
					K05XOR(var0, db[EF00]); K39XOR(var1, db[EF01]); K26XOR(var2, db[EF02]); K45XOR(var3, db[EF03]); K41XOR(var4, db[EF04]); K13XOR(var5, db[EF05]);
				}
			} else {
				if (round == 2) {
					K46XOR(var0, db[EF00]); K25XOR(var1, db[EF01]); K12XOR(var2, db[EF02]); K31XOR(var3, db[EF03]); K27XOR(var4, db[EF04]); K54XOR(var5, db[EF05]);
				} else {
					K32XOR(var0, db[EF00]); K11XOR(var1, db[EF01]); K53XOR(var2, db[EF02]); K48XOR(var3, db[EF03]); K13XOR(var4, db[EF04]); K40XOR(var5, db[EF05]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K18XOR(var0, db[EF00]); K52XOR(var1, db[EF01]); K39XOR(var2, db[EF02]); K34XOR(var3, db[EF03]); K54XOR(var4, db[EF04]); K26XOR(var5, db[EF05]);
				} else {
					K04XOR(var0, db[EF00]); K38XOR(var1, db[EF01]); K25XOR(var2, db[EF02]); K20XOR(var3, db[EF03]); K40XOR(var4, db[EF04]); K12XOR(var5, db[EF05]);
				}
			} else {
				if (round == 6) {
					K45XOR(var0, db[EF00]); K55XOR(var1, db[EF01]); K11XOR(var2, db[EF02]); K06XOR(var3, db[EF03]); K26XOR(var4, db[EF04]); K53XOR(var5, db[EF05]);
				} else {
					K31XOR(var0, db[EF00]); K41XOR(var1, db[EF01]); K52XOR(var2, db[EF02]); K47XOR(var3, db[EF03]); K12XOR(var4, db[EF04]); K39XOR(var5, db[EF05]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K55XOR(var0, db[EF00]); K34XOR(var1, db[EF01]); K45XOR(var2, db[EF02]); K40XOR(var3, db[EF03]); K05XOR(var4, db[EF04]); K32XOR(var5, db[EF05]);
				} else {
					K41XOR(var0, db[EF00]); K20XOR(var1, db[EF01]); K31XOR(var2, db[EF02]); K26XOR(var3, db[EF03]); K46XOR(var4, db[EF04]); K18XOR(var5, db[EF05]);
				}
			} else {
				if (round == 10) {
					K27XOR(var0, db[EF00]); K06XOR(var1, db[EF01]); K48XOR(var2, db[EF02]); K12XOR(var3, db[EF03]); K32XOR(var4, db[EF04]); K04XOR(var5, db[EF05]);
				} else {
					K13XOR(var0, db[EF00]); K47XOR(var1, db[EF01]); K34XOR(var2, db[EF02]); K53XOR(var3, db[EF03]); K18XOR(var4, db[EF04]); K45XOR(var5, db[EF05]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K54XOR(var0, db[EF00]); K33XOR(var1, db[EF01]); K20XOR(var2, db[EF02]); K39XOR(var3, db[EF03]); K04XOR(var4, db[EF04]); K31XOR(var5, db[EF05]);
				} else {
					K40XOR(var0, db[EF00]); K19XOR(var1, db[EF01]); K06XOR(var2, db[EF02]); K25XOR(var3, db[EF03]); K45XOR(var4, db[EF04]); K48XOR(var5, db[EF05]);
				}
			} else {
				if (round == 14) {
					K26XOR(var0, db[EF00]); K05XOR(var1, db[EF01]); K47XOR(var2, db[EF02]); K11XOR(var3, db[EF03]); K31XOR(var4, db[EF04]); K34XOR(var5, db[EF05]);
				} else {
					K19XOR(var0, db[EF00]); K53XOR(var1, db[EF01]); K40XOR(var2, db[EF02]); K04XOR(var3, db[EF03]); K55XOR(var4, db[EF04]); K27XOR(var5, db[EF05]);
				}
			}
		}	
	}
	s1(z(40), z(48), z(54), z(62));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K34XOR(var0, db[EF06]); K55XOR(var1, db[EF07]); K05XOR(var2, db[EF08]); K13XOR(var3, db[EF09]); K18XOR(var4, db[EF10]); K40XOR(var5, db[EF11]);
				} else {
					K27XOR(var0, db[EF06]); K48XOR(var1, db[EF07]); K53XOR(var2, db[EF08]); K06XOR(var3, db[EF09]); K11XOR(var4, db[EF10]); K33XOR(var5, db[EF11]);
				}
			} else {
				if (round == 2) {
					K13XOR(var0, db[EF06]); K34XOR(var1, db[EF07]); K39XOR(var2, db[EF08]); K47XOR(var3, db[EF09]); K52XOR(var4, db[EF10]); K19XOR(var5, db[EF11]);
				} else {
					K54XOR(var0, db[EF06]); K20XOR(var1, db[EF07]); K25XOR(var2, db[EF08]); K33XOR(var3, db[EF09]); K38XOR(var4, db[EF10]); K05XOR(var5, db[EF11]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K40XOR(var0, db[EF06]); K06XOR(var1, db[EF07]); K11XOR(var2, db[EF08]); K19XOR(var3, db[EF09]); K55XOR(var4, db[EF10]); K46XOR(var5, db[EF11]);
				} else {
					K26XOR(var0, db[EF06]); K47XOR(var1, db[EF07]); K52XOR(var2, db[EF08]); K05XOR(var3, db[EF09]); K41XOR(var4, db[EF10]); K32XOR(var5, db[EF11]);
				}
			} else {
				if (round == 6) {
					K12XOR(var0, db[EF06]); K33XOR(var1, db[EF07]); K38XOR(var2, db[EF08]); K46XOR(var3, db[EF09]); K27XOR(var4, db[EF10]); K18XOR(var5, db[EF11]);
				} else {
					K53XOR(var0, db[EF06]); K19XOR(var1, db[EF07]); K55XOR(var2, db[EF08]); K32XOR(var3, db[EF09]); K13XOR(var4, db[EF10]); K04XOR(var5, db[EF11]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K46XOR(var0, db[EF06]); K12XOR(var1, db[EF07]); K48XOR(var2, db[EF08]); K25XOR(var3, db[EF09]); K06XOR(var4, db[EF10]); K52XOR(var5, db[EF11]);
				} else {
					K32XOR(var0, db[EF06]); K53XOR(var1, db[EF07]); K34XOR(var2, db[EF08]); K11XOR(var3, db[EF09]); K47XOR(var4, db[EF10]); K38XOR(var5, db[EF11]);
				}
			} else {
				if (round == 10) {
					K18XOR(var0, db[EF06]); K39XOR(var1, db[EF07]); K20XOR(var2, db[EF08]); K52XOR(var3, db[EF09]); K33XOR(var4, db[EF10]); K55XOR(var5, db[EF11]);
				} else {
					K04XOR(var0, db[EF06]); K25XOR(var1, db[EF07]); K06XOR(var2, db[EF08]); K38XOR(var3, db[EF09]); K19XOR(var4, db[EF10]); K41XOR(var5, db[EF11]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K45XOR(var0, db[EF06]); K11XOR(var1, db[EF07]); K47XOR(var2, db[EF08]); K55XOR(var3, db[EF09]); K05XOR(var4, db[EF10]); K27XOR(var5, db[EF11]);
				} else {
					K31XOR(var0, db[EF06]); K52XOR(var1, db[EF07]); K33XOR(var2, db[EF08]); K41XOR(var3, db[EF09]); K46XOR(var4, db[EF10]); K13XOR(var5, db[EF11]);
				}
			} else {
				if (round == 14) {
					K48XOR(var0, db[EF06]); K38XOR(var1, db[EF07]); K19XOR(var2, db[EF08]); K27XOR(var3, db[EF09]); K32XOR(var4, db[EF10]); K54XOR(var5, db[EF11]);
				} else {
					K41XOR(var0, db[EF06]); K31XOR(var1, db[EF07]); K12XOR(var2, db[EF08]); K20XOR(var3, db[EF09]); K25XOR(var4, db[EF10]); K47XOR(var5, db[EF11]);
				}
			}
		}	
	}
	s2(z(44), z(59), z(33), z(49)); 

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K04XOR(var0, db[   7]); K32XOR(var1, db[   8]); K26XOR(var2, db[   9]); K27XOR(var3, db[  10]); K38XOR(var4, db[  11]); K54XOR(var5, db[  12]);
				} else {
					K52XOR(var0, db[   7]); K25XOR(var1, db[   8]); K19XOR(var2, db[   9]); K20XOR(var3, db[  10]); K31XOR(var4, db[  11]); K47XOR(var5, db[  12]);
				}
			} else {
				if (round == 2) {
					K38XOR(var0, db[   7]); K11XOR(var1, db[   8]); K05XOR(var2, db[   9]); K06XOR(var3, db[  10]); K48XOR(var4, db[  11]); K33XOR(var5, db[  12]);
				} else {
					K55XOR(var0, db[   7]); K52XOR(var1, db[   8]); K46XOR(var2, db[   9]); K47XOR(var3, db[  10]); K34XOR(var4, db[  11]); K19XOR(var5, db[  12]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K41XOR(var0, db[   7]); K38XOR(var1, db[   8]); K32XOR(var2, db[   9]); K33XOR(var3, db[  10]); K20XOR(var4, db[  11]); K05XOR(var5, db[  12]);
				} else {
					K27XOR(var0, db[   7]); K55XOR(var1, db[   8]); K18XOR(var2, db[   9]); K19XOR(var3, db[  10]); K06XOR(var4, db[  11]); K46XOR(var5, db[  12]);
				}
			} else {
				if (round == 6) {
					K13XOR(var0, db[   7]); K41XOR(var1, db[   8]); K04XOR(var2, db[   9]); K05XOR(var3, db[  10]); K47XOR(var4, db[  11]); K32XOR(var5, db[  12]);
				} else {
					K54XOR(var0, db[   7]); K27XOR(var1, db[   8]); K45XOR(var2, db[   9]); K46XOR(var3, db[  10]); K33XOR(var4, db[  11]); K18XOR(var5, db[  12]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K47XOR(var0, db[   7]); K20XOR(var1, db[   8]); K38XOR(var2, db[   9]); K39XOR(var3, db[  10]); K26XOR(var4, db[  11]); K11XOR(var5, db[  12]);
				} else {
					K33XOR(var0, db[   7]); K06XOR(var1, db[   8]); K55XOR(var2, db[   9]); K25XOR(var3, db[  10]); K12XOR(var4, db[  11]); K52XOR(var5, db[  12]);
				}
			} else {
				if (round == 10) {
					K19XOR(var0, db[   7]); K47XOR(var1, db[   8]); K41XOR(var2, db[   9]); K11XOR(var3, db[  10]); K53XOR(var4, db[  11]); K38XOR(var5, db[  12]);
				} else {
					K05XOR(var0, db[   7]); K33XOR(var1, db[   8]); K27XOR(var2, db[   9]); K52XOR(var3, db[  10]); K39XOR(var4, db[  11]); K55XOR(var5, db[  12]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K46XOR(var0, db[   7]); K19XOR(var1, db[   8]); K13XOR(var2, db[   9]); K38XOR(var3, db[  10]); K25XOR(var4, db[  11]); K41XOR(var5, db[  12]);
				} else {
					K32XOR(var0, db[   7]); K05XOR(var1, db[   8]); K54XOR(var2, db[   9]); K55XOR(var3, db[  10]); K11XOR(var4, db[  11]); K27XOR(var5, db[  12]);
				}
			} else {
				if (round == 14) {
					K18XOR(var0, db[   7]); K46XOR(var1, db[   8]); K40XOR(var2, db[   9]); K41XOR(var3, db[  10]); K52XOR(var4, db[  11]); K13XOR(var5, db[  12]);
				} else {
					K11XOR(var0, db[   7]); K39XOR(var1, db[   8]); K33XOR(var2, db[   9]); K34XOR(var3, db[  10]); K45XOR(var4, db[  11]); K06XOR(var5, db[  12]);
				}
			}
		}	
	}
	s3(z(55), z(47), z(61), z(37));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K53XOR(var0, db[  11]); K06XOR(var1, db[  12]); K31XOR(var2, db[  13]); K25XOR(var3, db[  14]); K19XOR(var4, db[  15]); K41XOR(var5, db[  16]);
				} else {
					K46XOR(var0, db[  11]); K54XOR(var1, db[  12]); K55XOR(var2, db[  13]); K18XOR(var3, db[  14]); K12XOR(var4, db[  15]); K34XOR(var5, db[  16]);
				}
			} else {
				if (round == 2) {
					K32XOR(var0, db[  11]); K40XOR(var1, db[  12]); K41XOR(var2, db[  13]); K04XOR(var3, db[  14]); K53XOR(var4, db[  15]); K20XOR(var5, db[  16]);
				} else {
					K18XOR(var0, db[  11]); K26XOR(var1, db[  12]); K27XOR(var2, db[  13]); K45XOR(var3, db[  14]); K39XOR(var4, db[  15]); K06XOR(var5, db[  16]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K04XOR(var0, db[  11]); K12XOR(var1, db[  12]); K13XOR(var2, db[  13]); K31XOR(var3, db[  14]); K25XOR(var4, db[  15]); K47XOR(var5, db[  16]);
				} else {
					K45XOR(var0, db[  11]); K53XOR(var1, db[  12]); K54XOR(var2, db[  13]); K48XOR(var3, db[  14]); K11XOR(var4, db[  15]); K33XOR(var5, db[  16]);
				}
			} else {
				if (round == 6) {
					K31XOR(var0, db[  11]); K39XOR(var1, db[  12]); K40XOR(var2, db[  13]); K34XOR(var3, db[  14]); K52XOR(var4, db[  15]); K19XOR(var5, db[  16]);
				} else {
					K48XOR(var0, db[  11]); K25XOR(var1, db[  12]); K26XOR(var2, db[  13]); K20XOR(var3, db[  14]); K38XOR(var4, db[  15]); K05XOR(var5, db[  16]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K41XOR(var0, db[  11]); K18XOR(var1, db[  12]); K19XOR(var2, db[  13]); K13XOR(var3, db[  14]); K31XOR(var4, db[  15]); K53XOR(var5, db[  16]);
				} else {
					K27XOR(var0, db[  11]); K04XOR(var1, db[  12]); K05XOR(var2, db[  13]); K54XOR(var3, db[  14]); K48XOR(var4, db[  15]); K39XOR(var5, db[  16]);
				}
			} else {
				if (round == 10) {
					K13XOR(var0, db[  11]); K45XOR(var1, db[  12]); K46XOR(var2, db[  13]); K40XOR(var3, db[  14]); K34XOR(var4, db[  15]); K25XOR(var5, db[  16]);
				} else {
					K54XOR(var0, db[  11]); K31XOR(var1, db[  12]); K32XOR(var2, db[  13]); K26XOR(var3, db[  14]); K20XOR(var4, db[  15]); K11XOR(var5, db[  16]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K40XOR(var0, db[  11]); K48XOR(var1, db[  12]); K18XOR(var2, db[  13]); K12XOR(var3, db[  14]); K06XOR(var4, db[  15]); K52XOR(var5, db[  16]);
				} else {
					K26XOR(var0, db[  11]); K34XOR(var1, db[  12]); K04XOR(var2, db[  13]); K53XOR(var3, db[  14]); K47XOR(var4, db[  15]); K38XOR(var5, db[  16]);
				}
			} else {
				if (round == 14) {
					K12XOR(var0, db[  11]); K20XOR(var1, db[  12]); K45XOR(var2, db[  13]); K39XOR(var3, db[  14]); K33XOR(var4, db[  15]); K55XOR(var5, db[  16]);
				} else {
					K05XOR(var0, db[  11]); K13XOR(var1, db[  12]); K38XOR(var2, db[  13]); K32XOR(var3, db[  14]); K26XOR(var4, db[  15]); K48XOR(var5, db[  16]);
				}
			}
		}	
	}
	s4(z(57), z(51), z(41), z(32));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K15XOR(var0, db[EF24]); K24XOR(var1, db[EF25]); K28XOR(var2, db[EF26]); K43XOR(var3, db[EF27]); K30XOR(var4, db[EF28]); K03XOR(var5, db[EF29]);
				} else {
					K08XOR(var0, db[EF24]); K17XOR(var1, db[EF25]); K21XOR(var2, db[EF26]); K36XOR(var3, db[EF27]); K23XOR(var4, db[EF28]); K49XOR(var5, db[EF29]);
				}
			} else {
				if (round == 2) {
					K51XOR(var0, db[EF24]); K03XOR(var1, db[EF25]); K07XOR(var2, db[EF26]); K22XOR(var3, db[EF27]); K09XOR(var4, db[EF28]); K35XOR(var5, db[EF29]);
				} else {
					K37XOR(var0, db[EF24]); K42XOR(var1, db[EF25]); K50XOR(var2, db[EF26]); K08XOR(var3, db[EF27]); K24XOR(var4, db[EF28]); K21XOR(var5, db[EF29]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K23XOR(var0, db[EF24]); K28XOR(var1, db[EF25]); K36XOR(var2, db[EF26]); K51XOR(var3, db[EF27]); K10XOR(var4, db[EF28]); K07XOR(var5, db[EF29]);
				} else {
					K09XOR(var0, db[EF24]); K14XOR(var1, db[EF25]); K22XOR(var2, db[EF26]); K37XOR(var3, db[EF27]); K49XOR(var4, db[EF28]); K50XOR(var5, db[EF29]);
				}
			} else {
				if (round == 6) {
					K24XOR(var0, db[EF24]); K00XOR(var1, db[EF25]); K08XOR(var2, db[EF26]); K23XOR(var3, db[EF27]); K35XOR(var4, db[EF28]); K36XOR(var5, db[EF29]);
				} else {
					K10XOR(var0, db[EF24]); K43XOR(var1, db[EF25]); K51XOR(var2, db[EF26]); K09XOR(var3, db[EF27]); K21XOR(var4, db[EF28]); K22XOR(var5, db[EF29]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K03XOR(var0, db[EF24]); K36XOR(var1, db[EF25]); K44XOR(var2, db[EF26]); K02XOR(var3, db[EF27]); K14XOR(var4, db[EF28]); K15XOR(var5, db[EF29]);
				} else {
					K42XOR(var0, db[EF24]); K22XOR(var1, db[EF25]); K30XOR(var2, db[EF26]); K17XOR(var3, db[EF27]); K00XOR(var4, db[EF28]); K01XOR(var5, db[EF29]);
				}
			} else {
				if (round == 10) {
					K28XOR(var0, db[EF24]); K08XOR(var1, db[EF25]); K16XOR(var2, db[EF26]); K03XOR(var3, db[EF27]); K43XOR(var4, db[EF28]); K44XOR(var5, db[EF29]);
				} else {
					K14XOR(var0, db[EF24]); K51XOR(var1, db[EF25]); K02XOR(var2, db[EF26]); K42XOR(var3, db[EF27]); K29XOR(var4, db[EF28]); K30XOR(var5, db[EF29]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K00XOR(var0, db[EF24]); K37XOR(var1, db[EF25]); K17XOR(var2, db[EF26]); K28XOR(var3, db[EF27]); K15XOR(var4, db[EF28]); K16XOR(var5, db[EF29]);
				} else {
					K43XOR(var0, db[EF24]); K23XOR(var1, db[EF25]); K03XOR(var2, db[EF26]); K14XOR(var3, db[EF27]); K01XOR(var4, db[EF28]); K02XOR(var5, db[EF29]);
				}
			} else {
				if (round == 14) {
					K29XOR(var0, db[EF24]); K09XOR(var1, db[EF25]); K42XOR(var2, db[EF26]); K00XOR(var3, db[EF27]); K44XOR(var4, db[EF28]); K17XOR(var5, db[EF29]);
				} else {
					K22XOR(var0, db[EF24]); K02XOR(var1, db[EF25]); K35XOR(var2, db[EF26]); K50XOR(var3, db[EF27]); K37XOR(var4, db[EF28]); K10XOR(var5, db[EF29]);
				}
			}
		}	
	}
	s5(z(39), z(45), z(56), z(34));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K35XOR(var0, db[EF30]); K22XOR(var1, db[EF31]); K02XOR(var2, db[EF32]); K44XOR(var3, db[EF33]); K14XOR(var4, db[EF34]); K23XOR(var5, db[EF35]);
				} else {
					K28XOR(var0, db[EF30]); K15XOR(var1, db[EF31]); K24XOR(var2, db[EF32]); K37XOR(var3, db[EF33]); K07XOR(var4, db[EF34]); K16XOR(var5, db[EF35]);
				}
			} else {
				if (round == 2) {
					K14XOR(var0, db[EF30]); K01XOR(var1, db[EF31]); K10XOR(var2, db[EF32]); K23XOR(var3, db[EF33]); K50XOR(var4, db[EF34]); K02XOR(var5, db[EF35]);
				} else {
					K00XOR(var0, db[EF30]); K44XOR(var1, db[EF31]); K49XOR(var2, db[EF32]); K09XOR(var3, db[EF33]); K36XOR(var4, db[EF34]); K17XOR(var5, db[EF35]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K43XOR(var0, db[EF30]); K30XOR(var1, db[EF31]); K35XOR(var2, db[EF32]); K24XOR(var3, db[EF33]); K22XOR(var4, db[EF34]); K03XOR(var5, db[EF35]);
				} else {
					K29XOR(var0, db[EF30]); K16XOR(var1, db[EF31]); K21XOR(var2, db[EF32]); K10XOR(var3, db[EF33]); K08XOR(var4, db[EF34]); K42XOR(var5, db[EF35]);
				}
			} else {
				if (round == 6) {
					K15XOR(var0, db[EF30]); K02XOR(var1, db[EF31]); K07XOR(var2, db[EF32]); K49XOR(var3, db[EF33]); K51XOR(var4, db[EF34]); K28XOR(var5, db[EF35]);
				} else {
					K01XOR(var0, db[EF30]); K17XOR(var1, db[EF31]); K50XOR(var2, db[EF32]); K35XOR(var3, db[EF33]); K37XOR(var4, db[EF34]); K14XOR(var5, db[EF35]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K51XOR(var0, db[EF30]); K10XOR(var1, db[EF31]); K43XOR(var2, db[EF32]); K28XOR(var3, db[EF33]); K30XOR(var4, db[EF34]); K07XOR(var5, db[EF35]);
				} else {
					K37XOR(var0, db[EF30]); K49XOR(var1, db[EF31]); K29XOR(var2, db[EF32]); K14XOR(var3, db[EF33]); K16XOR(var4, db[EF34]); K50XOR(var5, db[EF35]);
				}
			} else {
				if (round == 10) {
					K23XOR(var0, db[EF30]); K35XOR(var1, db[EF31]); K15XOR(var2, db[EF32]); K00XOR(var3, db[EF33]); K02XOR(var4, db[EF34]); K36XOR(var5, db[EF35]);
				} else {
					K09XOR(var0, db[EF30]); K21XOR(var1, db[EF31]); K01XOR(var2, db[EF32]); K43XOR(var3, db[EF33]); K17XOR(var4, db[EF34]); K22XOR(var5, db[EF35]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K24XOR(var0, db[EF30]); K07XOR(var1, db[EF31]); K44XOR(var2, db[EF32]); K29XOR(var3, db[EF33]); K03XOR(var4, db[EF34]); K08XOR(var5, db[EF35]);
				} else {
					K10XOR(var0, db[EF30]); K50XOR(var1, db[EF31]); K30XOR(var2, db[EF32]); K15XOR(var3, db[EF33]); K42XOR(var4, db[EF34]); K51XOR(var5, db[EF35]);
				}
			} else {
				if (round == 14) {
					K49XOR(var0, db[EF30]); K36XOR(var1, db[EF31]); K16XOR(var2, db[EF32]); K01XOR(var3, db[EF33]); K28XOR(var4, db[EF34]); K37XOR(var5, db[EF35]);
				} else {
					K42XOR(var0, db[EF30]); K29XOR(var1, db[EF31]); K09XOR(var2, db[EF32]); K51XOR(var3, db[EF33]); K21XOR(var4, db[EF34]); K30XOR(var5, db[EF35]);
				}
			}
		}	
	}
	s6(z(35), z(60), z(42), z(50));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K51XOR(var0, db[  23]); K16XOR(var1, db[  24]); K29XOR(var2, db[  25]); K49XOR(var3, db[  26]); K07XOR(var4, db[  27]); K17XOR(var5, db[  28]);
				} else {
					K44XOR(var0, db[  23]); K09XOR(var1, db[  24]); K22XOR(var2, db[  25]); K42XOR(var3, db[  26]); K00XOR(var4, db[  27]); K10XOR(var5, db[  28]);
				}
			} else {
				if (round == 2) {
					K30XOR(var0, db[  23]); K24XOR(var1, db[  24]); K08XOR(var2, db[  25]); K28XOR(var3, db[  26]); K43XOR(var4, db[  27]); K49XOR(var5, db[  28]);
				} else {
					K16XOR(var0, db[  23]); K10XOR(var1, db[  24]); K51XOR(var2, db[  25]); K14XOR(var3, db[  26]); K29XOR(var4, db[  27]); K35XOR(var5, db[  28]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K02XOR(var0, db[  23]); K49XOR(var1, db[  24]); K37XOR(var2, db[  25]); K00XOR(var3, db[  26]); K15XOR(var4, db[  27]); K21XOR(var5, db[  28]);
				} else {
					K17XOR(var0, db[  23]); K35XOR(var1, db[  24]); K23XOR(var2, db[  25]); K43XOR(var3, db[  26]); K01XOR(var4, db[  27]); K07XOR(var5, db[  28]);
				}
			} else {
				if (round == 6) {
					K03XOR(var0, db[  23]); K21XOR(var1, db[  24]); K09XOR(var2, db[  25]); K29XOR(var3, db[  26]); K44XOR(var4, db[  27]); K50XOR(var5, db[  28]);
				} else {
					K42XOR(var0, db[  23]); K07XOR(var1, db[  24]); K24XOR(var2, db[  25]); K15XOR(var3, db[  26]); K30XOR(var4, db[  27]); K36XOR(var5, db[  28]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K35XOR(var0, db[  23]); K00XOR(var1, db[  24]); K17XOR(var2, db[  25]); K08XOR(var3, db[  26]); K23XOR(var4, db[  27]); K29XOR(var5, db[  28]);
				} else {
					K21XOR(var0, db[  23]); K43XOR(var1, db[  24]); K03XOR(var2, db[  25]); K51XOR(var3, db[  26]); K09XOR(var4, db[  27]); K15XOR(var5, db[  28]);
				}
			} else {
				if (round == 10) {
					K07XOR(var0, db[  23]); K29XOR(var1, db[  24]); K42XOR(var2, db[  25]); K37XOR(var3, db[  26]); K24XOR(var4, db[  27]); K01XOR(var5, db[  28]);
				} else {
					K50XOR(var0, db[  23]); K15XOR(var1, db[  24]); K28XOR(var2, db[  25]); K23XOR(var3, db[  26]); K10XOR(var4, db[  27]); K44XOR(var5, db[  28]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K36XOR(var0, db[  23]); K01XOR(var1, db[  24]); K14XOR(var2, db[  25]); K09XOR(var3, db[  26]); K49XOR(var4, db[  27]); K30XOR(var5, db[  28]);
				} else {
					K22XOR(var0, db[  23]); K44XOR(var1, db[  24]); K00XOR(var2, db[  25]); K24XOR(var3, db[  26]); K35XOR(var4, db[  27]); K16XOR(var5, db[  28]);
				}
			} else {
				if (round == 14) {
					K08XOR(var0, db[  23]); K30XOR(var1, db[  24]); K43XOR(var2, db[  25]); K10XOR(var3, db[  26]); K21XOR(var4, db[  27]); K02XOR(var5, db[  28]);
				} else {
					K01XOR(var0, db[  23]); K23XOR(var1, db[  24]); K36XOR(var2, db[  25]); K03XOR(var3, db[  26]); K14XOR(var4, db[  27]); K24XOR(var5, db[  28]);
				}
			}
		}	
	}
	s7(z(63), z(43), z(53), z(38));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K37XOR(var0, db[  27]); K08XOR(var1, db[  28]); K09XOR(var2, db[  29]); K50XOR(var3, db[  30]); K42XOR(var4, db[  31]); K21XOR(var5, db[   0]);
				} else {
					K30XOR(var0, db[  27]); K01XOR(var1, db[  28]); K02XOR(var2, db[  29]); K43XOR(var3, db[  30]); K35XOR(var4, db[  31]); K14XOR(var5, db[   0]);
				}
			} else {
				if (round == 2) {
					K16XOR(var0, db[  27]); K44XOR(var1, db[  28]); K17XOR(var2, db[  29]); K29XOR(var3, db[  30]); K21XOR(var4, db[  31]); K00XOR(var5, db[   0]);
				} else {
					K02XOR(var0, db[  27]); K30XOR(var1, db[  28]); K03XOR(var2, db[  29]); K15XOR(var3, db[  30]); K07XOR(var4, db[  31]); K43XOR(var5, db[   0]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K17XOR(var0, db[  27]); K16XOR(var1, db[  28]); K42XOR(var2, db[  29]); K01XOR(var3, db[  30]); K50XOR(var4, db[  31]); K29XOR(var5, db[   0]);
				} else {
					K03XOR(var0, db[  27]); K02XOR(var1, db[  28]); K28XOR(var2, db[  29]); K44XOR(var3, db[  30]); K36XOR(var4, db[  31]); K15XOR(var5, db[   0]);
				}
			} else {
				if (round == 6) {
					K42XOR(var0, db[  27]); K17XOR(var1, db[  28]); K14XOR(var2, db[  29]); K30XOR(var3, db[  30]); K22XOR(var4, db[  31]); K01XOR(var5, db[   0]);
				} else {
					K28XOR(var0, db[  27]); K03XOR(var1, db[  28]); K00XOR(var2, db[  29]); K16XOR(var3, db[  30]); K08XOR(var4, db[  31]); K44XOR(var5, db[   0]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K21XOR(var0, db[  27]); K49XOR(var1, db[  28]); K50XOR(var2, db[  29]); K09XOR(var3, db[  30]); K01XOR(var4, db[  31]); K37XOR(var5, db[   0]);
				} else {
					K07XOR(var0, db[  27]); K35XOR(var1, db[  28]); K36XOR(var2, db[  29]); K24XOR(var3, db[  30]); K44XOR(var4, db[  31]); K23XOR(var5, db[   0]);
				}
			} else {
				if (round == 10) {
					K50XOR(var0, db[  27]); K21XOR(var1, db[  28]); K22XOR(var2, db[  29]); K10XOR(var3, db[  30]); K30XOR(var4, db[  31]); K09XOR(var5, db[   0]);
				} else {
					K36XOR(var0, db[  27]); K07XOR(var1, db[  28]); K08XOR(var2, db[  29]); K49XOR(var3, db[  30]); K16XOR(var4, db[  31]); K24XOR(var5, db[   0]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K22XOR(var0, db[  27]); K50XOR(var1, db[  28]); K51XOR(var2, db[  29]); K35XOR(var3, db[  30]); K02XOR(var4, db[  31]); K10XOR(var5, db[   0]);
				} else {
					K08XOR(var0, db[  27]); K36XOR(var1, db[  28]); K37XOR(var2, db[  29]); K21XOR(var3, db[  30]); K17XOR(var4, db[  31]); K49XOR(var5, db[   0]);
				}
			} else {
				if (round == 14) {
					K51XOR(var0, db[  27]); K22XOR(var1, db[  28]); K23XOR(var2, db[  29]); K07XOR(var3, db[  30]); K03XOR(var4, db[  31]); K35XOR(var5, db[   0]);
				} else {
					K44XOR(var0, db[  27]); K15XOR(var1, db[  28]); K16XOR(var2, db[  29]); K00XOR(var3, db[  30]); K49XOR(var4, db[  31]); K28XOR(var5, db[   0]);
				}
			}
		}	
	}
	s8(z(36), z(58), z(46), z(52));

	if (roundsAndSwapped == 0x100)
		goto next;

swap:
	++round;

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K12XOR(var0, db[EF00+32]); K46XOR(var1, db[EF01+32]); K33XOR(var2, db[EF02+32]); K52XOR(var3, db[EF03+32]); K48XOR(var4, db[EF04+32]); K20XOR(var5, db[EF05+32]);
				} else {
					K05XOR(var0, db[EF00+32]); K39XOR(var1, db[EF01+32]); K26XOR(var2, db[EF02+32]); K45XOR(var3, db[EF03+32]); K41XOR(var4, db[EF04+32]); K13XOR(var5, db[EF05+32]);
				}
			} else {
				if (round == 2) {
					K46XOR(var0, db[EF00+32]); K25XOR(var1, db[EF01+32]); K12XOR(var2, db[EF02+32]); K31XOR(var3, db[EF03+32]); K27XOR(var4, db[EF04+32]); K54XOR(var5, db[EF05+32]);
				} else {
					K32XOR(var0, db[EF00+32]); K11XOR(var1, db[EF01+32]); K53XOR(var2, db[EF02+32]); K48XOR(var3, db[EF03+32]); K13XOR(var4, db[EF04+32]); K40XOR(var5, db[EF05+32]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K18XOR(var0, db[EF00+32]); K52XOR(var1, db[EF01+32]); K39XOR(var2, db[EF02+32]); K34XOR(var3, db[EF03+32]); K54XOR(var4, db[EF04+32]); K26XOR(var5, db[EF05+32]);
				} else {
					K04XOR(var0, db[EF00+32]); K38XOR(var1, db[EF01+32]); K25XOR(var2, db[EF02+32]); K20XOR(var3, db[EF03+32]); K40XOR(var4, db[EF04+32]); K12XOR(var5, db[EF05+32]);
				}
			} else {
				if (round == 6) {
					K45XOR(var0, db[EF00+32]); K55XOR(var1, db[EF01+32]); K11XOR(var2, db[EF02+32]); K06XOR(var3, db[EF03+32]); K26XOR(var4, db[EF04+32]); K53XOR(var5, db[EF05+32]);
				} else {
					K31XOR(var0, db[EF00+32]); K41XOR(var1, db[EF01+32]); K52XOR(var2, db[EF02+32]); K47XOR(var3, db[EF03+32]); K12XOR(var4, db[EF04+32]); K39XOR(var5, db[EF05+32]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K55XOR(var0, db[EF00+32]); K34XOR(var1, db[EF01+32]); K45XOR(var2, db[EF02+32]); K40XOR(var3, db[EF03+32]); K05XOR(var4, db[EF04+32]); K32XOR(var5, db[EF05+32]);
				} else {
					K41XOR(var0, db[EF00+32]); K20XOR(var1, db[EF01+32]); K31XOR(var2, db[EF02+32]); K26XOR(var3, db[EF03+32]); K46XOR(var4, db[EF04+32]); K18XOR(var5, db[EF05+32]);
				}
			} else {
				if (round == 10) {
					K27XOR(var0, db[EF00+32]); K06XOR(var1, db[EF01+32]); K48XOR(var2, db[EF02+32]); K12XOR(var3, db[EF03+32]); K32XOR(var4, db[EF04+32]); K04XOR(var5, db[EF05+32]);
				} else {
					K13XOR(var0, db[EF00+32]); K47XOR(var1, db[EF01+32]); K34XOR(var2, db[EF02+32]); K53XOR(var3, db[EF03+32]); K18XOR(var4, db[EF04+32]); K45XOR(var5, db[EF05+32]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K54XOR(var0, db[EF00+32]); K33XOR(var1, db[EF01+32]); K20XOR(var2, db[EF02+32]); K39XOR(var3, db[EF03+32]); K04XOR(var4, db[EF04+32]); K31XOR(var5, db[EF05+32]);
				} else {
					K40XOR(var0, db[EF00+32]); K19XOR(var1, db[EF01+32]); K06XOR(var2, db[EF02+32]); K25XOR(var3, db[EF03+32]); K45XOR(var4, db[EF04+32]); K48XOR(var5, db[EF05+32]);
				}
			} else {
				if (round == 14) {
					K26XOR(var0, db[EF00+32]); K05XOR(var1, db[EF01+32]); K47XOR(var2, db[EF02+32]); K11XOR(var3, db[EF03+32]); K31XOR(var4, db[EF04+32]); K34XOR(var5, db[EF05+32]);
				} else {
					K19XOR(var0, db[EF00+32]); K53XOR(var1, db[EF01+32]); K40XOR(var2, db[EF02+32]); K04XOR(var3, db[EF03+32]); K55XOR(var4, db[EF04+32]); K27XOR(var5, db[EF05+32]);
				}
			}
		}	
	}
	s1(z(40-32), z(48-32), z(54-32), z(62-32));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K34XOR(var0, db[EF06+32]); K55XOR(var1, db[EF07+32]); K05XOR(var2, db[EF08+32]); K13XOR(var3, db[EF09+32]); K18XOR(var4, db[EF10+32]); K40XOR(var5, db[EF11+32]);
				} else {
					K27XOR(var0, db[EF06+32]); K48XOR(var1, db[EF07+32]); K53XOR(var2, db[EF08+32]); K06XOR(var3, db[EF09+32]); K11XOR(var4, db[EF10+32]); K33XOR(var5, db[EF11+32]);
				}
			} else {
				if (round == 2) {
					K13XOR(var0, db[EF06+32]); K34XOR(var1, db[EF07+32]); K39XOR(var2, db[EF08+32]); K47XOR(var3, db[EF09+32]); K52XOR(var4, db[EF10+32]); K19XOR(var5, db[EF11+32]);
				} else {
					K54XOR(var0, db[EF06+32]); K20XOR(var1, db[EF07+32]); K25XOR(var2, db[EF08+32]); K33XOR(var3, db[EF09+32]); K38XOR(var4, db[EF10+32]); K05XOR(var5, db[EF11+32]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K40XOR(var0, db[EF06+32]); K06XOR(var1, db[EF07+32]); K11XOR(var2, db[EF08+32]); K19XOR(var3, db[EF09+32]); K55XOR(var4, db[EF10+32]); K46XOR(var5, db[EF11+32]);
				} else {
					K26XOR(var0, db[EF06+32]); K47XOR(var1, db[EF07+32]); K52XOR(var2, db[EF08+32]); K05XOR(var3, db[EF09+32]); K41XOR(var4, db[EF10+32]); K32XOR(var5, db[EF11+32]);
				}
			} else {
				if (round == 6) {
					K12XOR(var0, db[EF06+32]); K33XOR(var1, db[EF07+32]); K38XOR(var2, db[EF08+32]); K46XOR(var3, db[EF09+32]); K27XOR(var4, db[EF10+32]); K18XOR(var5, db[EF11+32]);
				} else {
					K53XOR(var0, db[EF06+32]); K19XOR(var1, db[EF07+32]); K55XOR(var2, db[EF08+32]); K32XOR(var3, db[EF09+32]); K13XOR(var4, db[EF10+32]); K04XOR(var5, db[EF11+32]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K46XOR(var0, db[EF06+32]); K12XOR(var1, db[EF07+32]); K48XOR(var2, db[EF08+32]); K25XOR(var3, db[EF09+32]); K06XOR(var4, db[EF10+32]); K52XOR(var5, db[EF11+32]);
				} else {
					K32XOR(var0, db[EF06+32]); K53XOR(var1, db[EF07+32]); K34XOR(var2, db[EF08+32]); K11XOR(var3, db[EF09+32]); K47XOR(var4, db[EF10+32]); K38XOR(var5, db[EF11+32]);
				}
			} else {
				if (round == 10) {
					K18XOR(var0, db[EF06+32]); K39XOR(var1, db[EF07+32]); K20XOR(var2, db[EF08+32]); K52XOR(var3, db[EF09+32]); K33XOR(var4, db[EF10+32]); K55XOR(var5, db[EF11+32]);
				} else {
					K04XOR(var0, db[EF06+32]); K25XOR(var1, db[EF07+32]); K06XOR(var2, db[EF08+32]); K38XOR(var3, db[EF09+32]); K19XOR(var4, db[EF10+32]); K41XOR(var5, db[EF11+32]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K45XOR(var0, db[EF06+32]); K11XOR(var1, db[EF07+32]); K47XOR(var2, db[EF08+32]); K55XOR(var3, db[EF09+32]); K05XOR(var4, db[EF10+32]); K27XOR(var5, db[EF11+32]);
				} else {
					K31XOR(var0, db[EF06+32]); K52XOR(var1, db[EF07+32]); K33XOR(var2, db[EF08+32]); K41XOR(var3, db[EF09+32]); K46XOR(var4, db[EF10+32]); K13XOR(var5, db[EF11+32]);
				}
			} else {
				if (round == 14) {
					K48XOR(var0, db[EF06+32]); K38XOR(var1, db[EF07+32]); K19XOR(var2, db[EF08+32]); K27XOR(var3, db[EF09+32]); K32XOR(var4, db[EF10+32]); K54XOR(var5, db[EF11+32]);
				} else {
					K41XOR(var0, db[EF06+32]); K31XOR(var1, db[EF07+32]); K12XOR(var2, db[EF08+32]); K20XOR(var3, db[EF09+32]); K25XOR(var4, db[EF10+32]); K47XOR(var5, db[EF11+32]);
				}
			}
		}	
	}
	s2(z(44-32), z(59-32), z(33-32), z(49-32)); 

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K04XOR(var0, db[   7+32]); K32XOR(var1, db[   8+32]); K26XOR(var2, db[   9+32]); K27XOR(var3, db[  10+32]); K38XOR(var4, db[  11+32]); K54XOR(var5, db[  12+32]);
				} else {
					K52XOR(var0, db[   7+32]); K25XOR(var1, db[   8+32]); K19XOR(var2, db[   9+32]); K20XOR(var3, db[  10+32]); K31XOR(var4, db[  11+32]); K47XOR(var5, db[  12+32]);
				}
			} else {
				if (round == 2) {
					K38XOR(var0, db[   7+32]); K11XOR(var1, db[   8+32]); K05XOR(var2, db[   9+32]); K06XOR(var3, db[  10+32]); K48XOR(var4, db[  11+32]); K33XOR(var5, db[  12+32]);
				} else {
					K55XOR(var0, db[   7+32]); K52XOR(var1, db[   8+32]); K46XOR(var2, db[   9+32]); K47XOR(var3, db[  10+32]); K34XOR(var4, db[  11+32]); K19XOR(var5, db[  12+32]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K41XOR(var0, db[   7+32]); K38XOR(var1, db[   8+32]); K32XOR(var2, db[   9+32]); K33XOR(var3, db[  10+32]); K20XOR(var4, db[  11+32]); K05XOR(var5, db[  12+32]);
				} else {
					K27XOR(var0, db[   7+32]); K55XOR(var1, db[   8+32]); K18XOR(var2, db[   9+32]); K19XOR(var3, db[  10+32]); K06XOR(var4, db[  11+32]); K46XOR(var5, db[  12+32]);
				}
			} else {
				if (round == 6) {
					K13XOR(var0, db[   7+32]); K41XOR(var1, db[   8+32]); K04XOR(var2, db[   9+32]); K05XOR(var3, db[  10+32]); K47XOR(var4, db[  11+32]); K32XOR(var5, db[  12+32]);
				} else {
					K54XOR(var0, db[   7+32]); K27XOR(var1, db[   8+32]); K45XOR(var2, db[   9+32]); K46XOR(var3, db[  10+32]); K33XOR(var4, db[  11+32]); K18XOR(var5, db[  12+32]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K47XOR(var0, db[   7+32]); K20XOR(var1, db[   8+32]); K38XOR(var2, db[   9+32]); K39XOR(var3, db[  10+32]); K26XOR(var4, db[  11+32]); K11XOR(var5, db[  12+32]);
				} else {
					K33XOR(var0, db[   7+32]); K06XOR(var1, db[   8+32]); K55XOR(var2, db[   9+32]); K25XOR(var3, db[  10+32]); K12XOR(var4, db[  11+32]); K52XOR(var5, db[  12+32]);
				}
			} else {
				if (round == 10) {
					K19XOR(var0, db[   7+32]); K47XOR(var1, db[   8+32]); K41XOR(var2, db[   9+32]); K11XOR(var3, db[  10+32]); K53XOR(var4, db[  11+32]); K38XOR(var5, db[  12+32]);
				} else {
					K05XOR(var0, db[   7+32]); K33XOR(var1, db[   8+32]); K27XOR(var2, db[   9+32]); K52XOR(var3, db[  10+32]); K39XOR(var4, db[  11+32]); K55XOR(var5, db[  12+32]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K46XOR(var0, db[   7+32]); K19XOR(var1, db[   8+32]); K13XOR(var2, db[   9+32]); K38XOR(var3, db[  10+32]); K25XOR(var4, db[  11+32]); K41XOR(var5, db[  12+32]);
				} else {
					K32XOR(var0, db[   7+32]); K05XOR(var1, db[   8+32]); K54XOR(var2, db[   9+32]); K55XOR(var3, db[  10+32]); K11XOR(var4, db[  11+32]); K27XOR(var5, db[  12+32]);
				}
			} else {
				if (round == 14) {
					K18XOR(var0, db[   7+32]); K46XOR(var1, db[   8+32]); K40XOR(var2, db[   9+32]); K41XOR(var3, db[  10+32]); K52XOR(var4, db[  11+32]); K13XOR(var5, db[  12+32]);
				} else {
					K11XOR(var0, db[   7+32]); K39XOR(var1, db[   8+32]); K33XOR(var2, db[   9+32]); K34XOR(var3, db[  10+32]); K45XOR(var4, db[  11+32]); K06XOR(var5, db[  12+32]);
				}
			}
		}	
	}
	s3(z(55-32), z(47-32), z(61-32), z(37-32));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K53XOR(var0, db[  11+32]); K06XOR(var1, db[  12+32]); K31XOR(var2, db[  13+32]); K25XOR(var3, db[  14+32]); K19XOR(var4, db[  15+32]); K41XOR(var5, db[  16+32]);
				} else {
					K46XOR(var0, db[  11+32]); K54XOR(var1, db[  12+32]); K55XOR(var2, db[  13+32]); K18XOR(var3, db[  14+32]); K12XOR(var4, db[  15+32]); K34XOR(var5, db[  16+32]);
				}
			} else {
				if (round == 2) {
					K32XOR(var0, db[  11+32]); K40XOR(var1, db[  12+32]); K41XOR(var2, db[  13+32]); K04XOR(var3, db[  14+32]); K53XOR(var4, db[  15+32]); K20XOR(var5, db[  16+32]);
				} else {
					K18XOR(var0, db[  11+32]); K26XOR(var1, db[  12+32]); K27XOR(var2, db[  13+32]); K45XOR(var3, db[  14+32]); K39XOR(var4, db[  15+32]); K06XOR(var5, db[  16+32]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K04XOR(var0, db[  11+32]); K12XOR(var1, db[  12+32]); K13XOR(var2, db[  13+32]); K31XOR(var3, db[  14+32]); K25XOR(var4, db[  15+32]); K47XOR(var5, db[  16+32]);
				} else {
					K45XOR(var0, db[  11+32]); K53XOR(var1, db[  12+32]); K54XOR(var2, db[  13+32]); K48XOR(var3, db[  14+32]); K11XOR(var4, db[  15+32]); K33XOR(var5, db[  16+32]);
				}
			} else {
				if (round == 6) {
					K31XOR(var0, db[  11+32]); K39XOR(var1, db[  12+32]); K40XOR(var2, db[  13+32]); K34XOR(var3, db[  14+32]); K52XOR(var4, db[  15+32]); K19XOR(var5, db[  16+32]);
				} else {
					K48XOR(var0, db[  11+32]); K25XOR(var1, db[  12+32]); K26XOR(var2, db[  13+32]); K20XOR(var3, db[  14+32]); K38XOR(var4, db[  15+32]); K05XOR(var5, db[  16+32]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K41XOR(var0, db[  11+32]); K18XOR(var1, db[  12+32]); K19XOR(var2, db[  13+32]); K13XOR(var3, db[  14+32]); K31XOR(var4, db[  15+32]); K53XOR(var5, db[  16+32]);
				} else {
					K27XOR(var0, db[  11+32]); K04XOR(var1, db[  12+32]); K05XOR(var2, db[  13+32]); K54XOR(var3, db[  14+32]); K48XOR(var4, db[  15+32]); K39XOR(var5, db[  16+32]);
				}
			} else {
				if (round == 10) {
					K13XOR(var0, db[  11+32]); K45XOR(var1, db[  12+32]); K46XOR(var2, db[  13+32]); K40XOR(var3, db[  14+32]); K34XOR(var4, db[  15+32]); K25XOR(var5, db[  16+32]);
				} else {
					K54XOR(var0, db[  11+32]); K31XOR(var1, db[  12+32]); K32XOR(var2, db[  13+32]); K26XOR(var3, db[  14+32]); K20XOR(var4, db[  15+32]); K11XOR(var5, db[  16+32]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K40XOR(var0, db[  11+32]); K48XOR(var1, db[  12+32]); K18XOR(var2, db[  13+32]); K12XOR(var3, db[  14+32]); K06XOR(var4, db[  15+32]); K52XOR(var5, db[  16+32]);
				} else {
					K26XOR(var0, db[  11+32]); K34XOR(var1, db[  12+32]); K04XOR(var2, db[  13+32]); K53XOR(var3, db[  14+32]); K47XOR(var4, db[  15+32]); K38XOR(var5, db[  16+32]);
				}
			} else {
				if (round == 14) {
					K12XOR(var0, db[  11+32]); K20XOR(var1, db[  12+32]); K45XOR(var2, db[  13+32]); K39XOR(var3, db[  14+32]); K33XOR(var4, db[  15+32]); K55XOR(var5, db[  16+32]);
				} else {
					K05XOR(var0, db[  11+32]); K13XOR(var1, db[  12+32]); K38XOR(var2, db[  13+32]); K32XOR(var3, db[  14+32]); K26XOR(var4, db[  15+32]); K48XOR(var5, db[  16+32]);
				}
			}
		}	
	}
	s4(z(57-32), z(51-32), z(41-32), z(32-32));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K15XOR(var0, db[EF24+32]); K24XOR(var1, db[EF25+32]); K28XOR(var2, db[EF26+32]); K43XOR(var3, db[EF27+32]); K30XOR(var4, db[EF28+32]); K03XOR(var5, db[EF29+32]);
				} else {
					K08XOR(var0, db[EF24+32]); K17XOR(var1, db[EF25+32]); K21XOR(var2, db[EF26+32]); K36XOR(var3, db[EF27+32]); K23XOR(var4, db[EF28+32]); K49XOR(var5, db[EF29+32]);
				}
			} else {
				if (round == 2) {
					K51XOR(var0, db[EF24+32]); K03XOR(var1, db[EF25+32]); K07XOR(var2, db[EF26+32]); K22XOR(var3, db[EF27+32]); K09XOR(var4, db[EF28+32]); K35XOR(var5, db[EF29+32]);
				} else {
					K37XOR(var0, db[EF24+32]); K42XOR(var1, db[EF25+32]); K50XOR(var2, db[EF26+32]); K08XOR(var3, db[EF27+32]); K24XOR(var4, db[EF28+32]); K21XOR(var5, db[EF29+32]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K23XOR(var0, db[EF24+32]); K28XOR(var1, db[EF25+32]); K36XOR(var2, db[EF26+32]); K51XOR(var3, db[EF27+32]); K10XOR(var4, db[EF28+32]); K07XOR(var5, db[EF29+32]);
				} else {
					K09XOR(var0, db[EF24+32]); K14XOR(var1, db[EF25+32]); K22XOR(var2, db[EF26+32]); K37XOR(var3, db[EF27+32]); K49XOR(var4, db[EF28+32]); K50XOR(var5, db[EF29+32]);
				}
			} else {
				if (round == 6) {
					K24XOR(var0, db[EF24+32]); K00XOR(var1, db[EF25+32]); K08XOR(var2, db[EF26+32]); K23XOR(var3, db[EF27+32]); K35XOR(var4, db[EF28+32]); K36XOR(var5, db[EF29+32]);
				} else {
					K10XOR(var0, db[EF24+32]); K43XOR(var1, db[EF25+32]); K51XOR(var2, db[EF26+32]); K09XOR(var3, db[EF27+32]); K21XOR(var4, db[EF28+32]); K22XOR(var5, db[EF29+32]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K03XOR(var0, db[EF24+32]); K36XOR(var1, db[EF25+32]); K44XOR(var2, db[EF26+32]); K02XOR(var3, db[EF27+32]); K14XOR(var4, db[EF28+32]); K15XOR(var5, db[EF29+32]);
				} else {
					K42XOR(var0, db[EF24+32]); K22XOR(var1, db[EF25+32]); K30XOR(var2, db[EF26+32]); K17XOR(var3, db[EF27+32]); K00XOR(var4, db[EF28+32]); K01XOR(var5, db[EF29+32]);
				}
			} else {
				if (round == 10) {
					K28XOR(var0, db[EF24+32]); K08XOR(var1, db[EF25+32]); K16XOR(var2, db[EF26+32]); K03XOR(var3, db[EF27+32]); K43XOR(var4, db[EF28+32]); K44XOR(var5, db[EF29+32]);
				} else {
					K14XOR(var0, db[EF24+32]); K51XOR(var1, db[EF25+32]); K02XOR(var2, db[EF26+32]); K42XOR(var3, db[EF27+32]); K29XOR(var4, db[EF28+32]); K30XOR(var5, db[EF29+32]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K00XOR(var0, db[EF24+32]); K37XOR(var1, db[EF25+32]); K17XOR(var2, db[EF26+32]); K28XOR(var3, db[EF27+32]); K15XOR(var4, db[EF28+32]); K16XOR(var5, db[EF29+32]);
				} else {
					K43XOR(var0, db[EF24+32]); K23XOR(var1, db[EF25+32]); K03XOR(var2, db[EF26+32]); K14XOR(var3, db[EF27+32]); K01XOR(var4, db[EF28+32]); K02XOR(var5, db[EF29+32]);
				}
			} else {
				if (round == 14) {
					K29XOR(var0, db[EF24+32]); K09XOR(var1, db[EF25+32]); K42XOR(var2, db[EF26+32]); K00XOR(var3, db[EF27+32]); K44XOR(var4, db[EF28+32]); K17XOR(var5, db[EF29+32]);
				} else {
					K22XOR(var0, db[EF24+32]); K02XOR(var1, db[EF25+32]); K35XOR(var2, db[EF26+32]); K50XOR(var3, db[EF27+32]); K37XOR(var4, db[EF28+32]); K10XOR(var5, db[EF29+32]);
				}
			}
		}	
	}
	s5(z(39-32), z(45-32), z(56-32), z(34-32));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K35XOR(var0, db[EF30+32]); K22XOR(var1, db[EF31+32]); K02XOR(var2, db[EF32+32]); K44XOR(var3, db[EF33+32]); K14XOR(var4, db[EF34+32]); K23XOR(var5, db[EF35+32]);
				} else {
					K28XOR(var0, db[EF30+32]); K15XOR(var1, db[EF31+32]); K24XOR(var2, db[EF32+32]); K37XOR(var3, db[EF33+32]); K07XOR(var4, db[EF34+32]); K16XOR(var5, db[EF35+32]);
				}
			} else {
				if (round == 2) {
					K14XOR(var0, db[EF30+32]); K01XOR(var1, db[EF31+32]); K10XOR(var2, db[EF32+32]); K23XOR(var3, db[EF33+32]); K50XOR(var4, db[EF34+32]); K02XOR(var5, db[EF35+32]);
				} else {
					K00XOR(var0, db[EF30+32]); K44XOR(var1, db[EF31+32]); K49XOR(var2, db[EF32+32]); K09XOR(var3, db[EF33+32]); K36XOR(var4, db[EF34+32]); K17XOR(var5, db[EF35+32]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K43XOR(var0, db[EF30+32]); K30XOR(var1, db[EF31+32]); K35XOR(var2, db[EF32+32]); K24XOR(var3, db[EF33+32]); K22XOR(var4, db[EF34+32]); K03XOR(var5, db[EF35+32]);
				} else {
					K29XOR(var0, db[EF30+32]); K16XOR(var1, db[EF31+32]); K21XOR(var2, db[EF32+32]); K10XOR(var3, db[EF33+32]); K08XOR(var4, db[EF34+32]); K42XOR(var5, db[EF35+32]);
				}
			} else {
				if (round == 6) {
					K15XOR(var0, db[EF30+32]); K02XOR(var1, db[EF31+32]); K07XOR(var2, db[EF32+32]); K49XOR(var3, db[EF33+32]); K51XOR(var4, db[EF34+32]); K28XOR(var5, db[EF35+32]);
				} else {
					K01XOR(var0, db[EF30+32]); K17XOR(var1, db[EF31+32]); K50XOR(var2, db[EF32+32]); K35XOR(var3, db[EF33+32]); K37XOR(var4, db[EF34+32]); K14XOR(var5, db[EF35+32]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K51XOR(var0, db[EF30+32]); K10XOR(var1, db[EF31+32]); K43XOR(var2, db[EF32+32]); K28XOR(var3, db[EF33+32]); K30XOR(var4, db[EF34+32]); K07XOR(var5, db[EF35+32]);
				} else {
					K37XOR(var0, db[EF30+32]); K49XOR(var1, db[EF31+32]); K29XOR(var2, db[EF32+32]); K14XOR(var3, db[EF33+32]); K16XOR(var4, db[EF34+32]); K50XOR(var5, db[EF35+32]);
				}
			} else {
				if (round == 10) {
					K23XOR(var0, db[EF30+32]); K35XOR(var1, db[EF31+32]); K15XOR(var2, db[EF32+32]); K00XOR(var3, db[EF33+32]); K02XOR(var4, db[EF34+32]); K36XOR(var5, db[EF35+32]);
				} else {
					K09XOR(var0, db[EF30+32]); K21XOR(var1, db[EF31+32]); K01XOR(var2, db[EF32+32]); K43XOR(var3, db[EF33+32]); K17XOR(var4, db[EF34+32]); K22XOR(var5, db[EF35+32]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K24XOR(var0, db[EF30+32]); K07XOR(var1, db[EF31+32]); K44XOR(var2, db[EF32+32]); K29XOR(var3, db[EF33+32]); K03XOR(var4, db[EF34+32]); K08XOR(var5, db[EF35+32]);
				} else {
					K10XOR(var0, db[EF30+32]); K50XOR(var1, db[EF31+32]); K30XOR(var2, db[EF32+32]); K15XOR(var3, db[EF33+32]); K42XOR(var4, db[EF34+32]); K51XOR(var5, db[EF35+32]);
				}
			} else {
				if (round == 14) {
					K49XOR(var0, db[EF30+32]); K36XOR(var1, db[EF31+32]); K16XOR(var2, db[EF32+32]); K01XOR(var3, db[EF33+32]); K28XOR(var4, db[EF34+32]); K37XOR(var5, db[EF35+32]);
				} else {
					K42XOR(var0, db[EF30+32]); K29XOR(var1, db[EF31+32]); K09XOR(var2, db[EF32+32]); K51XOR(var3, db[EF33+32]); K21XOR(var4, db[EF34+32]); K30XOR(var5, db[EF35+32]);
				}
			}
		}	
	}
	s6(z(35-32), z(60-32), z(42-32), z(50-32));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K51XOR(var0, db[  23+32]); K16XOR(var1, db[  24+32]); K29XOR(var2, db[  25+32]); K49XOR(var3, db[  26+32]); K07XOR(var4, db[  27+32]); K17XOR(var5, db[  28+32]);
				} else {
					K44XOR(var0, db[  23+32]); K09XOR(var1, db[  24+32]); K22XOR(var2, db[  25+32]); K42XOR(var3, db[  26+32]); K00XOR(var4, db[  27+32]); K10XOR(var5, db[  28+32]);
				}
			} else {
				if (round == 2) {
					K30XOR(var0, db[  23+32]); K24XOR(var1, db[  24+32]); K08XOR(var2, db[  25+32]); K28XOR(var3, db[  26+32]); K43XOR(var4, db[  27+32]); K49XOR(var5, db[  28+32]);
				} else {
					K16XOR(var0, db[  23+32]); K10XOR(var1, db[  24+32]); K51XOR(var2, db[  25+32]); K14XOR(var3, db[  26+32]); K29XOR(var4, db[  27+32]); K35XOR(var5, db[  28+32]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K02XOR(var0, db[  23+32]); K49XOR(var1, db[  24+32]); K37XOR(var2, db[  25+32]); K00XOR(var3, db[  26+32]); K15XOR(var4, db[  27+32]); K21XOR(var5, db[  28+32]);
				} else {
					K17XOR(var0, db[  23+32]); K35XOR(var1, db[  24+32]); K23XOR(var2, db[  25+32]); K43XOR(var3, db[  26+32]); K01XOR(var4, db[  27+32]); K07XOR(var5, db[  28+32]);
				}
			} else {
				if (round == 6) {
					K03XOR(var0, db[  23+32]); K21XOR(var1, db[  24+32]); K09XOR(var2, db[  25+32]); K29XOR(var3, db[  26+32]); K44XOR(var4, db[  27+32]); K50XOR(var5, db[  28+32]);
				} else {
					K42XOR(var0, db[  23+32]); K07XOR(var1, db[  24+32]); K24XOR(var2, db[  25+32]); K15XOR(var3, db[  26+32]); K30XOR(var4, db[  27+32]); K36XOR(var5, db[  28+32]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K35XOR(var0, db[  23+32]); K00XOR(var1, db[  24+32]); K17XOR(var2, db[  25+32]); K08XOR(var3, db[  26+32]); K23XOR(var4, db[  27+32]); K29XOR(var5, db[  28+32]);
				} else {
					K21XOR(var0, db[  23+32]); K43XOR(var1, db[  24+32]); K03XOR(var2, db[  25+32]); K51XOR(var3, db[  26+32]); K09XOR(var4, db[  27+32]); K15XOR(var5, db[  28+32]);
				}
			} else {
				if (round == 10) {
					K07XOR(var0, db[  23+32]); K29XOR(var1, db[  24+32]); K42XOR(var2, db[  25+32]); K37XOR(var3, db[  26+32]); K24XOR(var4, db[  27+32]); K01XOR(var5, db[  28+32]);
				} else {
					K50XOR(var0, db[  23+32]); K15XOR(var1, db[  24+32]); K28XOR(var2, db[  25+32]); K23XOR(var3, db[  26+32]); K10XOR(var4, db[  27+32]); K44XOR(var5, db[  28+32]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K36XOR(var0, db[  23+32]); K01XOR(var1, db[  24+32]); K14XOR(var2, db[  25+32]); K09XOR(var3, db[  26+32]); K49XOR(var4, db[  27+32]); K30XOR(var5, db[  28+32]);
				} else {
					K22XOR(var0, db[  23+32]); K44XOR(var1, db[  24+32]); K00XOR(var2, db[  25+32]); K24XOR(var3, db[  26+32]); K35XOR(var4, db[  27+32]); K16XOR(var5, db[  28+32]);
				}
			} else {
				if (round == 14) {
					K08XOR(var0, db[  23+32]); K30XOR(var1, db[  24+32]); K43XOR(var2, db[  25+32]); K10XOR(var3, db[  26+32]); K21XOR(var4, db[  27+32]); K02XOR(var5, db[  28+32]);
				} else {
					K01XOR(var0, db[  23+32]); K23XOR(var1, db[  24+32]); K36XOR(var2, db[  25+32]); K03XOR(var3, db[  26+32]); K14XOR(var4, db[  27+32]); K24XOR(var5, db[  28+32]);
				}
			}
		}	
	}
	s7(z(63-32), z(43-32), z(53-32), z(38-32));

	if (round < 8) {
		if (round < 4) {
			if (round < 2) {
				if (round == 0) {
					K37XOR(var0, db[  27+32]); K08XOR(var1, db[  28+32]); K09XOR(var2, db[  29+32]); K50XOR(var3, db[  30+32]); K42XOR(var4, db[  31+32]); K21XOR(var5, db[   0+32]);
				} else {
					K30XOR(var0, db[  27+32]); K01XOR(var1, db[  28+32]); K02XOR(var2, db[  29+32]); K43XOR(var3, db[  30+32]); K35XOR(var4, db[  31+32]); K14XOR(var5, db[   0+32]);
				}
			} else {
				if (round == 2) {
					K16XOR(var0, db[  27+32]); K44XOR(var1, db[  28+32]); K17XOR(var2, db[  29+32]); K29XOR(var3, db[  30+32]); K21XOR(var4, db[  31+32]); K00XOR(var5, db[   0+32]);
				} else {
					K02XOR(var0, db[  27+32]); K30XOR(var1, db[  28+32]); K03XOR(var2, db[  29+32]); K15XOR(var3, db[  30+32]); K07XOR(var4, db[  31+32]); K43XOR(var5, db[   0+32]);
				}
			}
		} else {
			if (round < 6) {
				if (round == 4) {
					K17XOR(var0, db[  27+32]); K16XOR(var1, db[  28+32]); K42XOR(var2, db[  29+32]); K01XOR(var3, db[  30+32]); K50XOR(var4, db[  31+32]); K29XOR(var5, db[   0+32]);
				} else {
					K03XOR(var0, db[  27+32]); K02XOR(var1, db[  28+32]); K28XOR(var2, db[  29+32]); K44XOR(var3, db[  30+32]); K36XOR(var4, db[  31+32]); K15XOR(var5, db[   0+32]);
				}
			} else {
				if (round == 6) {
					K42XOR(var0, db[  27+32]); K17XOR(var1, db[  28+32]); K14XOR(var2, db[  29+32]); K30XOR(var3, db[  30+32]); K22XOR(var4, db[  31+32]); K01XOR(var5, db[   0+32]);
				} else {
					K28XOR(var0, db[  27+32]); K03XOR(var1, db[  28+32]); K00XOR(var2, db[  29+32]); K16XOR(var3, db[  30+32]); K08XOR(var4, db[  31+32]); K44XOR(var5, db[   0+32]);
				}
			}
		}
	} else {
		if (round < 12) {
			if (round < 10) {
				if (round == 8) {
					K21XOR(var0, db[  27+32]); K49XOR(var1, db[  28+32]); K50XOR(var2, db[  29+32]); K09XOR(var3, db[  30+32]); K01XOR(var4, db[  31+32]); K37XOR(var5, db[   0+32]);
				} else {
					K07XOR(var0, db[  27+32]); K35XOR(var1, db[  28+32]); K36XOR(var2, db[  29+32]); K24XOR(var3, db[  30+32]); K44XOR(var4, db[  31+32]); K23XOR(var5, db[   0+32]);
				}
			} else {
				if (round == 10) {
					K50XOR(var0, db[  27+32]); K21XOR(var1, db[  28+32]); K22XOR(var2, db[  29+32]); K10XOR(var3, db[  30+32]); K30XOR(var4, db[  31+32]); K09XOR(var5, db[   0+32]);
				} else {
					K36XOR(var0, db[  27+32]); K07XOR(var1, db[  28+32]); K08XOR(var2, db[  29+32]); K49XOR(var3, db[  30+32]); K16XOR(var4, db[  31+32]); K24XOR(var5, db[   0+32]);
				}
			}
		} else {
			if (round < 14) {
				if (round == 12) {
					K22XOR(var0, db[  27+32]); K50XOR(var1, db[  28+32]); K51XOR(var2, db[  29+32]); K35XOR(var3, db[  30+32]); K02XOR(var4, db[  31+32]); K10XOR(var5, db[   0+32]);
				} else {
					K08XOR(var0, db[  27+32]); K36XOR(var1, db[  28+32]); K37XOR(var2, db[  29+32]); K21XOR(var3, db[  30+32]); K17XOR(var4, db[  31+32]); K49XOR(var5, db[   0+32]);
				}
			} else {
				if (round == 14) {
					K51XOR(var0, db[  27+32]); K22XOR(var1, db[  28+32]); K23XOR(var2, db[  29+32]); K07XOR(var3, db[  30+32]); K03XOR(var4, db[  31+32]); K35XOR(var5, db[   0+32]);
				} else {
					K44XOR(var0, db[  27+32]); K15XOR(var1, db[  28+32]); K16XOR(var2, db[  29+32]); K00XOR(var3, db[  30+32]); K49XOR(var4, db[  31+32]); K28XOR(var5, db[   0+32]);
				}
			}
		}	
	}
	s8(z(36-32), z(58-32), z(46-32), z(52-32));

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
	(  ((((r)[i0] & (0x01U << (t))) ? (0x1) : (0x0)) << (5 + ((pos) * 6)))  \
	 | ((((r)[i1] & (0x01U << (t))) ? (0x1) : (0x0)) << (4 + ((pos) * 6)))  \
	 | ((((r)[i2] & (0x01U << (t))) ? (0x1) : (0x0)) << (3 + ((pos) * 6)))  \
	 | ((((r)[i3] & (0x01U << (t))) ? (0x1) : (0x0)) << (2 + ((pos) * 6)))  \
	 | ((((r)[i4] & (0x01U << (t))) ? (0x1) : (0x0)) << (1 + ((pos) * 6)))  \
	 | ((((r)[i5] & (0x01U << (t))) ? (0x1) : (0x0)) << (0 + ((pos) * 6)))) \
		
#define OPENCL_DES_DEFINE_SEARCH_FUNCTION                                                    \
	__kernel void OpenCL_DES_PerformSearching(                                                                            \
		__global   GPUOutput                * const outputArray,                                           \
		__constant KeyInfo                  *       keyInfo,                                               \
		__global   const unsigned int       * const tripcodeChunkArray,                                    \
				   const unsigned int               numTripcodeChunk,                                      \
 		__constant const unsigned char      * const smallKeyBitmap,                                        \
  		__constant const unsigned int       * const compactMediumKeyBitmap,                                \
		__global   const unsigned char      * const keyBitmap,                                             \
		__global   const PartialKeyFrom3To6 * const partialKeyFrom3To6Array,                               \
                   const unsigned int               keyFrom00To27                                         \
	) {                                                                                                    \
		__global              GPUOutput     *output = &outputArray[get_global_id(0)];                      \
							  int  tripcodeIndex;                                                \
		DES_DATA_BLOCKS_SPACE vtype          DES_dataBlocks[64];                                           \
		__global unsigned char *partialKeyFrom3To6 = partialKeyFrom3To6Array[get_global_id(0)].partialKeyFrom3To6; \
		output->numMatchingTripcodes = 0;                                                                  \
		unsigned int keyFrom28To48 = ((partialKeyFrom3To6[3] & 0x7f) << 14) | ((partialKeyFrom3To6[2] & 0x7f) << 7) | (partialKeyFrom3To6[1] & 0x7f); \
		                                                                                                   \
		DES_Crypt(DES_dataBlocks, keyFrom00To27, keyFrom28To48);  \
		                                                                                                   \
		BOOL found = FALSE;                                                                                \

#define OPENCL_DES_END_OF_SEAERCH_FUNCTION                                                                             \
	quit_loops:                                                                                                        \
		if (found == TRUE) {                                                                                           \
			output->numMatchingTripcodes = 1;                                                                          \
			output->pair.key.c[7] = key7Array[tripcodeIndex]; \
		}                                                                                                              \
		output->numGeneratedTripcodes = OPENCL_DES_BS_DEPTH;                                                           \
	}                                                                                                                  \

#define OPENCL_DES_USE_SMALL_KEY_BITMAP                                           \
	if (smallKeyBitmap[tripcodeChunk >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]) \
		continue;                                                                 \

#define OPENCL_DES_USE_MEDIUM_KEY_BITMAP                                           \
	if (compactMediumKeyBitmap[tripcodeChunk >> ((5 - MEDIUM_KEY_BITMAP_LEN_STRING) * 6 + 5)] & (0x1 << (tripcodeChunk >> ((5 - MEDIUM_KEY_BITMAP_LEN_STRING) * 6) & 0x1f))) \
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

#if defined(FORWARD_MATCHING_1CHUNK)

OPENCL_DES_DEFINE_SEARCH_FUNCTION
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		if (tripcodeChunk == tripcodeChunkArray[0]) {
			found = TRUE;
			goto quit_loops;
		}
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

#elif defined(FORWARD_MATCHING_SIMPLE)

OPENCL_DES_DEFINE_SEARCH_FUNCTION
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

#elif defined(FORWARD_MATCHING)

OPENCL_DES_DEFINE_SEARCH_FUNCTION
	for (tripcodeIndex = 0; tripcodeIndex < OPENCL_DES_BS_DEPTH; ++tripcodeIndex) {
		unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
						             | GET_TRIPCODE_CHAR_INDEX(DES_dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
		// all:                                  2181M (10m)
		// w/o OPENCL_DES_USE_SMALL_KEY_BITMAP:  2160M (10m)
		// w/o OPENCL_DES_USE_MEDIUM_KEY_BITMAP: 2142M (10m)
		OPENCL_DES_USE_SMALL_KEY_BITMAP
		OPENCL_DES_USE_MEDIUM_KEY_BITMAP
		OPENCL_DES_USE_KEY_BITMAP
		OPENCL_DES_PERFORM_BINARY_SEARCH
	}
OPENCL_DES_END_OF_SEAERCH_FUNCTION

#elif defined(BACKWARD_MATCHING_SIMPLE)

OPENCL_DES_DEFINE_SEARCH_FUNCTION
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

#elif defined(BACKWARD_MATCHING)

OPENCL_DES_DEFINE_SEARCH_FUNCTION
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

#elif defined(FORWARD_AND_BACKWARD_MATCHING_SIMPLE)

OPENCL_DES_DEFINE_SEARCH_FUNCTION
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

#elif defined(FORWARD_AND_BACKWARD_MATCHING)

OPENCL_DES_DEFINE_SEARCH_FUNCTION
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

#elif defined(FLEXIBLE_SIMPLE)

OPENCL_DES_DEFINE_SEARCH_FUNCTION
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

#elif defined(FLEXIBLE)

OPENCL_DES_DEFINE_SEARCH_FUNCTION
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

#endif
