// Meriken's Tripcode Engine 1.0
// Copyright (c) 2011-2013 ÅüMeriken//XXX <meriken.2ch@gmail.com>
//
// The initial versions of this software were based on:
// CUDA SHA-1 Tripper 0.2.1
// Copyright (c) 2009 ÅüHoro/.IBXjcg
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



///////////////////////////////////////////////////////////////////////////////
// INCLUDE FILE(S)                                                           //
///////////////////////////////////////////////////////////////////////////////

#include "MERIKENsTripcodeEngine.h"



///////////////////////////////////////////////////////////////////////////////
// CPU SEARCH THREAD FOR 12 CHARACTER TRIPCODES                              //
///////////////////////////////////////////////////////////////////////////////

// Circular left rotation of 32-bit value 'val' left by 'bits' bits
// (assumes that 'bits' is always within range from 0 to 32)
// #define ROTL( bits, val ) \
//        ( ( ( val ) << ( bits ) ) | ( ( val ) >> ( 32 - ( bits ) ) ) )
#define ROTL(bits, val) _mm_or_si128(_mm_slli_epi32((val), (bits)), _mm_srli_epi32((val), 32 - (bits)))

inline void ConvertRaw12CharTripcodeIntoDisplayFormat(unsigned int *rawTripcodeArray, unsigned char *tripcode)
{
	tripcode[0]  = base64CharTable[ rawTripcodeArray[0] >> 26                                    ];
	tripcode[1]  = base64CharTable[(rawTripcodeArray[0] >> 20                            ) & 0x3f];
	tripcode[2]  = base64CharTable[(rawTripcodeArray[0] >> 14                            ) & 0x3f];
	tripcode[3]  = base64CharTable[(rawTripcodeArray[0] >>  8                            ) & 0x3f];
	tripcode[4]  = base64CharTable[(rawTripcodeArray[0] >>  2                            ) & 0x3f];
	tripcode[5]  = base64CharTable[(rawTripcodeArray[1] >> 28 | rawTripcodeArray[0] <<  4) & 0x3f];
	tripcode[6]  = base64CharTable[(rawTripcodeArray[1] >> 22                            ) & 0x3f];
	tripcode[7]  = base64CharTable[(rawTripcodeArray[1] >> 16                            ) & 0x3f];
	tripcode[8]  = base64CharTable[(rawTripcodeArray[1] >> 10                            ) & 0x3f];
	tripcode[9]  = base64CharTable[(rawTripcodeArray[1] >>  4                            ) & 0x3f];
	tripcode[10] = base64CharTable[(rawTripcodeArray[1] <<  2 | rawTripcodeArray[2] >> 30) & 0x3f];
	tripcode[11] = base64CharTable[(rawTripcodeArray[2] >> 24                            ) & 0x3f];
}

#define LOOK_FOR_POSSIBLE_MATCH                                                                                                                             \
	for (int wordIndex = 0; wordIndex < 4; ++wordIndex) {                                                                                                   \
		BOOL found = FALSE;                                                                                                                                 \
		                                                                                                                                                    \
		key[0] = ((key[0] & 0xfc) | wordIndex);                                                                                                             \
		                                                                                                                                                    \
		if (searchMode == SEARCH_MODE_FORWARD_MATCHING) {                                                                                                   \
			generatedTripcodeChunkArray[0] =   rawTripcodeArray[wordIndex][0] >>  2;                                                                        \
		} else if (searchMode == SEARCH_MODE_BACKWARD_MATCHING) {                                                                                           \
			generatedTripcodeChunkArray[0] = ((rawTripcodeArray[wordIndex][1] <<  8) & 0x3fffffff) | ((rawTripcodeArray[wordIndex][2] >> 24) & 0x000000ff); \
		} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {                                                                               \
			generatedTripcodeChunkArray[0] =   rawTripcodeArray[wordIndex][0] >>  2;                                                                        \
			generatedTripcodeChunkArray[1] = ((rawTripcodeArray[wordIndex][1] <<  8) & 0x3fffffff) | ((rawTripcodeArray[wordIndex][2] >> 24) & 0x000000ff); \
		} else /* if (searchMode == SEARCH_MODE_FLEXIBLE) */ {                                                                                              \
			generatedTripcodeChunkArray[0] =   rawTripcodeArray[wordIndex][0] >>  2;                                                                        \
			generatedTripcodeChunkArray[1] = ((rawTripcodeArray[wordIndex][0] <<  4) & 0x3fffffff) | ((rawTripcodeArray[wordIndex][1] >> 28) & 0x0000000f); \
			generatedTripcodeChunkArray[2] = ((rawTripcodeArray[wordIndex][0] << 10) & 0x3fffffff) | ((rawTripcodeArray[wordIndex][1] >> 22) & 0x000003ff); \
			generatedTripcodeChunkArray[3] = ((rawTripcodeArray[wordIndex][0] << 16) & 0x3fffffff) | ((rawTripcodeArray[wordIndex][1] >> 16) & 0x0000ffff); \
			generatedTripcodeChunkArray[4] = ((rawTripcodeArray[wordIndex][0] << 22) & 0x3fffffff) | ((rawTripcodeArray[wordIndex][1] >> 10) & 0x003fffff); \
			generatedTripcodeChunkArray[5] = ((rawTripcodeArray[wordIndex][0] << 28) & 0x3fffffff) | ((rawTripcodeArray[wordIndex][1] >>  4) & 0x0fffffff); \
			generatedTripcodeChunkArray[6] = ((rawTripcodeArray[wordIndex][1] <<  2) & 0x3fffffff) | ((rawTripcodeArray[wordIndex][2] >> 30) & 0x00000003); \
			generatedTripcodeChunkArray[7] = ((rawTripcodeArray[wordIndex][1] <<  8) & 0x3fffffff) | ((rawTripcodeArray[wordIndex][2] >> 24) & 0x000000ff); \
		}                                                                                                                                                   \
		                                                                                                                                                    \
		if ((searchMode == SEARCH_MODE_FORWARD_MATCHING || searchMode == SEARCH_MODE_BACKWARD_MATCHING) && numTripcodeChunk == 1) {                         \
			if (generatedTripcodeChunkArray[0] == tripcodeChunkArray[0]) {                                                                                  \
				ConvertRaw12CharTripcodeIntoDisplayFormat(rawTripcodeArray[wordIndex], tripcode);                                                           \
				ProcessPossibleMatch(tripcode, key);                                                                                                        \
			}                                                                                                                                               \
		} else if (searchMode == SEARCH_MODE_FORWARD_MATCHING || searchMode == SEARCH_MODE_BACKWARD_MATCHING) {                                             \
			BINARY_SEARCH_FOR_TRIPCODE_CHUNK(0)                                                                                                             \
		} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {                                                                               \
			BINARY_SEARCH_FOR_TRIPCODE_CHUNK(0)                                                                                                             \
			BINARY_SEARCH_FOR_TRIPCODE_CHUNK(1)                                                                                                             \
		} else {                                                                                                                                            \
			int maxPos = (searchMode == SEARCH_MODE_FLEXIBLE || searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING)                                    \
						        ? (lenTripcode - MIN_LEN_EXPANDED_PATTERN)                                                                                  \
						        : (0);                                                                                                                      \
			for (int pos = 0; pos <= maxPos; ++pos)                                                                                                         \
				BINARY_SEARCH_FOR_TRIPCODE_CHUNK(pos)                                                                                                       \
		}                                                                                                                                                   \
		                                                                                                                                                    \
		if (!found && searchForSpecialPatternsOnCPU) {                                                                                                      \
			ConvertRaw12CharTripcodeIntoDisplayFormat(rawTripcodeArray[wordIndex], tripcode);                                                               \
			if (   options.searchForKaibunOnCPU                                                                                                             \
				&& tripcode[0] == tripcode[11]                                                                                                              \
				&& tripcode[1] == tripcode[10]                                                                                                              \
				&& tripcode[2] == tripcode[ 9]                                                                                                              \
				&& tripcode[3] == tripcode[ 8]                                                                                                              \
				&& tripcode[4] == tripcode[ 7]                                                                                                              \
				&& tripcode[5] == tripcode[ 6] ) {                                                                                                          \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			} else if (   options.searchForKagamiOnCPU                                                                                                      \
						&& charTableForKagami[tripcode[0]] == tripcode[11]                                                                                  \
						&& charTableForKagami[tripcode[1]] == tripcode[10]                                                                                  \
						&& charTableForKagami[tripcode[2]] == tripcode[ 9]                                                                                  \
						&& charTableForKagami[tripcode[3]] == tripcode[ 8]                                                                                  \
						&& charTableForKagami[tripcode[4]] == tripcode[ 7]                                                                                  \
						&& charTableForKagami[tripcode[5]] == tripcode[ 6] ) {                                                                              \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			} else if (   options.searchForYamabikoOnCPU                                                                                                    \
						&& tripcode[0] == tripcode[ 6]                                                                                                      \
						&& tripcode[1] == tripcode[ 7]                                                                                                      \
						&& tripcode[2] == tripcode[ 8]                                                                                                      \
						&& tripcode[3] == tripcode[ 9]                                                                                                      \
						&& tripcode[4] == tripcode[10]                                                                                                      \
						&& tripcode[5] == tripcode[11] ) {                                                                                                  \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			} else if (   options.searchForSourenOnCPU                                                                                                      \
						&& tripcode[ 0] == tripcode[ 1]                                                                                                     \
						&& tripcode[ 2] == tripcode[ 3]                                                                                                     \
						&& tripcode[ 4] == tripcode[ 5]                                                                                                     \
						&& tripcode[ 6] == tripcode[ 7]                                                                                                     \
						&& tripcode[ 8] == tripcode[ 9]                                                                                                     \
						&& tripcode[10] == tripcode[11] ) {                                                                                                 \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			} else if (   options.searchForHisekiOnCPU                                                                                                      \
						&& tripcode[ 0] == '.'                                                                                                              \
						&& tripcode[ 2] == '.'                                                                                                              \
						&& tripcode[ 4] == '.'                                                                                                              \
						&& tripcode[ 6] == '.'                                                                                                              \
						&& tripcode[ 8] == '.'                                                                                                              \
						&& tripcode[10] == '.') {                                                                                                           \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			} else if (   options.searchForHisekiOnCPU                                                                                                      \
						&& tripcode[ 1] == '.'                                                                                                              \
						&& tripcode[ 3] == '.'                                                                                                              \
						&& tripcode[ 5] == '.'                                                                                                              \
						&& tripcode[ 7] == '.'                                                                                                              \
						&& tripcode[ 9] == '.'                                                                                                              \
						&& tripcode[11] == '.') {                                                                                                           \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			} else if (   options.searchForHisekiOnCPU                                                                                                      \
						&& tripcode[ 0] == '/'                                                                                                              \
						&& tripcode[ 2] == '/'                                                                                                              \
						&& tripcode[ 4] == '/'                                                                                                              \
						&& tripcode[ 6] == '/'                                                                                                              \
						&& tripcode[ 8] == '/'                                                                                                              \
						&& tripcode[10] == '/') {                                                                                                           \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			} else if (   options.searchForHisekiOnCPU                                                                                                      \
						&& tripcode[ 1] == '/'                                                                                                              \
						&& tripcode[ 3] == '/'                                                                                                              \
						&& tripcode[ 5] == '/'                                                                                                              \
						&& tripcode[ 7] == '/'                                                                                                              \
						&& tripcode[ 9] == '/'                                                                                                              \
						&& tripcode[11] == '/') {                                                                                                           \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			} else if (   options.searchForKakuhiOnCPU                                                                                                      \
						&& tripcode[ 2] == tripcode[0]                                                                                                      \
						&& tripcode[ 4] == tripcode[0]                                                                                                      \
						&& tripcode[ 6] == tripcode[0]                                                                                                      \
						&& tripcode[ 8] == tripcode[0]                                                                                                      \
						&& tripcode[10] == tripcode[0]) {                                                                                                   \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			} else if (   options.searchForKakuhiOnCPU                                                                                                      \
						&& tripcode[ 3] == tripcode[1]                                                                                                      \
						&& tripcode[ 5] == tripcode[1]                                                                                                      \
						&& tripcode[ 7] == tripcode[1]                                                                                                      \
						&& tripcode[ 9] == tripcode[1]                                                                                                      \
						&& tripcode[11] == tripcode[1]) {                                                                                                   \
				ProcessMatch(tripcode, key);                                                                                                                \
				found = TRUE;                                                                                                                               \
			}                                                                                                                                               \
		}                                                                                                                                                   \
	}                                                                                                                                                       \

#define BINARY_SEARCH_FOR_TRIPCODE_CHUNK(p)                                                                     \
	if (!found && !smallKeyBitmap[generatedTripcodeChunkArray[p] >> ((5 - SMALL_KEY_BITMAP_LEN_STRING) * 6)]) { \
		int lower = 0, upper = numTripcodeChunk - 1, middle = lower;                                            \
		while (lower <= upper) {                                                                                \
			middle = (lower + upper) >> 1;                                                                      \
			if (generatedTripcodeChunkArray[p] > tripcodeChunkArray[middle]) {                                  \
				lower = middle + 1;                                                                             \
			} else if (generatedTripcodeChunkArray[p] < tripcodeChunkArray[middle]) {                           \
				upper = middle - 1;                                                                             \
			} else {                                                                                            \
				ConvertRaw12CharTripcodeIntoDisplayFormat(rawTripcodeArray[wordIndex], tripcode);               \
				ProcessPossibleMatch(tripcode, key);                                                            \
				found = TRUE;                                                                                   \
				break;                                                                                          \
			}                                                                                                   \
		}                                                                                                       \
	}                                                                                                           \



#ifdef _M_X64
extern "C" void SHA1_GenerateTripcodesWithOptimization_x64_AVX         (void *W0, void *PW, void *W0Shifted, void *ABC);
extern "C" void SHA1_GenerateTripcodesWithOptimization_x64_SSE2        (void *W0, void *PW, void *W0Shifted, void *ABC);
extern "C" void SHA1_GenerateTripcodesWithOptimization_x64_SSE2_Nehalem(void *W0, void *PW, void *W0Shifted, void *ABC);
#else
extern "C" void SHA1_GenerateTripcodesWithOptimization_x86_AVX         (void *W0, void *PW, void *W0Shifted, void *ABC);
extern "C" void SHA1_GenerateTripcodesWithOptimization_x86_SSE2        (void *W0, void *PW, void *W0Shifted, void *ABC);
extern "C" void SHA1_GenerateTripcodesWithOptimization_x86_SSE2_Nehalem(void *W0, void *PW, void *W0Shifted, void *ABC);
#endif

BOOL IsCPUBasedOnNehalemMicroarchitecture()
{
	int results[4];
	int processorInfoArray[] = {
		// See: http://software.intel.com/en-us/articles/intel-architecture-and-processor-identification-with-cpuid-model-and-family-numbers
		0x20650,
		0x206c0,
		0x206f0,
		0x106e0,
		0x106a0,
		0x206e0,
		0
	};
	int mask = 0xfffffff0;
	
	__cpuid(results, 1);
	for (int i = 0; processorInfoArray[i]; ++i) {
		if ((results[0] & mask) == processorInfoArray[i])
			return TRUE;
	}

	return FALSE;
}

static unsigned int SearchForTripcodesWithOptimization()
{
	unsigned char  tripcode[MAX_LEN_TRIPCODE + 1], key[MAX_LEN_TRIPCODE_KEY + 1];
	unsigned int   generatedTripcodeChunkArray[MAX_LEN_TRIPCODE - MIN_LEN_EXPANDED_PATTERN + 1];
	unsigned int   numGeneratedTripcodes = 0;
	int            pos, maxPos = (searchMode == SEARCH_MODE_FLEXIBLE) ? (lenTripcode - MIN_LEN_EXPANDED_PATTERN) : (0);
	unsigned int   rawTripcodeArray[4][3];

#ifdef _M_X64
	void           (*SHA1_GenerateTripcodesWithOptimization)(void *, void *, void *, void *) = 
		(options.isAVXEnabled && IsAVXSupported()) ? SHA1_GenerateTripcodesWithOptimization_x64_AVX          :
		(IsCPUBasedOnNehalemMicroarchitecture()  ) ? SHA1_GenerateTripcodesWithOptimization_x64_SSE2_Nehalem :
		                                             SHA1_GenerateTripcodesWithOptimization_x64_SSE2;
#else
	void           (*SHA1_GenerateTripcodesWithOptimization)(void *, void *, void *, void *) = 
		(options.isAVXEnabled && IsAVXSupported()) ? SHA1_GenerateTripcodesWithOptimization_x86_AVX          :
		(IsCPUBasedOnNehalemMicroarchitecture()  ) ? SHA1_GenerateTripcodesWithOptimization_x86_SSE2_Nehalem :
		                                             SHA1_GenerateTripcodesWithOptimization_x86_SSE2;
#endif

	tripcode[lenTripcode]    = '\0';
	key     [lenTripcodeKey] = '\0';

	SetCharactersInTripcodeKeyForSHA1Tripcode(key);
	while (TRUE) {
		key[0] = ((key[0] & 0xfc) | 0x00); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
		key[0] = ((key[0] & 0xfc) | 0x01); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
		key[0] = ((key[0] & 0xfc) | 0x02); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
		key[0] = ((key[0] & 0xfc) | 0x03); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
		break;
	}

	__declspec(align(16)) __m128i PW[80], W0Shifted[23];
	PW[0]  = _mm_set1_epi32(0);
	PW[1]  = _mm_set1_epi32((key[4] << 24) | (key[5] << 16) | (key[ 6] << 8) | key[ 7]);
	PW[2]  = _mm_set1_epi32((key[8] << 24) | (key[9] << 16) | (key[10] << 8) | key[11]);
	PW[3]  = _mm_set1_epi32(0x80000000);
	PW[4]  = _mm_set1_epi32(0);
	PW[5]  = _mm_set1_epi32(0);
	PW[6]  = _mm_set1_epi32(0);
	PW[7]  = _mm_set1_epi32(0);
	PW[8]  = _mm_set1_epi32(0);
	PW[9]  = _mm_set1_epi32(0);
	PW[10] = _mm_set1_epi32(0);
	PW[11] = _mm_set1_epi32(0);
	PW[12] = _mm_set1_epi32(0);
	PW[13] = _mm_set1_epi32(0);
	PW[14] = _mm_set1_epi32(0);
	PW[15] = _mm_set1_epi32(12 * 8);
	PW[16] = ROTL(1, _mm_xor_si128(_mm_xor_si128(PW[16 - 3], PW[16 - 8]), PW[16 - 14]));
	for (int t = 17; t < 80; ++t)
		PW[t] = ROTL(1, _mm_xor_si128(_mm_xor_si128(_mm_xor_si128(PW[(t) - 3], PW[(t) - 8]), PW[(t) - 14]), PW[(t) - 16]));

	for (int indexKey1 = 0; indexKey1 <= CPU_SHA1_MAX_INDEX_FOR_KEYS; ++indexKey1) {
		key[1] = keyCharTable_SecondByteAndOneByte[indexKey1];

		for (int indexKey2 = 0; indexKey2 <= CPU_SHA1_MAX_INDEX_FOR_KEYS; ++indexKey2) {
			key[2] = keyCharTable_FirstByte[indexKey2];

			for (int indexKey3 = 0; indexKey3 <= CPU_SHA1_MAX_INDEX_FOR_KEYS; ++indexKey3) {
				key[3] = keyCharTable_SecondByteAndOneByte[indexKey3];
				
				__declspec(align(16)) __m128i W0, ABC[3];
				W0.m128i_u32[0] = (((key[0] & 0xfc) | 0x00) << 24) | (key[1] << 16) | (key[ 2] << 8) | key[ 3];
				W0.m128i_u32[1] = (((key[0] & 0xfc) | 0x01) << 24) | (key[1] << 16) | (key[ 2] << 8) | key[ 3];
				W0.m128i_u32[2] = (((key[0] & 0xfc) | 0x02) << 24) | (key[1] << 16) | (key[ 2] << 8) | key[ 3];
				W0.m128i_u32[3] = (((key[0] & 0xfc) | 0x03) << 24) | (key[1] << 16) | (key[ 2] << 8) | key[ 3];

				(*SHA1_GenerateTripcodesWithOptimization)(&W0, PW, W0Shifted, ABC);

				rawTripcodeArray[0][0] = ABC[0].m128i_u32[0];
				rawTripcodeArray[0][1] = ABC[1].m128i_u32[0];
				rawTripcodeArray[0][2] = ABC[2].m128i_u32[0];

				rawTripcodeArray[1][0] = ABC[0].m128i_u32[1];
				rawTripcodeArray[1][1] = ABC[1].m128i_u32[1];
				rawTripcodeArray[1][2] = ABC[2].m128i_u32[1];

				rawTripcodeArray[2][0] = ABC[0].m128i_u32[2];
				rawTripcodeArray[2][1] = ABC[1].m128i_u32[2];
				rawTripcodeArray[2][2] = ABC[2].m128i_u32[2];

				rawTripcodeArray[3][0] = ABC[0].m128i_u32[3];
				rawTripcodeArray[3][1] = ABC[1].m128i_u32[3];
				rawTripcodeArray[3][2] = ABC[2].m128i_u32[3];

				numGeneratedTripcodes += 4;
			
				LOOK_FOR_POSSIBLE_MATCH
			}
		}
	}

	return numGeneratedTripcodes;
}

#if FALSE

extern "C" void SHA1_GenerateTripcodes_x86_SSE2(void *W, void *rawTripcodeArray, void *ABC);
extern "C" void SHA1_GenerateTripcodes_x86_AVX (void *W, void *rawTripcodeArray, void *ABC);

static unsigned int SearchForTripcodesWithoutOptimization()
{
	unsigned char  tripcode[MAX_LEN_TRIPCODE + 1], key[MAX_LEN_TRIPCODE_KEY + 1];
	unsigned int   generatedTripcodeChunkArray[MAX_LEN_TRIPCODE - MIN_LEN_EXPANDED_PATTERN + 1];
	unsigned int   numGeneratedTripcodes = 0;
	int            pos, maxPos = (searchMode == SEARCH_MODE_FLEXIBLE) ? (lenTripcode - MIN_LEN_EXPANDED_PATTERN) : (0);
	unsigned int   rawTripcodeArray[4][3];
	__declspec(align(16)) __m128i W[80], ABC[3];
	
 	void           (*SHA1_GenerateTripcodes)(void *, void *, void *) = 
		(options.isAVXEnabled && IsAVXSupported())
#ifdef _M_X64
		    ? SHA1_GenerateTripcodes_x64_AVX : SHA1_GenerateTripcodes_x64_SSE2;
#else
		    ? SHA1_GenerateTripcodes_x86_AVX : SHA1_GenerateTripcodes_x86_SSE2;
#endif

	tripcode[lenTripcode]    = '\0';
	key     [lenTripcodeKey] = '\0';

	SetCharactersInTripcodeKeyForSHA1Tripcode(key);
	while (TRUE) {
		key[0] = ((key[0] & 0xfc) | 0x00); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
		key[0] = ((key[0] & 0xfc) | 0x01); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
		key[0] = ((key[0] & 0xfc) | 0x02); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
		key[0] = ((key[0] & 0xfc) | 0x03); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
		break;
	}

	W[1]  = _mm_set1_epi32((key[4] << 24) | (key[5] << 16) | (key[ 6] << 8) | key[ 7]);
	W[2]  = _mm_set1_epi32((key[8] << 24) | (key[9] << 16) | (key[10] << 8) | key[11]);
	W[3]  = _mm_set1_epi32(0x80000000);;
	W[4]  = _mm_set1_epi32(0);
	W[5]  = _mm_set1_epi32(0);
	W[6]  = _mm_set1_epi32(0);
	W[7]  = _mm_set1_epi32(0);
	W[8]  = _mm_set1_epi32(0);
	W[9]  = _mm_set1_epi32(0);
	W[10] = _mm_set1_epi32(0);
	W[11] = _mm_set1_epi32(0);
	W[12] = _mm_set1_epi32(0);
	W[13] = _mm_set1_epi32(0);
	W[14] = _mm_set1_epi32(0);
	W[15] = _mm_set1_epi32(12 * 8);

	for (int indexKey1 = 0; indexKey1 <= CPU_SHA1_MAX_INDEX_FOR_KEYS; ++indexKey1) {
		key[1] = keyCharTable_SecondByteAndOneByte[indexKey1];

		for (int indexKey2 = 0; indexKey2 <= CPU_SHA1_MAX_INDEX_FOR_KEYS; ++indexKey2) {
			key[2] = keyCharTable_FirstByte[indexKey2];

			for (int indexKey3 = 0; indexKey3 <= CPU_SHA1_MAX_INDEX_FOR_KEYS; ++indexKey3) {
				key[3] = keyCharTable_SecondByteAndOneByte[indexKey3];
				
				W[0].m128i_u32[0] = (((key[0] & 0xfc) | 0x00) << 24) | (key[1] << 16) | (key[ 2] << 8) | key[ 3];
				W[0].m128i_u32[1] = (((key[0] & 0xfc) | 0x01) << 24) | (key[1] << 16) | (key[ 2] << 8) | key[ 3];
				W[0].m128i_u32[2] = (((key[0] & 0xfc) | 0x02) << 24) | (key[1] << 16) | (key[ 2] << 8) | key[ 3];
				W[0].m128i_u32[3] = (((key[0] & 0xfc) | 0x03) << 24) | (key[1] << 16) | (key[ 2] << 8) | key[ 3];

				(*SHA1_GenerateTripcodes)(W, rawTripcodeArray, ABC);

				rawTripcodeArray[0][0] = ABC[0].m128i_u32[0];
				rawTripcodeArray[0][1] = ABC[1].m128i_u32[0];
				rawTripcodeArray[0][2] = ABC[2].m128i_u32[0];

				rawTripcodeArray[1][0] = ABC[0].m128i_u32[1];
				rawTripcodeArray[1][1] = ABC[1].m128i_u32[1];
				rawTripcodeArray[1][2] = ABC[2].m128i_u32[1];

				rawTripcodeArray[2][0] = ABC[0].m128i_u32[2];
				rawTripcodeArray[2][1] = ABC[1].m128i_u32[2];
				rawTripcodeArray[2][2] = ABC[2].m128i_u32[2];

				rawTripcodeArray[3][0] = ABC[0].m128i_u32[3];
				rawTripcodeArray[3][1] = ABC[1].m128i_u32[3];
				rawTripcodeArray[3][2] = ABC[2].m128i_u32[3];

				numGeneratedTripcodes += 4;
			
				LOOK_FOR_POSSIBLE_MATCH
			}
		}
	}

	return numGeneratedTripcodes;
}

#endif

unsigned WINAPI Thread_SearchForSHA1TripcodesOnCPU(LPVOID threadParams)
{
	BOOL useSSE2Intrinsics = IsCPUBasedOnNehalemMicroarchitecture();

	while (!GetTerminationState()) {
		while (GetPauseState() && !GetTerminationState())
			Sleep(PAUSE_INTERVAL);

		unsigned int numGeneratedTripcodes = SearchForTripcodesWithOptimization();
		AddToNumGeneratedTripcodesByCPU(numGeneratedTripcodes);
	}
	return 0;
}
