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



struct Tripcode {
	// unsigned int length;
	unsigned char c[MAX_LEN_TRIPCODE];
};

struct TripcodeKey {
	// unsigned int length;
	unsigned char c[MAX_LEN_TRIPCODE_KEY];
};

struct TripcodeKeyPair {
	Tripcode    tripcode;
	TripcodeKey key;
};

struct ExpandedPattern {
	unsigned char pos;
	unsigned char c[MAX_LEN_EXPANDED_PATTERN + 1];
};

struct RegexPattern {
	unsigned char   original [MAX_LEN_TARGET_PATTERN + 1];
	unsigned char   expanded [MAX_LEN_TARGET_PATTERN + 1];
	unsigned char   remaining[MAX_LEN_TARGET_PATTERN + 1];
	BOOL            startsAtFirstChar;
	BOOL            endsAtLastChar;
	BOOL            wereVerticalBarsProcessed;
	//
	int             depth;
	unsigned char   expandedAtLowerDepth [MAX_NUM_DEPTHS_IN_REGEX_PATTERN - 1][MAX_LEN_TARGET_PATTERN + 1];
	unsigned char   remainingAtLowerDepth[MAX_NUM_DEPTHS_IN_REGEX_PATTERN - 1][MAX_LEN_TARGET_PATTERN + 1];
	//
	int             numSubexpressions;
	unsigned char   subexpressions[MAX_NUM_SUBEXPRESSIONS_IN_REGEX_PATTERN][MAX_LEN_TARGET_PATTERN + 1];
	BOOL            wereSubexpressionsSet[MAX_NUM_SUBEXPRESSIONS_IN_REGEX_PATTERN];
	int             subexpressionIndexAtLowerDepth[MAX_NUM_DEPTHS_IN_REGEX_PATTERN - 1];
	BOOL            expandSpecialCharactersInParentheses;
};

struct GPUOutput {
	unsigned int  numGeneratedTripcodes;
	unsigned char numMatchingTripcodes;
	TripcodeKeyPair pair;
};

struct Options {
	int  GPUIndex;
	int  CUDANumBlocksPerSM;
	BOOL beepWhenNewTripcodeIsFound;
	BOOL outputInvalidTripcode;
	BOOL warnSpeedDrop;
	int  searchDevice;
	BOOL testNewCode;
	int  numCPUSearchThreads;
	BOOL redirection;
	int  openCLNumWorkGroupsPerCU;
	int  openCLNumWorkItemsPerWG;
	int  openCLNumThreads;
	BOOL useOneByteCharactersForKeys;
	BOOL searchForHisekiOnCPU;
	BOOL searchForKakuhiOnCPU;
	BOOL searchForKaibunOnCPU;
	BOOL searchForYamabikoOnCPU;
	BOOL searchForSourenOnCPU;
	BOOL searchForKagamiOnCPU;
	BOOL useOpenCLForCUDADevices;
	BOOL isAVXEnabled;
	BOOL useOnlyASCIICharactersForKeys;
	BOOL maximizeKeySpace;
	BOOL isAVX2Enabled;
};

struct CUDADeviceSearchThreadInfo {
	int  CUDADeviceIndex;
	BOOL isOptimizationInProgress;
	char status[LEN_LINE_BUFFER_FOR_SCREEN];
};

struct OpenCLDeviceSearchThreadInfo {
	cl_device_id openCLDeviceID;
	int          index;
	int          subindex;
	char         status[LEN_LINE_BUFFER_FOR_SCREEN];
	//
	int          deviceNo;
	double       currentSpeed;
	double       averageSpeed;
	double       totalNumGeneratedTripcodes;
	unsigned int numDiscardedTripcodes;
};

