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



// The following is a heavy rewrite of DeepLearningJohnDoe's awesome Bitslice DES implementation
// for the NVIDIA Maxwell architecture. See:
// https://devtalk.nvidia.com/default/topic/860120/cuda-programming-and-performance/bitslice-des-optimization/4/
// https://github.com/DeepLearningJohnDoe/merikens-tripcode-engine/tree/PRV



// #define DEBUG_SALT_0

// 790.0M t/s (10000 chunks, DEBUG_SALT_0, 25m)
// 795.8M t/s (10000 chunks, JD, 8m)


///////////////////////////////////////////////////////////////////////////////
// INCLUDE FILE(S)                                                           //
///////////////////////////////////////////////////////////////////////////////

#include "MerikensTripcodeEngine.h"
#include "CUDA10_Registers_Kernel_Common.h"
#ifdef DEBUG_SALT_0
#define SALT 0
#endif
#include "CUDA10_Registers_Kernel.h"



///////////////////////////////////////////////////////////////////////////////
// CUDA SEARCH THREAD FOR 10 CHARACTER TRIPCODES                             //
///////////////////////////////////////////////////////////////////////////////

#ifdef CUDA_DES_ENABLE_MULTIPLE_KERNELS_MODE

#define CUDA_DES_DECLARE_KERNEL_LAUNCHER(n) \
	extern void CUDA_DES_InitializeKernelLauncher##n();\
	extern void CUDA_DES_LaunchKernel##n(\
		unsigned int numBlocksPerGrid,\
		cudaDeviceProp CUDADeviceProperties,\
		cudaStream_t currentStream,\
		unsigned char *cudaPassCountArray,\
		unsigned char *cudaTripcodeIndexArray,\
		unsigned int *cudaTripcodeChunkArray,\
		unsigned int numTripcodeChunk,\
		int intSalt,\
		unsigned char *cudaKey0Array,\
		unsigned char *cudaKey7Array,\
		DES_Vector *cudaKeyVectorsFrom49To55,\
		unsigned char *cudaKeyAndRandomBytes,\
		int searchMode)\

#define CUDA_DES_CALL_KERNEL_LAUNCHER(n) \
	CUDA_DES_LaunchKernel##n(\
		numBlocksPerGrid,\
		CUDADeviceProperties,\
		currentStream,\
		cudaPassCountArray,\
		cudaTripcodeIndexArray,\
		cudaTripcodeChunkArray,\
		numTripcodeChunk,\
		intSalt,\
		cudaKey0Array,\
		cudaKey7Array,\
		cudaKeyVectorsFrom49To55,\
		cudaKeyAndRandomBytes,\
		searchMode)\

CUDA_DES_DECLARE_KERNEL_LAUNCHER(0);
CUDA_DES_DECLARE_KERNEL_LAUNCHER(1);
CUDA_DES_DECLARE_KERNEL_LAUNCHER(2);
CUDA_DES_DECLARE_KERNEL_LAUNCHER(3);
CUDA_DES_DECLARE_KERNEL_LAUNCHER(4);
CUDA_DES_DECLARE_KERNEL_LAUNCHER(5);
CUDA_DES_DECLARE_KERNEL_LAUNCHER(6);
CUDA_DES_DECLARE_KERNEL_LAUNCHER(7);

#endif



#define SET_BIT_FOR_KEY7(var, k) if (key7 & (0x1 << (k))) (var) |= 0x1 << tripcodeIndex

unsigned WINAPI Thread_SearchForDESTripcodesOnCUDADevice_Registers(LPVOID info)
{
	cudaDeviceProp  CUDADeviceProperties;
	unsigned int    numBlocksPerSM;
	unsigned int    numBlocksPerGrid;
	unsigned char  *passCountArray = NULL;
	unsigned char  *cudaPassCountArray = NULL;
	unsigned char  *tripcodeIndexArray = NULL;
	unsigned char  *cudaTripcodeIndexArray = NULL;
	unsigned int   *cudaTripcodeChunkArray = NULL;
	unsigned char  *cudaKey0Array = NULL;
	unsigned char  *cudaKey7Array = NULL;
	unsigned char  *cudaKeyAndRandomBytes = NULL;
	DES_Vector     *cudaKeyVectorsFrom49To55;
	unsigned char   key0Array[CUDA_DES_MAX_PASS_COUNT];
	unsigned char   key7Array[CUDA_DES_BS_DEPTH * 2];
	unsigned char   keyAndRandomBytes[MAX_LEN_TRIPCODE + 1];

	unsigned char  *prevPassCountArray = NULL;
	unsigned char  *cudaPrevPassCountArray = NULL;
	unsigned char  *prevTripcodeIndexArray = NULL;
	unsigned char  *cudaPrevTripcodeIndexArray = NULL;
	unsigned char   prevKey0Array[CUDA_DES_MAX_PASS_COUNT];
	unsigned char   prevKey7Array[CUDA_DES_BS_DEPTH * 2];
	unsigned char   prevKeyAndRandomBytes[MAX_LEN_TRIPCODE + 1];

	unsigned int    numThreadsPerGrid;
	unsigned char   salt[3];
	char            status[LEN_LINE_BUFFER_FOR_SCREEN] = "";
	double          timeElapsed = 0;
	double          numGeneratedTripcodes = 0;
	double          speed = 0;
	DWORD           startingTime;
	DWORD           endingTime;
	double          deltaTime;
	int             salt0NonDotCounter = 0;
	int             salt1NonDotCounter = 0;

	keyAndRandomBytes[lenTripcode] = '\0';
	salt[2] = '\0';
	
	CUDA_ERROR(cudaSetDevice(((CUDADeviceSearchThreadInfo *)info)->CUDADeviceIndex));
	CUDA_ERROR(cudaGetDeviceProperties(&CUDADeviceProperties, ((CUDADeviceSearchThreadInfo *)info)->CUDADeviceIndex));
	if (CUDADeviceProperties.computeMode == cudaComputeModeProhibited) {
		sprintf(status, "[disabled]");
		UpdateCUDADeviceStatus(((CUDADeviceSearchThreadInfo *)info), status);
		return 0;
	}

	numBlocksPerSM = options.CUDANumBlocksPerSM;
	numBlocksPerGrid = numBlocksPerSM * CUDADeviceProperties.multiProcessorCount;
	numThreadsPerGrid = CUDA_DES_NUM_THREADS_PER_BLOCK * numBlocksPerGrid;

	CUDA_ERROR(cudaMalloc((void **)&cudaTripcodeChunkArray,   sizeof(unsigned int) * numTripcodeChunk)); 
	CUDA_ERROR(cudaMalloc((void **)&cudaKey0Array,            sizeof(unsigned char) * CUDA_DES_MAX_PASS_COUNT)); 
	CUDA_ERROR(cudaMalloc((void **)&cudaKey7Array,            sizeof(unsigned char) * CUDA_DES_BS_DEPTH * 2)); 
	CUDA_ERROR(cudaMalloc((void **)&cudaKeyVectorsFrom49To55, sizeof(DES_Vector) * 7 * 2)); 
	CUDA_ERROR(cudaMalloc((void **)&cudaKeyAndRandomBytes,    sizeof(unsigned char) * 8)); 
	
	EnterCriticalSection(&((CUDADeviceSearchThreadInfo *)info)->criticalSection);
#ifdef CUDA_DES_ENABLE_MULTIPLE_KERNELS_MODE
	CUDA_DES_InitializeKernelLauncher0();
	CUDA_DES_InitializeKernelLauncher1();
	CUDA_DES_InitializeKernelLauncher2();
	CUDA_DES_InitializeKernelLauncher3();
	CUDA_DES_InitializeKernelLauncher4();
	CUDA_DES_InitializeKernelLauncher5();
	CUDA_DES_InitializeKernelLauncher6();
	CUDA_DES_InitializeKernelLauncher7();
#endif
	CUDA_ERROR(cudaMemcpy(cudaTripcodeChunkArray, tripcodeChunkArray, sizeof(unsigned int) * numTripcodeChunk, cudaMemcpyHostToDevice));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_FirstByte,  keyCharTable_FirstByte,  SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_SecondByte, keyCharTable_SecondByte, SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaChunkBitmap,               chunkBitmap,               CHUNK_BITMAP_SIZE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaCompactMediumChunkBitmap,  compactMediumChunkBitmap,  COMPACT_MEDIUM_CHUNK_BITMAP_SIZE));
	LeaveCriticalSection(&((CUDADeviceSearchThreadInfo *)info)->criticalSection);
		
	startingTime = timeGetTime();

	cudaStream_t currentStream;
	CUDA_ERROR(cudaStreamCreate(&currentStream));
	BOOL prevDataExists = FALSE;
	passCountArray         = (unsigned char *)malloc(sizeof(unsigned char) * numThreadsPerGrid); ERROR0(passCountArray         == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	tripcodeIndexArray     = (unsigned char *)malloc(sizeof(unsigned char) * numThreadsPerGrid); ERROR0(tripcodeIndexArray     == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	prevPassCountArray     = (unsigned char *)malloc(sizeof(unsigned char) * numThreadsPerGrid); ERROR0(prevPassCountArray     == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	prevTripcodeIndexArray = (unsigned char *)malloc(sizeof(unsigned char) * numThreadsPerGrid); ERROR0(prevTripcodeIndexArray == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	CUDA_ERROR(cudaMalloc((void **)&cudaPassCountArray,           sizeof(unsigned char) * numThreadsPerGrid));
	CUDA_ERROR(cudaMalloc((void **)&cudaTripcodeIndexArray,       sizeof(unsigned char) * numThreadsPerGrid));
	CUDA_ERROR(cudaMalloc((void **)&cudaPrevPassCountArray,       sizeof(unsigned char) * numThreadsPerGrid));
	CUDA_ERROR(cudaMalloc((void **)&cudaPrevTripcodeIndexArray,   sizeof(unsigned char) * numThreadsPerGrid));
	while (!GetTerminationState()) {
		// Choose the first 3 characters of the keyAndRandomBytes.
		int intSalt;
		for (int i = 3; i < lenTripcode; ++i)
			keyAndRandomBytes[i] = 'A';
		do {
			SetCharactersInTripcodeKey(keyAndRandomBytes, 3);
			salt[0] = CONVERT_CHAR_FOR_SALT(keyAndRandomBytes[1]);
			salt[1] = CONVERT_CHAR_FOR_SALT(keyAndRandomBytes[2]);
			intSalt = charToIndexTableForDES[salt[0]] | (charToIndexTableForDES[salt[1]] << 6);
		} while (
#ifdef DEBUG_SALT_0
                    intSalt
#else
			        (salt[0] == '.' && salt0NonDotCounter < 64)
				 || (salt[1] == '.' && salt1NonDotCounter < 64)
#endif
				 || !IsValidKey(keyAndRandomBytes));
		if (salt[0] == '.') {
			salt0NonDotCounter -= 63;
		} else {
			++salt0NonDotCounter;
		}
		if (salt[1] == '.') {
			salt1NonDotCounter -= 63;
		} else {
			++salt1NonDotCounter;
		}
		// printf("intSalt: %d\n", intSalt);

		//
		unsigned char randomByteForKey0 = RandomByte();
		int j = 0;
		for (int i = 0; i < CUDA_DES_MAX_PASS_COUNT; ++i) {
			do {
				keyAndRandomBytes[0] = keyCharTable_FirstByte[randomByteForKey0 + j++];
			} while(!IsValidKey(keyAndRandomBytes));
			key0Array[i] = keyAndRandomBytes[0];
		}
		
		// Generate random bytes for the key to ensure its randomness.
		for (int i = 3; i < lenTripcode; ++i)
			keyAndRandomBytes[i] = RandomByte();

		//
		DES_Vector  keyVectorsFrom49To55[7 * 2] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
		for (int tripcodeIndex = 0; tripcodeIndex < CUDA_DES_BS_DEPTH; ++tripcodeIndex) {
			unsigned char key7 = key7Array[tripcodeIndex] = keyCharTable_FirstByte[keyAndRandomBytes[7] + tripcodeIndex];
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[0], 0);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[1], 1);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[2], 2);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[3], 3);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[4], 4);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[5], 5);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[6], 6);
			key7 = key7Array[tripcodeIndex + CUDA_DES_BS_DEPTH] = keyCharTable_SecondByte[keyAndRandomBytes[7] + tripcodeIndex];
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[0 + 7], 0);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[1 + 7], 1);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[2 + 7], 2);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[3 + 7], 3);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[4 + 7], 4);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[5 + 7], 5);
			SET_BIT_FOR_KEY7(keyVectorsFrom49To55[6 + 7], 6);
		}

		// Call an appropriate CUDA kernel.
		CUDA_ERROR(cudaMemcpyAsync(cudaKey0Array, key0Array, sizeof(key0Array), cudaMemcpyHostToDevice, currentStream));
		CUDA_ERROR(cudaMemcpyAsync(cudaKey7Array, key7Array, sizeof(key7Array), cudaMemcpyHostToDevice, currentStream));
		CUDA_ERROR(cudaMemcpyAsync(cudaKeyVectorsFrom49To55, keyVectorsFrom49To55, sizeof(keyVectorsFrom49To55), cudaMemcpyHostToDevice, currentStream))
		CUDA_ERROR(cudaMemcpyAsync(cudaKeyAndRandomBytes, keyAndRandomBytes, 8, cudaMemcpyHostToDevice, currentStream));
#ifdef CUDA_DES_ENABLE_MULTIPLE_KERNELS_MODE
		if (CUDADeviceProperties.major >= 5) {
			switch (intSalt / 512) {
			case 0: CUDA_DES_CALL_KERNEL_LAUNCHER(0); break;
			case 1: CUDA_DES_CALL_KERNEL_LAUNCHER(1); break;
			case 2: CUDA_DES_CALL_KERNEL_LAUNCHER(2); break;
			case 3: CUDA_DES_CALL_KERNEL_LAUNCHER(3); break;
			case 4: CUDA_DES_CALL_KERNEL_LAUNCHER(4); break;
			case 5: CUDA_DES_CALL_KERNEL_LAUNCHER(5); break;
			case 6: CUDA_DES_CALL_KERNEL_LAUNCHER(6); break;
			case 7: CUDA_DES_CALL_KERNEL_LAUNCHER(7); break;
			default: continue;
			}
		} else
#endif
		{
			dim3 dimGrid(numBlocksPerGrid);
			dim3 dimBlock(CUDA_DES_NUM_THREADS_PER_BLOCK);
#ifdef DEBUG_SALT_0
			CUDA_DES_PerformSearch_0<<<dimGrid, dimBlock, 0, currentStream>>>(
#else
			CUDA_DES_PerformSearch<<<dimGrid, dimBlock, 0, currentStream>>>(
#endif	
				cudaPassCountArray,
				cudaTripcodeIndexArray,
				cudaTripcodeChunkArray,
				numTripcodeChunk,
				intSalt,
				cudaKey0Array,
				cudaKey7Array,
				cudaKeyVectorsFrom49To55,
				cudaKeyAndRandomBytes,
				searchMode);
		}
		CUDA_ERROR(cudaGetLastError());
		CUDA_ERROR(cudaMemcpyAsync(passCountArray,     cudaPassCountArray,     sizeof(unsigned char) * numThreadsPerGrid, cudaMemcpyDeviceToHost, currentStream));
		CUDA_ERROR(cudaMemcpyAsync(tripcodeIndexArray, cudaTripcodeIndexArray, sizeof(unsigned char) * numThreadsPerGrid, cudaMemcpyDeviceToHost, currentStream));

		// Process the output.
		TripcodeKeyPair tripcodes[32];
		int numTripcodes = 0;
		if (prevDataExists) {
			for (int i = 0; i < numThreadsPerGrid; i++){
				if (prevPassCountArray[i] < CUDA_DES_MAX_PASS_COUNT) {
					unsigned char key[MAX_LEN_TRIPCODE_KEY + 1];
					key[0] = prevKey0Array[prevPassCountArray[i]];
					key[1] = prevKeyAndRandomBytes[1];
					key[2] = prevKeyAndRandomBytes[2];
	
					BOOL isSecondByte =    ( IS_FIRST_BYTE_SJIS_FULL(prevKey0Array[0])                                                       && IS_FIRST_BYTE_SJIS_FULL(prevKeyAndRandomBytes[2]))
										|| (!IS_FIRST_BYTE_SJIS_FULL(prevKey0Array[0]) && !IS_FIRST_BYTE_SJIS_FULL(prevKeyAndRandomBytes[1]) && IS_FIRST_BYTE_SJIS_FULL(prevKeyAndRandomBytes[2]));
					int threadIndex = i % CUDA_DES_NUM_THREADS_PER_BLOCK;
					int blockIndex  = i / CUDA_DES_NUM_THREADS_PER_BLOCK;
					SET_KEY_CHAR(key[3], isSecondByte, keyCharTable_FirstByte, prevKeyAndRandomBytes[3] + (((threadIndex >> 6) &  7) | (((blockIndex  >> 12) & 7) << 3)));
					SET_KEY_CHAR(key[4], isSecondByte, keyCharTable_FirstByte, prevKeyAndRandomBytes[4] + ( (blockIndex  >> 6) & 63));
					SET_KEY_CHAR(key[5], isSecondByte, keyCharTable_FirstByte, prevKeyAndRandomBytes[5] + (  blockIndex        & 63));
					SET_KEY_CHAR(key[6], isSecondByte, keyCharTable_FirstByte, prevKeyAndRandomBytes[6] + (  threadIndex       & 63));
					key[7] = prevKey7Array[prevTripcodeIndexArray[i] + (isSecondByte ? CUDA_DES_BS_DEPTH : 0)];
					CreateKey8AndKey9(key);
					key[10] = '\0';
					strcpy((char *)tripcodes[numTripcodes].key.c, (char *)key);
					++numTripcodes;
				}
				if (numTripcodes > 0 && (numTripcodes >= sizeof(tripcodes) / sizeof(TripcodeKeyPair) || i >= numThreadsPerGrid - 1)) {
					Generate10CharTripcodes(tripcodes, numTripcodes);
					for (int j = 0; j < numTripcodes; j++){
						ERROR0(!IsTripcodeChunkValid(tripcodes[j].tripcode.c), ERROR_TRIPCODE_VERIFICATION_FAILED, "A generated tripcode was corrupt.");
						ProcessPossibleMatch(tripcodes[j].tripcode.c, tripcodes[j].key.c);
					}
					numTripcodes = 0;
				}
			}
		}
		CUDA_ERROR(cudaStreamSynchronize(currentStream));
		unsigned int numGeneratedTripcodesThisTime = 0;
		for (int i = 0; i < numThreadsPerGrid; i++)
			numGeneratedTripcodesThisTime += CUDA_DES_BS_DEPTH * passCountArray[i];
		AddToNumGeneratedTripcodesByGPU(numGeneratedTripcodesThisTime);
		numGeneratedTripcodes += numGeneratedTripcodesThisTime;
#undef  SWAP
#define SWAP(t, a, b) { t temp; temp = (a); (a) = (b); (b) = temp; }
		SWAP(unsigned char *, passCountArray, prevPassCountArray);
		SWAP(unsigned char *, tripcodeIndexArray, prevTripcodeIndexArray);
		SWAP(unsigned char *, cudaPassCountArray, cudaPrevPassCountArray);
		SWAP(unsigned char *, cudaTripcodeIndexArray, cudaPrevTripcodeIndexArray);
		memcpy(prevKey0Array, key0Array, sizeof(key0Array));
		memcpy(prevKey7Array, key7Array, sizeof(key7Array));
		memcpy(prevKeyAndRandomBytes, keyAndRandomBytes, sizeof(keyAndRandomBytes));
		prevDataExists = TRUE;

		//
		endingTime = timeGetTime();
		deltaTime = (endingTime >= startingTime)
						? ((double)endingTime - (double)startingTime                     ) * 0.001
						: ((double)endingTime - (double)startingTime + (double)0xffffffff) * 0.001;
		while (GetPauseState() && !GetTerminationState())
			Sleep(PAUSE_INTERVAL);
		startingTime = timeGetTime();
		timeElapsed += deltaTime;
		speed = numGeneratedTripcodes / timeElapsed;
		sprintf(status,
			    "%.1lfM TPS, %d blocks/SM",
				speed / 1000000,
				numBlocksPerSM);
		UpdateCUDADeviceStatus(((CUDADeviceSearchThreadInfo *)info), status);
	}

	RELEASE_AND_SET_TO_NULL(passCountArray,               free);
	RELEASE_AND_SET_TO_NULL(tripcodeIndexArray,           free);
	RELEASE_AND_SET_TO_NULL(cudaPassCountArray,           cudaFree);
	RELEASE_AND_SET_TO_NULL(cudaTripcodeIndexArray,       cudaFree);
	RELEASE_AND_SET_TO_NULL(prevPassCountArray,           free);
	RELEASE_AND_SET_TO_NULL(prevTripcodeIndexArray,       free);
	RELEASE_AND_SET_TO_NULL(cudaPrevPassCountArray,       cudaFree);
	RELEASE_AND_SET_TO_NULL(cudaPrevTripcodeIndexArray,   cudaFree);
	RELEASE_AND_SET_TO_NULL(cudaTripcodeChunkArray,   cudaFree);
	RELEASE_AND_SET_TO_NULL(cudaKey0Array,            cudaFree);
	RELEASE_AND_SET_TO_NULL(cudaKey7Array,            cudaFree);
	RELEASE_AND_SET_TO_NULL(cudaKeyVectorsFrom49To55, cudaFree);
	RELEASE_AND_SET_TO_NULL(cudaKeyAndRandomBytes,    cudaFree);
	CUDA_ERROR(cudaStreamDestroy(currentStream));

	return 0;
}