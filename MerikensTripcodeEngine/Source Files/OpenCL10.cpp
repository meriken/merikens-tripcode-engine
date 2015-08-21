// Meriken's Tripcode Engine 2.0.1
// Copyright (c) 2011-2015 Meriken.Z. <meriken.2ch@gmail.com>
//
// The initial versions of this software were based on:
// CUDA DES Tripper 0.2.1
// Copyright (c) 2009 Horo/.IBXjcg
// 
// The code that deals with DES decryption is partially adopted from:
// John the Ripper password cracker
// Copyright (c) 1996-2002, 2005, 2010 by Solar Designer
// DeepLearningJohnDoe's fork of Meriken's Tripcode Engine
// Copyright (c) 2015 by <deeplearningjohndoe at gmail.com>
//
// The code that deals with DES hash generation is partially adopted from:
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



// TO DO: Make sure to test the following routines with HD 7970!



///////////////////////////////////////////////////////////////////////////////
// INCLUDE FILE(S)                                                           //
///////////////////////////////////////////////////////////////////////////////

#include "MerikensTripcodeEngine.h"



///////////////////////////////////////////////////////////////////////////////
// OPENCL SEARCH THREAD FOR 10 CHARACTER TRIPCODES                           //
///////////////////////////////////////////////////////////////////////////////

// #define DEBUG_KEEP_TEMPORARY_FILES_FOR_OPENCL

typedef struct KeyInfo {
	unsigned char partialKeyAndRandomBytes[10];
	unsigned char expansioinFunction[DES_SIZE_EXPANSION_FUNCTION];
} KeyInfo;

typedef struct PartialKeyFrom3To6 {
	unsigned char partialKeyFrom3To6[4];
} PartialKeyFrom3To6;

#define SET_KEY_CHAR(var, flag, table, value)   \
	if (!(flag)) {                              \
		var = (table)[(value)];                 \
		isSecondByte = IsFirstByteSJIS(var);    \
	} else {                                    \
		var = keyCharTable_SecondByte[(value)];     \
		isSecondByte = FALSE;                   \
	}                                           \

static void CreateProgram(cl_context *context, cl_program *program, cl_device_id *deviceID, char *sourceFileName, char *buildOptions, char keyChar1, char keyChar2, unsigned char *expansionFunction)
{
	cl_int         openCLError;

	// Create an expansion function based on the salt.
	unsigned char  salt[2];
	salt[0] = CONVERT_CHAR_FOR_SALT(keyChar1);
	salt[1] = CONVERT_CHAR_FOR_SALT(keyChar2);
	DES_CreateExpansionFunction((char *)salt, expansionFunction);

	/*
	char    binaryFilePath[MAX_LEN_FILE_PATH + 1];
	FILE   *binaryFile;
	sprintf(binaryFilePath, "%s\\OpenCL\\bin\\%02x%02x.bin", applicationDirectory, salt[0], salt[1]);
	if (binaryFile = fopen(binaryFilePath, "rb")) {
		fseek(binaryFile, 0L, SEEK_END);
		size_t binarySize = ftell(binaryFile);
		unsigned char *binary = (unsigned char *)malloc(binarySize);
		const unsigned char *binaryArray[1] = {binary};
		ERROR0(binary == NULL, ERROR_NO_MEMORY, "Not enough memory.");
		fseek(binaryFile, 0L, SEEK_SET);
		fread(binary, sizeof(unsigned char), binarySize, binaryFile);
		fclose(binaryFile);

		*program = clCreateProgramWithBinary(*context, 1, deviceID, &binarySize, binaryArray, NULL, &openCLError);
		OPENCL_ERROR(openCLError);
		openCLError = clBuildProgram(*program, 1, deviceID, buildOptions, NULL, NULL);
		OPENCL_ERROR(openCLError);
		
		free(binary);
		return;
	}
	*/

	// Load an OpenCL source code
	char    sourceFilePath[MAX_LEN_FILE_PATH + 1];
	FILE   *sourceFile;
	char   *sourceCode;
	size_t  sizeSourceCode;
	strcpy(sourceFilePath, applicationDirectory);
	strcat(sourceFilePath, "\\");
	strcat(sourceFilePath, sourceFileName);
	sourceFile = fopen(sourceFilePath, "r");
	ERROR0(!sourceFile, ERROR_OPENCL, "Failed to load an OpenCL source file.");
	sourceCode = (char*)malloc(OPENCL_MAX_SIZE_SOURCE_CODE);
	ERROR0(sourceCode == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	sourceCode[0] = '\0';
	for (int i = 0; i < 7; ++i) {
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
		if (keyChar1 & (1 << i)) {
			sprintf(s, "#define K%02d 0xfffffffUL\n#define K%02dXOR(dest, val) (dest) = ~(val)\n", i + 7, i + 7);
		} else {
			sprintf(s, "#define K%02d 0x0000000UL\n#define K%02dXOR(dest, val) (dest) = (val)\n", i + 7, i + 7);
		}
		strcat(sourceCode, s);
	}
	for (int i = 0; i < 7; ++i) {
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
		if (keyChar2 & (1 << i)) {
			sprintf(s, "#define K%02d 0xffffffffU\n#define K%02dXOR(dest, val) (dest) = ~(val)\n", i + 14, i + 14);
		} else {
			sprintf(s, "#define K%02d 0x00000000U\n#define K%02dXOR(dest, val) (dest) = (val)\n", i + 14, i + 14);
		}
		strcat(sourceCode, s);
	}
	for (int i = 0; i < DES_SIZE_EXPANSION_FUNCTION; ++i) {
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
		sprintf(s, "#define EF%02d %d\n", i, (int)expansionFunction[i]);
		strcat(sourceCode, s);
	}
	unsigned char key7Array[OPENCL_DES_BS_DEPTH];
	int randomByteForKey7 = RandomByte();
	strcat(sourceCode, "__constant unsigned char key7Array[] = {");
	for (int i = 0; i < OPENCL_DES_BS_DEPTH; ++i) {
		key7Array[i] = keyCharTable_SecondByteAndOneByte[randomByteForKey7 + i];
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; 
		sprintf(s, "0x%02x,", key7Array[i]);
		strcat(sourceCode, s);
	}
	strcat(sourceCode, "};\n");
	for (int j = 0; j < 7; ++j) {
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
		unsigned int k = 0;
		for (int i = 0; i < OPENCL_DES_BS_DEPTH; ++i)
			k |= ((key7Array[i] >> j) & 0x1) << i;
		sprintf(s, "#define K%02d 0x%08x\n#define K%02dXOR(dest, val) (dest) = ((val) ^ 0x%08x)\n", j + 49, k, j + 49, k);
		strcat(sourceCode, s);
	}
	sizeSourceCode =  strlen(sourceCode);
	sizeSourceCode += fread(sourceCode + strlen(sourceCode), 1, OPENCL_MAX_SIZE_SOURCE_CODE - strlen(sourceCode), sourceFile);
	fclose(sourceFile);
	// printf("sourceCode: %d/%d bytes\n", strlen(sourceCode), OPENCL_MAX_SIZE_SOURCE_CODE);

	//
	*program = clCreateProgramWithSource(*context, 1, (const char **)&sourceCode, (const size_t *)&sizeSourceCode, &openCLError);
	free(sourceCode);
	openCLError = clBuildProgram(*program, 1, deviceID, buildOptions, NULL, NULL);
	if (openCLError != CL_SUCCESS && !options.redirection) {
		size_t lenBuildLog= 0;
		clGetProgramBuildInfo(*program, *deviceID, CL_PROGRAM_BUILD_LOG, 0, NULL, &lenBuildLog);
		char *buildLog = (char *)malloc(lenBuildLog + 1);
		ERROR0(buildLog == NULL, ERROR_NO_MEMORY, "Not enough memory.");
		clGetProgramBuildInfo(*program, *deviceID, CL_PROGRAM_BUILD_LOG, lenBuildLog, buildLog, &lenBuildLog);
		buildLog[lenBuildLog] = '\0';
		fprintf(stderr, "%s\n", buildLog);
		free(buildLog);
	}
	OPENCL_ERROR(openCLError);

	/*
	//
	size_t numDevices;
	openCLError = clGetProgramInfo(*program, CL_PROGRAM_NUM_DEVICES, sizeof(size_t), &numDevices, NULL);
	OPENCL_ERROR(openCLError);
	size_t *binarySizeArray = (size_t *)malloc(sizeof(size_t) * numDevices);
	ERROR0(binarySizeArray == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	openCLError = clGetProgramInfo(*program, CL_PROGRAM_BINARY_SIZES, sizeof(size_t) * numDevices, binarySizeArray, NULL);
	OPENCL_ERROR(openCLError);
	unsigned char **binaryArray = (unsigned char **)malloc(sizeof(unsigned char *) * numDevices);
	ERROR0(binaryArray == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	for(int i = 0; i < numDevices; ++i) {
		binaryArray[i] = (unsigned char *)malloc(binarySizeArray[i]);
		ERROR0(binaryArray[i] == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	}
	openCLError = clGetProgramInfo(*program, CL_PROGRAM_BINARIES, sizeof(unsigned char *) * numDevices, binaryArray, NULL);
	OPENCL_ERROR(openCLError);

	//
	if (binaryFile = fopen(binaryFilePath, "wb")) {
		fwrite(binaryArray[0], sizeof(unsigned char), binarySizeArray[0], binaryFile);
		fclose(binaryFile);
	}
	free(binarySizeArray);
	for(int i = 0; i < numDevices; ++i)
		free(binaryArray[i]);
	free(binaryArray);
	*/
}

unsigned WINAPI Thread_SearchForDESTripcodesOnOpenCLDevice(LPVOID info)
{
	cl_context       context;
	cl_command_queue commandQueue;
	cl_program       program;
	cl_kernel        kernel;
	cl_mem openCL_outputArray;
	cl_mem openCL_keyInfo;
	cl_mem openCL_tripcodeChunkArray;
	cl_mem openCL_smallChunkBitmap;
	cl_mem openCL_compactMediumChunkBitmap;
	cl_mem openCL_chunkBitmap;
	cl_mem openCL_partialKeyFrom3To6Array;
	cl_int         openCLError;
	cl_device_id   deviceID = ((OpenCLDeviceSearchThreadInfo *)info)->openCLDeviceID;
	cl_uint        numComputeUnits;
	char           status[LEN_LINE_BUFFER_FOR_SCREEN] = {'\0'};
	char           buildOptions[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1] = {'\0'}; 
	KeyInfo        keyInfo;
	unsigned char  expansionFunction[96];

	if (((OpenCLDeviceSearchThreadInfo *)info)->runChildProcess) {
		Thread_RunChildProcessForOpenCLDevice((OpenCLDeviceSearchThreadInfo *)info);
		return 0;
	}

	UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), "[thread] Starting a tripcode search...");

	// Random wait time between 0 and 10 seconds for increased stability.
	Sleep((DWORD)RandomByte() * 10000 / 256);

	// Determine the sizes of local and global work items.
	size_t  numWorkItemsPerComputeUnit;
	size_t  localWorkSize;
	size_t  globalWorkSize;
	char   sourceFileName[MAX_LEN_FILE_PATH + 1];
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(numComputeUnits), &numComputeUnits, NULL));
	GetParametersForOpenCLDevice(deviceID, sourceFileName, &numWorkItemsPerComputeUnit, &localWorkSize, buildOptions);
	globalWorkSize = numWorkItemsPerComputeUnit * numComputeUnits;
	// printf("globalWorkSize: %d\n", globalWorkSize);
	// printf(" localWorkSize: %d\n",  localWorkSize);

	char    deviceVendor[LEN_LINE_BUFFER_FOR_SCREEN];
	char    deviceName  [LEN_LINE_BUFFER_FOR_SCREEN];
	size_t localMemorySize;
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_LOCAL_MEM_SIZE, sizeof(localMemorySize), &localMemorySize, NULL));
	// printf("localMemorySize: %d\n", localMemorySize);
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(numComputeUnits), &numComputeUnits, NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_VENDOR,            sizeof(deviceVendor),    &deviceVendor,    NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_NAME,              sizeof(deviceName),      &deviceName,      NULL));
	BOOL isIntelHDGraphics = FALSE;
	if (   strcmp(deviceVendor, OPENCL_VENDOR_INTEL) == 0
		&& strncmp(deviceName, "Intel(R) HD Graphics", strlen("Intel(R) HD Graphics")) == 0) {
		// There is a bug in the Intel OpenCL driver.
		ERROR0(TRUE, ERROR_INTEL_HD_GRAPHICS, "This software is not compatible with the Intel(R) HD Graphics series.");
		// strcat(buildOptions, " -D INTEL_HD_GRAPHICS ");
	}

	// Create memory blocks for CPU.
	unsigned int  sizeOutputArray = globalWorkSize;
	GPUOutput    *outputArray     = (GPUOutput *)malloc(sizeof(GPUOutput) * sizeOutputArray);
	ERROR0(outputArray == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	unsigned int *compactMediumChunkBitmap = (unsigned int *)calloc(MEDIUM_CHUNK_BITMAP_SIZE / 8, sizeof(unsigned int));
	ERROR0(compactMediumChunkBitmap == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	for (int i = 0; i < MEDIUM_CHUNK_BITMAP_SIZE; ++i)
		if (mediumChunkBitmap[i])
			compactMediumChunkBitmap[i >> 5] |= 0x1 << (i & 0x1f);
	// printf("sizeOutputArray = %u\n", sizeOutputArray);
	PartialKeyFrom3To6 *partialKeyFrom3To6Array = (PartialKeyFrom3To6 *)malloc(sizeof(PartialKeyFrom3To6) * globalWorkSize);
	ERROR0(partialKeyFrom3To6Array == NULL, ERROR_NO_MEMORY, "Not enough memory.");

    // 
	if (options.maximizeKeySpace)
		strcat(buildOptions, " -DMAXIMIZE_KEY_SPACE ");
	char buildOption_localWorkSize[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1];
	sprintf(buildOption_localWorkSize, " -DOPENCL_DES_LOCAL_WORK_SIZE=%d ", (int)localWorkSize);
	strcat(buildOptions, buildOption_localWorkSize);
	strcat(buildOptions, " -w ");
#ifdef DEBUG_KEEP_TEMPORARY_FILES_FOR_OPENCL
	strcat(buildOptions, " -save-temps=OpenCL10.cl ");
#endif

	//
	char *nameKernelFunction;
	if (searchMode == SEARCH_MODE_FORWARD_MATCHING) {
		nameKernelFunction = (numTripcodeChunk == 1)                              ? "FORWARD_MATCHING_1CHUNK" :
		                     (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "FORWARD_MATCHING_SIMPLE" :
							                                                        "FORWARD_MATCHING";
	} else if (searchMode == SEARCH_MODE_BACKWARD_MATCHING) {
		nameKernelFunction = (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "BACKWARD_MATCHING_SIMPLE" : 
		                                                                            "BACKWARD_MATCHING";
	} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {
		nameKernelFunction = (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "FORWARD_AND_BACKWARD_MATCHING_SIMPLE" : 
		                                                                            "FORWARD_AND_BACKWARD_MATCHING";
	} else {
		// Flexible search
		nameKernelFunction = (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "FLEXIBLE_SIMPLE" :
		                                                                            "FLEXIBLE";
	}
	// printf("nameKernelFunction = %s\n", nameKernelFunction);
	strcat(buildOptions, " -D");
	strcat(buildOptions, nameKernelFunction);
	strcat(buildOptions, " ");

	// The main loop of the thread.
	double       timeElapsed = 0;
	double       numGeneratedTripcodes = 0;
	double       averageSpeed = 0;
	DWORD        startingTime = timeGetTime();
	DWORD        endingTime;
	double       deltaTime;
	int          execCounter = 0;
	BOOL         firstBuild = TRUE;
	int          salt0NonDotCounter = 0;
	int          salt1NonDotCounter = 0;

	// Create an OpenCL context.
	context      = clCreateContext(NULL, 1, &deviceID, OnOpenCLError, NULL, &openCLError); OPENCL_ERROR(openCLError);
	commandQueue = clCreateCommandQueue(context, deviceID, 0, &openCLError);               OPENCL_ERROR(openCLError);

	// Create memory blocks for the OpenCL device.
	openCL_outputArray          = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(GPUOutput) * sizeOutputArray,     NULL, &openCLError); OPENCL_ERROR(openCLError);
	openCL_keyInfo              = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(keyInfo),                         NULL, &openCLError); OPENCL_ERROR(openCLError);
	openCL_tripcodeChunkArray   = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(unsigned int) * numTripcodeChunk, NULL, &openCLError); OPENCL_ERROR(openCLError);
	openCL_smallChunkBitmap       = clCreateBuffer(context, CL_MEM_READ_ONLY,  SMALL_CHUNK_BITMAP_SIZE,                   NULL, &openCLError); OPENCL_ERROR(openCLError);
	openCL_compactMediumChunkBitmap = clCreateBuffer(context, CL_MEM_READ_ONLY,  MEDIUM_CHUNK_BITMAP_SIZE / 8,                   NULL, &openCLError); OPENCL_ERROR(openCLError);
	openCL_chunkBitmap            = clCreateBuffer(context, CL_MEM_READ_ONLY,  CHUNK_BITMAP_SIZE,                         NULL, &openCLError); OPENCL_ERROR(openCLError);
	openCL_partialKeyFrom3To6Array      = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(PartialKeyFrom3To6) * globalWorkSize,     NULL, &openCLError); OPENCL_ERROR(openCLError);
			
	while (!GetTerminationState()) {
		// Build the kernel.
		if (firstBuild || --execCounter < 0) {
			UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), "[thread] Creating an OpenCL program...");

			if (!firstBuild) {
				OPENCL_ERROR(clReleaseKernel(kernel));
				OPENCL_ERROR(clReleaseProgram(program));
			}
	
			// Choose the first 3 characters of the keyInfo.partialKeyAndRandomBytes.
			do {
				SetCharactersInTripcodeKey(keyInfo.partialKeyAndRandomBytes, 3);
				unsigned char  salt[2];
				salt[0] = CONVERT_CHAR_FOR_SALT(keyInfo.partialKeyAndRandomBytes[1]);
				if (salt[0] == '.' && salt0NonDotCounter < 64) {
					continue;
				} else if (salt[0] == '.') {
					salt0NonDotCounter -= 63;
				} else {
					++salt0NonDotCounter;
				}
				salt[1] = CONVERT_CHAR_FOR_SALT(keyInfo.partialKeyAndRandomBytes[2]);
				if (salt[1] == '.' && salt1NonDotCounter < 64) {
					continue;
				} else if (salt[1] == '.') {
					salt1NonDotCounter -= 63;
				} else {
					++salt1NonDotCounter;
				}
				break;
			} while (TRUE);

			CreateProgram(&context, &program, &deviceID, sourceFileName, buildOptions, keyInfo.partialKeyAndRandomBytes[1], keyInfo.partialKeyAndRandomBytes[2], keyInfo.expansioinFunction);
			UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), "[thread] Creating an OpenCL kernel...");
			kernel = clCreateKernel(program, "OpenCL_DES_PerformSearching", &openCLError);
			// printf("clCreateKernel(): done\n");
   			OPENCL_ERROR(openCLError);

			// Set arguments for the kernel.
			OPENCL_ERROR(clSetKernelArg(kernel, 0, sizeof(cl_mem),       (void *)&openCL_outputArray));
			OPENCL_ERROR(clSetKernelArg(kernel, 1, sizeof(cl_mem),       (void *)&openCL_keyInfo));
			OPENCL_ERROR(clSetKernelArg(kernel, 2, sizeof(cl_mem),       (void *)&openCL_tripcodeChunkArray));
			OPENCL_ERROR(clSetKernelArg(kernel, 3, sizeof(unsigned int), (void *)&numTripcodeChunk));
			OPENCL_ERROR(clSetKernelArg(kernel, 4, sizeof(cl_mem),       (void *)&openCL_smallChunkBitmap));
			OPENCL_ERROR(clSetKernelArg(kernel, 5, sizeof(cl_mem),       (void *)&openCL_compactMediumChunkBitmap));
			OPENCL_ERROR(clSetKernelArg(kernel, 6, sizeof(cl_mem),       (void *)&openCL_chunkBitmap));
			OPENCL_ERROR(clSetKernelArg(kernel, 7, sizeof(cl_mem),       (void *)&openCL_partialKeyFrom3To6Array));
			OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_tripcodeChunkArray,   CL_TRUE, 0, sizeof(unsigned int) * numTripcodeChunk, tripcodeChunkArray,   0, NULL, NULL));
			OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_smallChunkBitmap,       CL_TRUE, 0, SMALL_CHUNK_BITMAP_SIZE,                   smallChunkBitmap,       0, NULL, NULL));
			OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_compactMediumChunkBitmap,       CL_TRUE, 0, MEDIUM_CHUNK_BITMAP_SIZE / 8,     compactMediumChunkBitmap,       0, NULL, NULL));
			OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_chunkBitmap,            CL_TRUE, 0, CHUNK_BITMAP_SIZE,                         chunkBitmap,            0, NULL, NULL));

			execCounter = 16384 + ((int)RandomByte() * 32 - 128 * 32);;
			firstBuild = FALSE;
		}

		// Set the first character of the key.
		do {
			for (int i = 3; i < lenTripcode; ++i)
				keyInfo.partialKeyAndRandomBytes[i] = 'A';
			if (options.useOneByteCharactersForKeys) {
				keyInfo.partialKeyAndRandomBytes[0] = keyCharTable_OneByte[RandomByte()];
			} else if (   !IS_ONE_BYTE_KEY_CHAR(keyInfo.partialKeyAndRandomBytes[1])
				       && !IsFirstByteSJIS     (keyInfo.partialKeyAndRandomBytes[1])
					   &&  IS_SECOND_BYTE_SJIS (keyInfo.partialKeyAndRandomBytes[1])) {
		 		while (!IsFirstByteSJIS(keyInfo.partialKeyAndRandomBytes[0] = keyCharTable_FirstByte[RandomByte()]))
		 			;
			} else {
				keyInfo.partialKeyAndRandomBytes[0] = keyCharTable_OneByte[RandomByte()];
			}
		} while (!IsValidKey(keyInfo.partialKeyAndRandomBytes));
		BOOL isSecondByte =    (   (IS_ONE_BYTE_KEY_CHAR(keyInfo.partialKeyAndRandomBytes   [0]) && IS_ONE_BYTE_KEY_CHAR(keyInfo.partialKeyAndRandomBytes[1]))
			                        || (IS_FIRST_BYTE_SJIS_FULL(keyInfo.partialKeyAndRandomBytes[0])                                                      ))
								&& IS_FIRST_BYTE_SJIS_FULL(keyInfo.partialKeyAndRandomBytes[2]);
		SET_KEY_CHAR(keyInfo.partialKeyAndRandomBytes[3], isSecondByte, keyCharTable_FirstByte, RandomByte());
		BOOL isKey4SecondByte = isSecondByte;

		//
		unsigned int keyFrom00To27 =   ((keyInfo.partialKeyAndRandomBytes[0] & 0x7f) << 0)
			                          | ((keyInfo.partialKeyAndRandomBytes[1] & 0x7f) << 7)
									  | ((keyInfo.partialKeyAndRandomBytes[2] & 0x7f) << 14)
									  | ((keyInfo.partialKeyAndRandomBytes[3] & 0x7f) << 21);
		OPENCL_ERROR(clSetKernelArg(kernel, 8, sizeof(unsigned int), (void *)&keyFrom00To27));

		// Generate random bytes for the keyInfo.partialKeyAndRandomBytes to ensure the randomness of generated keys.
		for (int i = 4; i < lenTripcode; ++i)
			keyInfo.partialKeyAndRandomBytes[i] = RandomByte();
		
		// Generate part of the keys.
		for (int i = 0; i < globalWorkSize; ++i) {
			isSecondByte = isKey4SecondByte;
			partialKeyFrom3To6Array[i].partialKeyFrom3To6[0] = keyInfo.partialKeyAndRandomBytes[3];
			SET_KEY_CHAR(partialKeyFrom3To6Array[i].partialKeyFrom3To6[1], isSecondByte, keyCharTable_FirstByte, keyInfo.partialKeyAndRandomBytes[4] + ((i >> 10) & 0x1f));
			SET_KEY_CHAR(partialKeyFrom3To6Array[i].partialKeyFrom3To6[2], isSecondByte, keyCharTable_FirstByte, keyInfo.partialKeyAndRandomBytes[5] + ((i >>  5) & 0x1f));
			SET_KEY_CHAR(partialKeyFrom3To6Array[i].partialKeyFrom3To6[3], isSecondByte, keyCharTable_SecondByteAndOneByte, keyInfo.partialKeyAndRandomBytes[6] + ((i >>  0) & 0x1f));
		}

		// Execute the OpenCL kernel
		OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyInfo, CL_TRUE, 0, sizeof(keyInfo), &keyInfo, 0, NULL, NULL));
		OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_partialKeyFrom3To6Array, CL_TRUE, 0, sizeof(PartialKeyFrom3To6) * globalWorkSize, partialKeyFrom3To6Array, 0, NULL, NULL));
		OPENCL_ERROR(clEnqueueNDRangeKernel(commandQueue, kernel, 1, NULL, &globalWorkSize, &localWorkSize, 0, NULL, NULL));
		OPENCL_ERROR(clEnqueueReadBuffer(commandQueue, openCL_outputArray, CL_TRUE, 0, sizeOutputArray * sizeof(GPUOutput), outputArray, 0, NULL, NULL));
		OPENCL_ERROR(clFinish(commandQueue));
		// We can save registers this way.
		for (unsigned int indexOutput = 0; indexOutput < sizeOutputArray; indexOutput++){
			GPUOutput *output = &outputArray[indexOutput];
			if (output->numMatchingTripcodes > 0) {
				output->pair.key.c[0] = keyInfo.partialKeyAndRandomBytes[0];
				output->pair.key.c[1] = keyInfo.partialKeyAndRandomBytes[1];
				output->pair.key.c[2] = keyInfo.partialKeyAndRandomBytes[2];
				output->pair.key.c[3] = partialKeyFrom3To6Array[indexOutput].partialKeyFrom3To6[0];
				output->pair.key.c[4] = partialKeyFrom3To6Array[indexOutput].partialKeyFrom3To6[1];
				output->pair.key.c[5] = partialKeyFrom3To6Array[indexOutput].partialKeyFrom3To6[2];
				output->pair.key.c[6] = partialKeyFrom3To6Array[indexOutput].partialKeyFrom3To6[3];
				GenerateDESTripcode(output->pair.tripcode.c, output->pair.key.c);
			}
		}
		numGeneratedTripcodes += ProcessGPUOutput(keyInfo.partialKeyAndRandomBytes, outputArray, sizeOutputArray, FALSE);

		// Measure the current speed.
		endingTime = timeGetTime();
		deltaTime = (endingTime >= startingTime)
		                ? ((double)endingTime - (double)startingTime                     ) * 0.001
		                : ((double)endingTime - (double)startingTime + (double)0xffffffff) * 0.001;
		while (GetPauseState() && !GetTerminationState())
			Sleep(PAUSE_INTERVAL);
		startingTime = timeGetTime();
		timeElapsed += deltaTime;
		averageSpeed = numGeneratedTripcodes / timeElapsed;
		
		// Update the current status.
		sprintf(status,
			    "[thread] %.1lfM TPS, %d WI, %d WI/CU, %d WI/WG",
				averageSpeed / 1000000,
				globalWorkSize,
				numWorkItemsPerComputeUnit,
				localWorkSize);
		UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), status);
	}
 
    // Clean up.
    OPENCL_ERROR(clFlush(commandQueue));
    OPENCL_ERROR(clFinish(commandQueue));
    OPENCL_ERROR(clReleaseKernel(kernel));
    OPENCL_ERROR(clReleaseProgram(program));
    OPENCL_ERROR(clReleaseMemObject(openCL_outputArray));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyInfo));
    OPENCL_ERROR(clReleaseMemObject(openCL_tripcodeChunkArray));
    OPENCL_ERROR(clReleaseMemObject(openCL_smallChunkBitmap));
	OPENCL_ERROR(clReleaseMemObject(openCL_chunkBitmap));
	OPENCL_ERROR(clReleaseMemObject(openCL_partialKeyFrom3To6Array));
    OPENCL_ERROR(clReleaseCommandQueue(commandQueue));
    OPENCL_ERROR(clReleaseContext(context));
	free(outputArray);
	free(compactMediumChunkBitmap);
	free(partialKeyFrom3To6Array);
}

