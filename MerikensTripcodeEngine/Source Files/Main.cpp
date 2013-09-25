// Meriken's Tripcode Engine 1.1 Alpha 7
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

#include "MerikensTripcodeEngine.h"



///////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLES, CONSTANTS, AND MACROS                                   //
///////////////////////////////////////////////////////////////////////////////

Options options = {
	DEFAULT_OPTION_GPU_INDEX,                       // int  GPUIndex;
	DEFAULT_OPTION_CUDA_NUM_BLOCKS_PER_SM,          // int  numBlocksPerSM;
	DEFAULT_OPTION_BEEP_WHEN_NEW_TRIPCODE_IS_FOUND, // BOOL beepWhenNewTripcodeIsFound;
	DEFAULT_OPTION_OUTPUT_INVALID_TRIPCODE,         // BOOL outputInvalidTripcode;
	DEFAULT_OPTION_WARN_SPEED_DROP,                 // BOOL warnSpeedDrop;
	DEFAULT_OPTION_SEARCH_DEVICE,                   // int  searchDevice;
	DEFAULT_OPTION_TEST_NEW_CODE,                   // BOOL testNewCode;
	DEFAULT_OPTION_NUM_CPU_SEARCH_THREADS,          // int  numCPUSearchThreads;
	DEFAULT_OPTION_REDIRECTION,                     // BOOL redirection;
	DEFAULT_OPTION_OPENCL_NUM_WORK_GROUPS_PER_CU,   // int  openCLNumWorkGroupsPerCU;
	DEFAULT_OPTION_OPENCL_NUM_WORK_ITEMS_PER_WG,    // int  openCLNumWorkItemsPerWG;
	DEFAULT_OPTION_OPENCL_NUM_THREADS_PER_AMD_GPU,  // int  openCLNumThreads;
	DEFAULT_OPTION_OPENCL_RUN_CHILD_PROCESSES_FOR_MULTIPLE_DEVICES, // BOOL openCLRunChildProcesses;
	DEFAULT_OPTION_OPENCL_NUM_PROCESSES_PER_AMD_GPU, // int  openCLNumProcesses;
	DEFAULT_OPTION_USE_ONE_BYTE_CHARACTERS_FOR_KEYS, // BOOL useOneByteCharactersForKeys;
	DEFAULT_OPTION_SEARCH_FOR_HISEKI_ON_CPU,
	DEFAULT_OPTION_SEARCH_FOR_KAKUHI_ON_CPU,
	DEFAULT_OPTION_SEARCH_FOR_KAIBUN_ON_CPU,
	DEFAULT_OPTION_SEARCH_FOR_YAMABIKO_ON_CPU,
	DEFAULT_OPTION_SEARCH_FOR_SOUREN_ON_CPU,
	DEFAULT_OPTION_SEARCH_FOR_KAGAMI_ON_CPU,
	DEFAULT_OPTION_USE_OPENCL_FOR_CUDA_DEVICES,
	DEFAULT_OPTION_IS_AVX_ENABLED,
	DEFAULT_OPTION_USE_ONLY_ASCII_CHARACTERS_FOR_KEYS,
	DEFAULT_OPTION_MAXIMIZE_KEY_SPACE,
};

// Search Parameters
int  lenTripcode    = 12;
int  lenTripcodeKey = 12;

// Application path
char applicationPath     [MAX_LEN_FILE_PATH + 1];
char applicationDirectory[MAX_LEN_FILE_PATH + 1];

// Input and output files
int   numPatternFiles = 0;
char  patternFilePathArray[MAX_NUM_PATTERN_FILES][MAX_LEN_FILE_PATH + 1];
char  tripcodeFilePath    [MAX_LEN_FILE_PATH + 1];
FILE *tripcodeFile = NULL;

// Inter process communication
char         nameMutexForPausing      [MAX_LEN_INPUT_LINE + 1] =  "";
static WCHAR nameMutexForPausingWC    [MAX_LEN_INPUT_LINE + 1] = L"";
char         nameEventForTerminating  [MAX_LEN_INPUT_LINE + 1] =  "";
static WCHAR nameEventForTerminatingWC[MAX_LEN_INPUT_LINE + 1] = L"";

// GPUs
int           CUDADeviceCount   = 0;
int           openCLDeviceCount = 0;
cl_device_id *openCLDeviceIDArray = NULL;
int           searchDevice = SEARCH_DEVICE_NIL;

// Character tables
int numFirstByte  = 0;
int numSecondByte = 0;
int numOneByte   = 0;
unsigned char keyCharTable_OneByte             [SIZE_KEY_CHAR_TABLE];
unsigned char keyCharTable_FirstByte           [SIZE_KEY_CHAR_TABLE];
unsigned char keyCharTable_SecondByte          [SIZE_KEY_CHAR_TABLE];
unsigned char keyCharTable_SecondByteAndOneByte[SIZE_KEY_CHAR_TABLE];
char base64CharTable[64] = {
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
	'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
	'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
	'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '/',
};

// Current and previous status
double       matchingProb,     numAverageTrialsForOneMatch;
mpf_t        matchingProb_mpf, numAverageTrialsForOneMatch_mpf;
double       totalTime = 0;
double       currentSpeed_thisProcess = 0, currentSpeed_thisProcess_GPU = 0, currentSpeed_CPU = 0, maximumSpeed = 0;
unsigned int     numValidTripcodes = 0,     numDiscardedTripcodes = 0;
unsigned int prevNumValidTripcodes = 0, prevNumDiscardedTripcodes = 0;
double           totalNumGeneratedTripcodes = 0;
double           totalNumGeneratedTripcodes_GPU = 0;
double           totalNumGeneratedTripcodes_CPU = 0;
double       prevTotalNumGeneratedTripcodes = 0;
double       prevTotalNumGeneratedTripcodes_GPU = 0;
double       prevTotalNumGeneratedTripcodes_CPU = 0;
BOOL         isSearchPaused      = FALSE;
BOOL         wasSearchTerminated = FALSE;
HANDLE       eventForTerminating = NULL;



// Search mode
int searchMode = SEARCH_MODE_NIL;

// For multi-threading
int                                  numCUDADeviceSearchThreads        = 0;
struct CUDADeviceSearchThreadInfo   *CUDADeviceSearchThreadInfoArray   = NULL;
HANDLE                              *CUDADeviceSearchThreadArray       = NULL;
int                                  numOpenCLDeviceSearchThreads      = 0;
struct OpenCLDeviceSearchThreadInfo *openCLDeviceSearchThreadInfoArray = NULL;
HANDLE                              *openCLDeviceSearchThreadArray     = NULL;
int                                  numCPUSearchThreads               = 0;
HANDLE                              *CPUSearchThreadArray              = NULL;
BOOL                                 openCLRunChildProcesses = FALSE;
CRITICAL_SECTION criticalSection_numGeneratedTripcodes;
CRITICAL_SECTION criticalSection_ProcessTripcodePair;
CRITICAL_SECTION criticalSection_currentState;
CRITICAL_SECTION criticalSection_CUDADeviceSearchThreadInfoArray;
CRITICAL_SECTION criticalSection_openCLDeviceSearchThreadInfoArray;
unsigned int     numGeneratedTripcodes_GPU;
unsigned int     numGeneratedTripcodesByGPUInMillions;
unsigned int     numGeneratedTripcodes_CPU;
unsigned int     numGeneratedTripcodesByCPUInMillions;



///////////////////////////////////////////////////////////////////////////////
// FUNCTIONS                                                                 //
///////////////////////////////////////////////////////////////////////////////

unsigned char RandomByte()
{
	unsigned int randomValue;

	rand_s(&randomValue);
	return (unsigned char)(randomValue & 0x000000ff);
}

void ReleaseResources()
{
	RELEASE_AND_SET_TO_NULL(expandedPatternArray, free);
	RELEASE_AND_SET_TO_NULL(tripcodeChunkArray,   free);
	RELEASE_AND_SET_TO_NULL(keyBitmap,            free);
	RELEASE_AND_SET_TO_NULL(smallKeyBitmap,       free);
	RELEASE_AND_SET_TO_NULL(regexPatternArray,    free);
	if (tripcodeFile) {
		RELEASE_AND_SET_TO_NULL(tripcodeFile,     fclose);
	}
	if (eventForTerminating) {
		CloseHandle(eventForTerminating);
		eventForTerminating = NULL;
	}
}

void PrintUsage()
{
	printf("Usage: %s [-c] [-g] [-d device_no] [-x blocks_per_SM] [-y global_work_size] [-z local_work_size] [-o tripcode_file] [-f pattern_file] [-i] [-w]\n", COMMAND);
	getchar();
	exit(-1);
}

void HideCursor()
{
	CONSOLE_CURSOR_INFO info;
	
	info.bVisible = false;
	info.dwSize = 100;
	SetConsoleCursorInfo((HWND)GetStdHandle(STD_OUTPUT_HANDLE), &info); 
}

void ShowCursor()
{
	CONSOLE_CURSOR_INFO info;
	
	info.bVisible = true;
	info.dwSize = 100;
	SetConsoleCursorInfo((HWND)GetStdHandle(STD_OUTPUT_HANDLE), &info); 
}

void ResetCursorPos(int deltaY)
{
    CONSOLE_SCREEN_BUFFER_INFO scrnBufInfo;
    COORD                      cursorPos;
	if (!GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &scrnBufInfo))
		return;
    cursorPos.X = 0;
	cursorPos.Y = (scrnBufInfo.dwCursorPosition.Y + deltaY) >= 0
	                  ? (scrnBufInfo.dwCursorPosition.Y + deltaY)
	                  : 0;
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), cursorPos);
}

double ProcessGPUOutput(unsigned char *partialKey, GPUOutput *outputArray, unsigned int sizeOutputArray, BOOL newFormat)
{
	unsigned char  tripcode[MAX_LEN_TRIPCODE     + 1];
	unsigned char  key     [MAX_LEN_TRIPCODE_KEY + 1];
	double numGeneratedTripcodesInThisOutput = 0;
	
	tripcode[lenTripcode   ] = '\0';
	key     [lenTripcodeKey] = '\0';
	memcpy(key, partialKey, lenTripcodeKey);
	for (unsigned int indexOutput = 0; indexOutput < sizeOutputArray; indexOutput++){
		GPUOutput *output = &outputArray[indexOutput];
		AddToNumGeneratedTripcodesByGPU(output->numGeneratedTripcodes);
		numGeneratedTripcodesInThisOutput += output->numGeneratedTripcodes;
		if (output->numMatchingTripcodes > 0) {
			memcpy(tripcode, output->pair.tripcode.c, lenTripcode);
			if (lenTripcode == 12 && newFormat) {
				memcpy(key, output->pair.key.c, 4);
				key[7]  = output->pair.key.c[7];
				key[11] = output->pair.key.c[11];
			} else if (lenTripcode == 12) {
				memcpy(key + 7,  output->pair.key.c + 7, lenTripcode - 7);
			} else {
				ASSERT(lenTripcode == 10);
				memcpy(key + 2,  output->pair.key.c + 2, lenTripcode - 2);
				if (options.useOneByteCharactersForKeys) {
					key[8] = keyCharTable_OneByte[RandomByte()];
					key[9] = keyCharTable_OneByte[RandomByte()];
				} else {
					BOOL isSecondByte = FALSE;
					for (int i = 0; i < 8; ++i) {
						if (!isSecondByte) {
							isSecondByte = IS_FIRST_BYTE_SJIS_FULL(key[i]);
						} else {
							isSecondByte = FALSE;
						}
					}
					if (isSecondByte) {
						key[8] = keyCharTable_SecondByte[RandomByte()];
						key[9] = keyCharTable_OneByte   [RandomByte()];
					} else {
						key[8] = keyCharTable_FirstByte[RandomByte()];
						key[9] = (IS_FIRST_BYTE_SJIS_FULL(key[8]))
									 ? keyCharTable_SecondByte[RandomByte()]
									 : keyCharTable_OneByte   [RandomByte()];
					}
				}
			}
			// printf("{%s, %s}\n", tripcode, key);
			ProcessPossibleMatch(tripcode, key);
		}
	}
	return numGeneratedTripcodesInThisOutput;
}

BOOL IsValidKey(unsigned char *key)
{
	int i;
	BOOL isSecondByteSJIS = FALSE;
	char results[13] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
	
	if (key[0] == '#' || key[0] == '$') {
#ifdef DEBUG_PRINT_INVALID_KEY_INFO
		printf("  results: %c                                                     \n", key[0]);
#endif
		return FALSE;
	}

	for (i = 0; i < lenTripcode; ++i) {
		if (!isSecondByteSJIS && IS_ONE_BYTE_KEY_CHAR(key[i])) {
			// Don't do anything
			results[i] = 'O';
		} else if (!isSecondByteSJIS && i < lenTripcode - 1 && IS_FIRST_BYTE_SJIS_FULL(key[i])) {
			isSecondByteSJIS = TRUE;
			results[i] = '1';
		} else if (isSecondByteSJIS && IS_SECOND_BYTE_SJIS(key[i])) {
		    isSecondByteSJIS = FALSE;
		    if (!IS_VALID_SJIS_CHAR(key[i - 1], key[i])) {
#ifdef DEBUG_PRINT_INVALID_KEY_INFO
				printf("  results: %sx                                                     \n", results);
				printf("  key[%2d]: 0x%02x ('%c')                                            \n", i, key[i], key[i]);
#endif
				return FALSE;
			}
			results[i] = '2';
		} else {
#ifdef DEBUG_PRINT_INVALID_KEY_INFO
			printf("  results: %sX                                                     \n", results);
			printf("  key[%2d]: 0x%02x ('%c')                                            \n", i, key[i], key[i]);
#endif
			return FALSE;
		}
	}
	return TRUE;
}

void CreateCharacterTables(void)
{
	unsigned char keyChar;
	int i;

#if FALSE
	for (i = 0; i < 64; ++i)
		base64CharTable[i] = i + ((i < 26) ?  'A'       :
		                          (i < 52) ? ('a' - 26) :
		                          (i < 62) ? ('0' - 52) :
		                                     ('.' - 62));
#endif

	numFirstByte = numSecondByte = numOneByte = 0;

	// Set keyCharTable_OneByte[]
	if (options.useOnlyASCIICharactersForKeys) {
		do {
			keyChar = RandomByte();
		} while (!IS_ASCII_KEY_CHAR(keyChar));
		for (i = 0; i < SIZE_KEY_CHAR_TABLE; ++i) {
			keyChar = ((int)keyChar + 1) & 0xff;
			while (!IS_ASCII_KEY_CHAR(keyChar))
				keyChar = ((int)keyChar + 1) & 0xff;
			keyCharTable_OneByte[i] = keyChar;
		}
	} else {
		do {
			keyChar = RandomByte();
		} while (!IS_ONE_BYTE_KEY_CHAR(keyChar));
		for (i = 0; i < SIZE_KEY_CHAR_TABLE; ++i) {
			keyChar = ((int)keyChar + 1) & 0xff;
			while (!IS_ONE_BYTE_KEY_CHAR(keyChar))
				keyChar = ((int)keyChar + 1) & 0xff;
			keyCharTable_OneByte[i] = keyChar;
		}
	}

	// Set keyCharTable_FirstByte[], keyCharTable_SecondByte[], and keyCharTable_SecondByteAndOneByte[].
	if (options.useOnlyASCIICharactersForKeys) {
		for (i = 0; i < SIZE_KEY_CHAR_TABLE; ++i) {
			keyCharTable_FirstByte [i]           = keyCharTable_OneByte[i];
			keyCharTable_SecondByte[i]           = keyCharTable_OneByte[i];
			keyCharTable_SecondByteAndOneByte[i] = keyCharTable_OneByte[i];
		}
		for (int i = 0; i < 256; ++i) {
			if (IS_ASCII_KEY_CHAR(i)) {
				++numFirstByte;
				++numSecondByte;
				++numOneByte;
			}
		}
	} else if (options.useOneByteCharactersForKeys) {
		for (i = 0; i < SIZE_KEY_CHAR_TABLE; ++i) {
			keyCharTable_FirstByte           [i] = keyCharTable_OneByte[i];
			keyCharTable_SecondByte          [i] = keyCharTable_OneByte[i];
			keyCharTable_SecondByteAndOneByte[i] = keyCharTable_OneByte[i];
		}
		for (int i = 0; i < 256; ++i) {
			if (IS_ONE_BYTE_KEY_CHAR(i)) {
				++numFirstByte;
				++numSecondByte;
				++numOneByte;
			}
		}
	} else {
		// Set keyCharTable_FirstByte[].
		do {
			keyChar = RandomByte();
		} while (!(IS_ONE_BYTE_KEY_CHAR(keyChar) || IsFirstByteSJIS(keyChar)));
		for (i = 0; i < SIZE_KEY_CHAR_TABLE; ++i) {
			keyCharTable_FirstByte[i] = keyChar;
			do {
				keyChar = ((int)keyChar + 1) & 0xff;
			} while (!(IS_ONE_BYTE_KEY_CHAR(keyChar) || IsFirstByteSJIS(keyChar)));
		}

		// Set keyCharTable_SecondByte[].
		do {
			keyChar = RandomByte();
		} while (!IS_SECOND_BYTE_SJIS(keyChar));
		for (i = 0; i < SIZE_KEY_CHAR_TABLE; ++i) {
			keyCharTable_SecondByte[i] = keyChar;
			do {
				keyChar = ((int)keyChar + 1) & 0xff;
			} while (!IS_SECOND_BYTE_SJIS(keyChar));
		}

		// Set keyCharTable_SecondByteAndOneByte[].
		do {
			keyChar = RandomByte();
		} while (!(IS_SECOND_BYTE_SJIS(keyChar) && IS_ONE_BYTE_KEY_CHAR(keyChar)));
		for (i = 0; i < SIZE_KEY_CHAR_TABLE; ++i) {
			keyCharTable_SecondByteAndOneByte[i] = keyChar;
			do {
				keyChar = ((int)keyChar + 1) & 0xff;
			} while (!(IS_SECOND_BYTE_SJIS(keyChar) && IS_ONE_BYTE_KEY_CHAR(keyChar)));
		}

		// Count characters in each table.
		for (int i = 0; i < 256; ++i) {
			if (IS_ONE_BYTE_KEY_CHAR(i) || IsFirstByteSJIS(i) ) ++numFirstByte;
			if (                           IS_SECOND_BYTE_SJIS(i)) ++numSecondByte;
			if (IS_ONE_BYTE_KEY_CHAR(i)                          ) ++numOneByte;
		}
	}
#if FALSE
	printf("numFirstByte  = %d\n", numFirstByte);
	printf("numSecondByte = %d\n", numSecondByte);
	printf("numOneByte    = %d\n", numOneByte);
#endif
}

void DisplayCopyrights()
{
	printf("%s\n", PRODUCT_NAME);
	printf("[compiled at %s on %s (PST)]\n", __TIME__, __DATE__);
#ifdef ENGLISH_VERSION
	printf("Copyright (C) 2013 Meriken <meriken.2ch@gmail.com>\n");
#else
	printf("Copyright (C) 2011-13 %c%cMeriken//XXX <meriken.2ch@gmail.com>\n", 0x81, 0x9f);
#endif
	printf("This program comes with ABSOLUTELY NO WARRANTY.\n");
    printf("This is free software, and you are welcome to redistribute it\n");
    printf("under certain conditions.\n");
    printf("\n");
}

void UpdateCUDADeviceStatus(struct CUDADeviceSearchThreadInfo *info, BOOL isOptimizationInProgress, char *status)
{
	EnterCriticalSection(&criticalSection_CUDADeviceSearchThreadInfoArray);
	info->isOptimizationInProgress = isOptimizationInProgress;
	strcpy(info->status, status);
	LeaveCriticalSection(&criticalSection_CUDADeviceSearchThreadInfoArray);
}

void UpdateOpenCLDeviceStatus(struct OpenCLDeviceSearchThreadInfo *info, char *status)
{
	EnterCriticalSection(&criticalSection_openCLDeviceSearchThreadInfoArray);
	ASSERT(!info->runChildProcess);
	strcpy(info->status, status);
	LeaveCriticalSection(&criticalSection_openCLDeviceSearchThreadInfoArray);
}

void UpdateOpenCLDeviceStatus_ChildProcess(struct OpenCLDeviceSearchThreadInfo *info, char *status, double currentSpeed, double averageSpeed, double totalNumGeneratedTripcodes, unsigned int numDiscardedTripcodes)
{
	EnterCriticalSection(&criticalSection_openCLDeviceSearchThreadInfoArray);
	ASSERT(info->runChildProcess);
	strcpy(info->status, status);
	info->currentSpeed = currentSpeed;
	info->averageSpeed = averageSpeed;
	info->totalNumGeneratedTripcodes = totalNumGeneratedTripcodes;
	info->numDiscardedTripcodes = numDiscardedTripcodes;
	LeaveCriticalSection(&criticalSection_openCLDeviceSearchThreadInfoArray);
}

BOOL IsCUDADeviceOptimizationInProgress()
{
	BOOL ret = FALSE;
	EnterCriticalSection(&criticalSection_CUDADeviceSearchThreadInfoArray);
	for (int i = 0; i < numCUDADeviceSearchThreads; ++i) {
		if (CUDADeviceSearchThreadInfoArray[i].isOptimizationInProgress) {
			ret = TRUE;
			break;
		}
	}
	LeaveCriticalSection(&criticalSection_CUDADeviceSearchThreadInfoArray);
	return ret;
}

void PrintStatus()
{
	EnterCriticalSection(&criticalSection_currentState);
	EnterCriticalSection(&criticalSection_openCLDeviceSearchThreadInfoArray);

	char msg[MAX_NUM_LINES_STATUS_MSG][LEN_LINE_BUFFER_FOR_SCREEN];
	int lineCount = 0;
	
#define NEXT_LINE &(msg[lineCount++][0])

	sprintf(NEXT_LINE, "%-79s", "");
	sprintf(NEXT_LINE, "%-79s", "STATUS");
	sprintf(NEXT_LINE, "%-79s", "======");
	sprintf(NEXT_LINE, "  Performing a %s search on %s",
			(searchMode == SEARCH_MODE_FORWARD_MATCHING             ) ? "forward-matching"  :
			(searchMode == SEARCH_MODE_BACKWARD_MATCHING            ) ? "backward-matching" :
			(searchMode == SEARCH_MODE_FORWARD_AND_BACKWARD_MATCHING) ? "forward- and backward-matching" :
	                                                                    "flexible",
			(searchDevice == SEARCH_DEVICE_CPU) ? "CPU" :
			(searchDevice == SEARCH_DEVICE_GPU) ? "GPU(s)" :
	                                              "CPU and GPU(s)");
	if (minLenExpandedPattern != maxLenExpandedPattern) {
		sprintf(NEXT_LINE,
				"  for %d pattern%s (%d chunk%s) with %d to %d characters%s",
				numExpandedPatterns,
				(numExpandedPatterns == 1) ? "" : "s",
				numTripcodeChunk,
				(numTripcodeChunk == 1) ? "" : "s",
				minLenExpandedPattern,
				maxLenExpandedPattern,
				(searchDevice == SEARCH_DEVICE_CPU) ? "." : ":");
		
	} else {
		sprintf(NEXT_LINE,
				"  for %d pattern%s (%d chunk%s) with %d characters%s",
				numExpandedPatterns,
				(numExpandedPatterns == 1) ? "" : "s",
				numTripcodeChunk,
				(numTripcodeChunk == 1) ? "" : "s",
				minLenExpandedPattern,
				(searchDevice == SEARCH_DEVICE_CPU) ? "." : ":");
	}
	if (searchDevice != SEARCH_DEVICE_CPU && CUDADeviceSearchThreadInfoArray) {
		EnterCriticalSection(&criticalSection_CUDADeviceSearchThreadInfoArray);
		if (numCUDADeviceSearchThreads == 1) {
			sprintf(NEXT_LINE, "      CUDA0:     %s", CUDADeviceSearchThreadInfoArray[0].status);
		} else {
			for (int i = 0; i < numCUDADeviceSearchThreads; ++i)
				sprintf(NEXT_LINE, "      CUDA%d:     %s", i, CUDADeviceSearchThreadInfoArray[i].status);
		}
		LeaveCriticalSection(&criticalSection_CUDADeviceSearchThreadInfoArray);
	}
	if (searchDevice != SEARCH_DEVICE_CPU && openCLDeviceSearchThreadInfoArray) {
		if (numOpenCLDeviceSearchThreads == 1) {
			sprintf(NEXT_LINE, "      OpenCL0:   %s", openCLDeviceSearchThreadInfoArray[0].status);
		} else {
			for (int i = 0; i < numOpenCLDeviceSearchThreads; ++i) {
				if (openCLDeviceSearchThreadInfoArray[i].subindex < 0) {
					sprintf(NEXT_LINE, "      OpenCL%d:   %s",  openCLDeviceSearchThreadInfoArray[i].index, openCLDeviceSearchThreadInfoArray[i].status);
				} else {
					sprintf(NEXT_LINE, "      OpenCL%d-%d: %s", openCLDeviceSearchThreadInfoArray[i].index, openCLDeviceSearchThreadInfoArray[i].subindex, openCLDeviceSearchThreadInfoArray[i].status);
				}
			}
		}
	}
#if FALSE
	if (CUDADeviceSearchThreadInfoArray && IsCUDADeviceOptimizationInProgress())
		sprintf(NEXT_LINE, "      [optimization in progress]");
#endif

	double currentSpeed_childProcesses = 0;
	double averageSpeed_childProcesses = 0;
	double totalNumGeneratedTripcodes_childProcesses = 0;
	unsigned int numDiscardedTripcodes_childProcesses = 0;
	// printf("numOpenCLDeviceSearchThreads = %d\n", numOpenCLDeviceSearchThreads);
	if (openCLDeviceSearchThreadInfoArray && openCLRunChildProcesses) {
		for (int i = 0; i < numOpenCLDeviceSearchThreads; ++i) {
			// printf("deviceNo = %d\n", openCLDeviceSearchThreadInfoArray[i].deviceNo);
			if (!(openCLDeviceSearchThreadInfoArray[i].runChildProcess))
				continue;
			currentSpeed_childProcesses               += openCLDeviceSearchThreadInfoArray[i].currentSpeed;
			averageSpeed_childProcesses               += openCLDeviceSearchThreadInfoArray[i].averageSpeed;
			totalNumGeneratedTripcodes_childProcesses += openCLDeviceSearchThreadInfoArray[i].totalNumGeneratedTripcodes;
			numDiscardedTripcodes_childProcesses      += openCLDeviceSearchThreadInfoArray[i].numDiscardedTripcodes;
		}
	}

	double averageSpeed;
	double averageSpeed_GPU;
	double averageSpeed_CPU;
	double timeForOneMatch;
	double actualMatchingProb;
	double matchingProbDiff;
	if (totalTime > 0) {
		unsigned int remainingSeconds = (unsigned int)totalTime;
		unsigned int totalTimeDays    = remainingSeconds / (24 * 60 * 60); remainingSeconds -= totalTimeDays    * 24 * 60 * 60;
		unsigned int totalTimeHours   = remainingSeconds / (     60 * 60); remainingSeconds -= totalTimeHours        * 60 * 60;
		unsigned int totalTimeMinutes = remainingSeconds / (          60); remainingSeconds -= totalTimeMinutes           * 60;
		unsigned int totalTimeSeconds = remainingSeconds;
		
		sprintf(NEXT_LINE, "");
		sprintf(NEXT_LINE, "  %.3lfT tripcodes were generated in %dd %dh %dm %02ds at:",
				(prevTotalNumGeneratedTripcodes + totalNumGeneratedTripcodes_childProcesses) * 0.000000000001,
				totalTimeDays,
				totalTimeHours,
				totalTimeMinutes,
				totalTimeSeconds);
		sprintf(NEXT_LINE, "      %3.2lfM tripcode/s (current)", (currentSpeed_thisProcess + currentSpeed_childProcesses) / 1000000);
		if (searchDevice == SEARCH_DEVICE_GPU_AND_CPU) {
			sprintf(NEXT_LINE, "          GPU: %7.2lfM tripcode/s", (currentSpeed_thisProcess_GPU + currentSpeed_childProcesses) / 1000000);
			sprintf(NEXT_LINE, "          CPU: %7.2lfM tripcode/s", currentSpeed_CPU / 1000000);
		}
#ifdef DISPLAY_MAXIMUM_SPEED
		sprintf(NEXT_LINE, "      %3.2lfM tripcode/s (maximum)", maximumSpeed);
#endif
		averageSpeed     = prevTotalNumGeneratedTripcodes     / totalTime + averageSpeed_childProcesses;
		averageSpeed_GPU = prevTotalNumGeneratedTripcodes_GPU / totalTime + averageSpeed_childProcesses;
		averageSpeed_CPU = prevTotalNumGeneratedTripcodes_CPU / totalTime;
		sprintf(NEXT_LINE, "      %3.2lfM tripcode/s (average)",  averageSpeed / 1000000);
		if (searchDevice == SEARCH_DEVICE_GPU_AND_CPU) {
			sprintf(NEXT_LINE, "          GPU: %7.2lfM tripcode/s", averageSpeed_GPU / 1000000);
			sprintf(NEXT_LINE, "          CPU: %7.2lfM tripcode/s", averageSpeed_CPU / 1000000);
		}
		
		timeForOneMatch = numAverageTrialsForOneMatch / averageSpeed;
		if (averageSpeed > 0 && !searchForSpecialPatternsOnCPU) {
			if (timeForOneMatch >= 100.0 * 365 * 24 * 60 * 60) {
				sprintf(NEXT_LINE, "  On average, it takes %.1lf centuries to find one match at this speed.", timeForOneMatch / (100.0 * 365 * 24 * 60 * 60));			
			} else if (timeForOneMatch >= 365.0 * 24 * 60 * 60) {
				sprintf(NEXT_LINE, "  On average, it takes %.1lf years to find one match at this speed.", timeForOneMatch / (365.0 * 24 * 60 * 60));			
			} else if (timeForOneMatch >= 30.4 * 24 * 60 * 60) {
				sprintf(NEXT_LINE, "  On average, it takes %.1lf months to find one match at this speed.", timeForOneMatch / (30.4 * 24 * 60 * 60));			
			} else if (timeForOneMatch >= 24 * 60 * 60) {
				sprintf(NEXT_LINE, "  On average, it takes %.1lf days to find one match at this speed.", timeForOneMatch / (24 * 60 * 60));			
			} else if (timeForOneMatch >= 60 * 60) {
				sprintf(NEXT_LINE, "  On average, it takes %.1lf hours to find one match at this speed.", timeForOneMatch / (60 * 60));			
			} else if (timeForOneMatch >= 60) {
				sprintf(NEXT_LINE, "  On average, it takes %.1lf minutes to find one match at this speed.", timeForOneMatch / 60);			
			} else {
				sprintf(NEXT_LINE, "  On average, it takes %.1lf seconds to find one match at this speed.", timeForOneMatch);			
			}
		}
		sprintf(NEXT_LINE, "");
		if (numValidTripcodes <= 0) {
			sprintf(NEXT_LINE, "  No matches were found yet.");
		} else {
			if (prevNumValidTripcodes > 0) {
				sprintf(NEXT_LINE, "  %ld match%s found at %.2lf matches/h and %.2lfG tripcodes/match.",
						prevNumValidTripcodes,
						(prevNumValidTripcodes == 1) ? "" : "es",
						prevNumValidTripcodes / (totalTime / 3600),
						(double)(prevTotalNumGeneratedTripcodes + totalNumGeneratedTripcodes_childProcesses) / prevNumValidTripcodes * 0.000000001);
			}
			actualMatchingProb = (prevNumValidTripcodes + prevNumDiscardedTripcodes + numDiscardedTripcodes_childProcesses) / (prevTotalNumGeneratedTripcodes + totalNumGeneratedTripcodes_childProcesses);
			matchingProbDiff = (actualMatchingProb - matchingProb) / matchingProb;
#ifdef DEBUG_DISPLAY_MATCHING_PROBABILITY
			sprintf(NEXT_LINE, "  The theoretical matching probability is %0.20lf%%.", matchingProb);
#endif
			if (!searchForSpecialPatternsOnCPU) {
				if (matchingProbDiff > 0.01) {
					sprintf(NEXT_LINE, "  The actual matching probability is %.0f%% higher than expected.", matchingProbDiff * 100);
				} else if (matchingProbDiff < -0.01) {
					sprintf(NEXT_LINE, "  The actual matching probability is %.0f%% lower than expected.",
							-matchingProbDiff * 100);
				} else {
					sprintf(NEXT_LINE, "  The actual matching probability is about the same as expected.");
				}
			}
			if (!openCLRunChildProcesses && prevNumValidTripcodes + prevNumDiscardedTripcodes > 0) {
				double invalidTripcodeRatio = ((double)(prevNumDiscardedTripcodes) / (prevNumValidTripcodes + prevNumDiscardedTripcodes));
				sprintf(NEXT_LINE, "  %.0f%% of matching tripcodes were invalid.",
						invalidTripcodeRatio * 100);
			}
		}
	}
	
	if (!options.redirection) {
		for (int i = 0; i < lineCount; ++i)
			printf("%-79s\n", &(msg[i][0]));
		ResetCursorPos(-lineCount);
	} else {
		if (totalTime > 0 && !searchForSpecialPatternsOnCPU) {
			printf("[status],%.0lf,%.0lf,%.0lf,%.0lf,%.0lf,%.1lf,%s%d%%,%.0lf,%ld,%d,%.0lf,%.0lf,%u\n",
			       totalTime,
				   currentSpeed_thisProcess     + currentSpeed_childProcesses,
				   currentSpeed_thisProcess_GPU + currentSpeed_childProcesses,
				   currentSpeed_CPU,
				   averageSpeed,
				   timeForOneMatch,
				   ((int)(matchingProbDiff * 100) > 0) ? "+" : "", // All I want to do here is to avoid "-0%" and "+0%".
				    (int)(matchingProbDiff * 100),
				   prevTotalNumGeneratedTripcodes + totalNumGeneratedTripcodes_childProcesses,
				   prevNumValidTripcodes,
				   IsCUDADeviceOptimizationInProgress(),
				   averageSpeed_GPU,
				   averageSpeed_CPU,
				   prevNumDiscardedTripcodes);
		} else if (totalTime > 0) {
			printf("[status],%.0lf,%.0lf,%.0lf,%.0lf,%.0lf,-,-,%.0lf,%ld,%d,%.0lf,%.0lf,%u\n",
			       totalTime,
				   currentSpeed_thisProcess     + currentSpeed_childProcesses,
				   currentSpeed_thisProcess_GPU + currentSpeed_childProcesses,
				   currentSpeed_CPU,
				   averageSpeed,
				   prevTotalNumGeneratedTripcodes + totalNumGeneratedTripcodes_childProcesses,
				   prevNumValidTripcodes,
				   IsCUDADeviceOptimizationInProgress(),
				   averageSpeed_GPU,
				   averageSpeed_CPU,
				   prevNumDiscardedTripcodes);
		}
		fflush(stdout);
	}
	
	LeaveCriticalSection(&criticalSection_openCLDeviceSearchThreadInfoArray);
	LeaveCriticalSection(&criticalSection_currentState);
#undef NEXT_LINE
}

BOOL WINAPI ControlHandler(_In_  DWORD dwCtrlType)
{
	switch (dwCtrlType) {
	case CTRL_C_EVENT:
	case CTRL_CLOSE_EVENT:
	case CTRL_SHUTDOWN_EVENT:
	case CTRL_LOGOFF_EVENT:
		SetTerminationState();
		while (TRUE)
			Sleep(1000);
		return TRUE;
	default:
		return FALSE;
	}
}

void InitProcess()
{
	HideCursor();

	InitializeCriticalSection(&criticalSection_ProcessTripcodePair);
	InitializeCriticalSection(&criticalSection_currentState);
	InitializeCriticalSection(&criticalSection_numGeneratedTripcodes);
	InitializeCriticalSection(&criticalSection_CUDADeviceSearchThreadInfoArray);
	InitializeCriticalSection(&criticalSection_openCLDeviceSearchThreadInfoArray);

	SetConsoleCtrlHandler(ControlHandler, true);
}

void ListCUDADevices()
{
	int i;
	cudaDeviceProp CUDADeviceProperties;
	
	cudaGetDeviceCount(&CUDADeviceCount);

	for (i = 0; i < CUDADeviceCount; ++i) {
		cudaGetDeviceProperties(&CUDADeviceProperties, i);
		printf("NVIDIA %s (CUDA)\n", CUDADeviceProperties.name); 
	}
}

void CountOpenCLDevices()
{
    cl_int        errorCode;
    cl_uint       numPlatforms;
	cl_uint       deviceCount;
	cl_device_id *devices = NULL;

	openCLDeviceCount = 0;

	// Get a list of platforms
	errorCode = clGetPlatformIDs(0, NULL, &numPlatforms);
    if (errorCode != CL_SUCCESS || numPlatforms <= 0)
		return;
	cl_platform_id* platforms = (cl_platform_id*)malloc(sizeof(cl_platform_id) * numPlatforms);
	ERROR0(platforms == NULL, ERROR_NO_MEMORY, "Not enough memory.");
    errorCode = clGetPlatformIDs(numPlatforms, platforms, NULL);
    OPENCL_ERROR(errorCode);

	int openCLDeviceIDArrayIndex = 0;
	for (int pass = 0; pass <= 1; ++pass) {
		for (int platformIndex = 0; platformIndex < numPlatforms; ++platformIndex) {
			// Skip CUDA devices.
			char platformVendor[LEN_LINE_BUFFER_FOR_SCREEN];
			errorCode = clGetPlatformInfo(platforms[platformIndex], CL_PLATFORM_VENDOR, sizeof(platformVendor), platformVendor, NULL);
			// OPENCL_ERROR(errorCode);
			if (errorCode != CL_SUCCESS)
				continue;
			if (   (strcmp(platformVendor, OPENCL_VENDOR_NVIDIA) == 0 && !options.useOpenCLForCUDADevices)
				||  strcmp(platformVendor, OPENCL_VENDOR_INTEL ) == 0                                     )
				continue;
		
			// Get a list of devices on the platform.
			errorCode = clGetDeviceIDs(platforms[platformIndex], CL_DEVICE_TYPE_ALL, 0, NULL, &deviceCount);
			// OPENCL_ERROR(errorCode);
			// if (errorCode == CL_DEVICE_NOT_FOUND)
			//	continue;
			if (errorCode != CL_SUCCESS)
				continue;
			devices = (cl_device_id*)malloc(sizeof(cl_device_id) * deviceCount);
			ERROR0(devices == NULL, ERROR_NO_MEMORY, "Not enough memory.");
			errorCode = clGetDeviceIDs(platforms[platformIndex], CL_DEVICE_TYPE_GPU | CL_DEVICE_TYPE_ACCELERATOR, deviceCount, devices, &deviceCount);
			if (errorCode != CL_DEVICE_NOT_FOUND) {
				OPENCL_ERROR(errorCode);
				for(int deviceIndex = 0; deviceIndex < deviceCount; ++deviceIndex) {
					if (pass == 0) {
						++openCLDeviceCount;
					} else {
						openCLDeviceIDArray[openCLDeviceIDArrayIndex++] = devices[deviceIndex];
					}
				}
			}
			free(devices);
		}
		if (pass == 0) {
			openCLDeviceIDArray = (cl_device_id *)malloc(sizeof(cl_device_id) * openCLDeviceCount);
			ERROR0(openCLDeviceIDArray == NULL, ERROR_NO_MEMORY, "Not enough memory.");
		}
	}

    free(platforms);
}

void ListOpenCLDevices()
{
    cl_int  errorCode;
    cl_uint numPlatforms;
	cl_uint deviceCount;
	char    deviceVendor[LEN_LINE_BUFFER_FOR_SCREEN];
	char    deviceName  [LEN_LINE_BUFFER_FOR_SCREEN];
	cl_uint numComputeUnits;

	CountOpenCLDevices();

	for(int deviceIndex = 0; deviceIndex < openCLDeviceCount; ++deviceIndex) {  
		OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[deviceIndex], CL_DEVICE_VENDOR,            sizeof(deviceVendor),    &deviceVendor,    NULL));
		OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[deviceIndex], CL_DEVICE_NAME,              sizeof(deviceName),      &deviceName,      NULL));
		OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[deviceIndex], CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(numComputeUnits), &numComputeUnits, NULL));
		// printf("%d: ", CUDADeviceCount + deviceIndex);
		if (strcmp(deviceVendor, OPENCL_VENDOR_AMD) == 0) {
			printf("AMD ");
		} else if (strcmp(deviceVendor, OPENCL_VENDOR_INTEL) == 0) {
			// Do not print anything.
		} else if (strcmp(deviceVendor, OPENCL_VENDOR_NVIDIA) == 0) {
			printf("NVIDIA ");
		} else {
			printf("%s ", deviceVendor);
		}
		char *productName = GetProductNameForOpenCLDevice(deviceVendor, deviceName, numComputeUnits);
		if (productName) {
			printf("%s", productName);
		} else {
			printf("%s", deviceName);
		}
		printf(" (OpenCL)\n");
	}
}

void ListGPUsAndExit()
{
	if (!options.useOpenCLForCUDADevices)
		ListCUDADevices();
	ListOpenCLDevices();
	exit(0);
}

void InitSearchDevices(BOOL displayDeviceInformation)
{
	int i;
	cudaDeviceProp CUDADeviceProperties;
	
	if (options.useOpenCLForCUDADevices) {
		CUDADeviceCount = 0;
	} else {
		cudaGetDeviceCount(&CUDADeviceCount);
	}
	CountOpenCLDevices();
	ERROR0(   options.GPUIndex != GPU_INDEX_ALL
		   && (options.GPUIndex < 0 || CUDADeviceCount + openCLDeviceCount <= options.GPUIndex),
			ERROR_INVALID_OPTION,
			"An invalid device was specified.");
	if (options.searchDevice == SEARCH_DEVICE_NIL) {
		searchDevice = (CUDADeviceCount <= 0 && openCLDeviceCount <= 0) ? (SEARCH_DEVICE_CPU) : (SEARCH_DEVICE_GPU_AND_CPU);
	} else {
		searchDevice = options.searchDevice;
	}
#ifdef DEBUG_USE_CPU_ONLY
	searchDevice = SEARCH_DEVICE_CPU;
#endif
	
#if FALSE
	if (displayDeviceInformation) {
		if (searchDevice == SEARCH_DEVICE_CPU) {
			printf("CPU will be used as a search device.\n\n");
		} else if (searchDevice == SEARCH_DEVICE_GPU && CUDADeviceCount + openCLDeviceCount <= 1 || options.GPUIndex != GPU_INDEX_ALL) {
			printf("GPU will be used as a search device.\n\n");
		} else if (searchDevice == SEARCH_DEVICE_GPU) {
			printf("GPUs will be used as search devices.\n\n");
		} else {
			printf("Both GPU(s) and CPU will be used as search devices.\n\n");
		}
	}
#endif
	ERROR0((searchDevice == SEARCH_DEVICE_GPU || searchDevice == SEARCH_DEVICE_GPU_AND_CPU) && CUDADeviceCount <= 0 && openCLDeviceCount <= 0,
		   ERROR_INVALID_OPTION, "There is no GPU.");
		
	numCUDADeviceSearchThreads   = 0;
	numOpenCLDeviceSearchThreads = 0;
	numCPUSearchThreads          = 0;

	if (   (searchDevice == SEARCH_DEVICE_GPU || searchDevice == SEARCH_DEVICE_GPU_AND_CPU)
		&& CUDADeviceCount > 0
		&& !options.useOpenCLForCUDADevices
		&& (options.GPUIndex == GPU_INDEX_ALL || options.GPUIndex < CUDADeviceCount)) {

		if (displayDeviceInformation && CUDADeviceCount > 1 && options.GPUIndex == GPU_INDEX_ALL) {
			printf("CUDA DEVICES\n");
			printf("============\n");
			printf(        "  CUDA Device Count:        %d\n\n", CUDADeviceCount);
		} else if (displayDeviceInformation) {
			printf("CUDA DEVICE\n");
			printf("===========\n");
		}
		for (i = ((options.GPUIndex == GPU_INDEX_ALL) ? 0               :  options.GPUIndex     );
		     i < ((options.GPUIndex == GPU_INDEX_ALL) ? CUDADeviceCount : (options.GPUIndex + 1));
			 ++i) {
			if (displayDeviceInformation) {
				cudaGetDeviceProperties(&CUDADeviceProperties, i);
				printf(    "  Device No.:               %d\n",      i);
				printf(    "  Device Name:              %s\n",      CUDADeviceProperties.name);
				printf(    "  Multiprocessor Count:     %d\n",      CUDADeviceProperties.multiProcessorCount);
				printf(    "  Clock Rate:               %.0fMHz\n", CUDADeviceProperties.clockRate * 1e-3f);
				printf(    "  Compute Capability:       %d.%d\n",   CUDADeviceProperties.major, CUDADeviceProperties.minor);
				printf(    "  Compute Mode:             %s\n",
					   (CUDADeviceProperties.computeMode == cudaComputeModeDefault         ) ? "cudaComputeModeDefault"          :
					   (CUDADeviceProperties.computeMode == cudaComputeModeExclusive       ) ? "cudaComputeModeExclusive"        :
					   (CUDADeviceProperties.computeMode == cudaComputeModeProhibited      ) ? "cudaComputeModeProhibited"       :
					   (CUDADeviceProperties.computeMode == cudaComputeModeExclusiveProcess) ? "cudaComputeModeExclusiveProcess" :
					                                                                           "(unknown)"                        );
				printf("\n");
			}
			++numCUDADeviceSearchThreads;
		}
	}

	if (   (searchDevice == SEARCH_DEVICE_GPU || searchDevice == SEARCH_DEVICE_GPU_AND_CPU)
		&& openCLDeviceCount > 0
		&& (options.GPUIndex == GPU_INDEX_ALL || CUDADeviceCount <= options.GPUIndex)) {

		if (displayDeviceInformation && openCLDeviceCount > 1 && options.GPUIndex == GPU_INDEX_ALL) {
			printf("OPENCL DEVICES\n");
			printf("==============\n");
			printf(        "  OpenCL Device Count:      %d\n\n", openCLDeviceCount);
		} else if (displayDeviceInformation) {
			printf("OPENCL DEVICE\n");
			printf("=============\n");
		}
		openCLRunChildProcesses =    (   options.openCLRunChildProcesses
		                              && (openCLDeviceCount > 1)
			                          && (options.GPUIndex == GPU_INDEX_ALL))
								  || options.openCLNumProcesses > 1;
													
		// printf("openCLRunChildProcesses = %d\n", openCLRunChildProcesses);
		for (i = ((options.GPUIndex == GPU_INDEX_ALL) ? CUDADeviceCount                     : (options.GPUIndex    ));
		     i < ((options.GPUIndex == GPU_INDEX_ALL) ? CUDADeviceCount + openCLDeviceCount : (options.GPUIndex + 1));
			 ++i) {
			int openCLDeviceIndex = i - CUDADeviceCount;
			char deviceVendor [LEN_LINE_BUFFER_FOR_SCREEN];
			char deviceName   [LEN_LINE_BUFFER_FOR_SCREEN];
			char deviceVersion[LEN_LINE_BUFFER_FOR_SCREEN];
			char driverVersion[LEN_LINE_BUFFER_FOR_SCREEN];
			cl_ulong globalMemorySize;
			cl_uint  clockFrequency;
			cl_uint  numComputeUnits;
			size_t maxWorkGroupSize;
			OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIndex], CL_DEVICE_VENDOR,              sizeof(deviceVendor),     &deviceVendor,     NULL));
			OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIndex], CL_DEVICE_NAME,                sizeof(deviceName),       &deviceName,       NULL));
			OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIndex], CL_DEVICE_VERSION,             sizeof(deviceVersion),    &deviceVersion,    NULL));
			OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIndex], CL_DRIVER_VERSION,             sizeof(driverVersion),    &driverVersion,    NULL));
			OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIndex], CL_DEVICE_GLOBAL_MEM_SIZE,     sizeof(globalMemorySize), &globalMemorySize, NULL));
			OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIndex], CL_DEVICE_MAX_CLOCK_FREQUENCY, sizeof(clockFrequency),   &clockFrequency,   NULL));
			OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIndex], CL_DEVICE_MAX_COMPUTE_UNITS,   sizeof(numComputeUnits),  &numComputeUnits,  NULL));
			OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIndex], CL_DEVICE_MAX_WORK_GROUP_SIZE, sizeof(maxWorkGroupSize), &maxWorkGroupSize, NULL));
			char *productName = GetProductNameForOpenCLDevice(deviceVendor, deviceName, numComputeUnits);
			if (displayDeviceInformation) {
				printf(    "  Vendor:                   %s\n",        deviceVendor);
				if (productName) {
					printf(    "  Name:                     %s (%s)\n", deviceName, productName);
				} else {
					printf(    "  Name:                     %s\n",      deviceName);
				}
				printf(    "  Number of Compute Units:  %d\n",        (int)numComputeUnits);
				printf(    "  Clock Frequency:          %dMHz\n",     (int)clockFrequency);
				printf(    "  Global Memory Size:       %dM bytes\n", (int)(globalMemorySize / 1024 / 1024));
				printf(    "  Max. Work Group Size:     %d\n",        (int)maxWorkGroupSize);
				printf(    "  Version:                  %s\n",        deviceVersion);
				printf(    "  Driver Version:           %s\n",        driverVersion);
				printf("\n");
			}
			if (openCLRunChildProcesses) {
				numOpenCLDeviceSearchThreads += options.openCLNumProcesses;
			} else {
				numOpenCLDeviceSearchThreads += options.openCLNumThreads;
			}
		}
	}

	if (searchDevice == SEARCH_DEVICE_CPU || searchDevice == SEARCH_DEVICE_GPU_AND_CPU) {
		SYSTEM_INFO sysInfo;
		GetSystemInfo(&sysInfo);
#ifdef DEBUG_ONE_CPU_SEARCH_THREAD
		numCPUSearchThreads = 1;
#else
		if (options.numCPUSearchThreads == NUM_CPU_SEARCH_THREADS_NIL) { 
			numCPUSearchThreads = sysInfo.dwNumberOfProcessors;
			if (searchDevice == SEARCH_DEVICE_GPU_AND_CPU)
				numCPUSearchThreads = (numCPUSearchThreads > numCUDADeviceSearchThreads + numOpenCLDeviceSearchThreads)
										  ? (numCPUSearchThreads - numCUDADeviceSearchThreads - numOpenCLDeviceSearchThreads)
										  : 0;
		} else {
			numCPUSearchThreads = (options.numCPUSearchThreads < sysInfo.dwNumberOfProcessors) ? options.numCPUSearchThreads : sysInfo.dwNumberOfProcessors;
		}
#endif
		if (searchDevice == SEARCH_DEVICE_GPU_AND_CPU && numCPUSearchThreads <= 0) {
			searchDevice = SEARCH_DEVICE_GPU;
		} else 	if (displayDeviceInformation) {
			int results[4];
			__cpuid(results, 1);

			printf("CPU\n");
			printf("===\n");
			if (IsCPUBasedOnNehalemMicroarchitecture()) {
				printf("  Processor Info:           0x%06x (Nehalem)\n", results[0]);
			} else {
				printf("  Processor Info:           0x%06x\n", results[0]);
			}
			printf("  Number of Logical Cores:  %d\n", sysInfo.dwNumberOfProcessors);
			printf("  Number of Search Threads: %d\n", numCPUSearchThreads);
			printf("\n");
		}
	}
}

void InitMemoryBlocks()
{
	keyBitmap = (unsigned char *)malloc(KEY_BITMAP_SIZE);
	ERROR0(keyBitmap == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	smallKeyBitmap = (unsigned char *)malloc(SMALL_KEY_BITMAP_SIZE);
	ERROR0(smallKeyBitmap == NULL, ERROR_NO_MEMORY, "Not enough memory.");
}

void ObtainOptions(int argCount, char **arguments)
{
	int i;
	
	// Get the application path and directory.
	// strcpy(applicationPath,      arguments[0]);
	_fullpath(applicationPath, arguments[0], sizeof(applicationPath));
	strcpy(applicationDirectory, applicationPath);
	for (i = strlen(applicationPath) - 1; i > 0; --i) {
		if (applicationDirectory[i] == '\\')
			break;
	}
	if (i < 0)
		i = 0;
	applicationDirectory[i] = '\0';
#if FALSE
	printf("arguments[0]         = \'%s\'\n", arguments[0]);
	printf("applicationPath      = \'%s\'\n", applicationPath);
	printf("applicationDirectory = \'%s\'\n", applicationDirectory);
#endif

	// Set default values if necessary.	
	strncpy(tripcodeFilePath, DEFAULT_NAME_TRIPCODE_FILE, sizeof(tripcodeFilePath));

	for (int indexArg = 1; indexArg < argCount; ++indexArg) {
		if (strcmp(arguments[indexArg], "-o") == 0 && indexArg + 1 < argCount) {
			++indexArg;
			ERROR1(strlen(arguments[indexArg]) + 1 > sizeof(tripcodeFilePath),
			       ERROR_TRIPCODE_FILE,
			       "The path of the tripcode file `%s' is too long.",
			       arguments[indexArg]);
			strcpy(tripcodeFilePath, arguments[indexArg]);

		} else if (strcmp(arguments[indexArg], "-f") == 0 && indexArg + 1 < argCount) {
			++indexArg;
			ERROR1(strlen(arguments[indexArg]) > MAX_LEN_FILE_PATH,
			       ERROR_PATTERN_FILE,
			       "The path of the pattern file `%s' is too long.",
			       arguments[indexArg]);
			ERROR0(numPatternFiles >= MAX_NUM_PATTERN_FILES, ERROR_PATTERN_FILE, "Too many pattern files were specified.");
			strcpy(patternFilePathArray[numPatternFiles++], arguments[indexArg]);

		} else if (strcmp(arguments[indexArg], "-d") == 0 && indexArg + 1 < argCount) {
			options.GPUIndex = atoi(arguments[++indexArg]);

		} else if (strcmp(arguments[indexArg], "-x") == 0 && indexArg + 1 < argCount) {
			options.CUDANumBlocksPerSM = atoi(arguments[++indexArg]);
			ERROR1(options.CUDANumBlocksPerSM < CUDA_MIN_NUM_BLOCKS_PER_SM,
			       ERROR_INVALID_OPTION,
				   "The number of blocks per SM must be at least %d.", CUDA_MIN_NUM_BLOCKS_PER_SM);
			ERROR1(options.CUDANumBlocksPerSM > CUDA_MAX_NUM_BLOCKS_PER_SM,
			       ERROR_INVALID_OPTION,
				   "The number of blocks per SM cannot exceed %d.",    CUDA_MAX_NUM_BLOCKS_PER_SM);

		} else if (strcmp(arguments[indexArg], "-y") == 0 && indexArg + 1 < argCount) {
			options.openCLNumWorkGroupsPerCU = atoi(arguments[++indexArg]);
			ERROR1(options.openCLNumWorkGroupsPerCU < OPENCL_MIN_WORK_GROUPS_PER_CU,
			       ERROR_INVALID_OPTION,
				   "The number of work groups per CU must be at least %d.", OPENCL_MIN_WORK_GROUPS_PER_CU);

		} else if (strcmp(arguments[indexArg], "-z") == 0 && indexArg + 1 < argCount) {
			options.openCLNumWorkItemsPerWG = atoi(arguments[++indexArg]);
			ERROR1(options.openCLNumWorkItemsPerWG < OPENCL_MIN_NUM_WORK_ITEMS_PER_WG,
			       ERROR_INVALID_OPTION,
				   "The number of work items per WG must be at least %d.", OPENCL_MIN_NUM_WORK_ITEMS_PER_WG);
			ERROR1(options.openCLNumWorkItemsPerWG > OPENCL_MAX_NUM_WORK_ITEMS_PER_WG,
			       ERROR_INVALID_OPTION,
				   "The number of work items per WG cannot exceed %d.",    OPENCL_MAX_NUM_WORK_ITEMS_PER_WG);
			ERROR0(options.openCLNumWorkItemsPerWG % 8 != 0,
			       ERROR_INVALID_OPTION,
				   "The number of work items per WG must be a multiple of 8.");

		} else if (strcmp(arguments[indexArg], "-a") == 0 && indexArg + 1 < argCount) {
			options.openCLNumThreads = atoi(arguments[++indexArg]);
			ERROR1(options.openCLNumThreads < OPENCL_MIN_NUM_THREADS_PER_AMD_GPU,
			       ERROR_INVALID_OPTION,
				   "The number of threads per AMD GPU must be at least %d.", OPENCL_MIN_NUM_THREADS_PER_AMD_GPU);
			ERROR1(options.openCLNumThreads > OPENCL_MAX_NUM_THREADS_PER_AMD_GPU,
			       ERROR_INVALID_OPTION,
				   "The number of threads per AMD GPU cannot exceed %d.",    OPENCL_MAX_NUM_THREADS_PER_AMD_GPU);

		} else if (strcmp(arguments[indexArg], "-b") == 0 && indexArg + 1 < argCount) {
			options.openCLNumProcesses = atoi(arguments[++indexArg]);
			ERROR1(options.openCLNumProcesses < OPENCL_MIN_NUM_PROCESSES_PER_AMD_GPU,
			       ERROR_INVALID_OPTION,
				   "The number of processes per AMD GPU must be at least %d.", OPENCL_MIN_NUM_PROCESSES_PER_AMD_GPU);
			ERROR1(options.openCLNumProcesses > OPENCL_MAX_NUM_PROCESSES_PER_AMD_GPU,
			       ERROR_INVALID_OPTION,
				   "The number of processes per AMD GPU cannot exceed %d.",    OPENCL_MAX_NUM_PROCESSES_PER_AMD_GPU);

		} else if (strcmp(arguments[indexArg], "-l") == 0 && indexArg + 1 < argCount) {
			lenTripcode    = atoi(arguments[++indexArg]);
			lenTripcodeKey = lenTripcode;
			ERROR0(lenTripcode != 10 && lenTripcode != 12,
			       ERROR_INVALID_OPTION,
			       "The length of tripcodes must be either 10 or 12.");

		} else if (strcmp(arguments[indexArg], "-b") == 0) {
			options.beepWhenNewTripcodeIsFound = TRUE;

		} else if (strcmp(arguments[indexArg], "-i") == 0) {
			options.outputInvalidTripcode = TRUE;

		} else if (strcmp(arguments[indexArg], "-w") == 0) {
			options.warnSpeedDrop= TRUE;

		} else if (strcmp(arguments[indexArg], "-n") == 0) {
			options.testNewCode = TRUE;

		} else if (strcmp(arguments[indexArg], "-c") == 0) {
			options.searchDevice = (options.searchDevice == SEARCH_DEVICE_NIL ) ? (SEARCH_DEVICE_CPU)          :
			                       (options.searchDevice == SEARCH_DEVICE_GPU) ? (SEARCH_DEVICE_GPU_AND_CPU) :
			                                                                      (options.searchDevice);

		} else if (strcmp(arguments[indexArg], "-g") == 0) {
			options.searchDevice = (options.searchDevice == SEARCH_DEVICE_NIL)  ? (SEARCH_DEVICE_GPU)         :
			                       (options.searchDevice == SEARCH_DEVICE_CPU)  ? (SEARCH_DEVICE_GPU_AND_CPU) :
			                                                                      (options.searchDevice);

		} else if (strcmp(arguments[indexArg], "-t") == 0 && indexArg + 1 < argCount) {
			options.numCPUSearchThreads = atoi(arguments[++indexArg]);
			ERROR0(options.numCPUSearchThreads <= 0,
			       ERROR_INVALID_OPTION,
			       "The number of CPU search threads must be at least 1.");

		} else if (strcmp(arguments[indexArg], "--output-for-redirection") == 0) {
			options.redirection = TRUE;

		} else if (strcmp(arguments[indexArg], "-e") == 0 && indexArg + 1 < argCount) {
			++indexArg;
			strcpy(nameMutexForPausing, arguments[indexArg]);
			int len = MultiByteToWideChar(CP_ACP, 0, arguments[indexArg], -1, nameMutexForPausingWC, MAX_LEN_INPUT_LINE);
			if (len < 0) {
				len = 0;
			} else if (len <= MAX_LEN_INPUT_LINE) {
				nameMutexForPausingWC[len] = 0;
			}
			nameMutexForPausingWC[MAX_LEN_INPUT_LINE] = 0;

		} else if (strcmp(arguments[indexArg], "-E") == 0 && indexArg + 1 < argCount) {
			++indexArg;
			strcpy(nameEventForTerminating, arguments[indexArg]);
			int len = MultiByteToWideChar(CP_ACP, 0, arguments[indexArg], -1, nameEventForTerminatingWC, MAX_LEN_INPUT_LINE);
			if (len < 0) {
				len = 0;
			} else if (len <= MAX_LEN_INPUT_LINE) {
				nameEventForTerminatingWC[len] = 0;
			}
			nameEventForTerminatingWC[MAX_LEN_INPUT_LINE] = 0;

		} else if (strcmp(arguments[indexArg], "--use-one-byte-characters-for-keys") == 0) {
			options.useOneByteCharactersForKeys = TRUE;

		} else if (strcmp(arguments[indexArg], "--search-for-hiseki-on-cpu") == 0) {
			options.searchForHisekiOnCPU = TRUE;

		} else if (strcmp(arguments[indexArg], "--search-for-kakuhi-on-cpu") == 0) {
			options.searchForKakuhiOnCPU = TRUE;

		} else if (strcmp(arguments[indexArg], "--search-for-kaibun-on-cpu") == 0) {
			options.searchForKaibunOnCPU = TRUE;

		} else if (strcmp(arguments[indexArg], "--search-for-kagami-on-cpu") == 0) {
			options.searchForKagamiOnCPU = TRUE;

		} else if (strcmp(arguments[indexArg], "--search-for-yamabiko-on-cpu") == 0) {
			options.searchForYamabikoOnCPU = TRUE;

		} else if (strcmp(arguments[indexArg], "--search-for-souren-on-cpu") == 0) {
			options.searchForSourenOnCPU = TRUE;
			
		} else if (strcmp(arguments[indexArg], "--use-opencl-for-cuda-devices") == 0) {
			options.useOpenCLForCUDADevices = TRUE;

		} else if (strcmp(arguments[indexArg], "--disable-avx") == 0) {
			options.isAVXEnabled = FALSE;

		} else if (strcmp(arguments[indexArg], "--use-one-byte-characters-for-keys") == 0) {
			options.useOneByteCharactersForKeys = TRUE;

		} else if (strcmp(arguments[indexArg], "--use-ascii-characters-for-keys") == 0) {
			options.useOneByteCharactersForKeys = TRUE;
			options.useOnlyASCIICharactersForKeys = TRUE;

		} else if (strcmp(arguments[indexArg], "--use-one-and-two-byte-characters-for-keys") == 0) {
			options.useOneByteCharactersForKeys = FALSE;

		} else if (strcmp(arguments[indexArg], "--maximize-key-space") == 0) {
			options.useOneByteCharactersForKeys = FALSE;
			options.maximizeKeySpace = TRUE;

		} else if (   strcmp(arguments[indexArg], "--display-device-information") == 0
			       || strcmp(arguments[indexArg], "--list-expanded-patterns"    ) == 0
				   || strcmp(arguments[indexArg], "--gpu-list"                  ) == 0) {
			// Ignore the option.

		} else {
			ERROR0(TRUE, ERROR_INVALID_OPTION, "An invalid option was specified.");
		}
	}

	if (numPatternFiles <= 0) {
		strcpy(patternFilePathArray[0], DEFAULT_NAME_PATTERN_FILE);
		numPatternFiles = 1;
	}
}

void ProcessValidTripcodePair(unsigned char *tripcode, unsigned char *key)
{
	EnterCriticalSection(&criticalSection_currentState);
	EnterCriticalSection(&criticalSection_ProcessTripcodePair);

	ASSERT(lenTripcode    == 10 || lenTripcode    == 12);
	ASSERT(lenTripcodeKey == 10 || lenTripcodeKey == 12);
	
	if (!options.redirection) {
#ifdef ENGLISH_VERSION
		fprintf(tripcodeFile, "!");
#else
		fprintf(tripcodeFile, "%c%c", 0x81, 0x9f);
#endif
		for (int i = 0; i < lenTripcode; ++i)
			fprintf(tripcodeFile, "%c", tripcode[i]);
		fprintf(tripcodeFile, " #");
		for (int i = 0; i < lenTripcodeKey; ++i)
			fprintf(tripcodeFile, "%c", key[i]);
		fprintf(tripcodeFile, " (");
		for (int i = 0; i < lenTripcodeKey; ++i) {
			fprintf(tripcodeFile, "%02X", key[i]);
			if (i + 1 < lenTripcodeKey)
				fprintf(tripcodeFile, " ");
		}
		fprintf(tripcodeFile, ")\n");
		fflush(tripcodeFile);
	}  

	if (!options.redirection) {
#ifdef ENGLISH_VERSION
		printf("  !");
#else
		printf("  %c%c", 0x81, 0x9f);
#endif
		for (int i = 0; i < lenTripcode; ++i)
			printf("%c", tripcode[i]);
		printf(" #");
		for (int i = 0; i < lenTripcodeKey; ++i)
			printf("%c", key[i]);
		printf(" (");
		for (int i = 0; i < lenTripcodeKey; ++i) {
			printf("%02X", key[i]);
			if (i + 1 < lenTripcodeKey)
				printf(" ");
		}
		printf(")");
		for (int i = 4 + lenTripcode + 2 + lenTripcodeKey + 2 + lenTripcodeKey * 3;
			i < SCREEN_WIDTH - 1;
			++i) {
			printf(" ");
		}
		printf("\n");
	} else {
		printf("[tripcode],%c%c", 0x81, 0x9f);
		for (int i = 0; i < lenTripcode; ++i)
			printf("%c", tripcode[i]);
		printf(",#");
		for (int i = 0; i < lenTripcodeKey; ++i)
			printf("%c", key[i]);
		printf(",(");
		for (int i = 0; i < lenTripcodeKey; ++i) {
			printf("%02X", key[i]);
			if (i + 1 < lenTripcodeKey)
				printf(" ");
		}
		printf(")\n");
	}
	fflush(stdout);

	++numValidTripcodes;
	if (!options.redirection)
		PrintStatus();
	if (!options.redirection && options.beepWhenNewTripcodeIsFound)
		printf("\a");
	
	LeaveCriticalSection(&criticalSection_ProcessTripcodePair);
	LeaveCriticalSection(&criticalSection_currentState);
}

void ProcessInvalidTripcodePair(unsigned char *tripcode, unsigned char *key)
{
	EnterCriticalSection(&criticalSection_currentState);
	EnterCriticalSection(&criticalSection_ProcessTripcodePair);

	if (options.outputInvalidTripcode) {
#ifdef ENGLISH_VERSION
		fprintf(tripcodeFile, "!");
#else
		fprintf(tripcodeFile, "%c%c", 0x81, 0x9f);
#endif
		for (int i = 0; i < lenTripcode; ++i)
			fprintf(tripcodeFile, "%c", tripcode[i]);
		fprintf(tripcodeFile, "  ");
		for (int i = 0; i < lenTripcodeKey; ++i)
			fprintf(tripcodeFile, " ");
		fprintf(tripcodeFile, " (");
		for (int i = 0; i < lenTripcodeKey; ++i) {
			fprintf(tripcodeFile, "%02X", key[i]);
			if (i + 1 < lenTripcodeKey)
				fprintf(tripcodeFile, " ");
		}
		fprintf(tripcodeFile, ")\n");
		fflush(tripcodeFile);  

#ifdef ENGLISH_VERSION
		printf("  !");
#else
		printf("  %c%c", 0x81, 0x9f);
#endif
		for (int i = 0; i < lenTripcode; ++i)
			printf("%c", tripcode[i]);
		printf("  ");
		for (int i = 0; i < lenTripcodeKey; ++i)
			printf(" ");
		printf(" (");
		for (int i = 0; i < lenTripcodeKey; ++i) {
			printf("%02X", key[i]);
			if (i + 1 < lenTripcodeKey)
				printf(" ");
		}
		printf(")");
		for (int i = 4 + lenTripcode + 2 + lenTripcodeKey + 2 + lenTripcodeKey * 3;
		    i < SCREEN_WIDTH - 1;
		    ++i) {
			printf(" ");
		}
		printf("\n");
		fflush(stdout);
		
		if (!options.redirection)
			PrintStatus();
	}
	++numDiscardedTripcodes;

	LeaveCriticalSection(&criticalSection_ProcessTripcodePair);
	LeaveCriticalSection(&criticalSection_currentState);
}

void OpenTripcodeFile()
{
	tripcodeFile = fopen(tripcodeFilePath, "a");
	ERROR0(tripcodeFilePath == NULL, ERROR_TRIPCODE_FILE, "The output file cannot be opened.");
}

void AddToNumGeneratedTripcodesByCPU(unsigned int num)
{
	EnterCriticalSection(&criticalSection_numGeneratedTripcodes);
	numGeneratedTripcodes_CPU += num;
	if (numGeneratedTripcodes_CPU >= 1000000) {
		numGeneratedTripcodesByCPUInMillions += numGeneratedTripcodes_CPU / 1000000;
		numGeneratedTripcodes_CPU           %= 1000000;
	}
	LeaveCriticalSection(&criticalSection_numGeneratedTripcodes);
}

void AddToNumGeneratedTripcodesByGPU(unsigned int num)
{
	EnterCriticalSection(&criticalSection_numGeneratedTripcodes);
	numGeneratedTripcodes_GPU += num;
	if (numGeneratedTripcodes_GPU >= 1000000) {
		numGeneratedTripcodesByGPUInMillions += numGeneratedTripcodes_GPU / 1000000;
		numGeneratedTripcodes_GPU           %= 1000000;
	}
	LeaveCriticalSection(&criticalSection_numGeneratedTripcodes);
}

double GetNumGeneratedTripcodesByCPU()
{
	EnterCriticalSection(&criticalSection_numGeneratedTripcodes);

	double ret =   (double)numGeneratedTripcodesByCPUInMillions * 1000000
	             +         numGeneratedTripcodes_CPU;
	numGeneratedTripcodesByCPUInMillions = 0;
	numGeneratedTripcodes_CPU           = 0;

	LeaveCriticalSection(&criticalSection_numGeneratedTripcodes);
	
	return ret;
}

double GetNumGeneratedTripcodesByGPU()
{
	EnterCriticalSection(&criticalSection_numGeneratedTripcodes);

	double ret =   (double)numGeneratedTripcodesByGPUInMillions * 1000000
	             +         numGeneratedTripcodes_GPU;
	numGeneratedTripcodesByGPUInMillions = 0;
	numGeneratedTripcodes_GPU           = 0;

	LeaveCriticalSection(&criticalSection_numGeneratedTripcodes);
	
	return ret;
}

void SetPauseState(BOOL newPauseState)
{
	EnterCriticalSection(&criticalSection_currentState);
	isSearchPaused = newPauseState;
	LeaveCriticalSection(&criticalSection_currentState);
}

BOOL GetPauseState()
{
	BOOL ret;
	EnterCriticalSection(&criticalSection_currentState);
	ret = isSearchPaused;
	LeaveCriticalSection(&criticalSection_currentState);
	return ret;
}

void SetTerminationState()
{
	EnterCriticalSection(&criticalSection_currentState);
	wasSearchTerminated = TRUE;
	LeaveCriticalSection(&criticalSection_currentState);
}

BOOL GetTerminationState()
{
	BOOL ret;

	EnterCriticalSection(&criticalSection_currentState);

	// Prepare for termination.
	if (options.redirection && nameEventForTerminatingWC[0] != 0x0 && eventForTerminating == NULL) {
		eventForTerminating = OpenEvent(EVENT_ALL_ACCESS, false, nameEventForTerminatingWC);
		ERROR0(!eventForTerminating, ERROR_EVENT, "Failed to open an event.") 
	}

	// Check to see if a termination event has occured.
	if (eventForTerminating && WaitForSingleObject(eventForTerminating, 0) == WAIT_OBJECT_0)
		wasSearchTerminated = true;

	ret = wasSearchTerminated;

	LeaveCriticalSection(&criticalSection_currentState);

	return ret;
}

double UpdateCurrentStatus(DWORD startingTime)
{
	EnterCriticalSection(&criticalSection_currentState);
	
	double numGeneratedTripcodes_GPU = GetNumGeneratedTripcodesByGPU();
	double numGeneratedTripcodes_CPU = GetNumGeneratedTripcodesByCPU();
	DWORD  endingTime = timeGetTime();
	double deltaTime = (endingTime >= startingTime)
	                       ? (endingTime - startingTime             ) * 0.001
	                       : (endingTime - startingTime + 0xffffffff) * 0.001;

	totalNumGeneratedTripcodes     += numGeneratedTripcodes_GPU + numGeneratedTripcodes_CPU;
	totalNumGeneratedTripcodes_GPU += numGeneratedTripcodes_GPU;
	totalNumGeneratedTripcodes_CPU += numGeneratedTripcodes_CPU;
	totalTime += deltaTime;
	currentSpeed_thisProcess  = ((double)(  numGeneratedTripcodes_GPU
	                          + numGeneratedTripcodes_CPU) / deltaTime);
	currentSpeed_thisProcess_GPU = ((double)numGeneratedTripcodes_GPU / deltaTime);
	currentSpeed_CPU        = ((double)numGeneratedTripcodes_CPU        / deltaTime);
	if (maximumSpeed < currentSpeed_thisProcess)
		maximumSpeed = currentSpeed_thisProcess;
	prevTotalNumGeneratedTripcodes     = totalNumGeneratedTripcodes;
	prevTotalNumGeneratedTripcodes_GPU = totalNumGeneratedTripcodes_GPU;
	prevTotalNumGeneratedTripcodes_CPU = totalNumGeneratedTripcodes_CPU;
	prevNumValidTripcodes     = numValidTripcodes;
	prevNumDiscardedTripcodes = numDiscardedTripcodes;

	LeaveCriticalSection(&criticalSection_currentState);

	return deltaTime;
}

BOOL IsFirstByteSJIS(unsigned char ch)
{
	if (options.maximizeKeySpace) {
		return IS_FIRST_BYTE_SJIS_FULL(ch);
	} else {
		return IS_FIRST_BYTE_SJIS_CONSERVATIVE(ch);
	}
}

void SetCharactersInTripcodeKey(unsigned char *key, int n)
{
	if (options.useOnlyASCIICharactersForKeys) {
		for (int i = 0; i < n; i++){
			key[i] = RandomByte();
			while ((i == 0 && (key[i] == '#' || key[i] == '$')) || !IS_ASCII_KEY_CHAR(key[i]))
				key[i] = (unsigned char)(RandomByte() & 0xff);
		}
	} else if (options.useOneByteCharactersForKeys) {
		for (int i = 0; i < n; i++){
			key[i] = RandomByte();
			while ((i == 0 && (key[i] == '#' || key[i] == '$')) || !IS_ONE_BYTE_KEY_CHAR(key[i]))
				key[i] = (unsigned char)(RandomByte() & 0xff);
		}
	} else {
		BOOL isSecondByteSJIS = FALSE;
		for (int i = 0; i < n; i++){
			if (!isSecondByteSJIS) {
				key[i] = RandomByte();
				while ((i == 0 && (key[i] == '#' || key[i] == '$')) || !(IS_ONE_BYTE_KEY_CHAR(key[i]) || IsFirstByteSJIS(key[i])))
					key[i] = (unsigned char)(RandomByte() & 0xff);
				if (IsFirstByteSJIS(key[i]))
					isSecondByteSJIS = TRUE;
			} else {
				key[i] = (unsigned char)(RandomByte() & 0xff);
				while ((i == 0 && (key[i] == '#' || key[i] == '$')) || !IS_SECOND_BYTE_SJIS(key[i]) || !IS_VALID_SJIS_CHAR(key[i - 1], key[i]))
					key[i] = (unsigned char)(RandomByte() & 0xff);
				isSecondByteSJIS = FALSE;
			}
		}
	}
}

void SetCharactersInTripcodeKeyForSHA1Tripcode(unsigned char *key)
{
	if (options.useOnlyASCIICharactersForKeys) {
		for (int i = 0; i < lenTripcodeKey; i++){
			key[i] = RandomByte();
			while ((i == 0 && (key[i] == '#' || key[i] == '$')) || !IS_ASCII_KEY_CHAR(key[i]))
				key[i] = (unsigned char)(RandomByte() & 0xff);
		}
	} else if (options.useOneByteCharactersForKeys) {
		for (int i = 0; i < lenTripcodeKey; i++){
			key[i] = RandomByte();
			while ((i == 0 && (key[i] == '#' || key[i] == '$')) || !IS_ONE_BYTE_KEY_CHAR(key[i]))
				key[i] = (unsigned char)(RandomByte() & 0xff);
		}
	} else {
		BOOL isSecondByteSJIS = FALSE;
		for (int i = 0; i < lenTripcodeKey; i++){
			if (!isSecondByteSJIS) {
				key[i] = (unsigned char)(RandomByte() & 0xff);
				if (i == 3 || i == lenTripcodeKey - 1) {
					while (!IS_ONE_BYTE_KEY_CHAR(key[i]))
						key[i] = (unsigned char)(RandomByte() & 0xff);
				} else {
					while ((i == 0 && (key[i] == '#' || key[i] == '$')) || !(IS_ONE_BYTE_KEY_CHAR(key[i]) || IsFirstByteSJIS(key[i])))
						key[i] = (unsigned char)(RandomByte() & 0xff);
				}
				isSecondByteSJIS = IsFirstByteSJIS(key[i]);
			} else {
				key[i] = (unsigned char)(RandomByte() & 0xff);
				while (!IS_SECOND_BYTE_SJIS(key[i]) || !IS_VALID_SJIS_CHAR(key[i - 1], key[i]))
					key[i] = (unsigned char)(RandomByte() & 0xff);
				isSecondByteSJIS = FALSE;
			}
		}
	}
}

void StartCUDADeviceSearchThreads()
{
	int    i;
	unsigned int winThreadID;
	
	ASSERT(numCUDADeviceSearchThreads > 0);

	ERROR0((CUDADeviceSearchThreadArray     = (HANDLE *)malloc(sizeof(HANDLE) * numCUDADeviceSearchThreads)) == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	ERROR0((CUDADeviceSearchThreadInfoArray = (struct CUDADeviceSearchThreadInfo *)malloc(sizeof(struct CUDADeviceSearchThreadInfo) * numCUDADeviceSearchThreads)) == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	if (options.GPUIndex == GPU_INDEX_ALL) {
		for (i = 0; i < numCUDADeviceSearchThreads; ++i) {
			CUDADeviceSearchThreadInfoArray[i].CUDADeviceIndex = i;
			CUDADeviceSearchThreadInfoArray[i].isOptimizationInProgress = TRUE;
			CUDADeviceSearchThreadInfoArray[i].status[0] = '\0';
		}
	} else if (options.GPUIndex < CUDADeviceCount) {
		ASSERT(numCUDADeviceSearchThreads == 1);
		CUDADeviceSearchThreadInfoArray[0].CUDADeviceIndex = options.GPUIndex;
		CUDADeviceSearchThreadInfoArray[0].isOptimizationInProgress = TRUE;
		CUDADeviceSearchThreadInfoArray[0].status[0] = '\0';
	}

	if (lenTripcode == 12) {
		for (i = 0; i < numCUDADeviceSearchThreads; ++i) {
			CUDADeviceSearchThreadArray[i] = (HANDLE)_beginthreadex(NULL,
			                                                        0,
													                Thread_SearchForSHA1TripcodesOnCUDADevice,
															        &(CUDADeviceSearchThreadInfoArray[i]),
															        0,
											                        &winThreadID);
			ERROR0((CUDADeviceSearchThreadArray[i] == NULL), ERROR_SEARCH_THREAD, "Failed to start a CUDA device search thread.");
		}
	} else {
		ASSERT(lenTripcode == 10);
		for (i = 0; i < numCUDADeviceSearchThreads; ++i) {
			CUDADeviceSearchThreadArray[i] = (HANDLE)_beginthreadex(NULL,
			                                                        0,
			                                                        Thread_SearchForDESTripcodesOnCUDADevice,
															        &(CUDADeviceSearchThreadInfoArray[i]),
															        0,
														            &winThreadID);
			ERROR0((CUDADeviceSearchThreadArray[i] == NULL), ERROR_SEARCH_THREAD, "Failed to start a CUDA device search thread.");
		}
	}
}

void StartOpenCLDeviceSearchThreads()
{
	int          i, j;
	unsigned int winThreadID;
	char         deviceVendor[LEN_LINE_BUFFER_FOR_SCREEN];
	
	ASSERT(numOpenCLDeviceSearchThreads > 0);

	ERROR0((openCLDeviceSearchThreadArray     = (HANDLE *)malloc(sizeof(HANDLE) * numOpenCLDeviceSearchThreads)) == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	ERROR0((openCLDeviceSearchThreadInfoArray = (struct OpenCLDeviceSearchThreadInfo *)malloc(sizeof(struct OpenCLDeviceSearchThreadInfo) * numOpenCLDeviceSearchThreads)) == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	if (options.GPUIndex == GPU_INDEX_ALL) {
		int openCLDeviceIDArrayIndex = 0;
		for (i = 0; i < numOpenCLDeviceSearchThreads; ++i) {
			OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIDArrayIndex], CL_DEVICE_VENDOR, sizeof(deviceVendor), &deviceVendor, NULL));
			openCLDeviceSearchThreadInfoArray[i].openCLDeviceID  = openCLDeviceIDArray[openCLDeviceIDArrayIndex];
			openCLDeviceSearchThreadInfoArray[i].index           = openCLDeviceIDArrayIndex;
			openCLDeviceSearchThreadInfoArray[i].subindex        = -1;
			openCLDeviceSearchThreadInfoArray[i].status[0]       = '\0';
			openCLDeviceSearchThreadInfoArray[i].runChildProcess = openCLRunChildProcesses;
			//
			openCLDeviceSearchThreadInfoArray[i].deviceNo                   = CUDADeviceCount + openCLDeviceIDArrayIndex;
			openCLDeviceSearchThreadInfoArray[i].currentSpeed               = 0;
			openCLDeviceSearchThreadInfoArray[i].averageSpeed               = 0;
			openCLDeviceSearchThreadInfoArray[i].totalNumGeneratedTripcodes = 0;
			openCLDeviceSearchThreadInfoArray[i].numDiscardedTripcodes      = 0;
			if (!openCLRunChildProcesses) {
				openCLDeviceSearchThreadInfoArray[i].subindex       = 0;
				for (j = 1; j < options.openCLNumThreads; ++j) {
					++i;
					ASSERT(i < numOpenCLDeviceSearchThreads);
					ASSERT(openCLDeviceIDArrayIndex < openCLDeviceCount);
					openCLDeviceSearchThreadInfoArray[i].openCLDeviceID = openCLDeviceIDArray[openCLDeviceIDArrayIndex];
					openCLDeviceSearchThreadInfoArray[i].index          = openCLDeviceIDArrayIndex;
					openCLDeviceSearchThreadInfoArray[i].subindex       = j;
					openCLDeviceSearchThreadInfoArray[i].status[0]      = '\0';
					openCLDeviceSearchThreadInfoArray[i].runChildProcess = FALSE;
				}
			} else {
				openCLDeviceSearchThreadInfoArray[i].subindex       = 0;
				for (j = 1; j < options.openCLNumProcesses; ++j) {
					++i;
					ASSERT(i < numOpenCLDeviceSearchThreads);
					ASSERT(openCLDeviceIDArrayIndex < openCLDeviceCount);
					openCLDeviceSearchThreadInfoArray[i].openCLDeviceID = openCLDeviceIDArray[openCLDeviceIDArrayIndex];
					openCLDeviceSearchThreadInfoArray[i].index          = openCLDeviceIDArrayIndex;
					openCLDeviceSearchThreadInfoArray[i].subindex       = j;
					openCLDeviceSearchThreadInfoArray[i].status[0]      = '\0';
					openCLDeviceSearchThreadInfoArray[i].runChildProcess = TRUE;
					//
					openCLDeviceSearchThreadInfoArray[i].deviceNo                   = CUDADeviceCount + openCLDeviceIDArrayIndex;
					openCLDeviceSearchThreadInfoArray[i].currentSpeed               = 0;
					openCLDeviceSearchThreadInfoArray[i].averageSpeed               = 0;
					openCLDeviceSearchThreadInfoArray[i].totalNumGeneratedTripcodes = 0;
					openCLDeviceSearchThreadInfoArray[i].numDiscardedTripcodes      = 0;
				}
			}
			++openCLDeviceIDArrayIndex;
		}

	} else if (CUDADeviceCount <= options.GPUIndex && options.GPUIndex < CUDADeviceCount + openCLDeviceCount) {
		int openCLDeviceIDArrayIndex = options.GPUIndex - CUDADeviceCount;
		OPENCL_ERROR(clGetDeviceInfo(openCLDeviceIDArray[openCLDeviceIDArrayIndex], CL_DEVICE_VENDOR, sizeof(deviceVendor), &deviceVendor, NULL));
		openCLDeviceSearchThreadInfoArray[0].openCLDeviceID  = openCLDeviceIDArray[openCLDeviceIDArrayIndex];
		openCLDeviceSearchThreadInfoArray[0].index           = 0;
		openCLDeviceSearchThreadInfoArray[0].subindex        = -1;
		openCLDeviceSearchThreadInfoArray[0].status[0]       = '\0';
		openCLDeviceSearchThreadInfoArray[0].runChildProcess = openCLRunChildProcesses;
		//
		openCLDeviceSearchThreadInfoArray[0].deviceNo                   = CUDADeviceCount + openCLDeviceIDArrayIndex;
		openCLDeviceSearchThreadInfoArray[0].currentSpeed               = 0;
		openCLDeviceSearchThreadInfoArray[0].averageSpeed               = 0;
		openCLDeviceSearchThreadInfoArray[0].totalNumGeneratedTripcodes = 0;
		openCLDeviceSearchThreadInfoArray[0].numDiscardedTripcodes      = 0;
		if (!openCLRunChildProcesses) {
			ASSERT(numOpenCLDeviceSearchThreads == options.openCLNumThreads);
			openCLDeviceSearchThreadInfoArray[0].subindex       = 0;
			for (j = 1; j < options.openCLNumThreads; ++j) {
				openCLDeviceSearchThreadInfoArray[j].openCLDeviceID  = openCLDeviceIDArray[openCLDeviceIDArrayIndex];
				openCLDeviceSearchThreadInfoArray[j].index           = 0;
				openCLDeviceSearchThreadInfoArray[j].subindex        = j;
				openCLDeviceSearchThreadInfoArray[j].status[0]       = '\0';
				openCLDeviceSearchThreadInfoArray[j].runChildProcess = FALSE;
			}
		} else {
			openCLDeviceSearchThreadInfoArray[0].subindex = 0;
			for (j = 1; j < options.openCLNumProcesses; ++j) {
				ASSERT(openCLDeviceIDArrayIndex < openCLDeviceCount);
				openCLDeviceSearchThreadInfoArray[j].openCLDeviceID = openCLDeviceIDArray[openCLDeviceIDArrayIndex];
				openCLDeviceSearchThreadInfoArray[j].index          = 0;
				openCLDeviceSearchThreadInfoArray[j].subindex       = j;
				openCLDeviceSearchThreadInfoArray[j].status[0]      = '\0';
				openCLDeviceSearchThreadInfoArray[j].runChildProcess = TRUE;
				//
				openCLDeviceSearchThreadInfoArray[j].deviceNo                   = CUDADeviceCount + openCLDeviceIDArrayIndex;
				openCLDeviceSearchThreadInfoArray[j].currentSpeed               = 0;
				openCLDeviceSearchThreadInfoArray[j].averageSpeed               = 0;
				openCLDeviceSearchThreadInfoArray[j].totalNumGeneratedTripcodes = 0;
				openCLDeviceSearchThreadInfoArray[j].numDiscardedTripcodes      = 0;
			}	
		}
	}

	if (lenTripcode == 12) {
		for (i = 0; i < numOpenCLDeviceSearchThreads; ++i) {
			openCLDeviceSearchThreadArray[i] = (HANDLE)_beginthreadex(NULL,
			                                                        0,
													                Thread_SearchForSHA1TripcodesOnOpenCLDevice,
															        &(openCLDeviceSearchThreadInfoArray[i]),
															        0,
											                        &winThreadID);
			ERROR0((openCLDeviceSearchThreadArray[i] == NULL), ERROR_SEARCH_THREAD, "Failed to start a OpenCL device search thread.");
		}
	} else {
		ASSERT(lenTripcode == 10);
#ifndef OPENCL_ENABLE_10CHAR_TRIPCODE_SEARCH
		ERROR0(TRUE, ERROR_DES, "10 character tripcode search cannot be performed on the specified device(s).");
#else
		for (i = 0; i < numOpenCLDeviceSearchThreads; ++i) {
			openCLDeviceSearchThreadArray[i] = (HANDLE)_beginthreadex(NULL,
			                                                        0,
			                                                        Thread_SearchForDESTripcodesOnOpenCLDevice,
															        &(openCLDeviceSearchThreadInfoArray[i]),
															        0,
														            &winThreadID);
			ERROR0((openCLDeviceSearchThreadArray[i] == NULL), ERROR_SEARCH_THREAD, "Failed to start a OpenCL device search thread.");
		}
#endif
	}
	// printf("openCLDeviceCount            = %d\n", openCLDeviceCount);
	// printf("numOpenCLDeviceSearchThreads = %d\n", numOpenCLDeviceSearchThreads);
}

void StartGPUSearchThreads()
{
	if (numCUDADeviceSearchThreads > 0)
		StartCUDADeviceSearchThreads();
	if (numOpenCLDeviceSearchThreads > 0)
		StartOpenCLDeviceSearchThreads();
}

void StartCPUSearchThreads()
{
	ASSERT(numCPUSearchThreads > 0);

	unsigned int winThreadID;
	
	if (CPUSearchThreadArray)
		free(CPUSearchThreadArray);
	ERROR0((CPUSearchThreadArray = (HANDLE *)malloc(sizeof(HANDLE) * numCPUSearchThreads)) == NULL, ERROR_NO_MEMORY, "Not enough memory.");
	
	for (int i = 0; i < numCPUSearchThreads; ++i) {
		if (lenTripcode == 12) {
			CPUSearchThreadArray[i] = (HANDLE)_beginthreadex(NULL, 0, Thread_SearchForSHA1TripcodesOnCPU, NULL, 0, &winThreadID);
		} else {
			ASSERT(lenTripcode == 10);
			CPUSearchThreadArray[i] = (HANDLE)_beginthreadex(NULL, 0, Thread_SearchForDESTripcodesOnCPU, NULL, 0, &winThreadID);
		}
		ERROR0((CPUSearchThreadArray[i] == NULL), ERROR_SEARCH_THREAD, "Failed to start a CPU search thread.");
	}
}

int GetParentProcessID()
{
	int processID = GetCurrentProcessId();
	int parentProcessID = -1;
	HANDLE hSnapProcess = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
	PROCESSENTRY32 processEntry = {0};
	processEntry.dwSize = sizeof(PROCESSENTRY32);

	if(Process32First(hSnapProcess, &processEntry)) {
		do {
    		if (processEntry.th32ProcessID == processID) {
    			parentProcessID = processEntry.th32ParentProcessID;
    			break;
			}
		} while( Process32Next(hSnapProcess, &processEntry));
	}

	CloseHandle(hSnapProcess);
	return parentProcessID;
}

void ListExpandedPatterns()
{
	for (int i = 0; i < numExpandedPatterns; ++i)
		printf("%d: `%s' @ %d\n", i, expandedPatternArray[i].c, expandedPatternArray[i].pos);
}

int main(int argc, char **argv)
{
	BOOL   displayDeviceInformationAndExit = false;
	BOOL   listExpandedPatternsAndExit     = false;

	if (argc > 1) {
		displayDeviceInformationAndExit = (strcmp(argv[1], "--display-device-information") == 0);
		listExpandedPatternsAndExit     = (strcmp(argv[1], "--list-expanded-patterns"    ) == 0);
	}

	InitProcess();
	if (    argc <= 1
		|| (   strcmp(argv[1], "--gpu-list"              ) != 0
		    && !displayDeviceInformationAndExit
			&& !listExpandedPatternsAndExit
		    && strcmp(argv[1], "--output-for-redirection") != 0))
		DisplayCopyrights();
	ObtainOptions(argc, argv);
	if (argc > 1 && strcmp(argv[1], "--gpu-list") == 0)
		ListGPUsAndExit();
	InitSearchDevices((!options.redirection && !listExpandedPatternsAndExit) || displayDeviceInformationAndExit);

	if (displayDeviceInformationAndExit)
		exit(0);

	InitMemoryBlocks();
	CreateCharacterTables();
	LoadTargetPatterns(!options.redirection && !listExpandedPatternsAndExit);

	if (listExpandedPatternsAndExit) {
		ListExpandedPatterns();
		exit(0);
	}

	if (!options.redirection)
		OpenTripcodeFile();

#ifdef DEBUG_TEST_NEW_CODE
	if (options.testNewCode)
		TestNewCode();
#endif
	
#if MTF_FREE_EDITION
	if (!options.redirection)
		exit(0);
#endif

	// Prepare for pausing.
	HANDLE mutexForPausing = NULL;
	if (options.redirection && nameMutexForPausingWC[0] != 0x0) {
		mutexForPausing = OpenMutex(MUTEX_ALL_ACCESS, false, nameMutexForPausingWC);
		ERROR0(!mutexForPausing, ERROR_EVENT, "Failed to open an event.") 
	}
	isSearchPaused = FALSE;
	
	if (!options.redirection) {
		printf("TRIPCODES\n");
		printf("=========\n");
	} else {
		printf("[started]\n");
	}
	PrintStatus();
	
	if (searchDevice == SEARCH_DEVICE_GPU || searchDevice == SEARCH_DEVICE_GPU_AND_CPU)
		StartGPUSearchThreads();

	if (searchDevice == SEARCH_DEVICE_CPU || searchDevice == SEARCH_DEVICE_GPU_AND_CPU)
		StartCPUSearchThreads();
	
	// The main loop.
	DWORD startingTime = timeGetTime();
	HANDLE parentProcess = OpenProcess(SYNCHRONIZE, FALSE, GetParentProcessID());
	while (!GetTerminationState()) {
		// Break the main loop if necessary.
		if (options.redirection && WaitForSingleObject(parentProcess, 0) != WAIT_TIMEOUT)
			break;

		// Wait for the duration of STATUS_UPDATE_INTERVAL.
		DWORD mutexForPausingState;
		for (int i = 0; i < NUM_CHECKS_PER_INTERVAL; ++i) {
			// Break the loop if the search is paused.
			if (mutexForPausing) {
				mutexForPausingState = WaitForSingleObject(mutexForPausing, 0);
				if (mutexForPausingState == WAIT_OBJECT_0) {
					ReleaseMutex(mutexForPausing);
				} else if (mutexForPausingState == WAIT_TIMEOUT) {
					SetPauseState(TRUE);
					break;
				}
			}

			// Break the loop if the search was terminated.
			if (GetTerminationState())
				break;

			// Break the loop if the parent process has already quit.
			if (options.redirection && WaitForSingleObject(parentProcess, 0) != WAIT_TIMEOUT)
				break;

			Sleep((DWORD)(STATUS_UPDATE_INTERVAL * 1000 / NUM_CHECKS_PER_INTERVAL));
		}
		if (GetTerminationState())
			break;
		UpdateCurrentStatus(startingTime);
		
		// Pause searching if necessary.
		if (mutexForPausing) {
			while ((mutexForPausingState = WaitForSingleObject(mutexForPausing, 0)) == WAIT_TIMEOUT) {
				// Break the loop if the search was terminated.
				if (GetTerminationState())
					break;

				// Break the loop if the parent process has already quit.
				if (options.redirection && WaitForSingleObject(parentProcess, 0) != WAIT_TIMEOUT)
					break;

				SetPauseState(TRUE);
				Sleep(PAUSE_INTERVAL);
			}
			if (mutexForPausingState == WAIT_OBJECT_0) {
				ReleaseMutex(mutexForPausing);
				SetPauseState(FALSE);
			}
		}
		if (GetTerminationState())
			break;
				
		//
		startingTime = timeGetTime();
		PrintStatus();
		
		// Warn the user if the speed drops suddenly.
		if (!options.redirection && options.warnSpeedDrop && currentSpeed_thisProcess < maximumSpeed * SPEED_DROP_WARNING_THRESHOLD)
			printf("\a");
	}

	// Close handles.
	CloseHandle(parentProcess);
	if (mutexForPausing)
		CloseHandle(mutexForPausing);

	// Terminate search threads.
	SetTerminationState();
	BOOL allThreadsHaveExited;
	do {
		Sleep(100);
		allThreadsHaveExited = TRUE;
		for (int i = 0; i < numCUDADeviceSearchThreads; ++i) {
			if (WaitForSingleObject(CUDADeviceSearchThreadArray[i], 0) != WAIT_OBJECT_0) {
				allThreadsHaveExited = FALSE;
				break;
			}
		}
		for (int i = 0; i < numOpenCLDeviceSearchThreads; ++i) {
			if (WaitForSingleObject(openCLDeviceSearchThreadArray[i], 0) != WAIT_OBJECT_0) {
				allThreadsHaveExited = FALSE;
				break;
			}
		}
		for (int i = 0; i < numCPUSearchThreads; ++i) {
			if (WaitForSingleObject(CPUSearchThreadArray[i], 0) != WAIT_OBJECT_0) {
				allThreadsHaveExited = FALSE;
				break;
			}
		}
	} while (!allThreadsHaveExited);

	ReleaseResources();

	return 0;
}
