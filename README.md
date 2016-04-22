Meriken's Tripcode Engine
=========================

The English version of this program is available for free download here:
http://meriken.ygch.net/programming/merikens-tripcode-engine-english/

This program is part of "Meriken's Tripcode Generator," a GUI-based tripcode generator targeted primarily to users in Japan:
http://meriken.ygch.net/programming/merikens-tripcode-generator/

"Meriken's Tripcode Engine" is a Windows application designed to generate custom/vanity tripcodes at maximum speed. 
It is arguably the fastest and most powerful program of its kind. It makes effecitive use of available computing power of CPUs and GPUs, 
and the user can specify flexible regex patterns for tripcodes. It features highly optimized, extensively parallelized 
implementations of bitslice DES and SHA-1 for OpenCL, AMD GCN, NVIDIA CUDA, and Intel SSE2/AVX/AVX2.

Building
--------

You need the following tools to build Meriken's Tripcode Engine.

* Visual Studio 2010 Professional
* CUDA Toolkit 7.5
* AMD APP SDK 3.0
* YASM 1.2.0

This program uses Multiple Precision Integers and Rationals (MPIR). Make sure to copy MPIR header and library files into appropriate Visual Studio folders.

See MerikensTripcodeEngine.h for various build options. Don't forget to define ENGLISH_VERSION if you want to build an English version for 4chan.