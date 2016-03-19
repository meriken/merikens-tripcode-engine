Meriken's Tripcode Engine
=========================

"Meriken's Tripcode Engine" is a Windows application designed to generate custom/vanity tripcodes at maximum speed. 
It is arguably the fastest and most powerful program of its kind. It makes effecitive use of available computing power of CPUs and GPUs, 
and the user can specify flexible regex patterns for tripcodes. It features highly optimized, extensively parallelized 
implementations of bitslice DES and SHA-1 for SSE2, AVX, AVX2, CUDA, and OpenCL.

This program is part of "Meriken's Tripcode Generator":
http://meriken.ygch.net/programming/merikens-tripcode-generator/

The English version of this program is available for free download here:
http://meriken.ygch.net/programming/merikens-tripcode-engine-english/

Meriken's Tripcode Engine is developed with the following tools:
* Visual Studio 2010 Professional
* CUDA Toolkit 7.5
* AMD APP SDK 3.0
* YASM 1.2.0

This program uses Multiple Precision Integers and Rationals (MPIR). Make sure to copy MPIR header and library files into appropriate Visual Studio folders.

See MerikensTripcodeEngine.h for various build options.