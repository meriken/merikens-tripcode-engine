// Meriken's Tripcode Engine 1.1.1
// Copyright (c) 2011-2013 Meriken//XXX <meriken.2ch@gmail.com>
//
// The initial versions of this software were based on:
// CUDA DES Tripper 0.2.1
// Copyright (c) 2009 Horo/.IBXjcg
// 
// The code that deals with DES decryption is partially adopted from:
// John the Ripper password cracker
// Copyright (c) 1996-2002, 2005, 2010 by Solar Designer
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
// OPENCL SEARCH THREAD FOR 12 CHARACTER TRIPCODES                           //
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

unsigned WINAPI Thread_SearchForDESTripcodesOnOpenCLDevice(LPVOID info)
{
	cl_int         openCLError;
	cl_device_id   deviceID = ((OpenCLDeviceSearchThreadInfo *)info)->openCLDeviceID;
	cl_uint        numComputeUnits;
	char           status[LEN_LINE_BUFFER_FOR_SCREEN] = "";
	char           buildOptions[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1] = ""; 
	KeyInfo        keyInfo;
	unsigned char  expansionFunction[96];

	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(numComputeUnits), &numComputeUnits, NULL));

	// Determine the sizes of local and global work items.
	size_t  numThreadsPerComputeUnit;
	size_t  localWorkSize;
	size_t  globalWorkSize;
	char   sourceFileName[MAX_LEN_FILE_PATH + 1];
	GetParametersForOpenCLDevice(deviceID, sourceFileName, &numThreadsPerComputeUnit, &localWorkSize, buildOptions);
	globalWorkSize = numThreadsPerComputeUnit * numComputeUnits;
	// printf("globalWorkSize: %d\n", globalWorkSize);
	// printf(" localWorkSize: %d\n",  localWorkSize);

	char    deviceVendor[LEN_LINE_BUFFER_FOR_SCREEN];
	char    deviceName  [LEN_LINE_BUFFER_FOR_SCREEN];
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

	// Choose the first 3 characters of the keyInfo.partialKeyAndRandomBytes.
	// Make sure that the first 3 bytes consist of valid Shift-JIS characters.
	do {
		SetCharactersInTripcodeKey(keyInfo.partialKeyAndRandomBytes, 3);
		for (int i = 3; i < lenTripcode; ++i)
			keyInfo.partialKeyAndRandomBytes[i] = 'A';
	} while (!IsValidKey(keyInfo.partialKeyAndRandomBytes));

	// Create an OpenCL context.
    cl_context       context      = clCreateContext(NULL, 1, &deviceID, OnOpenCLError, NULL, &openCLError); OPENCL_ERROR(openCLError);
    cl_command_queue commandQueue = clCreateCommandQueue(context, deviceID, 0, &openCLError);               OPENCL_ERROR(openCLError);
	// Create memory blocks for CPU.
	unsigned int  sizeOutputArray = globalWorkSize;
	GPUOutput    *outputArray     = (GPUOutput *)malloc(sizeof(GPUOutput) * sizeOutputArray);
	ERROR0(outputArray == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	// printf("sizeOutputArray = %u\n", sizeOutputArray);

	// Create memory blocks for the OpenCL device.
	cl_mem openCL_outputArray          = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(GPUOutput) * sizeOutputArray,     NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyInfo              = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(keyInfo),                         NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_tripcodeChunkArray   = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(unsigned int) * numTripcodeChunk, NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyCharTable_OneByte = clCreateBuffer(context, CL_MEM_READ_ONLY,  SIZE_KEY_CHAR_TABLE,                     NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyCharTable_FirstByte   = clCreateBuffer(context, CL_MEM_READ_ONLY,  SIZE_KEY_CHAR_TABLE,                     NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyCharTable_SecondByte  = clCreateBuffer(context, CL_MEM_READ_ONLY,  SIZE_KEY_CHAR_TABLE,                     NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_smallKeyBitmap       = clCreateBuffer(context, CL_MEM_READ_ONLY,  SMALL_KEY_BITMAP_SIZE,                   NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyBitmap            = clCreateBuffer(context, CL_MEM_READ_ONLY,  KEY_BITMAP_SIZE,                         NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_partialKeyFrom3To6Array      = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(PartialKeyFrom3To6) * globalWorkSize,     NULL, &openCLError); OPENCL_ERROR(openCLError);

	// Create an expansion function based on the salt.
	unsigned char  salt[2];
	salt[0] = CONVERT_CHAR_FOR_SALT(keyInfo.partialKeyAndRandomBytes[1]);
	salt[1] = CONVERT_CHAR_FOR_SALT(keyInfo.partialKeyAndRandomBytes[2]);
	DES_CreateExpansionFunction((char *)salt, expansionFunction);
	for (int i = 0; i < 96; ++i)
		keyInfo.expansioinFunction[i] = expansionFunction[i];

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
	for (int i = 0; i < DES_SIZE_EXPANSION_FUNCTION; ++i) {
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
		sprintf(s, "#define EF%02d %d\n", i, (int)expansionFunction[i]);
		strcat(sourceCode, s);
	}
	//
	strcat(sourceCode, "#define K07XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[1] & (0x1 << (0))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K08XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[1] & (0x1 << (1))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K09XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[1] & (0x1 << (2))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K10XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[1] & (0x1 << (3))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K11XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[1] & (0x1 << (4))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K12XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[1] & (0x1 << (5))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K13XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[1] & (0x1 << (6))) ? "(~(x))\n" : "(x)\n");
	//
	strcat(sourceCode, "#define K14XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[2] & (0x1 << (0))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K15XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[2] & (0x1 << (1))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K16XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[2] & (0x1 << (2))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K17XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[2] & (0x1 << (3))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K18XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[2] & (0x1 << (4))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K19XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[2] & (0x1 << (5))) ? "(~(x))\n" : "(x)\n");
	strcat(sourceCode, "#define K20XOR(x) "); strcat(sourceCode, (keyInfo.partialKeyAndRandomBytes[2] & (0x1 << (6))) ? "(~(x))\n" : "(x)\n");
	// printf("sourceCode[%d]:\n%s", strlen(sourceCode), sourceCode);
	sizeSourceCode =  strlen(sourceCode);
	sizeSourceCode += fread(sourceCode + strlen(sourceCode), 1, OPENCL_MAX_SIZE_SOURCE_CODE - strlen(sourceCode), sourceFile);
    fclose(sourceFile);
	
    // Create an OpenCL kernel from the source code.
	UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), "Building an OpenCL program...");
	if (options.maximizeKeySpace)
		strcat(buildOptions, " -D MAXIMIZE_KEY_SPACE ");
	// printf("clCreateProgramWithSource()\n");
    cl_program       program      = clCreateProgramWithSource(context, 1, (const char **)&sourceCode, (const size_t *)&sizeSourceCode, &openCLError);
	char buildOption_localWorkSize[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1];
	sprintf(buildOption_localWorkSize, " -DOPENCL_DES_LOCAL_WORK_SIZE=%d ", (int)localWorkSize);
	strcat(buildOptions, buildOption_localWorkSize);
#ifdef DEBUG_KEEP_TEMPORARY_FILES_FOR_OPENCL
	strcat(buildOptions, " -save-temps=OpenCL10.cl ");
#endif
	openCLError = clBuildProgram(program, 1, &deviceID, buildOptions, NULL, NULL);
	if (openCLError != CL_SUCCESS && !options.redirection) {
		size_t lenBuildLog= 0;
		char  *buildLog = NULL;
		clGetProgramBuildInfo(program, deviceID, CL_PROGRAM_BUILD_LOG, 0, NULL, &lenBuildLog);
		if ((buildLog = (char *)malloc(lenBuildLog + 1)) != NULL) {
			clGetProgramBuildInfo(program, deviceID, CL_PROGRAM_BUILD_LOG, lenBuildLog, buildLog, &lenBuildLog);
			buildLog[lenBuildLog] = '\0';
			fprintf(stderr, "%s\n", buildLog);
			free(buildLog);
		}
	}
	OPENCL_ERROR(openCLError);
	char *nameKernelFunction;
	if (searchMode == SEARCH_MODE_FORWARD_MATCHING) {
		nameKernelFunction = (numTripcodeChunk == 1)                              ? "OpenCL_DES_PerformSearching_ForwardMatching_1Chunk" :
		                     (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "OpenCL_DES_PerformSearching_ForwardMatching_Simple" :
							                                                        "OpenCL_DES_PerformSearching_ForwardMatching";
	} else if (searchMode == SEARCH_MODE_BACKWARD_MATCHING) {
		nameKernelFunction = (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "OpenCL_DES_PerformSearching_BackwardMatching_Simple" : 
		                                                                            "OpenCL_DES_PerformSearching_BackwardMatching";
	} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {
		nameKernelFunction = (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "OpenCL_DES_PerformSearching_ForwardAndBackwardMatching_Simple" : 
		                                                                            "OpenCL_DES_PerformSearching_ForwardAndBackwardMatching";
	} else {
		// Flexible search
		nameKernelFunction = (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "OpenCL_DES_PerformSearching_Flexible_Simple" :
		                                                                            "OpenCL_DES_PerformSearching_Flexible";
	}
	// printf("nameKernelFunction = %s\n", nameKernelFunction);
	// printf("clCreateKernel()\n");
	UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), "Creating an OpenCL kernel...");
    cl_kernel kernel = clCreateKernel(program, nameKernelFunction, &openCLError);
	// printf("clCreateKernel(): done\n");
   	OPENCL_ERROR(openCLError);

	// Set arguments for the kernel.
	OPENCL_ERROR(clSetKernelArg(kernel, 0, sizeof(cl_mem),       (void *)&openCL_outputArray));
	OPENCL_ERROR(clSetKernelArg(kernel, 1, sizeof(cl_mem),       (void *)&openCL_keyInfo));
	OPENCL_ERROR(clSetKernelArg(kernel, 2, sizeof(cl_mem),       (void *)&openCL_tripcodeChunkArray));
	OPENCL_ERROR(clSetKernelArg(kernel, 3, sizeof(unsigned int), (void *)&numTripcodeChunk));
	OPENCL_ERROR(clSetKernelArg(kernel, 4, sizeof(cl_mem),       (void *)&openCL_keyCharTable_OneByte));
	OPENCL_ERROR(clSetKernelArg(kernel, 5, sizeof(cl_mem),       (void *)&openCL_keyCharTable_FirstByte));
	OPENCL_ERROR(clSetKernelArg(kernel, 6, sizeof(cl_mem),       (void *)&openCL_keyCharTable_SecondByte));
	OPENCL_ERROR(clSetKernelArg(kernel, 7, sizeof(cl_mem),       (void *)&openCL_smallKeyBitmap));
	OPENCL_ERROR(clSetKernelArg(kernel, 8, sizeof(cl_mem),       (void *)&openCL_keyBitmap));
	OPENCL_ERROR(clSetKernelArg(kernel, 9, sizeof(cl_mem),       (void *)&openCL_partialKeyFrom3To6Array));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_tripcodeChunkArray,   CL_TRUE, 0, sizeof(unsigned int) * numTripcodeChunk, tripcodeChunkArray,   0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_OneByte, CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_OneByte, 0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_FirstByte,   CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_FirstByte,   0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_SecondByte,  CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_SecondByte,  0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_smallKeyBitmap,       CL_TRUE, 0, SMALL_KEY_BITMAP_SIZE,                   smallKeyBitmap,       0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyBitmap,            CL_TRUE, 0, KEY_BITMAP_SIZE,                         keyBitmap,            0, NULL, NULL));

	// The main loop of the thread.
	UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), "Starting a tripcode search...");
	double       timeElapsed = 0;
	double       numGeneratedTripcodes = 0;
	double       averageSpeed = 0;
	DWORD        startingTime = timeGetTime();
	DWORD        endingTime;
	double       deltaTime;
	PartialKeyFrom3To6 *partialKeyFrom3To6Array = (PartialKeyFrom3To6 *)malloc(sizeof(PartialKeyFrom3To6) * globalWorkSize);
	ERROR0(partialKeyFrom3To6Array == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	while (!GetTerminationState()) {
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
		BOOL isKey3SecondByte =    (   (IS_ONE_BYTE_KEY_CHAR(keyInfo.partialKeyAndRandomBytes   [0]) && IS_ONE_BYTE_KEY_CHAR(keyInfo.partialKeyAndRandomBytes[1]))
			                        || (IS_FIRST_BYTE_SJIS_FULL(keyInfo.partialKeyAndRandomBytes[0])                                                      ))
								&& IS_FIRST_BYTE_SJIS_FULL(keyInfo.partialKeyAndRandomBytes[2]);

		// Generate random bytes for the keyInfo.partialKeyAndRandomBytes to ensure the randomness of generated keys.
		for (int i = 3; i < lenTripcode; ++i)
			keyInfo.partialKeyAndRandomBytes[i] = RandomByte();
		
		// Generate part of the keys.
		for (int i = 0; i < globalWorkSize; ++i) {
			BOOL isSecondByte = isKey3SecondByte;
			SET_KEY_CHAR(partialKeyFrom3To6Array[i].partialKeyFrom3To6[0], isSecondByte, keyCharTable_FirstByte, keyInfo.partialKeyAndRandomBytes[3] + ((i >> 15) & 0x1f));
			SET_KEY_CHAR(partialKeyFrom3To6Array[i].partialKeyFrom3To6[1], isSecondByte, keyCharTable_FirstByte, keyInfo.partialKeyAndRandomBytes[4] + ((i >> 10) & 0x1f));
			SET_KEY_CHAR(partialKeyFrom3To6Array[i].partialKeyFrom3To6[2], isSecondByte, keyCharTable_FirstByte, keyInfo.partialKeyAndRandomBytes[5] + ((i >>  5) & 0x1f));
			SET_KEY_CHAR(partialKeyFrom3To6Array[i].partialKeyFrom3To6[3], isSecondByte, keyCharTable_OneByte,   keyInfo.partialKeyAndRandomBytes[6] + ((i >>  0) & 0x1f));
		}

		// Execute the OpenCL kernel
		OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyInfo, CL_TRUE, 0, sizeof(keyInfo), &keyInfo, 0, NULL, NULL));
		OPENCL_ERROR(clEnqueueNDRangeKernel(commandQueue, kernel, 1, NULL, &globalWorkSize, &localWorkSize, 0, NULL, NULL));
		OPENCL_ERROR(clEnqueueReadBuffer(commandQueue, openCL_outputArray, CL_TRUE, 0, sizeOutputArray * sizeof(GPUOutput), outputArray, 0, NULL, NULL));
		OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_partialKeyFrom3To6Array, CL_TRUE, 0, sizeof(PartialKeyFrom3To6) * globalWorkSize, partialKeyFrom3To6Array, 0, NULL, NULL));
		OPENCL_ERROR(clFinish(commandQueue));
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
			    "%.1lfM TPS, %d work-groups/CU, %d work-items/WG",
				averageSpeed / 1000000,
				numThreadsPerComputeUnit,
				localWorkSize);
		UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), status);
	}
 
    // Clean up.
	free(partialKeyFrom3To6Array);
    OPENCL_ERROR(clFlush(commandQueue));
    OPENCL_ERROR(clFinish(commandQueue));
    OPENCL_ERROR(clReleaseKernel(kernel));
    OPENCL_ERROR(clReleaseProgram(program));
    OPENCL_ERROR(clReleaseMemObject(openCL_outputArray));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyInfo));
    OPENCL_ERROR(clReleaseMemObject(openCL_tripcodeChunkArray));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_OneByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_FirstByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_SecondByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_smallKeyBitmap));
	OPENCL_ERROR(clReleaseMemObject(openCL_partialKeyFrom3To6Array));
    OPENCL_ERROR(clReleaseCommandQueue(commandQueue));
    OPENCL_ERROR(clReleaseContext(context));
}

