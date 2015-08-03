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



#define FUNCTION_NAME2(salt) CUDA_DES_PerformSearch ## salt
#define FUNCTION_NAME(salt) FUNCTION_NAME2(salt)

__global__ void FUNCTION_NAME(SALT)(
	GPUOutput *outputArray,
	unsigned char      *keyBitmap,
	unsigned int     *tripcodeChunkArray,
	unsigned int      numTripcodeChunk,
	unsigned int  keyFrom00To27,
	int           searchMode) {
	DES_Vector *db = dataBlocks + threadIdx.x;
	GPUOutput  *output = &outputArray[blockIdx.x * CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK + threadIdx.x];
	unsigned char        key[8];
	BOOL         isSecondByte;
	unsigned char        tripcodeIndex;
	unsigned char        passCount;
	BOOL found = FALSE;
	unsigned int generatedTripcodeChunkArray[6];
	
	if (threadIdx.y == 0) {
		output->numMatchingTripcodes = 0;
	}
	key[0] = CUDA_key[0];
	key[1] = CUDA_key[1];
	key[2] = CUDA_key[2];
	key[3] = CUDA_key[3];
	isSecondByte = IS_FIRST_BYTE_SJIS(CUDA_key[3]);
	SET_KEY_CHAR(key[4], isSecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[4] + ((blockIdx.x  >> 6) & 63));
	SET_KEY_CHAR(key[5], isSecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[5] + ( blockIdx.x        & 63));
	SET_KEY_CHAR(key[6], isSecondByte, CUDA_keyCharTable_FirstByte, CUDA_key[6] + ( threadIdx.x       & 63));
	unsigned int keyFrom28To48 = (((unsigned int)key[6] & 0x7f) << 14) | (((unsigned int)key[5] & 0x7f) <<  7) | (((unsigned int)key[4] & 0x7f) << 0); 
	
	for (passCount = 0; passCount < 1; ++passCount) {
		__syncthreads();
		if (threadIdx.y == 0)
			CLEAR_BLOCK();
	
		__syncthreads();
		for (int i = 0; i < 13; ++i) {
			// ROUND_A(0);
			switch (threadIdx.y) {
			case 0: s1(K12XOR((   1 & SALT) ? DB15 : DB31), K46XOR((   2 & SALT) ? DB16 : DB00), K33XOR((   4 & SALT) ? DB17 : DB01), K52XOR((   8 & SALT) ? DB18 : DB02), K48XOR((  16 & SALT) ? DB19 : DB03), K20XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K34XOR((  64 & SALT) ? DB19 : DB03), K55XOR(( 128 & SALT) ? DB20 : DB04), K05XOR(( 256 & SALT) ? DB21 : DB05), K13XOR(( 512 & SALT) ? DB22 : DB06), K18XOR((1024 & SALT) ? DB23 : DB07), K40XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K04XOR(                DB07       ), K32XOR(                DB08       ), K26XOR(                DB09       ), K27XOR(                DB10       ), K38XOR(                DB11       ), K54XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K53XOR(                DB11       ), K06XOR(                DB12       ), K31XOR(                DB13       ), K25XOR(                DB14       ), K19XOR(                DB15       ), K41XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K15XOR((   1 & SALT) ? DB31 : DB15), K24XOR((   2 & SALT) ? DB00 : DB16), K28XOR((   4 & SALT) ? DB01 : DB17), K43XOR((   8 & SALT) ? DB02 : DB18), K30XOR((  16 & SALT) ? DB03 : DB19), K03XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K35XOR((  64 & SALT) ? DB03 : DB19), K22XOR(( 128 & SALT) ? DB04 : DB20), K02XOR(( 256 & SALT) ? DB05 : DB21), K44XOR(( 512 & SALT) ? DB06 : DB22), K14XOR((1024 & SALT) ? DB07 : DB23), K23XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K51XOR(                DB23       ), K16XOR(                DB24       ), K29XOR(                DB25       ), K49XOR(                DB26       ), K07XOR(                DB27       ), K17XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K37XOR(                DB27       ), K08XOR(                DB28       ), K09XOR(                DB29       ), K50XOR(                DB30       ), K42XOR(                DB31       ), K21XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(0);
			switch (threadIdx.y) {
			case 0: s1(K05XOR((   1 & SALT) ? DB47 : DB63), K39XOR((   2 & SALT) ? DB48 : DB32), K26XOR((   4 & SALT) ? DB49 : DB33), K45XOR((   8 & SALT) ? DB50 : DB34), K41XOR((  16 & SALT) ? DB51 : DB35), K13XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K27XOR((  64 & SALT) ? DB51 : DB35), K48XOR(( 128 & SALT) ? DB52 : DB36), K53XOR(( 256 & SALT) ? DB53 : DB37), K06XOR(( 512 & SALT) ? DB54 : DB38), K11XOR((1024 & SALT) ? DB55 : DB39), K33XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K52XOR(                DB39       ), K25XOR(                DB40       ), K19XOR(                DB41       ), K20XOR(                DB42       ), K31XOR(                DB43       ), K47XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K46XOR(                DB43       ), K54XOR(                DB44       ), K55XOR(                DB45       ), K18XOR(                DB46       ), K12XOR(                DB47       ), K34XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K08XOR((   1 & SALT) ? DB63 : DB47), K17XOR((   2 & SALT) ? DB32 : DB48), K21XOR((   4 & SALT) ? DB33 : DB49), K36XOR((   8 & SALT) ? DB34 : DB50), K23XOR((  16 & SALT) ? DB35 : DB51), K49XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K28XOR((  64 & SALT) ? DB35 : DB51), K15XOR(( 128 & SALT) ? DB36 : DB52), K24XOR(( 256 & SALT) ? DB37 : DB53), K37XOR(( 512 & SALT) ? DB38 : DB54), K07XOR((1024 & SALT) ? DB39 : DB55), K16XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K44XOR(                DB55       ), K09XOR(                DB56       ), K22XOR(                DB57       ), K42XOR(                DB58       ), K00XOR(                DB59       ), K10XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K30XOR(                DB59       ), K01XOR(                DB60       ), K02XOR(                DB61       ), K43XOR(                DB62       ), K35XOR(                DB63       ), K14XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(96);
			switch (threadIdx.y) {
			case 0: s1(K46XOR((   1 & SALT) ? DB15 : DB31), K25XOR((   2 & SALT) ? DB16 : DB00), K12XOR((   4 & SALT) ? DB17 : DB01), K31XOR((   8 & SALT) ? DB18 : DB02), K27XOR((  16 & SALT) ? DB19 : DB03), K54XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K13XOR((  64 & SALT) ? DB19 : DB03), K34XOR(( 128 & SALT) ? DB20 : DB04), K39XOR(( 256 & SALT) ? DB21 : DB05), K47XOR(( 512 & SALT) ? DB22 : DB06), K52XOR((1024 & SALT) ? DB23 : DB07), K19XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K38XOR(                DB07       ), K11XOR(                DB08       ), K05XOR(                DB09       ), K06XOR(                DB10       ), K48XOR(                DB11       ), K33XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K32XOR(                DB11       ), K40XOR(                DB12       ), K41XOR(                DB13       ), K04XOR(                DB14       ), K53XOR(                DB15       ), K20XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K51XOR((   1 & SALT) ? DB31 : DB15), K03XOR((   2 & SALT) ? DB00 : DB16), K07XOR((   4 & SALT) ? DB01 : DB17), K22XOR((   8 & SALT) ? DB02 : DB18), K09XOR((  16 & SALT) ? DB03 : DB19), K35XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K14XOR((  64 & SALT) ? DB03 : DB19), K01XOR(( 128 & SALT) ? DB04 : DB20), K10XOR(( 256 & SALT) ? DB05 : DB21), K23XOR(( 512 & SALT) ? DB06 : DB22), K50XOR((1024 & SALT) ? DB07 : DB23), K02XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K30XOR(                DB23       ), K24XOR(                DB24       ), K08XOR(                DB25       ), K28XOR(                DB26       ), K43XOR(                DB27       ), K49XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K16XOR(                DB27       ), K44XOR(                DB28       ), K17XOR(                DB29       ), K29XOR(                DB30       ), K21XOR(                DB31       ), K00XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(96);
			switch (threadIdx.y) {
			case 0: s1(K32XOR((   1 & SALT) ? DB47 : DB63), K11XOR((   2 & SALT) ? DB48 : DB32), K53XOR((   4 & SALT) ? DB49 : DB33), K48XOR((   8 & SALT) ? DB50 : DB34), K13XOR((  16 & SALT) ? DB51 : DB35), K40XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K54XOR((  64 & SALT) ? DB51 : DB35), K20XOR(( 128 & SALT) ? DB52 : DB36), K25XOR(( 256 & SALT) ? DB53 : DB37), K33XOR(( 512 & SALT) ? DB54 : DB38), K38XOR((1024 & SALT) ? DB55 : DB39), K05XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K55XOR(                DB39       ), K52XOR(                DB40       ), K46XOR(                DB41       ), K47XOR(                DB42       ), K34XOR(                DB43       ), K19XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K18XOR(                DB43       ), K26XOR(                DB44       ), K27XOR(                DB45       ), K45XOR(                DB46       ), K39XOR(                DB47       ), K06XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K37XOR((   1 & SALT) ? DB63 : DB47), K42XOR((   2 & SALT) ? DB32 : DB48), K50XOR((   4 & SALT) ? DB33 : DB49), K08XOR((   8 & SALT) ? DB34 : DB50), K24XOR((  16 & SALT) ? DB35 : DB51), K21XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K00XOR((  64 & SALT) ? DB35 : DB51), K44XOR(( 128 & SALT) ? DB36 : DB52), K49XOR(( 256 & SALT) ? DB37 : DB53), K09XOR(( 512 & SALT) ? DB38 : DB54), K36XOR((1024 & SALT) ? DB39 : DB55), K17XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K16XOR(                DB55       ), K10XOR(                DB56       ), K51XOR(                DB57       ), K14XOR(                DB58       ), K29XOR(                DB59       ), K35XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K02XOR(                DB59       ), K30XOR(                DB60       ), K03XOR(                DB61       ), K15XOR(                DB62       ), K07XOR(                DB63       ), K43XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(192);
			switch (threadIdx.y) {
			case 0: s1(K18XOR((   1 & SALT) ? DB15 : DB31), K52XOR((   2 & SALT) ? DB16 : DB00), K39XOR((   4 & SALT) ? DB17 : DB01), K34XOR((   8 & SALT) ? DB18 : DB02), K54XOR((  16 & SALT) ? DB19 : DB03), K26XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K40XOR((  64 & SALT) ? DB19 : DB03), K06XOR(( 128 & SALT) ? DB20 : DB04), K11XOR(( 256 & SALT) ? DB21 : DB05), K19XOR(( 512 & SALT) ? DB22 : DB06), K55XOR((1024 & SALT) ? DB23 : DB07), K46XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K41XOR(                DB07       ), K38XOR(                DB08       ), K32XOR(                DB09       ), K33XOR(                DB10       ), K20XOR(                DB11       ), K05XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K04XOR(                DB11       ), K12XOR(                DB12       ), K13XOR(                DB13       ), K31XOR(                DB14       ), K25XOR(                DB15       ), K47XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K23XOR((   1 & SALT) ? DB31 : DB15), K28XOR((   2 & SALT) ? DB00 : DB16), K36XOR((   4 & SALT) ? DB01 : DB17), K51XOR((   8 & SALT) ? DB02 : DB18), K10XOR((  16 & SALT) ? DB03 : DB19), K07XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K43XOR((  64 & SALT) ? DB03 : DB19), K30XOR(( 128 & SALT) ? DB04 : DB20), K35XOR(( 256 & SALT) ? DB05 : DB21), K24XOR(( 512 & SALT) ? DB06 : DB22), K22XOR((1024 & SALT) ? DB07 : DB23), K03XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K02XOR(                DB23       ), K49XOR(                DB24       ), K37XOR(                DB25       ), K00XOR(                DB26       ), K15XOR(                DB27       ), K21XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K17XOR(                DB27       ), K16XOR(                DB28       ), K42XOR(                DB29       ), K01XOR(                DB30       ), K50XOR(                DB31       ), K29XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(192);
			switch (threadIdx.y) {
			case 0: s1(K04XOR((   1 & SALT) ? DB47 : DB63), K38XOR((   2 & SALT) ? DB48 : DB32), K25XOR((   4 & SALT) ? DB49 : DB33), K20XOR((   8 & SALT) ? DB50 : DB34), K40XOR((  16 & SALT) ? DB51 : DB35), K12XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K26XOR((  64 & SALT) ? DB51 : DB35), K47XOR(( 128 & SALT) ? DB52 : DB36), K52XOR(( 256 & SALT) ? DB53 : DB37), K05XOR(( 512 & SALT) ? DB54 : DB38), K41XOR((1024 & SALT) ? DB55 : DB39), K32XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K27XOR(                DB39       ), K55XOR(                DB40       ), K18XOR(                DB41       ), K19XOR(                DB42       ), K06XOR(                DB43       ), K46XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K45XOR(                DB43       ), K53XOR(                DB44       ), K54XOR(                DB45       ), K48XOR(                DB46       ), K11XOR(                DB47       ), K33XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K09XOR((   1 & SALT) ? DB63 : DB47), K14XOR((   2 & SALT) ? DB32 : DB48), K22XOR((   4 & SALT) ? DB33 : DB49), K37XOR((   8 & SALT) ? DB34 : DB50), K49XOR((  16 & SALT) ? DB35 : DB51), K50XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K29XOR((  64 & SALT) ? DB35 : DB51), K16XOR(( 128 & SALT) ? DB36 : DB52), K21XOR(( 256 & SALT) ? DB37 : DB53), K10XOR(( 512 & SALT) ? DB38 : DB54), K08XOR((1024 & SALT) ? DB39 : DB55), K42XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K17XOR(                DB55       ), K35XOR(                DB56       ), K23XOR(                DB57       ), K43XOR(                DB58       ), K01XOR(                DB59       ), K07XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K03XOR(                DB59       ), K02XOR(                DB60       ), K28XOR(                DB61       ), K44XOR(                DB62       ), K36XOR(                DB63       ), K15XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(288);
			switch (threadIdx.y) {
			case 0: s1(K45XOR((   1 & SALT) ? DB15 : DB31), K55XOR((   2 & SALT) ? DB16 : DB00), K11XOR((   4 & SALT) ? DB17 : DB01), K06XOR((   8 & SALT) ? DB18 : DB02), K26XOR((  16 & SALT) ? DB19 : DB03), K53XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K12XOR((  64 & SALT) ? DB19 : DB03), K33XOR(( 128 & SALT) ? DB20 : DB04), K38XOR(( 256 & SALT) ? DB21 : DB05), K46XOR(( 512 & SALT) ? DB22 : DB06), K27XOR((1024 & SALT) ? DB23 : DB07), K18XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K13XOR(                DB07       ), K41XOR(                DB08       ), K04XOR(                DB09       ), K05XOR(                DB10       ), K47XOR(                DB11       ), K32XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K31XOR(                DB11       ), K39XOR(                DB12       ), K40XOR(                DB13       ), K34XOR(                DB14       ), K52XOR(                DB15       ), K19XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K24XOR((   1 & SALT) ? DB31 : DB15), K00XOR((   2 & SALT) ? DB00 : DB16), K08XOR((   4 & SALT) ? DB01 : DB17), K23XOR((   8 & SALT) ? DB02 : DB18), K35XOR((  16 & SALT) ? DB03 : DB19), K36XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K15XOR((  64 & SALT) ? DB03 : DB19), K02XOR(( 128 & SALT) ? DB04 : DB20), K07XOR(( 256 & SALT) ? DB05 : DB21), K49XOR(( 512 & SALT) ? DB06 : DB22), K51XOR((1024 & SALT) ? DB07 : DB23), K28XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K03XOR(                DB23       ), K21XOR(                DB24       ), K09XOR(                DB25       ), K29XOR(                DB26       ), K44XOR(                DB27       ), K50XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K42XOR(                DB27       ), K17XOR(                DB28       ), K14XOR(                DB29       ), K30XOR(                DB30       ), K22XOR(                DB31       ), K01XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(288);
			switch (threadIdx.y) {
			case 0: s1(K31XOR((   1 & SALT) ? DB47 : DB63), K41XOR((   2 & SALT) ? DB48 : DB32), K52XOR((   4 & SALT) ? DB49 : DB33), K47XOR((   8 & SALT) ? DB50 : DB34), K12XOR((  16 & SALT) ? DB51 : DB35), K39XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K53XOR((  64 & SALT) ? DB51 : DB35), K19XOR(( 128 & SALT) ? DB52 : DB36), K55XOR(( 256 & SALT) ? DB53 : DB37), K32XOR(( 512 & SALT) ? DB54 : DB38), K13XOR((1024 & SALT) ? DB55 : DB39), K04XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K54XOR(                DB39       ), K27XOR(                DB40       ), K45XOR(                DB41       ), K46XOR(                DB42       ), K33XOR(                DB43       ), K18XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K48XOR(                DB43       ), K25XOR(                DB44       ), K26XOR(                DB45       ), K20XOR(                DB46       ), K38XOR(                DB47       ), K05XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K10XOR((   1 & SALT) ? DB63 : DB47), K43XOR((   2 & SALT) ? DB32 : DB48), K51XOR((   4 & SALT) ? DB33 : DB49), K09XOR((   8 & SALT) ? DB34 : DB50), K21XOR((  16 & SALT) ? DB35 : DB51), K22XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K01XOR((  64 & SALT) ? DB35 : DB51), K17XOR(( 128 & SALT) ? DB36 : DB52), K50XOR(( 256 & SALT) ? DB37 : DB53), K35XOR(( 512 & SALT) ? DB38 : DB54), K37XOR((1024 & SALT) ? DB39 : DB55), K14XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K42XOR(                DB55       ), K07XOR(                DB56       ), K24XOR(                DB57       ), K15XOR(                DB58       ), K30XOR(                DB59       ), K36XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K28XOR(                DB59       ), K03XOR(                DB60       ), K00XOR(                DB61       ), K16XOR(                DB62       ), K08XOR(                DB63       ), K44XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(384);
			switch (threadIdx.y) {
			case 0: s1(K55XOR((   1 & SALT) ? DB15 : DB31), K34XOR((   2 & SALT) ? DB16 : DB00), K45XOR((   4 & SALT) ? DB17 : DB01), K40XOR((   8 & SALT) ? DB18 : DB02), K05XOR((  16 & SALT) ? DB19 : DB03), K32XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K46XOR((  64 & SALT) ? DB19 : DB03), K12XOR(( 128 & SALT) ? DB20 : DB04), K48XOR(( 256 & SALT) ? DB21 : DB05), K25XOR(( 512 & SALT) ? DB22 : DB06), K06XOR((1024 & SALT) ? DB23 : DB07), K52XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K47XOR(                DB07       ), K20XOR(                DB08       ), K38XOR(                DB09       ), K39XOR(                DB10       ), K26XOR(                DB11       ), K11XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K41XOR(                DB11       ), K18XOR(                DB12       ), K19XOR(                DB13       ), K13XOR(                DB14       ), K31XOR(                DB15       ), K53XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K03XOR((   1 & SALT) ? DB31 : DB15), K36XOR((   2 & SALT) ? DB00 : DB16), K44XOR((   4 & SALT) ? DB01 : DB17), K02XOR((   8 & SALT) ? DB02 : DB18), K14XOR((  16 & SALT) ? DB03 : DB19), K15XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K51XOR((  64 & SALT) ? DB03 : DB19), K10XOR(( 128 & SALT) ? DB04 : DB20), K43XOR(( 256 & SALT) ? DB05 : DB21), K28XOR(( 512 & SALT) ? DB06 : DB22), K30XOR((1024 & SALT) ? DB07 : DB23), K07XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K35XOR(                DB23       ), K00XOR(                DB24       ), K17XOR(                DB25       ), K08XOR(                DB26       ), K23XOR(                DB27       ), K29XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K21XOR(                DB27       ), K49XOR(                DB28       ), K50XOR(                DB29       ), K09XOR(                DB30       ), K01XOR(                DB31       ), K37XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(384);
			switch (threadIdx.y) {
			case 0: s1(K41XOR((   1 & SALT) ? DB47 : DB63), K20XOR((   2 & SALT) ? DB48 : DB32), K31XOR((   4 & SALT) ? DB49 : DB33), K26XOR((   8 & SALT) ? DB50 : DB34), K46XOR((  16 & SALT) ? DB51 : DB35), K18XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K32XOR((  64 & SALT) ? DB51 : DB35), K53XOR(( 128 & SALT) ? DB52 : DB36), K34XOR(( 256 & SALT) ? DB53 : DB37), K11XOR(( 512 & SALT) ? DB54 : DB38), K47XOR((1024 & SALT) ? DB55 : DB39), K38XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K33XOR(                DB39       ), K06XOR(                DB40       ), K55XOR(                DB41       ), K25XOR(                DB42       ), K12XOR(                DB43       ), K52XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K27XOR(                DB43       ), K04XOR(                DB44       ), K05XOR(                DB45       ), K54XOR(                DB46       ), K48XOR(                DB47       ), K39XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K42XOR((   1 & SALT) ? DB63 : DB47), K22XOR((   2 & SALT) ? DB32 : DB48), K30XOR((   4 & SALT) ? DB33 : DB49), K17XOR((   8 & SALT) ? DB34 : DB50), K00XOR((  16 & SALT) ? DB35 : DB51), K01XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K37XOR((  64 & SALT) ? DB35 : DB51), K49XOR(( 128 & SALT) ? DB36 : DB52), K29XOR(( 256 & SALT) ? DB37 : DB53), K14XOR(( 512 & SALT) ? DB38 : DB54), K16XOR((1024 & SALT) ? DB39 : DB55), K50XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K21XOR(                DB55       ), K43XOR(                DB56       ), K03XOR(                DB57       ), K51XOR(                DB58       ), K09XOR(                DB59       ), K15XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K07XOR(                DB59       ), K35XOR(                DB60       ), K36XOR(                DB61       ), K24XOR(                DB62       ), K44XOR(                DB63       ), K23XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(480);
			switch (threadIdx.y) {
			case 0: s1(K27XOR((   1 & SALT) ? DB15 : DB31), K06XOR((   2 & SALT) ? DB16 : DB00), K48XOR((   4 & SALT) ? DB17 : DB01), K12XOR((   8 & SALT) ? DB18 : DB02), K32XOR((  16 & SALT) ? DB19 : DB03), K04XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K18XOR((  64 & SALT) ? DB19 : DB03), K39XOR(( 128 & SALT) ? DB20 : DB04), K20XOR(( 256 & SALT) ? DB21 : DB05), K52XOR(( 512 & SALT) ? DB22 : DB06), K33XOR((1024 & SALT) ? DB23 : DB07), K55XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K19XOR(                DB07       ), K47XOR(                DB08       ), K41XOR(                DB09       ), K11XOR(                DB10       ), K53XOR(                DB11       ), K38XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K13XOR(                DB11       ), K45XOR(                DB12       ), K46XOR(                DB13       ), K40XOR(                DB14       ), K34XOR(                DB15       ), K25XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K28XOR((   1 & SALT) ? DB31 : DB15), K08XOR((   2 & SALT) ? DB00 : DB16), K16XOR((   4 & SALT) ? DB01 : DB17), K03XOR((   8 & SALT) ? DB02 : DB18), K43XOR((  16 & SALT) ? DB03 : DB19), K44XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K23XOR((  64 & SALT) ? DB03 : DB19), K35XOR(( 128 & SALT) ? DB04 : DB20), K15XOR(( 256 & SALT) ? DB05 : DB21), K00XOR(( 512 & SALT) ? DB06 : DB22), K02XOR((1024 & SALT) ? DB07 : DB23), K36XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K07XOR(                DB23       ), K29XOR(                DB24       ), K42XOR(                DB25       ), K37XOR(                DB26       ), K24XOR(                DB27       ), K01XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K50XOR(                DB27       ), K21XOR(                DB28       ), K22XOR(                DB29       ), K10XOR(                DB30       ), K30XOR(                DB31       ), K09XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(480);
			switch (threadIdx.y) {
			case 0: s1(K13XOR((   1 & SALT) ? DB47 : DB63), K47XOR((   2 & SALT) ? DB48 : DB32), K34XOR((   4 & SALT) ? DB49 : DB33), K53XOR((   8 & SALT) ? DB50 : DB34), K18XOR((  16 & SALT) ? DB51 : DB35), K45XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K04XOR((  64 & SALT) ? DB51 : DB35), K25XOR(( 128 & SALT) ? DB52 : DB36), K06XOR(( 256 & SALT) ? DB53 : DB37), K38XOR(( 512 & SALT) ? DB54 : DB38), K19XOR((1024 & SALT) ? DB55 : DB39), K41XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K05XOR(                DB39       ), K33XOR(                DB40       ), K27XOR(                DB41       ), K52XOR(                DB42       ), K39XOR(                DB43       ), K55XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K54XOR(                DB43       ), K31XOR(                DB44       ), K32XOR(                DB45       ), K26XOR(                DB46       ), K20XOR(                DB47       ), K11XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K14XOR((   1 & SALT) ? DB63 : DB47), K51XOR((   2 & SALT) ? DB32 : DB48), K02XOR((   4 & SALT) ? DB33 : DB49), K42XOR((   8 & SALT) ? DB34 : DB50), K29XOR((  16 & SALT) ? DB35 : DB51), K30XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K09XOR((  64 & SALT) ? DB35 : DB51), K21XOR(( 128 & SALT) ? DB36 : DB52), K01XOR(( 256 & SALT) ? DB37 : DB53), K43XOR(( 512 & SALT) ? DB38 : DB54), K17XOR((1024 & SALT) ? DB39 : DB55), K22XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K50XOR(                DB55       ), K15XOR(                DB56       ), K28XOR(                DB57       ), K23XOR(                DB58       ), K10XOR(                DB59       ), K44XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K36XOR(                DB59       ), K07XOR(                DB60       ), K08XOR(                DB61       ), K49XOR(                DB62       ), K16XOR(                DB63       ), K24XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(576);
			switch (threadIdx.y) {
			case 0: s1(K54XOR((   1 & SALT) ? DB15 : DB31), K33XOR((   2 & SALT) ? DB16 : DB00), K20XOR((   4 & SALT) ? DB17 : DB01), K39XOR((   8 & SALT) ? DB18 : DB02), K04XOR((  16 & SALT) ? DB19 : DB03), K31XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K45XOR((  64 & SALT) ? DB19 : DB03), K11XOR(( 128 & SALT) ? DB20 : DB04), K47XOR(( 256 & SALT) ? DB21 : DB05), K55XOR(( 512 & SALT) ? DB22 : DB06), K05XOR((1024 & SALT) ? DB23 : DB07), K27XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K46XOR(                DB07       ), K19XOR(                DB08       ), K13XOR(                DB09       ), K38XOR(                DB10       ), K25XOR(                DB11       ), K41XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K40XOR(                DB11       ), K48XOR(                DB12       ), K18XOR(                DB13       ), K12XOR(                DB14       ), K06XOR(                DB15       ), K52XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K00XOR((   1 & SALT) ? DB31 : DB15), K37XOR((   2 & SALT) ? DB00 : DB16), K17XOR((   4 & SALT) ? DB01 : DB17), K28XOR((   8 & SALT) ? DB02 : DB18), K15XOR((  16 & SALT) ? DB03 : DB19), K16XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K24XOR((  64 & SALT) ? DB03 : DB19), K07XOR(( 128 & SALT) ? DB04 : DB20), K44XOR(( 256 & SALT) ? DB05 : DB21), K29XOR(( 512 & SALT) ? DB06 : DB22), K03XOR((1024 & SALT) ? DB07 : DB23), K08XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K36XOR(                DB23       ), K01XOR(                DB24       ), K14XOR(                DB25       ), K09XOR(                DB26       ), K49XOR(                DB27       ), K30XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K22XOR(                DB27       ), K50XOR(                DB28       ), K51XOR(                DB29       ), K35XOR(                DB30       ), K02XOR(                DB31       ), K10XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(576);
			switch (threadIdx.y) {
			case 0: s1(K40XOR((   1 & SALT) ? DB47 : DB63), K19XOR((   2 & SALT) ? DB48 : DB32), K06XOR((   4 & SALT) ? DB49 : DB33), K25XOR((   8 & SALT) ? DB50 : DB34), K45XOR((  16 & SALT) ? DB51 : DB35), K48XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K31XOR((  64 & SALT) ? DB51 : DB35), K52XOR(( 128 & SALT) ? DB52 : DB36), K33XOR(( 256 & SALT) ? DB53 : DB37), K41XOR(( 512 & SALT) ? DB54 : DB38), K46XOR((1024 & SALT) ? DB55 : DB39), K13XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K32XOR(                DB39       ), K05XOR(                DB40       ), K54XOR(                DB41       ), K55XOR(                DB42       ), K11XOR(                DB43       ), K27XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K26XOR(                DB43       ), K34XOR(                DB44       ), K04XOR(                DB45       ), K53XOR(                DB46       ), K47XOR(                DB47       ), K38XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K43XOR((   1 & SALT) ? DB63 : DB47), K23XOR((   2 & SALT) ? DB32 : DB48), K03XOR((   4 & SALT) ? DB33 : DB49), K14XOR((   8 & SALT) ? DB34 : DB50), K01XOR((  16 & SALT) ? DB35 : DB51), K02XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K10XOR((  64 & SALT) ? DB35 : DB51), K50XOR(( 128 & SALT) ? DB36 : DB52), K30XOR(( 256 & SALT) ? DB37 : DB53), K15XOR(( 512 & SALT) ? DB38 : DB54), K42XOR((1024 & SALT) ? DB39 : DB55), K51XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K22XOR(                DB55       ), K44XOR(                DB56       ), K00XOR(                DB57       ), K24XOR(                DB58       ), K35XOR(                DB59       ), K16XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K08XOR(                DB59       ), K36XOR(                DB60       ), K37XOR(                DB61       ), K21XOR(                DB62       ), K17XOR(                DB63       ), K49XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(672);
			switch (threadIdx.y) {
			case 0: s1(K26XOR((   1 & SALT) ? DB15 : DB31), K05XOR((   2 & SALT) ? DB16 : DB00), K47XOR((   4 & SALT) ? DB17 : DB01), K11XOR((   8 & SALT) ? DB18 : DB02), K31XOR((  16 & SALT) ? DB19 : DB03), K34XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K48XOR((  64 & SALT) ? DB19 : DB03), K38XOR(( 128 & SALT) ? DB20 : DB04), K19XOR(( 256 & SALT) ? DB21 : DB05), K27XOR(( 512 & SALT) ? DB22 : DB06), K32XOR((1024 & SALT) ? DB23 : DB07), K54XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K18XOR(                DB07       ), K46XOR(                DB08       ), K40XOR(                DB09       ), K41XOR(                DB10       ), K52XOR(                DB11       ), K13XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K12XOR(                DB11       ), K20XOR(                DB12       ), K45XOR(                DB13       ), K39XOR(                DB14       ), K33XOR(                DB15       ), K55XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K29XOR((   1 & SALT) ? DB31 : DB15), K09XOR((   2 & SALT) ? DB00 : DB16), K42XOR((   4 & SALT) ? DB01 : DB17), K00XOR((   8 & SALT) ? DB02 : DB18), K44XOR((  16 & SALT) ? DB03 : DB19), K17XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K49XOR((  64 & SALT) ? DB03 : DB19), K36XOR(( 128 & SALT) ? DB04 : DB20), K16XOR(( 256 & SALT) ? DB05 : DB21), K01XOR(( 512 & SALT) ? DB06 : DB22), K28XOR((1024 & SALT) ? DB07 : DB23), K37XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K08XOR(                DB23       ), K30XOR(                DB24       ), K43XOR(                DB25       ), K10XOR(                DB26       ), K21XOR(                DB27       ), K02XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K51XOR(                DB27       ), K22XOR(                DB28       ), K23XOR(                DB29       ), K07XOR(                DB30       ), K03XOR(                DB31       ), K35XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(672);
			switch (threadIdx.y) {
			case 0: s1(K19XOR((   1 & SALT) ? DB47 : DB63), K53XOR((   2 & SALT) ? DB48 : DB32), K40XOR((   4 & SALT) ? DB49 : DB33), K04XOR((   8 & SALT) ? DB50 : DB34), K55XOR((  16 & SALT) ? DB51 : DB35), K27XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K41XOR((  64 & SALT) ? DB51 : DB35), K31XOR(( 128 & SALT) ? DB52 : DB36), K12XOR(( 256 & SALT) ? DB53 : DB37), K20XOR(( 512 & SALT) ? DB54 : DB38), K25XOR((1024 & SALT) ? DB55 : DB39), K47XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K11XOR(                DB39       ), K39XOR(                DB40       ), K33XOR(                DB41       ), K34XOR(                DB42       ), K45XOR(                DB43       ), K06XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K05XOR(                DB43       ), K13XOR(                DB44       ), K38XOR(                DB45       ), K32XOR(                DB46       ), K26XOR(                DB47       ), K48XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K22XOR((   1 & SALT) ? DB63 : DB47), K02XOR((   2 & SALT) ? DB32 : DB48), K35XOR((   4 & SALT) ? DB33 : DB49), K50XOR((   8 & SALT) ? DB34 : DB50), K37XOR((  16 & SALT) ? DB35 : DB51), K10XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K42XOR((  64 & SALT) ? DB35 : DB51), K29XOR(( 128 & SALT) ? DB36 : DB52), K09XOR(( 256 & SALT) ? DB37 : DB53), K51XOR(( 512 & SALT) ? DB38 : DB54), K21XOR((1024 & SALT) ? DB39 : DB55), K30XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K01XOR(                DB55       ), K23XOR(                DB56       ), K36XOR(                DB57       ), K03XOR(                DB58       ), K14XOR(                DB59       ), K24XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K44XOR(                DB59       ), K15XOR(                DB60       ), K16XOR(                DB61       ), K00XOR(                DB62       ), K49XOR(                DB63       ), K28XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		
			if (i >= 12)
				break;

			// ROUND_B(-48);
			switch (threadIdx.y) {
			case 0: s1(K12XOR((   1 & SALT) ? DB47 : DB63), K46XOR((   2 & SALT) ? DB48 : DB32), K33XOR((   4 & SALT) ? DB49 : DB33), K52XOR((   8 & SALT) ? DB50 : DB34), K48XOR((  16 & SALT) ? DB51 : DB35), K20XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K34XOR((  64 & SALT) ? DB51 : DB35), K55XOR(( 128 & SALT) ? DB52 : DB36), K05XOR(( 256 & SALT) ? DB53 : DB37), K13XOR(( 512 & SALT) ? DB54 : DB38), K18XOR((1024 & SALT) ? DB55 : DB39), K40XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K04XOR(                DB39       ), K32XOR(                DB40       ), K26XOR(                DB41       ), K27XOR(                DB42       ), K38XOR(                DB43       ), K54XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K53XOR(                DB43       ), K06XOR(                DB44       ), K31XOR(                DB45       ), K25XOR(                DB46       ), K19XOR(                DB47       ), K41XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K15XOR((   1 & SALT) ? DB63 : DB47), K24XOR((   2 & SALT) ? DB32 : DB48), K28XOR((   4 & SALT) ? DB33 : DB49), K43XOR((   8 & SALT) ? DB34 : DB50), K30XOR((  16 & SALT) ? DB35 : DB51), K03XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K35XOR((  64 & SALT) ? DB35 : DB51), K22XOR(( 128 & SALT) ? DB36 : DB52), K02XOR(( 256 & SALT) ? DB37 : DB53), K44XOR(( 512 & SALT) ? DB38 : DB54), K14XOR((1024 & SALT) ? DB39 : DB55), K23XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K51XOR(                DB55       ), K16XOR(                DB56       ), K29XOR(                DB57       ), K49XOR(                DB58       ), K07XOR(                DB59       ), K17XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K37XOR(                DB59       ), K08XOR(                DB60       ), K09XOR(                DB61       ), K50XOR(                DB62       ), K42XOR(                DB63       ), K21XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(48);
			switch (threadIdx.y) {
			case 0: s1(K05XOR((   1 & SALT) ? DB15 : DB31), K39XOR((   2 & SALT) ? DB16 : DB00), K26XOR((   4 & SALT) ? DB17 : DB01), K45XOR((   8 & SALT) ? DB18 : DB02), K41XOR((  16 & SALT) ? DB19 : DB03), K13XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K27XOR((  64 & SALT) ? DB19 : DB03), K48XOR(( 128 & SALT) ? DB20 : DB04), K53XOR(( 256 & SALT) ? DB21 : DB05), K06XOR(( 512 & SALT) ? DB22 : DB06), K11XOR((1024 & SALT) ? DB23 : DB07), K33XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K52XOR(                DB07       ), K25XOR(                DB08       ), K19XOR(                DB09       ), K20XOR(                DB10       ), K31XOR(                DB11       ), K47XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K46XOR(                DB11       ), K54XOR(                DB12       ), K55XOR(                DB13       ), K18XOR(                DB14       ), K12XOR(                DB15       ), K34XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K08XOR((   1 & SALT) ? DB31 : DB15), K17XOR((   2 & SALT) ? DB00 : DB16), K21XOR((   4 & SALT) ? DB01 : DB17), K36XOR((   8 & SALT) ? DB02 : DB18), K23XOR((  16 & SALT) ? DB03 : DB19), K49XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K28XOR((  64 & SALT) ? DB03 : DB19), K15XOR(( 128 & SALT) ? DB04 : DB20), K24XOR(( 256 & SALT) ? DB05 : DB21), K37XOR(( 512 & SALT) ? DB06 : DB22), K07XOR((1024 & SALT) ? DB07 : DB23), K16XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K44XOR(                DB23       ), K09XOR(                DB24       ), K22XOR(                DB25       ), K42XOR(                DB26       ), K00XOR(                DB27       ), K10XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K30XOR(                DB27       ), K01XOR(                DB28       ), K02XOR(                DB29       ), K43XOR(                DB30       ), K35XOR(                DB31       ), K14XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(48);
			switch (threadIdx.y) {
			case 0: s1(K46XOR((   1 & SALT) ? DB47 : DB63), K25XOR((   2 & SALT) ? DB48 : DB32), K12XOR((   4 & SALT) ? DB49 : DB33), K31XOR((   8 & SALT) ? DB50 : DB34), K27XOR((  16 & SALT) ? DB51 : DB35), K54XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K13XOR((  64 & SALT) ? DB51 : DB35), K34XOR(( 128 & SALT) ? DB52 : DB36), K39XOR(( 256 & SALT) ? DB53 : DB37), K47XOR(( 512 & SALT) ? DB54 : DB38), K52XOR((1024 & SALT) ? DB55 : DB39), K19XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K38XOR(                DB39       ), K11XOR(                DB40       ), K05XOR(                DB41       ), K06XOR(                DB42       ), K48XOR(                DB43       ), K33XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K32XOR(                DB43       ), K40XOR(                DB44       ), K41XOR(                DB45       ), K04XOR(                DB46       ), K53XOR(                DB47       ), K20XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K51XOR((   1 & SALT) ? DB63 : DB47), K03XOR((   2 & SALT) ? DB32 : DB48), K07XOR((   4 & SALT) ? DB33 : DB49), K22XOR((   8 & SALT) ? DB34 : DB50), K09XOR((  16 & SALT) ? DB35 : DB51), K35XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K14XOR((  64 & SALT) ? DB35 : DB51), K01XOR(( 128 & SALT) ? DB36 : DB52), K10XOR(( 256 & SALT) ? DB37 : DB53), K23XOR(( 512 & SALT) ? DB38 : DB54), K50XOR((1024 & SALT) ? DB39 : DB55), K02XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K30XOR(                DB55       ), K24XOR(                DB56       ), K08XOR(                DB57       ), K28XOR(                DB58       ), K43XOR(                DB59       ), K49XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K16XOR(                DB59       ), K44XOR(                DB60       ), K17XOR(                DB61       ), K29XOR(                DB62       ), K21XOR(                DB63       ), K00XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(144);
			switch (threadIdx.y) {
			case 0: s1(K32XOR((   1 & SALT) ? DB15 : DB31), K11XOR((   2 & SALT) ? DB16 : DB00), K53XOR((   4 & SALT) ? DB17 : DB01), K48XOR((   8 & SALT) ? DB18 : DB02), K13XOR((  16 & SALT) ? DB19 : DB03), K40XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K54XOR((  64 & SALT) ? DB19 : DB03), K20XOR(( 128 & SALT) ? DB20 : DB04), K25XOR(( 256 & SALT) ? DB21 : DB05), K33XOR(( 512 & SALT) ? DB22 : DB06), K38XOR((1024 & SALT) ? DB23 : DB07), K05XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K55XOR(                DB07       ), K52XOR(                DB08       ), K46XOR(                DB09       ), K47XOR(                DB10       ), K34XOR(                DB11       ), K19XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K18XOR(                DB11       ), K26XOR(                DB12       ), K27XOR(                DB13       ), K45XOR(                DB14       ), K39XOR(                DB15       ), K06XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K37XOR((   1 & SALT) ? DB31 : DB15), K42XOR((   2 & SALT) ? DB00 : DB16), K50XOR((   4 & SALT) ? DB01 : DB17), K08XOR((   8 & SALT) ? DB02 : DB18), K24XOR((  16 & SALT) ? DB03 : DB19), K21XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K00XOR((  64 & SALT) ? DB03 : DB19), K44XOR(( 128 & SALT) ? DB04 : DB20), K49XOR(( 256 & SALT) ? DB05 : DB21), K09XOR(( 512 & SALT) ? DB06 : DB22), K36XOR((1024 & SALT) ? DB07 : DB23), K17XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K16XOR(                DB23       ), K10XOR(                DB24       ), K51XOR(                DB25       ), K14XOR(                DB26       ), K29XOR(                DB27       ), K35XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K02XOR(                DB27       ), K30XOR(                DB28       ), K03XOR(                DB29       ), K15XOR(                DB30       ), K07XOR(                DB31       ), K43XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(144);
			switch (threadIdx.y) {
			case 0: s1(K18XOR((   1 & SALT) ? DB47 : DB63), K52XOR((   2 & SALT) ? DB48 : DB32), K39XOR((   4 & SALT) ? DB49 : DB33), K34XOR((   8 & SALT) ? DB50 : DB34), K54XOR((  16 & SALT) ? DB51 : DB35), K26XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K40XOR((  64 & SALT) ? DB51 : DB35), K06XOR(( 128 & SALT) ? DB52 : DB36), K11XOR(( 256 & SALT) ? DB53 : DB37), K19XOR(( 512 & SALT) ? DB54 : DB38), K55XOR((1024 & SALT) ? DB55 : DB39), K46XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K41XOR(                DB39       ), K38XOR(                DB40       ), K32XOR(                DB41       ), K33XOR(                DB42       ), K20XOR(                DB43       ), K05XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K04XOR(                DB43       ), K12XOR(                DB44       ), K13XOR(                DB45       ), K31XOR(                DB46       ), K25XOR(                DB47       ), K47XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K23XOR((   1 & SALT) ? DB63 : DB47), K28XOR((   2 & SALT) ? DB32 : DB48), K36XOR((   4 & SALT) ? DB33 : DB49), K51XOR((   8 & SALT) ? DB34 : DB50), K10XOR((  16 & SALT) ? DB35 : DB51), K07XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K43XOR((  64 & SALT) ? DB35 : DB51), K30XOR(( 128 & SALT) ? DB36 : DB52), K35XOR(( 256 & SALT) ? DB37 : DB53), K24XOR(( 512 & SALT) ? DB38 : DB54), K22XOR((1024 & SALT) ? DB39 : DB55), K03XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K02XOR(                DB55       ), K49XOR(                DB56       ), K37XOR(                DB57       ), K00XOR(                DB58       ), K15XOR(                DB59       ), K21XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K17XOR(                DB59       ), K16XOR(                DB60       ), K42XOR(                DB61       ), K01XOR(                DB62       ), K50XOR(                DB63       ), K29XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(240);
			switch (threadIdx.y) {
			case 0: s1(K04XOR((   1 & SALT) ? DB15 : DB31), K38XOR((   2 & SALT) ? DB16 : DB00), K25XOR((   4 & SALT) ? DB17 : DB01), K20XOR((   8 & SALT) ? DB18 : DB02), K40XOR((  16 & SALT) ? DB19 : DB03), K12XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K26XOR((  64 & SALT) ? DB19 : DB03), K47XOR(( 128 & SALT) ? DB20 : DB04), K52XOR(( 256 & SALT) ? DB21 : DB05), K05XOR(( 512 & SALT) ? DB22 : DB06), K41XOR((1024 & SALT) ? DB23 : DB07), K32XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K27XOR(                DB07       ), K55XOR(                DB08       ), K18XOR(                DB09       ), K19XOR(                DB10       ), K06XOR(                DB11       ), K46XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K45XOR(                DB11       ), K53XOR(                DB12       ), K54XOR(                DB13       ), K48XOR(                DB14       ), K11XOR(                DB15       ), K33XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K09XOR((   1 & SALT) ? DB31 : DB15), K14XOR((   2 & SALT) ? DB00 : DB16), K22XOR((   4 & SALT) ? DB01 : DB17), K37XOR((   8 & SALT) ? DB02 : DB18), K49XOR((  16 & SALT) ? DB03 : DB19), K50XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K29XOR((  64 & SALT) ? DB03 : DB19), K16XOR(( 128 & SALT) ? DB04 : DB20), K21XOR(( 256 & SALT) ? DB05 : DB21), K10XOR(( 512 & SALT) ? DB06 : DB22), K08XOR((1024 & SALT) ? DB07 : DB23), K42XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K17XOR(                DB23       ), K35XOR(                DB24       ), K23XOR(                DB25       ), K43XOR(                DB26       ), K01XOR(                DB27       ), K07XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K03XOR(                DB27       ), K02XOR(                DB28       ), K28XOR(                DB29       ), K44XOR(                DB30       ), K36XOR(                DB31       ), K15XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(240);
			switch (threadIdx.y) {
			case 0: s1(K45XOR((   1 & SALT) ? DB47 : DB63), K55XOR((   2 & SALT) ? DB48 : DB32), K11XOR((   4 & SALT) ? DB49 : DB33), K06XOR((   8 & SALT) ? DB50 : DB34), K26XOR((  16 & SALT) ? DB51 : DB35), K53XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K12XOR((  64 & SALT) ? DB51 : DB35), K33XOR(( 128 & SALT) ? DB52 : DB36), K38XOR(( 256 & SALT) ? DB53 : DB37), K46XOR(( 512 & SALT) ? DB54 : DB38), K27XOR((1024 & SALT) ? DB55 : DB39), K18XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K13XOR(                DB39       ), K41XOR(                DB40       ), K04XOR(                DB41       ), K05XOR(                DB42       ), K47XOR(                DB43       ), K32XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K31XOR(                DB43       ), K39XOR(                DB44       ), K40XOR(                DB45       ), K34XOR(                DB46       ), K52XOR(                DB47       ), K19XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K24XOR((   1 & SALT) ? DB63 : DB47), K00XOR((   2 & SALT) ? DB32 : DB48), K08XOR((   4 & SALT) ? DB33 : DB49), K23XOR((   8 & SALT) ? DB34 : DB50), K35XOR((  16 & SALT) ? DB35 : DB51), K36XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K15XOR((  64 & SALT) ? DB35 : DB51), K02XOR(( 128 & SALT) ? DB36 : DB52), K07XOR(( 256 & SALT) ? DB37 : DB53), K49XOR(( 512 & SALT) ? DB38 : DB54), K51XOR((1024 & SALT) ? DB39 : DB55), K28XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K03XOR(                DB55       ), K21XOR(                DB56       ), K09XOR(                DB57       ), K29XOR(                DB58       ), K44XOR(                DB59       ), K50XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K42XOR(                DB59       ), K17XOR(                DB60       ), K14XOR(                DB61       ), K30XOR(                DB62       ), K22XOR(                DB63       ), K01XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(336);
			switch (threadIdx.y) {
			case 0: s1(K31XOR((   1 & SALT) ? DB15 : DB31), K41XOR((   2 & SALT) ? DB16 : DB00), K52XOR((   4 & SALT) ? DB17 : DB01), K47XOR((   8 & SALT) ? DB18 : DB02), K12XOR((  16 & SALT) ? DB19 : DB03), K39XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K53XOR((  64 & SALT) ? DB19 : DB03), K19XOR(( 128 & SALT) ? DB20 : DB04), K55XOR(( 256 & SALT) ? DB21 : DB05), K32XOR(( 512 & SALT) ? DB22 : DB06), K13XOR((1024 & SALT) ? DB23 : DB07), K04XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K54XOR(                DB07       ), K27XOR(                DB08       ), K45XOR(                DB09       ), K46XOR(                DB10       ), K33XOR(                DB11       ), K18XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K48XOR(                DB11       ), K25XOR(                DB12       ), K26XOR(                DB13       ), K20XOR(                DB14       ), K38XOR(                DB15       ), K05XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K10XOR((   1 & SALT) ? DB31 : DB15), K43XOR((   2 & SALT) ? DB00 : DB16), K51XOR((   4 & SALT) ? DB01 : DB17), K09XOR((   8 & SALT) ? DB02 : DB18), K21XOR((  16 & SALT) ? DB03 : DB19), K22XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K01XOR((  64 & SALT) ? DB03 : DB19), K17XOR(( 128 & SALT) ? DB04 : DB20), K50XOR(( 256 & SALT) ? DB05 : DB21), K35XOR(( 512 & SALT) ? DB06 : DB22), K37XOR((1024 & SALT) ? DB07 : DB23), K14XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K42XOR(                DB23       ), K07XOR(                DB24       ), K24XOR(                DB25       ), K15XOR(                DB26       ), K30XOR(                DB27       ), K36XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K28XOR(                DB27       ), K03XOR(                DB28       ), K00XOR(                DB29       ), K16XOR(                DB30       ), K08XOR(                DB31       ), K44XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(336);
			switch (threadIdx.y) {
			case 0: s1(K55XOR((   1 & SALT) ? DB47 : DB63), K34XOR((   2 & SALT) ? DB48 : DB32), K45XOR((   4 & SALT) ? DB49 : DB33), K40XOR((   8 & SALT) ? DB50 : DB34), K05XOR((  16 & SALT) ? DB51 : DB35), K32XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K46XOR((  64 & SALT) ? DB51 : DB35), K12XOR(( 128 & SALT) ? DB52 : DB36), K48XOR(( 256 & SALT) ? DB53 : DB37), K25XOR(( 512 & SALT) ? DB54 : DB38), K06XOR((1024 & SALT) ? DB55 : DB39), K52XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K47XOR(                DB39       ), K20XOR(                DB40       ), K38XOR(                DB41       ), K39XOR(                DB42       ), K26XOR(                DB43       ), K11XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K41XOR(                DB43       ), K18XOR(                DB44       ), K19XOR(                DB45       ), K13XOR(                DB46       ), K31XOR(                DB47       ), K53XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K03XOR((   1 & SALT) ? DB63 : DB47), K36XOR((   2 & SALT) ? DB32 : DB48), K44XOR((   4 & SALT) ? DB33 : DB49), K02XOR((   8 & SALT) ? DB34 : DB50), K14XOR((  16 & SALT) ? DB35 : DB51), K15XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K51XOR((  64 & SALT) ? DB35 : DB51), K10XOR(( 128 & SALT) ? DB36 : DB52), K43XOR(( 256 & SALT) ? DB37 : DB53), K28XOR(( 512 & SALT) ? DB38 : DB54), K30XOR((1024 & SALT) ? DB39 : DB55), K07XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K35XOR(                DB55       ), K00XOR(                DB56       ), K17XOR(                DB57       ), K08XOR(                DB58       ), K23XOR(                DB59       ), K29XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K21XOR(                DB59       ), K49XOR(                DB60       ), K50XOR(                DB61       ), K09XOR(                DB62       ), K01XOR(                DB63       ), K37XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(432);
			switch (threadIdx.y) {
			case 0: s1(K41XOR((   1 & SALT) ? DB15 : DB31), K20XOR((   2 & SALT) ? DB16 : DB00), K31XOR((   4 & SALT) ? DB17 : DB01), K26XOR((   8 & SALT) ? DB18 : DB02), K46XOR((  16 & SALT) ? DB19 : DB03), K18XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K32XOR((  64 & SALT) ? DB19 : DB03), K53XOR(( 128 & SALT) ? DB20 : DB04), K34XOR(( 256 & SALT) ? DB21 : DB05), K11XOR(( 512 & SALT) ? DB22 : DB06), K47XOR((1024 & SALT) ? DB23 : DB07), K38XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K33XOR(                DB07       ), K06XOR(                DB08       ), K55XOR(                DB09       ), K25XOR(                DB10       ), K12XOR(                DB11       ), K52XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K27XOR(                DB11       ), K04XOR(                DB12       ), K05XOR(                DB13       ), K54XOR(                DB14       ), K48XOR(                DB15       ), K39XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K42XOR((   1 & SALT) ? DB31 : DB15), K22XOR((   2 & SALT) ? DB00 : DB16), K30XOR((   4 & SALT) ? DB01 : DB17), K17XOR((   8 & SALT) ? DB02 : DB18), K00XOR((  16 & SALT) ? DB03 : DB19), K01XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K37XOR((  64 & SALT) ? DB03 : DB19), K49XOR(( 128 & SALT) ? DB04 : DB20), K29XOR(( 256 & SALT) ? DB05 : DB21), K14XOR(( 512 & SALT) ? DB06 : DB22), K16XOR((1024 & SALT) ? DB07 : DB23), K50XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K21XOR(                DB23       ), K43XOR(                DB24       ), K03XOR(                DB25       ), K51XOR(                DB26       ), K09XOR(                DB27       ), K15XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K07XOR(                DB27       ), K35XOR(                DB28       ), K36XOR(                DB29       ), K24XOR(                DB30       ), K44XOR(                DB31       ), K23XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(432);
			switch (threadIdx.y) {
			case 0: s1(K27XOR((   1 & SALT) ? DB47 : DB63), K06XOR((   2 & SALT) ? DB48 : DB32), K48XOR((   4 & SALT) ? DB49 : DB33), K12XOR((   8 & SALT) ? DB50 : DB34), K32XOR((  16 & SALT) ? DB51 : DB35), K04XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K18XOR((  64 & SALT) ? DB51 : DB35), K39XOR(( 128 & SALT) ? DB52 : DB36), K20XOR(( 256 & SALT) ? DB53 : DB37), K52XOR(( 512 & SALT) ? DB54 : DB38), K33XOR((1024 & SALT) ? DB55 : DB39), K55XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K19XOR(                DB39       ), K47XOR(                DB40       ), K41XOR(                DB41       ), K11XOR(                DB42       ), K53XOR(                DB43       ), K38XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K13XOR(                DB43       ), K45XOR(                DB44       ), K46XOR(                DB45       ), K40XOR(                DB46       ), K34XOR(                DB47       ), K25XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K28XOR((   1 & SALT) ? DB63 : DB47), K08XOR((   2 & SALT) ? DB32 : DB48), K16XOR((   4 & SALT) ? DB33 : DB49), K03XOR((   8 & SALT) ? DB34 : DB50), K43XOR((  16 & SALT) ? DB35 : DB51), K44XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K23XOR((  64 & SALT) ? DB35 : DB51), K35XOR(( 128 & SALT) ? DB36 : DB52), K15XOR(( 256 & SALT) ? DB37 : DB53), K00XOR(( 512 & SALT) ? DB38 : DB54), K02XOR((1024 & SALT) ? DB39 : DB55), K36XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K07XOR(                DB55       ), K29XOR(                DB56       ), K42XOR(                DB57       ), K37XOR(                DB58       ), K24XOR(                DB59       ), K01XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K50XOR(                DB59       ), K21XOR(                DB60       ), K22XOR(                DB61       ), K10XOR(                DB62       ), K30XOR(                DB63       ), K09XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(528);
			switch (threadIdx.y) {
			case 0: s1(K13XOR((   1 & SALT) ? DB15 : DB31), K47XOR((   2 & SALT) ? DB16 : DB00), K34XOR((   4 & SALT) ? DB17 : DB01), K53XOR((   8 & SALT) ? DB18 : DB02), K18XOR((  16 & SALT) ? DB19 : DB03), K45XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K04XOR((  64 & SALT) ? DB19 : DB03), K25XOR(( 128 & SALT) ? DB20 : DB04), K06XOR(( 256 & SALT) ? DB21 : DB05), K38XOR(( 512 & SALT) ? DB22 : DB06), K19XOR((1024 & SALT) ? DB23 : DB07), K41XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K05XOR(                DB07       ), K33XOR(                DB08       ), K27XOR(                DB09       ), K52XOR(                DB10       ), K39XOR(                DB11       ), K55XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K54XOR(                DB11       ), K31XOR(                DB12       ), K32XOR(                DB13       ), K26XOR(                DB14       ), K20XOR(                DB15       ), K11XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K14XOR((   1 & SALT) ? DB31 : DB15), K51XOR((   2 & SALT) ? DB00 : DB16), K02XOR((   4 & SALT) ? DB01 : DB17), K42XOR((   8 & SALT) ? DB02 : DB18), K29XOR((  16 & SALT) ? DB03 : DB19), K30XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K09XOR((  64 & SALT) ? DB03 : DB19), K21XOR(( 128 & SALT) ? DB04 : DB20), K01XOR(( 256 & SALT) ? DB05 : DB21), K43XOR(( 512 & SALT) ? DB06 : DB22), K17XOR((1024 & SALT) ? DB07 : DB23), K22XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K50XOR(                DB23       ), K15XOR(                DB24       ), K28XOR(                DB25       ), K23XOR(                DB26       ), K10XOR(                DB27       ), K44XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K36XOR(                DB27       ), K07XOR(                DB28       ), K08XOR(                DB29       ), K49XOR(                DB30       ), K16XOR(                DB31       ), K24XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(528);
			switch (threadIdx.y) {
			case 0: s1(K54XOR((   1 & SALT) ? DB47 : DB63), K33XOR((   2 & SALT) ? DB48 : DB32), K20XOR((   4 & SALT) ? DB49 : DB33), K39XOR((   8 & SALT) ? DB50 : DB34), K04XOR((  16 & SALT) ? DB51 : DB35), K31XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K45XOR((  64 & SALT) ? DB51 : DB35), K11XOR(( 128 & SALT) ? DB52 : DB36), K47XOR(( 256 & SALT) ? DB53 : DB37), K55XOR(( 512 & SALT) ? DB54 : DB38), K05XOR((1024 & SALT) ? DB55 : DB39), K27XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K46XOR(                DB39       ), K19XOR(                DB40       ), K13XOR(                DB41       ), K38XOR(                DB42       ), K25XOR(                DB43       ), K41XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K40XOR(                DB43       ), K48XOR(                DB44       ), K18XOR(                DB45       ), K12XOR(                DB46       ), K06XOR(                DB47       ), K52XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K00XOR((   1 & SALT) ? DB63 : DB47), K37XOR((   2 & SALT) ? DB32 : DB48), K17XOR((   4 & SALT) ? DB33 : DB49), K28XOR((   8 & SALT) ? DB34 : DB50), K15XOR((  16 & SALT) ? DB35 : DB51), K16XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K24XOR((  64 & SALT) ? DB35 : DB51), K07XOR(( 128 & SALT) ? DB36 : DB52), K44XOR(( 256 & SALT) ? DB37 : DB53), K29XOR(( 512 & SALT) ? DB38 : DB54), K03XOR((1024 & SALT) ? DB39 : DB55), K08XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K36XOR(                DB55       ), K01XOR(                DB56       ), K14XOR(                DB57       ), K09XOR(                DB58       ), K49XOR(                DB59       ), K30XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K22XOR(                DB59       ), K50XOR(                DB60       ), K51XOR(                DB61       ), K35XOR(                DB62       ), K02XOR(                DB63       ), K10XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(624);
			switch (threadIdx.y) {
			case 0: s1(K40XOR((   1 & SALT) ? DB15 : DB31), K19XOR((   2 & SALT) ? DB16 : DB00), K06XOR((   4 & SALT) ? DB17 : DB01), K25XOR((   8 & SALT) ? DB18 : DB02), K45XOR((  16 & SALT) ? DB19 : DB03), K48XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K31XOR((  64 & SALT) ? DB19 : DB03), K52XOR(( 128 & SALT) ? DB20 : DB04), K33XOR(( 256 & SALT) ? DB21 : DB05), K41XOR(( 512 & SALT) ? DB22 : DB06), K46XOR((1024 & SALT) ? DB23 : DB07), K13XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K32XOR(                DB07       ), K05XOR(                DB08       ), K54XOR(                DB09       ), K55XOR(                DB10       ), K11XOR(                DB11       ), K27XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K26XOR(                DB11       ), K34XOR(                DB12       ), K04XOR(                DB13       ), K53XOR(                DB14       ), K47XOR(                DB15       ), K38XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K43XOR((   1 & SALT) ? DB31 : DB15), K23XOR((   2 & SALT) ? DB00 : DB16), K03XOR((   4 & SALT) ? DB01 : DB17), K14XOR((   8 & SALT) ? DB02 : DB18), K01XOR((  16 & SALT) ? DB03 : DB19), K02XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K10XOR((  64 & SALT) ? DB03 : DB19), K50XOR(( 128 & SALT) ? DB04 : DB20), K30XOR(( 256 & SALT) ? DB05 : DB21), K15XOR(( 512 & SALT) ? DB06 : DB22), K42XOR((1024 & SALT) ? DB07 : DB23), K51XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K22XOR(                DB23       ), K44XOR(                DB24       ), K00XOR(                DB25       ), K24XOR(                DB26       ), K35XOR(                DB27       ), K16XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K08XOR(                DB27       ), K36XOR(                DB28       ), K37XOR(                DB29       ), K21XOR(                DB30       ), K17XOR(                DB31       ), K49XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		

			// ROUND_B(624);
			switch (threadIdx.y) {
			case 0: s1(K26XOR((   1 & SALT) ? DB47 : DB63), K05XOR((   2 & SALT) ? DB48 : DB32), K47XOR((   4 & SALT) ? DB49 : DB33), K11XOR((   8 & SALT) ? DB50 : DB34), K31XOR((  16 & SALT) ? DB51 : DB35), K34XOR((  32 & SALT) ? DB52 : DB36), &DB08, &DB16, &DB22, &DB30);
					s2(K48XOR((  64 & SALT) ? DB51 : DB35), K38XOR(( 128 & SALT) ? DB52 : DB36), K19XOR(( 256 & SALT) ? DB53 : DB37), K27XOR(( 512 & SALT) ? DB54 : DB38), K32XOR((1024 & SALT) ? DB55 : DB39), K54XOR((2048 & SALT) ? DB56 : DB40), &DB12, &DB27, &DB01, &DB17); break;
			case 1: s3(K18XOR(                DB39       ), K46XOR(                DB40       ), K40XOR(                DB41       ), K41XOR(                DB42       ), K52XOR(                DB43       ), K13XOR(                DB44       ), &DB23, &DB15, &DB29, &DB05);
					s4(K12XOR(                DB43       ), K20XOR(                DB44       ), K45XOR(                DB45       ), K39XOR(                DB46       ), K33XOR(                DB47       ), K55XOR(                DB48       ), &DB25, &DB19, &DB09, &DB00); break;
			case 2: s5(K29XOR((   1 & SALT) ? DB63 : DB47), K09XOR((   2 & SALT) ? DB32 : DB48), K42XOR((   4 & SALT) ? DB33 : DB49), K00XOR((   8 & SALT) ? DB34 : DB50), K44XOR((  16 & SALT) ? DB35 : DB51), K17XOR((  32 & SALT) ? DB36 : DB52), &DB07, &DB13, &DB24, &DB02);
					s6(K49XOR((  64 & SALT) ? DB35 : DB51), K36XOR(( 128 & SALT) ? DB36 : DB52), K16XOR(( 256 & SALT) ? DB37 : DB53), K01XOR(( 512 & SALT) ? DB38 : DB54), K28XOR((1024 & SALT) ? DB39 : DB55), K37XOR((2048 & SALT) ? DB40 : DB56), &DB03, &DB28, &DB10, &DB18); break;
			case 3: s7(K08XOR(                DB55       ), K30XOR(                DB56       ), K43XOR(                DB57       ), K10XOR(                DB58       ), K21XOR(                DB59       ), K02XOR(                DB60       ), &DB31, &DB11, &DB21, &DB06);
					s8(K51XOR(                DB59       ), K22XOR(                DB60       ), K23XOR(                DB61       ), K07XOR(                DB62       ), K03XOR(                DB63       ), K35XOR(                DB32       ), &DB04, &DB26, &DB14, &DB20); break;
			}
			__syncthreads();
		

			// ROUND_A(720);
			switch (threadIdx.y) {
			case 0: s1(K19XOR((   1 & SALT) ? DB15 : DB31), K53XOR((   2 & SALT) ? DB16 : DB00), K40XOR((   4 & SALT) ? DB17 : DB01), K04XOR((   8 & SALT) ? DB18 : DB02), K55XOR((  16 & SALT) ? DB19 : DB03), K27XOR((  32 & SALT) ? DB20 : DB04), &DB40, &DB48, &DB54, &DB62);
					s2(K41XOR((  64 & SALT) ? DB19 : DB03), K31XOR(( 128 & SALT) ? DB20 : DB04), K12XOR(( 256 & SALT) ? DB21 : DB05), K20XOR(( 512 & SALT) ? DB22 : DB06), K25XOR((1024 & SALT) ? DB23 : DB07), K47XOR((2048 & SALT) ? DB24 : DB08), &DB44, &DB59, &DB33, &DB49); break;
			case 1: s3(K11XOR(                DB07       ), K39XOR(                DB08       ), K33XOR(                DB09       ), K34XOR(                DB10       ), K45XOR(                DB11       ), K06XOR(                DB12       ), &DB55, &DB47, &DB61, &DB37);
					s4(K05XOR(                DB11       ), K13XOR(                DB12       ), K38XOR(                DB13       ), K32XOR(                DB14       ), K26XOR(                DB15       ), K48XOR(                DB16       ), &DB57, &DB51, &DB41, &DB32); break;
			case 2: s5(K22XOR((   1 & SALT) ? DB31 : DB15), K02XOR((   2 & SALT) ? DB00 : DB16), K35XOR((   4 & SALT) ? DB01 : DB17), K50XOR((   8 & SALT) ? DB02 : DB18), K37XOR((  16 & SALT) ? DB03 : DB19), K10XOR((  32 & SALT) ? DB04 : DB20), &DB39, &DB45, &DB56, &DB34);
					s6(K42XOR((  64 & SALT) ? DB03 : DB19), K29XOR(( 128 & SALT) ? DB04 : DB20), K09XOR(( 256 & SALT) ? DB05 : DB21), K51XOR(( 512 & SALT) ? DB06 : DB22), K21XOR((1024 & SALT) ? DB07 : DB23), K30XOR((2048 & SALT) ? DB08 : DB24), &DB35, &DB60, &DB42, &DB50); break;
			case 3: s7(K01XOR(                DB23       ), K23XOR(                DB24       ), K36XOR(                DB25       ), K03XOR(                DB26       ), K14XOR(                DB27       ), K24XOR(                DB28       ), &DB63, &DB43, &DB53, &DB38);
					s8(K44XOR(                DB27       ), K15XOR(                DB28       ), K16XOR(                DB29       ), K00XOR(                DB30       ), K49XOR(                DB31       ), K28XOR(                DB00       ), &DB36, &DB58, &DB46, &DB52); break;
			}
			__syncthreads();
		}
	
		__syncthreads();
		if (threadIdx.y == 0) {
			if (searchMode == SEARCH_MODE_FORWARD_MATCHING) {
				for (tripcodeIndex = 0; tripcodeIndex < CUDA_DES_BS_DEPTH; ++tripcodeIndex) {
					unsigned int tripcodeChunk =   GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 63, 31, 38,  6, 46, 14, 4)
									| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 54, 22, 62, 30, 37,  5, 3)
									| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 45, 13, 53, 21, 61, 29, 2)
									| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 36,  4, 44, 12, 52, 20, 1)
									| GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 60, 28, 35,  3, 43, 11, 0);
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
				}
			} else if (searchMode == SEARCH_MODE_BACKWARD_MATCHING) {
				for (tripcodeIndex = 0; tripcodeIndex < CUDA_DES_BS_DEPTH; ++tripcodeIndex) {
					unsigned int tripcodeChunk =    GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 51, 19, 59, 27, 34,  2, 4)
		                        | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 42, 10, 50, 18, 58, 26, 3)
		                        | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 33,  1, 41,  9, 49, 17, 2)
		                        | GET_TRIPCODE_CHAR_INDEX(dataBlocks, tripcodeIndex, 57, 25, 32,  0, 40,  8, 1)
		                        | GET_TRIPCODE_CHAR_INDEX_LAST(dataBlocks, tripcodeIndex, 48, 16, 56, 24);
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
				}
			} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {
				DES_GetTripcodeChunks(tripcodeIndex, generatedTripcodeChunkArray, searchMode);
				//
				unsigned int generatedTripcodeChunk = generatedTripcodeChunkArray[0];
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
			} else {
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
			}
quit_loops:
			if (found == TRUE) {
				output->numMatchingTripcodes  = 1;
				output->pair.key.c[0] = key[0];
				output->pair.key.c[1] = key[1];
				output->pair.key.c[2] = key[2];
				output->pair.key.c[3] = key[3];
				output->pair.key.c[4] = key[4];
				output->pair.key.c[5] = key[5];
				output->pair.key.c[6] = key[6];
				output->pair.key.c[7] = CUDA_key7Array[tripcodeIndex];
			}
		}
	}
	if (threadIdx.y == 0)
		output->numGeneratedTripcodes = CUDA_DES_BS_DEPTH * 1;
}

#undef FUNCTION_NAME2
#undef FUNCTION_NAME
#undef SALT

