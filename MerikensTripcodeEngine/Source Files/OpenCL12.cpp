// Meriken's Tripcode Engine 1.1.2
// Copyright (c) 2011-2014 Meriken//XXX <meriken.2ch@gmail.com>
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



///////////////////////////////////////////////////////////////////////////////
// INCLUDE FILE(S)                                                           //
///////////////////////////////////////////////////////////////////////////////

#include "MerikensTripcodeEngine.h"



///////////////////////////////////////////////////////////////////////////////
// OPENCL SEARCH THREAD FOR 12 CHARACTER TRIPCODES                           //
///////////////////////////////////////////////////////////////////////////////

char *ConvertOpenCLErrorCodeToString(cl_int openCLError)
{
	switch (openCLError) {
        case CL_SUCCESS:                         return "CL_SUCCESS";
        case CL_DEVICE_NOT_FOUND:                return "CL_DEVICE_NOT_FOUND";
        case CL_DEVICE_NOT_AVAILABLE:            return "CL_DEVICE_NOT_AVAILABLE";
        case CL_COMPILER_NOT_AVAILABLE:          return "CL_COMPILER_NOT_AVAILABLE";
        case CL_MEM_OBJECT_ALLOCATION_FAILURE:   return "CL_MEM_OBJECT_ALLOCATION_FAILURE";
        case CL_OUT_OF_RESOURCES:                return "CL_OUT_OF_RESOURCES";
        case CL_OUT_OF_HOST_MEMORY:              return "CL_OUT_OF_HOST_MEMORY";
        case CL_PROFILING_INFO_NOT_AVAILABLE:    return "CL_PROFILING_INFO_NOT_AVAILABLE";
        case CL_MEM_COPY_OVERLAP:                return "CL_MEM_COPY_OVERLAP";
        case CL_IMAGE_FORMAT_MISMATCH:           return "CL_IMAGE_FORMAT_MISMATCH";
        case CL_IMAGE_FORMAT_NOT_SUPPORTED:      return "CL_IMAGE_FORMAT_NOT_SUPPORTED";
        case CL_BUILD_PROGRAM_FAILURE:           return "CL_BUILD_PROGRAM_FAILURE";
        case CL_MAP_FAILURE:                     return "CL_MAP_FAILURE";
        case CL_INVALID_VALUE:                   return "CL_INVALID_VALUE";
        case CL_INVALID_DEVICE_TYPE:             return "CL_INVALID_DEVICE_TYPE";
        case CL_INVALID_PLATFORM:                return "CL_INVALID_PLATFORM";
        case CL_INVALID_DEVICE:                  return "CL_INVALID_DEVICE";
        case CL_INVALID_CONTEXT:                 return "CL_INVALID_CONTEXT";
        case CL_INVALID_QUEUE_PROPERTIES:        return "CL_INVALID_QUEUE_PROPERTIES";
        case CL_INVALID_COMMAND_QUEUE:           return "CL_INVALID_COMMAND_QUEUE";
        case CL_INVALID_HOST_PTR:                return "CL_INVALID_HOST_PTR";
        case CL_INVALID_MEM_OBJECT:              return "CL_INVALID_MEM_OBJECT";
        case CL_INVALID_IMAGE_FORMAT_DESCRIPTOR: return "CL_INVALID_IMAGE_FORMAT_DESCRIPTOR";
        case CL_INVALID_IMAGE_SIZE:              return "CL_INVALID_IMAGE_SIZE";
        case CL_INVALID_SAMPLER:                 return "CL_INVALID_SAMPLER";
        case CL_INVALID_BINARY:                  return "CL_INVALID_BINARY";
        case CL_INVALID_BUILD_OPTIONS:           return "CL_INVALID_BUILD_OPTIONS";
        case CL_INVALID_PROGRAM:                 return "CL_INVALID_PROGRAM";
        case CL_INVALID_PROGRAM_EXECUTABLE:      return "CL_INVALID_PROGRAM_EXECUTABLE";
        case CL_INVALID_KERNEL_NAME:             return "CL_INVALID_KERNEL_NAME";
        case CL_INVALID_KERNEL_DEFINITION:       return "CL_INVALID_KERNEL_DEFINITION";
        case CL_INVALID_KERNEL:                  return "CL_INVALID_KERNEL";
        case CL_INVALID_ARG_INDEX:               return "CL_INVALID_ARG_INDEX";
        case CL_INVALID_ARG_VALUE:               return "CL_INVALID_ARG_VALUE";
        case CL_INVALID_ARG_SIZE:                return "CL_INVALID_ARG_SIZE";
        case CL_INVALID_KERNEL_ARGS:             return "CL_INVALID_KERNEL_ARGS";
        case CL_INVALID_WORK_DIMENSION:          return "CL_INVALID_WORK_DIMENSION";
        case CL_INVALID_WORK_GROUP_SIZE:         return "CL_INVALID_WORK_GROUP_SIZE";
        case CL_INVALID_WORK_ITEM_SIZE:          return "CL_INVALID_WORK_ITEM_SIZE";
        case CL_INVALID_GLOBAL_OFFSET:           return "CL_INVALID_GLOBAL_OFFSET";
        case CL_INVALID_EVENT_WAIT_LIST:         return "CL_INVALID_EVENT_WAIT_LIST";
        case CL_INVALID_EVENT:                   return "CL_INVALID_EVENT";
        case CL_INVALID_OPERATION:               return "CL_INVALID_OPERATION";
        case CL_INVALID_GL_OBJECT:               return "CL_INVALID_GL_OBJECT";
        case CL_INVALID_BUFFER_SIZE:             return "CL_INVALID_BUFFER_SIZE";
        case CL_INVALID_MIP_LEVEL:               return "CL_INVALID_MIP_LEVEL";
        default:                                 return "Unknown";
    }
}

void __stdcall OnOpenCLError(const char *errorInfo, const void *privateInfo, size_t sizePrivateInfo, void *userData)
{
	fprintf(stderr, "OnOpenCLError(): %s\n", errorInfo);
}


struct {
	char   *vendor;
	char   *name;
	int     numCU;
	char   *productName;

	char   *sourceFile_SHA1;
	size_t  numWorkGroupsPerComputeUnit_SHA1;
	size_t  localWorkSize_SHA1;

	char   *sourceFile_DES;
	size_t  numWorkGroupsPerComputeUnit_DES;
	size_t  localWorkSize_DES;
	char   *buildOptions_DES;
} static deviceSettingsArray[] = {
	{OPENCL_VENDOR_AMD,    "Cedar",                      2, "Radeon HD 5450",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Redwood",                    4, "Radeon HD 5550",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Redwood",                    5, "Radeon HD 5570/5670",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Juniper",                    9, "Radeon HD 5750",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Juniper",                   10, "Radeon HD 5770",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""}, // measured
	{OPENCL_VENDOR_AMD,    "Cypress",                   14, "Radeon HD 5830",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Cypress",                   18, "Radeon HD 5850",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Cypress",                   20, "Radeon HD 5870",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 5120,  64, "OpenCL\\OpenCL10.cl", 5120,  64, ""}, // reported
	{OPENCL_VENDOR_AMD,    "Hemlock",                   -1, "Radeon HD 5970",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 5120,  64, "OpenCL\\OpenCL10.cl", 5120,  64, ""},

	{OPENCL_VENDOR_AMD,    "Saymour",                    2, "Radeon HD 6400M Series", "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Caicos",                     2, "Radeon HD 6450",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Turks",                      6, "Radeon HD 6570/6670",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Whistler",                   6, "Radeon HD 6700M Series", "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Barts",                     10, "Radeon HD 6790",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Barts",                     12, "Radeon HD 6850",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Barts",                     14, "Radeon HD 6870",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Blackcomb",                 12, "Radeon HD 6950M",        "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Cayman",                    22, "Radeon HD 6950",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Cayman",                    -1, "Radeon HD 6970/6990",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},

	{OPENCL_VENDOR_AMD,    "Verde",                      8, "Radeon HD 7750",         "OpenCL\\OpenCL12.cl",              960,  64, "OpenCL\\OpenCL10.cl",16384,  64, "-DUNROLL_MAIN_LOOP -DUSE_UNSIGNED_LONG"},
	{OPENCL_VENDOR_AMD,    "Verde",                     10, "Radeon HD 7770",         "OpenCL\\OpenCL12.cl",              960,  64, "OpenCL\\OpenCL10.cl",16384,  64, "-DUNROLL_MAIN_LOOP -DUSE_UNSIGNED_LONG"},
	{OPENCL_VENDOR_AMD,    "Pitcairn",                  16, "Radeon HD 7850",         "OpenCL\\OpenCL12.cl",              960,  64, "OpenCL\\OpenCL10.cl",16384,  64, "-DUNROLL_MAIN_LOOP -DUSE_UNSIGNED_LONG"},
	{OPENCL_VENDOR_AMD,    "Pitcairn",                  20, "Radeon HD 7870",         "OpenCL\\OpenCL12.cl",              960,  64, "OpenCL\\OpenCL10.cl",16384,  64, "-DUNROLL_MAIN_LOOP -DUSE_UNSIGNED_LONG"},
	{OPENCL_VENDOR_AMD,    "Tahiti",                    28, "Radeon HD 7950",         "OpenCL\\OpenCL12.cl",              960,  64, "OpenCL\\OpenCL10.cl",16384,  64, "-DUNROLL_MAIN_LOOP -DUSE_UNSIGNED_LONG"},
	{OPENCL_VENDOR_AMD,    "Tahiti",                    32, "Radeon HD 7970/7990",    "OpenCL\\OpenCL12.cl",              960,  64, "OpenCL\\OpenCL10.cl",16384,  64, "-DUNROLL_MAIN_LOOP -DUSE_UNSIGNED_LONG"}, // measured

	{OPENCL_VENDOR_AMD,    "Hawaii",                    40, "Radeon R9 290",          "OpenCL\\OpenCL12.cl",            16384, 128, "OpenCL\\OpenCL10.cl",16384,  64, "-DUNROLL_MAIN_LOOP -DUSE_UNSIGNED_LONG"}, // measured
	{OPENCL_VENDOR_AMD,    "Hawaii",                    44, "Radeon R9 290X",         "OpenCL\\OpenCL12.cl",            16384, 128, "OpenCL\\OpenCL10.cl",16384,  64, "-DUNROLL_MAIN_LOOP -DUSE_UNSIGNED_LONG"}, // measured

	{OPENCL_VENDOR_AMD,    "Desna",                     -1, "Z-series",               "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Ontario",                   -1, "C/G-series",             "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Zacate",                    -1, "E/G-series",             "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Llano",                     -1, "A8/A6/A4/E2-series",     "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Hondo",                     -1, "Z-series",               "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Brazos",                    -1, "E2-series",              "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Trinity",                   -1, "A10/A8/A6/A4-series",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},
	{OPENCL_VENDOR_AMD,    "Devastator",                -1, "A10/A8/A6/A4-series",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 2560,  64, ""},

	{OPENCL_VENDOR_AMD,    NULL,                        -1, NULL,                     "OpenCL\\OpenCL12.cl",            16384,  64, "OpenCL\\OpenCL10.cl",16384,  64, "-DUNROLL_MAIN_LOOP -DUSE_UNSIGNED_LONG"},

	{OPENCL_VENDOR_NVIDIA, NULL,                        -1, NULL,                     "OpenCL\\OpenCL12.cl",            16384, 128, "OpenCL\\OpenCL10.cl",16384, 128, ""},

	{OPENCL_VENDOR_INTEL,  "Intel(R) HD Graphics 2500", -1, NULL,                     "OpenCL\\OpenCL12.cl",               64,  32, "OpenCL\\OpenCL10.cl",   64,  32, ""},
	{OPENCL_VENDOR_INTEL,  "Intel(R) HD Graphics 4000", -1, NULL,                     "OpenCL\\OpenCL12.cl",               64,  32, "OpenCL\\OpenCL10.cl",   64,  32, ""}, // measured

	{NULL}
};



char *GetProductNameForOpenCLDevice(char *vendor, char *name, cl_uint numComputeUnits)
{
	for (int i = 0; deviceSettingsArray[i].vendor != NULL; ++i) {
		if (   (   strcmp(deviceSettingsArray[i].vendor, vendor) == 0
			    && deviceSettingsArray[i].name == NULL               )
		    || (   strcmp(deviceSettingsArray[i].vendor, vendor) == 0
			    && strcmp(deviceSettingsArray[i].name,   name  ) == 0
				&& deviceSettingsArray[i].numCU < 0                  )
			|| (   strcmp(deviceSettingsArray[i].vendor, vendor) == 0
			    && strcmp(deviceSettingsArray[i].name,   name  ) == 0
				&& (cl_uint)(deviceSettingsArray[i].numCU) == numComputeUnits))
			return deviceSettingsArray[i].productName;
	}
	return NULL;
}

void GetParametersForOpenCLDevice(cl_device_id deviceID, char *sourceFile, size_t *numWorkGroupsPerComputeUnit, size_t *localWorkSize, char *buildOptions)
{
	cl_uint numComputeUnits;

	*numWorkGroupsPerComputeUnit = OPENCL_SHA1_DEFAULT_NUM_WORK_GROUPS_PER_COMPUTE_UNIT;
	*localWorkSize               = OPENCL_SHA1_DEFAULT_NUM_WORK_ITEMS;
	if (sourceFile && lenTripcode == 12) {
		strcpy(sourceFile, OPENCL_SHA1_DEFAULT_SOURCE_FILE);
	} else if (sourceFile && lenTripcode == 10) {
		strcpy(sourceFile, OPENCL_DES_DEFAULT_SOURCE_FILE);
	} 
	if (buildOptions)
		strcpy(buildOptions, "");
	char    deviceVendor[LEN_LINE_BUFFER_FOR_SCREEN];
	char    deviceName  [LEN_LINE_BUFFER_FOR_SCREEN];
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_VENDOR,            sizeof(deviceVendor),    &deviceVendor,    NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_NAME,              sizeof(deviceName),      &deviceName,      NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(numComputeUnits), &numComputeUnits, NULL));
	for (int i = 0; deviceSettingsArray[i].vendor != NULL; ++i) {
		if (   (   strcmp(deviceSettingsArray[i].vendor, deviceVendor) == 0
			    && deviceSettingsArray[i].name == NULL                     )
		    || (   strcmp(deviceSettingsArray[i].vendor, deviceVendor) == 0
			    && strcmp(deviceSettingsArray[i].name,   deviceName  ) == 0
				&& deviceSettingsArray[i].numCU < 0                        )
			|| (   strcmp(deviceSettingsArray[i].vendor, deviceVendor) == 0
			    && strcmp(deviceSettingsArray[i].name,   deviceName  ) == 0
				&& (cl_uint)(deviceSettingsArray[i].numCU) == numComputeUnits)) {
			if (sourceFile && lenTripcode == 12) {
				strcpy(sourceFile, deviceSettingsArray[i].sourceFile_SHA1);
			} else if (sourceFile && lenTripcode == 10) {
				strcpy(sourceFile, deviceSettingsArray[i].sourceFile_DES);
			}
			if (buildOptions && lenTripcode == 10)
				strcpy(buildOptions, deviceSettingsArray[i].buildOptions_DES);
			*numWorkGroupsPerComputeUnit = (lenTripcode == 12) ? (deviceSettingsArray[i].numWorkGroupsPerComputeUnit_SHA1) : (deviceSettingsArray[i].numWorkGroupsPerComputeUnit_DES);
			*localWorkSize               = (lenTripcode == 12) ? (deviceSettingsArray[i].localWorkSize_SHA1              ) : (deviceSettingsArray[i].localWorkSize_DES              );
			break;
		}
	}
	if (options.openCLNumWorkGroupsPerCU != OPENCL_NUM_WORK_GROUPS_PER_CU_NIL)
		*numWorkGroupsPerComputeUnit = options.openCLNumWorkGroupsPerCU;
	if (options.openCLNumWorkItemsPerWG  != OPENCL_NUM_WORK_ITEMS_PER_WG_NIL)
		*localWorkSize = options.openCLNumWorkItemsPerWG;
}

unsigned WINAPI Thread_SearchForSHA1TripcodesOnOpenCLDevice(LPVOID info)
{

	cl_int         openCLError;
	cl_device_id   deviceID = ((OpenCLDeviceSearchThreadInfo *)info)->openCLDeviceID;
	cl_uint        numComputeUnits;
	char           status[LEN_LINE_BUFFER_FOR_SCREEN] = "";
	char           buildOptions[MAX_LEN_COMMAND_LINE + 1] = ""; 
	unsigned char  key[MAX_LEN_TRIPCODE + 1];

	// Random wait time between 0 and 10 seconds for increased stability.
	Sleep((DWORD)RandomByte() * 10000 / 256);

	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(numComputeUnits), &numComputeUnits, NULL));
	key[lenTripcode] = '\0';

	// Determine the sizes of local and global work items.
	size_t numWorkGroupsPerComputeUnit;
	size_t localWorkSize;
	size_t globalWorkSize;
	char   sourceFileName[MAX_LEN_FILE_PATH + 1];
	GetParametersForOpenCLDevice(deviceID, sourceFileName, &numWorkGroupsPerComputeUnit, &localWorkSize, buildOptions);
	globalWorkSize = numWorkGroupsPerComputeUnit * numComputeUnits;

	char    deviceVendor[LEN_LINE_BUFFER_FOR_SCREEN];
	char    deviceName  [LEN_LINE_BUFFER_FOR_SCREEN];
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(numComputeUnits), &numComputeUnits, NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_VENDOR,            sizeof(deviceVendor),    &deviceVendor,    NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_NAME,              sizeof(deviceName),      &deviceName,      NULL));
	BOOL isIntelHDGraphics = FALSE;
	if (   strcmp(deviceVendor, OPENCL_VENDOR_INTEL) == 0
		&& strncmp(deviceName, "Intel(R) HD Graphics", strlen("Intel(R) HD Graphics")) == 0) {
		// There is a bug in the Intel OpenCL driver.
		// ERROR0(TRUE, ERROR_INTEL_HD_GRAPHICS, "This software is not compatible with the Intel(R) HD Graphics series.");
		strcat(buildOptions, " -D INTEL_HD_GRAPHICS ");
	}

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
    sizeSourceCode = fread(sourceCode, 1, OPENCL_MAX_SIZE_SOURCE_CODE, sourceFile);
    fclose(sourceFile);

    // Create an OpenCL kernel from the source code.
	if (options.maximizeKeySpace)
		strcat(buildOptions, " -D MAXIMIZE_KEY_SPACE ");
	cl_context       context      = clCreateContext(NULL, 1, &deviceID, OnOpenCLError, NULL, &openCLError); OPENCL_ERROR(openCLError);
    cl_command_queue commandQueue = clCreateCommandQueue(context, deviceID, 0, &openCLError);               OPENCL_ERROR(openCLError);
    cl_program       program      = clCreateProgramWithSource(context, 1, (const char **)&sourceCode, (const size_t *)&sizeSourceCode, &openCLError);
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
		nameKernelFunction = (numTripcodeChunk == 1)                              ? "OpenCL_SHA1_PerformSearching_ForwardMatching_1Chunk" :
		                     (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "OpenCL_SHA1_PerformSearching_ForwardMatching_Simple" :
							                                                        "OpenCL_SHA1_PerformSearching_ForwardMatching";
	} else if (searchMode == SEARCH_MODE_BACKWARD_MATCHING) {
		nameKernelFunction = (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "OpenCL_SHA1_PerformSearching_BackwardMatching_Simple" : 
		                                                                            "OpenCL_SHA1_PerformSearching_BackwardMatching";
	} else if (searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) {
		nameKernelFunction = (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "OpenCL_SHA1_PerformSearching_ForwardAndBackwardMatching_Simple" : 
		                                                                            "OpenCL_SHA1_PerformSearching_ForwardAndBackwardMatching";
	} else {
		// Flexible search
		nameKernelFunction = (numTripcodeChunk <= OPENCL_SIMPLE_SEARCH_THRESHOLD) ? "OpenCL_SHA1_PerformSearching_Flexible_Simple" :
		                                                                            "OpenCL_SHA1_PerformSearching_Flexible";
	}
	// printf("nameKernelFunction = %s\n", nameKernelFunction);
    cl_kernel kernel = clCreateKernel(program, nameKernelFunction, &openCLError);
   	OPENCL_ERROR(openCLError);

	// Create memory blocks for CPU.
	unsigned int  sizeOutputArray = globalWorkSize;
	GPUOutput    *outputArray     = (GPUOutput *)malloc(sizeof(GPUOutput) * sizeOutputArray);
	ERROR0(outputArray == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	// printf("sizeOutputArray = %u\n", sizeOutputArray);

	// Create memory blocks for the OpenCL device.
	cl_mem openCL_outputArray                       = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(GPUOutput) * sizeOutputArray,     NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_key                               = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(key),                             NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_tripcodeChunkArray                = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(unsigned int) * numTripcodeChunk, NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyCharTable_OneByte              = clCreateBuffer(context, CL_MEM_READ_ONLY,  SIZE_KEY_CHAR_TABLE,                     NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyCharTable_FirstByte            = clCreateBuffer(context, CL_MEM_READ_ONLY,  SIZE_KEY_CHAR_TABLE,                     NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyCharTable_SecondByte           = clCreateBuffer(context, CL_MEM_READ_ONLY,  SIZE_KEY_CHAR_TABLE,                     NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyCharTable_SecondByteAndOneByte = clCreateBuffer(context, CL_MEM_READ_ONLY,  SIZE_KEY_CHAR_TABLE,                     NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_smallKeyBitmap                    = clCreateBuffer(context, CL_MEM_READ_ONLY,  SMALL_KEY_BITMAP_SIZE,                   NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_keyBitmap                         = clCreateBuffer(context, CL_MEM_READ_ONLY,  KEY_BITMAP_SIZE,                         NULL, &openCLError); OPENCL_ERROR(openCLError);
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_tripcodeChunkArray,                CL_TRUE, 0, sizeof(unsigned int) * numTripcodeChunk, tripcodeChunkArray,                0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_OneByte,              CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_OneByte,              0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_FirstByte,            CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_FirstByte,            0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_SecondByte,           CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_SecondByte,           0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_SecondByteAndOneByte, CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_SecondByteAndOneByte, 0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_smallKeyBitmap,                    CL_TRUE, 0, SMALL_KEY_BITMAP_SIZE,                   smallKeyBitmap,                    0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyBitmap,                         CL_TRUE, 0, KEY_BITMAP_SIZE,                         keyBitmap,                         0, NULL, NULL));

	// The main loop of the thread. 
	double       timeElapsed = 0;
	double       numGeneratedTripcodes = 0;
	double       averageSpeed = 0;
	DWORD        startingTime = timeGetTime();
	DWORD        endingTime;
	double       deltaTime;
	while (!GetTerminationState()) {
		// Choose a random key.
		SetCharactersInTripcodeKeyForSHA1Tripcode(key);
		while (TRUE) {
			key[7] = ((key[7] & 0xfc) | 0x00); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
			key[7] = ((key[7] & 0xfc) | 0x01); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
			key[7] = ((key[7] & 0xfc) | 0x02); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
			key[7] = ((key[7] & 0xfc) | 0x03); if (!IsValidKey(key)) { SetCharactersInTripcodeKeyForSHA1Tripcode(key); continue; }
			break;
		}
		for (int i = 0; i < 4; ++i)
			key[i] = RandomByte();
		key[11] = RandomByte();

		// Execute the OpenCL kernel
		OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_key, CL_TRUE, 0, sizeof(key), key, 0, NULL, NULL));
		OPENCL_ERROR(clSetKernelArg(kernel, 0, sizeof(cl_mem),       (void *)&openCL_outputArray));
		OPENCL_ERROR(clSetKernelArg(kernel, 1, sizeof(cl_mem),       (void *)&openCL_key));
		OPENCL_ERROR(clSetKernelArg(kernel, 2, sizeof(cl_mem),       (void *)&openCL_tripcodeChunkArray));
		OPENCL_ERROR(clSetKernelArg(kernel, 3, sizeof(unsigned int), (void *)&numTripcodeChunk));
		OPENCL_ERROR(clSetKernelArg(kernel, 4, sizeof(cl_mem),       (void *)&openCL_keyCharTable_OneByte));
		OPENCL_ERROR(clSetKernelArg(kernel, 5, sizeof(cl_mem),       (void *)&openCL_keyCharTable_FirstByte));
		OPENCL_ERROR(clSetKernelArg(kernel, 6, sizeof(cl_mem),       (void *)&openCL_keyCharTable_SecondByte));
		OPENCL_ERROR(clSetKernelArg(kernel, 7, sizeof(cl_mem),       (void *)&openCL_keyCharTable_SecondByteAndOneByte));
		OPENCL_ERROR(clSetKernelArg(kernel, 8, sizeof(cl_mem),       (void *)&openCL_smallKeyBitmap));
		OPENCL_ERROR(clSetKernelArg(kernel, 9, sizeof(cl_mem),       (void *)&openCL_keyBitmap));
		// printf("globalWorkSize = [%u]\n", globalWorkSize);
		// printf("localWorkSize  = [%u]\n", localWorkSize);
		// size_t sizeWorkGroup;
		// OPENCL_ERROR(clGetKernelWorkGroupInfo(kernel, deviceID, CL_KERNEL_WORK_GROUP_SIZE, sizeof(size_t), &sizeWorkGroup, NULL));
		// printf("sizeWorkGroup  = [%u]\n", sizeWorkGroup);
		OPENCL_ERROR(clEnqueueNDRangeKernel(commandQueue, kernel, 1, NULL, &globalWorkSize, &localWorkSize, 0, NULL, NULL));
		OPENCL_ERROR(clEnqueueReadBuffer(commandQueue, openCL_outputArray, CL_TRUE, 0, sizeOutputArray * sizeof(GPUOutput), outputArray, 0, NULL, NULL));
	    OPENCL_ERROR(clFlush (commandQueue));
	    OPENCL_ERROR(clFinish(commandQueue));
		numGeneratedTripcodes += ProcessGPUOutput(key, outputArray, sizeOutputArray, TRUE);

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
				numWorkGroupsPerComputeUnit,
				localWorkSize);
		UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), status);
	}
 
    // Clean up.
    OPENCL_ERROR(clFlush(commandQueue));
    OPENCL_ERROR(clFinish(commandQueue));
    OPENCL_ERROR(clReleaseKernel(kernel));
    OPENCL_ERROR(clReleaseProgram(program));
    OPENCL_ERROR(clReleaseMemObject(openCL_outputArray));
    OPENCL_ERROR(clReleaseMemObject(openCL_key));
    OPENCL_ERROR(clReleaseMemObject(openCL_tripcodeChunkArray));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_OneByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_FirstByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_SecondByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_SecondByteAndOneByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_smallKeyBitmap));
    OPENCL_ERROR(clReleaseCommandQueue(commandQueue));
    OPENCL_ERROR(clReleaseContext(context));
}

