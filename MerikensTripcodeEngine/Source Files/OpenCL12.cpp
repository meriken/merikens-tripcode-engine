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
	size_t  numWorkItemsPerComputeUnit_SHA1;
	size_t  localWorkSize_SHA1;

	char   *sourceFile_DES;
	size_t  numWorkItemsPerComputeUnit_DES;
	size_t  localWorkSize_DES;
	char   *buildOptions_DES;
} static deviceSettingsArray[] = {
	{OPENCL_VENDOR_AMD,    "Cedar",                      2, "Radeon HD 5450",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Redwood",                    4, "Radeon HD 5550",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Redwood",                    5, "Radeon HD 5570/5670",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Juniper",                    9, "Radeon HD 5750",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Juniper",                   10, "Radeon HD 5770",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"}, // measured
	{OPENCL_VENDOR_AMD,    "Cypress",                   14, "Radeon HD 5830",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Cypress",                   18, "Radeon HD 5850",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Cypress",                   20, "Radeon HD 5870",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 5120,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"}, // reported
	{OPENCL_VENDOR_AMD,    "Hemlock",                   -1, "Radeon HD 5970",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 5120,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},

	{OPENCL_VENDOR_AMD,    "Saymour",                    2, "Radeon HD 6400M Series", "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Caicos",                     2, "Radeon HD 6450",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Turks",                      6, "Radeon HD 6570/6670",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Whistler",                   6, "Radeon HD 6700M Series", "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Barts",                     10, "Radeon HD 6790",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Barts",                     12, "Radeon HD 6850",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Barts",                     14, "Radeon HD 6870",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Blackcomb",                 12, "Radeon HD 6950M",        "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Cayman",                    22, "Radeon HD 6950",         "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Cayman",                    -1, "Radeon HD 6970/6990",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},

	{OPENCL_VENDOR_AMD,    "Verde",                      8, "Radeon HD 7750",         "OpenCL\\OpenCL12.cl",            16384, 256, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Verde",                     10, "Radeon HD 7770",         "OpenCL\\OpenCL12.cl",            16384, 256, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Pitcairn",                  16, "Radeon HD 7850",         "OpenCL\\OpenCL12.cl",            16384, 256, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Pitcairn",                  20, "Radeon HD 7870",         "OpenCL\\OpenCL12.cl",            16384, 256, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Tahiti",                    28, "Radeon HD 7950",         "OpenCL\\OpenCL12.cl",            16384, 256, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Tahiti",                    32, "Radeon HD 7970/7990",    "OpenCL\\OpenCL12.cl",            16384, 256, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"}, // measured

	{OPENCL_VENDOR_AMD,    "Hawaii",                    40, "Radeon R9 290",          "OpenCL\\OpenCL12.cl",            16384, 256, "OpenCL\\OpenCL10.cl",  640, 256, "-O1 -cl-mad-enable"}, // measured
	{OPENCL_VENDOR_AMD,    "Hawaii",                    44, "Radeon R9 290X",         "OpenCL\\OpenCL12.cl",            16384, 256, "OpenCL\\OpenCL10.cl",  640, 256, "-O1 -cl-mad-enable"}, // measured

	{OPENCL_VENDOR_AMD,    "Desna",                     -1, "Z-series",               "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Ontario",                   -1, "C/G-series",             "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Zacate",                    -1, "E/G-series",             "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Llano",                     -1, "A8/A6/A4/E2-series",     "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Hondo",                     -1, "Z-series",               "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Brazos",                    -1, "E2-series",              "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Trinity",                   -1, "A10/A8/A6/A4-series",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},
	{OPENCL_VENDOR_AMD,    "Devastator",                -1, "A10/A8/A6/A4-series",    "OpenCL\\OpenCL12_AMD_pre-GCN.cl", 2560,  64, "OpenCL\\OpenCL10.cl", 1024, 128, "-O1 -cl-mad-enable"},

	{OPENCL_VENDOR_AMD,    NULL,                        -1, NULL,                     "OpenCL\\OpenCL12.cl",            16384, 256, "OpenCL\\OpenCL10.cl",  512, 256, "-O1 -cl-mad-enable"},

	{OPENCL_VENDOR_NVIDIA, NULL,                        -1, NULL,                     "OpenCL\\OpenCL12.cl",              512, 256, "OpenCL\\OpenCL10.cl",  512, 128, ""},

	{OPENCL_VENDOR_INTEL,  "Intel(R) HD Graphics 2500", -1, NULL,                     "OpenCL\\OpenCL12.cl",              512, 256, "OpenCL\\OpenCL10.cl",  512, 128, ""},
	{OPENCL_VENDOR_INTEL,  "Intel(R) HD Graphics 4000", -1, NULL,                     "OpenCL\\OpenCL12.cl",              512, 256, "OpenCL\\OpenCL10.cl",  512, 128, ""}, // measured

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

void GetParametersForOpenCLDevice(cl_device_id deviceID, char *sourceFile, size_t *numWorkItemsPerComputeUnit, size_t *localWorkSize, char *buildOptions)
{
	cl_uint numComputeUnits;

	*numWorkItemsPerComputeUnit = OPENCL_SHA1_DEFAULT_NUM_WORK_ITEMS_PER_COMPUTE_UNIT;
	*localWorkSize               = OPENCL_SHA1_DEFAULT_NUM_WORK_ITEMS_PER_WORK_GROUP;
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
			*numWorkItemsPerComputeUnit = (lenTripcode == 12) ? (deviceSettingsArray[i].numWorkItemsPerComputeUnit_SHA1) : (deviceSettingsArray[i].numWorkItemsPerComputeUnit_DES);
			*localWorkSize               = (lenTripcode == 12) ? (deviceSettingsArray[i].localWorkSize_SHA1              ) : (deviceSettingsArray[i].localWorkSize_DES              );
			break;
		}
	}
	if (options.openCLNumWorkItemsPerCU != OPENCL_NUM_NUM_WORK_ITEMS_PER_CU_NIL)
		*numWorkItemsPerComputeUnit = options.openCLNumWorkItemsPerCU;
	if (options.openCLNumWorkItemsPerWG  != OPENCL_NUM_WORK_ITEMS_PER_WG_NIL)
		*localWorkSize = options.openCLNumWorkItemsPerWG;
}

void Thread_RunChildProcessForOpenCLDevice(OpenCLDeviceSearchThreadInfo *info)
{
	// This thread may be restarted. See CheckSearchThreads().
	double       prevTotalNumGeneratedTripcodes = info->totalNumGeneratedTripcodes;
	unsigned int prevNumDiscardedTripcodes      = info->numDiscardedTripcodes;
	
	char   status[LEN_LINE_BUFFER_FOR_SCREEN] = "";

	size_t  numWorkItemsPerComputeUnit = OPENCL_SHA1_DEFAULT_NUM_WORK_ITEMS_PER_COMPUTE_UNIT;
	size_t  localWorkSize = OPENCL_SHA1_DEFAULT_NUM_WORK_ITEMS_PER_WORK_GROUP;
	GetParametersForOpenCLDevice(info->openCLDeviceID, NULL, &numWorkItemsPerComputeUnit, &localWorkSize, NULL);

	char commandLine[MAX_LEN_COMMAND_LINE + 1];
	sprintf(commandLine,
	        "\"%s\" --output-for-redirection --disable-tripcode-checks -l %d -g -d %d -y %d -z %d -a %d -b 1",
			applicationPath,
			lenTripcode,
			info->deviceNo,
			numWorkItemsPerComputeUnit,
			localWorkSize,
			options.openCLNumThreads);
	for (int patternFileIndex = 0; patternFileIndex < numPatternFiles; ++patternFileIndex) {
		strcat(commandLine, " -f ");
		strcat(commandLine, patternFilePathArray[patternFileIndex]);
	}
	if (options.useOneByteCharactersForKeys)
		strcat(commandLine, " --use-one-byte-characters-for-keys");
	if (strlen(nameMutexForPausing) > 0) {
		strcat(commandLine, " -e ");
		strcat(commandLine, nameMutexForPausing);
	}
	if (strlen(nameEventForTerminating) > 0) {
		strcat(commandLine, " -E ");
		strcat(commandLine, nameEventForTerminating);
	}
	// printf("commandLine: %s\n", commandLine);

	HANDLE hChildProcess = NULL;
	HANDLE hStdIn = NULL; // Handle to parents std input.
	BOOL   bRunThread = TRUE;
   
	HANDLE hOutputReadTmp,hOutputRead,hOutputWrite;
	HANDLE hInputWriteTmp,hInputRead,hInputWrite;
	HANDLE hErrorWrite;
	HANDLE hThread;
	DWORD  ThreadId;
	SECURITY_ATTRIBUTES securityAttributes;

	securityAttributes.nLength= sizeof(SECURITY_ATTRIBUTES);
	securityAttributes.lpSecurityDescriptor = NULL;
	securityAttributes.bInheritHandle = TRUE;
	ERROR0(!CreatePipe(&hOutputReadTmp, &hOutputWrite,   &securityAttributes, 0), ERROR_CHILD_PROCESS, "CreatePipe");
	ERROR0(!CreatePipe(&hInputRead,     &hInputWriteTmp, &securityAttributes, 0), ERROR_CHILD_PROCESS, "CreatePipe");
	ERROR0(!DuplicateHandle(GetCurrentProcess(), hOutputWrite,   GetCurrentProcess(), &hErrorWrite, 0, TRUE,  DUPLICATE_SAME_ACCESS), ERROR_CHILD_PROCESS, "DuplicateHandle");
	ERROR0(!DuplicateHandle(GetCurrentProcess(), hOutputReadTmp, GetCurrentProcess(), &hOutputRead, 0, FALSE, DUPLICATE_SAME_ACCESS), ERROR_CHILD_PROCESS, "DupliateHandle");
	ERROR0(!DuplicateHandle(GetCurrentProcess(), hInputWriteTmp, GetCurrentProcess(), &hInputWrite, 0, FALSE, DUPLICATE_SAME_ACCESS), ERROR_CHILD_PROCESS, "DupliateHandle");
	ERROR0(!CloseHandle(hOutputReadTmp), ERROR_CHILD_PROCESS, "CloseHandle");
	ERROR0(!CloseHandle(hInputWriteTmp), ERROR_CHILD_PROCESS, "CloseHandle");
	ERROR0((hStdIn = GetStdHandle(STD_INPUT_HANDLE)) == INVALID_HANDLE_VALUE, ERROR_CHILD_PROCESS, "GetStdHandle");

	PROCESS_INFORMATION processInfo;
	STARTUPINFO startupInfo;
	ZeroMemory(&startupInfo, sizeof(STARTUPINFO));
	startupInfo.cb         = sizeof(STARTUPINFO);
	startupInfo.dwFlags    = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW;
	startupInfo.hStdOutput = hOutputWrite;
	startupInfo.hStdInput  = hInputRead;
	startupInfo.hStdError  = hErrorWrite;
	startupInfo.wShowWindow =  /* SW_SHOW */ SW_HIDE;
	WCHAR commandLineWC[MAX_LEN_COMMAND_LINE + 1];
	MultiByteToWideChar(CP_ACP, 0, commandLine, -1, commandLineWC, MAX_LEN_COMMAND_LINE);
	ERROR0(!CreateProcess(NULL, commandLineWC, NULL, NULL, TRUE, CREATE_NEW_CONSOLE, NULL, NULL, &startupInfo, &processInfo), ERROR_CHILD_PROCESS, "CreateProcess");
	hChildProcess = processInfo.hProcess;
	UpdateOpenCLDeviceStatus_ChildProcess(((OpenCLDeviceSearchThreadInfo *)info), "[process] Started child process.", 0, 0, 0, 0, hChildProcess);

	// Close pipe handles.
	ERROR0(!CloseHandle(processInfo.hThread), ERROR_CHILD_PROCESS, "CloseHandle");
	ERROR0(!CloseHandle(hOutputWrite       ), ERROR_CHILD_PROCESS, "CloseHandle");
	ERROR0(!CloseHandle(hInputRead         ), ERROR_CHILD_PROCESS, "CloseHandle");
	ERROR0(!CloseHandle(hErrorWrite        ), ERROR_CHILD_PROCESS, "CloseHandle");

	// Launch the thread that gets the input and sends it to the child.
	// hThread = CreateThread(NULL,0,GetAndSendInputThread,
	// 						(LPVOID)hInputWrite,0,&ThreadId);
	// if (hThread == NULL) DisplayError("CreateThread");

	CHAR  lpBuffer[LEN_LINE_BUFFER_FOR_SCREEN];
	DWORD nBytesRead;
	DWORD nCharsWritten;

	while(!GetTerminationState())
	{
		// This line does not work well.
		// We restart the child process in () instead.
		// ERROR0(WaitForSingleObject(hChildProcess, 0) != WAIT_TIMEOUT, ERROR_CHILD_PROCESS, "A child process terminated unexpectedly.");

		if (!ReadFile(hOutputRead, lpBuffer, sizeof(lpBuffer), &nBytesRead, NULL) || !nBytesRead) {
			if (GetLastError() == ERROR_BROKEN_PIPE)
				break;
			else
				ERROR0(TRUE, ERROR_CHILD_PROCESS, "ReadFile");
		}
		lpBuffer[nBytesRead] = '\0';
		// printf("%s", lpBuffer);
		// ERROR0(!WriteConsole(GetStdHandle(STD_OUTPUT_HANDLE), lpBuffer, nBytesRead, &nCharsWritten,NULL), ERROR_CHILD_PROCESS, "WriteConsole");

		if (strncmp(lpBuffer, "[tripcode],", strlen("[tripcode],")) == 0) {
			unsigned char tripcode[MAX_LEN_TRIPCODE];
			unsigned char key     [MAX_LEN_TRIPCODE_KEY];
			int i, j;
			ASSERT(lpBuffer[10 + 1 + 2 + lenTripcode                         ] == ',');
			ASSERT(lpBuffer[10 + 1 + 2 + lenTripcode + 1                     ] == '#');
			ASSERT(lpBuffer[10 + 1 + 2 + lenTripcode + 1 + 1 + lenTripcodeKey] == ',');
			for (i = 0, j = 10 + 1 + 2; i < lenTripcode; ++i, ++j)
				tripcode[i] = lpBuffer[j];
			for (i = 0, j = 10 + 1 + 2 + lenTripcodeKey + 1 + 1; i < lenTripcodeKey; ++i, ++j)
				key[i] = lpBuffer[j];
			ProcessPossibleMatch(tripcode, key);
		} else if (strncmp(lpBuffer, "[status],", strlen("[status],")) == 0) {
			double       currentSpeed, averageSpeed, totalNumGeneratedTripcodes;
			unsigned int numDiscardedTripcodes;
			char *delimiter = ",";
			char *currentToken = strtok(lpBuffer, delimiter);                                                 //       "[status]"
			currentToken = strtok(NULL, delimiter);                                                           //       totalTime,
			currentToken = strtok(NULL, delimiter); sscanf(currentToken, "%lf", &currentSpeed);               // 	   currentSpeed,
			currentToken = strtok(NULL, delimiter);                                                           // 	   currentSpeed_GPU,
			currentToken = strtok(NULL, delimiter);                                                           // 	   currentSpeed_CPU,
			currentToken = strtok(NULL, delimiter); sscanf(currentToken, "%lf", &averageSpeed);               // 	   averageSpeed,
			currentToken = strtok(NULL, delimiter);                                                           // 	   timeForOneMatch,
			currentToken = strtok(NULL, delimiter);                                                           // 	   (int)(matchingProbDiff * 100),
			currentToken = strtok(NULL, delimiter); sscanf(currentToken, "%lf", &totalNumGeneratedTripcodes); // 	   prevTotalNumGeneratedTripcodes,
			currentToken = strtok(NULL, delimiter);                                                           // 	   prevNumValidTripcodes,
			currentToken = strtok(NULL, delimiter);                                                           // 	   IsCUDADeviceOptimizationInProgress(),
			currentToken = strtok(NULL, delimiter);                                                           // 	   averageSpeed_GPU,
			currentToken = strtok(NULL, delimiter);                                                           // 	   averageSpeed_CPU);
			currentToken = strtok(NULL, delimiter); sscanf(currentToken, "%u",  &numDiscardedTripcodes);      // 	   numDiscardedTripcodes
			sprintf(status,
					"[process] %.1lfM TPS, %d WI/CU, %d WI/WG",
					averageSpeed / 1000000,
					numWorkItemsPerComputeUnit,
					localWorkSize);
			UpdateOpenCLDeviceStatus_ChildProcess(((OpenCLDeviceSearchThreadInfo *)info), 
				                                  status, 
												  currentSpeed, 
												  averageSpeed, 
												  prevTotalNumGeneratedTripcodes + totalNumGeneratedTripcodes, 
												  prevNumDiscardedTripcodes      + numDiscardedTripcodes, 
												  hChildProcess);
		}
	}

	// Force the read on the input to return by closing the stdin handle.
	// ERROR0(!CloseHandle(hStdIn), ERROR_CHILD_PROCESS, "CloseHandle");
	CloseHandle(hStdIn);

	// Tell the thread to exit and wait for thread to die.
	// bRunThread = FALSE;
	// if (WaitForSingleObject(hThread,INFINITE) == WAIT_FAILED)
	//	DisplayError("WaitForSingleObject");

	// ERROR0(!CloseHandle(hOutputRead), ERROR_CHILD_PROCESS, "CloseHandle");
	// ERROR0(!CloseHandle(hInputWrite), ERROR_CHILD_PROCESS, "CloseHandle");
	CloseHandle(hOutputRead);
	CloseHandle(hInputWrite);

	// TO DO: Wait for child processes to exit.
}

unsigned WINAPI Thread_SearchForSHA1TripcodesOnOpenCLDevice(LPVOID info)
{

	cl_int         openCLError;
	cl_device_id   deviceID = ((OpenCLDeviceSearchThreadInfo *)info)->openCLDeviceID;
	cl_uint        numComputeUnits;
	char           status[LEN_LINE_BUFFER_FOR_SCREEN] = "";
	char           buildOptions[MAX_LEN_COMMAND_LINE + 1] = ""; 
	unsigned char  key[MAX_LEN_TRIPCODE + 1];

	if (((OpenCLDeviceSearchThreadInfo *)info)->runChildProcess) {
		Thread_RunChildProcessForOpenCLDevice((OpenCLDeviceSearchThreadInfo *)info);
		return 0;
	}

	// Random wait time between 0 and 10 seconds for increased stability.
	Sleep((DWORD)RandomByte() * 10000 / 256);

	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(numComputeUnits), &numComputeUnits, NULL));
	key[lenTripcode] = '\0';
	
	// Determine the sizes of local and global work items.
	size_t numWorkItemsPerComputeUnit;
	size_t localWorkSize;
	size_t globalWorkSize;
	char   sourceFileName[MAX_LEN_FILE_PATH + 1];
	GetParametersForOpenCLDevice(deviceID, sourceFileName, &numWorkItemsPerComputeUnit, &localWorkSize, buildOptions);
	globalWorkSize = numWorkItemsPerComputeUnit * numComputeUnits;

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
	// strcat(buildOptions, " -save-temps=OpenCL10.cl ");
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
	cl_mem openCL_smallChunkBitmap                    = clCreateBuffer(context, CL_MEM_READ_ONLY,  SMALL_CHUNK_BITMAP_SIZE,                   NULL, &openCLError); OPENCL_ERROR(openCLError);
	cl_mem openCL_chunkBitmap                         = clCreateBuffer(context, CL_MEM_READ_ONLY,  CHUNK_BITMAP_SIZE,                         NULL, &openCLError); OPENCL_ERROR(openCLError);
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_tripcodeChunkArray,                CL_TRUE, 0, sizeof(unsigned int) * numTripcodeChunk, tripcodeChunkArray,                0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_OneByte,              CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_OneByte,              0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_FirstByte,            CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_FirstByte,            0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_SecondByte,           CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_SecondByte,           0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_keyCharTable_SecondByteAndOneByte, CL_TRUE, 0, SIZE_KEY_CHAR_TABLE,                     keyCharTable_SecondByteAndOneByte, 0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_smallChunkBitmap,                    CL_TRUE, 0, SMALL_CHUNK_BITMAP_SIZE,                   smallChunkBitmap,                    0, NULL, NULL));
	OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_chunkBitmap,                         CL_TRUE, 0, CHUNK_BITMAP_SIZE,                         chunkBitmap,                         0, NULL, NULL));

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
		OPENCL_ERROR(clSetKernelArg(kernel, 8, sizeof(cl_mem),       (void *)&openCL_smallChunkBitmap));
		OPENCL_ERROR(clSetKernelArg(kernel, 9, sizeof(cl_mem),       (void *)&openCL_chunkBitmap));
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
    OPENCL_ERROR(clReleaseMemObject(openCL_key));
    OPENCL_ERROR(clReleaseMemObject(openCL_tripcodeChunkArray));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_OneByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_FirstByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_SecondByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_keyCharTable_SecondByteAndOneByte));
    OPENCL_ERROR(clReleaseMemObject(openCL_smallChunkBitmap));
    OPENCL_ERROR(clReleaseCommandQueue(commandQueue));
    OPENCL_ERROR(clReleaseContext(context));
}

