// Meriken's Tripcode Engine
// Copyright (c) 2011-2016 /Meriken/. <meriken.ygch.net@gmail.com>
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



// #define DEBUG_KEEP_TEMPORARY_FILES_FOR_OPENCL
// #define SINGLE_SALT



///////////////////////////////////////////////////////////////////////////////
// INCLUDE FILE(S)                                                           //
///////////////////////////////////////////////////////////////////////////////

#include "MerikensTripcodeEngine.h"



///////////////////////////////////////////////////////////////////////////////
// OPENCL SEARCH THREAD FOR 10 CHARACTER TRIPCODES                           //
///////////////////////////////////////////////////////////////////////////////

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

static void CreateProgram(cl_context *context, cl_program *program, cl_device_id *deviceID, char *sourceFileName, char *buildOptions, unsigned char keyChar1, unsigned char keyChar2, unsigned char *expansionFunction, char *binaryFilePath)
{
	cl_int         openCLError;

	// Create an expansion function based on the salt.
	unsigned char  salt[2];
	salt[0] = CONVERT_CHAR_FOR_SALT(keyChar1);
	salt[1] = CONVERT_CHAR_FOR_SALT(keyChar2);
	DES_CreateExpansionFunction((char *)salt, expansionFunction);
	//for (int32_t i = 0; i < DES_SIZE_EXPANSION_FUNCTION; ++i)
	//	printf("#define EF%02d %d\n", i, (int32_t)expansionFunction[i]);

	/*
	char    binaryFilePath[MAX_LEN_FILE_PATH + 1];
	FILE   *binaryFile;
	sprintf(binaryFilePath, "%s\\OpenCL\\bin\\OpenCL10GCN.bin", applicationDirectory);
	if (binaryFile = fopen(binaryFilePath, "rb")) {
		fseek(binaryFile, 0L, SEEK_END);
		size_t binarySize = ftell(binaryFile);
		unsigned char *binary = (unsigned char *)malloc(binarySize);
		const unsigned char *binaryArray[1] = {binary};
		ERROR0(binary == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));
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
	ERROR0(sourceCode == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));
	sourceCode[0] = '\0';
	for (int32_t i = 0; i < 7; ++i) {
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
		if (keyChar1 & (1 << i)) {
			sprintf(s, "#define K%02dC 0xffffffffU\n#define K%02dXOR(dest, val) (dest) = ~(val)\n#define K%02dXORV(val) ~(val)\n", i + 7, i + 7, i + 7);
		} else {
			sprintf(s, "#define K%02dC 0x0U\n#define K%02dXOR(dest, val) (dest) = (val)\n#define K%02dXORV(val) (val)\n", i + 7, i + 7, i + 7);
		}
		strcat(sourceCode, s);
	}
	for (int32_t i = 0; i < 7; ++i) {
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
		if (keyChar2 & (1 << i)) {
			sprintf(s, "#define K%02dC 0xffffffffU\n#define K%02dXOR(dest, val) (dest) = ~(val)\n#define K%02dXORV(val) ~(val)\n", i + 14, i + 14, i + 14);
		} else {
			sprintf(s, "#define K%02dC 0x0U\n#define K%02dXOR(dest, val) (dest) = (val)\n#define K%02dXORV(val) (val)\n", i + 14, i + 14, i + 14);
		}
		strcat(sourceCode, s);
	}
	for (int32_t i = 0; i < DES_SIZE_EXPANSION_FUNCTION; ++i) {
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
		sprintf(s, "#define EF%02d %d\n", i, (int32_t)expansionFunction[i]);
		strcat(sourceCode, s);
		sprintf(s, "#define DB_EF%02d DB%02d\n", i, (int32_t)expansionFunction[i]);
		strcat(sourceCode, s);
	}
	unsigned char key7Array[OPENCL_DES_BS_DEPTH];
	int32_t randomByteForKey7 = RandomByte();
	//strcat(sourceCode, "__constant unsigned char key7Array[] = {");
	for (int32_t i = 0; i < OPENCL_DES_BS_DEPTH; ++i) {
		key7Array[i] = keyCharTable_SecondByteAndOneByte[randomByteForKey7 + i];
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; 
		//sprintf(s, "0x%02x,", key7Array[i]);
		sprintf(s, "#define KEY7_%02d 0x%02x\n", i, key7Array[i]);
		strcat(sourceCode, s);
	}
	//strcat(sourceCode, "};\n");
	for (int32_t j = 0; j < 7; ++j) {
		char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
		uint32_t k = 0;
		for (int32_t i = 0; i < OPENCL_DES_BS_DEPTH; ++i)
			k |= ((key7Array[i] >> j) & 0x1) << i;
		sprintf(s, "#define K%02dC 0x%08x\n#define K%02dXOR(dest, val) (dest) = ((val) ^ 0x%08x)\n#define K%02dXORV(val) ((val) ^ 0x%08x)\n", j + 49, k, j + 49, k, j + 49, k);
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
		ERROR0(buildLog == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));
		clGetProgramBuildInfo(*program, *deviceID, CL_PROGRAM_BUILD_LOG, lenBuildLog, buildLog, &lenBuildLog);
		buildLog[lenBuildLog] = '\0';
		fprintf(stderr, "%s\n", buildLog);
		free(buildLog);
	}
	OPENCL_ERROR(openCLError);

	if (binaryFilePath) {
		size_t numDevices;
		openCLError = clGetProgramInfo(*program, CL_PROGRAM_NUM_DEVICES, sizeof(size_t), &numDevices, NULL);
		OPENCL_ERROR(openCLError);
		size_t *binarySizeArray = (size_t *)malloc(sizeof(size_t) * numDevices);
		ERROR0(binarySizeArray == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));
		openCLError = clGetProgramInfo(*program, CL_PROGRAM_BINARY_SIZES, sizeof(size_t) * numDevices, binarySizeArray, NULL);
		OPENCL_ERROR(openCLError);
		unsigned char **binaryArray = (unsigned char **)malloc(sizeof(unsigned char *) * numDevices);
		ERROR0(binaryArray == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));
		for(int32_t i = 0; i < numDevices; ++i) {
			binaryArray[i] = (unsigned char *)malloc(binarySizeArray[i]);
			ERROR0(binaryArray[i] == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));
		}
		openCLError = clGetProgramInfo(*program, CL_PROGRAM_BINARIES, sizeof(unsigned char *) * numDevices, binaryArray, NULL);
		OPENCL_ERROR(openCLError);
		FILE   *binaryFile;
		if (binaryFile = fopen(binaryFilePath, "wb")) {
			fwrite(binaryArray[0], sizeof(unsigned char), binarySizeArray[0], binaryFile);
			fclose(binaryFile);
		}
		free(binarySizeArray);
		for(int32_t i = 0; i < numDevices; ++i)
			free(binaryArray[i]);
		free(binaryArray);
	}
}

#include <iostream>
#include <fstream>
#include <iterator>
#include "elfio/elfio.hpp"

using namespace std;
using namespace ELFIO;

static void ExtractTextSectionInELFFileIntoFile(char *ELFFilePath, char *textSectionFilePath)
{
    elfio reader;
    
    reader.load(ELFFilePath);
    Elf_Half sec_num = reader.sections.size();
    for ( int32_t i = 0; i < sec_num; ++i ) {
        section* psec = reader.sections[i];
		if (psec->get_name() == ".text") {
			ofstream textSectionFile;
			textSectionFile.open(textSectionFilePath, ios::out | ios::binary);
			textSectionFile.write(reader.sections[i]->get_data(), reader.sections[i]->get_size());
			textSectionFile.close();
		}
    }
}

static void ReplaceTextSectionInELFFileWithFile(char *ELFFilePath, char *textSectionFilePath, BOOL innerELFFile)
{
    elfio reader, writer;
    
	reader.load(ELFFilePath);

	ifstream textSectionFile;
	textSectionFile.open(textSectionFilePath, ios::in | ios::binary);
	textSectionFile.seekg(0, ios::end);
	size_t textSectionSize = textSectionFile.tellg();
	char *textSection = new char[textSectionSize];
	textSectionFile.seekg(0, ios::beg);
	textSectionFile.read(textSection, textSectionSize);
	textSectionFile.close();

	writer.create(reader.get_class(), reader.get_encoding());

	writer.set_os_abi(reader.get_os_abi());
	writer.set_abi_version(reader.get_abi_version());
	writer.set_type(reader.get_type());
	writer.set_machine(reader.get_machine());

	Elf_Half sec_num = reader.sections.size();
	section* text_sec = NULL;
    section* data_sec = NULL;
    section* symtab_sec = NULL;
    section* strtab_sec = NULL;
    for ( int32_t i = 0; i < sec_num; ++i ) {
		if (reader.sections[i]->get_name() == ".strtab")
			strtab_sec = reader.sections[i];
	}
    for ( int32_t i = 0; i < sec_num; ++i ) {
        section* src_sec = reader.sections[i];
		if (src_sec->get_name() == ".shstrtab" || src_sec->get_type() == SHT_NULL)
			continue;

		section* dest_sec = writer.sections.add(src_sec->get_name());		
		dest_sec->set_type(src_sec->get_type());
		dest_sec->set_flags(src_sec->get_flags());
		dest_sec->set_link(src_sec->get_link());
		dest_sec->set_addr_align(src_sec->get_addr_align());
		dest_sec->set_entry_size(src_sec->get_entry_size());
		dest_sec->set_address(src_sec->get_address());
		dest_sec->set_info(src_sec->get_info());
		//dest_sec->set_size(src_sec->get_size());
		//dest_sec->set_name_string_offset(src_sec->get_name_string_offset());
		if (src_sec->get_name() == ".text") {
			dest_sec->set_data(textSection, textSectionSize);
			text_sec = dest_sec;
		} else if (src_sec->get_name() == ".data") {
			dest_sec->set_data(src_sec->get_data(), src_sec->get_size());
			data_sec = dest_sec;
		} else if (src_sec->get_name() == ".symtab") {
			/*
			symbol_section_accessor src_symbols (symbol_section_accessor(reader, src_sec));
			symbol_section_accessor dest_symbols(symbol_section_accessor(reader, dest_sec));
			std::string name;
			Elf64_Addr value;
			Elf_Xword size;
			unsigned char bind;
			unsigned char type;
			Elf_Half section_index;
			unsigned char other;

			for (int32_t i = 0; i < src_symbols.get_symbols_num(); ++i) {
				int32_t j = 0;
				string_section_accessor strings = string_section_accessor(strtab_sec);

				src_symbols.get_symbol(i, name, value, size, bind, type, section_index, other);
				while (strings.get_string(j)) {
					if (name == strings.get_string(j))
						break;
					++j;
				}
				if (type == STT_FUNC)
					size = textSectionSize;
				if (type == STT_NOTYPE)
					continue;
				dest_symbols.add_symbol(j, value, size, bind, type, other, section_index);
			}
			*/
			char *data = new char [src_sec->get_size()];
			for (int32_t i = 0; i < src_sec->get_size(); ++i) {
				data[i] = (src_sec->get_data())[i];
				//printf("%02x ", (int32_t)(((unsigned char *)data)[i]));
				//if (i % 16 == 15)
				//	printf("\n");
			}
			//printf("\n");
			if (!innerELFFile && src_sec->get_size() >=  16 + 24 * 3)
				*(uint64_t *)(data + 24 * 2 + 16) = textSectionSize;
			dest_sec->set_data(data, src_sec->get_size());
			//for (int32_t i = 0; i < src_sec->get_size(); ++i) {
			//	printf("%02x ", (int32_t)(((unsigned char *)data)[i]));
			//	if (i % 16 == 15)
			//		printf("\n");
			//}
			delete [] data;
			symtab_sec = dest_sec;
		} else if (src_sec->get_name() == ".strtab") {
			dest_sec->set_data(src_sec->get_data(), src_sec->get_size());
			strtab_sec = dest_sec;
		} else {
			dest_sec->set_data(src_sec->get_data(), src_sec->get_size());
		}
	}

	Elf_Half seg_num = reader.segments.size();
    for ( int32_t i = 0; i < seg_num; ++i ) {
        segment* src_seg = reader.segments[i];
		segment* dest_seg = writer.segments.add();
		dest_seg->set_type(src_seg->get_type());
		dest_seg->set_virtual_address(src_seg->get_virtual_address());
		dest_seg->set_physical_address(src_seg->get_physical_address());
		dest_seg->set_memory_size(src_seg->get_memory_size());
		dest_seg->set_flags(src_seg->get_flags());
		dest_seg->set_align(src_seg->get_align());

		if (src_seg->get_type() == PT_LOAD && text_sec && data_sec && symtab_sec && strtab_sec) {
			size_t text_sec_size   = text_sec->get_size();
			size_t data_sec_size   = data_sec->get_size();
			size_t symtab_sec_size = symtab_sec->get_size();
			size_t strtab_sec_size = strtab_sec->get_size();
			size_t size = text_sec_size + data_sec_size + symtab_sec_size + strtab_sec_size;
			char *data = new char [size], *p = data;
			const char *q;
			int32_t i;
			for (i = 0, q = text_sec->get_data();   i < text_sec_size;   ++i) *p++ = *q++;
			for (i = 0, q = data_sec->get_data();   i < data_sec_size;   ++i) *p++ = *q++;
			for (i = 0, q = symtab_sec->get_data(); i < symtab_sec_size; ++i) *p++ = *q++;
			for (i = 0, q = strtab_sec->get_data(); i < strtab_sec_size; ++i) *p++ = *q++;
			dest_seg->set_memory_size(size);
			dest_seg->set_data(data, size);
			delete [] data;
		} else { 
			dest_seg->set_data(src_seg->get_data(), src_seg->get_file_size());
		}

		if (src_seg->get_type() == PT_NOTE && innerELFFile) {
			unsigned char *data = (unsigned char *)(dest_seg->get_data());
			for (int32_t i = 0; i < dest_seg->get_file_size() - 8; ++i) {
				if (   data[i    ] == 0x41
					&& data[i + 1] == 0x10
					&& data[i + 2] == 0x00
					&& data[i + 3] == 0x80
					&& data[i + 4] != 0
					&& data[i + 5] == 0
					&& data[i + 6] == 0
					&& data[i + 7] == 0) {
					//printf("VGPR: %d\n", (int32_t)data[i + 4]);
					data[i + 4] = 128U; // VGPR
					//printf("VGPR: %d\n", (int32_t)data[i + 4]);
				} else if (   data[i    ] == 0x42
						   && data[i + 1] == 0x10
						   && data[i + 2] == 0x00
						   && data[i + 3] == 0x80
						   && data[i + 4] != 0
						   && data[i + 5] == 0
						   && data[i + 6] == 0
						   && data[i + 7] == 0) {
					//printf("SGPR: %d\n", (int32_t)data[i + 4]);
					data[i + 4] = 102U; // SGPR
					//printf("SGPR: %d\n", (int32_t)data[i + 4]);
				}
			}
		}
	}
	delete textSection;

	if (innerELFFile) {
		ERROR0(!writer.save_inner_elf_file(ELFFilePath), ERROR_OPENCL, "elfio failed.");
	} else {
		ERROR0(!writer.save_outer_elf_file(ELFFilePath), ERROR_OPENCL, "elfio failed.");
	}
}

static void CreateProgramFromGCNAssemblySource(cl_context *context, cl_program *program, cl_device_id *deviceID, char *deviceName, char *deviceVersion, char *driverVersion, unsigned char keyChar1, unsigned char keyChar2, unsigned char *expansionFunction, char *dummyKernelBinaryFilePath)
{
	static char *registerMap[64] = {
		"%v118",
		"%v65",
		"%v68",
		"%v62",
		"%v64",
		"%v121",
		"%v120",
		"%v119",
		"%v57",
		"%v70",
		"%v72",
		"%v69",
		"%v71",
		"%v66",
		"%v122",
		"%v67",
		"%v63",
		"%v73",
		"%v78",
		"%v80",
		"%v77",
		"%v74",
		"%v79",
		"%v76",
		"%v61",
		"%v85",
		"%v59",
		"%v58",
		"%v117",
		"%v56",
		"%v55",
		"%v54",
		"%v53",
		"%v52",
		"%v51",
		"%v50",
		"%v49",
		"%v48",
		"%v47",
		"%v46",
		"%v45",
		"%v44",
		"%v43",
		"%v42",
		"%v41",
		"%v40",
		"%v39",
		"%v38",
		"%v37",
		"%v36",
		"%v35",
		"%v34",
		"%v33",
		"%v32",
		"%v31",
		"%v30",
		"%v29",
		"%v28",
		"%v27",
		"%v26",
		"%v25",
		"%v24",
		"%v23",
		"%v22",
	};
	cl_int         openCLError;

	ACQUIRE_SPIN_LOCK(ansi_system_function_lock);

	// Create an expansion function based on the salt.
	unsigned char  salt[2];
	salt[0] = CONVERT_CHAR_FOR_SALT(keyChar1);
	salt[1] = CONVERT_CHAR_FOR_SALT(keyChar2);
	DES_CreateExpansionFunction((char *)salt, expansionFunction);
	
	char    asssemblerOutputFilePath[MAX_LEN_FILE_PATH + 1];
	char    assemblerOutputFileFullPath[MAX_LEN_FILE_PATH + 1];
	sprintf(asssemblerOutputFilePath, "OpenCL\\bin\\OpenCL10GCN_AssemblerOutput_%02x%02x%02x%02x.bin", RandomByte(), RandomByte(), RandomByte(), RandomByte());
	sprintf(assemblerOutputFileFullPath, "%s\\%s", applicationDirectory, asssemblerOutputFilePath);

	char    sourceFilePath[MAX_LEN_FILE_PATH + 1];
	char    sourceFileFullPath[MAX_LEN_FILE_PATH + 1];
	FILE   *sourceFile;
	sprintf(sourceFilePath, "OpenCL\\bin\\OpenCL10GCN_%02x%02x%02x%02x.asm", RandomByte(), RandomByte(), RandomByte(), RandomByte());
	sprintf(sourceFileFullPath, "%s\\%s", applicationDirectory, sourceFilePath);
	if (sourceFile = fopen(sourceFileFullPath, "w")) {
		for (int32_t i = 0; i < DES_SIZE_EXPANSION_FUNCTION; ++i)
			fprintf(sourceFile, "DB_EF%02d = %s\n", i, registerMap[expansionFunction[i]]);

		unsigned char key7Array[OPENCL_DES_BS_DEPTH];
		int32_t randomByteForKey7 = RandomByte();
		for (int32_t i = 0; i < OPENCL_DES_BS_DEPTH; ++i) {
			key7Array[i] = keyCharTable_SecondByteAndOneByte[randomByteForKey7 + i];
			char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; 
			fprintf(sourceFile, "KEY7_%02d = 0x%02x\n", i, key7Array[i]);
		}
		for (int32_t j = 0; j < 7; ++j) {
			char s[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1]; // may be too big.
			uint32_t k = 0;
			for (int32_t i = 0; i < OPENCL_DES_BS_DEPTH; ++i)
				k |= ((key7Array[i] >> j) & 0x1) << i;
			fprintf(sourceFile, "K%02d = 0x%08x\n", j + 49, k);
		}

		fclose(sourceFile);
	}

	int driverMajorVersion;
	int driverMinorVersion;
	char rest[LEN_LINE_BUFFER_FOR_SCREEN];
	sscanf(driverVersion, "%d.%d%1023s", &driverMajorVersion, &driverMinorVersion, rest);
	
	char    assemblerCommand[MAX_LEN_COMMAND_LINE + 1];
	if (dummyKernelBinaryFilePath) {
		sprintf(assemblerCommand, "type \"%s\\OpenCL\\bin\\OpenCL10GCN_OpenCL20.asm\" >> \"%s\"", applicationDirectory, sourceFileFullPath);
	} else {
		sprintf(assemblerCommand, "type \"%s\\OpenCL\\bin\\OpenCL10GCN.asm\" >> \"%s\"", applicationDirectory, sourceFileFullPath);
	}
	system(assemblerCommand);
	sprintf(assemblerCommand, 
		    "cmd /C \"\"%s\\CLRadeonExtender\\clrxasm\" -b %s -g %s -A %s -t %d%02d -o \"%s\" \"%s\"\"",
			applicationDirectory,
			dummyKernelBinaryFilePath                     ? "rawcode" : 
			strncmp(deviceVersion, "OpenCL 1.2", 10) == 0 ? "amd"     :
			                                                "amd",
			deviceName,
			(   strcmp(deviceName, "CapeVerde") == 0
			 || strcmp(deviceName, "Pitcairn" ) == 0
			 || strcmp(deviceName, "Tahiti"   ) == 0
			 || strcmp(deviceName, "Oland"    ) == 0) ? "gcn1.0" :
	        (   strcmp(deviceName, "Bonaire"  ) == 0
			 || strcmp(deviceName, "Spectre"  ) == 0
			 || strcmp(deviceName, "Spooky"   ) == 0
			 || strcmp(deviceName, "Kalindi"  ) == 0
			 || strcmp(deviceName, "Hainan"   ) == 0
			 || strcmp(deviceName, "Hawaii"   ) == 0
			 || strcmp(deviceName, "Mullins"  ) == 0) ? "gcn1.1" :
	                                                    "gcn1.2",
            driverMajorVersion, 
			driverMinorVersion, 
			assemblerOutputFileFullPath,
			sourceFileFullPath);
	ERROR0(system(assemblerCommand) != 0, ERROR_GCN_ASSEMBLER, "Failed to assemble GCN kernel.");
	sprintf(assemblerCommand, "cmd /C \"del \"%s\"\"", sourceFileFullPath);
	system(assemblerCommand);

	if (dummyKernelBinaryFilePath) {
		char    innerELFFilePath[MAX_LEN_FILE_PATH + 1];
		sprintf(innerELFFilePath, "%s\\OpenCL\\bin\\OpenCL10GCN_InnerELF_%02x%02x%02x%02x.bin", applicationDirectory, RandomByte(), RandomByte(), RandomByte(), RandomByte());
		char    GCNCodeFilePath[MAX_LEN_FILE_PATH + 1];
		sprintf(GCNCodeFilePath, "%s\\OpenCL\\bin\\OpenCL10GCN_GCNCode_%02x%02x%02x%02x.bin", applicationDirectory, RandomByte(), RandomByte(), RandomByte(), RandomByte());

		//sprintf(assemblerCommand, "cmd /C \"copy \"%s\" \"%s.original\"\"", dummyKernelBinaryFilePath, dummyKernelBinaryFilePath);
		//system(assemblerCommand);
		
		ExtractTextSectionInELFFileIntoFile(dummyKernelBinaryFilePath, innerELFFilePath);

		//sprintf(assemblerCommand, "cmd /C \"copy \"%s\" \"%s.original\"\"", innerELFFilePath, innerELFFilePath);
		//system(assemblerCommand);

		//ExtractTextSectionInELFFileIntoFile(innerELFFilePath, GCNCodeFilePath);
		//ReplaceTextSectionInELFFileWithFile(innerELFFilePath, GCNCodeFilePath, TRUE);
		
		ReplaceTextSectionInELFFileWithFile(innerELFFilePath, assemblerOutputFileFullPath, TRUE);
		ReplaceTextSectionInELFFileWithFile(dummyKernelBinaryFilePath, innerELFFilePath, FALSE);
		
		sprintf(assemblerCommand, "cmd /C \"del \"%s\"\"", innerELFFilePath);
		system(assemblerCommand);
	}

	FILE   *binaryFile = fopen(assemblerOutputFileFullPath, "rb");
	ERROR0(   binaryFile == NULL
		   || fseek(binaryFile, 0L, SEEK_END) != 0, 
		   ERROR_GCN_ASSEMBLER,
		   "Failed to load GCN kernel.");
	size_t binarySize = ftell(binaryFile);
	unsigned char *binary = (unsigned char *)malloc(binarySize);
	const unsigned char *binaryArray[1] = {binary};
	ERROR0(binary == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));
	ERROR0(   fseek(binaryFile, 0L, SEEK_SET) != 0
		   || fread(binary, sizeof(unsigned char), binarySize, binaryFile) != binarySize,
		   ERROR_GCN_ASSEMBLER,
		   "Failed to load GCN kernel.");
	fclose(binaryFile);

	*program = clCreateProgramWithBinary(*context, 1, deviceID, &binarySize, binaryArray, NULL, &openCLError);
	OPENCL_ERROR(openCLError);
	openCLError = clBuildProgram(*program, 1, deviceID, NULL, NULL, NULL);
	OPENCL_ERROR(openCLError);
		
	free(binary);

	sprintf(assemblerCommand, "cmd /C \"del \"%s\"\"", assemblerOutputFileFullPath);
	system(assemblerCommand);

	if (dummyKernelBinaryFilePath) {
		sprintf(assemblerCommand, "cmd /C \"del \"%s\"\"", dummyKernelBinaryFilePath);
		system(assemblerCommand);
	}

	RELEASE_SPIN_LOCK(ansi_system_function_lock);
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
	Sleep((uint32_t)RandomByte() * 10000 / 256);

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

	char deviceVendor[LEN_LINE_BUFFER_FOR_SCREEN];
	char deviceName  [LEN_LINE_BUFFER_FOR_SCREEN];
	char deviceVersion[LEN_LINE_BUFFER_FOR_SCREEN];
	char driverVersion[LEN_LINE_BUFFER_FOR_SCREEN];
	cl_ulong localMemorySize;
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_LOCAL_MEM_SIZE, sizeof(localMemorySize), &localMemorySize, NULL));
	// printf("localMemorySize: %d\n", localMemorySize);
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(numComputeUnits), &numComputeUnits, NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_VENDOR,            sizeof(deviceVendor),    &deviceVendor,    NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_NAME,              sizeof(deviceName),      &deviceName,      NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DEVICE_VERSION,           sizeof(deviceVersion),    &deviceVersion,    NULL));
	OPENCL_ERROR(clGetDeviceInfo(deviceID, CL_DRIVER_VERSION,           sizeof(driverVersion),    &driverVersion,    NULL));
	BOOL enableGCNAssembler =    options.enableGCNAssembler
		                      && (strcmp(deviceVendor, OPENCL_VENDOR_AMD) == 0)
		                      && (   strcmp(deviceName, "CapeVerde") == 0
						          || strcmp(deviceName, "Pitcairn" ) == 0
						          || strcmp(deviceName, "Tahiti"   ) == 0
						          || strcmp(deviceName, "Oland"    ) == 0

						          || strcmp(deviceName, "Bonaire"  ) == 0
						          || strcmp(deviceName, "Spectre"  ) == 0
						          || strcmp(deviceName, "Spooky"   ) == 0
						          || strcmp(deviceName, "Kalindi"  ) == 0
						          || strcmp(deviceName, "Hainan"   ) == 0
						          || strcmp(deviceName, "Hawaii"   ) == 0
						          || strcmp(deviceName, "Mullins"  ) == 0
								  
						          || strcmp(deviceName, "Tonga"    ) == 0
						          || strcmp(deviceName, "Fiji"     ) == 0
						          || strcmp(deviceName, "Carrizo"  ) == 0
						          || strcmp(deviceName, "Iceland"  ) == 0)
						      && (   strncmp(deviceVersion, "OpenCL 1.2", 10) == 0
						          || strncmp(deviceVersion, "OpenCL 2.0", 10) == 0);
	BOOL isDriverOpenCL20Compatible = (strncmp(deviceVersion, "OpenCL 2.0", 10) == 0);
	BOOL isIntelHDGraphics = FALSE;
	if (   strcmp(deviceVendor, OPENCL_VENDOR_INTEL) == 0
		&& strncmp(deviceName, "Intel(R) HD Graphics", strlen("Intel(R) HD Graphics")) == 0) {
		// There is a bug in the Intel OpenCL driver.
		ERROR0(TRUE, ERROR_INTEL_HD_GRAPHICS, "This software is not compatible with the Intel(R) HD Graphics series.");
		// strcat(buildOptions, " -D INTEL_HD_GRAPHICS ");
	}

	// Create memory blocks for CPU.
	uint32_t  sizeOutputArray = globalWorkSize;
	GPUOutput    *outputArray     = (GPUOutput *)malloc(sizeof(GPUOutput) * sizeOutputArray);
	ERROR0(outputArray == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));
	uint32_t *compactMediumChunkBitmap = (uint32_t *)calloc(MEDIUM_CHUNK_BITMAP_SIZE / 8, sizeof(uint32_t));
	ERROR0(compactMediumChunkBitmap == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));
	for (int32_t i = 0; i < MEDIUM_CHUNK_BITMAP_SIZE; ++i)
		if (mediumChunkBitmap[i])
			compactMediumChunkBitmap[i >> 5] |= 0x1 << (i & 0x1f);
	// printf("sizeOutputArray = %u\n", sizeOutputArray);
	PartialKeyFrom3To6 *partialKeyFrom3To6Array = (PartialKeyFrom3To6 *)malloc(sizeof(PartialKeyFrom3To6) * globalWorkSize);
	ERROR0(partialKeyFrom3To6Array == NULL, ERROR_NO_MEMORY, GetErrorMessage(ERROR_NO_MEMORY));

    // 
	if (options.maximizeKeySpace)
		strcat(buildOptions, " -DMAXIMIZE_KEY_SPACE ");
	char tempBuildOption[OPENCL_DES_MAX_LEN_BUILD_OPTIONS + 1];
	sprintf(tempBuildOption, " -DOPENCL_DES_LOCAL_WORK_SIZE=%d ", (int32_t)localWorkSize);
	strcat(buildOptions, tempBuildOption);
	sprintf(tempBuildOption, " -DOPENCL_DES_BS_DEPTH=%d ", (int32_t)OPENCL_DES_BS_DEPTH);
	strcat(buildOptions, tempBuildOption);
	strcat(buildOptions, " -w ");
	if (strcmp(deviceVendor, OPENCL_VENDOR_AMD) == 0)
		strcat(buildOptions, " -fno-bin-source -fno-bin-llvmir -fbin-exe ");
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
	int64_t        startingTime = TIME_SINCE_EPOCH_IN_MILLISECONDS;
	int64_t        endingTime;
	double       deltaTime;
	int32_t          execCounter = 0;
	BOOL         firstBuild = TRUE;
	
	// Create an OpenCL context.
	context      = clCreateContext(NULL, 1, &deviceID, OnOpenCLError, NULL, &openCLError); OPENCL_ERROR(openCLError);
	commandQueue = clCreateCommandQueue(context, deviceID, 0, &openCLError);               OPENCL_ERROR(openCLError);

	// Create memory blocks for the OpenCL device.
	openCL_outputArray          = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(GPUOutput) * sizeOutputArray,     NULL, &openCLError); OPENCL_ERROR(openCLError);
	openCL_keyInfo              = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(keyInfo),                         NULL, &openCLError); OPENCL_ERROR(openCLError);
	openCL_tripcodeChunkArray   = clCreateBuffer(context, CL_MEM_READ_ONLY,  sizeof(uint32_t) * numTripcodeChunk, NULL, &openCLError); OPENCL_ERROR(openCLError);
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
			unsigned char  salt[2];
#ifdef SINGLE_SALT
			do {
#endif
				SetCharactersInTripcodeKey(keyInfo.partialKeyAndRandomBytes, 3);
				salt[0] = CONVERT_CHAR_FOR_SALT(keyInfo.partialKeyAndRandomBytes[1]);
				salt[1] = CONVERT_CHAR_FOR_SALT(keyInfo.partialKeyAndRandomBytes[2]);
#ifdef SINGLE_SALT
			} while (salt[0] != '.' || salt[1] != '.');
#endif
			if (false && enableGCNAssembler && isDriverOpenCL20Compatible) {
				char    dummyKernelBinaryFilePath[MAX_LEN_FILE_PATH + 1];
				sprintf(dummyKernelBinaryFilePath, "%s\\OpenCL\\bin\\OpenCL10GCN_%02x%02x%02x%02x.bin", applicationDirectory, RandomByte(), RandomByte(), RandomByte(), RandomByte());
				CreateProgram(&context, &program, &deviceID, sourceFileName, buildOptions, keyInfo.partialKeyAndRandomBytes[1], keyInfo.partialKeyAndRandomBytes[2], keyInfo.expansioinFunction, dummyKernelBinaryFilePath);
				CreateProgramFromGCNAssemblySource(&context, &program, &deviceID, deviceName, deviceVersion, driverVersion, keyInfo.partialKeyAndRandomBytes[1], keyInfo.partialKeyAndRandomBytes[2], keyInfo.expansioinFunction, dummyKernelBinaryFilePath);
			} else if (enableGCNAssembler) {
				CreateProgramFromGCNAssemblySource(&context, &program, &deviceID, deviceName, deviceVersion, driverVersion, keyInfo.partialKeyAndRandomBytes[1], keyInfo.partialKeyAndRandomBytes[2], keyInfo.expansioinFunction, NULL);
			} else {
				char    binaryFilePath[MAX_LEN_FILE_PATH + 1];
				FILE   *binaryFile;
				sprintf(binaryFilePath, "%s\\OpenCL\\bin\\OpenCL10GCN.bin", applicationDirectory);
				CreateProgram(&context, &program, &deviceID, sourceFileName, buildOptions, keyInfo.partialKeyAndRandomBytes[1], keyInfo.partialKeyAndRandomBytes[2], keyInfo.expansioinFunction, binaryFilePath);
			}
			UpdateOpenCLDeviceStatus(((OpenCLDeviceSearchThreadInfo *)info), "[thread] Creating an OpenCL kernel...");
			kernel = clCreateKernel(program, "OpenCL_DES_PerformSearching", &openCLError);
			// printf("clCreateKernel(): done\n");
   			OPENCL_ERROR(openCLError);

			// Set arguments for the kernel.
			cl_int  openCL_searchMode       = searchMode;
			cl_uint openCL_numTripcodeChunk = numTripcodeChunk;
			OPENCL_ERROR(clSetKernelArg(kernel, 0, sizeof(cl_int),  (void *)&openCL_searchMode));
			OPENCL_ERROR(clSetKernelArg(kernel, 1, sizeof(cl_mem),  (void *)&openCL_outputArray));
			OPENCL_ERROR(clSetKernelArg(kernel, 2, sizeof(cl_mem),  (void *)&openCL_keyInfo));
			OPENCL_ERROR(clSetKernelArg(kernel, 3, sizeof(cl_mem),  (void *)&openCL_tripcodeChunkArray));
			OPENCL_ERROR(clSetKernelArg(kernel, 4, sizeof(cl_uint), (void *)&openCL_numTripcodeChunk));
			OPENCL_ERROR(clSetKernelArg(kernel, 5, sizeof(cl_mem),  (void *)&openCL_smallChunkBitmap));
			OPENCL_ERROR(clSetKernelArg(kernel, 6, sizeof(cl_mem),  (void *)&openCL_compactMediumChunkBitmap));
			OPENCL_ERROR(clSetKernelArg(kernel, 7, sizeof(cl_mem),  (void *)&openCL_chunkBitmap));
			OPENCL_ERROR(clSetKernelArg(kernel, 8, sizeof(cl_mem),  (void *)&openCL_partialKeyFrom3To6Array));
			OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_tripcodeChunkArray,   CL_TRUE, 0, sizeof(uint32_t) * numTripcodeChunk, tripcodeChunkArray,   0, NULL, NULL));
			OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_smallChunkBitmap,       CL_TRUE, 0, SMALL_CHUNK_BITMAP_SIZE,                   smallChunkBitmap,       0, NULL, NULL));
			OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_compactMediumChunkBitmap,       CL_TRUE, 0, MEDIUM_CHUNK_BITMAP_SIZE / 8,     compactMediumChunkBitmap,       0, NULL, NULL));
			OPENCL_ERROR(clEnqueueWriteBuffer(commandQueue, openCL_chunkBitmap,            CL_TRUE, 0, CHUNK_BITMAP_SIZE,                         chunkBitmap,            0, NULL, NULL));

			execCounter = 16384 + ((int32_t)RandomByte() * 32 - 128 * 32);;
			firstBuild = FALSE;
		}

		// Set the first character of the key.
		do {
			for (int32_t i = 3; i < lenTripcode; ++i)
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
		uint32_t keyFrom00To27 =   ((keyInfo.partialKeyAndRandomBytes[0] & 0x7f) << 0)
			                          | ((keyInfo.partialKeyAndRandomBytes[1] & 0x7f) << 7)
									  | ((keyInfo.partialKeyAndRandomBytes[2] & 0x7f) << 14)
									  | ((keyInfo.partialKeyAndRandomBytes[3] & 0x7f) << 21);
		OPENCL_ERROR(clSetKernelArg(kernel, 9, sizeof(uint32_t), (void *)&keyFrom00To27));

		// Generate random bytes for the keyInfo.partialKeyAndRandomBytes to ensure the randomness of generated keys.
		for (int32_t i = 4; i < lenTripcode; ++i)
			keyInfo.partialKeyAndRandomBytes[i] = RandomByte();
		
		// Generate part of the keys.
		for (int32_t i = 0; i < globalWorkSize; ++i) {
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
		for (uint32_t indexOutput = 0; indexOutput < sizeOutputArray; indexOutput++){
			GPUOutput *output = &outputArray[indexOutput];
			ASSERT(output->numGeneratedTripcodes <= 32);
			ASSERT(output->numMatchingTripcodes <= 1);
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
		endingTime = TIME_SINCE_EPOCH_IN_MILLISECONDS;
		deltaTime = (endingTime - startingTime) * 0.001;
		while (GetPauseState() && !GetTerminationState())
			Sleep(PAUSE_INTERVAL);
		startingTime = TIME_SINCE_EPOCH_IN_MILLISECONDS;
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

