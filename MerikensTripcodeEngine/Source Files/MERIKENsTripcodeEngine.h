// Meriken's Tripcode Engine 1.1 Alpha 8
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
// INCLUDE FILES                                                             //
///////////////////////////////////////////////////////////////////////////////

#define _CRT_RAND_S // for rand_s()

// For Win32
#include <windows.h>
#include <process.h>
#include <tlhelp32.h>
#include <mmsystem.h> // for timeGetTime()

// Standard C libraries
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <search.h>
// #include <stdint.h>
#include <stddef.h>

// For MMX/SSE/SSE2/SSSE3 Intrinsics
#include <nmmintrin.h>
#include <smmintrin.h>
#include <intrin.h>
#include <emmintrin.h> 
#include <xmmintrin.h>
#include <mmintrin.h>     

// For CUDA and OpenCL
#include <cuda.h>
#include <cuda_runtime.h>
#include <CL/cl.h>

// For MPIR
#include "mpir.h"

//
#include "Constants.h"
#include "Types.h"
#include "Macros.h"



///////////////////////////////////////////////////////////////////////////////
// Main.cpp                                                                  //
///////////////////////////////////////////////////////////////////////////////

// Options
extern Options options;

// Application path
extern char applicationPath     [MAX_LEN_FILE_PATH + 1];
extern char applicationDirectory[MAX_LEN_FILE_PATH + 1];

// Input and output files
extern int   numPatternFiles;
extern char  patternFilePathArray[MAX_NUM_PATTERN_FILES][MAX_LEN_FILE_PATH + 1];
extern char tripcodeFilePath[MAX_LEN_FILE_PATH + 1];
extern FILE *tripcodeFile;

// Current and previous status
extern double       matchingProb,     numAverageTrialsForOneMatch;
extern mpf_t        matchingProb_mpf, numAverageTrialsForOneMatch_mpf;
extern double totalTime;
extern double currentSpeed, currentSpeed_CUDADevice, currentSpeed_CPU, maximumSpeed;
extern unsigned int numValidTripcodes,     numDiscardedTripcodes;
extern unsigned int prevNumValidTripcodes, prevNumDiscardedTripcodes;
extern double     numGeneratedTripcodes;
extern double prevNumGeneratedTripcodes;
// extern BOOL   isSearchPaused;

// Search Parameters
extern int searchMode;
extern int lenTripcode;
extern int lenTripcodeKey;

// Character tables
extern int           numFirstByte;
extern int           numSecondByte;
extern int           numOneByte;
extern unsigned char keyCharTable_OneByte             [SIZE_KEY_CHAR_TABLE];
extern unsigned char keyCharTable_FirstByte           [SIZE_KEY_CHAR_TABLE];
extern unsigned char keyCharTable_SecondByte          [SIZE_KEY_CHAR_TABLE];
extern unsigned char keyCharTable_SecondByteAndOneByte[SIZE_KEY_CHAR_TABLE];
extern char          base64CharTable[64];
extern void          CreateCharacterTables(void);

// Key bitmap
extern unsigned char *keyBitmap;
extern unsigned char *smallKeyBitmap;

// GPUs
extern int CUDADeviceCount;
extern int searchDevice;

// For multi-threading
extern int                                numCUDADeviceSearchThreads;
extern struct CUDADeviceSearchThreadInfo *CUDADeviceSearchThreadInfoArray;
extern HANDLE                            *CUDADeviceSearchThreadArray;
extern int                                numCPUSearchThreads;
extern HANDLE                            *CPUSearchThreadArray;
extern CRITICAL_SECTION  criticalSection_numGeneratedTripcodes;
extern CRITICAL_SECTION  criticalSection_ProcessTripcodePair;
extern CRITICAL_SECTION  criticalSection_currentState;
extern CRITICAL_SECTION  criticalSection_RandomByte;
extern CRITICAL_SECTION  criticalSection_CUDADeviceSearchThreadInfoArray;
extern unsigned int      numGeneratedTripcodesByCUDADevice;
extern unsigned int      numGeneratedTripcodesByCUDADeviceInMillions;
extern unsigned int      numGeneratedTripcodesByCPU;
extern unsigned int      numGeneratedTripcodesByCPUInMillions;
extern char              nameMutexForPausing    [MAX_LEN_INPUT_LINE + 1];
extern char              nameEventForTerminating[MAX_LEN_INPUT_LINE + 1];

//
extern void          AddToNumGeneratedTripcodesByCPU(unsigned int num);
extern void          AddToNumGeneratedTripcodesByGPU(unsigned int num);
extern void          SetCharactersInTripcodeKey(unsigned char *key, int n);
extern void          SetCharactersInTripcodeKeyForSHA1Tripcode(unsigned char *key);
extern unsigned char RandomByte();
extern BOOL          IsValidKey(unsigned char *key);

// 
extern void SetPauseState(BOOL state);
extern BOOL GetPauseState();
extern void SetTerminationState();
extern BOOL GetTerminationState();

//
extern void UpdateCUDADeviceStatus  (struct CUDADeviceSearchThreadInfo   *info, BOOL isOptimizationInProgress, char *status);
extern void UpdateOpenCLDeviceStatus(struct OpenCLDeviceSearchThreadInfo *info, char *status);
extern void UpdateOpenCLDeviceStatus_ChildProcess(struct OpenCLDeviceSearchThreadInfo *info, char *status, double currentSpeed, double averageSpeed, double totalNumGeneratedTripcodes, unsigned int numDiscardedTripcodes);

//
extern void ShowCursor();
extern void ResetCursorPos(int deltaY);

// Output
extern double ProcessGPUOutput(unsigned char *key, GPUOutput *outputArray, unsigned int sizeOutputArray, BOOL newFormat);
extern void   ProcessValidTripcodePair(unsigned char *tripcode, unsigned char *key);
extern void   ProcessInvalidTripcodePair(unsigned char *tripcode, unsigned char *key);

//
BOOL IsFirstByteSJIS(unsigned char ch);



///////////////////////////////////////////////////////////////////////////////
// Patterns.cu                                                       //
///////////////////////////////////////////////////////////////////////////////

extern void LoadTargetPatterns(BOOL displayProgress);
extern void ProcessMatch        (unsigned char *tripcode, unsigned char *key);
extern void ProcessPossibleMatch(unsigned char *tripcode, unsigned char *key);

extern ExpandedPattern *expandedPatternArray;
extern unsigned int     numExpandedPatterns;
extern unsigned int     sizeExpandedPatternArray;
extern int              minLenExpandedPattern;
extern int              maxLenExpandedPattern;
extern unsigned int    *tripcodeChunkArray;        
extern unsigned int     numTripcodeChunk;
extern unsigned int     sizeTripcodeChunkArray;
extern RegexPattern    *regexPatternArray;
extern int              sizeRegexPatternArray;
extern int              numRegexPattern;
extern BOOL             searchForSpecialPatternsOnCPU;



///////////////////////////////////////////////////////////////////////////////
// Testing.cu                                                            //
///////////////////////////////////////////////////////////////////////////////

extern void TestNewCode();



///////////////////////////////////////////////////////////////////////////////
// BITSLICED DES                                                             //
///////////////////////////////////////////////////////////////////////////////

extern     void CPU_DES_SBoxes1_SSE2Intrinsics(unsigned char *expansionFunction, __m128i *expandedKeySchedule, __m128i *dataBlocks, int keyScheduleIndexBase);
extern     void CPU_DES_SBoxes2_SSE2Intrinsics(unsigned char *expansionFunction, __m128i *expandedKeySchedule, __m128i *dataBlocks, int keyScheduleIndexBase);

extern "C" void CPU_DES_SBoxes1_asm_x64(void *context, __int64 keyScheduleIndexBase);
extern "C" void CPU_DES_SBoxes2_asm_x64(void *context, __int64 keyScheduleIndexBase);

#ifdef _M_X64
extern "C" void DES_Crypt25_x64_SSE2        (void *context);
extern "C" void DES_Crypt25_x64_SSE2_Nehalem(void *context);
extern "C" void DES_Crypt25_x64_AVX         (void *context);
extern "C" void DES_Crypt25_x64_AVX2        (void *context);
#else
extern "C" void DES_Crypt25_x86_SSE2        (void *context);
extern "C" void DES_Crypt25_x86_SSE2_Nehalem(void *context);
extern "C" void DES_Crypt25_x86_AVX         (void *context);
extern "C" void DES_Crypt25_x86_AVX2        (void *context);
#endif



///////////////////////////////////////////////////////////////////////////////
// OPENCL                                                                    //
///////////////////////////////////////////////////////////////////////////////

extern char           *GetProductNameForOpenCLDevice(char *vendor, char *name, cl_uint numComputeUnits);
extern void            GetParametersForOpenCLDevice(cl_device_id deviceID, char *sourceFile, size_t *numWorkGroupsPerComputeUnit, size_t *localWorkSize, char *options);
extern char           *ConvertOpenCLErrorCodeToString(cl_int openCLError);
extern void __stdcall  OnOpenCLError(const char *errorInfo, const void *privateInfo, size_t sizePrivateInfo, void *userData);



///////////////////////////////////////////////////////////////////////////////
// VERFICATION                                                               //
///////////////////////////////////////////////////////////////////////////////

extern BOOL VerifySHA1Tripcode (unsigned char *tripcode, unsigned char *key);
extern BOOL VerifyDESTripcode  (unsigned char *tripcode, unsigned char *key);
extern BOOL IsTripcodeDuplicate(unsigned char *tripcode);



///////////////////////////////////////////////////////////////////////////////
// SEARCH THREADS                                                            //
///////////////////////////////////////////////////////////////////////////////

extern unsigned WINAPI Thread_SearchForSHA1TripcodesOnCPU         (LPVOID threadParams);
extern unsigned WINAPI Thread_SearchForSHA1TripcodesOnCUDADevice  (LPVOID info);
extern unsigned WINAPI Thread_SearchForSHA1TripcodesOnOpenCLDevice(LPVOID info);

extern unsigned WINAPI Thread_SearchForDESTripcodesOnCPU         (LPVOID threadParams);
extern unsigned WINAPI Thread_SearchForDESTripcodesOnCUDADevice  (LPVOID info);
extern unsigned WINAPI Thread_SearchForDESTripcodesOnOpenCLDevice(LPVOID info);

extern void            Thread_RunChildProcessForOpenCLDevice(OpenCLDeviceSearchThreadInfo *info);

extern void DES_CreateExpansionFunction(char *saltString, unsigned char *expansionFunction);
extern const char          charToIndexTableForDES[0x100];
extern const unsigned char expansionTable[48];
// extern unsigned char       expansionFunction[96];
extern unsigned char charTableForKagami[256];



///////////////////////////////////////////////////////////////////////////////
// CPUID                                                                     //
///////////////////////////////////////////////////////////////////////////////

extern "C" int  IsAVXSupported();
extern "C" int  _xgetbv(int ecx);
extern     int  IsAVX2Supported();
extern     BOOL IsCPUBasedOnNehalemMicroarchitecture();
