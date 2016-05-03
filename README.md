﻿Meriken's Tripcode Engine
=========================

*I am currently working on a cross-platform version of this application.* "Meriken's Tripcode Engine" is a Windows application designed to generate custom/vanity tripcodes at maximum speed. 
It is arguably the fastest and most powerful program of its kind. It makes effecitive use of available computing power of CPUs and GPUs, 
and the user can specify flexible regex patterns for tripcodes. It features highly optimized, extensively parallelized 
implementations of bitslice DES and SHA-1 for OpenCL, AMD GCN, NVIDIA CUDA, and Intel SSE2/AVX/AVX2.

The English version of this program is available for free download here:

http://meriken.ygch.net/programming/merikens-tripcode-engine-english/

This program is part of "Meriken's Tripcode Generator," a GUI-based tripcode generator targeted primarily to users in Japan:

http://meriken.ygch.net/programming/merikens-tripcode-generator/

## Performance

Here are some actual speeds the author achieved with this tripcode generator:

* AMD Radeon HD 7990 **1022MH/s** (descrypt; 1250mV +20% 1180MHz)
* NVIDIA GeForce GTX 980 Ti **996MH/s** (descrypt; 110% +250MHz)
* AMD Radeon HD 290X **647M tripcode/s** (descrypt; +100mV +50% 1074MHz)
* AMD Radeon HD 7970 **408M tripcode/s** (descrypt; 1000MHz)

Currently [MTY CL][2] is the only practical alternative to this program, and this program runs much faster than MTY CL in most cases.

[2]: https://github.com/madsbuvi/MTY_CL

## Donations

I would really appreciate donations as it is quite expensive to buy hardware for testing.
I am also working on the English version of my tripcode search service and would like to add more servers.

* PayPal: `meriken.ygch.net@gmail.com`
* Bitcoin: `1BZrWADRhLr9DyQYYRJhRcmudE3vntT5em`

## Building

You need the following tools to build Meriken's Tripcode Engine.

* Visual Studio 2013 Community
* CUDA Toolkit 7.5
* AMD APP SDK 3.0
* YASM 1.2.0

This program uses Boost 1.60.0 and Boost Process. Make sure to copy Boost files into appropriate Visual Studio folders.

See `MerikensTripcodeEngine.h` for various build options. Don't forget to define `ENGLISH_VERSION` if you want to build an English version for 4chan.

## Dependencies

You need the following software installed in order to run the application:

* [AMD Radeon Desktop Video Card Driver][4]
  (if you are using an AMD graphics card)
* [NVIDIA Display Driver Version 352.78 or later][5]
  (if you are using an NVIDIA graphics card)

[4]: http://support.amd.com/en-us/download
[5]: http://www.nvidia.com/Download/index.aspx?lang=en-us

## Usage

Make sure to download and install the required software packages before 
executing the program. If there is no OpenCL driver in the system, make sure to copy
either `OpenCL\x86\OpenCL.dll` or `OpenCL\x64\OpenCL.dll`,
depending on the operating system, to the folder where 
the executables are located.

Specify search patterns in `patterns.txt` and run either
`MerikensTripcodeEngine.exe`, if you are using a 32-bit operating system, or
`MerikensTripcodeEngine64.exe`, if you are using a 64-bit operating system.
Matching tripcodes will be displayed and saved in `tripcodes.txt`.

Example of `patterns.txt`:

```
# Meriken's Tripcode Engine English
# Copyright (c) 2011-2016 !/Meriken/. <meriken.ygch.net@gmail.com>
#
# - Specify only one pattern in each line.
# - Patterns must be at least 5 characters in length.
# - Patterns that are too long will be ignored.
# - Strings after '#' are treated as comments.



# Specify non-regex patterns after the "#noregex" directive.
# You can only use [A-Za-z0-9./] for patterns.

#noregex

TEST/                   # Matches "!TEST/UH3.F", "!TEST/ZXVew", etc.



# Specify regex patterns after the "#regex" directive.
# The following operators and specifiers are available for use:
# 
#     ^ $ () | [] [^] . + * ? \ {n} {m,n} \n
#     [:alpha:] [:upper:] [:lower:] [:digit:] [:alnum:] [:punct:]
# 
# It is encouraged to use '^' whenever possible to achieve maximum
# search speed.

#regex

#^TEST/                 # Matches "!TEST/UH3.F", "!TEST/ZXVew", etc.
#/TEST$                 # Matches "!15ycs/TEST", "!wtra5/TEST", etc.
#/TEST/                 # Matches "!y/TEST/5uj", "!anj/TEST/.", etc.
#^[0-9]*$               # Matches "!8710915015", "!9104552720", etc.
#^([:upper:]{5})\1$     # Matches "!IOPAFIOPAF", "!UIABTUIABT", etc.
#^[Mm]eriken[:punct:]   # Matches "!meriken/u6", "!Meriken.qe", etc.



#ignore
Lines between "#ignore" are "#endignore" will be ignored.
#endignore



# You cannot specify a pattern in the last line.
```

## Options

**-g** : Use GPUs as search devices. (This option can be used in combination with "-c".)

**-d** [device number] : Specify a GPU to use.

**-c** : Use CPUs as search devices. (This option can be used in combination with "-g".)

**-l** [length of tripcodes] : Specify either 10 or 12. (Please note that you can use 12 character tripcodes only at 2ch.net.)

**-t** [number of threads]   : Specify the number of CPU search threads.

**-o** [output file] : Specify an output file.

**-f** [input file] : Specify an input file.

**--use-one-and-two-byte-characters-for-keys** : Use Shift-JIS characters for keys.

**--disable-gcn-assembler** : Disable GCN assembler and use OpenCL kernels instead.

## License

Meriken's Tripcode Engine is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Meriken's Tripcode Engine is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Meriken's Tripcode Engine.  If not, see <http://www.gnu.org/licenses/>.

Copyright © 2016 ◆/Meriken/.