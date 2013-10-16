; Meriken's Tripcode Engine 1.1 Alpha 6
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
; The code that deals with SHA-1 hash generati8on is partially adopted from:
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

global DES_Crypt25_x64_AVX
global IsAVXSupported
global _xgetbv



;;;;;;;;;;
; Macros ;
;;;;;;;;;;

%define iterations                           rsi

%define data_blocks_source_address           rbx
%define data_blocks_destination_address      rdx

%define expanded_key_schedule_address        (rcx + expanded_key_schedule_offset)

%define vector_size 16

%define expansion_function_offset    0
%define expanded_key_schedule_offset (expansion_function_offset    + 96)
%define data_blocks_offset           (expanded_key_schedule_offset + 0x300 * vector_size)
%define temp_offset                  (data_blocks_offset           + 64    * vector_size)
%define keys_offset                  (temp_offset                  + 13    * vector_size)

%define data_blocks_destination(i) [data_blocks_destination_address + (i) * vector_size]
%define keys(i)                    [rcx + keys_offset               + (i) * vector_size]

%macro sbox1 4
	; From STF
	vpandn  xmm12, xmm4, xmm0
    vpxor   xmm9, xmm12, xmm3
    vpor    xmm15, xmm2, xmm5
    vpxor   xmm6, xmm0, xmm2
    vpand   xmm11, xmm15, xmm6
    vpxor   xmm7, xmm11, xmm3
    vpandn  xmm13, xmm9, xmm7
    vpandn  xmm10, xmm7, xmm4
    vpxor   xmm14, xmm4, xmm5
    vpxor   xmm8, xmm14, xmm2
    vpandn  xmm8, xmm8, xmm9
    vpor    xmm7, xmm11, xmm5
    vpxor   xmm7, xmm8, xmm7
    vpandn  xmm11, xmm13, xmm7
    vpor    xmm8, xmm0, xmm5
    vpor    xmm5, xmm7, xmm8
    vpor    xmm4, xmm9, xmm4
    vpandn  xmm8, xmm8, xmm3
    vpxor   xmm8, xmm10, xmm8
    vpandn  xmm6, xmm6, xmm14
    vpor    xmm3, xmm8, xmm6
    vpandn  xmm8, xmm12, xmm2
    vpxor   xmm6, xmm9, xmm5
    vpandn  xmm9, xmm8, xmm6
    vpcmpeqd    xmm6, xmm6, xmm6
    vpxor   xmm8, xmm9, xmm6
    vpand   xmm7, xmm15, xmm7
    vpxor   xmm6, xmm8, xmm7
    vpxor   xmm7, xmm10, xmm5
    vpandn  xmm12, xmm1, xmm7
    vpxor   xmm12, xmm12, xmm6
    vpxor   xmm12, xmm12, %3
    vmovdqa %3, xmm12
    vpxor   xmm7, xmm14, xmm9
    vpor    xmm7, xmm10, xmm7
    vpxor   xmm7, xmm15, xmm7
    vpxor   xmm0, xmm7, xmm0
    vpxor   xmm2, xmm6, xmm0
    vpor    xmm13, xmm13, xmm1
    vpxor   xmm13, xmm13, xmm2
    vpxor   xmm13, xmm13, %1
    vmovdqa %1, xmm13
    vpxor   xmm15, xmm15, xmm5
    vpor    xmm15, xmm15, xmm3
    vpxor   xmm15, xmm15, xmm0
    vpor    xmm7, xmm14, xmm2
    vpxor   xmm7, xmm15, xmm7
    vpor    xmm14, xmm11, xmm1
    vpxor   xmm14, xmm14, xmm7
    vpxor   xmm14, xmm14, %2
    vmovdqa %2, xmm14
    vpandn  xmm15, xmm15, xmm4
    vpand   xmm7, xmm11, xmm0
    vpxor   xmm15, xmm15, xmm7
    vpor    xmm15, xmm15, xmm1
    vpxor   xmm15, xmm15, xmm3
    vpxor   xmm15, xmm15, %4
    vmovdqa %4, xmm15
%endmacro

%macro sbox2 4
	; From STF
    vpxor   xmm13, xmm1, xmm4
    vpandn  xmm12, xmm5, xmm0
    vpandn  xmm12, xmm12, xmm4
    vpor    xmm10, xmm12, xmm1
    vpandn  xmm6, xmm5, xmm13
    vpand   xmm7, xmm13, xmm0
    vpxor   xmm7, xmm7, xmm4
    vpxor   xmm12, xmm12, xmm6
    vpandn  xmm15, xmm6, xmm7
    vpand   xmm14, xmm2, xmm5
    vpand   xmm6, xmm10, xmm12
    vpandn  xmm12, xmm14, xmm6
    vpand   xmm8, xmm2, xmm6
    vpcmpeqd    xmm6, xmm6, xmm6
    vpxor   xmm0, xmm0, xmm6
    vpxor   xmm6, xmm8, xmm0
    vpxor   xmm4, xmm8, xmm4
    vpxor   xmm5, xmm13, xmm5
    vpandn  xmm8, xmm14, xmm5
    vpxor   xmm0, xmm8, xmm6
    vpandn  xmm12, xmm12, xmm3
    vpxor   xmm12, xmm12, xmm0
    vpxor   xmm12, xmm12, %2
    vmovdqa %2, xmm12
    vpandn  xmm8, xmm8, xmm1
    vpxor   xmm12, xmm8, xmm7
    vpandn  xmm7, xmm12, xmm6
    vpxor   xmm11, xmm2, xmm5
    vpxor   xmm7, xmm11, xmm7
    vpandn  xmm13, xmm3, xmm10
    vpxor   xmm13, xmm13, xmm7
    vpxor   xmm13, xmm13, %1
    vmovdqa %1, xmm13
    vpandn  xmm7, xmm11, xmm1
    vpxor   xmm13, xmm10, xmm0
    vpxor   xmm7, xmm13, xmm7
    vpor    xmm7, xmm14, xmm7
    vpxor   xmm1, xmm11, xmm7
    vpandn  xmm7, xmm1, xmm2
    vpxor   xmm7, xmm15, xmm7
    vpor    xmm7, xmm12, xmm7
    vpxor   xmm2, xmm7, xmm4
    vpor    xmm14, xmm2, xmm3
    vpxor   xmm14, xmm14, xmm1
    vpxor   xmm14, xmm14, %3
    vmovdqa %3, xmm14
    vpandn  xmm2, xmm12, xmm2
    vpor    xmm7, xmm13, xmm5
    vpxor   xmm2, xmm2, xmm7
    vpor    xmm15, xmm15, xmm3
    vpxor   xmm15, xmm15, xmm2
    vpxor   xmm15, xmm15, %4
    vmovdqa %4, xmm15
%endmacro

%macro sbox3 4
	; From STF
    vpandn  xmm7, xmm11, xmm0
    vpxor   xmm15, xmm2, xmm5
    vpor    xmm12, xmm15, xmm7
    vpxor   xmm7, xmm3, xmm5
    vpandn  xmm6, xmm0, xmm7
    vpand   xmm13, xmm15, xmm7
    vpxor   xmm1, xmm12, xmm6
    vpxor   xmm9, xmm11, xmm15
    vpandn  xmm7, xmm5, xmm9
    vpxor   xmm14, xmm12, xmm7
    vpxor   xmm7, xmm0, xmm3
    vpor    xmm6, xmm6, xmm7
    vpxor   xmm7, xmm14, xmm7
    vpor    xmm7, xmm2, xmm7
    vpandn  xmm10, xmm13, xmm7
    vpand   xmm12, xmm5, xmm1
    vpor    xmm12, xmm12, xmm3
    vpand   xmm12, xmm12, xmm0
    vpxor   xmm7, xmm9, xmm12
    vpandn  xmm12, xmm4, xmm1
    vpxor   xmm12, xmm12, xmm7
    vpxor   xmm12, xmm12, %4
    vmovdqa %4, xmm12
    vpandn  xmm13, xmm14, xmm1
    vpandn  xmm14, xmm6, xmm7
    vpand   xmm3, xmm3, xmm5
    vpandn  xmm5, xmm11, xmm3
    vpxor   xmm14, xmm14, xmm5
    vpor    xmm11, xmm11, xmm2
    vpandn  xmm8, xmm2, xmm14
    vpor    xmm2, xmm9, xmm3
    vpandn  xmm8, xmm8, xmm2
    vpxor   xmm8, xmm8, xmm0
    vpand   xmm2, xmm10, xmm4
    vpxor   xmm2, xmm8, xmm2
    vpxor   xmm2, xmm2, %2
    vmovdqa %2, xmm2
    vpxor   xmm8, xmm9, xmm6
    vpcmpeqd    xmm3, xmm3, xmm3
    vpxor   xmm3, xmm8, xmm3
    vpandn  xmm8, xmm11, xmm1
    vpxor   xmm2, xmm8, xmm3
    vpandn  xmm8, xmm13, xmm4
    vpxor   xmm8, xmm8, xmm2
    vpxor   xmm8, xmm8, %1
    vmovdqa %1, xmm8
    vpxor   xmm0, xmm10, xmm0
    vpor    xmm0, xmm3, xmm0
    vpxor   xmm0, xmm1, xmm0
    vpxor   xmm0, xmm7, xmm0
    vpxor   xmm15, xmm11, xmm0
    vpor    xmm4, xmm14, xmm4
    vpxor   xmm15, xmm15, xmm4
    vpxor   xmm15, xmm15, %3
    vmovdqa %3, xmm15
%endmacro

%macro sbox4 4
	; From STF
    vpxor   xmm8, xmm0, xmm2
    vpxor   xmm2, xmm2, xmm4
    vpor    xmm9, xmm1, xmm3
    vpxor   xmm9, xmm9, xmm4
    vpandn  xmm9, xmm9, xmm2
    vpandn  xmm10, xmm1, xmm2
    vpxor   xmm7, xmm10, xmm3
    vpor    xmm6, xmm8, xmm7
    vpandn  xmm11, xmm9, xmm6
    vpxor   xmm0, xmm11, xmm1
    vpxor   xmm14, xmm1, xmm3
    vpand   xmm7, xmm0, xmm7
    vpandn  xmm6, xmm7, xmm2
    vpxor   xmm1, xmm8, xmm0
    vpandn  xmm6, xmm6, xmm1
    vpxor   xmm2, xmm9, xmm6
    vpor    xmm4, xmm10, xmm4
    vpxor   xmm3, xmm1, xmm4
    vpandn  xmm4, xmm14, xmm3
    vpxor   xmm4, xmm11, xmm4
    vpandn  xmm12, xmm2, xmm5
    vpxor   xmm12, xmm12, xmm4
    vpxor   xmm12, xmm12, %1
    vmovdqa %1, xmm12
    vpcmpeqd    xmm6, xmm6, xmm6
    vpxor   xmm4, xmm4, xmm6
    vpandn  xmm13, xmm5, xmm2
    vpxor   xmm13, xmm13, xmm4
    vpxor   xmm13, xmm13, %2
    vmovdqa %2, xmm13
    vpxor   xmm4, xmm2, xmm4
    vpandn  xmm4, xmm14, xmm4
    vpor    xmm4, xmm7, xmm4
    vpxor   xmm4, xmm3, xmm4
    vpor    xmm14, xmm0, xmm5
    vpxor   xmm14, xmm14, xmm4
    vpxor   xmm14, xmm14, %3
    vmovdqa %3, xmm14
    vpand   xmm5, xmm0, xmm5
    vpxor   xmm5, xmm4, xmm5
    vpxor   xmm5, xmm5, %4
    vmovdqa %4, xmm5
%endmacro

%macro sbox5 4
	; From STF
    vpor    xmm0, xmm10, xmm2
    vpandn  xmm7, xmm5, xmm0
    vpxor   xmm15, xmm10, xmm7
    vpandn  xmm8, xmm3, xmm7
    vpxor   xmm7, xmm15, xmm2
    vpor    xmm13, xmm7, xmm3
    vpxor   xmm2, xmm8, xmm2
    vpor    xmm11, xmm10, xmm7
    vpand   xmm7, xmm4, xmm2
    vpxor   xmm8, xmm11, xmm7
    vpxor   xmm8, xmm8, xmm3
    vpxor   xmm5, xmm8, xmm5
    vpor    xmm7, xmm15, xmm5
    vpand   xmm6, xmm7, xmm4
    vpandn  xmm14, xmm10, xmm7
    vpxor   xmm12, xmm15, xmm6
    vpand   xmm7, xmm11, xmm3
    vpxor   xmm12, xmm12, xmm7
    vpxor   xmm9, xmm14, xmm2
    vpxor   xmm4, xmm13, xmm4
    vpandn  xmm9, xmm9, xmm4
    vpcmpeqd    xmm7, xmm7, xmm7
    vpxor   xmm7, xmm9, xmm7
    vpandn  xmm7, xmm1, xmm7
    vpxor   xmm7, xmm8, xmm7
    vpxor   xmm7, xmm7, %3
    vmovdqa %3, xmm7
    vpandn  xmm8, xmm6, xmm2
    vpxor   xmm7, xmm14, xmm4
    vpor    xmm7, xmm12, xmm7
    vpandn  xmm8, xmm8, xmm7
    vpxor   xmm0, xmm8, xmm0
    vpxor   xmm14, xmm10, xmm0
    vpand   xmm0, xmm8, xmm5
    vpandn  xmm8, xmm8, xmm13
    vpxor   xmm4, xmm0, xmm4
    vpand   xmm0, xmm11, xmm2
    vpor    xmm0, xmm4, xmm0
    vpxor   xmm0, xmm6, xmm0
    vpand   xmm0, xmm0, xmm1
    vpxor   xmm0, xmm12, xmm0
    vpxor   xmm0, xmm0, %4
    vmovdqa %4, xmm0
    vpand   xmm3, xmm3, xmm4
    vpxor   xmm14, xmm14, xmm3
    vpor    xmm3, xmm8, xmm1
    vpxor   xmm3, xmm14, xmm3
    vpxor   xmm3, xmm3, %1
    vmovdqa %1, xmm3
    vpxor   xmm3, xmm13, xmm2
    vpandn  xmm0, xmm14, xmm3
    vpxor   xmm3, xmm15, xmm4
    vpxor   xmm3, xmm0, xmm3
    vpand   xmm1, xmm13, xmm1
    vpxor   xmm1, xmm1, xmm3
    vpxor   xmm1, xmm1, %2
    vmovdqa %2, xmm1
%endmacro

%macro sbox6 4
	; From STF
    vpxor   xmm7, xmm1, xmm4
    vpor    xmm9, xmm1, xmm5
    vpand   xmm10, xmm9, xmm0
    vpxor   xmm8, xmm10, xmm7
    vpxor   xmm7, xmm8, xmm5
    vpandn  xmm12, xmm7, xmm4
    vpand   xmm7, xmm0, xmm7
    vpxor   xmm6, xmm1, xmm7
    vpxor   xmm9, xmm5, xmm7
    vpxor   xmm13, xmm0, xmm2
    vpor    xmm7, xmm13, xmm6
    vpxor   xmm11, xmm8, xmm7
    vpxor   xmm15, xmm1, xmm7
    vpor    xmm1, xmm13, xmm1
    vpandn  xmm13, xmm15, xmm5
    vpxor   xmm13, xmm13, xmm2
    vpxor   xmm7, xmm13, xmm0
    vpand   xmm9, xmm9, xmm7
    vpand   xmm7, xmm11, xmm2
    vpor    xmm2, xmm12, xmm6
    vpandn  xmm6, xmm5, xmm7
    vpxor   xmm14, xmm6, xmm2
    vpor    xmm0, xmm11, xmm0
    vpand   xmm0, xmm2, xmm0
    vpand   xmm2, xmm14, xmm3
    vpxor   xmm2, xmm11, xmm2
    vpxor   xmm2, xmm2, %4
    vmovdqa %4, xmm2
    vpxor   xmm9, xmm9, xmm7
    vpandn  xmm7, xmm7, xmm4
    vpor    xmm7, xmm13, xmm7
    vpxor   xmm0, xmm13, xmm0
    vpandn  xmm6, xmm6, xmm0
    vpor    xmm2, xmm12, xmm3
    vpxor   xmm2, xmm2, xmm6
    vpxor   xmm2, xmm2, %3
    vmovdqa %3, xmm2
    vpor    xmm10, xmm10, xmm7
    vpxor   xmm2, xmm10, xmm1
    vpxor   xmm10, xmm14, xmm2
    vpxor   xmm8, xmm8, xmm0
    vpandn  xmm8, xmm8, xmm4
    vpxor   xmm15, xmm15, xmm1
    vpcmpeqd    xmm6, xmm6, xmm6
    vpxor   xmm4, xmm15, xmm6
    vpxor   xmm2, xmm8, xmm4
    vpandn  xmm2, xmm3, xmm2
    vpxor   xmm2, xmm10, xmm2
    vpxor   xmm2, xmm2, %2
    vmovdqa %2, xmm2
    vpxor   xmm1, xmm9, xmm4
    vpandn  xmm3, xmm3, xmm7
    vpxor   xmm3, xmm3, xmm1
    vpxor   xmm3, xmm3, %1
    vmovdqa %1, xmm3
%endmacro

%macro sbox7 4
	; From STF
    vpxor   xmm10, xmm3, xmm4
    vpand   xmm9, xmm10, xmm3
    vpxor   xmm8, xmm10, xmm5
    vpxor   xmm7, xmm10, xmm12
    vpandn  xmm15, xmm7, xmm4
    vpandn  xmm10, xmm8, xmm7
    vpand   xmm7, xmm5, xmm7
    vpxor   xmm2, xmm9, xmm1
    vpand   xmm13, xmm7, xmm2
    vpand   xmm6, xmm9, xmm5
    vpxor   xmm11, xmm12, xmm6
    vpor    xmm6, xmm11, xmm2
    vpxor   xmm6, xmm8, xmm6
    vpandn  xmm14, xmm13, xmm0
    vpxor   xmm14, xmm14, xmm6
    vpxor   xmm14, xmm14, %4
    vmovdqa %4, xmm14
    vpxor   xmm14, xmm8, xmm7
    vpandn  xmm14, xmm14, xmm3
    vpandn  xmm14, xmm14, xmm2
    vpor    xmm2, xmm15, xmm2
    vpxor   xmm11, xmm11, xmm7
    vpxor   xmm13, xmm2, xmm11
    vpxor   xmm11, xmm11, xmm4
    vpxor   xmm14, xmm14, xmm11
    vpor    xmm7, xmm9, xmm6
    vpand   xmm9, xmm14, xmm12
    vpor    xmm2, xmm7, xmm9
    vpxor   xmm7, xmm2, xmm10
    vpandn  xmm2, xmm0, xmm7
    vpxor   xmm2, xmm2, xmm13
    vpxor   xmm2, xmm2, %1
    vmovdqa %1, xmm2
    vpor    xmm10, xmm14, xmm7
    vpand   xmm5, xmm10, xmm5
    vpand   xmm1, xmm1, xmm5
    vpxor   xmm13, xmm13, xmm7
    vpxor   xmm1, xmm13, xmm1
    vpor    xmm9, xmm9, xmm1
    vpxor   xmm9, xmm9, xmm5
    vpxor   xmm4, xmm13, xmm4
    vpor    xmm9, xmm9, xmm4
    vpand   xmm4, xmm9, xmm0
    vpxor   xmm4, xmm14, xmm4
    vpxor   xmm4, xmm4, %3
    vmovdqa %3, xmm4
    vpxor   xmm5, xmm9, xmm5
    vpor    xmm9, xmm15, xmm5
    vpcmpeqd    xmm6, xmm6, xmm6
    vpxor   xmm2, xmm7, xmm6
    vpxor   xmm2, xmm9, xmm2
    vpandn  xmm0, xmm0, xmm2
    vpxor   xmm0, xmm0, xmm1
    vpxor   xmm0, xmm0, %2
    vmovdqa %2, xmm0
%endmacro

%macro sbox8 4
	; From STF
    vpandn  xmm15, xmm1, xmm2
    vpandn  xmm14, xmm2, xmm4
    vpxor   xmm14, xmm14, xmm3
    vpand   xmm7, xmm14, xmm0
    vpandn  xmm13, xmm15, xmm7
    vpandn  xmm9, xmm14, xmm1
    vpor    xmm12, xmm9, xmm0
    vpandn  xmm8, xmm2, xmm1
    vpxor   xmm10, xmm4, xmm8
    vpand   xmm8, xmm12, xmm10
    vpor    xmm11, xmm7, xmm8
    vpxor   xmm7, xmm14, xmm8
    vpcmpeqd    xmm6, xmm6, xmm6
    vpxor   xmm7, xmm7, xmm6
    vpandn  xmm12, xmm12, xmm2
    vpxor   xmm7, xmm7, xmm12
    vpxor   xmm15, xmm15, xmm7
    vpor    xmm2, xmm13, xmm5
    vpxor   xmm2, xmm2, xmm15
    vpxor   xmm2, xmm2, %2
    vmovdqa %2, xmm2
    vpxor   xmm12, xmm15, xmm0
    vpand   xmm2, xmm4, xmm12
    vpxor   xmm14, xmm7, xmm1
    vpxor   xmm2, xmm14, xmm2
    vpxor   xmm7, xmm11, xmm2
    vpxor   xmm15, xmm9, xmm2
    vpor    xmm1, xmm1, xmm7
    vpxor   xmm1, xmm12, xmm1
    vpor    xmm12, xmm12, xmm3
    vpor    xmm3, xmm3, xmm14
    vpxor   xmm14, xmm15, xmm3
    vpxor   xmm14, xmm10, xmm14
    vpxor   xmm3, xmm14, xmm0
    vpand   xmm3, xmm3, xmm5
    vpxor   xmm3, xmm15, xmm3
    vpxor   xmm3, xmm3, %4
    vmovdqa %4, xmm3
    vpxor   xmm4, xmm4, xmm1
    vpand   xmm3, xmm11, xmm5
    vpxor   xmm3, xmm3, xmm4
    vpxor   xmm3, xmm3, %3
    vmovdqa %3, xmm3
    vpandn  xmm4, xmm12, xmm4
    vpor    xmm4, xmm13, xmm4
    vpxor   xmm4, xmm14, xmm4
    vpor    xmm5, xmm4, xmm5
    vpxor   xmm5, xmm15, xmm5
    vpxor   xmm5, xmm5, %1
    vmovdqa %1, xmm5
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
	vmovdqa xmm11, keys(%14)
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

	vmovdqa xmm10, keys(%25)
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

	vmovdqa xmm0,  keys(%37)
	vmovdqa xmm1,  keys(%38)
	vmovdqa xmm12, keys(%39)
	vmovdqa xmm3,  keys(%40)
	vmovdqa xmm4,  keys(%41)
	vmovdqa xmm5,  keys(%42)
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



%macro save_xmm128_with_vmovdqa 2
	[savexmm128 %1, %2]
	vmovdqa [rsp + %2], %1
%endmacro



section .text
	PROC_FRAME DES_Crypt25_x64_AVX
		alloc_stack 0xb8
		save_xmm128_with_vmovdqa xmm6,  0x00
		save_xmm128_with_vmovdqa xmm7,  0x10
		save_xmm128_with_vmovdqa xmm8,  0x20
		save_xmm128_with_vmovdqa xmm9,  0x30
		save_xmm128_with_vmovdqa xmm10, 0x40
		save_xmm128_with_vmovdqa xmm11, 0x50
		save_xmm128_with_vmovdqa xmm12, 0x60
		save_xmm128_with_vmovdqa xmm13, 0x70
		save_xmm128_with_vmovdqa xmm14, 0x80
		save_xmm128_with_vmovdqa xmm15, 0x90
		save_reg rbx, 0xa0
		save_reg rsi, 0xa8
		save_reg rdi, 0xb0
	END_PROLOGUE	

		; ======================================

		; rcx: DES_Context *context

		lea data_blocks_source_address,      [rcx + data_blocks_offset]
		lea data_blocks_destination_address, [rcx + data_blocks_offset + 32 * vector_size]

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
		vmovdqa  xmm6,  [rsp+0x00]
		vmovdqa  xmm7,  [rsp+0x10]
		vmovdqa  xmm8,  [rsp+0x20]
		vmovdqa  xmm9,  [rsp+0x30]
		vmovdqa  xmm10, [rsp+0x40]
		vmovdqa  xmm11, [rsp+0x50]
		vmovdqa  xmm12, [rsp+0x60]
		vmovdqa  xmm13, [rsp+0x70]
		vmovdqa  xmm14, [rsp+0x80]
		vmovdqa  xmm15, [rsp+0x90]
		mov     rbx,   [rsp+0xa0]
		mov     rsi,   [rsp+0xa8]
		mov     rdi,   [rsp+0xb0]
		add     rsp, 0xb8
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
		vpxor   xmm10, [data_blocks_source_address + 0xffffffff]
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
		vpxor   xmm11, [data_blocks_source_address + 8 * vector_size]
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
		vpxor   xmm0,  [data_blocks_source_address + 23 * vector_size]
		vpxor   xmm1,  [data_blocks_source_address + 24 * vector_size]
		vpxor   xmm12, [data_blocks_source_address + 25 * vector_size]
		vpxor   xmm3,  [data_blocks_source_address + 26 * vector_size]
		vpxor   xmm4,  [data_blocks_source_address + 27 * vector_size]
		vpxor   xmm5,  [data_blocks_source_address + 28 * vector_size]
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

	ENDPROC_FRAME
	
	align 16
		db "THIS_IS_THE_END_OF_THE_FUNCTION",  0x00



		; int IsAVXSupported();
	IsAVXSupported:
		mov r10, rbx
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
		mov rbx, r10
		ret
	AVX_not_supported:
		xor eax, eax
		mov rbx, r10
		ret



	; int _xgetbv(int ecx);
	_xgetbv:
		xgetbv
		ret



	global TestASM
	PROC_FRAME TestASM
		alloc_stack 0xe8
		save_xmm128 xmm6,  0x00
		save_xmm128 xmm7,  0x10
		save_xmm128 xmm8,  0x20
		save_xmm128 xmm9,  0x30
		save_xmm128 xmm10, 0x40
		save_xmm128 xmm11, 0x50
		save_xmm128 xmm12, 0x60
		save_xmm128 xmm13, 0x70
		save_xmm128 xmm14, 0x80
		save_xmm128 xmm15, 0x90

		%define pnot  [rsp+0xa0]
		%define temp0 [rsp+0xb0]
		%define temp1 [rsp+0xc0]

		save_reg rbx, 0xd0
		save_reg rsi, 0xd8
		save_reg rdi, 0xe0
	END_PROLOGUE
		


		; ======================================
		
		 	jmp skip
		 	vpxor ymm0, [data_blocks_source_address + 0xffffffff]
		 	vpxor ymm1, [data_blocks_source_address + 0xffffffff]
			vpxor ymm2, [data_blocks_source_address + 0xffffffff]
			vpxor ymm3, [data_blocks_source_address + 0xffffffff]
			vpxor ymm4, [data_blocks_source_address + 0xffffffff]
			vpxor ymm5, [data_blocks_source_address + 0xffffffff]
			vpxor ymm6, [data_blocks_source_address + 0xffffffff]
			vpxor ymm7, [data_blocks_source_address + 0xffffffff]
			vpxor ymm8, [data_blocks_source_address + 0xffffffff]
			vpxor ymm9, [data_blocks_source_address + 0xffffffff]
			vpxor ymm10, [data_blocks_source_address + 0xffffffff]
			vpxor ymm11, [data_blocks_source_address + 0xffffffff]
			vpxor ymm12, [data_blocks_source_address + 0xffffffff]
			vpxor ymm13, [data_blocks_source_address + 0xffffffff]
			vpxor ymm14, [data_blocks_source_address + 0xffffffff]
			vpxor ymm15, [data_blocks_source_address + 0xffffffff]
		skip:

		; ======================================


	exit_TestAVX:
		vmovdqa  xmm6,  [rsp+0x00]
		vmovdqa  xmm7,  [rsp+0x10]
		vmovdqa  xmm8,  [rsp+0x20]
		vmovdqa  xmm9,  [rsp+0x30]
		vmovdqa  xmm10, [rsp+0x40]
		vmovdqa  xmm11, [rsp+0x50]
		vmovdqa  xmm12, [rsp+0x60]
		vmovdqa  xmm13, [rsp+0x70]
		vmovdqa  xmm14, [rsp+0x80]
		vmovdqa  xmm15, [rsp+0x90]
		mov     rbx,   [rsp+0xd0]
		mov     rsi,   [rsp+0xd8]
		mov     rdi,   [rsp+0xe0]
		add     rsp, 0xe8
		ret

	ENDPROC_FRAME

		db "THIS_IS_THE_END_OF_THE_FUNCTION",  0x00
