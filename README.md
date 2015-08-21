Meriken's Tripcode Engine
=========================

"Meriken's Tripcode Engine" is an Windows application designed to brute-force tripcodes at maximum speed. 
It is arguably the fastest and most powerful program of its kind. It makes effecitive use of available computing power of CPUs and GPUs, 
and the user can specify flexible regex patterns for tripcodes. It features highly optimized, extensively parallelized 
implementations of bitslice DES and SHA-1 for SSE2, AVX, AVX2, CUDA, and OpenCL.

Meriken's Tripcode Engine is developed with the following tools:
* Visual Studio 2010 Professional
* CUDA Toolkit 7.5 RC
* AMD APP SDK 2.8
* YASM 1.2.0

This program uses Multiple Precision Integers and Rationals (MPIR). Make sure to copy MPIR header and library files into appropriate Visual Studio folders.