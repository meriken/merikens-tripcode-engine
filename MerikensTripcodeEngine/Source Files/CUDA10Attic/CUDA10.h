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



#define CUDA_DES_BS_DEPTH                   32
#define CUDA_DES_NUM_THREADS_PER_BLOCK      128
#define CUDA_DES_NUM_THREADS_FOR_BITSLICE   4
#define CUDA_DES_NUM_BITSLICE_DES_CONTEXTS_PER_BLOCK (CUDA_DES_NUM_THREADS_PER_BLOCK / CUDA_DES_NUM_THREADS_FOR_BITSLICE)

typedef int           DES_ARCH_WORD;
typedef int           DES_ARCH_WORD_32;
#define DES_ARCH_SIZE 4
#define DES_ARCH_BITS 32

typedef int           DES_Vector;
// #define CUDA_DES_BS_DEPTH  DES_ARCH_BITS
#define DES_VECTOR_ZERO               0
#define DES_VECTOR_ONES               ~(DES_Vector)0

#define DES_VECTOR_NOT(dst, a)        (dst) =  ~(a)
#define DES_VECTOR_AND(dst, a, b)     (dst) =   (a) &  (b)
#define DES_VECTOR_OR(dst, a, b)      (dst) =   (a) |  (b)
#define DES_VECTOR_AND_NOT(dst, a, b) (dst) =   (a) & ~(b)
#define DES_VECTOR_XOR_NOT(dst, a, b) (dst) = ~((a) ^  (b))
#define DES_VECTOR_NOT_OR(dst, a, b)  (dst) = ~((a) |  (b))
#define DES_VECTOR_SEL(dst, a, b, c)  (dst) = (((a) & ~(c)) ^ ((b) & (c)))
#define DES_VECTOR_XOR_FUNC(a, b)              ((a) ^  (b))
#define DES_VECTOR_XOR(dst, a, b)     (dst) = DES_VECTOR_XOR_FUNC((a), (b))
#define DES_VECTOR_SET(dst, ofs, src) *((DES_Vector *)((DES_Vector *)&(dst) + ((ofs) << DB_SHIFT))) = (src)

#define DES_CONSTANT_QUALIFIERS      __device__ __constant__
#define DES_FUNCTION_QUALIFIERS      __device__ __forceinline__
#define DES_SBOX_FUNCTION_QUALIFIERS __device__ __forceinline__



#define CUDA_DES_LAUNCH_KERNEL_ARGS \
	int intSalt, \
	dim3 dimGrid, \
	dim3 dimBlock, \
	unsigned char *key,               \
	unsigned char   *expansionFunction, \
	unsigned char *key7Array, \
	DES_Vector *keyFrom49To55Array, \
	GPUOutput     *CUDA_outputArray, \
	unsigned char  *CUDA_keyBitmap, \
	unsigned int  *CUDA_tripcodeChunkArray, \
	unsigned int    keyFrom00To27\

#define CUDA_DES_PERFORM_SEARCH_ARGS \
	CUDA_outputArray, \
	CUDA_keyBitmap, \
	CUDA_tripcodeChunkArray, \
	numTripcodeChunk, \
	keyFrom00To27, \
	searchMode

#define CUDA_DES_PERFORM_SEARCH_ARGS CUDA_outputArray, CUDA_keyBitmap, CUDA_tripcodeChunkArray, numTripcodeChunk, keyFrom00To27, searchMode

extern void CUDA_DES_InitializeKernelLauncher0();
extern void CUDA_DES_InitializeKernelLauncher1();
extern void CUDA_DES_InitializeKernelLauncher2();
extern void CUDA_DES_InitializeKernelLauncher3();
extern void CUDA_DES_InitializeKernelLauncher4();
extern void CUDA_DES_InitializeKernelLauncher5();
extern void CUDA_DES_InitializeKernelLauncher6();
extern void CUDA_DES_InitializeKernelLauncher7();

extern void CUDA_DES_LaunchKernel0(CUDA_DES_LAUNCH_KERNEL_ARGS);
extern void CUDA_DES_LaunchKernel1(CUDA_DES_LAUNCH_KERNEL_ARGS);
extern void CUDA_DES_LaunchKernel2(CUDA_DES_LAUNCH_KERNEL_ARGS);
extern void CUDA_DES_LaunchKernel3(CUDA_DES_LAUNCH_KERNEL_ARGS);
extern void CUDA_DES_LaunchKernel4(CUDA_DES_LAUNCH_KERNEL_ARGS);
extern void CUDA_DES_LaunchKernel5(CUDA_DES_LAUNCH_KERNEL_ARGS);
extern void CUDA_DES_LaunchKernel6(CUDA_DES_LAUNCH_KERNEL_ARGS);
extern void CUDA_DES_LaunchKernel7(CUDA_DES_LAUNCH_KERNEL_ARGS);
