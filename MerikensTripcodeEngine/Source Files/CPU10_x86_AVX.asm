; Meriken's Tripcode Engine 1.1 Alpha 8
; Copyright (c) 2011-2013 ÅüMeriken//XXX <meriken.2ch@gmail.com>
;
; The initial versions of this software were based on:
; CUDA SHA-1 Tripper 0.2.1
; Copyright (c) 2009 ÅüHoro/.IBXjcg
; 
; The code that deals with DES decryption is partially adopted from:
; John the Ripper password cracker
; Copyright (c) 1996-2002, 2005, 2010 by Solar Designer
;
; The code that deals with SHA-1 hash generation is partially adopted from:
; sha_digest-2.2
; Copyright (C) 2009 Jens Thoms Toerring <jt@toerring.de>
; VecTripper 
; Copyright (C) 2011 tmkk <tmkk@smoug.net>
; 
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http:;www.gnu.org/licenses/>.

global _DES_Crypt25_x86_AVX
global _IsAVXSupported
global __xgetbv



;;;;;;;;;;
; Macros ;
;;;;;;;;;;

%define iterations                      esi

%define data_blocks_source_address      ebx
%define data_blocks_destination_address edx

%define expanded_key_schedule_address   (ecx + expanded_key_schedule_offset)

%define vector_size 16

%define expansion_function_offset    0
%define expanded_key_schedule_offset (expansion_function_offset    + 96)
%define data_blocks_offset           (expanded_key_schedule_offset + 0x300 * vector_size)
%define temp_offset                  (data_blocks_offset           + 64    * vector_size)
%define keys_offset                  (temp_offset                  + 13    * vector_size)

%define data_blocks_destination(i) [data_blocks_destination_address + (i) * vector_size]
%define keys(i)                    [ecx + keys_offset               + (i) * vector_size]
%define pnot                       [ecx + temp_offset]
%define tmp_at(i)                  [ecx + temp_offset + (i) * vector_size]

%macro sbox1 4
	vmovdqa tmp_at(1), xmm0                 ; [X]
	vmovdqa tmp_at(4), xmm4                 ; [X]
	vmovdqa tmp_at(2), xmm1                 ; [X]
	vpor    xmm7,      xmm5,      xmm2
	vmovdqa tmp_at(3), xmm3                 ; [X]
	vpxor   xmm6,      xmm2,      xmm0
	vmovdqa tmp_at(5), xmm7                 ; [X]
	vpandn  xmm4,      xmm0
	vpand   xmm1,      xmm6,      xmm7
	vpor    xmm7,      xmm1,      xmm5
	vpxor   xmm1,      xmm3
	vpxor   xmm3,      xmm4
	vmovdqa tmp_at(6), xmm1                 ; [X]
	vmovdqa xmm1,      xmm3                 ; [X]
	vpandn  xmm3,      tmp_at(6)
	vmovdqa tmp_at(7), xmm3                 ; [X]
	vpxor   xmm3,      xmm5,      tmp_at(4)
	vpor    xmm5,      xmm0
	vmovdqa tmp_at(8), xmm3                 ; [X]
	vpandn  xmm6,      xmm3
	vpxor   xmm3,      xmm2
	vpandn  xmm4,      xmm2
	vpandn  xmm3,      xmm1
	vpxor   xmm7,      xmm3
	vpor    xmm0,      xmm5,      xmm7
	vmovdqa xmm3,      tmp_at(7)            ; [X]
	vpandn  xmm5,      tmp_at(3)
	vpandn  xmm3,      xmm7
	vmovdqa tmp_at(9), xmm3                 ; [X]
	vpand   xmm7,      tmp_at(5)
	vmovdqa xmm3,      tmp_at(6)            ; [X]
	vpxor   xmm2,      xmm0,      xmm1
	vpandn  xmm3,      tmp_at(4)
	vpandn  xmm4,      xmm2
	vpxor   xmm7,      xmm4
	vpxor   xmm4,      tmp_at(8)
	vpxor   xmm5,      xmm3
	vpor    xmm4,      xmm3
	vpxor   xmm4,      tmp_at(1)
	vpxor   xmm3,      xmm0
	vmovdqa xmm2,      tmp_at(2)            ; [X]
	vpandn  xmm2,      xmm3
	vpxor   xmm0,      tmp_at(5)
	vmovdqa xmm3,      tmp_at(7)            ; [X]
	vpor    xmm3,      tmp_at(2)
	vpxor   xmm7,      pnot
	vpxor   xmm3,      %1
	vpxor   xmm2,      xmm7
	vpxor   xmm4,      tmp_at(5)
	vpxor   xmm2,      %3
	vpxor   xmm7,      xmm4
	vpxor   xmm3,      xmm7
	vmovdqa %1,        xmm3                 ; [X]
	vpor    xmm5,      xmm6
	vpor    xmm7,      tmp_at(8)
	vpor    xmm0,      xmm5
	vpxor   xmm7,      %2
	vpxor   xmm0,      xmm4
	vpxor   xmm7,      xmm0
	vpor    xmm1,      tmp_at(4)
	vpand   xmm4,      tmp_at(9)
	vpandn  xmm0,      xmm1
	vpxor   xmm4,      xmm0
	vmovdqa xmm3,      tmp_at(2)            ; [X]
	vpor    xmm3,      tmp_at(9)
	vpor    xmm4,      tmp_at(2)
	vmovdqa %3,        xmm2                 ; [X]
	vpxor   xmm7,      xmm3
	vpxor   xmm4,      xmm5
	vpxor   xmm4,      %4
	vmovdqa %2,        xmm7                 ; [X]
	vmovdqa %4,        xmm4                 ; [X]
%endmacro

%macro sbox2 4
	vmovdqa tmp_at(2), xmm2                 ; [X]
	vmovdqa tmp_at(1), xmm1                 ; [X]
	vpandn  xmm2,      xmm5,      xmm0
	vmovdqa tmp_at(4), xmm4                 ; [X]
	vmovdqa tmp_at(3), xmm3                 ; [X]
	vpandn  xmm2,      xmm4
	vmovdqa xmm6,      xmm0                 ; [X]
	vpxor   xmm0,      pnot
	vpor    xmm7,      xmm2,      xmm1
	vpxor   xmm1,      xmm4
	vmovdqa tmp_at(5), xmm7                 ; [X]
	vpand   xmm6,      xmm1
	vpxor   xmm6,      xmm4
	vpandn  xmm7,      xmm5,      xmm1
	vpxor   xmm2,      xmm7
	vpandn  xmm7,      xmm6
	vpxor   xmm1,      xmm5
	vmovdqa tmp_at(7), xmm7                 ; [X]
	vmovdqa xmm7,      xmm5                 ; [X]
	vpand   xmm5,      tmp_at(2)            ; [X]
	vpandn  xmm7,      xmm5,      xmm1
	vmovdqa tmp_at(8), xmm5                 ; [X]
	vpand   xmm2,      tmp_at(5)
	vpandn  xmm5,      xmm2
	vpand   xmm2,      tmp_at(2)
	vpandn  xmm5,      tmp_at(3)
	vpxor   xmm0,      xmm2
	vpandn  xmm4,      xmm3,      tmp_at(5)
	vpxor   xmm3,      xmm7,      xmm0
	vpxor   xmm5,      %2
	vpandn  xmm7,      tmp_at(1)
	vpxor   xmm7,      xmm6
	vpxor   xmm5,      xmm3
	vmovdqa %2,        xmm5                 ; [X]
	vpandn  xmm6,      xmm7,      xmm0
	vpxor   xmm3,      tmp_at(5)
	vpxor   xmm6,      xmm4
	vpxor   xmm0,      xmm1,      tmp_at(2)
	vpxor   xmm6,      xmm0
	vmovdqa xmm4,      xmm0                 ; [X]
	vpxor   xmm6,      %1
	vpandn  xmm0,      tmp_at(1)
	vpxor   xmm2,      tmp_at(4)
	vpxor   xmm0,      xmm3
	vmovdqa %1,        xmm6                 ; [X]
	vpor    xmm3,      xmm1
	vpor    xmm0,      tmp_at(8)
	vpxor   xmm0,      xmm4
	vmovdqa xmm4,      xmm0                 ; [X]
	vpandn  xmm0,      tmp_at(2)
	vmovdqa xmm6,      tmp_at(3)            ; [X]
	vpxor   xmm0,      tmp_at(7)
	vpor    xmm0,      xmm7
	vpor    xmm5,      xmm6,      tmp_at(7)
	vpxor   xmm2,      xmm0
	vpandn  xmm7,      xmm2
	vpor    xmm6,      xmm2
	vpxor   xmm7,      %4
	vpxor   xmm6,      xmm4
	vpxor   xmm6,      %3
	vpxor   xmm7,      xmm5
	vpxor   xmm7,      xmm3
	vmovdqa %3,        xmm6                 ; [X]
	vmovdqa %4,        xmm7                 ; [X]
%endmacro

%macro sbox3 4
	vmovdqa tmp_at(1), xmm0                 ; [X]
	vmovdqa tmp_at(2), xmm1                 ; [X]
	vmovdqa xmm7,      xmm0                 ; [X]
	vpandn  xmm1,      xmm0
	vmovdqa tmp_at(3), xmm2                 ; [X]
	vpxor   xmm0,      xmm5,     xmm2
	vmovdqa tmp_at(4), xmm4                 ; [X]
	vpxor   xmm2,      xmm5,     xmm3
	vpor    xmm1,      xmm0
	vpxor   xmm4,      xmm0,     tmp_at(2)
	vpandn  xmm7,      xmm2
	vmovdqa tmp_at(5), xmm7                 ; [X]
	vpxor   xmm7,      xmm1
	vpandn  xmm6,      xmm5,     xmm4
	vmovdqa tmp_at(6), xmm7                 ; [X]
	vpxor   xmm1,      xmm6
	vpand   xmm2,      xmm0
	vpxor   xmm0,      xmm3,     tmp_at(1)
	vpandn  xmm6,      xmm1,     xmm7
	vpand   xmm7,      xmm5
	vpand   xmm5,      xmm3
	vpor    xmm7,      xmm3
	vpand   xmm7,      tmp_at(1)
	vmovdqa xmm3,      tmp_at(4)            ; [X]
	vpandn  xmm3,      tmp_at(6)
	vpxor   xmm7,      xmm4
	vmovdqa tmp_at(7), xmm7                 ; [X]
	vpxor   xmm7,      xmm3
	vmovdqa xmm3,      tmp_at(2)            ; [X]
	vpxor   xmm7,      %4
	vpxor   xmm1,      xmm0
	vmovdqa %4,        xmm7                 ; [X]
	vmovdqa xmm7,      tmp_at(3)            ; [X]
	vpor    xmm1,      tmp_at(3)
	vpandn  xmm2,      xmm1
	vpor    xmm0,      tmp_at(5)
	vpandn  xmm1,      xmm0,      tmp_at(7)
	vpandn  xmm3,      xmm5
	vpor    xmm5,      xmm4
	vpxor   xmm1,      xmm3
	vpor    xmm7,      tmp_at(2)
	vmovdqa xmm3,      tmp_at(3)            ; [X]
	vpandn  xmm3,      xmm1
	vpxor   xmm0,      xmm4
	vpandn  xmm3,      xmm5
	vpxor   xmm3,      tmp_at(1)
	vpand   xmm5,      xmm2,     tmp_at(4)
	vpxor   xmm0,      pnot
	vpxor   xmm3,      xmm5
	vpxor   xmm5,      xmm7,     tmp_at(6)
	vpxor   xmm3,      %2
	vpandn  xmm6,      tmp_at(4)
	vpandn  xmm7,      tmp_at(6)
	vpxor   xmm6,      xmm0
	vmovdqa %2,        xmm3                 ; [X]
	vpxor   xmm2,      tmp_at(1)
	vpor    xmm1,      tmp_at(4)
	vpor    xmm0,      xmm2
	vpxor   xmm0,      xmm1
	vpxor   xmm6,      %1
	vpxor   xmm5,      %3
	vpxor   xmm0,      tmp_at(7)
	vpxor   xmm6,      xmm7
	vpxor   xmm0,      xmm5
	vmovdqa %1,        xmm6                 ; [X]
	vmovdqa %3,        xmm0                 ; [X]
%endmacro

%macro sbox4 4
	vmovdqa xmm7,      xmm1                 ; [X]
	vpxor   xmm0,      xmm2
	vpor    xmm1,      xmm3
	vpxor   xmm2,      xmm4
	vmovdqa tmp_at(2), xmm5                 ; [X]
	vpxor   xmm1,      xmm4
	vmovdqa xmm6,      xmm7                 ; [X]
	vmovdqa xmm5,      xmm7                 ; [X]
	vpandn  xmm7,      xmm2
	vpandn  xmm1,      xmm2
	vpor    xmm4,      xmm7
	vpxor   xmm7,      xmm3
	vmovdqa xmm6,      xmm7                 ; [X]
	vpor    xmm7,      xmm0
	vpxor   xmm3,      xmm5
	vmovdqa tmp_at(3), xmm1                 ; [X]
	vpandn  xmm1,      xmm7
	vmovdqa xmm7,      xmm1                 ; [X]
	vpxor   xmm1,      xmm5
	vpand   xmm6,      xmm1
	vmovdqa xmm5,      xmm6                 ; [X]
	vpxor   xmm0,      xmm1
	vpandn  xmm6,      xmm2
	vpandn  xmm6,      xmm0
	vpxor   xmm4,      xmm0
	vmovdqa xmm0,      xmm3                 ; [X]
	vpandn  xmm3,      xmm4
	vmovdqa xmm2,      tmp_at(2)            ; [X]
	vpxor   xmm3,      xmm7
	vpxor   xmm6,      tmp_at(3)
	vmovdqa xmm7,      xmm6                 ; [X]
	vpandn  xmm6,      xmm2
	vpxor   xmm6,      %1
	vpandn  xmm2,      xmm7
	vpxor   xmm2,      %2
	vpxor   xmm6,      xmm3
	vpxor   xmm3,      pnot
	vpxor   xmm2,      xmm3
	vpxor   xmm3,      xmm7
	vmovdqa %1,        xmm6                 ; [X]
	vpandn  xmm0,      xmm3
	vpor    xmm0,      xmm5
	vmovdqa %2,        xmm2                 ; [X]
	vpor    xmm3,      xmm1,      tmp_at(2)
	vpand   xmm1,      tmp_at(2)
	vpxor   xmm0,      xmm4
	vpxor   xmm3,      xmm0
	vpxor   xmm3,      %3
	vpxor   xmm0,      xmm1
	vmovdqa %3,        xmm3                 ; [X]
	vpxor   xmm0,      %4
	vmovdqa %4,        xmm0                 ; [X]
%endmacro

%macro sbox5 4
	vmovdqa tmp_at(3), xmm2                 ; [X]
	vmovdqa tmp_at(1), xmm0                 ; [X]
	vpor    xmm2,      xmm0
	vmovdqa xmm6,      xmm5                 ; [X]
	vmovdqa tmp_at(4), xmm2                 ; [X]
	vpandn  xmm5,      xmm2
	vmovdqa xmm7,      xmm2                 ; [X]
	vmovdqa xmm2,      xmm5                 ; [X]
	vpxor   xmm5,      xmm0
	vmovdqa xmm7,      xmm3                 ; [X]
	vmovdqa tmp_at(5), xmm5                 ; [X]
	vpxor   xmm5,      tmp_at(3)
	vmovdqa tmp_at(2), xmm1                 ; [X]
	vpor    xmm0,      xmm5
	vpor    xmm5,      xmm3
	vpandn  xmm3,      xmm2
	vpxor   xmm3,      tmp_at(3)
	vmovdqa tmp_at(6), xmm3                 ; [X]
	vpand   xmm1,      xmm0,      tmp_at(6)
	vpand   xmm3,      xmm4
	vpxor   xmm3,      xmm0
	vpand   xmm0,      xmm7
	vpxor   xmm3,      xmm7
	vmovdqa tmp_at(3), xmm3                 ; [X]
	vpxor   xmm6,      xmm3
	vmovdqa xmm2,      xmm6                 ; [X]
	vpor    xmm6,      tmp_at(5)
	vmovdqa xmm3,      xmm6                 ; [X]
	vpand   xmm6,      xmm4
	vmovdqa tmp_at(7), xmm6                 ; [X]
	vpxor   xmm6,      tmp_at(5)
	vpxor   xmm0,      xmm6
	vmovdqa xmm6,      tmp_at(1)            ; [X]
	vmovdqa tmp_at(8), xmm0                 ; [X]
	vpandn  xmm6,      xmm3
	vmovdqa xmm0,      tmp_at(2)            ; [X]
	vpxor   xmm4,      xmm5
	vpxor   xmm3,      xmm6,      xmm4
	vpxor   xmm6,      tmp_at(6)
	vpandn  xmm6,      xmm4
	vpxor   xmm6,      pnot
	vpandn  xmm0,      xmm6
	vpxor   xmm0,      tmp_at(3)
	vmovdqa xmm6,      tmp_at(7)            ; [X]
	vpandn  xmm6,      tmp_at(6)
	vpxor   xmm0,      %3
	vmovdqa %3,        xmm0                 ; [X]
	vpor    xmm3,      tmp_at(8)
	vpxor   xmm0,      xmm5,      tmp_at(6)
	vpandn  xmm6,      xmm3
	vpand   xmm2,      xmm6
	vpxor   xmm3,      xmm6,      tmp_at(4)
	vpandn  xmm6,      xmm5
	vpxor   xmm2,      xmm4
	vpor    xmm1,      xmm2
	vpxor   xmm1,      tmp_at(7)
	vpand   xmm7,      xmm2
	vpand   xmm1,      tmp_at(2)
	vpxor   xmm7,      tmp_at(1)
	vpxor   xmm1,      tmp_at(8)
	vpxor   xmm3,      xmm7
	vpor    xmm6,      tmp_at(2)
	vpxor   xmm1,      %4
	vmovdqa %4,        xmm1                 ; [X]
	vpxor   xmm2,      tmp_at(5)
	vpxor   xmm6,      xmm3
	vpandn  xmm3,      xmm0
	vpand   xmm5,      tmp_at(2)
	vpxor   xmm3,      xmm2
	vpxor   xmm5,      %2
	vpxor   xmm3,      xmm5
	vpxor   xmm6,      %1
	vmovdqa %2,        xmm3                 ; [X]
	vmovdqa %1,        xmm6                 ; [X]
%endmacro

%macro sbox6 4
	vmovdqa tmp_at(2), xmm4                 ; [X]
	vpxor   xmm4,      xmm1
	vmovdqa tmp_at(3), xmm5                 ; [X]
	vpor    xmm5,      xmm1
	vmovdqa xmm7,      xmm2                 ; [X]
	vpand   xmm5,      xmm0
	vpxor   xmm2,      xmm0
	vmovdqa tmp_at(1), xmm0                 ; [X]
	vpxor   xmm4,      xmm5
	vmovdqa tmp_at(4), xmm4                 ; [X]
	vpxor   xmm4,      tmp_at(3)
	vpand   xmm6,      xmm4,      xmm0
	vpandn  xmm4,      tmp_at(2)
	vmovdqa tmp_at(5), xmm6                 ; [X]
	vpxor   xmm6,      xmm1
	vmovdqa tmp_at(6), xmm6                 ; [X]
	vpor    xmm6,      xmm2
	vmovdqa tmp_at(7), xmm6                 ; [X]
	vpxor   xmm6,      tmp_at(4)
	vmovdqa xmm0,      xmm6                 ; [X]
	vpand   xmm6,      xmm7
	vmovdqa tmp_at(8), xmm6                 ; [X]
	vmovdqa xmm6,      tmp_at(3)            ; [X]
	vpor    xmm2,      xmm1
	vpandn  xmm6,      tmp_at(8)
	vmovdqa tmp_at(9), xmm6                 ; [X]
	vpor    xmm6,      xmm4,      tmp_at(6)
	vmovdqa tmp_at(6), xmm6                 ; [X]
	vpxor   xmm6,      tmp_at(9)
	vmovdqa tmp_at(10),xmm6                 ; [X]
	vpand   xmm6,      xmm3
	vpxor   xmm6,      %4
	vpxor   xmm6,      xmm0
	vpor    xmm0,      tmp_at(1)
	vmovdqa %4,        xmm6                 ; [X]
	vpxor   xmm6,      xmm1,      tmp_at(7)
	vmovdqa tmp_at(7), xmm6                 ; [X]
	vpandn  xmm6,      tmp_at(3)
	vpxor   xmm6,      xmm7
	vmovdqa xmm7,      tmp_at(8)            ; [X]
	vmovdqa tmp_at(12),xmm6                 ; [X]
	vpandn  xmm7,      tmp_at(2)
	vpand   xmm0,      tmp_at(6)
	vpor    xmm7,      xmm6
	vpandn  xmm1,      xmm3,      xmm7
	vpxor   xmm0,      xmm6
	vmovdqa xmm6,      tmp_at(9)            ; [X]
	vpor    xmm4,      xmm3
	vpandn  xmm6,      xmm0
	vpor    xmm5,      xmm7
	vpxor   xmm6,      xmm4
	vpxor   xmm0,      tmp_at(4)
	vpxor   xmm6,      %3
	vpxor   xmm5,      xmm2
	vmovdqa %3,        xmm6                 ; [X]
	vmovdqa xmm6,      tmp_at(5)            ; [X]
	vpandn  xmm0,      tmp_at(2)
	vpxor   xmm2,      pnot
	vpxor   xmm2,      tmp_at(7)
	vpxor   xmm6,      tmp_at(3)
	vpxor   xmm5,      %2
	vmovdqa xmm4,      tmp_at(12)           ; [X]
	vpxor   xmm0,      xmm2
	vpxor   xmm4,      tmp_at(1)
	vpxor   xmm5,      tmp_at(10)
	vpand   xmm4,      xmm6
	vpandn  xmm3,      xmm0
	vpxor   xmm4,      %1
	vpxor   xmm4,      tmp_at(8)
	vpxor   xmm1,      xmm2
	vpxor   xmm5,      xmm3
	vmovdqa %2,        xmm5                 ; [X]
	vpxor   xmm4,      xmm1
	vmovdqa %1,        xmm4                 ; [X]
%endmacro

%macro sbox7 4
	vmovdqa tmp_at(1), xmm0                 ; [X]
	vmovdqa tmp_at(3), xmm4                 ; [X]
	vmovdqa xmm0,      xmm4                 ; [X]
	vpxor   xmm4,      xmm3
	vmovdqa tmp_at(4), xmm5                 ; [X]
	vmovdqa xmm7,      xmm4                 ; [X]
	vmovdqa tmp_at(2), xmm3                 ; [X]
	vpxor   xmm4,      xmm2
	vmovdqa tmp_at(5), xmm4                 ; [X]
	vpand   xmm4,      xmm5
	vpxor   xmm5,      xmm7,      tmp_at(4)
	vpand   xmm7,      xmm3
	vmovdqa tmp_at(6), xmm7                 ; [X]
	vpand   xmm6,      xmm7,      tmp_at(4)
	vpxor   xmm7,      xmm1
	vpxor   xmm6,      xmm2
	vmovdqa tmp_at(7), xmm7                 ; [X]
	vmovdqa xmm3,      tmp_at(1)            ; [X]
	vpxor   xmm0,      xmm6,      xmm4
	vpor    xmm6,      xmm7
	vpand   xmm7,      xmm4
	vpxor   xmm6,      xmm5
	vpandn  xmm7,      xmm3
	vpxor   xmm7,      %4
	vpxor   xmm4,      xmm5
	vpxor   xmm7,      xmm6
	vmovdqa %4,        xmm7                 ; [X]
	vpandn  xmm4,      tmp_at(2)
	vpor    xmm6,      tmp_at(6)
	vmovdqa xmm7,      tmp_at(5)            ; [X]
	vpandn  xmm7,      tmp_at(3)
	vpandn  xmm4,      tmp_at(7)
	vmovdqa tmp_at(9), xmm7                 ; [X]
	vpor    xmm7,      tmp_at(7)
	vpandn  xmm5,      tmp_at(5)
	vpxor   xmm7,      xmm0
	vpxor   xmm0,      tmp_at(3)
	vpxor   xmm0,      xmm4
	vmovdqa xmm4,      tmp_at(1)            ; [X]
	vpand   xmm2,      xmm0
	vpor    xmm6,      xmm2
	vpxor   xmm6,      xmm5
	vpandn  xmm3,      xmm6
	vmovdqa xmm5,      xmm6                 ; [X]
	vpxor   xmm3,      xmm7
	vpxor   xmm7,      xmm6
	vpor    xmm6,      xmm0
	vpxor   xmm3,      %1
	vpand   xmm6,      tmp_at(4)
	vpxor   xmm5,      pnot
	vpand   xmm1,      xmm6
	vpxor   xmm0,      %3
	vpxor   xmm1,      xmm7
	vmovdqa %1,        xmm3                 ; [X]
	vmovdqa xmm3,      xmm4                 ; [X]
	vpxor   xmm7,      tmp_at(3)
	vpor    xmm2,      xmm1
	vpxor   xmm2,      xmm6
	vpor    xmm7,      xmm2
	vpand   xmm4,      xmm7
	vpxor   xmm7,      xmm6
	vpor    xmm7,      tmp_at(9)
	vpxor   xmm7,      xmm5
	vpxor   xmm1,      %2
	vpandn  xmm3,      xmm7
	vpxor   xmm0,      xmm4
	vmovdqa %3,        xmm0                 ; [X]
	vpxor   xmm1,      xmm3
	vmovdqa %2,        xmm1                 ; [X]
%endmacro

%macro sbox8 4
	vpandn  xmm7,      xmm2,      xmm1
	vmovdqa tmp_at(1), xmm1                 ; [X]
	vpandn  xmm1,      xmm2
	vmovdqa tmp_at(2), xmm2                 ; [X]
	vpandn  xmm2,      xmm4
	vmovdqa tmp_at(5), xmm5                 ; [X]
	vpxor   xmm2,      xmm3
	vmovdqa tmp_at(4), xmm4                 ; [X]
	vmovdqa xmm5,      xmm1                 ; [X]
	vmovdqa tmp_at(3), xmm3                 ; [X]
	vpxor   xmm3,      xmm2,      pnot
	vpandn  xmm4,      xmm2,      tmp_at(1)  
	vpand   xmm2,      xmm0
	vpandn  xmm1,      xmm2
	vpxor   xmm7,      tmp_at(4)
	vmovdqa xmm6,      xmm4                 ; [X]
	vpor    xmm4,      xmm0
	vmovdqa tmp_at(6), xmm7                 ; [X]
	vpand   xmm7,      xmm4
	vpor    xmm2,      xmm7
	vpxor   xmm3,      xmm7
	vpandn  xmm4,      tmp_at(2)
	vpxor   xmm3,      xmm4
	vpor    xmm7,      xmm1,      tmp_at(5)
	vpxor   xmm5,      xmm3
	vpxor   xmm7,      xmm5
	vpxor   xmm5,      xmm0
	vpxor   xmm7,      %2
	vmovdqa %2,        xmm7                 ; [X]
	vpxor   xmm3,      tmp_at(1)
	vmovdqa xmm4,      xmm5                 ; [X]
	vpand   xmm5,      tmp_at(4)
	vpxor   xmm5,      xmm3
	vpor    xmm3,      tmp_at(3)
	vpxor   xmm6,      xmm5
	vpxor   xmm3,      tmp_at(6)
	vpxor   xmm5,      xmm2
	vpxor   xmm3,      xmm6
	vpor    xmm5,      tmp_at(1)
	vpxor   xmm0,      xmm3
	vpxor   xmm5,      xmm4
	vpor    xmm4,      tmp_at(3)
	vpxor   xmm5,      tmp_at(4)
	vpand   xmm2,      tmp_at(5)
	vpandn  xmm4,      xmm5
	vpand   xmm0,      tmp_at(5)
	vpxor   xmm0,      xmm6
	vpor    xmm4,      xmm1
	vpxor   xmm0,      %4
	vpxor   xmm3,      xmm4
	vpxor   xmm2,      %3
	vpor    xmm3,      tmp_at(5)
	vpxor   xmm3,      %1
	vpxor   xmm2,      xmm5
	vpxor   xmm3,      xmm6
	vmovdqa %4,        xmm0                 ; [X]
	vmovdqa %3,        xmm2                 ; [X]
	vmovdqa %1,        xmm3                 ; [X]
%endmacro



%macro round 48
	vmovdqa xmm0, keys(%1)
	vmovdqa xmm1, keys(%2)
	vmovdqa xmm2, keys(%3)
	vmovdqa xmm3, keys(%4)
	vmovdqa xmm4, keys(%5)
	vmovdqa xmm5, keys(%6)
	call sbox1_func

	vmovdqa xmm0, keys(%7)
	vmovdqa xmm1, keys(%8)
	vmovdqa xmm2, keys(%9)
	vmovdqa xmm3, keys(%10)
	vmovdqa xmm4, keys(%11)
	vmovdqa xmm5, keys(%12)
	call sbox2_func

	vmovdqa xmm0, keys(%13)
	vmovdqa xmm1, keys(%14)
	vmovdqa xmm2, keys(%15)
	vmovdqa xmm3, keys(%16)
	vmovdqa xmm4, keys(%17)
	vmovdqa xmm5, keys(%18)
	call sbox3_func

	vmovdqa xmm0, keys(%19)
	vmovdqa xmm1, keys(%20)
	vmovdqa xmm2, keys(%21)
	vmovdqa xmm3, keys(%22)
	vmovdqa xmm4, keys(%23)
	vmovdqa xmm5, keys(%24)
	call sbox4_func

	vmovdqa xmm0, keys(%25)
	vmovdqa xmm1, keys(%26)
	vmovdqa xmm2, keys(%27)
	vmovdqa xmm3, keys(%28)
	vmovdqa xmm4, keys(%29)
	vmovdqa xmm5, keys(%30)
	call sbox5_func

	vmovdqa xmm0, keys(%31)
	vmovdqa xmm1, keys(%32)
	vmovdqa xmm2, keys(%33)
	vmovdqa xmm3, keys(%34)
	vmovdqa xmm4, keys(%35)
	vmovdqa xmm5, keys(%36)
	call sbox6_func

	vmovdqa xmm0, keys(%37)
	vmovdqa xmm1, keys(%38)
	vmovdqa xmm2, keys(%39)
	vmovdqa xmm3, keys(%40)
	vmovdqa xmm4, keys(%41)
	vmovdqa xmm5, keys(%42)
	call sbox7_func

	vmovdqa xmm0, keys(%43)
	vmovdqa xmm1, keys(%44)
	vmovdqa xmm2, keys(%45)
	vmovdqa xmm3, keys(%46)
	vmovdqa xmm4, keys(%47)
	vmovdqa xmm5, keys(%48)
	call sbox8_func

	xchg data_blocks_source_address, data_blocks_destination_address
%endmacro



section .text
	_DES_Crypt25_x86_AVX:
		push ebp
		mov  ebp, esp
		; sub  esp, 4
		push ebx
		push esi
		push edi

		; ======================================

		mov ecx, [ebp + 8]

		pcmpeqd xmm0, xmm0
		vmovdqa pnot, xmm0

		lea data_blocks_source_address,      [ecx + data_blocks_offset]
		lea data_blocks_destination_address, [ecx + data_blocks_offset + 32 * vector_size]

		mov iterations, 25

	start:
		round 12, 46, 33, 52, 48, 20, 34, 55,  5, 13, 18, 40,  4, 32, 26, 27, 38, 54, 53,  6, 31, 25, 19, 41, 15, 24, 28, 43, 30,  3, 35, 22,  2, 44, 14, 23, 51, 16, 29, 49,  7, 17, 37,  8,  9, 50, 42, 21
		round  5, 39, 26, 45, 41, 13, 27, 48, 53,  6, 11, 33, 52, 25, 19, 20, 31, 47, 46, 54, 55, 18, 12, 34,  8, 17, 21, 36, 23, 49, 28, 15, 24, 37,  7, 16, 44,  9, 22, 42,  0, 10, 30,  1,  2, 43, 35, 14
		round 46, 25, 12, 31, 27, 54, 13, 34, 39, 47, 52, 19, 38, 11,  5,  6, 48, 33, 32, 40, 41,  4, 53, 20, 51,  3,  7, 22,  9, 35, 14,  1, 10, 23, 50,  2, 30, 24,  8, 28, 43, 49, 16, 44, 17, 29, 21,  0
		round 32, 11, 53, 48, 13, 40, 54, 20, 25, 33, 38,  5, 55, 52, 46, 47, 34, 19, 18, 26, 27, 45, 39,  6, 37, 42, 50,  8, 24, 21,  0, 44, 49,  9, 36, 17, 16, 10, 51, 14, 29, 35,  2, 30,  3, 15,  7, 43
		round 18, 52, 39, 34, 54, 26, 40,  6, 11, 19, 55, 46, 41, 38, 32, 33, 20,  5,  4, 12, 13, 31, 25, 47, 23, 28, 36, 51, 10,  7, 43, 30, 35, 24, 22,  3,  2, 49, 37,  0, 15, 21, 17, 16, 42,  1, 50, 29
		round  4, 38, 25, 20, 40, 12, 26, 47, 52,  5, 41, 32, 27, 55, 18, 19,  6, 46, 45, 53, 54, 48, 11, 33,  9, 14, 22, 37, 49, 50, 29, 16, 21, 10,  8, 42, 17, 35, 23, 43,  1,  7,  3,  2, 28, 44, 36, 15
		round 45, 55, 11,  6, 26, 53, 12, 33, 38, 46, 27, 18, 13, 41,  4,  5, 47, 32, 31, 39, 40, 34, 52, 19, 24,  0,  8, 23, 35, 36, 15,  2,  7, 49, 51, 28,  3, 21,  9, 29, 44, 50, 42, 17, 14, 30, 22,  1
		round 31, 41, 52, 47, 12, 39, 53, 19, 55, 32, 13,  4, 54, 27, 45, 46, 33, 18, 48, 25, 26, 20, 38,  5, 10, 43, 51,  9, 21, 22,  1, 17, 50, 35, 37, 14, 42,  7, 24, 15, 30, 36, 28,  3,  0, 16,  8, 44
		round 55, 34, 45, 40,  5, 32, 46, 12, 48, 25,  6, 52, 47, 20, 38, 39, 26, 11, 41, 18, 19, 13, 31, 53,  3, 36, 44,  2, 14, 15, 51, 10, 43, 28, 30,  7, 35,  0, 17,  8, 23, 29, 21, 49, 50,  9,  1, 37
		round 41, 20, 31, 26, 46, 18, 32, 53, 34, 11, 47, 38, 33,  6, 55, 25, 12, 52, 27,  4,  5, 54, 48, 39, 42, 22, 30, 17,  0,  1, 37, 49, 29, 14, 16, 50, 21, 43,  3, 51,  9, 15,  7, 35, 36, 24, 44, 23
		round 27,  6, 48, 12, 32,  4, 18, 39, 20, 52, 33, 55, 19, 47, 41, 11, 53, 38, 13, 45, 46, 40, 34, 25, 28,  8, 16,  3, 43, 44, 23, 35, 15,  0,  2, 36,  7, 29, 42, 37, 24,  1, 50, 21, 22, 10, 30,  9
		round 13, 47, 34, 53, 18, 45,  4, 25,  6, 38, 19, 41,  5, 33, 27, 52, 39, 55, 54, 31, 32, 26, 20, 11, 14, 51,  2, 42, 29, 30,  9, 21,  1, 43, 17, 22, 50, 15, 28, 23, 10, 44, 36,  7,  8, 49, 16, 24
		round 54, 33, 20, 39,  4, 31, 45, 11, 47, 55,  5, 27, 46, 19, 13, 38, 25, 41, 40, 48, 18, 12,  6, 52,  0, 37, 17, 28, 15, 16, 24,  7, 44, 29,  3,  8, 36,  1, 14,  9, 49, 30, 22, 50, 51, 35,  2, 10
		round 40, 19,  6, 25, 45, 48, 31, 52, 33, 41, 46, 13, 32,  5, 54, 55, 11, 27, 26, 34,  4, 53, 47, 38, 43, 23,  3, 14,  1,  2, 10, 50, 30, 15, 42, 51, 22, 44,  0, 24, 35, 16,  8, 36, 37, 21, 17, 49
		round 26,  5, 47, 11, 31, 34, 48, 38, 19, 27, 32, 54, 18, 46, 40, 41, 52, 13, 12, 20, 45, 39, 33, 55, 29,  9, 42,  0, 44, 17, 49, 36, 16,  1, 28, 37,  8, 30, 43, 10, 21,  2, 51, 22, 23,  7,  3, 35
		round 19, 53, 40,  4, 55, 27, 41, 31, 12, 20, 25, 47, 11, 39, 33, 34, 45,  6,  5, 13, 38, 32, 26, 48, 22,  2, 35, 50, 37, 10, 42, 29,  9, 51, 21, 30,  1, 23, 36,  3, 14, 24, 44, 15, 16,  0, 49, 28

		xchg data_blocks_source_address, data_blocks_destination_address

		sub iterations, 1
		jnz start

		; ======================================

	exit:
		pop edi
		pop esi
		pop ebx
		mov esp, ebp
		pop ebp
		ret

	align 16
	sbox1_func:
		vpxor   xmm0, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm1, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm2, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm3, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm4, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm5, [data_blocks_source_address + 0xffffffff]
		sbox1 data_blocks_destination(8), data_blocks_destination(16), data_blocks_destination(22), data_blocks_destination(30)
		ret

	align 16
	sbox2_func:
		vpxor   xmm0, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm1, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm2, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm3, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm4, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm5, [data_blocks_source_address + 0xffffffff]
		sbox2 data_blocks_destination(12), data_blocks_destination(27), data_blocks_destination(1), data_blocks_destination(17)
		ret

	align 16
	sbox5_func:
		vpxor   xmm0, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm1, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm2, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm3, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm4, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm5, [data_blocks_source_address + 0xffffffff]
		sbox5 data_blocks_destination(7), data_blocks_destination(13), data_blocks_destination(24), data_blocks_destination(2)
		ret

	align 16
	sbox6_func:
		vpxor   xmm0, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm1, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm2, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm3, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm4, [data_blocks_source_address + 0xffffffff]
		vpxor   xmm5, [data_blocks_source_address + 0xffffffff]
		sbox6 data_blocks_destination(3), data_blocks_destination(28), data_blocks_destination(10), data_blocks_destination(18)
		ret

	align 16
	sbox3_func:
		vpxor   xmm0, [data_blocks_source_address + 7 * vector_size]
		vpxor   xmm1, [data_blocks_source_address + 8 * vector_size]
		vpxor   xmm2, [data_blocks_source_address + 9 * vector_size]
		vpxor   xmm3, [data_blocks_source_address + 10 * vector_size]
		vpxor   xmm4, [data_blocks_source_address + 11 * vector_size]
		vpxor   xmm5, [data_blocks_source_address + 12 * vector_size]
		sbox3 data_blocks_destination(23), data_blocks_destination(15), data_blocks_destination(29), data_blocks_destination(5)
		ret

	align 16
	sbox4_func:
		vpxor   xmm0, [data_blocks_source_address + 11 * vector_size]
		vpxor   xmm1, [data_blocks_source_address + 12 * vector_size]
		vpxor   xmm2, [data_blocks_source_address + 13 * vector_size]
		vpxor   xmm3, [data_blocks_source_address + 14 * vector_size]
		vpxor   xmm4, [data_blocks_source_address + 15 * vector_size]
		vpxor   xmm5, [data_blocks_source_address + 16 * vector_size]
		sbox4 data_blocks_destination(25), data_blocks_destination(19), data_blocks_destination(9), data_blocks_destination(0)
		ret

	align 16
	sbox7_func:
		vpxor   xmm0, [data_blocks_source_address + 23 * vector_size]
		vpxor   xmm1, [data_blocks_source_address + 24 * vector_size]
		vpxor   xmm2, [data_blocks_source_address + 25 * vector_size]
		vpxor   xmm3, [data_blocks_source_address + 26 * vector_size]
		vpxor   xmm4, [data_blocks_source_address + 27 * vector_size]
		vpxor   xmm5, [data_blocks_source_address + 28 * vector_size]
		sbox7 data_blocks_destination(31), data_blocks_destination(11), data_blocks_destination(21), data_blocks_destination(6)
		ret

	align 16
	sbox8_func:
		vpxor   xmm0, [data_blocks_source_address + 27 * vector_size]
		vpxor   xmm1, [data_blocks_source_address + 28 * vector_size]
		vpxor   xmm2, [data_blocks_source_address + 29 * vector_size]
		vpxor   xmm3, [data_blocks_source_address + 30 * vector_size]
		vpxor   xmm4, [data_blocks_source_address + 31 * vector_size]
		vpxor   xmm5, [data_blocks_source_address +  0 * vector_size]
		sbox8 data_blocks_destination(4), data_blocks_destination(26), data_blocks_destination(14), data_blocks_destination(20)
		ret

		db "THIS_IS_THE_END_OF_THE_FUNCTION",  0x00



		; int IsAVXSupported();
	_IsAVXSupported:
		push ebx
		xor eax, eax
		cpuid
		cmp eax, 1 ; does CPUID support eax = 1?
		jb AVX_not_supported
		mov eax, 1
		cpuid
		and ecx, 018000000h ;check 27 bit (OS uses XSAVE/XRSTOR)
		cmp ecx, 018000000h ; and 28 (AVX supported by CPU)
		jne AVX_not_supported
		xor ecx, ecx ; XFEATURE_ENABLED_MASK/XCR0 register number = 0
		xgetbv ; XFEATURE_ENABLED_MASK register is in edx:eax
		and eax, 110b
		cmp eax, 110b ; check the AVX registers restore at context switch
		jne AVX_not_supported
		mov eax, 1
		pop ebx
		ret
	AVX_not_supported:
		xor eax, eax
		pop ebx
		ret



	__xgetbv:
		push ebp
		mov ebp, esp

		mov ecx, [ebp + 8]
		xgetbv

		mov esp, ebp
		pop ebp
		ret

