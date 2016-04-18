/*
 * Meriken's Tripcode Engine
 * Copyright (c) 2011-2016 /Meriken/. <meriken.ygch.net@gmail.com>
 *
 * The initial versions of this software were based on:
 * CUDA DES Tripper 0.2.1
 * Copyright (c) 2009 Horo/.IBXjcg
 * 
 * The code that deals with DES decryption is partially adopted from:
 * John the Ripper password cracker
 * Copyright (c) 1996-2002, 2005, 2010 by Solar Designer
 * DeepLearningJohnDoe's fork of Meriken's Tripcode Engine
 * Copyright (c) 2015 by <deeplearningjohndoe at gmail.com>
 *
 * The code that deals with DES hash generation is partially adopted from:
 * sha_digest-2.2
 * Copyright (C) 2009 Jens Thoms Toerring <jt@toerring.de>
 * VecTripper 
 * Copyright (C) 2011 tmkk <tmkk@smoug.net>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: *www.gnu.org/licenses/>.
 */



.kernel OpenCL_DES_PerformSearching
    .header
        .byte 0x10, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .byte 0x10, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .byte 0x08, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
        .fill 8, 1, 0x00
    .metadata
        .ascii ";ARGSTART:__OpenCL_OpenCL_DES_PerformSearching_kernel\n"
        .ascii ";version:3:1:111\n"
        /* .ascii ";device:hawaii\n" */
        .ascii ";uniqueid:1024\n"
        .ascii ";memory:uavprivate:272\n"
        .ascii ";memory:hwlocal:0\n"
        .ascii ";memory:hwregion:0\n"
        .ascii ";value:searchMode:i32:1:1:0\n"
        .ascii ";pointer:outputArray:struct:1:1:16:uav:12:32:RW:0:0\n"
        .ascii ";pointer:keyInfo:opaque:1:1:32:c:11:4:RO:0:0\n"
        .ascii ";pointer:tripcodeChunkArray:u32:1:1:48:uav:13:4:RO:0:0\n"
        .ascii ";constarg:3:tripcodeChunkArray\n"
        .ascii ";value:numTripcodeChunk:u32:1:1:64\n"
        .ascii ";pointer:smallChunkBitmap:u8:1:1:80:c:14:1:RO:0:0\n"
        .ascii ";constarg:5:smallChunkBitmap\n"
        .ascii ";pointer:compactMediumChunkBitmap:u32:1:1:96:c:11:4:RO:0:0\n"
        .ascii ";constarg:6:compactMediumChunkBitmap\n"
        .ascii ";pointer:chunkBitmap:u8:1:1:112:uav:15:1:RO:0:0\n"
        .ascii ";constarg:7:chunkBitmap\n"
        .ascii ";pointer:partialKeyFrom3To6Array:struct:1:1:128:uav:16:4:RO:0:0\n"
        .ascii ";constarg:8:partialKeyFrom3To6Array\n"
        .ascii ";value:keyFrom00To27:u32:1:1:144\n"
        .ascii ";function:1:1028\n"
        .ascii ";memory:64bitABI\n"
        .ascii ";uavid:11\n"
        .ascii ";printfid:9\n"
        .ascii ";cbid:10\n"
        .ascii ";privateid:8\n"
        .ascii ";reflection:0:int\n"
        .ascii ";reflection:1:GPUOutput*\n"
        .ascii ";reflection:2:KeyInfo*\n"
        .ascii ";reflection:3:uint*\n"
        .ascii ";reflection:4:uint\n"
        .ascii ";reflection:5:uchar*\n"
        .ascii ";reflection:6:uint*\n"
        .ascii ";reflection:7:uchar*\n"
        .ascii ";reflection:8:PartialKeyFrom3To6*\n"
        .ascii ";reflection:9:uint\n"
        .ascii ";ARGEND:__OpenCL_OpenCL_DES_PerformSearching_kernel\n"
    .data
        .fill 4736, 1, 0x00
    .inputs
    .outputs
    .uav
        .entry 12, 4, 0, 5
        .entry 13, 4, 0, 5
        .entry 15, 4, 0, 5
        .entry 16, 4, 0, 5
        .entry 8, 3, 0, 5
    .condout 0
    .floatconsts
    .intconsts
    .boolconsts
    .earlyexit 0
    .globalbuffers
    .constantbuffers
        .cbmask 0, 0
        .cbmask 1, 0
        .cbmask 11, 0
        .cbmask 14, 0
        .cbmask 11, 0
    .inputsamplers
    .scratchbuffers
        .int 0x00000044
    .persistentbuffers
    .proginfo
        .entry 0x80001000, 0x00000004
        .entry 0x80001001, 0x00000018
        .entry 0x80001002, 0x00000000
        .entry 0x80001003, 0x00000000
        .entry 0x80001004, 0x00000002
        .entry 0x80001005, 0x00000017
        .entry 0x80001006, 0x00000000
        .entry 0x80001007, 0x00000002
        .entry 0x80001008, 0x00000002
        .entry 0x80001009, 0x00000002
        .entry 0x8000100a, 0x00000000
        .entry 0x8000100b, 0x00000004
        .entry 0x8000100c, 0x00000004
        .entry 0x8000100d, 0x00000002
        .entry 0x8000100e, 0x00000001
        .entry 0x8000100f, 0x00000008
        .entry 0x80001010, 0x00000004
        .entry 0x80001041, 0x00000080
        .entry 0x80001042, 0x00000066
        .entry 0x80001863, 0x00000066
        .entry 0x80001864, 0x00000100
        .entry 0x80001043, 0x000000c0
        .entry 0x80001044, 0x00000000
        .entry 0x80001045, 0x00000044
        .entry 0x00002e13, 0x00000099
        .entry 0x8000001c, 0x00000100
        .entry 0x8000001d, 0x00000000
        .entry 0x8000001e, 0x00000000
        .entry 0x80001841, 0x00000000
        .entry 0x8000001f, 0x0001f000
        .entry 0x80001843, 0x0001f000
        .entry 0x80001844, 0x00000000
        .entry 0x80001845, 0x00000000
        .entry 0x80001846, 0x00000000
        .entry 0x80001847, 0x00000000
        .entry 0x80001848, 0x00000000
        .entry 0x80001849, 0x00000000
        .entry 0x8000184a, 0x00000000
        .entry 0x8000184b, 0x00000000
        .entry 0x8000184c, 0x00000000
        .entry 0x8000184d, 0x00000000
        .entry 0x8000184e, 0x00000000
        .entry 0x8000184f, 0x00000000
        .entry 0x80001850, 0x00000000
        .entry 0x80001851, 0x00000000
        .entry 0x80001852, 0x00000000
        .entry 0x80001853, 0x00000000
        .entry 0x80001854, 0x00000000
        .entry 0x80001855, 0x00000000
        .entry 0x80001856, 0x00000000
        .entry 0x80001857, 0x00000000
        .entry 0x80001858, 0x00000000
        .entry 0x80001859, 0x00000000
        .entry 0x8000185a, 0x00000000
        .entry 0x8000185b, 0x00000000
        .entry 0x8000185c, 0x00000000
        .entry 0x8000185d, 0x00000000
        .entry 0x8000185e, 0x00000000
        .entry 0x8000185f, 0x00000000
        .entry 0x80001860, 0x00000000
        .entry 0x80001861, 0x00000000
        .entry 0x80001862, 0x00000000
        .entry 0x8000000a, 0x00000001
        .entry 0x80000078, 0x00000040
        .entry 0x80000081, 0x00008000
        .entry 0x80000082, 0x00000000
    .subconstantbuffers
    .uavmailboxsize 0
    .uavopmask
        .byte 0x00, 0xf0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00
        .fill 120, 1, 0x00
    .text
        s_load_dwordx4  s[16:19], s[0:1], 0x4
        s_buffer_load_dword s0, s[4:7], 0x4
        s_buffer_load_dword s1, s[4:7], 0x18
        s_waitcnt       lgkmcnt(0)
        s_min_u32       s0, s0, 0xffff
        s_buffer_load_dwordx2 s[4:5], s[8:11], 0x4
        s_mul_i32       s0, s12, s0
        s_add_u32       s0, s0, s1
        s_buffer_load_dwordx2 s[6:7], s[8:11], 0x20
        v_add_i32       v0, vcc, s0, v0
        v_mov_b32       v1, 0
        v_lshl_b64      v[2:3], v[0:1], 5
        s_load_dwordx4  s[20:23], s[2:3], 0x60
        s_load_dwordx4  s[24:27], s[2:3], 0x80
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v2, vcc, s4, v2
        v_mov_b32       v4, s5
        v_addc_u32      v3, vcc, v4, v3, vcc
        v_add_i32       v4, vcc, v2, 4
        v_addc_u32      v5, vcc, v3, 0, vcc
        v_lshl_b64      v[0:1], v[0:1], 2
        v_mov_b32       v6, 0
        v_add_i32       v0, vcc, s6, v0
        v_mov_b32       v7, s7
        v_addc_u32      v1, vcc, v7, v1, vcc
        buffer_store_dword v4, v0, s[16:19], s13 offset:256
        buffer_load_ubyte v4, v[0:1], s[24:27], 0 offset:1 addr64
        buffer_load_ubyte v7, v[0:1], s[24:27], 0 offset:2 addr64
        buffer_load_ubyte v0, v[0:1], s[24:27], 0 offset:3 addr64
        s_buffer_load_dword s0, s[8:11], 0x0
        s_buffer_load_dwordx2 s[4:5], s[8:11], 0xc
        s_buffer_load_dword s1, s[8:11], 0x10
        s_buffer_load_dwordx2 s[6:7], s[8:11], 0x14
        s_buffer_load_dwordx2 s[14:15], s[8:11], 0x1c
        s_buffer_load_dword s8, s[8:11], 0x24
        buffer_store_dword v5, v0, s[16:19], s13 offset:260
        v_mov_b32       v1, v2
        v_mov_b32       v2, v3
        buffer_store_byte v6, v[1:2], s[20:23], 0 offset:4 glc addr64
        s_movk_i32      s10, 0x0
        s_movk_i32      s11, 0x0
.L208_0:
        s_add_u32       s24, 32, s10
        s_addc_u32      s25, 0, s11
        s_add_u32       s9, s24, 0xffffffe0
        v_mov_b32       v3, s9
        v_mov_b32       v5, 0
        s_add_u32       s9, s24, 0xffffffe4
        v_mov_b32       v6, s9
        s_add_u32       s9, s24, 0xffffffe8
        v_mov_b32       v8, s9
        s_add_u32       s9, s24, 0xffffffec
        buffer_store_dword v5, v3, s[16:19], s13 offen
        v_mov_b32       v3, s9
        s_add_u32       s9, s24, -16
        buffer_store_dword v5, v6, s[16:19], s13 offen
        v_mov_b32       v6, s9
        s_add_u32       s9, s24, -12
        buffer_store_dword v5, v8, s[16:19], s13 offen
        v_mov_b32       v8, s9
        s_add_u32       s9, s24, -8
        buffer_store_dword v5, v3, s[16:19], s13 offen
        v_mov_b32       v3, s9
        s_add_u32       s9, s24, -4
        buffer_store_dword v5, v6, s[16:19], s13 offen
        v_mov_b32       v6, s9
        buffer_store_dword v5, v8, s[16:19], s13 offen
        v_mov_b32       v8, s24
        buffer_store_dword v5, v3, s[16:19], s13 offen
        buffer_store_dword v5, v6, s[16:19], s13 offen
        buffer_store_dword v5, v8, s[16:19], s13 offen
        buffer_store_dword v5, v8, s[16:19], s13 offen offset:4
        buffer_store_dword v5, v8, s[16:19], s13 offen offset:8
        buffer_store_dword v5, v8, s[16:19], s13 offen offset:12
        buffer_store_dword v5, v8, s[16:19], s13 offen offset:16
        buffer_store_dword v5, v8, s[16:19], s13 offen offset:20
        buffer_store_dword v5, v8, s[16:19], s13 offen offset:24
        buffer_store_dword v5, v8, s[16:19], s13 offen offset:28
        s_add_u32       s10, s10, 64
        s_addc_u32      s11, s11, 0
        s_cmp_eq_i32    s10, 0x100
        s_cbranch_scc1  .L456_0
        s_branch        .L208_0
.L456_0:
        K28 = %v9
        K34 = %v18
        K33 = %v19
        K32 = %v20
        K31 = %v21
        K30 = %v22
        K29 = %v4
        K41 = %v6
        K35 = %v8
        K40 = %v14
        K39 = %v15
        K38 = %v16
        K37 = %v17
        K36 = %v7
        K48 = %v3
        K42 = %v5
        K47 = %v10
        K46 = %v11
        K45 = %v12
        K44 = %v13
        K43 = %v0

        v_bfe_i32       K28, K29, 0, 1 /* K28 */
        v_bfe_i32       K34, K29, 6, 1 /* K34 */
        v_bfe_i32       K33, K29, 5, 1 /* K33 */
        v_bfe_i32       K32, K29, 4, 1 /* K32 */
        v_bfe_i32       K31, K29, 3, 1 /* K31 */
        v_bfe_i32       K30, K29, 2, 1 /* K30 */
        v_bfe_i32       K29, K29, 1, 1 /* K29 */

        v_bfe_i32       K41, K36, 6, 1 /* K41 */
        v_bfe_i32       K35, K36, 0, 1 /* K35 */
        v_bfe_i32       K40, K36, 5, 1 /* K40 */
        v_bfe_i32       K39, K36, 4, 1 /* K39 */
        v_bfe_i32       K38, K36, 3, 1 /* K38 */
        v_bfe_i32       K37, K36, 2, 1 /* K37 */
        v_bfe_i32       K36, K36, 1, 1 /* K36 */

        v_bfe_i32       K48, K43, 6, 1 /* K48 */
        v_bfe_i32       K42, K43, 0, 1 /* K42 */
        v_bfe_i32       K47, K43, 5, 1 /* K47 */
        v_bfe_i32       K46, K43, 4, 1 /* K46 */
        v_bfe_i32       K45, K43, 3, 1 /* K45 */
        v_bfe_i32       K44, K43, 2, 1 /* K44 */
        v_bfe_i32       K43, K43, 1, 1 /* K43 */

        s_waitcnt       lgkmcnt(0)

        K00 = %s9
        K27 = %s10
        K26 = %s11
        K25 = %s12
        K24 = %s24
        K23 = %s25
        K22 = %s26
        K21 = %s27
        K20 = %s28
        K19 = %s29
        K18 = %s30
        K17 = %s31
        K16 = %s32
        K15 = %s33
        K14 = %s34
        K13 = %s35
        K12 = %s36
        K11 = %s37
        K10 = %s38
        K09 = %s39
        K08 = %s40
        K07 = %s41
        K06 = %s42
        K05 = %s43
        K04 = %s44
        K03 = %s45
        K02 = %s46
        K01 = %s8

        s_bfe_i32       K00, K01, 0x10000 /* K00 */
        s_bfe_i32       K27, K01, 0x1001b /* K27 */
        s_bfe_i32       K26, K01, 0x1001a /* K26 */
        s_bfe_i32       K25, K01, 0x10019 /* K25 */
        s_bfe_i32       K24, K01, 0x10018 /* K24 */
        s_bfe_i32       K23, K01, 0x10017 /* K23 */
        s_bfe_i32       K22, K01, 0x10016 /* K22 */
        s_bfe_i32       K21, K01, 0x10015 /* K21 */
        s_bfe_i32       K20, K01, 0x10014 /* K20 */
        s_bfe_i32       K19, K01, 0x10013 /* K19 */
        s_bfe_i32       K18, K01, 0x10012 /* K18 */
        s_bfe_i32       K17, K01, 0x10011 /* K17 */
        s_bfe_i32       K16, K01, 0x10010 /* K16 */
        s_bfe_i32       K15, K01, 0x1000f /* K15 */
        s_bfe_i32       K14, K01, 0x1000e /* K14 */
        s_bfe_i32       K13, K01, 0x1000d /* K13 */
        s_bfe_i32       K12, K01, 0x1000c /* K12 */
        s_bfe_i32       K11, K01, 0x1000b /* K11 */
        s_bfe_i32       K10, K01, 0x1000a /* K10 */
        s_bfe_i32       K09, K01, 0x10009 /* K09 */
        s_bfe_i32       K08, K01, 0x10008 /* K08 */
        s_bfe_i32       K07, K01, 0x10007 /* K07 */
        s_bfe_i32       K06, K01, 0x10006 /* K06 */
        s_bfe_i32       K05, K01, 0x10005 /* K05 */
        s_bfe_i32       K04, K01, 0x10004 /* K04 */
        s_bfe_i32       K03, K01, 0x10003 /* K03 */
        s_bfe_i32       K02, K01, 0x10002 /* K02 */
        s_bfe_i32       K01, K01, 0x10001 /* K01 */
		
		/*
		K49 = 0x55555555
		K50 = 0x99999999
		K51 = 0x1e1e1e1e
		K52 = 0xe01fe01f
		K53 = 0x001fffe0
		K54 = 0x001fffff
		K55 = 0xffe00000
		
		KEY7_00 = 0xab
		KEY7_01 = 0xac
		KEY7_02 = 0xad
		KEY7_03 = 0xae
		KEY7_04 = 0xaf
		KEY7_05 = 0xb0
		KEY7_06 = 0xb1
		KEY7_07 = 0xb2
		KEY7_08 = 0xb3
		KEY7_09 = 0xb4
		KEY7_10 = 0xb5
		KEY7_11 = 0xb6
		KEY7_12 = 0xb7
		KEY7_13 = 0xb8
		KEY7_14 = 0xb9
		KEY7_15 = 0xba
		KEY7_16 = 0xbb
		KEY7_17 = 0xbc
		KEY7_18 = 0xbd
		KEY7_19 = 0xbe
		KEY7_20 = 0xbf
		KEY7_21 = 0xc0
		KEY7_22 = 0xc1
		KEY7_23 = 0xc2
		KEY7_24 = 0xc3
		KEY7_25 = 0xc4
		KEY7_26 = 0xc5
		KEY7_27 = 0xc6
		KEY7_28 = 0xc7
		KEY7_29 = 0xc8
		KEY7_30 = 0xc9
		KEY7_31 = 0xca
		*/

        DB63 = %v23
        DB62 = %v24
        DB61 = %v25
        DB60 = %v26
        DB59 = %v27
        DB58 = %v28
        DB57 = %v29
        DB56 = %v30
        DB55 = %v31
        DB54 = %v32
        DB53 = %v33
        DB52 = %v34
        DB51 = %v35
        DB50 = %v36
        DB49 = %v37
        DB48 = %v38
        DB47 = %v39
        DB46 = %v40
        DB45 = %v41
        DB44 = %v42
        DB43 = %v43
        DB42 = %v44
        DB41 = %v45
        DB40 = %v46
        DB39 = %v47
        DB38 = %v48
        DB37 = %v49
        DB36 = %v50
        DB35 = %v51
        DB34 = %v52
        DB33 = %v53
        DB32 = %v54
        DB31 = %v55
        DB30 = %v56
        DB29 = %v57
        DB28 = %v119
        DB27 = %v59
        DB26 = %v84
        DB25 = %v86
        DB24 = %v76
        DB23 = %v75
        DB22 = %v79
        DB21 = %v77
        DB20 = %v78
        DB19 = %v80
        DB18 = %v81           
        DB17 = %v74
        DB16 = %v68
        DB15 = %v65
        DB14 = %v69
        DB13 = %v70
        DB12 = %v72
        DB11 = %v71
        DB10 = %v73
        DB09 = %v122
        DB08 = %v121
        DB07 = %v123
        DB06 = %v62
        DB05 = %v63
        DB04 = %v66
        DB03 = %v64
        DB02 = %v58
        DB01 = %v67
        DB00 = %v120

		TEMP00 = %v110
		TEMP01 = %v93
		TEMP02 = %v92
		TEMP03 = %v99
		TEMP04 = %v95
		TEMP05 = %v98
		TEMP06 = %v96
		TEMP07 = %v90
		TEMP08 = %v87
		TEMP09 = %v103
		TEMP10 = %v94
		TEMP11 = %v97
		TEMP12 = %v89
		TEMP13 = %v108
		TEMP14 = %v101
		TEMP15 = %v88
		TEMP16 = %v60
		TEMP17 = %v100
		TEMP18 = %v106
		TEMP19 = %v104
		TEMP20 = %v85
		TEMP21 = %v124
		TEMP22 = %v82
		TEMP23 = %v83
		TEMP24 = %v61
		TEMP25 = %v91
		TEMP26 = %v102
		TEMP27 = %v111
		TEMP28 = %v107
		TEMP29 = %v105
		TEMP30 = %v116
		TEMP31 = %v114
		TEMP32 = %v112
		TEMP33 = %v115
		TEMP34 = %v113
		TEMP35 = %v109
		TEMP36 = %v117
		TEMP37 = %v118

		/*
		DB_EF00 = DB31
		DB_EF01 = DB00
		DB_EF02 = DB01
		DB_EF03 = DB02
		DB_EF04 = DB03
		DB_EF05 = DB04
		DB_EF06 = DB03
		DB_EF07 = DB04
		DB_EF08 = DB05
		DB_EF09 = DB06
		DB_EF10 = DB07
		DB_EF11 = DB08
		DB_EF12 = DB07
		DB_EF13 = DB08
		DB_EF14 = DB09
		DB_EF15 = DB10
		DB_EF16 = DB11
		DB_EF17 = DB12
		DB_EF18 = DB11
		DB_EF19 = DB12
		DB_EF20 = DB13
		DB_EF21 = DB14
		DB_EF22 = DB15
		DB_EF23 = DB16
		DB_EF24 = DB15
		DB_EF25 = DB16
		DB_EF26 = DB17
		DB_EF27 = DB18
		DB_EF28 = DB19
		DB_EF29 = DB20
		DB_EF30 = DB19
		DB_EF31 = DB20
		DB_EF32 = DB21
		DB_EF33 = DB22
		DB_EF34 = DB23
		DB_EF35 = DB24
		DB_EF36 = DB23
		DB_EF37 = DB24
		DB_EF38 = DB25
		DB_EF39 = DB26
		DB_EF40 = DB27
		DB_EF41 = DB28
		DB_EF42 = DB27
		DB_EF43 = DB28
		DB_EF44 = DB29
		DB_EF45 = DB30
		DB_EF46 = DB31
		DB_EF47 = DB00
		DB_EF48 = DB63
		DB_EF49 = DB32
		DB_EF50 = DB33
		DB_EF51 = DB34
		DB_EF52 = DB35
		DB_EF53 = DB36
		DB_EF54 = DB35
		DB_EF55 = DB36
		DB_EF56 = DB37
		DB_EF57 = DB38
		DB_EF58 = DB39
		DB_EF59 = DB40
		DB_EF60 = DB39
		DB_EF61 = DB40
		DB_EF62 = DB41
		DB_EF63 = DB42
		DB_EF64 = DB43
		DB_EF65 = DB44
		DB_EF66 = DB43
		DB_EF67 = DB44
		DB_EF68 = DB45
		DB_EF69 = DB46
		DB_EF70 = DB47
		DB_EF71 = DB48
		DB_EF72 = DB47
		DB_EF73 = DB48
		DB_EF74 = DB49
		DB_EF75 = DB50
		DB_EF76 = DB51
		DB_EF77 = DB52
		DB_EF78 = DB51
		DB_EF79 = DB52
		DB_EF80 = DB53
		DB_EF81 = DB54
		DB_EF82 = DB55
		DB_EF83 = DB56
		DB_EF84 = DB55
		DB_EF85 = DB56
		DB_EF86 = DB57
		DB_EF87 = DB58
		DB_EF88 = DB59
		DB_EF89 = DB60
		DB_EF90 = DB59
		DB_EF91 = DB60
		DB_EF92 = DB61
		DB_EF93 = DB62
		DB_EF94 = DB63
		DB_EF95 = DB32
		*/

		/*
		DB_EF00 = %v55
		DB_EF01 = %v120
		DB_EF02 = %v67
		DB_EF03 = %v58
		DB_EF04 = %v64
		DB_EF05 = %v66
		DB_EF06 = %v64
		DB_EF07 = %v66
		DB_EF08 = %v63
		DB_EF09 = %v62
		DB_EF10 = %v123
		DB_EF11 = %v121
		DB_EF12 = %v123
		DB_EF13 = %v121
		DB_EF14 = %v122
		DB_EF15 = %v73
		DB_EF16 = %v71
		DB_EF17 = %v72
		DB_EF18 = %v71
		DB_EF19 = %v72
		DB_EF20 = %v70
		DB_EF21 = %v69
		DB_EF22 = %v65
		DB_EF23 = %v68
		DB_EF24 = %v65
		DB_EF25 = %v68
		DB_EF26 = %v74
		DB_EF27 = %v81
		DB_EF28 = %v80
		DB_EF29 = %v78
		DB_EF30 = %v80
		DB_EF31 = %v78
		DB_EF32 = %v77
		DB_EF33 = %v79
		DB_EF34 = %v75
		DB_EF35 = %v76
		DB_EF36 = %v75
		DB_EF37 = %v76
		DB_EF38 = %v86
		DB_EF39 = %v84
		DB_EF40 = %v59
		DB_EF41 = %v119
		DB_EF42 = %v59
		DB_EF43 = %v119
		DB_EF44 = %v57
		DB_EF45 = %v56
		DB_EF46 = %v55
		DB_EF47 = %v120
		DB_EF48 = %v23
		DB_EF49 = %v54
		DB_EF50 = %v53
		DB_EF51 = %v52
		DB_EF52 = %v51
		DB_EF53 = %v50
		DB_EF54 = %v51
		DB_EF55 = %v50
		DB_EF56 = %v49
		DB_EF57 = %v48
		DB_EF58 = %v47
		DB_EF59 = %v46
		DB_EF60 = %v47
		DB_EF61 = %v46
		DB_EF62 = %v45
		DB_EF63 = %v44
		DB_EF64 = %v43
		DB_EF65 = %v42
		DB_EF66 = %v43
		DB_EF67 = %v42
		DB_EF68 = %v41
		DB_EF69 = %v40
		DB_EF70 = %v39
		DB_EF71 = %v38
		DB_EF72 = %v39
		DB_EF73 = %v38
		DB_EF74 = %v37
		DB_EF75 = %v36
		DB_EF76 = %v35
		DB_EF77 = %v34
		DB_EF78 = %v35
		DB_EF79 = %v34
		DB_EF80 = %v33
		DB_EF81 = %v32
		DB_EF82 = %v31
		DB_EF83 = %v30
		DB_EF84 = %v31
		DB_EF85 = %v30
		DB_EF86 = %v29
		DB_EF87 = %v28
		DB_EF88 = %v27
		DB_EF89 = %v26
		DB_EF90 = %v27
		DB_EF91 = %v26
		DB_EF92 = %v25
		DB_EF93 = %v24
		DB_EF94 = %v23
		DB_EF95 = %v54
		*/

        v_mov_b32       DB63,  0 /* DB63 */
        v_mov_b32       DB62,  0 /* DB62 */
        v_mov_b32       DB61,  0 /* DB61 */
        v_mov_b32       DB60,  0 /* DB60 */
        v_mov_b32       DB59,  0 /* DB59 */
        v_mov_b32       DB58,  0 /* DB58 */
        v_mov_b32       DB57,  0 /* DB57 */
        v_mov_b32       DB56,  0 /* DB56 */
        v_mov_b32       DB55,  0 /* DB55? */
        v_mov_b32       DB54,  0 /* DB54 */
        v_mov_b32       DB53,  0 /* DB53 */
        v_mov_b32       DB52,  0 /* DB52 */
        v_mov_b32       DB51,  0 /* DB51 */
        v_mov_b32       DB50,  0 /* DB50 */
        v_mov_b32       DB49,  0 /* DB49 */
        v_mov_b32       DB48,  0 /* DB48 */
        v_mov_b32       DB47,  0 /* DB47? */
        v_mov_b32       DB46,  0 /* DB46 */
        v_mov_b32       DB45,  0 /* DB45 */
        v_mov_b32       DB44,  0 /* DB44 */
        v_mov_b32       DB43,  0 /* DB43 */
        v_mov_b32       DB42,  0 /* DB42 */
        v_mov_b32       DB41,  0 /* DB41 */
        v_mov_b32       DB40,  0 /* DB40 */
        v_mov_b32       DB39,  0 /* DB39? */
        v_mov_b32       DB38,  0 /* DB38 */
        v_mov_b32       DB37,  0 /* DB37 */
        v_mov_b32       DB36,  0 /* DB36 */
        v_mov_b32       DB35,  0 /* DB35 */
        v_mov_b32       DB34,  0 /* DB34 */
        v_mov_b32       DB33,  0 /* DB33 */
        v_mov_b32       DB32,  0 /* DB32 */
        v_mov_b32       DB31,  0 /* DB31 */
        v_mov_b32       DB30,  0 /* DB30 */
        v_mov_b32       DB29,  0 /* DB29 */
        v_mov_b32       DB28, 0 /* DB28 */
        v_mov_b32       DB27,  0 /* DB27 */
        v_mov_b32       DB26,  0 /* DB26 */
        v_mov_b32       DB25,  0 /* DB25 */
        v_mov_b32       DB24,  0 /* DB24 */
        v_mov_b32       DB23,  0 /* DB23? */
        v_mov_b32       DB22,  0 /* DB22 */
        v_mov_b32       DB21,  0 /* DB21 */
        v_mov_b32       DB20,  0 /* DB20 */
        v_mov_b32       DB19,  0 /* DB19 */
        v_mov_b32       DB18,  0  /* DB18 */
        v_mov_b32       DB17,  0 /* DB17 */
        v_mov_b32       DB16,  0 /* DB16 */
        v_mov_b32       DB15,  0 /* DB15? */
        v_mov_b32       DB14,  0 /* DB14 */
        v_mov_b32       DB13,  0 /* DB13 */
        v_mov_b32       DB12,  0 /* DB12 */
        v_mov_b32       DB11,  0 /* DB11 */
        v_mov_b32       DB10,  0 /* DB10 */
        v_mov_b32       DB09, 0 /* DB09 */
        v_mov_b32       DB08, 0 /* DB08 */
        v_mov_b32       DB07, 0 /* DB07 */
        v_mov_b32       DB06,  0 /* DB06 */
        v_mov_b32       DB05,  0 /* DB05 */
        v_mov_b32       DB04,  0 /* DB04 */
        v_mov_b32       DB03,  0 /* DB03 */
        v_mov_b32       DB02,  0 /* DB02 */
        v_mov_b32       DB01,  0 /* DB01 */
        v_mov_b32       DB00, 0 /* DB00 */

		s_movk_i32      s50, 13

.S1_S2_A:
		s_getpc_b64 s[98:99]
		s_add_u32 s98,s98,12
		s_addc_u32 s99,s99,0
		s_branch .S3_S4_A
		
        v_bfi_b32 TEMP28, TEMP19, TEMP16, TEMP17
        v_xor_b32 TEMP36, TEMP16, TEMP17
        v_or_b32  TEMP35, TEMP15, TEMP18
        v_xor_b32 TEMP32, TEMP36, TEMP35
        v_bfi_b32 TEMP31, TEMP32, TEMP28, TEMP19
        v_xor_b32 TEMP30, TEMP18, TEMP31
        v_xor_b32 TEMP08, TEMP15, TEMP30
        v_bfi_b32 TEMP15, TEMP19, TEMP08, TEMP30
        v_bfi_b32 TEMP01, TEMP28, TEMP35, TEMP08
        v_bfi_b32 TEMP00, TEMP19, TEMP32, TEMP36
        v_xor_b32 TEMP01, TEMP01, TEMP00
        v_bfi_b32 TEMP35, TEMP01, TEMP08, TEMP35
        v_bfi_b32 TEMP27, TEMP15, TEMP01, TEMP35
        v_xor_b32 TEMP27, TEMP28, TEMP27
        v_bfi_b32 TEMP12, TEMP27, TEMP28, TEMP18
        v_bfi_b32 TEMP28, TEMP08, TEMP32, TEMP28
        v_bfi_b32 TEMP14, TEMP27, TEMP28, TEMP19
        v_bfi_b32 TEMP35, TEMP35, TEMP30, TEMP32
        v_xor_b32 TEMP35, TEMP14, TEMP35
        v_bfi_b32 TEMP28, TEMP17, TEMP28, TEMP08
        v_bfi_b32 TEMP30, TEMP12, TEMP28, TEMP35
        v_not_b32 TEMP30, TEMP30
        v_bfi_b32 TEMP35, TEMP20, TEMP35, TEMP30
        v_xor_b32 DB40, TEMP35, DB40
        v_bfi_b32 TEMP14, TEMP14, TEMP17, TEMP30
        v_bfi_b32 TEMP10, TEMP32, TEMP16, TEMP28
        v_bfi_b32 TEMP14, TEMP10, TEMP18, TEMP14
        v_xor_b32 TEMP18, TEMP27, TEMP14
        v_bfi_b32 TEMP28, TEMP20, TEMP08, TEMP18
        v_xor_b32 DB48, TEMP28, DB48
        v_bfi_b32 TEMP28, TEMP14, TEMP00, TEMP15
        v_bfi_b32 TEMP10, TEMP31, TEMP08, TEMP10
        v_xor_b32 TEMP28, TEMP28, TEMP10
        v_bfi_b32 TEMP28, TEMP20, TEMP27, TEMP28
        v_xor_b32 DB62, TEMP28, DB62
        v_xor_b32 TEMP08, TEMP08, TEMP18
        v_bfi_b32 TEMP14, TEMP14, TEMP08, TEMP17
        v_bfi_b32 TEMP14, TEMP10, TEMP36, TEMP14
        v_bfi_b32 TEMP14, TEMP20, TEMP01, TEMP14
        v_xor_b32 DB54, TEMP14, DB54

        v_bfi_b32 TEMP14, TEMP26, TEMP23, TEMP21
        v_bfi_b32 TEMP08, TEMP25, TEMP14, TEMP26
        v_bfi_b32 TEMP05, TEMP08, TEMP24, TEMP23
        v_xor_b32 TEMP05, TEMP21, TEMP05
        v_bfi_b32 TEMP10, TEMP26, TEMP05, TEMP24
        v_not_b32 TEMP17, TEMP10
        v_xor_b32 TEMP14, TEMP14, TEMP17
        v_xor_b32 TEMP18, TEMP26, TEMP25
        v_xor_b32 TEMP28, TEMP14, TEMP18
        v_xor_b32 TEMP36, TEMP05, TEMP18
        v_bfi_b32 TEMP28, TEMP22, TEMP36, TEMP28
        v_xor_b32 DB59, TEMP28, DB59
        v_xor_b32 TEMP28, TEMP24, TEMP08
        v_bfi_b32 TEMP35, TEMP25, TEMP28, TEMP14
        v_xor_b32 TEMP32, TEMP23, TEMP28
        v_bfi_b32 TEMP35, TEMP21, TEMP32, TEMP35
        v_bfi_b32 TEMP33, TEMP25, TEMP35, TEMP24
        v_bfi_b32 TEMP32, TEMP14, TEMP36, TEMP05
        v_xor_b32 TEMP17, TEMP17, TEMP32
        v_xor_b32 TEMP17, TEMP33, TEMP17
        v_bfi_b32 TEMP31, TEMP22, TEMP35, TEMP17
        v_xor_b32 DB44, TEMP31, DB44
        v_bfi_b32 TEMP32, TEMP35, TEMP17, TEMP32
        v_bfi_b32 TEMP13, TEMP21, TEMP14, TEMP36
        v_bfi_b32 TEMP08, TEMP08, TEMP23, TEMP13
        v_bfi_b32 TEMP21, TEMP25, TEMP08, TEMP32
        v_bfi_b32 TEMP05, TEMP18, TEMP26, TEMP05
        v_bfi_b32 TEMP14, TEMP05, TEMP28, TEMP14
        v_bfi_b32 TEMP14, TEMP22, TEMP21, TEMP14
        v_xor_b32 DB49, TEMP14, DB49
        v_bfi_b32 TEMP16, TEMP26, TEMP33, TEMP13
        v_bfi_b32 TEMP14, TEMP18, TEMP17, TEMP35
        v_bfi_b32 TEMP14, TEMP05, TEMP13, TEMP14
        v_bfi_b32 TEMP16, TEMP16, TEMP14, TEMP10
        v_xor_b32 TEMP16, TEMP08, TEMP16
        v_bfi_b32 TEMP16, TEMP22, TEMP16, TEMP14
        v_xor_b32 DB33, TEMP16, DB33

		s_setpc_b64 s[82:83]



.S3_S4_A:
		s_getpc_b64 s[96:97]
		s_add_u32 s96,s96,12
		s_addc_u32 s97,s97,0
		s_branch .S5_S6_A

        v_bfi_b32 TEMP28, TEMP16, TEMP18, TEMP14
        v_xor_b32 TEMP28, TEMP25, TEMP28
        v_bfi_b32 TEMP36, TEMP20, TEMP28, TEMP16
        v_xor_b32 TEMP35, TEMP20, TEMP28
        v_bfi_b32 TEMP32, TEMP14, TEMP36, TEMP35
        v_bfi_b32 TEMP31, TEMP28, TEMP18, TEMP16
        v_bfi_b32 TEMP30, TEMP36, TEMP14, TEMP31
        v_bfi_b32 TEMP15, TEMP35, TEMP25, TEMP18
        v_xor_b32 TEMP15, TEMP30, TEMP15
        v_bfi_b32 TEMP18, TEMP18, TEMP15, TEMP32
        v_not_b32 TEMP01, TEMP18
        v_bfi_b32 TEMP00, TEMP26, TEMP01, TEMP15
        v_xor_b32 DB47, TEMP00, DB47
        v_xor_b32 TEMP01, TEMP31, TEMP01
        v_bfi_b32 TEMP32, TEMP35, TEMP32, TEMP01
        v_bfi_b32 TEMP30, TEMP30, TEMP28, TEMP20
        v_xor_b32 TEMP00, TEMP32, TEMP30
        v_bfi_b32 TEMP27, TEMP01, TEMP25, TEMP00
        v_bfi_b32 TEMP18, TEMP16, TEMP20, TEMP18
        v_bfi_b32 TEMP28, TEMP28, TEMP25, TEMP14
        v_bfi_b32 TEMP36, TEMP36, TEMP28, TEMP01
        v_bfi_b32 TEMP36, TEMP27, TEMP18, TEMP36
        v_xor_b32 TEMP01, TEMP00, TEMP18
        v_bfi_b32 TEMP01, TEMP26, TEMP01, TEMP36
        v_xor_b32 DB55, TEMP01, DB55
        v_bfi_b32 TEMP08, TEMP16, TEMP00, TEMP32
        v_bfi_b32 TEMP34, TEMP14, TEMP31, TEMP28
        v_bfi_b32 TEMP08, TEMP34, TEMP36, TEMP08
        v_bfi_b32 TEMP08, TEMP26, TEMP08, TEMP35
        v_xor_b32 DB37, TEMP08, DB37
        v_bfi_b32 TEMP08, TEMP30, TEMP20, TEMP32
        v_bfi_b32 TEMP08, TEMP25, TEMP34, TEMP08
        v_xor_b32 TEMP08, TEMP18, TEMP08
        v_xor_b32 TEMP05, TEMP31, TEMP15
        v_bfi_b32 TEMP05, TEMP18, TEMP30, TEMP05
        v_bfi_b32 TEMP14, TEMP26, TEMP05, TEMP08
        v_xor_b32 DB61, TEMP14, DB61

        v_bfi_b32 TEMP14, TEMP19, TEMP24, TEMP13
        v_xor_b32 TEMP08, TEMP23, TEMP14
        v_bfi_b32 TEMP05, TEMP24, TEMP13, TEMP08
        v_bfi_b32 TEMP34, TEMP14, TEMP08, TEMP05
        v_bfi_b32 TEMP10, TEMP19, TEMP13, TEMP24
        v_bfi_b32 TEMP17, TEMP23, TEMP19, TEMP10
        v_xor_b32 TEMP33, TEMP13, TEMP17
        v_bfi_b32 TEMP33, TEMP22, TEMP33, TEMP19
        v_xor_b32 TEMP05, TEMP05, TEMP33
        v_not_b32 TEMP33, TEMP05
        v_bfi_b32 TEMP34, TEMP22, TEMP34, TEMP33
        v_bfi_b32 TEMP17, TEMP17, TEMP22, TEMP23
        v_xor_b32 TEMP13, TEMP19, TEMP10
        v_bfi_b32 TEMP10, TEMP13, TEMP17, TEMP33
        v_xor_b32 TEMP14, TEMP14, TEMP10
        v_not_b32 TEMP10, TEMP14
        v_bfi_b32 TEMP18, TEMP23, TEMP10, TEMP13
        v_xor_b32 TEMP34, TEMP34, TEMP18
        v_bfi_b32 TEMP05, TEMP12, TEMP05, TEMP34
        v_xor_b32 DB41, TEMP05, DB41
        v_bfi_b32 TEMP05, TEMP12, TEMP34, TEMP33
        v_xor_b32 DB32, TEMP05, DB32
        v_bfi_b32 TEMP08, TEMP08, TEMP23, TEMP22
        v_bfi_b32 TEMP08, TEMP13, TEMP08, TEMP17
        v_xor_b32 TEMP13, TEMP10, TEMP34
        v_xor_b32 TEMP08, TEMP08, TEMP13
        v_bfi_b32 TEMP13, TEMP12, TEMP08, TEMP10
        v_xor_b32 DB57, TEMP13, DB57
        v_bfi_b32 TEMP16, TEMP12, TEMP14, TEMP08
        v_xor_b32 DB51, TEMP16, DB51
		s_setpc_b64 s[82:83]



.S5_S6_A:
		s_getpc_b64 s[94:95]
		s_add_u32 s94,s94,12
		s_addc_u32 s95,s95,0
		s_branch .S7_S8_A

        v_bfi_b32 TEMP28, TEMP22, TEMP18, TEMP16
        v_not_b32 TEMP36, TEMP28
        v_bfi_b32 TEMP35, TEMP18, TEMP16, TEMP36
        v_xor_b32 TEMP32, TEMP09, TEMP35
        v_xor_b32 TEMP31, TEMP22, TEMP23
        v_xor_b32 TEMP30, TEMP32, TEMP31
        v_bfi_b32 TEMP15, TEMP32, TEMP30, TEMP09
        v_bfi_b32 TEMP01, TEMP15, TEMP28, TEMP23
        v_bfi_b32 TEMP00, TEMP16, TEMP22, TEMP01
        v_bfi_b32 TEMP18, TEMP09, TEMP36, TEMP18
        v_xor_b32 TEMP27, TEMP00, TEMP18
        v_bfi_b32 TEMP12, TEMP32, TEMP27, TEMP31
        v_bfi_b32 TEMP26, TEMP12, TEMP16, TEMP23
        v_bfi_b32 TEMP15, TEMP26, TEMP23, TEMP15
        v_xor_b32 TEMP19, TEMP27, TEMP15
        v_bfi_b32 TEMP27, TEMP21, TEMP27, TEMP19
        v_xor_b32 DB56, TEMP27, DB56
        v_bfi_b32 TEMP36, TEMP12, TEMP01, TEMP36
        v_bfi_b32 TEMP05, TEMP16, TEMP28, TEMP15
        v_xor_b32 TEMP28, TEMP36, TEMP05
        v_bfi_b32 TEMP01, TEMP21, TEMP30, TEMP28
        v_xor_b32 DB45, TEMP01, DB45
        v_bfi_b32 TEMP01, TEMP23, TEMP05, TEMP28
        v_bfi_b32 TEMP00, TEMP09, TEMP00, TEMP01
        v_bfi_b32 TEMP17, TEMP30, TEMP09, TEMP18
        v_bfi_b32 TEMP27, TEMP28, TEMP17, TEMP00
        v_bfi_b32 TEMP16, TEMP30, TEMP28, TEMP22
        v_bfi_b32 TEMP05, TEMP16, TEMP31, TEMP05
        v_bfi_b32 TEMP17, TEMP17, TEMP00, TEMP15
        v_xor_b32 TEMP05, TEMP05, TEMP17
        v_bfi_b32 TEMP05, TEMP21, TEMP05, TEMP27
        v_xor_b32 DB34, TEMP05, DB34
        v_bfi_b32 TEMP05, TEMP36, TEMP19, TEMP32
        v_bfi_b32 TEMP16, TEMP00, TEMP05, TEMP16
        v_bfi_b32 TEMP08, TEMP23, TEMP35, TEMP18
        v_bfi_b32 TEMP05, TEMP26, TEMP30, TEMP32
        v_bfi_b32 TEMP08, TEMP01, TEMP05, TEMP08
        v_bfi_b32 TEMP16, TEMP21, TEMP16, TEMP08
        v_xor_b32 DB39, TEMP16, DB39

        v_bfi_b32 TEMP16, TEMP20, TEMP24, TEMP11
        v_xor_b32 TEMP08, TEMP14, TEMP16
        v_bfi_b32 TEMP05, TEMP10, TEMP24, TEMP08
        v_xor_b32 TEMP34, TEMP11, TEMP05
        v_xor_b32 TEMP17, TEMP20, TEMP34
        v_bfi_b32 TEMP18, TEMP24, TEMP17, TEMP34
        v_bfi_b32 TEMP28, TEMP18, TEMP34, TEMP24
        v_xor_b32 TEMP28, TEMP10, TEMP28
        v_bfi_b32 TEMP18, TEMP18, TEMP24, TEMP10
        v_xor_b32 TEMP08, TEMP08, TEMP18
        v_bfi_b32 TEMP21, TEMP17, TEMP10, TEMP24
        v_bfi_b32 TEMP33, TEMP08, TEMP21, TEMP28
        v_bfi_b32 TEMP36, TEMP33, TEMP28, TEMP20
        v_not_b32 TEMP35, TEMP17
        v_bfi_b32 TEMP32, TEMP08, TEMP21, TEMP35
        v_bfi_b32 TEMP36, TEMP36, TEMP17, TEMP32
        v_bfi_b32 TEMP35, TEMP25, TEMP36, TEMP35
        v_xor_b32 DB35, TEMP35, DB35
        v_bfi_b32 TEMP29, TEMP14, TEMP36, TEMP34
        v_bfi_b32 TEMP13, TEMP29, TEMP32, TEMP11
        v_xor_b32 TEMP08, TEMP17, TEMP08
        v_xor_b32 TEMP29, TEMP13, TEMP08
        v_bfi_b32 TEMP08, TEMP25, TEMP29, TEMP08
        v_xor_b32 DB50, TEMP08, DB50
        v_bfi_b32 TEMP08, TEMP17, TEMP05, TEMP28
        v_bfi_b32 TEMP21, TEMP18, TEMP21, TEMP08
        v_xor_b32 TEMP21, TEMP29, TEMP21
        v_xor_b32 TEMP16, TEMP16, TEMP21
        v_bfi_b32 TEMP10, TEMP32, TEMP36, TEMP20
        v_bfi_b32 TEMP34, TEMP10, TEMP21, TEMP16
        v_not_b32 TEMP34, TEMP34
        v_bfi_b32 TEMP16, TEMP25, TEMP16, TEMP34
        v_xor_b32 DB60, TEMP16, DB60
        v_bfi_b32 TEMP16, TEMP21, TEMP29, TEMP10
        v_bfi_b32 TEMP08, TEMP05, TEMP08, TEMP13
        v_xor_b32 TEMP16, TEMP16, TEMP08
        v_bfi_b32 TEMP16, TEMP25, TEMP16, TEMP33
        v_xor_b32 DB42, TEMP16, DB42
		s_setpc_b64 s[82:83]



.S7_S8_A:
        s_getpc_b64 s[92:93]
		s_add_u32 s92,s92,12
		s_addc_u32 s93,s93,0
		s_branch .S1_S2_B
		
		v_bfi_b32 TEMP28, TEMP18, TEMP26, TEMP21
        v_bfi_b32 TEMP36, TEMP24, TEMP18, TEMP23
        v_bfi_b32 TEMP28, TEMP26, TEMP36, TEMP28
        v_bfi_b32 TEMP35, TEMP21, TEMP23, TEMP18
        v_xor_b32 TEMP35, TEMP24, TEMP35
        v_xor_b32 TEMP32, TEMP28, TEMP35
        v_bfi_b32 TEMP28, TEMP24, TEMP28, TEMP21
        v_xor_b32 TEMP31, TEMP21, TEMP18
        v_bfi_b32 TEMP30, TEMP35, TEMP28, TEMP31
        v_xor_b32 TEMP15, TEMP23, TEMP26
        v_xor_b32 TEMP01, TEMP30, TEMP15
        v_bfi_b32 TEMP00, TEMP16, TEMP32, TEMP01
        v_xor_b32 DB63, TEMP00, DB63
        v_xor_b32 TEMP00, TEMP18, TEMP01
        v_bfi_b32 TEMP27, TEMP31, TEMP26, TEMP00
        v_bfi_b32 TEMP27, TEMP23, TEMP27, TEMP01
        v_not_b32 TEMP08, TEMP26
        v_bfi_b32 TEMP08, TEMP28, TEMP00, TEMP08
        v_bfi_b32 TEMP14, TEMP23, TEMP00, TEMP35
        v_bfi_b32 TEMP14, TEMP15, TEMP31, TEMP14
        v_xor_b32 TEMP14, TEMP36, TEMP14
        v_bfi_b32 TEMP18, TEMP18, TEMP14, TEMP35
        v_xor_b32 TEMP28, TEMP08, TEMP18
        v_bfi_b32 TEMP36, TEMP16, TEMP27, TEMP28
        v_xor_b32 DB43, TEMP36, DB43
        v_xor_b32 TEMP28, TEMP31, TEMP28
        v_bfi_b32 TEMP18, TEMP18, TEMP28, TEMP27
        v_bfi_b32 TEMP08, TEMP08, TEMP32, TEMP18
        v_bfi_b32 TEMP14, TEMP16, TEMP14, TEMP08
        v_xor_b32 DB53, TEMP14, DB53
        v_bfi_b32 TEMP14, TEMP30, TEMP01, TEMP00
        v_xor_b32 TEMP08, TEMP00, TEMP28
        v_bfi_b32 TEMP14, TEMP24, TEMP08, TEMP14
        v_bfi_b32 TEMP08, TEMP01, TEMP32, TEMP27
        v_bfi_b32 TEMP08, TEMP08, TEMP21, TEMP14
        v_not_b32 TEMP08, TEMP08
        v_bfi_b32 TEMP14, TEMP16, TEMP08, TEMP14
        v_xor_b32 DB38, TEMP14, DB38

        v_bfi_b32 TEMP14, TEMP11, TEMP22, TEMP25
        v_bfi_b32 TEMP08, TEMP19, TEMP11, TEMP12
        v_bfi_b32 TEMP10, TEMP25, TEMP19, TEMP11
        v_xor_b32 TEMP10, TEMP22, TEMP10
        v_bfi_b32 TEMP14, TEMP08, TEMP14, TEMP10
        v_xor_b32 TEMP08, TEMP12, TEMP14
        v_bfi_b32 TEMP34, TEMP10, TEMP11, TEMP08
        v_bfi_b32 TEMP10, TEMP25, TEMP22, TEMP10
        v_bfi_b32 TEMP21, TEMP10, TEMP19, TEMP34
        v_bfi_b32 TEMP10, TEMP12, TEMP10, TEMP11
        v_bfi_b32 TEMP34, TEMP10, TEMP08, TEMP19
        v_bfi_b32 TEMP33, TEMP12, TEMP11, TEMP25
        v_xor_b32 TEMP17, TEMP34, TEMP33
        v_xor_b32 TEMP18, TEMP21, TEMP17
        v_bfi_b32 TEMP28, TEMP20, TEMP17, TEMP18
        v_xor_b32 DB46, TEMP28, DB46
        v_bfi_b32 TEMP13, TEMP11, TEMP18, TEMP33
        v_bfi_b32 TEMP18, TEMP13, TEMP12, TEMP14
        v_xor_b32 TEMP13, TEMP10, TEMP13
        v_xor_b32 TEMP10, TEMP08, TEMP13
        v_not_b32 TEMP28, TEMP10
        v_bfi_b32 TEMP36, TEMP21, TEMP18, TEMP28
        v_xor_b32 TEMP13, TEMP13, TEMP36
        v_bfi_b32 TEMP08, TEMP20, TEMP08, TEMP13
        v_xor_b32 DB58, TEMP08, DB58
        v_bfi_b32 TEMP08, TEMP18, TEMP33, TEMP34
        v_bfi_b32 TEMP08, TEMP17, TEMP08, TEMP14
        v_xor_b32 TEMP08, TEMP28, TEMP08
        v_bfi_b32 TEMP08, TEMP20, TEMP08, TEMP28
        v_xor_b32 DB52, TEMP08, DB52
        v_or_b32 TEMP08, TEMP19, TEMP21
        v_xor_b32 TEMP08, TEMP36, TEMP08
        v_bfi_b32 TEMP16, TEMP17, TEMP12, TEMP14
        v_xor_b32 TEMP16, TEMP08, TEMP16
        v_bfi_b32 TEMP16, TEMP20, TEMP10, TEMP16
        v_xor_b32 DB36, TEMP16, DB36
		s_setpc_b64 s[82:83]
		


.S1_S2_B:
        s_getpc_b64 s[90:91]
		s_add_u32 s90,s90,12
		s_addc_u32 s91,s91,0
		s_branch .S3_S4_B
		
        v_bfi_b32 TEMP28, TEMP26, TEMP18, TEMP05
        v_xor_b32 TEMP36, TEMP05, TEMP18
        v_or_b32 TEMP35, TEMP08, TEMP16
        v_xor_b32 TEMP32, TEMP36, TEMP35
        v_bfi_b32 TEMP31, TEMP32, TEMP28, TEMP26
        v_xor_b32 TEMP30, TEMP16, TEMP31
        v_xor_b32 TEMP13, TEMP08, TEMP30
        v_bfi_b32 TEMP15, TEMP26, TEMP13, TEMP30
        v_bfi_b32 TEMP01, TEMP28, TEMP35, TEMP13
        v_bfi_b32 TEMP00, TEMP26, TEMP32, TEMP36
        v_xor_b32 TEMP01, TEMP01, TEMP00
        v_bfi_b32 TEMP35, TEMP01, TEMP13, TEMP35
        v_bfi_b32 TEMP27, TEMP15, TEMP01, TEMP35
        v_xor_b32 TEMP27, TEMP28, TEMP27
        v_bfi_b32 TEMP12, TEMP27, TEMP28, TEMP16
        v_bfi_b32 TEMP28, TEMP13, TEMP32, TEMP28
        v_bfi_b32 TEMP08, TEMP27, TEMP28, TEMP26
        v_bfi_b32 TEMP35, TEMP35, TEMP30, TEMP32
        v_xor_b32 TEMP35, TEMP08, TEMP35
        v_bfi_b32 TEMP28, TEMP05, TEMP28, TEMP13
        v_bfi_b32 TEMP30, TEMP12, TEMP28, TEMP35
        v_not_b32 TEMP30, TEMP30
        v_bfi_b32 TEMP08, TEMP08, TEMP05, TEMP30
        v_bfi_b32 TEMP18, TEMP32, TEMP18, TEMP28
        v_bfi_b32 TEMP08, TEMP18, TEMP16, TEMP08
        v_xor_b32 TEMP34, TEMP27, TEMP08
        v_xor_b32 TEMP28, TEMP13, TEMP34
        v_bfi_b32 TEMP17, TEMP08, TEMP28, TEMP05
        v_bfi_b32 TEMP18, TEMP31, TEMP13, TEMP18
        v_bfi_b32 TEMP17, TEMP18, TEMP36, TEMP17
        v_bfi_b32 TEMP17, TEMP19, TEMP01, TEMP17
        v_xor_b32 DB22, DB22, TEMP17
        v_bfi_b32 TEMP17, TEMP19, TEMP35, TEMP30
        v_xor_b32 DB08, DB08, TEMP17
        v_bfi_b32 TEMP13, TEMP19, TEMP13, TEMP34
        v_xor_b32 DB16, DB16, TEMP13
        v_bfi_b32 TEMP08, TEMP08, TEMP00, TEMP15
        v_xor_b32 TEMP08, TEMP18, TEMP08
        v_bfi_b32 TEMP08, TEMP19, TEMP27, TEMP08
        v_xor_b32 DB30, DB30, TEMP08

        v_bfi_b32 TEMP08, TEMP03, TEMP02, TEMP14
        v_bfi_b32 TEMP13, TEMP04, TEMP08, TEMP03
        v_bfi_b32 TEMP29, TEMP13, TEMP07, TEMP02
        v_xor_b32 TEMP29, TEMP14, TEMP29
        v_bfi_b32 TEMP34, TEMP03, TEMP29, TEMP07
        v_not_b32 TEMP17, TEMP34
        v_xor_b32 TEMP08, TEMP08, TEMP17
        v_xor_b32 TEMP18, TEMP03, TEMP04
        v_xor_b32 TEMP28, TEMP29, TEMP18
        v_bfi_b32 TEMP36, TEMP14, TEMP08, TEMP28
        v_xor_b32 TEMP35, TEMP07, TEMP13
        v_bfi_b32 TEMP32, TEMP04, TEMP35, TEMP08
        v_xor_b32 TEMP31, TEMP02, TEMP35
        v_bfi_b32 TEMP14, TEMP14, TEMP31, TEMP32
        v_bfi_b32 TEMP21, TEMP04, TEMP14, TEMP07
        v_bfi_b32 TEMP32, TEMP03, TEMP21, TEMP36
        v_bfi_b32 TEMP31, TEMP08, TEMP28, TEMP29
        v_xor_b32 TEMP17, TEMP17, TEMP31
        v_xor_b32 TEMP21, TEMP21, TEMP17
        v_bfi_b32 TEMP17, TEMP18, TEMP21, TEMP14
        v_bfi_b32 TEMP29, TEMP18, TEMP03, TEMP29
        v_bfi_b32 TEMP05, TEMP29, TEMP36, TEMP17
        v_bfi_b32 TEMP34, TEMP32, TEMP05, TEMP34
        v_bfi_b32 TEMP13, TEMP13, TEMP02, TEMP36
        v_xor_b32 TEMP33, TEMP34, TEMP13
        v_bfi_b32 TEMP05, TEMP06, TEMP33, TEMP05
        v_xor_b32 DB01, DB01, TEMP05
        v_bfi_b32 TEMP05, TEMP06, TEMP14, TEMP21
        v_xor_b32 DB12, DB12, TEMP05
        v_bfi_b32 TEMP14, TEMP14, TEMP21, TEMP31
        v_bfi_b32 TEMP14, TEMP04, TEMP13, TEMP14
        v_bfi_b32 TEMP13, TEMP29, TEMP35, TEMP08
        v_bfi_b32 TEMP14, TEMP06, TEMP14, TEMP13
        v_xor_b32 DB17, DB17, TEMP14
        v_xor_b32 TEMP14, TEMP08, TEMP18
        v_bfi_b32 TEMP16, TEMP06, TEMP28, TEMP14
        v_xor_b32 DB27, DB27, TEMP16
		s_setpc_b64 s[82:83]



.S3_S4_B:
        s_getpc_b64 s[88:89]
		s_add_u32 s88,s88,12
		s_addc_u32 s89,s89,0
		s_branch .S5_S6_B

        v_bfi_b32 TEMP28, TEMP02, TEMP10, TEMP16
        v_xor_b32 TEMP28, TEMP04, TEMP28
        v_bfi_b32 TEMP36, TEMP18, TEMP28, TEMP02
        v_xor_b32 TEMP35, TEMP18, TEMP28
        v_bfi_b32 TEMP32, TEMP16, TEMP36, TEMP35
        v_bfi_b32 TEMP31, TEMP28, TEMP10, TEMP02
        v_bfi_b32 TEMP30, TEMP36, TEMP16, TEMP31
        v_bfi_b32 TEMP15, TEMP35, TEMP04, TEMP10
        v_xor_b32 TEMP15, TEMP30, TEMP15
        v_bfi_b32 TEMP17, TEMP10, TEMP15, TEMP32
        v_not_b32 TEMP01, TEMP17
        v_xor_b32 TEMP00, TEMP31, TEMP01
        v_bfi_b32 TEMP32, TEMP35, TEMP32, TEMP00
        v_bfi_b32 TEMP30, TEMP30, TEMP28, TEMP18
        v_xor_b32 TEMP27, TEMP32, TEMP30
        v_bfi_b32 TEMP12, TEMP00, TEMP04, TEMP27
        v_bfi_b32 TEMP17, TEMP02, TEMP18, TEMP17
        v_bfi_b32 TEMP28, TEMP28, TEMP04, TEMP16
        v_bfi_b32 TEMP36, TEMP36, TEMP28, TEMP00
        v_bfi_b32 TEMP36, TEMP12, TEMP17, TEMP36
        v_xor_b32 TEMP00, TEMP27, TEMP17
        v_bfi_b32 TEMP00, TEMP25, TEMP00, TEMP36
        v_xor_b32 DB23, DB23, TEMP00
        v_bfi_b32 TEMP05, TEMP02, TEMP27, TEMP32
        v_bfi_b32 TEMP34, TEMP16, TEMP31, TEMP28
        v_bfi_b32 TEMP05, TEMP34, TEMP36, TEMP05
        v_bfi_b32 TEMP05, TEMP25, TEMP05, TEMP35
        v_xor_b32 DB05, DB05, TEMP05
        v_bfi_b32 TEMP05, TEMP30, TEMP18, TEMP32
        v_bfi_b32 TEMP13, TEMP04, TEMP34, TEMP05
        v_xor_b32 TEMP13, TEMP17, TEMP13
        v_xor_b32 TEMP05, TEMP31, TEMP15
        v_bfi_b32 TEMP05, TEMP17, TEMP30, TEMP05
        v_bfi_b32 TEMP13, TEMP25, TEMP05, TEMP13
        v_xor_b32 DB29, DB29, TEMP13

        v_bfi_b32 TEMP13, TEMP03, TEMP19, TEMP22
        v_bfi_b32 TEMP05, TEMP26, TEMP03, TEMP13
        v_bfi_b32 TEMP34, TEMP05, TEMP06, TEMP26
        v_bfi_b32 TEMP17, TEMP03, TEMP22, TEMP19
        v_xor_b32 TEMP18, TEMP26, TEMP17
        v_bfi_b32 TEMP28, TEMP18, TEMP26, TEMP06
        v_xor_b32 TEMP13, TEMP03, TEMP13
        v_bfi_b32 TEMP28, TEMP13, TEMP28, TEMP34
        v_bfi_b32 TEMP10, TEMP22, TEMP19, TEMP18
        v_bfi_b32 TEMP18, TEMP17, TEMP18, TEMP10
        v_xor_b32 TEMP05, TEMP19, TEMP05
        v_bfi_b32 TEMP08, TEMP06, TEMP05, TEMP03
        v_xor_b32 TEMP08, TEMP10, TEMP08
        v_not_b32 TEMP05, TEMP08
        v_bfi_b32 TEMP16, TEMP06, TEMP18, TEMP05
        v_bfi_b32 TEMP10, TEMP13, TEMP34, TEMP05
        v_xor_b32 TEMP10, TEMP17, TEMP10
        v_not_b32 TEMP33, TEMP10
        v_bfi_b32 TEMP13, TEMP26, TEMP33, TEMP13
        v_xor_b32 TEMP16, TEMP16, TEMP13
        v_xor_b32 TEMP13, TEMP33, TEMP16
        v_xor_b32 TEMP13, TEMP28, TEMP13
        v_bfi_b32 TEMP10, TEMP07, TEMP10, TEMP13
        v_xor_b32 DB19, DB19, TEMP10
        v_bfi_b32 TEMP13, TEMP07, TEMP13, TEMP33
        v_xor_b32 DB25, DB25, TEMP13
        v_bfi_b32 TEMP14, TEMP25, TEMP01, TEMP15
        v_xor_b32 DB15, DB15, TEMP14
        v_bfi_b32 TEMP14, TEMP07, TEMP16, TEMP05
        v_xor_b32 DB00, DB00, TEMP14
        v_bfi_b32 TEMP16, TEMP07, TEMP08, TEMP16
        v_xor_b32 DB09, DB09, TEMP16
		s_setpc_b64 s[82:83]



.S5_S6_B:
        s_getpc_b64 s[86:87]
		s_add_u32 s86,s86,12
		s_addc_u32 s87,s87,0
		s_branch .S7_S8_B

        v_bfi_b32 TEMP28, TEMP04, TEMP21, TEMP03
        v_not_b32 TEMP36, TEMP28
        v_bfi_b32 TEMP35, TEMP21, TEMP03, TEMP36
        v_xor_b32 TEMP32, TEMP18, TEMP35
        v_xor_b32 TEMP31, TEMP04, TEMP07
        v_xor_b32 TEMP30, TEMP32, TEMP31
        v_bfi_b32 TEMP15, TEMP32, TEMP30, TEMP18
        v_bfi_b32 TEMP01, TEMP15, TEMP28, TEMP07
        v_bfi_b32 TEMP00, TEMP03, TEMP04, TEMP01
        v_bfi_b32 TEMP17, TEMP18, TEMP36, TEMP21
        v_xor_b32 TEMP27, TEMP00, TEMP17
        v_bfi_b32 TEMP12, TEMP32, TEMP27, TEMP31
        v_bfi_b32 TEMP36, TEMP12, TEMP01, TEMP36
        v_bfi_b32 TEMP01, TEMP12, TEMP03, TEMP07
        v_bfi_b32 TEMP15, TEMP01, TEMP07, TEMP15
        v_xor_b32 TEMP12, TEMP27, TEMP15
        v_bfi_b32 TEMP26, TEMP36, TEMP12, TEMP32
        v_bfi_b32 TEMP08, TEMP03, TEMP28, TEMP15
        v_xor_b32 TEMP28, TEMP36, TEMP08
        v_bfi_b32 TEMP29, TEMP30, TEMP28, TEMP04
        v_bfi_b32 TEMP36, TEMP07, TEMP08, TEMP28
        v_bfi_b32 TEMP00, TEMP18, TEMP00, TEMP36
        v_bfi_b32 TEMP26, TEMP00, TEMP26, TEMP29
        v_bfi_b32 TEMP05, TEMP07, TEMP35, TEMP17
        v_bfi_b32 TEMP35, TEMP01, TEMP30, TEMP32
        v_bfi_b32 TEMP05, TEMP36, TEMP35, TEMP05
        v_bfi_b32 TEMP05, TEMP22, TEMP26, TEMP05
        v_xor_b32 DB07, DB07, TEMP05
        v_bfi_b32 TEMP05, TEMP30, TEMP18, TEMP17
        v_bfi_b32 TEMP17, TEMP28, TEMP05, TEMP00
        v_bfi_b32 TEMP08, TEMP29, TEMP31, TEMP08
        v_bfi_b32 TEMP29, TEMP05, TEMP00, TEMP15
        v_xor_b32 TEMP08, TEMP08, TEMP29
        v_bfi_b32 TEMP08, TEMP22, TEMP08, TEMP17
        v_xor_b32 DB02, DB02, TEMP08

        v_bfi_b32 TEMP08, TEMP02, TEMP19, TEMP23
        v_xor_b32 TEMP29, TEMP06, TEMP08
        v_bfi_b32 TEMP05, TEMP10, TEMP19, TEMP29
        v_xor_b32 TEMP17, TEMP23, TEMP05
        v_xor_b32 TEMP18, TEMP02, TEMP17
        v_bfi_b32 TEMP36, TEMP19, TEMP18, TEMP17
        v_bfi_b32 TEMP35, TEMP36, TEMP19, TEMP10
        v_bfi_b32 TEMP36, TEMP36, TEMP17, TEMP19
        v_xor_b32 TEMP36, TEMP10, TEMP36
        v_bfi_b32 TEMP32, TEMP18, TEMP05, TEMP36
        v_bfi_b32 TEMP21, TEMP18, TEMP10, TEMP19
        v_bfi_b32 TEMP33, TEMP35, TEMP21, TEMP32
        v_xor_b32 TEMP29, TEMP29, TEMP35
        v_bfi_b32 TEMP35, TEMP29, TEMP21, TEMP36
        v_bfi_b32 TEMP36, TEMP35, TEMP36, TEMP02
        v_not_b32 TEMP31, TEMP18
        v_bfi_b32 TEMP21, TEMP29, TEMP21, TEMP31
        v_bfi_b32 TEMP36, TEMP36, TEMP18, TEMP21
        v_bfi_b32 TEMP16, TEMP06, TEMP36, TEMP17
        v_bfi_b32 TEMP16, TEMP16, TEMP21, TEMP23
        v_xor_b32 TEMP14, TEMP18, TEMP29
        v_xor_b32 TEMP29, TEMP16, TEMP14
        v_xor_b32 TEMP33, TEMP33, TEMP29
        v_xor_b32 TEMP08, TEMP08, TEMP33
        v_bfi_b32 TEMP10, TEMP21, TEMP36, TEMP02
        v_bfi_b32 TEMP21, TEMP10, TEMP33, TEMP08
        v_not_b32 TEMP21, TEMP21
        v_bfi_b32 TEMP08, TEMP25, TEMP08, TEMP21
        v_xor_b32 DB28, DB28, TEMP08
        v_bfi_b32 TEMP08, TEMP22, TEMP30, TEMP28
        v_xor_b32 DB13, DB13, TEMP08
        v_bfi_b32 TEMP08, TEMP33, TEMP29, TEMP10
        v_bfi_b32 TEMP16, TEMP05, TEMP32, TEMP16
        v_xor_b32 TEMP16, TEMP08, TEMP16
        v_bfi_b32 TEMP16, TEMP25, TEMP16, TEMP35
        v_xor_b32 DB10, DB10, TEMP16
        v_bfi_b32 TEMP16, TEMP25, TEMP36, TEMP31
        v_xor_b32 DB03, DB03, TEMP16
        v_bfi_b32 TEMP16, TEMP22, TEMP27, TEMP12
        v_xor_b32 DB24, DB24, TEMP16
        v_bfi_b32 TEMP16, TEMP25, TEMP29, TEMP14
        v_xor_b32 DB18, DB18, TEMP16
		s_setpc_b64 s[82:83]



.S7_S8_B:
        s_getpc_b64 s[84:85]
		s_add_u32 s84,s84,12
		s_addc_u32 s85,s85,0
		s_branch .startLoop

        v_bfi_b32 TEMP28, TEMP02, TEMP13, TEMP14
        v_bfi_b32 TEMP36, TEMP03, TEMP02, TEMP01
        v_bfi_b32 TEMP35, TEMP14, TEMP03, TEMP02
        v_xor_b32 TEMP35, TEMP13, TEMP35
        v_bfi_b32 TEMP28, TEMP36, TEMP28, TEMP35
        v_xor_b32 TEMP36, TEMP01, TEMP28
        v_bfi_b32 TEMP32, TEMP35, TEMP02, TEMP36
        v_bfi_b32 TEMP21, TEMP14, TEMP13, TEMP35
        v_bfi_b32 TEMP35, TEMP21, TEMP03, TEMP32
        v_bfi_b32 TEMP21, TEMP01, TEMP21, TEMP02
        v_bfi_b32 TEMP32, TEMP21, TEMP36, TEMP03
        v_bfi_b32 TEMP33, TEMP01, TEMP02, TEMP14
        v_xor_b32 TEMP31, TEMP32, TEMP33
        v_xor_b32 TEMP30, TEMP35, TEMP31
        v_bfi_b32 TEMP10, TEMP02, TEMP30, TEMP33
        v_bfi_b32 TEMP15, TEMP10, TEMP01, TEMP28
        v_bfi_b32 TEMP33, TEMP15, TEMP33, TEMP32
        v_bfi_b32 TEMP33, TEMP31, TEMP33, TEMP28
        v_xor_b32 TEMP10, TEMP21, TEMP10
        v_xor_b32 TEMP21, TEMP36, TEMP10
        v_not_b32 TEMP32, TEMP21
        v_xor_b32 TEMP33, TEMP33, TEMP32
        v_bfi_b32 TEMP33, TEMP04, TEMP33, TEMP32
        v_xor_b32 DB20, DB20, TEMP33
        v_bfi_b32 TEMP33, TEMP35, TEMP15, TEMP32
        v_xor_b32 TEMP10, TEMP10, TEMP33
        v_bfi_b32 TEMP10, TEMP04, TEMP36, TEMP10
        v_xor_b32 DB26, DB26, TEMP10
        v_or_b32 TEMP13, TEMP03, TEMP35
        v_xor_b32 TEMP13, TEMP33, TEMP13
        v_bfi_b32 TEMP14, TEMP31, TEMP01, TEMP28
        v_xor_b32 TEMP14, TEMP13, TEMP14
        v_bfi_b32 TEMP14, TEMP04, TEMP21, TEMP14
        v_xor_b32 DB04, DB04, TEMP14
        v_bfi_b32 TEMP14, TEMP18, TEMP12, TEMP27
        v_bfi_b32 TEMP13, TEMP00, TEMP18, TEMP07
        v_bfi_b32 TEMP14, TEMP12, TEMP13, TEMP14
        v_bfi_b32 TEMP10, TEMP00, TEMP14, TEMP27
        v_bfi_b32 TEMP21, TEMP27, TEMP07, TEMP18
        v_xor_b32 TEMP21, TEMP00, TEMP21

        v_xor_b32 TEMP33, TEMP27, TEMP18
        v_bfi_b32 TEMP28, TEMP21, TEMP10, TEMP33
        v_xor_b32 TEMP36, TEMP12, TEMP07
        v_xor_b32 TEMP35, TEMP28, TEMP36
        v_xor_b32 TEMP32, TEMP18, TEMP35
        v_bfi_b32 TEMP28, TEMP28, TEMP35, TEMP32
        v_not_b32 TEMP15, TEMP12
        v_bfi_b32 TEMP10, TEMP10, TEMP32, TEMP15
        v_bfi_b32 TEMP15, TEMP07, TEMP32, TEMP21
        v_bfi_b32 TEMP36, TEMP36, TEMP33, TEMP15
        v_xor_b32 TEMP13, TEMP13, TEMP36
        v_bfi_b32 TEMP18, TEMP18, TEMP13, TEMP21
        v_xor_b32 TEMP36, TEMP10, TEMP18
        v_xor_b32 TEMP15, TEMP33, TEMP36
        v_xor_b32 TEMP01, TEMP32, TEMP15
        v_bfi_b32 TEMP34, TEMP00, TEMP01, TEMP28
        v_bfi_b32 TEMP08, TEMP33, TEMP12, TEMP32
        v_bfi_b32 TEMP08, TEMP07, TEMP08, TEMP35
        v_xor_b32 TEMP14, TEMP14, TEMP21
        v_bfi_b32 TEMP05, TEMP35, TEMP14, TEMP08
        v_bfi_b32 TEMP05, TEMP05, TEMP27, TEMP34
        v_not_b32 TEMP05, TEMP05
        v_bfi_b32 TEMP05, TEMP06, TEMP05, TEMP34
        v_xor_b32 DB06, DB06, TEMP05
        v_bfi_b32 TEMP29, TEMP04, TEMP31, TEMP30
        v_xor_b32 DB14, DB14, TEMP29
        v_bfi_b32 TEMP29, TEMP06, TEMP08, TEMP36
        v_xor_b32 DB11, DB11, TEMP29
        v_bfi_b32 TEMP08, TEMP18, TEMP15, TEMP08
        v_bfi_b32 TEMP08, TEMP10, TEMP14, TEMP08
        v_bfi_b32 TEMP08, TEMP06, TEMP13, TEMP08
        v_xor_b32 DB21, DB21, TEMP08
        v_bfi_b32 TEMP16, TEMP06, TEMP14, TEMP35
        v_xor_b32 DB31, DB31, TEMP16
		s_setpc_b64 s[82:83]



.startLoop:

		/*******/
		/* A 0 */
		/*******/

        v_xor_b32 TEMP15, K12, DB_EF00
        v_xor_b32 TEMP16, K46, DB_EF01
        v_xor_b32 TEMP17, K33, DB_EF02
        v_xor_b32 TEMP18, K52, DB_EF03
        v_xor_b32 TEMP19, K48, DB_EF04
        v_xor_b32 TEMP20, K20, DB_EF05
        v_xor_b32 TEMP21, K34, DB_EF06
        v_xor_b32 TEMP22, K55, DB_EF07
        v_xor_b32 TEMP23, K05, DB_EF08
        v_xor_b32 TEMP24, K13, DB_EF09
        v_xor_b32 TEMP25, K18, DB_EF10
        v_xor_b32 TEMP26, K40, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K04, DB07
        v_xor_b32 TEMP20, K32, DB08
        v_xor_b32 TEMP18, K26, DB09
        v_xor_b32 TEMP14, K27, DB10
        v_xor_b32 TEMP16, K38, DB11
        v_xor_b32 TEMP25, K54, DB12
        v_xor_b32 TEMP19, K53, DB11
        v_xor_b32 TEMP22, K06, DB12
        v_xor_b32 TEMP13, K31, DB13
        v_xor_b32 TEMP23, K25, DB14
        v_xor_b32 TEMP24, K19, DB15
        v_xor_b32 TEMP12, K41, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K15, DB_EF24
        v_xor_b32 TEMP09, K24, DB_EF25
        v_xor_b32 TEMP18, K28, DB_EF26
        v_xor_b32 TEMP21, K43, DB_EF27
        v_xor_b32 TEMP22, K30, DB_EF28
        v_xor_b32 TEMP23, K03, DB_EF29
        v_xor_b32 TEMP11, K35, DB_EF30
        v_xor_b32 TEMP14, K22, DB_EF31
        v_xor_b32 TEMP10, K02, DB_EF32
        v_xor_b32 TEMP24, K44, DB_EF33
        v_xor_b32 TEMP20, K14, DB_EF34
        v_xor_b32 TEMP25, K23, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K51, DB23
        v_xor_b32 TEMP18, K16, DB24
        v_xor_b32 TEMP21, K29, DB25
        v_xor_b32 TEMP24, K49, DB26
        v_xor_b32 TEMP26, K07, DB27
        v_xor_b32 TEMP23, K17, DB28
        v_xor_b32 TEMP19, K37, DB27
        v_xor_b32 TEMP12, K08, DB28
        v_xor_b32 TEMP25, K09, DB29
        v_xor_b32 TEMP22, K50, DB30
        v_xor_b32 TEMP11, K42, DB31
        v_xor_b32 TEMP20, K21, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/*******/
		/* B 1 */
		/*******/

        v_xor_b32 TEMP08, K05, DB_EF48
        v_xor_b32 TEMP18, K39, DB_EF49
        v_xor_b32 TEMP05, K26, DB_EF50
        v_xor_b32 TEMP16, K45, DB_EF51
        v_xor_b32 TEMP26, K41, DB_EF52
        v_xor_b32 TEMP19, K13, DB_EF53
        v_xor_b32 TEMP14, K27, DB_EF54
        v_xor_b32 TEMP06, K48, DB_EF55
        v_xor_b32 TEMP02, K53, DB_EF56
        v_xor_b32 TEMP07, K06, DB_EF57
        v_xor_b32 TEMP04, K11, DB_EF58
        v_xor_b32 TEMP03, K33, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K52, DB39
        v_xor_b32 TEMP18, K25, DB40
        v_xor_b32 TEMP10, K19, DB41	
        v_xor_b32 TEMP16, K20, DB42
        v_xor_b32 TEMP02, K31, DB43
        v_xor_b32 TEMP04, K47, DB44
        v_xor_b32 TEMP03, K46, DB43
        v_xor_b32 TEMP06, K54, DB44
        v_xor_b32 TEMP19, K55, DB45
        v_xor_b32 TEMP26, K18, DB46
        v_xor_b32 TEMP22, K12, DB47
        v_xor_b32 TEMP07, K34, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K08, DB_EF72
        v_xor_b32 TEMP18, K17, DB_EF73
        v_xor_b32 TEMP21, K21, DB_EF74
        v_xor_b32 TEMP22, K36, DB_EF75
        v_xor_b32 TEMP04, K23, DB_EF76
        v_xor_b32 TEMP07, K49, DB_EF77
        v_xor_b32 TEMP23, K28, DB_EF78
        v_xor_b32 TEMP06, K15, DB_EF79
        v_xor_b32 TEMP10, K24, DB_EF80
        v_xor_b32 TEMP19, K37, DB_EF81
		v_xor_b32 TEMP02, K07, DB_EF82
        v_xor_b32 TEMP25, K16, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K44, DB55
        v_xor_b32 TEMP18, K09, DB56
        v_xor_b32 TEMP27, K22, DB57
        v_xor_b32 TEMP00, K42, DB58
        v_xor_b32 TEMP12, K00, DB59
        v_xor_b32 TEMP07, K10, DB60
        v_xor_b32 TEMP03, K30, DB59
        v_xor_b32 TEMP01, K01, DB60
        v_xor_b32 TEMP14, K02, DB61
        v_xor_b32 TEMP13, K43, DB62
        v_xor_b32 TEMP02, K35, DB63
        v_xor_b32 TEMP04, K14, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*******/
		/* A 2 */
		/*******/

        v_xor_b32 TEMP15, K46, DB_EF00
        v_xor_b32 TEMP16, K25, DB_EF01
        v_xor_b32 TEMP17, K12, DB_EF02
        v_xor_b32 TEMP18, K31, DB_EF03
        v_xor_b32 TEMP19, K27, DB_EF04
        v_xor_b32 TEMP20, K54, DB_EF05
        v_xor_b32 TEMP21, K13, DB_EF06
        v_xor_b32 TEMP22, K34, DB_EF07
        v_xor_b32 TEMP23, K39, DB_EF08
        v_xor_b32 TEMP24, K47, DB_EF09
        v_xor_b32 TEMP25, K52, DB_EF10
        v_xor_b32 TEMP26, K19, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K38, DB07
        v_xor_b32 TEMP20, K11, DB08
        v_xor_b32 TEMP18, K05, DB09
        v_xor_b32 TEMP14, K06, DB10
        v_xor_b32 TEMP16, K48, DB11
        v_xor_b32 TEMP25, K33, DB12
        v_xor_b32 TEMP19, K32, DB11
        v_xor_b32 TEMP22, K40, DB12
        v_xor_b32 TEMP13, K41, DB13
        v_xor_b32 TEMP23, K04, DB14
        v_xor_b32 TEMP24, K53, DB15
        v_xor_b32 TEMP12, K20, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K51, DB_EF24
        v_xor_b32 TEMP09, K03, DB_EF25
        v_xor_b32 TEMP18, K07, DB_EF26
        v_xor_b32 TEMP21, K22, DB_EF27
        v_xor_b32 TEMP22, K09, DB_EF28
        v_xor_b32 TEMP23, K35, DB_EF29
        v_xor_b32 TEMP11, K14, DB_EF30
        v_xor_b32 TEMP14, K01, DB_EF31
        v_xor_b32 TEMP10, K10, DB_EF32
        v_xor_b32 TEMP24, K23, DB_EF33
        v_xor_b32 TEMP20, K50, DB_EF34
        v_xor_b32 TEMP25, K02, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K30, DB23
        v_xor_b32 TEMP18, K24, DB24
        v_xor_b32 TEMP21, K08, DB25
        v_xor_b32 TEMP24, K28, DB26
        v_xor_b32 TEMP26, K43, DB27
        v_xor_b32 TEMP23, K49, DB28
        v_xor_b32 TEMP19, K16, DB27
        v_xor_b32 TEMP12, K44, DB28
        v_xor_b32 TEMP25, K17, DB29
        v_xor_b32 TEMP22, K29, DB30
        v_xor_b32 TEMP11, K21, DB31
        v_xor_b32 TEMP20, K00, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/*******/
		/* B 3 */
		/*******/

        v_xor_b32 TEMP08, K32, DB_EF48
        v_xor_b32 TEMP18, K11, DB_EF49
        v_xor_b32 TEMP05, K53, DB_EF50
        v_xor_b32 TEMP16, K48, DB_EF51
        v_xor_b32 TEMP26, K13, DB_EF52
        v_xor_b32 TEMP19, K40, DB_EF53
        v_xor_b32 TEMP14, K54, DB_EF54
        v_xor_b32 TEMP06, K20, DB_EF55
        v_xor_b32 TEMP02, K25, DB_EF56
        v_xor_b32 TEMP07, K33, DB_EF57
        v_xor_b32 TEMP04, K38, DB_EF58
        v_xor_b32 TEMP03, K05, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K55, DB39
        v_xor_b32 TEMP18, K52, DB40
        v_xor_b32 TEMP10, K46, DB41	
        v_xor_b32 TEMP16, K47, DB42
        v_xor_b32 TEMP02, K34, DB43
        v_xor_b32 TEMP04, K19, DB44
        v_xor_b32 TEMP03, K18, DB43
        v_xor_b32 TEMP06, K26, DB44
        v_xor_b32 TEMP19, K27, DB45
        v_xor_b32 TEMP26, K45, DB46
        v_xor_b32 TEMP22, K39, DB47
        v_xor_b32 TEMP07, K06, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K37, DB_EF72
        v_xor_b32 TEMP18, K42, DB_EF73
        v_xor_b32 TEMP21, K50, DB_EF74
        v_xor_b32 TEMP22, K08, DB_EF75
        v_xor_b32 TEMP04, K24, DB_EF76
        v_xor_b32 TEMP07, K21, DB_EF77
        v_xor_b32 TEMP23, K00, DB_EF78
        v_xor_b32 TEMP06, K44, DB_EF79
        v_xor_b32 TEMP10, K49, DB_EF80
        v_xor_b32 TEMP19, K09, DB_EF81
		v_xor_b32 TEMP02, K36, DB_EF82
        v_xor_b32 TEMP25, K17, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K16, DB55
        v_xor_b32 TEMP18, K10, DB56
        v_xor_b32 TEMP27, K51, DB57
        v_xor_b32 TEMP00, K14, DB58
        v_xor_b32 TEMP12, K29, DB59
        v_xor_b32 TEMP07, K35, DB60
        v_xor_b32 TEMP03, K02, DB59
        v_xor_b32 TEMP01, K30, DB60
        v_xor_b32 TEMP14, K03, DB61
        v_xor_b32 TEMP13, K15, DB62
        v_xor_b32 TEMP02, K07, DB63
        v_xor_b32 TEMP04, K43, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*******/
		/* A 4 */
		/*******/

        v_xor_b32 TEMP15, K18, DB_EF00
        v_xor_b32 TEMP16, K52, DB_EF01
        v_xor_b32 TEMP17, K39, DB_EF02
        v_xor_b32 TEMP18, K34, DB_EF03
        v_xor_b32 TEMP19, K54, DB_EF04
        v_xor_b32 TEMP20, K26, DB_EF05
        v_xor_b32 TEMP21, K40, DB_EF06
        v_xor_b32 TEMP22, K06, DB_EF07
        v_xor_b32 TEMP23, K11, DB_EF08
        v_xor_b32 TEMP24, K19, DB_EF09
        v_xor_b32 TEMP25, K55, DB_EF10
        v_xor_b32 TEMP26, K46, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K41, DB07
        v_xor_b32 TEMP20, K38, DB08
        v_xor_b32 TEMP18, K32, DB09
        v_xor_b32 TEMP14, K33, DB10
        v_xor_b32 TEMP16, K20, DB11
        v_xor_b32 TEMP25, K05, DB12
        v_xor_b32 TEMP19, K04, DB11
        v_xor_b32 TEMP22, K12, DB12
        v_xor_b32 TEMP13, K13, DB13
        v_xor_b32 TEMP23, K31, DB14
        v_xor_b32 TEMP24, K25, DB15
        v_xor_b32 TEMP12, K47, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K23, DB_EF24
        v_xor_b32 TEMP09, K28, DB_EF25
        v_xor_b32 TEMP18, K36, DB_EF26
        v_xor_b32 TEMP21, K51, DB_EF27
        v_xor_b32 TEMP22, K10, DB_EF28
        v_xor_b32 TEMP23, K07, DB_EF29
        v_xor_b32 TEMP11, K43, DB_EF30
        v_xor_b32 TEMP14, K30, DB_EF31
        v_xor_b32 TEMP10, K35, DB_EF32
        v_xor_b32 TEMP24, K24, DB_EF33
        v_xor_b32 TEMP20, K22, DB_EF34
        v_xor_b32 TEMP25, K03, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K02, DB23
        v_xor_b32 TEMP18, K49, DB24
        v_xor_b32 TEMP21, K37, DB25
        v_xor_b32 TEMP24, K00, DB26
        v_xor_b32 TEMP26, K15, DB27
        v_xor_b32 TEMP23, K21, DB28
        v_xor_b32 TEMP19, K17, DB27
        v_xor_b32 TEMP12, K16, DB28
        v_xor_b32 TEMP25, K42, DB29
        v_xor_b32 TEMP22, K01, DB30
        v_xor_b32 TEMP11, K50, DB31
        v_xor_b32 TEMP20, K29, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/*******/
		/* B 5 */
		/*******/

        v_xor_b32 TEMP08, K04, DB_EF48
        v_xor_b32 TEMP18, K38, DB_EF49
        v_xor_b32 TEMP05, K25, DB_EF50
        v_xor_b32 TEMP16, K20, DB_EF51
        v_xor_b32 TEMP26, K40, DB_EF52
        v_xor_b32 TEMP19, K12, DB_EF53
        v_xor_b32 TEMP14, K26, DB_EF54
        v_xor_b32 TEMP06, K47, DB_EF55
        v_xor_b32 TEMP02, K52, DB_EF56
        v_xor_b32 TEMP07, K05, DB_EF57
        v_xor_b32 TEMP04, K41, DB_EF58
        v_xor_b32 TEMP03, K32, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K27, DB39
        v_xor_b32 TEMP18, K55, DB40
        v_xor_b32 TEMP10, K18, DB41	
        v_xor_b32 TEMP16, K19, DB42
        v_xor_b32 TEMP02, K06, DB43
        v_xor_b32 TEMP04, K46, DB44
        v_xor_b32 TEMP03, K45, DB43
        v_xor_b32 TEMP06, K53, DB44
        v_xor_b32 TEMP19, K54, DB45
        v_xor_b32 TEMP26, K48, DB46
        v_xor_b32 TEMP22, K11, DB47
        v_xor_b32 TEMP07, K33, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K09, DB_EF72
        v_xor_b32 TEMP18, K14, DB_EF73
        v_xor_b32 TEMP21, K22, DB_EF74
        v_xor_b32 TEMP22, K37, DB_EF75
        v_xor_b32 TEMP04, K49, DB_EF76
        v_xor_b32 TEMP07, K50, DB_EF77
        v_xor_b32 TEMP23, K29, DB_EF78
        v_xor_b32 TEMP06, K16, DB_EF79
        v_xor_b32 TEMP10, K21, DB_EF80
        v_xor_b32 TEMP19, K10, DB_EF81
		v_xor_b32 TEMP02, K08, DB_EF82
        v_xor_b32 TEMP25, K42, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K17, DB55
        v_xor_b32 TEMP18, K35, DB56
        v_xor_b32 TEMP27, K23, DB57
        v_xor_b32 TEMP00, K43, DB58
        v_xor_b32 TEMP12, K01, DB59
        v_xor_b32 TEMP07, K07, DB60
        v_xor_b32 TEMP03, K03, DB59
        v_xor_b32 TEMP01, K02, DB60
        v_xor_b32 TEMP14, K28, DB61
        v_xor_b32 TEMP13, K44, DB62
        v_xor_b32 TEMP02, K36, DB63
        v_xor_b32 TEMP04, K15, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*******/
		/* A 6 */
		/*******/

        v_xor_b32 TEMP15, K45, DB_EF00
        v_xor_b32 TEMP16, K55, DB_EF01
        v_xor_b32 TEMP17, K11, DB_EF02
        v_xor_b32 TEMP18, K06, DB_EF03
        v_xor_b32 TEMP19, K26, DB_EF04
        v_xor_b32 TEMP20, K53, DB_EF05
        v_xor_b32 TEMP21, K12, DB_EF06
        v_xor_b32 TEMP22, K33, DB_EF07
        v_xor_b32 TEMP23, K38, DB_EF08
        v_xor_b32 TEMP24, K46, DB_EF09
        v_xor_b32 TEMP25, K27, DB_EF10
        v_xor_b32 TEMP26, K18, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K13, DB07
        v_xor_b32 TEMP20, K41, DB08
        v_xor_b32 TEMP18, K04, DB09
        v_xor_b32 TEMP14, K05, DB10
        v_xor_b32 TEMP16, K47, DB11
        v_xor_b32 TEMP25, K32, DB12
        v_xor_b32 TEMP19, K31, DB11
        v_xor_b32 TEMP22, K39, DB12
        v_xor_b32 TEMP13, K40, DB13
        v_xor_b32 TEMP23, K34, DB14
        v_xor_b32 TEMP24, K52, DB15
        v_xor_b32 TEMP12, K19, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K24, DB_EF24
        v_xor_b32 TEMP09, K00, DB_EF25
        v_xor_b32 TEMP18, K08, DB_EF26
        v_xor_b32 TEMP21, K23, DB_EF27
        v_xor_b32 TEMP22, K35, DB_EF28
        v_xor_b32 TEMP23, K36, DB_EF29
        v_xor_b32 TEMP11, K15, DB_EF30
        v_xor_b32 TEMP14, K02, DB_EF31
        v_xor_b32 TEMP10, K07, DB_EF32
        v_xor_b32 TEMP24, K49, DB_EF33
        v_xor_b32 TEMP20, K51, DB_EF34
        v_xor_b32 TEMP25, K28, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K03, DB23
        v_xor_b32 TEMP18, K21, DB24
        v_xor_b32 TEMP21, K09, DB25
        v_xor_b32 TEMP24, K29, DB26
        v_xor_b32 TEMP26, K44, DB27
        v_xor_b32 TEMP23, K50, DB28
        v_xor_b32 TEMP19, K42, DB27
        v_xor_b32 TEMP12, K17, DB28
        v_xor_b32 TEMP25, K14, DB29
        v_xor_b32 TEMP22, K30, DB30
        v_xor_b32 TEMP11, K22, DB31
        v_xor_b32 TEMP20, K01, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/*******/
		/* B 7 */
		/*******/

        v_xor_b32 TEMP08, K31, DB_EF48
        v_xor_b32 TEMP18, K41, DB_EF49
        v_xor_b32 TEMP05, K52, DB_EF50
        v_xor_b32 TEMP16, K47, DB_EF51
        v_xor_b32 TEMP26, K12, DB_EF52
        v_xor_b32 TEMP19, K39, DB_EF53
        v_xor_b32 TEMP14, K53, DB_EF54
        v_xor_b32 TEMP06, K19, DB_EF55
        v_xor_b32 TEMP02, K55, DB_EF56
        v_xor_b32 TEMP07, K32, DB_EF57
        v_xor_b32 TEMP04, K13, DB_EF58
        v_xor_b32 TEMP03, K04, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K54, DB39
        v_xor_b32 TEMP18, K27, DB40
        v_xor_b32 TEMP10, K45, DB41	
        v_xor_b32 TEMP16, K46, DB42
        v_xor_b32 TEMP02, K33, DB43
        v_xor_b32 TEMP04, K18, DB44
        v_xor_b32 TEMP03, K48, DB43
        v_xor_b32 TEMP06, K25, DB44
        v_xor_b32 TEMP19, K26, DB45
        v_xor_b32 TEMP26, K20, DB46
        v_xor_b32 TEMP22, K38, DB47
        v_xor_b32 TEMP07, K05, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K10, DB_EF72
        v_xor_b32 TEMP18, K43, DB_EF73
        v_xor_b32 TEMP21, K51, DB_EF74
        v_xor_b32 TEMP22, K09, DB_EF75
        v_xor_b32 TEMP04, K21, DB_EF76
        v_xor_b32 TEMP07, K22, DB_EF77
        v_xor_b32 TEMP23, K01, DB_EF78
        v_xor_b32 TEMP06, K17, DB_EF79
        v_xor_b32 TEMP10, K50, DB_EF80
        v_xor_b32 TEMP19, K35, DB_EF81
		v_xor_b32 TEMP02, K37, DB_EF82
        v_xor_b32 TEMP25, K14, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K42, DB55
        v_xor_b32 TEMP18, K07, DB56
        v_xor_b32 TEMP27, K24, DB57
        v_xor_b32 TEMP00, K15, DB58
        v_xor_b32 TEMP12, K30, DB59
        v_xor_b32 TEMP07, K36, DB60
        v_xor_b32 TEMP03, K28, DB59
        v_xor_b32 TEMP01, K03, DB60
        v_xor_b32 TEMP14, K00, DB61
        v_xor_b32 TEMP13, K16, DB62
        v_xor_b32 TEMP02, K08, DB63
        v_xor_b32 TEMP04, K44, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*******/
		/* A 8 */
		/*******/

        v_xor_b32 TEMP15, K55, DB_EF00
        v_xor_b32 TEMP16, K34, DB_EF01
        v_xor_b32 TEMP17, K45, DB_EF02
        v_xor_b32 TEMP18, K40, DB_EF03
        v_xor_b32 TEMP19, K05, DB_EF04
        v_xor_b32 TEMP20, K32, DB_EF05
        v_xor_b32 TEMP21, K46, DB_EF06
        v_xor_b32 TEMP22, K12, DB_EF07
        v_xor_b32 TEMP23, K48, DB_EF08
        v_xor_b32 TEMP24, K25, DB_EF09
        v_xor_b32 TEMP25, K06, DB_EF10
        v_xor_b32 TEMP26, K52, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K47, DB07
        v_xor_b32 TEMP20, K20, DB08
        v_xor_b32 TEMP18, K38, DB09
        v_xor_b32 TEMP14, K39, DB10
        v_xor_b32 TEMP16, K26, DB11
        v_xor_b32 TEMP25, K11, DB12
        v_xor_b32 TEMP19, K41, DB11
        v_xor_b32 TEMP22, K18, DB12
        v_xor_b32 TEMP13, K19, DB13
        v_xor_b32 TEMP23, K13, DB14
        v_xor_b32 TEMP24, K31, DB15
        v_xor_b32 TEMP12, K53, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K03, DB_EF24
        v_xor_b32 TEMP09, K36, DB_EF25
        v_xor_b32 TEMP18, K44, DB_EF26
        v_xor_b32 TEMP21, K02, DB_EF27
        v_xor_b32 TEMP22, K14, DB_EF28
        v_xor_b32 TEMP23, K15, DB_EF29
        v_xor_b32 TEMP11, K51, DB_EF30
        v_xor_b32 TEMP14, K10, DB_EF31
        v_xor_b32 TEMP10, K43, DB_EF32
        v_xor_b32 TEMP24, K28, DB_EF33
        v_xor_b32 TEMP20, K30, DB_EF34
        v_xor_b32 TEMP25, K07, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K35, DB23
        v_xor_b32 TEMP18, K00, DB24
        v_xor_b32 TEMP21, K17, DB25
        v_xor_b32 TEMP24, K08, DB26
        v_xor_b32 TEMP26, K23, DB27
        v_xor_b32 TEMP23, K29, DB28
        v_xor_b32 TEMP19, K21, DB27
        v_xor_b32 TEMP12, K49, DB28
        v_xor_b32 TEMP25, K50, DB29
        v_xor_b32 TEMP22, K09, DB30
        v_xor_b32 TEMP11, K01, DB31
        v_xor_b32 TEMP20, K37, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/*******/
		/* B 9 */
		/*******/

        v_xor_b32 TEMP08, K41, DB_EF48
        v_xor_b32 TEMP18, K20, DB_EF49
        v_xor_b32 TEMP05, K31, DB_EF50
        v_xor_b32 TEMP16, K26, DB_EF51
        v_xor_b32 TEMP26, K46, DB_EF52
        v_xor_b32 TEMP19, K18, DB_EF53
        v_xor_b32 TEMP14, K32, DB_EF54
        v_xor_b32 TEMP06, K53, DB_EF55
        v_xor_b32 TEMP02, K34, DB_EF56
        v_xor_b32 TEMP07, K11, DB_EF57
        v_xor_b32 TEMP04, K47, DB_EF58
        v_xor_b32 TEMP03, K38, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K33, DB39
        v_xor_b32 TEMP18, K06, DB40
        v_xor_b32 TEMP10, K55, DB41	
        v_xor_b32 TEMP16, K25, DB42
        v_xor_b32 TEMP02, K12, DB43
        v_xor_b32 TEMP04, K52, DB44
        v_xor_b32 TEMP03, K27, DB43
        v_xor_b32 TEMP06, K04, DB44
        v_xor_b32 TEMP19, K05, DB45
        v_xor_b32 TEMP26, K54, DB46
        v_xor_b32 TEMP22, K48, DB47
        v_xor_b32 TEMP07, K39, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K42, DB_EF72
        v_xor_b32 TEMP18, K22, DB_EF73
        v_xor_b32 TEMP21, K30, DB_EF74
        v_xor_b32 TEMP22, K17, DB_EF75
        v_xor_b32 TEMP04, K00, DB_EF76
        v_xor_b32 TEMP07, K01, DB_EF77
        v_xor_b32 TEMP23, K37, DB_EF78
        v_xor_b32 TEMP06, K49, DB_EF79
        v_xor_b32 TEMP10, K29, DB_EF80
        v_xor_b32 TEMP19, K14, DB_EF81
		v_xor_b32 TEMP02, K16, DB_EF82
        v_xor_b32 TEMP25, K50, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K21, DB55
        v_xor_b32 TEMP18, K43, DB56
        v_xor_b32 TEMP27, K03, DB57
        v_xor_b32 TEMP00, K51, DB58
        v_xor_b32 TEMP12, K09, DB59
        v_xor_b32 TEMP07, K15, DB60
        v_xor_b32 TEMP03, K07, DB59
        v_xor_b32 TEMP01, K35, DB60
        v_xor_b32 TEMP14, K36, DB61
        v_xor_b32 TEMP13, K24, DB62
        v_xor_b32 TEMP02, K44, DB63
        v_xor_b32 TEMP04, K23, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/********/
		/* A 10 */
		/********/

        v_xor_b32 TEMP15, K27, DB_EF00
        v_xor_b32 TEMP16, K06, DB_EF01
        v_xor_b32 TEMP17, K48, DB_EF02
        v_xor_b32 TEMP18, K12, DB_EF03
        v_xor_b32 TEMP19, K32, DB_EF04
        v_xor_b32 TEMP20, K04, DB_EF05
        v_xor_b32 TEMP21, K18, DB_EF06
        v_xor_b32 TEMP22, K39, DB_EF07
        v_xor_b32 TEMP23, K20, DB_EF08
        v_xor_b32 TEMP24, K52, DB_EF09
        v_xor_b32 TEMP25, K33, DB_EF10
        v_xor_b32 TEMP26, K55, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K19, DB07
        v_xor_b32 TEMP20, K47, DB08
        v_xor_b32 TEMP18, K41, DB09
        v_xor_b32 TEMP14, K11, DB10
        v_xor_b32 TEMP16, K53, DB11
        v_xor_b32 TEMP25, K38, DB12
        v_xor_b32 TEMP19, K13, DB11
        v_xor_b32 TEMP22, K45, DB12
        v_xor_b32 TEMP13, K46, DB13
        v_xor_b32 TEMP23, K40, DB14
        v_xor_b32 TEMP24, K34, DB15
        v_xor_b32 TEMP12, K25, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K28, DB_EF24
        v_xor_b32 TEMP09, K08, DB_EF25
        v_xor_b32 TEMP18, K16, DB_EF26
        v_xor_b32 TEMP21, K03, DB_EF27
        v_xor_b32 TEMP22, K43, DB_EF28
        v_xor_b32 TEMP23, K44, DB_EF29
        v_xor_b32 TEMP11, K23, DB_EF30
        v_xor_b32 TEMP14, K35, DB_EF31
        v_xor_b32 TEMP10, K15, DB_EF32
        v_xor_b32 TEMP24, K00, DB_EF33
        v_xor_b32 TEMP20, K02, DB_EF34
        v_xor_b32 TEMP25, K36, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K07, DB23
        v_xor_b32 TEMP18, K29, DB24
        v_xor_b32 TEMP21, K42, DB25
        v_xor_b32 TEMP24, K37, DB26
        v_xor_b32 TEMP26, K24, DB27
        v_xor_b32 TEMP23, K01, DB28
        v_xor_b32 TEMP19, K50, DB27
        v_xor_b32 TEMP12, K21, DB28
        v_xor_b32 TEMP25, K22, DB29
        v_xor_b32 TEMP22, K10, DB30
        v_xor_b32 TEMP11, K30, DB31
        v_xor_b32 TEMP20, K09, DB00
        s_swappc_b64 s[82:83], s[92:93]

 		/********/
		/* B 11 */
		/********/

        v_xor_b32 TEMP08, K13, DB_EF48
        v_xor_b32 TEMP18, K47, DB_EF49
        v_xor_b32 TEMP05, K34, DB_EF50
        v_xor_b32 TEMP16, K53, DB_EF51
        v_xor_b32 TEMP26, K18, DB_EF52
        v_xor_b32 TEMP19, K45, DB_EF53
        v_xor_b32 TEMP14, K04, DB_EF54
        v_xor_b32 TEMP06, K25, DB_EF55
        v_xor_b32 TEMP02, K06, DB_EF56
        v_xor_b32 TEMP07, K38, DB_EF57
        v_xor_b32 TEMP04, K19, DB_EF58
        v_xor_b32 TEMP03, K41, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K05, DB39
        v_xor_b32 TEMP18, K33, DB40
        v_xor_b32 TEMP10, K27, DB41	
        v_xor_b32 TEMP16, K52, DB42
        v_xor_b32 TEMP02, K39, DB43
        v_xor_b32 TEMP04, K55, DB44
        v_xor_b32 TEMP03, K54, DB43
        v_xor_b32 TEMP06, K31, DB44
        v_xor_b32 TEMP19, K32, DB45
        v_xor_b32 TEMP26, K26, DB46
        v_xor_b32 TEMP22, K20, DB47
        v_xor_b32 TEMP07, K11, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K14, DB_EF72
        v_xor_b32 TEMP18, K51, DB_EF73
        v_xor_b32 TEMP21, K02, DB_EF74
        v_xor_b32 TEMP22, K42, DB_EF75
        v_xor_b32 TEMP04, K29, DB_EF76
        v_xor_b32 TEMP07, K30, DB_EF77
        v_xor_b32 TEMP23, K09, DB_EF78
        v_xor_b32 TEMP06, K21, DB_EF79
        v_xor_b32 TEMP10, K01, DB_EF80
        v_xor_b32 TEMP19, K43, DB_EF81
		v_xor_b32 TEMP02, K17, DB_EF82
        v_xor_b32 TEMP25, K22, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K50, DB55
        v_xor_b32 TEMP18, K15, DB56
        v_xor_b32 TEMP27, K28, DB57
        v_xor_b32 TEMP00, K23, DB58
        v_xor_b32 TEMP12, K10, DB59
        v_xor_b32 TEMP07, K44, DB60
        v_xor_b32 TEMP03, K36, DB59
        v_xor_b32 TEMP01, K07, DB60
        v_xor_b32 TEMP14, K08, DB61
        v_xor_b32 TEMP13, K49, DB62
        v_xor_b32 TEMP02, K16, DB63
        v_xor_b32 TEMP04, K24, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/********/
		/* A 12 */
		/********/

        v_xor_b32 TEMP15, K54, DB_EF00
        v_xor_b32 TEMP16, K33, DB_EF01
        v_xor_b32 TEMP17, K20, DB_EF02
        v_xor_b32 TEMP18, K39, DB_EF03
        v_xor_b32 TEMP19, K04, DB_EF04
        v_xor_b32 TEMP20, K31, DB_EF05
        v_xor_b32 TEMP21, K45, DB_EF06
        v_xor_b32 TEMP22, K11, DB_EF07
        v_xor_b32 TEMP23, K47, DB_EF08
        v_xor_b32 TEMP24, K55, DB_EF09
        v_xor_b32 TEMP25, K05, DB_EF10
        v_xor_b32 TEMP26, K27, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K46, DB07
        v_xor_b32 TEMP20, K19, DB08
        v_xor_b32 TEMP18, K13, DB09
        v_xor_b32 TEMP14, K38, DB10
        v_xor_b32 TEMP16, K25, DB11
        v_xor_b32 TEMP25, K41, DB12
        v_xor_b32 TEMP19, K40, DB11
        v_xor_b32 TEMP22, K48, DB12
        v_xor_b32 TEMP13, K18, DB13
        v_xor_b32 TEMP23, K12, DB14
        v_xor_b32 TEMP24, K06, DB15
        v_xor_b32 TEMP12, K52, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K00, DB_EF24
        v_xor_b32 TEMP09, K37, DB_EF25
        v_xor_b32 TEMP18, K17, DB_EF26
        v_xor_b32 TEMP21, K28, DB_EF27
        v_xor_b32 TEMP22, K15, DB_EF28
        v_xor_b32 TEMP23, K16, DB_EF29
        v_xor_b32 TEMP11, K24, DB_EF30
        v_xor_b32 TEMP14, K07, DB_EF31
        v_xor_b32 TEMP10, K44, DB_EF32
        v_xor_b32 TEMP24, K29, DB_EF33
        v_xor_b32 TEMP20, K03, DB_EF34
        v_xor_b32 TEMP25, K08, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K36, DB23
        v_xor_b32 TEMP18, K01, DB24
        v_xor_b32 TEMP21, K14, DB25
        v_xor_b32 TEMP24, K09, DB26
        v_xor_b32 TEMP26, K49, DB27
        v_xor_b32 TEMP23, K30, DB28
        v_xor_b32 TEMP19, K22, DB27
        v_xor_b32 TEMP12, K50, DB28
        v_xor_b32 TEMP25, K51, DB29
        v_xor_b32 TEMP22, K35, DB30
        v_xor_b32 TEMP11, K02, DB31
        v_xor_b32 TEMP20, K10, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/********/
		/* B 13 */
		/********/

        v_xor_b32 TEMP08, K40, DB_EF48
        v_xor_b32 TEMP18, K19, DB_EF49
        v_xor_b32 TEMP05, K06, DB_EF50
        v_xor_b32 TEMP16, K25, DB_EF51
        v_xor_b32 TEMP26, K45, DB_EF52
        v_xor_b32 TEMP19, K48, DB_EF53
        v_xor_b32 TEMP14, K31, DB_EF54
        v_xor_b32 TEMP06, K52, DB_EF55
        v_xor_b32 TEMP02, K33, DB_EF56
        v_xor_b32 TEMP07, K41, DB_EF57
        v_xor_b32 TEMP04, K46, DB_EF58
        v_xor_b32 TEMP03, K13, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K32, DB39
        v_xor_b32 TEMP18, K05, DB40
        v_xor_b32 TEMP10, K54, DB41	
        v_xor_b32 TEMP16, K55, DB42
        v_xor_b32 TEMP02, K11, DB43
        v_xor_b32 TEMP04, K27, DB44
        v_xor_b32 TEMP03, K26, DB43
        v_xor_b32 TEMP06, K34, DB44
        v_xor_b32 TEMP19, K04, DB45
        v_xor_b32 TEMP26, K53, DB46
        v_xor_b32 TEMP22, K47, DB47
        v_xor_b32 TEMP07, K38, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K43, DB_EF72
        v_xor_b32 TEMP18, K23, DB_EF73
        v_xor_b32 TEMP21, K03, DB_EF74
        v_xor_b32 TEMP22, K14, DB_EF75
        v_xor_b32 TEMP04, K01, DB_EF76
        v_xor_b32 TEMP07, K02, DB_EF77
        v_xor_b32 TEMP23, K10, DB_EF78
        v_xor_b32 TEMP06, K50, DB_EF79
        v_xor_b32 TEMP10, K30, DB_EF80
        v_xor_b32 TEMP19, K15, DB_EF81
		v_xor_b32 TEMP02, K42, DB_EF82
        v_xor_b32 TEMP25, K51, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K22, DB55
        v_xor_b32 TEMP18, K44, DB56
        v_xor_b32 TEMP27, K00, DB57
        v_xor_b32 TEMP00, K24, DB58
        v_xor_b32 TEMP12, K35, DB59
        v_xor_b32 TEMP07, K16, DB60
        v_xor_b32 TEMP03, K08, DB59
        v_xor_b32 TEMP01, K36, DB60
        v_xor_b32 TEMP14, K37, DB61
        v_xor_b32 TEMP13, K21, DB62
        v_xor_b32 TEMP02, K17, DB63
        v_xor_b32 TEMP04, K49, DB32
        s_swappc_b64 s[82:83], s[84:85]

 		/********/
		/* A 14 */
		/********/

        v_xor_b32 TEMP15, K26, DB_EF00
        v_xor_b32 TEMP16, K05, DB_EF01
        v_xor_b32 TEMP17, K47, DB_EF02
        v_xor_b32 TEMP18, K11, DB_EF03
        v_xor_b32 TEMP19, K31, DB_EF04
        v_xor_b32 TEMP20, K34, DB_EF05
        v_xor_b32 TEMP21, K48, DB_EF06
        v_xor_b32 TEMP22, K38, DB_EF07
        v_xor_b32 TEMP23, K19, DB_EF08
        v_xor_b32 TEMP24, K27, DB_EF09
        v_xor_b32 TEMP25, K32, DB_EF10
        v_xor_b32 TEMP26, K54, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K18, DB07
        v_xor_b32 TEMP20, K46, DB08
        v_xor_b32 TEMP18, K40, DB09
        v_xor_b32 TEMP14, K41, DB10
        v_xor_b32 TEMP16, K52, DB11
        v_xor_b32 TEMP25, K13, DB12
        v_xor_b32 TEMP19, K12, DB11
        v_xor_b32 TEMP22, K20, DB12
        v_xor_b32 TEMP13, K45, DB13
        v_xor_b32 TEMP23, K39, DB14
        v_xor_b32 TEMP24, K33, DB15
        v_xor_b32 TEMP12, K55, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K29, DB_EF24
        v_xor_b32 TEMP09, K09, DB_EF25
        v_xor_b32 TEMP18, K42, DB_EF26
        v_xor_b32 TEMP21, K00, DB_EF27
        v_xor_b32 TEMP22, K44, DB_EF28
        v_xor_b32 TEMP23, K17, DB_EF29
        v_xor_b32 TEMP11, K49, DB_EF30
        v_xor_b32 TEMP14, K36, DB_EF31
        v_xor_b32 TEMP10, K16, DB_EF32
        v_xor_b32 TEMP24, K01, DB_EF33
        v_xor_b32 TEMP20, K28, DB_EF34
        v_xor_b32 TEMP25, K37, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K08, DB23
        v_xor_b32 TEMP18, K30, DB24
        v_xor_b32 TEMP21, K43, DB25
        v_xor_b32 TEMP24, K10, DB26
        v_xor_b32 TEMP26, K21, DB27
        v_xor_b32 TEMP23, K02, DB28
        v_xor_b32 TEMP19, K51, DB27
        v_xor_b32 TEMP12, K22, DB28
        v_xor_b32 TEMP25, K23, DB29
        v_xor_b32 TEMP22, K07, DB30
        v_xor_b32 TEMP11, K03, DB31
        v_xor_b32 TEMP20, K35, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/********/
		/* B 15 */
		/********/

        v_xor_b32 TEMP08, K19, DB_EF48
        v_xor_b32 TEMP18, K53, DB_EF49
        v_xor_b32 TEMP05, K40, DB_EF50
        v_xor_b32 TEMP16, K04, DB_EF51
        v_xor_b32 TEMP26, K55, DB_EF52
        v_xor_b32 TEMP19, K27, DB_EF53
        v_xor_b32 TEMP14, K41, DB_EF54
        v_xor_b32 TEMP06, K31, DB_EF55
        v_xor_b32 TEMP02, K12, DB_EF56
        v_xor_b32 TEMP07, K20, DB_EF57
        v_xor_b32 TEMP04, K25, DB_EF58
        v_xor_b32 TEMP03, K47, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K11, DB39
        v_xor_b32 TEMP18, K39, DB40
        v_xor_b32 TEMP10, K33, DB41	
        v_xor_b32 TEMP16, K34, DB42
        v_xor_b32 TEMP02, K45, DB43
        v_xor_b32 TEMP04, K06, DB44
        v_xor_b32 TEMP03, K05, DB43
        v_xor_b32 TEMP06, K13, DB44
        v_xor_b32 TEMP19, K38, DB45
        v_xor_b32 TEMP26, K32, DB46
        v_xor_b32 TEMP22, K26, DB47
        v_xor_b32 TEMP07, K48, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K22, DB_EF72
        v_xor_b32 TEMP18, K02, DB_EF73
        v_xor_b32 TEMP21, K35, DB_EF74
        v_xor_b32 TEMP22, K50, DB_EF75
        v_xor_b32 TEMP04, K37, DB_EF76
        v_xor_b32 TEMP07, K10, DB_EF77
        v_xor_b32 TEMP23, K42, DB_EF78
        v_xor_b32 TEMP06, K29, DB_EF79
        v_xor_b32 TEMP10, K09, DB_EF80
        v_xor_b32 TEMP19, K51, DB_EF81
		v_xor_b32 TEMP02, K21, DB_EF82
        v_xor_b32 TEMP25, K30, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K01, DB55
        v_xor_b32 TEMP18, K23, DB56
        v_xor_b32 TEMP27, K36, DB57
        v_xor_b32 TEMP00, K03, DB58
        v_xor_b32 TEMP12, K14, DB59
        v_xor_b32 TEMP07, K24, DB60
        v_xor_b32 TEMP03, K44, DB59
        v_xor_b32 TEMP01, K15, DB60
        v_xor_b32 TEMP14, K16, DB61
        v_xor_b32 TEMP13, K00, DB62
        v_xor_b32 TEMP02, K49, DB63
        v_xor_b32 TEMP04, K28, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*********************************************/
	    s_cmp_eq_i32    s50, 1
        s_cbranch_scc1  .quitLoop
		/*********************************************/

		/*******/
		/* B 0 */
		/*******/

        v_xor_b32 TEMP08, K12, DB_EF48
        v_xor_b32 TEMP18, K46, DB_EF49
        v_xor_b32 TEMP05, K33, DB_EF50
        v_xor_b32 TEMP16, K52, DB_EF51
        v_xor_b32 TEMP26, K48, DB_EF52
        v_xor_b32 TEMP19, K20, DB_EF53
        v_xor_b32 TEMP14, K34, DB_EF54
		v_xor_b32 TEMP06, K55, DB_EF55
        v_xor_b32 TEMP02, K05, DB_EF56
        v_xor_b32 TEMP07, K13, DB_EF57
        v_xor_b32 TEMP04, K18, DB_EF58
        v_xor_b32 TEMP03, K40, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K04, DB39
        v_xor_b32 TEMP18, K32, DB40
        v_xor_b32 TEMP10, K26, DB41
        v_xor_b32 TEMP16, K27, DB42
        v_xor_b32 TEMP02, K38, DB43
        v_xor_b32 TEMP04, K54, DB44
        v_xor_b32 TEMP03, K53, DB43
        v_xor_b32 TEMP06, K06, DB44
        v_xor_b32 TEMP19, K31, DB45
        v_xor_b32 TEMP26, K25, DB46
        v_xor_b32 TEMP22, K19, DB47
        v_xor_b32 TEMP07, K41, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K15, DB_EF72
        v_xor_b32 TEMP18, K24, DB_EF73
        v_xor_b32 TEMP21, K28, DB_EF74
        v_xor_b32 TEMP22, K43, DB_EF75
        v_xor_b32 TEMP04, K30, DB_EF76
        v_xor_b32 TEMP07, K03, DB_EF77
        v_xor_b32 TEMP23, K35, DB_EF78
        v_xor_b32 TEMP06, K22, DB_EF79
        v_xor_b32 TEMP10, K02, DB_EF80
        v_xor_b32 TEMP19, K44, DB_EF81
        v_xor_b32 TEMP02, K14, DB_EF82
        v_xor_b32 TEMP25, K23, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K51, DB55
        v_xor_b32 TEMP18, K16, DB56
        v_xor_b32 TEMP27, K29, DB57
        v_xor_b32 TEMP00, K49, DB58
        v_xor_b32 TEMP12, K07, DB59
        v_xor_b32 TEMP07, K17, DB60
        v_xor_b32 TEMP03, K37, DB59
        v_xor_b32 TEMP01, K08, DB60
        v_xor_b32 TEMP14, K09, DB61
        v_xor_b32 TEMP13, K50, DB62
        v_xor_b32 TEMP02, K42, DB63
        v_xor_b32 TEMP04, K21, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*******/
		/* A 1 */
		/*******/

        v_xor_b32 TEMP15, K05, DB_EF00
        v_xor_b32 TEMP16, K39, DB_EF01
        v_xor_b32 TEMP17, K26, DB_EF02
        v_xor_b32 TEMP18, K45, DB_EF03
        v_xor_b32 TEMP19, K41, DB_EF04
        v_xor_b32 TEMP20, K13, DB_EF05
        v_xor_b32 TEMP21, K27, DB_EF06
        v_xor_b32 TEMP22, K48, DB_EF07
        v_xor_b32 TEMP23, K53, DB_EF08
        v_xor_b32 TEMP24, K06, DB_EF09
        v_xor_b32 TEMP25, K11, DB_EF10
        v_xor_b32 TEMP26, K33, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K52, DB07
        v_xor_b32 TEMP20, K25, DB08
        v_xor_b32 TEMP18, K19, DB09
        v_xor_b32 TEMP14, K20, DB10
        v_xor_b32 TEMP16, K31, DB11
        v_xor_b32 TEMP25, K47, DB12
        v_xor_b32 TEMP19, K46, DB11
        v_xor_b32 TEMP22, K54, DB12
        v_xor_b32 TEMP13, K55, DB13
        v_xor_b32 TEMP23, K18, DB14
        v_xor_b32 TEMP24, K12, DB15
        v_xor_b32 TEMP12, K34, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K08, DB_EF24
        v_xor_b32 TEMP09, K17, DB_EF25
        v_xor_b32 TEMP18, K21, DB_EF26
        v_xor_b32 TEMP21, K36, DB_EF27
        v_xor_b32 TEMP22, K23, DB_EF28
        v_xor_b32 TEMP23, K49, DB_EF29
        v_xor_b32 TEMP11, K28, DB_EF30
        v_xor_b32 TEMP14, K15, DB_EF31
        v_xor_b32 TEMP10, K24, DB_EF32
        v_xor_b32 TEMP24, K37, DB_EF33
        v_xor_b32 TEMP20, K07, DB_EF34
        v_xor_b32 TEMP25, K16, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K44, DB23
        v_xor_b32 TEMP18, K09, DB24
        v_xor_b32 TEMP21, K22, DB25
        v_xor_b32 TEMP24, K42, DB26
        v_xor_b32 TEMP26, K00, DB27
        v_xor_b32 TEMP23, K10, DB28
        v_xor_b32 TEMP19, K30, DB27
        v_xor_b32 TEMP12, K01, DB28
        v_xor_b32 TEMP25, K02, DB29
        v_xor_b32 TEMP22, K43, DB30
        v_xor_b32 TEMP11, K35, DB31
        v_xor_b32 TEMP20, K14, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/*******/
		/* B 2 */
		/*******/

        v_xor_b32 TEMP08, K46, DB_EF48
        v_xor_b32 TEMP18, K25, DB_EF49
        v_xor_b32 TEMP05, K12, DB_EF50
        v_xor_b32 TEMP16, K31, DB_EF51
        v_xor_b32 TEMP26, K27, DB_EF52
        v_xor_b32 TEMP19, K54, DB_EF53
        v_xor_b32 TEMP14, K13, DB_EF54
		v_xor_b32 TEMP06, K34, DB_EF55
        v_xor_b32 TEMP02, K39, DB_EF56
        v_xor_b32 TEMP07, K47, DB_EF57
        v_xor_b32 TEMP04, K52, DB_EF58
        v_xor_b32 TEMP03, K19, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K38, DB39
        v_xor_b32 TEMP18, K11, DB40
        v_xor_b32 TEMP10, K05, DB41
        v_xor_b32 TEMP16, K06, DB42
        v_xor_b32 TEMP02, K48, DB43
        v_xor_b32 TEMP04, K33, DB44
        v_xor_b32 TEMP03, K32, DB43
        v_xor_b32 TEMP06, K40, DB44
        v_xor_b32 TEMP19, K41, DB45
        v_xor_b32 TEMP26, K04, DB46
        v_xor_b32 TEMP22, K53, DB47
        v_xor_b32 TEMP07, K20, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K51, DB_EF72
        v_xor_b32 TEMP18, K03, DB_EF73
        v_xor_b32 TEMP21, K07, DB_EF74
        v_xor_b32 TEMP22, K22, DB_EF75
        v_xor_b32 TEMP04, K09, DB_EF76
        v_xor_b32 TEMP07, K35, DB_EF77
        v_xor_b32 TEMP23, K14, DB_EF78
        v_xor_b32 TEMP06, K01, DB_EF79
        v_xor_b32 TEMP10, K10, DB_EF80
        v_xor_b32 TEMP19, K23, DB_EF81
        v_xor_b32 TEMP02, K50, DB_EF82
        v_xor_b32 TEMP25, K02, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K30, DB55
        v_xor_b32 TEMP18, K24, DB56
        v_xor_b32 TEMP27, K08, DB57
        v_xor_b32 TEMP00, K28, DB58
        v_xor_b32 TEMP12, K43, DB59
        v_xor_b32 TEMP07, K49, DB60
        v_xor_b32 TEMP03, K16, DB59
        v_xor_b32 TEMP01, K44, DB60
        v_xor_b32 TEMP14, K17, DB61
        v_xor_b32 TEMP13, K29, DB62
        v_xor_b32 TEMP02, K21, DB63
        v_xor_b32 TEMP04, K00, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*******/
		/* A 3 */
		/*******/

        v_xor_b32 TEMP15, K32, DB_EF00
        v_xor_b32 TEMP16, K11, DB_EF01
        v_xor_b32 TEMP17, K53, DB_EF02
        v_xor_b32 TEMP18, K48, DB_EF03
        v_xor_b32 TEMP19, K13, DB_EF04
        v_xor_b32 TEMP20, K40, DB_EF05
        v_xor_b32 TEMP21, K54, DB_EF06
        v_xor_b32 TEMP22, K20, DB_EF07
        v_xor_b32 TEMP23, K25, DB_EF08
        v_xor_b32 TEMP24, K33, DB_EF09
        v_xor_b32 TEMP25, K38, DB_EF10
        v_xor_b32 TEMP26, K05, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K55, DB07
        v_xor_b32 TEMP20, K52, DB08
        v_xor_b32 TEMP18, K46, DB09
        v_xor_b32 TEMP14, K47, DB10
        v_xor_b32 TEMP16, K34, DB11
        v_xor_b32 TEMP25, K19, DB12
        v_xor_b32 TEMP19, K18, DB11
        v_xor_b32 TEMP22, K26, DB12
        v_xor_b32 TEMP13, K27, DB13
        v_xor_b32 TEMP23, K45, DB14
        v_xor_b32 TEMP24, K39, DB15
        v_xor_b32 TEMP12, K06, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K37, DB_EF24
        v_xor_b32 TEMP09, K42, DB_EF25
        v_xor_b32 TEMP18, K50, DB_EF26
        v_xor_b32 TEMP21, K08, DB_EF27
        v_xor_b32 TEMP22, K24, DB_EF28
        v_xor_b32 TEMP23, K21, DB_EF29
        v_xor_b32 TEMP11, K00, DB_EF30
        v_xor_b32 TEMP14, K44, DB_EF31
        v_xor_b32 TEMP10, K49, DB_EF32
        v_xor_b32 TEMP24, K09, DB_EF33
        v_xor_b32 TEMP20, K36, DB_EF34
        v_xor_b32 TEMP25, K17, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K16, DB23
        v_xor_b32 TEMP18, K10, DB24
        v_xor_b32 TEMP21, K51, DB25
        v_xor_b32 TEMP24, K14, DB26
        v_xor_b32 TEMP26, K29, DB27
        v_xor_b32 TEMP23, K35, DB28
        v_xor_b32 TEMP19, K02, DB27
        v_xor_b32 TEMP12, K30, DB28
        v_xor_b32 TEMP25, K03, DB29
        v_xor_b32 TEMP22, K15, DB30
        v_xor_b32 TEMP11, K07, DB31
        v_xor_b32 TEMP20, K43, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/*******/
		/* B 4 */
		/*******/

        v_xor_b32 TEMP08, K18, DB_EF48
        v_xor_b32 TEMP18, K52, DB_EF49
        v_xor_b32 TEMP05, K39, DB_EF50
        v_xor_b32 TEMP16, K34, DB_EF51
        v_xor_b32 TEMP26, K54, DB_EF52
        v_xor_b32 TEMP19, K26, DB_EF53
        v_xor_b32 TEMP14, K40, DB_EF54
		v_xor_b32 TEMP06, K06, DB_EF55
        v_xor_b32 TEMP02, K11, DB_EF56
        v_xor_b32 TEMP07, K19, DB_EF57
        v_xor_b32 TEMP04, K55, DB_EF58
        v_xor_b32 TEMP03, K46, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K41, DB39
        v_xor_b32 TEMP18, K38, DB40
        v_xor_b32 TEMP10, K32, DB41
        v_xor_b32 TEMP16, K33, DB42
        v_xor_b32 TEMP02, K20, DB43
        v_xor_b32 TEMP04, K05, DB44
        v_xor_b32 TEMP03, K04, DB43
        v_xor_b32 TEMP06, K12, DB44
        v_xor_b32 TEMP19, K13, DB45
        v_xor_b32 TEMP26, K31, DB46
        v_xor_b32 TEMP22, K25, DB47
        v_xor_b32 TEMP07, K47, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K23, DB_EF72
        v_xor_b32 TEMP18, K28, DB_EF73
        v_xor_b32 TEMP21, K36, DB_EF74
        v_xor_b32 TEMP22, K51, DB_EF75
        v_xor_b32 TEMP04, K10, DB_EF76
        v_xor_b32 TEMP07, K07, DB_EF77
        v_xor_b32 TEMP23, K43, DB_EF78
        v_xor_b32 TEMP06, K30, DB_EF79
        v_xor_b32 TEMP10, K35, DB_EF80
        v_xor_b32 TEMP19, K24, DB_EF81
        v_xor_b32 TEMP02, K22, DB_EF82
        v_xor_b32 TEMP25, K03, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K02, DB55
        v_xor_b32 TEMP18, K49, DB56
        v_xor_b32 TEMP27, K37, DB57
        v_xor_b32 TEMP00, K00, DB58
        v_xor_b32 TEMP12, K15, DB59
        v_xor_b32 TEMP07, K21, DB60
        v_xor_b32 TEMP03, K17, DB59
        v_xor_b32 TEMP01, K16, DB60
        v_xor_b32 TEMP14, K42, DB61
        v_xor_b32 TEMP13, K01, DB62
        v_xor_b32 TEMP02, K50, DB63
        v_xor_b32 TEMP04, K29, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*******/
		/* A 5 */
		/*******/

        v_xor_b32 TEMP15, K04, DB_EF00
        v_xor_b32 TEMP16, K38, DB_EF01
        v_xor_b32 TEMP17, K25, DB_EF02
        v_xor_b32 TEMP18, K20, DB_EF03
        v_xor_b32 TEMP19, K40, DB_EF04
        v_xor_b32 TEMP20, K12, DB_EF05
        v_xor_b32 TEMP21, K26, DB_EF06
        v_xor_b32 TEMP22, K47, DB_EF07
        v_xor_b32 TEMP23, K52, DB_EF08
        v_xor_b32 TEMP24, K05, DB_EF09
        v_xor_b32 TEMP25, K41, DB_EF10
        v_xor_b32 TEMP26, K32, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K27, DB07
        v_xor_b32 TEMP20, K55, DB08
        v_xor_b32 TEMP18, K18, DB09
        v_xor_b32 TEMP14, K19, DB10
        v_xor_b32 TEMP16, K06, DB11
        v_xor_b32 TEMP25, K46, DB12
        v_xor_b32 TEMP19, K45, DB11
        v_xor_b32 TEMP22, K53, DB12
        v_xor_b32 TEMP13, K54, DB13
        v_xor_b32 TEMP23, K48, DB14
        v_xor_b32 TEMP24, K11, DB15
        v_xor_b32 TEMP12, K33, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K09, DB_EF24
        v_xor_b32 TEMP09, K14, DB_EF25
        v_xor_b32 TEMP18, K22, DB_EF26
        v_xor_b32 TEMP21, K37, DB_EF27
        v_xor_b32 TEMP22, K49, DB_EF28
        v_xor_b32 TEMP23, K50, DB_EF29
        v_xor_b32 TEMP11, K29, DB_EF30
        v_xor_b32 TEMP14, K16, DB_EF31
        v_xor_b32 TEMP10, K21, DB_EF32
        v_xor_b32 TEMP24, K10, DB_EF33
        v_xor_b32 TEMP20, K08, DB_EF34
        v_xor_b32 TEMP25, K42, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K17, DB23
        v_xor_b32 TEMP18, K35, DB24
        v_xor_b32 TEMP21, K23, DB25
        v_xor_b32 TEMP24, K43, DB26
        v_xor_b32 TEMP26, K01, DB27
        v_xor_b32 TEMP23, K07, DB28
        v_xor_b32 TEMP19, K03, DB27
        v_xor_b32 TEMP12, K02, DB28
        v_xor_b32 TEMP25, K28, DB29
        v_xor_b32 TEMP22, K44, DB30
        v_xor_b32 TEMP11, K36, DB31
        v_xor_b32 TEMP20, K15, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/*******/
		/* B 6 */
		/*******/

        v_xor_b32 TEMP08, K45, DB_EF48
        v_xor_b32 TEMP18, K55, DB_EF49
        v_xor_b32 TEMP05, K11, DB_EF50
        v_xor_b32 TEMP16, K06, DB_EF51
        v_xor_b32 TEMP26, K26, DB_EF52
        v_xor_b32 TEMP19, K53, DB_EF53
        v_xor_b32 TEMP14, K12, DB_EF54
		v_xor_b32 TEMP06, K33, DB_EF55
        v_xor_b32 TEMP02, K38, DB_EF56
        v_xor_b32 TEMP07, K46, DB_EF57
        v_xor_b32 TEMP04, K27, DB_EF58
        v_xor_b32 TEMP03, K18, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K13, DB39
        v_xor_b32 TEMP18, K41, DB40
        v_xor_b32 TEMP10, K04, DB41
        v_xor_b32 TEMP16, K05, DB42
        v_xor_b32 TEMP02, K47, DB43
        v_xor_b32 TEMP04, K32, DB44
        v_xor_b32 TEMP03, K31, DB43
        v_xor_b32 TEMP06, K39, DB44
        v_xor_b32 TEMP19, K40, DB45
        v_xor_b32 TEMP26, K34, DB46
        v_xor_b32 TEMP22, K52, DB47
        v_xor_b32 TEMP07, K19, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K24, DB_EF72
        v_xor_b32 TEMP18, K00, DB_EF73
        v_xor_b32 TEMP21, K08, DB_EF74
        v_xor_b32 TEMP22, K23, DB_EF75
        v_xor_b32 TEMP04, K35, DB_EF76
        v_xor_b32 TEMP07, K36, DB_EF77
        v_xor_b32 TEMP23, K15, DB_EF78
        v_xor_b32 TEMP06, K02, DB_EF79
        v_xor_b32 TEMP10, K07, DB_EF80
        v_xor_b32 TEMP19, K49, DB_EF81
        v_xor_b32 TEMP02, K51, DB_EF82
        v_xor_b32 TEMP25, K28, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K03, DB55
        v_xor_b32 TEMP18, K21, DB56
        v_xor_b32 TEMP27, K09, DB57
        v_xor_b32 TEMP00, K29, DB58
        v_xor_b32 TEMP12, K44, DB59
        v_xor_b32 TEMP07, K50, DB60
        v_xor_b32 TEMP03, K42, DB59
        v_xor_b32 TEMP01, K17, DB60
        v_xor_b32 TEMP14, K14, DB61
        v_xor_b32 TEMP13, K30, DB62
        v_xor_b32 TEMP02, K22, DB63
        v_xor_b32 TEMP04, K01, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*******/
		/* A 7 */
		/*******/

        v_xor_b32 TEMP15, K31, DB_EF00
        v_xor_b32 TEMP16, K41, DB_EF01
        v_xor_b32 TEMP17, K52, DB_EF02
        v_xor_b32 TEMP18, K47, DB_EF03
        v_xor_b32 TEMP19, K12, DB_EF04
        v_xor_b32 TEMP20, K39, DB_EF05
        v_xor_b32 TEMP21, K53, DB_EF06
        v_xor_b32 TEMP22, K19, DB_EF07
        v_xor_b32 TEMP23, K55, DB_EF08
        v_xor_b32 TEMP24, K32, DB_EF09
        v_xor_b32 TEMP25, K13, DB_EF10
        v_xor_b32 TEMP26, K04, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K54, DB07
        v_xor_b32 TEMP20, K27, DB08
        v_xor_b32 TEMP18, K45, DB09
        v_xor_b32 TEMP14, K46, DB10
        v_xor_b32 TEMP16, K33, DB11
        v_xor_b32 TEMP25, K18, DB12
        v_xor_b32 TEMP19, K48, DB11
        v_xor_b32 TEMP22, K25, DB12
        v_xor_b32 TEMP13, K26, DB13
        v_xor_b32 TEMP23, K20, DB14
        v_xor_b32 TEMP24, K38, DB15
        v_xor_b32 TEMP12, K05, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K10, DB_EF24
        v_xor_b32 TEMP09, K43, DB_EF25
        v_xor_b32 TEMP18, K51, DB_EF26
        v_xor_b32 TEMP21, K09, DB_EF27
        v_xor_b32 TEMP22, K21, DB_EF28
        v_xor_b32 TEMP23, K22, DB_EF29
        v_xor_b32 TEMP11, K01, DB_EF30
        v_xor_b32 TEMP14, K17, DB_EF31
        v_xor_b32 TEMP10, K50, DB_EF32
        v_xor_b32 TEMP24, K35, DB_EF33
        v_xor_b32 TEMP20, K37, DB_EF34
        v_xor_b32 TEMP25, K14, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K42, DB23
        v_xor_b32 TEMP18, K07, DB24
        v_xor_b32 TEMP21, K24, DB25
        v_xor_b32 TEMP24, K15, DB26
        v_xor_b32 TEMP26, K30, DB27
        v_xor_b32 TEMP23, K36, DB28
        v_xor_b32 TEMP19, K28, DB27
        v_xor_b32 TEMP12, K03, DB28
        v_xor_b32 TEMP25, K00, DB29
        v_xor_b32 TEMP22, K16, DB30
        v_xor_b32 TEMP11, K08, DB31
        v_xor_b32 TEMP20, K44, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/*******/
		/* B 8 */
		/*******/

        v_xor_b32 TEMP08, K55, DB_EF48
        v_xor_b32 TEMP18, K34, DB_EF49
        v_xor_b32 TEMP05, K45, DB_EF50
        v_xor_b32 TEMP16, K40, DB_EF51
        v_xor_b32 TEMP26, K05, DB_EF52
        v_xor_b32 TEMP19, K32, DB_EF53
        v_xor_b32 TEMP14, K46, DB_EF54
		v_xor_b32 TEMP06, K12, DB_EF55
        v_xor_b32 TEMP02, K48, DB_EF56
        v_xor_b32 TEMP07, K25, DB_EF57
        v_xor_b32 TEMP04, K06, DB_EF58
        v_xor_b32 TEMP03, K52, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K47, DB39
        v_xor_b32 TEMP18, K20, DB40
        v_xor_b32 TEMP10, K38, DB41
        v_xor_b32 TEMP16, K39, DB42
        v_xor_b32 TEMP02, K26, DB43
        v_xor_b32 TEMP04, K11, DB44
        v_xor_b32 TEMP03, K41, DB43
        v_xor_b32 TEMP06, K18, DB44
        v_xor_b32 TEMP19, K19, DB45
        v_xor_b32 TEMP26, K13, DB46
        v_xor_b32 TEMP22, K31, DB47
        v_xor_b32 TEMP07, K53, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K03, DB_EF72
        v_xor_b32 TEMP18, K36, DB_EF73
        v_xor_b32 TEMP21, K44, DB_EF74
        v_xor_b32 TEMP22, K02, DB_EF75
        v_xor_b32 TEMP04, K14, DB_EF76
        v_xor_b32 TEMP07, K15, DB_EF77
        v_xor_b32 TEMP23, K51, DB_EF78
        v_xor_b32 TEMP06, K10, DB_EF79
        v_xor_b32 TEMP10, K43, DB_EF80
        v_xor_b32 TEMP19, K28, DB_EF81
        v_xor_b32 TEMP02, K30, DB_EF82
        v_xor_b32 TEMP25, K07, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K35, DB55
        v_xor_b32 TEMP18, K00, DB56
        v_xor_b32 TEMP27, K17, DB57
        v_xor_b32 TEMP00, K08, DB58
        v_xor_b32 TEMP12, K23, DB59
        v_xor_b32 TEMP07, K29, DB60
        v_xor_b32 TEMP03, K21, DB59
        v_xor_b32 TEMP01, K49, DB60
        v_xor_b32 TEMP14, K50, DB61
        v_xor_b32 TEMP13, K09, DB62
        v_xor_b32 TEMP02, K01, DB63
        v_xor_b32 TEMP04, K37, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/*******/
		/* A 9 */
		/*******/

        v_xor_b32 TEMP15, K41, DB_EF00
        v_xor_b32 TEMP16, K20, DB_EF01
        v_xor_b32 TEMP17, K31, DB_EF02
        v_xor_b32 TEMP18, K26, DB_EF03
        v_xor_b32 TEMP19, K46, DB_EF04
        v_xor_b32 TEMP20, K18, DB_EF05
        v_xor_b32 TEMP21, K32, DB_EF06
        v_xor_b32 TEMP22, K53, DB_EF07
        v_xor_b32 TEMP23, K34, DB_EF08
        v_xor_b32 TEMP24, K11, DB_EF09
        v_xor_b32 TEMP25, K47, DB_EF10
        v_xor_b32 TEMP26, K38, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K33, DB07
        v_xor_b32 TEMP20, K06, DB08
        v_xor_b32 TEMP18, K55, DB09
        v_xor_b32 TEMP14, K25, DB10
        v_xor_b32 TEMP16, K12, DB11
        v_xor_b32 TEMP25, K52, DB12
        v_xor_b32 TEMP19, K27, DB11
        v_xor_b32 TEMP22, K04, DB12
        v_xor_b32 TEMP13, K05, DB13
        v_xor_b32 TEMP23, K54, DB14
        v_xor_b32 TEMP24, K48, DB15
        v_xor_b32 TEMP12, K39, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K42, DB_EF24
        v_xor_b32 TEMP09, K22, DB_EF25
        v_xor_b32 TEMP18, K30, DB_EF26
        v_xor_b32 TEMP21, K17, DB_EF27
        v_xor_b32 TEMP22, K00, DB_EF28
        v_xor_b32 TEMP23, K01, DB_EF29
        v_xor_b32 TEMP11, K37, DB_EF30
        v_xor_b32 TEMP14, K49, DB_EF31
        v_xor_b32 TEMP10, K29, DB_EF32
        v_xor_b32 TEMP24, K14, DB_EF33
        v_xor_b32 TEMP20, K16, DB_EF34
        v_xor_b32 TEMP25, K50, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K21, DB23
        v_xor_b32 TEMP18, K43, DB24
        v_xor_b32 TEMP21, K03, DB25
        v_xor_b32 TEMP24, K51, DB26
        v_xor_b32 TEMP26, K09, DB27
        v_xor_b32 TEMP23, K15, DB28
        v_xor_b32 TEMP19, K07, DB27
        v_xor_b32 TEMP12, K35, DB28
        v_xor_b32 TEMP25, K36, DB29
        v_xor_b32 TEMP22, K24, DB30
        v_xor_b32 TEMP11, K44, DB31
        v_xor_b32 TEMP20, K23, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/********/
		/* B 10 */
		/********/

        v_xor_b32 TEMP08, K27, DB_EF48
        v_xor_b32 TEMP18, K06, DB_EF49
        v_xor_b32 TEMP05, K48, DB_EF50
        v_xor_b32 TEMP16, K12, DB_EF51
        v_xor_b32 TEMP26, K32, DB_EF52
        v_xor_b32 TEMP19, K04, DB_EF53
        v_xor_b32 TEMP14, K18, DB_EF54
		v_xor_b32 TEMP06, K39, DB_EF55
        v_xor_b32 TEMP02, K20, DB_EF56
        v_xor_b32 TEMP07, K52, DB_EF57
        v_xor_b32 TEMP04, K33, DB_EF58
        v_xor_b32 TEMP03, K55, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K19, DB39
        v_xor_b32 TEMP18, K47, DB40
        v_xor_b32 TEMP10, K41, DB41
        v_xor_b32 TEMP16, K11, DB42
        v_xor_b32 TEMP02, K53, DB43
        v_xor_b32 TEMP04, K38, DB44
        v_xor_b32 TEMP03, K13, DB43
        v_xor_b32 TEMP06, K45, DB44
        v_xor_b32 TEMP19, K46, DB45
        v_xor_b32 TEMP26, K40, DB46
        v_xor_b32 TEMP22, K34, DB47
        v_xor_b32 TEMP07, K25, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K28, DB_EF72
        v_xor_b32 TEMP18, K08, DB_EF73
        v_xor_b32 TEMP21, K16, DB_EF74
        v_xor_b32 TEMP22, K03, DB_EF75
        v_xor_b32 TEMP04, K43, DB_EF76
        v_xor_b32 TEMP07, K44, DB_EF77
        v_xor_b32 TEMP23, K23, DB_EF78
        v_xor_b32 TEMP06, K35, DB_EF79
        v_xor_b32 TEMP10, K15, DB_EF80
        v_xor_b32 TEMP19, K00, DB_EF81
        v_xor_b32 TEMP02, K02, DB_EF82
        v_xor_b32 TEMP25, K36, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K07, DB55
        v_xor_b32 TEMP18, K29, DB56
        v_xor_b32 TEMP27, K42, DB57
        v_xor_b32 TEMP00, K37, DB58
        v_xor_b32 TEMP12, K24, DB59
        v_xor_b32 TEMP07, K01, DB60
        v_xor_b32 TEMP03, K50, DB59
        v_xor_b32 TEMP01, K21, DB60
        v_xor_b32 TEMP14, K22, DB61
        v_xor_b32 TEMP13, K10, DB62
        v_xor_b32 TEMP02, K30, DB63
        v_xor_b32 TEMP04, K09, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/********/
		/* A 11 */
		/********/

        v_xor_b32 TEMP15, K13, DB_EF00
        v_xor_b32 TEMP16, K47, DB_EF01
        v_xor_b32 TEMP17, K34, DB_EF02
        v_xor_b32 TEMP18, K53, DB_EF03
        v_xor_b32 TEMP19, K18, DB_EF04
        v_xor_b32 TEMP20, K45, DB_EF05
        v_xor_b32 TEMP21, K04, DB_EF06
        v_xor_b32 TEMP22, K25, DB_EF07
        v_xor_b32 TEMP23, K06, DB_EF08
        v_xor_b32 TEMP24, K38, DB_EF09
        v_xor_b32 TEMP25, K19, DB_EF10
        v_xor_b32 TEMP26, K41, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K05, DB07
        v_xor_b32 TEMP20, K33, DB08
        v_xor_b32 TEMP18, K27, DB09
        v_xor_b32 TEMP14, K52, DB10
        v_xor_b32 TEMP16, K39, DB11
        v_xor_b32 TEMP25, K55, DB12
        v_xor_b32 TEMP19, K54, DB11
        v_xor_b32 TEMP22, K31, DB12
        v_xor_b32 TEMP13, K32, DB13
        v_xor_b32 TEMP23, K26, DB14
        v_xor_b32 TEMP24, K20, DB15
        v_xor_b32 TEMP12, K11, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K14, DB_EF24
        v_xor_b32 TEMP09, K51, DB_EF25
        v_xor_b32 TEMP18, K02, DB_EF26
        v_xor_b32 TEMP21, K42, DB_EF27
        v_xor_b32 TEMP22, K29, DB_EF28
        v_xor_b32 TEMP23, K30, DB_EF29
        v_xor_b32 TEMP11, K09, DB_EF30
        v_xor_b32 TEMP14, K21, DB_EF31
        v_xor_b32 TEMP10, K01, DB_EF32
        v_xor_b32 TEMP24, K43, DB_EF33
        v_xor_b32 TEMP20, K17, DB_EF34
        v_xor_b32 TEMP25, K22, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K50, DB23
        v_xor_b32 TEMP18, K15, DB24
        v_xor_b32 TEMP21, K28, DB25
        v_xor_b32 TEMP24, K23, DB26
        v_xor_b32 TEMP26, K10, DB27
        v_xor_b32 TEMP23, K44, DB28
        v_xor_b32 TEMP19, K36, DB27
        v_xor_b32 TEMP12, K07, DB28
        v_xor_b32 TEMP25, K08, DB29
        v_xor_b32 TEMP22, K49, DB30
        v_xor_b32 TEMP11, K16, DB31
        v_xor_b32 TEMP20, K24, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/********/
		/* B 12 */
		/********/

        v_xor_b32 TEMP08, K54, DB_EF48
        v_xor_b32 TEMP18, K33, DB_EF49
        v_xor_b32 TEMP05, K20, DB_EF50
        v_xor_b32 TEMP16, K39, DB_EF51
        v_xor_b32 TEMP26, K04, DB_EF52
        v_xor_b32 TEMP19, K31, DB_EF53
        v_xor_b32 TEMP14, K45, DB_EF54
		v_xor_b32 TEMP06, K11, DB_EF55
        v_xor_b32 TEMP02, K47, DB_EF56
        v_xor_b32 TEMP07, K55, DB_EF57
        v_xor_b32 TEMP04, K05, DB_EF58
        v_xor_b32 TEMP03, K27, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K46, DB39
        v_xor_b32 TEMP18, K19, DB40
        v_xor_b32 TEMP10, K13, DB41
        v_xor_b32 TEMP16, K38, DB42
        v_xor_b32 TEMP02, K25, DB43
        v_xor_b32 TEMP04, K41, DB44
        v_xor_b32 TEMP03, K40, DB43
        v_xor_b32 TEMP06, K48, DB44
        v_xor_b32 TEMP19, K18, DB45
        v_xor_b32 TEMP26, K12, DB46
        v_xor_b32 TEMP22, K06, DB47
        v_xor_b32 TEMP07, K52, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K00, DB_EF72
        v_xor_b32 TEMP18, K37, DB_EF73
        v_xor_b32 TEMP21, K17, DB_EF74
        v_xor_b32 TEMP22, K28, DB_EF75
        v_xor_b32 TEMP04, K15, DB_EF76
        v_xor_b32 TEMP07, K16, DB_EF77
        v_xor_b32 TEMP23, K24, DB_EF78
        v_xor_b32 TEMP06, K07, DB_EF79
        v_xor_b32 TEMP10, K44, DB_EF80
        v_xor_b32 TEMP19, K29, DB_EF81
        v_xor_b32 TEMP02, K03, DB_EF82
        v_xor_b32 TEMP25, K08, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K36, DB55
        v_xor_b32 TEMP18, K01, DB56
        v_xor_b32 TEMP27, K14, DB57
        v_xor_b32 TEMP00, K09, DB58
        v_xor_b32 TEMP12, K49, DB59
        v_xor_b32 TEMP07, K30, DB60
        v_xor_b32 TEMP03, K22, DB59
        v_xor_b32 TEMP01, K50, DB60
        v_xor_b32 TEMP14, K51, DB61
        v_xor_b32 TEMP13, K35, DB62
        v_xor_b32 TEMP02, K02, DB63
        v_xor_b32 TEMP04, K10, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/********/
		/* A 13 */
		/********/

        v_xor_b32 TEMP15, K40, DB_EF00
        v_xor_b32 TEMP16, K19, DB_EF01
        v_xor_b32 TEMP17, K06, DB_EF02
        v_xor_b32 TEMP18, K25, DB_EF03
        v_xor_b32 TEMP19, K45, DB_EF04
        v_xor_b32 TEMP20, K48, DB_EF05
        v_xor_b32 TEMP21, K31, DB_EF06
        v_xor_b32 TEMP22, K52, DB_EF07
        v_xor_b32 TEMP23, K33, DB_EF08
        v_xor_b32 TEMP24, K41, DB_EF09
        v_xor_b32 TEMP25, K46, DB_EF10
        v_xor_b32 TEMP26, K13, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K32, DB07
        v_xor_b32 TEMP20, K05, DB08
        v_xor_b32 TEMP18, K54, DB09
        v_xor_b32 TEMP14, K55, DB10
        v_xor_b32 TEMP16, K11, DB11
        v_xor_b32 TEMP25, K27, DB12
        v_xor_b32 TEMP19, K26, DB11
        v_xor_b32 TEMP22, K34, DB12
        v_xor_b32 TEMP13, K04, DB13
        v_xor_b32 TEMP23, K53, DB14
        v_xor_b32 TEMP24, K47, DB15
        v_xor_b32 TEMP12, K38, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K43, DB_EF24
        v_xor_b32 TEMP09, K23, DB_EF25
        v_xor_b32 TEMP18, K03, DB_EF26
        v_xor_b32 TEMP21, K14, DB_EF27
        v_xor_b32 TEMP22, K01, DB_EF28
        v_xor_b32 TEMP23, K02, DB_EF29
        v_xor_b32 TEMP11, K10, DB_EF30
        v_xor_b32 TEMP14, K50, DB_EF31
        v_xor_b32 TEMP10, K30, DB_EF32
        v_xor_b32 TEMP24, K15, DB_EF33
        v_xor_b32 TEMP20, K42, DB_EF34
        v_xor_b32 TEMP25, K51, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K22, DB23
        v_xor_b32 TEMP18, K44, DB24
        v_xor_b32 TEMP21, K00, DB25
        v_xor_b32 TEMP24, K24, DB26
        v_xor_b32 TEMP26, K35, DB27
        v_xor_b32 TEMP23, K16, DB28
        v_xor_b32 TEMP19, K08, DB27
        v_xor_b32 TEMP12, K36, DB28
        v_xor_b32 TEMP25, K37, DB29
        v_xor_b32 TEMP22, K21, DB30
        v_xor_b32 TEMP11, K17, DB31
        v_xor_b32 TEMP20, K49, DB00
        s_swappc_b64 s[82:83], s[92:93]

		/********/
		/* B 14 */
		/********/

        v_xor_b32 TEMP08, K26, DB_EF48
        v_xor_b32 TEMP18, K05, DB_EF49
        v_xor_b32 TEMP05, K47, DB_EF50
        v_xor_b32 TEMP16, K11, DB_EF51
        v_xor_b32 TEMP26, K31, DB_EF52
        v_xor_b32 TEMP19, K34, DB_EF53
        v_xor_b32 TEMP14, K48, DB_EF54
		v_xor_b32 TEMP06, K38, DB_EF55
        v_xor_b32 TEMP02, K19, DB_EF56
        v_xor_b32 TEMP07, K27, DB_EF57
        v_xor_b32 TEMP04, K32, DB_EF58
        v_xor_b32 TEMP03, K54, DB_EF59
        s_swappc_b64 s[82:83], s[90:91]

        v_xor_b32 TEMP25, K18, DB39
        v_xor_b32 TEMP18, K46, DB40
        v_xor_b32 TEMP10, K40, DB41
        v_xor_b32 TEMP16, K41, DB42
        v_xor_b32 TEMP02, K52, DB43
        v_xor_b32 TEMP04, K13, DB44
        v_xor_b32 TEMP03, K12, DB43
        v_xor_b32 TEMP06, K20, DB44
        v_xor_b32 TEMP19, K45, DB45
        v_xor_b32 TEMP26, K39, DB46
        v_xor_b32 TEMP22, K33, DB47
        v_xor_b32 TEMP07, K55, DB48
        s_swappc_b64 s[82:83], s[88:89]

        v_xor_b32 TEMP03, K29, DB_EF72
        v_xor_b32 TEMP18, K09, DB_EF73
        v_xor_b32 TEMP21, K42, DB_EF74
        v_xor_b32 TEMP22, K00, DB_EF75
        v_xor_b32 TEMP04, K44, DB_EF76
        v_xor_b32 TEMP07, K17, DB_EF77
        v_xor_b32 TEMP23, K49, DB_EF78
        v_xor_b32 TEMP06, K36, DB_EF79
        v_xor_b32 TEMP10, K16, DB_EF80
        v_xor_b32 TEMP19, K01, DB_EF81
        v_xor_b32 TEMP02, K28, DB_EF82
        v_xor_b32 TEMP25, K37, DB_EF83
        s_swappc_b64 s[82:83], s[86:87]

        v_xor_b32 TEMP06, K08, DB55
        v_xor_b32 TEMP18, K30, DB56
        v_xor_b32 TEMP27, K43, DB57
        v_xor_b32 TEMP00, K10, DB58
        v_xor_b32 TEMP12, K21, DB59
        v_xor_b32 TEMP07, K02, DB60
        v_xor_b32 TEMP03, K51, DB59
        v_xor_b32 TEMP01, K22, DB60
        v_xor_b32 TEMP14, K23, DB61
        v_xor_b32 TEMP13, K07, DB62
        v_xor_b32 TEMP02, K03, DB63
        v_xor_b32 TEMP04, K35, DB32
        s_swappc_b64 s[82:83], s[84:85]

		/********/
		/* A 15 */
		/********/

        v_xor_b32 TEMP15, K19, DB_EF00
        v_xor_b32 TEMP16, K53, DB_EF01
        v_xor_b32 TEMP17, K40, DB_EF02
        v_xor_b32 TEMP18, K04, DB_EF03
        v_xor_b32 TEMP19, K55, DB_EF04
        v_xor_b32 TEMP20, K27, DB_EF05
        v_xor_b32 TEMP21, K41, DB_EF06
        v_xor_b32 TEMP22, K31, DB_EF07
        v_xor_b32 TEMP23, K12, DB_EF08
        v_xor_b32 TEMP24, K20, DB_EF09
        v_xor_b32 TEMP25, K25, DB_EF10
        v_xor_b32 TEMP26, K47, DB_EF11
        s_swappc_b64 s[82:83], s[98:99]

        v_xor_b32 TEMP26, K11, DB07
        v_xor_b32 TEMP20, K39, DB08
        v_xor_b32 TEMP18, K33, DB09
        v_xor_b32 TEMP14, K34, DB10
        v_xor_b32 TEMP16, K45, DB11
        v_xor_b32 TEMP25, K06, DB12
        v_xor_b32 TEMP19, K05, DB11
        v_xor_b32 TEMP22, K13, DB12
        v_xor_b32 TEMP13, K38, DB13
        v_xor_b32 TEMP23, K32, DB14
        v_xor_b32 TEMP24, K26, DB15
        v_xor_b32 TEMP12, K48, DB16
        s_swappc_b64 s[82:83], s[96:97]

        v_xor_b32 TEMP16, K22, DB_EF24
        v_xor_b32 TEMP09, K02, DB_EF25
        v_xor_b32 TEMP18, K35, DB_EF26
        v_xor_b32 TEMP21, K50, DB_EF27
        v_xor_b32 TEMP22, K37, DB_EF28
        v_xor_b32 TEMP23, K10, DB_EF29
        v_xor_b32 TEMP11, K42, DB_EF30
        v_xor_b32 TEMP14, K29, DB_EF31
        v_xor_b32 TEMP10, K09, DB_EF32
        v_xor_b32 TEMP24, K51, DB_EF33
        v_xor_b32 TEMP20, K21, DB_EF34
        v_xor_b32 TEMP25, K30, DB_EF35
        s_swappc_b64 s[82:83], s[94:95]

        v_xor_b32 TEMP16, K01, DB23
        v_xor_b32 TEMP18, K23, DB24
        v_xor_b32 TEMP21, K36, DB25
        v_xor_b32 TEMP24, K03, DB26
        v_xor_b32 TEMP26, K14, DB27
        v_xor_b32 TEMP23, K24, DB28
        v_xor_b32 TEMP19, K44, DB27
        v_xor_b32 TEMP12, K15, DB28
        v_xor_b32 TEMP25, K16, DB29
        v_xor_b32 TEMP22, K00, DB30
        v_xor_b32 TEMP11, K49, DB31
        v_xor_b32 TEMP20, K28, DB00
        s_swappc_b64 s[82:83], s[92:93]

        s_add_u32 s50, -1, s50
		s_branch  .startLoop

.quitLoop:



		/************/
		/* MATCHING */
		/************/
        buffer_store_dword v23, v0, s[16:19], s13 offset:252
        buffer_store_dword v24, v0, s[16:19], s13 offset:248
        buffer_store_dword v25, v0, s[16:19], s13 offset:244
        buffer_store_dword v26, v0, s[16:19], s13 offset:240
        buffer_store_dword v27, v0, s[16:19], s13 offset:236
        buffer_store_dword v28, v0, s[16:19], s13 offset:232
        buffer_store_dword v29, v0, s[16:19], s13 offset:228
        buffer_store_dword v30, v0, s[16:19], s13 offset:224
        buffer_store_dword v32, v0, s[16:19], s13 offset:216
        buffer_store_dword v33, v0, s[16:19], s13 offset:212
        buffer_store_dword v34, v0, s[16:19], s13 offset:208
        buffer_store_dword v35, v0, s[16:19], s13 offset:204
        buffer_store_dword v36, v0, s[16:19], s13 offset:200
        buffer_store_dword v37, v0, s[16:19], s13 offset:196
        buffer_store_dword v38, v0, s[16:19], s13 offset:192
        buffer_store_dword v40, v0, s[16:19], s13 offset:184
        buffer_store_dword v41, v0, s[16:19], s13 offset:180
        buffer_store_dword v42, v0, s[16:19], s13 offset:176
        buffer_store_dword v43, v0, s[16:19], s13 offset:172
        buffer_store_dword v44, v0, s[16:19], s13 offset:168
        buffer_store_dword v45, v0, s[16:19], s13 offset:164
        buffer_store_dword v46, v0, s[16:19], s13 offset:160
        buffer_store_dword v48, v0, s[16:19], s13 offset:152
        buffer_store_dword v49, v0, s[16:19], s13 offset:148
        buffer_store_dword v50, v0, s[16:19], s13 offset:144
        buffer_store_dword v51, v0, s[16:19], s13 offset:140
        buffer_store_dword v52, v0, s[16:19], s13 offset:136
        buffer_store_dword v53, v0, s[16:19], s13 offset:132
        buffer_store_dword v54, v0, s[16:19], s13 offset:128
        s_cmp_eq_i32    s0, 0
        s_cbranch_scc0  .L15732_0



		/********************************/
		/* SEARCH_MODE_FORWARD_MATCHING */
		/********************************/

		buffer_load_dword v0, v0, s[16:19], s13 offset:208
        buffer_load_dword v3, v0, s[16:19], s13 offset:172
        buffer_load_dword v5, v0, s[16:19], s13 offset:176
        buffer_load_dword v6, v0, s[16:19], s13 offset:180
        buffer_load_dword v7, v0, s[16:19], s13 offset:184
        buffer_load_dword v8, v0, s[16:19], s13 offset:140
        buffer_load_dword v9, v0, s[16:19], s13 offset:144
        buffer_load_dword v10, v0, s[16:19], s13 offset:148
        buffer_load_dword v11, v0, s[16:19], s13 offset:152
        buffer_load_dword v12, v0, s[16:19], s13 offset:240
        buffer_load_dword v13, v0, s[16:19], s13 offset:244
        buffer_load_dword v14, v0, s[16:19], s13 offset:248
        buffer_load_dword v15, v0, s[16:19], s13 offset:252
        buffer_load_dword v16, v0, s[16:19], s13 offset:212
        buffer_load_dword v17, v0, s[16:19], s13 offset:216
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[24:27], s[2:3], 0x78
        s_load_dwordx4  s[28:31], s[2:3], 0x68
        s_waitcnt       lgkmcnt(0)
        s_bfe_u32       s33, s29, 0x100000
        s_mov_b32       s32, s28
        s_add_u32       s32, s32, s4
        s_addc_u32      s33, s33, s5
        s_load_dword    s12, s[32:33], 0x0
        s_mov_b64       s[32:33], exec
        s_mov_b64       s[34:35], exec
        v_mov_b32       v39, 0
        v_mov_b32       v18, v4
.L14576_0:
        v_cmp_lt_i32    vcc, 31, v39
        s_and_saveexec_b64 s[36:37], vcc
        v_mov_b32       v18, 0
        s_cbranch_execz .L14600_0
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L15700_0
.L14600_0:
        s_and_b64       exec, s[36:37], s[34:35]
        v_lshl_b32      v18, 1, v39
        s_waitcnt       vmcnt(2)
        v_and_b32       v19, v15, v18
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x20000000
        v_cndmask_b32   v19, 0, v19, vcc
        v_and_b32       v20, v55, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x10000000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v11, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x8000000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v62, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x4000000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v7, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x2000000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v69, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x1000000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        s_waitcnt       vmcnt(0)
        v_and_b32       v20, v17, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x800000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v79, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x400000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v14, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x200000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v56, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x100000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v10, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x80000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v63, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x40000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_lshrrev_b32   v20, 18, v19
        v_add_i32       v20, vcc, s6, v20
        v_mov_b32       v21, s7
        v_addc_u32      v21, vcc, v21, 0, vcc
        buffer_load_ubyte v20, v[20:21], s[8:11], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_lg_i32    vcc, 0, v20
        s_mov_b64       s[36:37], exec
        s_andn2_b64     exec, s[36:37], vcc
        v_and_b32       v20, v6, v18
        s_cbranch_execz .L15672_0
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x20000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v70, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x10000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v16, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x8000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v77, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x4000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v13, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x2000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v57, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x1000
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v9, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x800
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v66, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x400
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v5, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x200
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v72, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x100
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v0, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x80
        v_cndmask_b32   v20, 0, v20, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v78, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_cndmask_b32   v20, 0, 64, vcc
        v_or_b32        v19, v19, v20
        v_lshrrev_b32   v20, 6, v19
        v_add_i32       v20, vcc, s14, v20
        v_mov_b32       v21, s15
        v_addc_u32      v21, vcc, v21, 0, vcc
        buffer_load_ubyte v20, v[20:21], s[24:27], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v20
        s_and_saveexec_b64 s[38:39], vcc
        v_and_b32       v20, v12, v18
        s_cbranch_execz .L15652_0
        v_cmp_lg_i32    vcc, 0, v20
        v_cndmask_b32   v20, 0, 32, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v119, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_cndmask_b32   v20, 0, 16, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v8, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_cndmask_b32   v20, 0, 8, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v64, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_cndmask_b32   v20, 0, 4, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v20, v3, v18
        v_cmp_lg_i32    vcc, 0, v20
        v_cndmask_b32   v20, 0, 2, vcc
        v_or_b32        v19, v19, v20
        v_and_b32       v18, v71, v18
        v_cmp_lg_i32    vcc, 0, v18
        v_cndmask_b32   v18, 0, 1, vcc
        v_or_b32        v18, v19, v18
        s_mov_b64       s[40:41], exec
        s_mov_b64       s[42:43], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v25, s12
        v_mov_b32       v20, 0
        v_mov_b32       v21, s1
        v_mov_b32       v26, 0
.L15424_0:
        v_add_i32       v23, vcc, -1, v21
        s_mov_b64       s[44:45], exec
        s_mov_b64       s[46:47], exec
        v_mov_b32       v24, v26
.L15440_0:
        v_cmp_gt_i32    vcc, v26, v23
        v_cmp_eq_i32    s[48:49], v18, v25
        s_or_b64        vcc, vcc, s[48:49]
        s_and_saveexec_b64 s[50:51], vcc
        v_cndmask_b32   v25, 0, -1, s[48:49]
        s_cbranch_execz .L15488_0
        v_mov_b32       v20, 1
        v_mov_b32       v26, v24
        s_andn2_b64     s[46:47], s[46:47], exec
        s_cbranch_scc0  .L15588_0
.L15488_0:
        s_and_b64       exec, s[50:51], s[46:47]
        v_add_i32       v19, vcc, v23, v26
        v_ashrrev_i32   v21, 1, v19
        v_ashrrev_i32   v22, 31, v21
        v_lshl_b64      v[24:25], v[21:22], 2
        v_add_i32       v27, vcc, s4, v24
        v_mov_b32       v24, s5
        v_addc_u32      v28, vcc, v24, v25, vcc
        buffer_load_dword v25, v[27:28], s[28:31], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    s[48:49], v18, v25
        v_add_i32       v24, vcc, 1, v21
        s_mov_b64       s[50:51], exec
        s_andn2_b64     exec, s[50:51], s[48:49]
        s_andn2_b64     s[46:47], s[46:47], exec
        s_cbranch_scc0  .L15588_0
        s_and_b64       exec, s[50:51], s[46:47]
        v_mov_b32       TEMP21, v24
        v_mov_b32       v24, v26
        v_mov_b32       v26, TEMP21
        s_branch        .L15440_0
        v_mov_b32       v26, v24
.L15588_0:
        s_mov_b64       exec, s[44:45]
        v_cmp_lg_u32    vcc, 0, v20
        s_and_saveexec_b64 s[44:45], vcc
        s_andn2_b64     s[42:43], s[42:43], exec
        s_cbranch_scc0  .L15616_0
        s_and_b64       exec, s[44:45], s[42:43]
        s_branch        .L15424_0
.L15616_0:
        s_mov_b64       exec, s[40:41]
        v_cmp_lg_u32    vcc, 0, v25
        s_and_saveexec_b64 s[40:41], vcc
        v_mov_b32       v18, 1
        s_cbranch_execz .L15644_0
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L15700_0
.L15644_0:
        s_and_b64       exec, s[40:41], s[34:35]
        v_mov_b32       v18, 1
.L15652_0:
        s_andn2_b64     exec, s[38:39], exec
        s_and_b64       exec, exec, s[34:35]
        v_mov_b32       v18, 0
        s_cbranch_execz .L15668_0
.L15668_0:
        s_and_b64       exec, s[38:39], s[34:35]
.L15672_0:
        s_andn2_b64     exec, s[36:37], exec
        s_and_b64       exec, exec, s[34:35]
        v_mov_b32       v18, 0
        s_cbranch_execz .L15688_0
.L15688_0:
        s_and_b64       exec, s[36:37], s[34:35]
        v_add_i32       v39, vcc, 1, v39
        s_branch        .L14576_0
.L15700_0:
        s_mov_b64       exec, s[32:33]
        v_cmp_eq_i32    vcc, 0, v18
        s_waitcnt       vmcnt(13)
        v_cndmask_b32   v3, 0, 1, vcc
        s_waitcnt       vmcnt(0)
        v_mov_b32       v17, 2
        s_branch        .L20616_0
.L15732_0:
        s_cmp_eq_i32    s0, 3
        s_cbranch_scc0  .L19264_0



		/************************/
		/* SEARCH_MODE_FLEXIBLE */
		/************************/

        buffer_load_dword v0, v0, s[16:19], s13 offset:128
        buffer_load_dword v3, v0, s[16:19], s13 offset:160
        buffer_load_dword v5, v0, s[16:19], s13 offset:192
        s_add_u32       s8, -1, s1
        buffer_load_dword v6, v0, s[16:19], s13 offset:224
        buffer_load_dword v7, v0, s[16:19], s13 offset:228
        buffer_load_dword v8, v0, s[16:19], s13 offset:232
        buffer_load_dword v9, v0, s[16:19], s13 offset:236
        buffer_load_dword v10, v0, s[16:19], s13 offset:196
        buffer_load_dword v11, v0, s[16:19], s13 offset:200
        buffer_load_dword v12, v0, s[16:19], s13 offset:164
        buffer_load_dword v13, v0, s[16:19], s13 offset:168
        buffer_load_dword v14, v0, s[16:19], s13 offset:132
        buffer_load_dword v15, v0, s[16:19], s13 offset:136
        buffer_load_dword v16, v0, s[16:19], s13 offset:204
        buffer_load_dword v17, v0, s[16:19], s13 offset:208
        buffer_load_dword v18, v0, s[16:19], s13 offset:212
        buffer_load_dword v19, v0, s[16:19], s13 offset:216
        buffer_load_dword v20, v0, s[16:19], s13 offset:172
        buffer_load_dword v21, v0, s[16:19], s13 offset:176
        buffer_load_dword v22, v0, s[16:19], s13 offset:180
        buffer_load_dword v23, v0, s[16:19], s13 offset:184
        buffer_load_dword v24, v0, s[16:19], s13 offset:140
        buffer_load_dword v25, v0, s[16:19], s13 offset:144
        buffer_load_dword v26, v0, s[16:19], s13 offset:148
        buffer_load_dword v27, v0, s[16:19], s13 offset:152
        buffer_load_dword v28, v0, s[16:19], s13 offset:240
        buffer_load_dword v29, v0, s[16:19], s13 offset:244
        buffer_load_dword v30, v0, s[16:19], s13 offset:248
        buffer_load_dword v31, v0, s[16:19], s13 offset:252
        s_load_dwordx4  s[24:27], s[2:3], 0x70
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x68
        s_waitcnt       lgkmcnt(0)
        s_bfe_u32       s11, s33, 0x100000
        s_mov_b32       s10, s32
        s_add_u32       s10, s10, s4
        s_addc_u32      s11, s11, s5
        s_load_dword    s9, s[10:11], 0x0
        s_mov_b64       s[10:11], exec
        s_mov_b64       s[36:37], exec
        v_mov_b32       v39, 0
        v_mov_b32       v32, v4
        v_mov_b32       v48, 0
        v_mov_b32       v49, 0
        v_mov_b32       v35, 0
        v_mov_b32       v36, 0
        v_mov_b32       v37, 0
        v_mov_b32       v38, 0
        v_mov_b32       v40, 0
.L16060_0:
        v_add_f32       v41, v38, v40
        v_add_f32       v41, v37, v41
        v_add_f32       v41, v36, v41
        v_add_f32       v41, v35, v41
        v_add_f32       v41, v49, v41
        v_add_f32       v41, v48, v41
        v_cmp_eq_u32    vcc, 0, v41
        s_and_saveexec_b64 s[38:39], vcc
        s_andn2_b64     exec, s[38:39], exec
        s_cbranch_execz .L16108_0
        s_andn2_b64     s[36:37], s[36:37], exec
        s_cbranch_scc0  .L19240_0
.L16108_0:
        s_and_b64       exec, s[38:39], s[36:37]
        v_cmp_ge_i32    vcc, 31, v39
        v_cndmask_b32   v48, 1.0, v48, vcc
        v_cmp_eq_u32    vcc, 0, v48
        s_and_saveexec_b64 s[38:39], vcc
        v_lshl_b32      v33, 1, v39
        s_cbranch_execz .L19220_0
        s_waitcnt       vmcnt(0)
        v_and_b32       v34, v31, v33
        v_and_b32       v41, v55, v33
        v_cmp_lg_i32    s[40:41], v34, 0
        v_mov_b32       v34, 0x20000000
        v_cmp_lg_i32    vcc, 0, v41
        v_mov_b32       v41, 0x10000000
        v_and_b32       v42, v27, v33
        v_cndmask_b32   v34, 0, v34, s[40:41]
        v_cndmask_b32   v41, 0, v41, vcc
        v_cmp_lg_i32    vcc, 0, v42
        v_mov_b32       v42, 0x8000000
        v_and_b32       v43, v62, v33
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v42, 0x4000000
        v_and_b32       v43, v23, v33
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v42, 0x2000000
        v_and_b32       v43, v69, v33
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v42, 0x1000000
        v_and_b32       v43, v19, v33
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v42, 0x800000
        v_and_b32       v43, v79, v33
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v42, 0x400000
        v_and_b32       v43, v30, v33
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v42, 0x200000
        v_and_b32       v43, v56, v33
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v42, 0x100000
        v_and_b32       v43, v26, v33
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v42, 0x80000
        v_and_b32       v43, v63, v33
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v42, 0x40000
        v_or_b32        v34, v34, v41
        v_cndmask_b32   v41, 0, v42, vcc
        v_or_b32        v34, v34, v41
        v_lshrrev_b32   v41, 18, v34
        v_add_i32       v41, vcc, s6, v41
        v_mov_b32       v42, s7
        v_addc_u32      v42, vcc, v42, 0, vcc
        buffer_load_ubyte v41, v[41:42], s[24:27], 0 addr64
        v_and_b32       v42, v22, v33
        v_cmp_lg_i32    vcc, 0, v42
        v_mov_b32       v42, 0x20000
        v_and_b32       v43, v70, v33
        v_cndmask_b32   v42, 0, v42, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_mov_b32       v43, 0x10000
        v_and_b32       v44, v18, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_mov_b32       v43, 0x8000
        v_and_b32       v44, v77, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_mov_b32       v43, 0x4000
        v_and_b32       v44, v29, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_mov_b32       v43, 0x2000
        v_and_b32       v44, v57, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_mov_b32       v43, 0x1000
        v_and_b32       v44, v25, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_mov_b32       v43, 0x800
        v_and_b32       v44, v66, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_mov_b32       v43, 0x400
        v_and_b32       v44, v21, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_mov_b32       v43, 0x200
        v_and_b32       v44, v72, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_mov_b32       v43, 0x100
        v_and_b32       v44, v17, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_mov_b32       v43, 0x80
        v_and_b32       v44, v78, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, v43, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v43, v28, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, 64, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_and_b32       v43, v119, v33
        v_or_b32        v34, v34, v42
        v_cndmask_b32   v42, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_and_b32       v43, v24, v33
        v_or_b32        v42, v34, v42
        v_cndmask_b32   v44, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_and_b32       v43, v64, v33
        v_or_b32        v42, v42, v44
        v_cndmask_b32   v44, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_and_b32       v43, v20, v33
        v_or_b32        v42, v42, v44
        v_cndmask_b32   v44, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_and_b32       v43, v71, v33
        v_or_b32        v42, v42, v44
        v_cndmask_b32   v44, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v43
        v_or_b32        v42, v42, v44
        v_cndmask_b32   v43, 0, 1, vcc
        v_or_b32        v42, v42, v43
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v41
        s_and_saveexec_b64 s[40:41], vcc
        v_lshrrev_b32   v34, 6, v34
        s_cbranch_execz .L17180_0
        v_add_i32       v43, vcc, s14, v34
        v_mov_b32       v41, s15
        v_addc_u32      v44, vcc, v41, 0, vcc
        buffer_load_ubyte v34, v[43:44], s[28:31], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v34
        s_and_saveexec_b64 s[42:43], vcc
        s_cbranch_execz .L17168_0
        s_mov_b64       s[44:45], exec
        s_mov_b64       s[46:47], exec
        v_mov_b32       v34, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v4, s9
        v_mov_b32       v50, s1
        v_mov_b32       v44, 0
.L16952_0:
        v_add_i32       v45, vcc, -1, v50
        s_mov_b64       s[48:49], exec
        s_mov_b64       s[50:51], exec
        v_mov_b32       v46, v44
        s_nop           0x0
        s_nop           0x0
.L16976_0:
        v_cmp_gt_i32    vcc, v44, v45
        v_cmp_eq_i32    s[52:53], v42, v4
        s_or_b64        vcc, vcc, s[52:53]
        s_and_saveexec_b64 s[54:55], vcc
        v_cndmask_b32   v4, 0, -1, s[52:53]
        s_cbranch_execz .L17024_0
        v_mov_b32       v34, 1
        v_mov_b32       v44, v46
        s_andn2_b64     s[50:51], s[50:51], exec
        s_cbranch_scc0  .L17124_0
.L17024_0:
        s_and_b64       exec, s[54:55], s[50:51]
        v_add_i32       v41, vcc, v45, v44
        v_ashrrev_i32   v50, 1, v41
        v_ashrrev_i32   v51, 31, v50
        v_lshl_b64      v[46:47], v[50:51], 2
        v_add_i32       v51, vcc, s4, v46
        v_mov_b32       v46, s5
        v_addc_u32      v52, vcc, v46, v47, vcc
        buffer_load_dword v4, v[51:52], s[32:35], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    s[52:53], v42, v4
        v_add_i32       v46, vcc, 1, v50
        s_mov_b64       s[54:55], exec
        s_andn2_b64     exec, s[54:55], s[52:53]
        s_andn2_b64     s[50:51], s[50:51], exec
        s_cbranch_scc0  .L17124_0
        s_and_b64       exec, s[54:55], s[50:51]
        v_mov_b32       TEMP21, v46
        v_mov_b32       v46, v44
        v_mov_b32       v44, TEMP21
        s_branch        .L16976_0
        v_mov_b32       v44, v46
.L17124_0:
        s_mov_b64       exec, s[48:49]
        v_cmp_lg_u32    vcc, 0, v34
        s_and_saveexec_b64 s[48:49], vcc
        s_andn2_b64     s[46:47], s[46:47], exec
        s_cbranch_scc0  .L17152_0
        s_and_b64       exec, s[48:49], s[46:47]
        s_branch        .L16952_0
.L17152_0:
        s_mov_b64       exec, s[44:45]
        v_cmp_eq_u32    vcc, 0, v4
        v_cndmask_b32   v49, 1.0, v49, vcc
        v_mov_b32       v4, 1
.L17168_0:
        s_andn2_b64     exec, s[42:43], exec
        v_mov_b32       v4, 0
        s_mov_b64       exec, s[42:43]
.L17180_0:
        s_andn2_b64     exec, s[40:41], exec
        v_mov_b32       v4, 0
        s_mov_b64       exec, s[40:41]
        v_cmp_eq_u32    vcc, 0, v49
        s_and_b64       exec, s[40:41], vcc
        v_lshlrev_b32   v41, 6, v42
        s_cbranch_execz .L19216_0
        v_and_b32       v41, 0x3fffffc0, v41
        v_lshrrev_b32   v43, 18, v41
        v_add_i32       v43, vcc, s6, v43
        v_mov_b32       v44, s7
        v_addc_u32      v44, vcc, v44, 0, vcc
        buffer_load_ubyte v43, v[43:44], s[24:27], 0 addr64
        v_and_b32       v44, v16, v33
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v80, v33
        v_cndmask_b32   v45, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v9, v33
        v_or_b32        v41, v45, v41
        v_cndmask_b32   v45, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v59, v33
        v_or_b32        v41, v41, v45
        v_cndmask_b32   v45, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v15, v33
        v_or_b32        v41, v41, v45
        v_cndmask_b32   v45, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v58, v33
        v_or_b32        v41, v41, v45
        v_cndmask_b32   v45, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_or_b32        v41, v41, v45
        v_cndmask_b32   v44, 0, 1, vcc
        v_or_b32        v41, v41, v44
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v43
        s_and_saveexec_b64 s[42:43], vcc
        v_bfe_u32       v42, v42, 0, 24
        s_cbranch_execz .L17596_0
        v_add_i32       v42, vcc, s14, v42
        v_mov_b32       v43, s15
        v_addc_u32      v43, vcc, v43, 0, vcc
        buffer_load_ubyte v42, v[42:43], s[28:31], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v42
        s_and_saveexec_b64 s[44:45], vcc
        s_cbranch_execz .L17596_0
        s_mov_b64       s[46:47], exec
        s_mov_b64       s[48:49], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v4, s9
        v_mov_b32       v42, 0
        v_mov_b32       v43, s8
        s_movk_i32      s50, 0x0
        s_movk_i32      s51, 0x0
.L17460_0:
        v_cmp_gt_i32    s[52:53], v42, v43
        v_cmp_eq_i32    vcc, v41, v4
        s_andn2_b64     s[50:51], s[50:51], exec
        s_or_b64        s[50:51], vcc, s[50:51]
        s_or_b64        vcc, s[52:53], vcc
        s_and_saveexec_b64 s[52:53], vcc
        s_andn2_b64     s[48:49], s[48:49], exec
        s_cbranch_scc0  .L17580_0
        s_and_b64       exec, s[52:53], s[48:49]
        v_add_i32       v34, vcc, v42, v43
        v_ashrrev_i32   v50, 1, v34
        v_ashrrev_i32   v51, 31, v50
        v_lshl_b64      v[44:45], v[50:51], 2
        v_add_i32       v44, vcc, s4, v44
        v_mov_b32       v46, s5
        v_addc_u32      v45, vcc, v46, v45, vcc
        buffer_load_dword v4, v[44:45], s[32:35], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    s[52:53], v4, v41
        v_add_i32       v45, vcc, -1, v50
        v_add_i32       v34, vcc, 1, v50
        v_cndmask_b32   v43, v43, v45, s[52:53]
        v_cndmask_b32   v42, v34, v42, s[52:53]
        s_branch        .L17460_0
.L17580_0:
        s_mov_b64       exec, s[46:47]
        v_cndmask_b32   v35, v35, 1.0, s[50:51]
        v_mov_b32       v4, 1
.L17596_0:
        s_mov_b64       exec, s[42:43]
        v_cmp_eq_u32    vcc, 0, v35
        s_and_b64       exec, s[42:43], vcc
        v_lshlrev_b32   v42, 6, v41
        s_cbranch_execz .L19216_0
        v_and_b32       v42, 0x3fffffc0, v42
        v_lshrrev_b32   v43, 18, v42
        v_add_i32       v43, vcc, s6, v43
        v_mov_b32       v44, s7
        v_addc_u32      v44, vcc, v44, 0, vcc
        buffer_load_ubyte v43, v[43:44], s[24:27], 0 addr64
        v_and_b32       v44, v13, v33
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v73, v33
        v_cndmask_b32   v45, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v11, v33
        v_or_b32        v42, v45, v42
        v_cndmask_b32   v45, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v81, v33
        v_or_b32        v42, v42, v45
        v_cndmask_b32   v45, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v8, v33
        v_or_b32        v42, v42, v45
        v_cndmask_b32   v45, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v84, v33
        v_or_b32        v42, v42, v45
        v_cndmask_b32   v45, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_or_b32        v42, v42, v45
        v_cndmask_b32   v44, 0, 1, vcc
        v_or_b32        v42, v42, v44
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v43
        s_and_saveexec_b64 s[44:45], vcc
        v_bfe_u32       v41, v41, 0, 24
        s_cbranch_execz .L18016_0
        v_add_i32       v44, vcc, s14, v41
        v_mov_b32       v43, s15
        v_addc_u32      v45, vcc, v43, 0, vcc
        buffer_load_ubyte v41, v[44:45], s[28:31], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v41
        s_and_saveexec_b64 s[46:47], vcc
        s_cbranch_execz .L18016_0
        s_mov_b64       s[48:49], exec
        s_mov_b64       s[50:51], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v4, s9
        v_mov_b32       v41, 0
        v_mov_b32       v43, s8
        s_movk_i32      s52, 0x0
        s_movk_i32      s53, 0x0
        s_nop           0x0
        s_nop           0x0
        s_nop           0x0
.L17880_0:
        v_cmp_gt_i32    s[54:55], v41, v43
        v_cmp_eq_i32    vcc, v42, v4
        s_andn2_b64     s[52:53], s[52:53], exec
        s_or_b64        s[52:53], vcc, s[52:53]
        s_or_b64        vcc, s[54:55], vcc
        s_and_saveexec_b64 s[54:55], vcc
        s_andn2_b64     s[50:51], s[50:51], exec
        s_cbranch_scc0  .L18000_0
        s_and_b64       exec, s[54:55], s[50:51]
        v_add_i32       v34, vcc, v41, v43
        v_ashrrev_i32   v50, 1, v34
        v_ashrrev_i32   v51, 31, v50
        v_lshl_b64      v[44:45], v[50:51], 2
        v_add_i32       v44, vcc, s4, v44
        v_mov_b32       v46, s5
        v_addc_u32      v45, vcc, v46, v45, vcc
        buffer_load_dword v4, v[44:45], s[32:35], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    s[54:55], v4, v42
        v_add_i32       v45, vcc, -1, v50
        v_add_i32       v34, vcc, 1, v50
        v_cndmask_b32   v43, v43, v45, s[54:55]
        v_cndmask_b32   v41, v34, v41, s[54:55]
        s_branch        .L17880_0
.L18000_0:
        s_mov_b64       exec, s[48:49]
        v_cndmask_b32   v36, v36, 1.0, s[52:53]
        v_mov_b32       v4, 1
.L18016_0:
        s_mov_b64       exec, s[44:45]
        v_cmp_eq_u32    vcc, 0, v36
        s_and_b64       exec, s[44:45], vcc
        v_lshlrev_b32   v41, 6, v42
        s_cbranch_execz .L19216_0
        v_and_b32       v41, 0x3fffffc0, v41
        v_lshrrev_b32   v43, 18, v41
        v_add_i32       v43, vcc, s6, v43
        v_mov_b32       v44, s7
        v_addc_u32      v44, vcc, v44, 0, vcc
        buffer_load_ubyte v43, v[43:44], s[24:27], 0 addr64
        v_and_b32       v44, v14, v33
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v67, v33
        v_cndmask_b32   v45, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v12, v33
        v_or_b32        v41, v45, v41
        v_cndmask_b32   v45, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v122, v33
        v_or_b32        v41, v41, v45
        v_cndmask_b32   v45, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v10, v33
        v_or_b32        v41, v41, v45
        v_cndmask_b32   v45, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v74, v33
        v_or_b32        v41, v41, v45
        v_cndmask_b32   v45, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_or_b32        v41, v41, v45
        v_cndmask_b32   v44, 0, 1, vcc
        v_or_b32        v41, v41, v44
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v43
        s_and_saveexec_b64 s[46:47], vcc
        v_bfe_u32       v42, v42, 0, 24
        s_cbranch_execz .L18424_0
        v_add_i32       v42, vcc, s14, v42
        v_mov_b32       v43, s15
        v_addc_u32      v43, vcc, v43, 0, vcc
        buffer_load_ubyte v42, v[42:43], s[28:31], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v42
        s_and_saveexec_b64 s[48:49], vcc
        s_cbranch_execz .L18424_0
        s_mov_b64       s[50:51], exec
        s_mov_b64       s[52:53], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v4, s9
        v_mov_b32       v42, 0
        v_mov_b32       v43, s8
        s_movk_i32      s54, 0x0
        s_movk_i32      s55, 0x0
.L18288_0:
        v_cmp_gt_i32    s[56:57], v42, v43
        v_cmp_eq_i32    vcc, v41, v4
        s_andn2_b64     s[54:55], s[54:55], exec
        s_or_b64        s[54:55], vcc, s[54:55]
        s_or_b64        vcc, s[56:57], vcc
        s_and_saveexec_b64 s[56:57], vcc
        s_andn2_b64     s[52:53], s[52:53], exec
        s_cbranch_scc0  .L18408_0
        s_and_b64       exec, s[56:57], s[52:53]
        v_add_i32       v34, vcc, v42, v43
        v_ashrrev_i32   v50, 1, v34
        v_ashrrev_i32   v51, 31, v50
        v_lshl_b64      v[44:45], v[50:51], 2
        v_add_i32       v44, vcc, s4, v44
        v_mov_b32       v46, s5
        v_addc_u32      v45, vcc, v46, v45, vcc
        buffer_load_dword v4, v[44:45], s[32:35], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    s[56:57], v4, v41
        v_add_i32       v45, vcc, -1, v50
        v_add_i32       v34, vcc, 1, v50
        v_cndmask_b32   v43, v43, v45, s[56:57]
        v_cndmask_b32   v42, v34, v42, s[56:57]
        s_branch        .L18288_0
.L18408_0:
        s_mov_b64       exec, s[50:51]
        v_cndmask_b32   v37, v37, 1.0, s[54:55]
        v_mov_b32       v4, 1
.L18424_0:
        s_mov_b64       exec, s[46:47]
        v_cmp_eq_u32    vcc, 0, v37
        s_and_b64       exec, s[46:47], vcc
        v_lshlrev_b32   v42, 6, v41
        s_cbranch_execz .L19216_0
        v_and_b32       v42, 0x3fffffc0, v42
        v_lshrrev_b32   v43, 18, v42
        v_add_i32       v43, vcc, s6, v43
        v_mov_b32       v44, s7
        v_addc_u32      v44, vcc, v44, 0, vcc
        buffer_load_ubyte v43, v[43:44], s[24:27], 0 addr64
        v_and_b32       v44, v7, v33
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v86, v33
        v_cndmask_b32   v45, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v0, v33
        v_or_b32        v42, v45, v42
        v_cndmask_b32   v45, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v120, v33
        v_or_b32        v42, v42, v45
        v_cndmask_b32   v45, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v3, v33
        v_or_b32        v42, v42, v45
        v_cndmask_b32   v45, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_and_b32       v44, v121, v33
        v_or_b32        v42, v42, v45
        v_cndmask_b32   v45, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v44
        v_or_b32        v42, v42, v45
        v_cndmask_b32   v44, 0, 1, vcc
        v_or_b32        v42, v42, v44
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v43
        s_and_saveexec_b64 s[48:49], vcc
        v_bfe_u32       v41, v41, 0, 24
        s_cbranch_execz .L18832_0
        v_add_i32       v44, vcc, s14, v41
        v_mov_b32       v43, s15
        v_addc_u32      v45, vcc, v43, 0, vcc
        buffer_load_ubyte v41, v[44:45], s[28:31], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v41
        s_and_saveexec_b64 s[50:51], vcc
        s_cbranch_execz .L18832_0
        s_mov_b64       s[52:53], exec
        s_mov_b64       s[54:55], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v4, s9
        v_mov_b32       v41, 0
        v_mov_b32       v43, s8
        s_movk_i32      s56, 0x0
        s_movk_i32      s57, 0x0
.L18696_0:
        v_cmp_gt_i32    s[58:59], v41, v43
        v_cmp_eq_i32    vcc, v42, v4
        s_andn2_b64     s[56:57], s[56:57], exec
        s_or_b64        s[56:57], vcc, s[56:57]
        s_or_b64        vcc, s[58:59], vcc
        s_and_saveexec_b64 s[58:59], vcc
        s_andn2_b64     s[54:55], s[54:55], exec
        s_cbranch_scc0  .L18816_0
        s_and_b64       exec, s[58:59], s[54:55]
        v_add_i32       v34, vcc, v41, v43
        v_ashrrev_i32   v50, 1, v34
        v_ashrrev_i32   v51, 31, v50
        v_lshl_b64      v[44:45], v[50:51], 2
        v_add_i32       v44, vcc, s4, v44
        v_mov_b32       v46, s5
        v_addc_u32      v45, vcc, v46, v45, vcc
        buffer_load_dword v4, v[44:45], s[32:35], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    s[58:59], v4, v42
        v_add_i32       v45, vcc, -1, v50
        v_add_i32       v34, vcc, 1, v50
        v_cndmask_b32   v43, v43, v45, s[58:59]
        v_cndmask_b32   v41, v34, v41, s[58:59]
        s_branch        .L18696_0
.L18816_0:
        s_mov_b64       exec, s[52:53]
        v_cndmask_b32   v38, v38, 1.0, s[56:57]
        v_mov_b32       v4, 1
.L18832_0:
        s_mov_b64       exec, s[48:49]
        v_cmp_eq_u32    vcc, 0, v38
        s_and_b64       exec, s[48:49], vcc
        v_lshlrev_b32   v41, 6, v42
        s_cbranch_execz .L19216_0
        v_and_b32       v41, 0x3fffffc0, v41
        v_lshrrev_b32   v43, 18, v41
        v_add_i32       v43, vcc, s6, v43
        v_mov_b32       v44, s7
        v_addc_u32      v44, vcc, v44, 0, vcc
        buffer_load_ubyte v43, v[43:44], s[24:27], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v43
        s_and_saveexec_b64 s[50:51], vcc
        v_bfe_u32       v42, v42, 0, 24
        s_cbranch_execz .L19200_0
        v_add_i32       v42, vcc, s14, v42
        v_mov_b32       v43, s15
        v_addc_u32      v43, vcc, v43, 0, vcc
        buffer_load_ubyte v42, v[42:43], s[28:31], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v42
        s_and_saveexec_b64 s[52:53], vcc
        v_and_b32       v34, v5, v33
        s_cbranch_execz .L19200_0
        v_cmp_lg_i32    vcc, 0, v34
        v_cndmask_b32   v34, 0, 32, vcc
        v_or_b32        v34, v41, v34
        v_and_b32       v41, v68, v33
        v_cmp_lg_i32    vcc, 0, v41
        v_cndmask_b32   v41, 0, 16, vcc
        v_or_b32        v34, v34, v41
        v_and_b32       v41, v6, v33
        v_cmp_lg_i32    vcc, 0, v41
        v_cndmask_b32   v41, 0, 8, vcc
        v_or_b32        v34, v34, v41
        v_and_b32       v33, v76, v33
        v_cmp_lg_i32    vcc, 0, v33
        v_cndmask_b32   v33, 0, 4, vcc
        v_or_b32        v33, v34, v33
        s_mov_b64       s[54:55], exec
        s_mov_b64       s[56:57], exec
        v_mov_b32       v34, s8
        v_mov_b32       v41, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v4, s9
        s_movk_i32      s58, 0x0
        s_movk_i32      s59, 0x0
.L19064_0:
        v_cmp_gt_i32    s[60:61], v41, v34
        v_cmp_eq_i32    vcc, v33, v4
        s_andn2_b64     s[58:59], s[58:59], exec
        s_or_b64        s[58:59], vcc, s[58:59]
        s_or_b64        vcc, s[60:61], vcc
        s_and_saveexec_b64 s[60:61], vcc
        s_andn2_b64     s[56:57], s[56:57], exec
        s_cbranch_scc0  .L19184_0
        s_and_b64       exec, s[60:61], s[56:57]
        v_add_i32       v42, vcc, v34, v41
        v_ashrrev_i32   v42, 1, v42
        v_ashrrev_i32   v43, 31, v42
        v_lshl_b64      v[43:44], v[42:43], 2
        v_add_i32       v43, vcc, s4, v43
        v_mov_b32       v45, s5
        v_addc_u32      v44, vcc, v45, v44, vcc
        buffer_load_dword v4, v[43:44], s[32:35], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    s[60:61], v4, v33
        v_add_i32       v44, vcc, -1, v42
        v_add_i32       v42, vcc, 1, v42
        v_cndmask_b32   v41, v42, v41, s[60:61]
        v_cndmask_b32   v34, v34, v44, s[60:61]
        s_branch        .L19064_0
.L19184_0:
        s_mov_b64       exec, s[54:55]
        v_cndmask_b32   v40, v40, 1.0, s[58:59]
        v_mov_b32       v4, 1
.L19200_0:
        s_mov_b64       exec, s[50:51]
        v_cmp_eq_u32    vcc, 0, v40
        v_addc_u32      v39, vcc, v39, 0, vcc
.L19216_0:
        s_mov_b64       exec, s[40:41]
.L19220_0:
        s_andn2_b64     exec, s[38:39], exec
        v_mov_b32       v4, 0
        s_mov_b64       exec, s[38:39]
        v_mov_b32       v32, 2
        s_branch        .L16060_0
.L19240_0:
        s_mov_b64       exec, s[10:11]
        v_cmp_eq_i32    vcc, 0, v4
        v_cndmask_b32   v3, 0, v32, vcc
        s_waitcnt       vmcnt(14)
        v_mov_b32       v17, 2
        s_branch        .L20616_0
.L19264_0:
        s_cmp_eq_i32    s0, 2
        s_cbranch_scc1  .L19288_0



        v_mov_b32       v39, 0
        v_mov_b32       v17, 1
        v_mov_b32       v3, v4
        s_branch        .L20616_0
.L19288_0:
        buffer_load_dword v0, v0, s[16:19], s13 offset:208
        buffer_load_dword v3, v0, s[16:19], s13 offset:172
        buffer_load_dword v5, v0, s[16:19], s13 offset:176
        buffer_load_dword v6, v0, s[16:19], s13 offset:180
        buffer_load_dword v7, v0, s[16:19], s13 offset:184
        buffer_load_dword v8, v0, s[16:19], s13 offset:140
        buffer_load_dword v9, v0, s[16:19], s13 offset:144
        buffer_load_dword v10, v0, s[16:19], s13 offset:148
        buffer_load_dword v11, v0, s[16:19], s13 offset:152
        buffer_load_dword v12, v0, s[16:19], s13 offset:240
        buffer_load_dword v13, v0, s[16:19], s13 offset:244
        buffer_load_dword v14, v0, s[16:19], s13 offset:248
        buffer_load_dword v15, v0, s[16:19], s13 offset:252
        buffer_load_dword v16, v0, s[16:19], s13 offset:212
        buffer_load_dword v17, v0, s[16:19], s13 offset:216
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[24:27], s[2:3], 0x78
        s_load_dwordx4  s[28:31], s[2:3], 0x68
        s_waitcnt       lgkmcnt(0)
        s_bfe_u32       s33, s29, 0x100000
        s_mov_b32       s32, s28
        s_add_u32       s32, s32, s4
        s_addc_u32      s33, s33, s5
        s_load_dword    s12, s[32:33], 0x0
        s_mov_b64       s[32:33], exec
        s_mov_b64       s[34:35], exec
        v_mov_b32       v39, 0
        v_mov_b32       v19, v4
.L19464_0:
        v_cmp_lt_i32    vcc, 31, v39
        s_and_saveexec_b64 s[36:37], vcc
        v_mov_b32       v19, 0
        s_cbranch_execz .L19488_0
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L20588_0
.L19488_0:
        s_and_b64       exec, s[36:37], s[34:35]
        v_lshl_b32      v19, 1, v39
        s_waitcnt       vmcnt(2)
        v_and_b32       v20, v15, v19
        v_cmp_lg_i32    vcc, 0, v20
        v_mov_b32       v20, 0x20000000
        v_cndmask_b32   v20, 0, v20, vcc
        v_and_b32       v21, v55, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x10000000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v11, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x8000000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v62, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x4000000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v7, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x2000000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v69, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x1000000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        s_waitcnt       vmcnt(0)
        v_and_b32       v21, v17, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x800000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v79, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x400000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v14, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x200000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v56, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x100000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v10, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x80000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v63, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x40000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_lshrrev_b32   v21, 18, v20
        v_add_i32       v21, vcc, s6, v21
        v_mov_b32       v22, s7
        v_addc_u32      v22, vcc, v22, 0, vcc
        buffer_load_ubyte v21, v[21:22], s[8:11], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_lg_i32    vcc, 0, v21
        s_mov_b64       s[36:37], exec
        s_andn2_b64     exec, s[36:37], vcc
        v_and_b32       v21, v6, v19
        s_cbranch_execz .L20560_0
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x20000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v70, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x10000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v16, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x8000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v77, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x4000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v13, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x2000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v57, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x1000
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v9, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x800
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v66, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x400
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v5, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x200
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v72, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x100
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v0, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_mov_b32       v21, 0x80
        v_cndmask_b32   v21, 0, v21, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v78, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_cndmask_b32   v21, 0, 64, vcc
        v_or_b32        v20, v20, v21
        v_lshrrev_b32   v21, 6, v20
        v_add_i32       v21, vcc, s14, v21
        v_mov_b32       v22, s15
        v_addc_u32      v22, vcc, v22, 0, vcc
        buffer_load_ubyte v21, v[21:22], s[24:27], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v21
        s_and_saveexec_b64 s[38:39], vcc
        v_and_b32       v21, v12, v19
        s_cbranch_execz .L20540_0
        v_cmp_lg_i32    vcc, 0, v21
        v_cndmask_b32   v21, 0, 32, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v119, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_cndmask_b32   v21, 0, 16, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v8, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_cndmask_b32   v21, 0, 8, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v64, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_cndmask_b32   v21, 0, 4, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v21, v3, v19
        v_cmp_lg_i32    vcc, 0, v21
        v_cndmask_b32   v21, 0, 2, vcc
        v_or_b32        v20, v20, v21
        v_and_b32       v19, v71, v19
        v_cmp_lg_i32    vcc, 0, v19
        v_cndmask_b32   v19, 0, 1, vcc
        v_or_b32        v19, v20, v19
        s_mov_b64       s[40:41], exec
        s_mov_b64       s[42:43], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v26, s12
        v_mov_b32       v21, 0
        v_mov_b32       v22, s1
        v_mov_b32       v27, 0
.L20312_0:
        v_add_i32       v24, vcc, -1, v22
        s_mov_b64       s[44:45], exec
        s_mov_b64       s[46:47], exec
        v_mov_b32       v25, v27
.L20328_0:
        v_cmp_gt_i32    vcc, v27, v24
        v_cmp_eq_i32    s[48:49], v19, v26
        s_or_b64        vcc, vcc, s[48:49]
        s_and_saveexec_b64 s[50:51], vcc
        v_cndmask_b32   v26, 0, -1, s[48:49]
        s_cbranch_execz .L20376_0
        v_mov_b32       v21, 1
        v_mov_b32       v27, v25
        s_andn2_b64     s[46:47], s[46:47], exec
        s_cbranch_scc0  .L20476_0
.L20376_0:
        s_and_b64       exec, s[50:51], s[46:47]
        v_add_i32       v20, vcc, v24, v27
        v_ashrrev_i32   v22, 1, v20
        v_ashrrev_i32   v23, 31, v22
        v_lshl_b64      v[25:26], v[22:23], 2
        v_add_i32       v28, vcc, s4, v25
        v_mov_b32       v25, s5
        v_addc_u32      v29, vcc, v25, v26, vcc
        buffer_load_dword v26, v[28:29], s[28:31], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    s[48:49], v19, v26
        v_add_i32       v25, vcc, 1, v22
        s_mov_b64       s[50:51], exec
        s_andn2_b64     exec, s[50:51], s[48:49]
        s_andn2_b64     s[46:47], s[46:47], exec
        s_cbranch_scc0  .L20476_0
        s_and_b64       exec, s[50:51], s[46:47]
        v_mov_b32       TEMP21, v25
        v_mov_b32       v25, v27
        v_mov_b32       v27, TEMP21
        s_branch        .L20328_0
        v_mov_b32       v27, v25
.L20476_0:
        s_mov_b64       exec, s[44:45]
        v_cmp_lg_u32    vcc, 0, v21
        s_and_saveexec_b64 s[44:45], vcc
        s_andn2_b64     s[42:43], s[42:43], exec
        s_cbranch_scc0  .L20504_0
        s_and_b64       exec, s[44:45], s[42:43]
        s_branch        .L20312_0
.L20504_0:
        s_mov_b64       exec, s[40:41]
        v_cmp_lg_u32    vcc, 0, v26
        s_and_saveexec_b64 s[40:41], vcc
        v_mov_b32       v19, 1
        s_cbranch_execz .L20532_0
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L20588_0
.L20532_0:
        s_and_b64       exec, s[40:41], s[34:35]
        v_mov_b32       v19, 1
.L20540_0:
        s_andn2_b64     exec, s[38:39], exec
        s_and_b64       exec, exec, s[34:35]
        v_mov_b32       v19, 0
        s_cbranch_execz .L20556_0
.L20556_0:
        s_and_b64       exec, s[38:39], s[34:35]
.L20560_0:
        s_andn2_b64     exec, s[36:37], exec
        s_and_b64       exec, exec, s[34:35]
        v_mov_b32       v19, 0
        s_cbranch_execz .L20576_0
.L20576_0:
        s_and_b64       exec, s[36:37], s[34:35]
        v_add_i32       v39, vcc, 1, v39
        s_branch        .L19464_0
.L20588_0:
        s_mov_b64       exec, s[32:33]
        v_cmp_eq_i32    vcc, 0, v19
        s_waitcnt       vmcnt(13)
        v_cndmask_b32   v3, 0, v4, vcc
        s_waitcnt       vmcnt(0)
        v_cndmask_b32   v17, 0, 1, vcc



		/*********************************/
		/* SEARCH_MODE_BACKWARD_MATCHING */
		/*********************************/

.L20616_0:
        v_cmp_lg_i32    vcc, 2, v17
        s_waitcnt       lgkmcnt(0)
        s_and_saveexec_b64 s[8:9], vcc
        v_cmp_lg_u32    vcc, 0, v17
        s_cbranch_execz .L21928_0
        s_and_saveexec_b64 s[10:11], vcc
        s_cbranch_execz .L21928_0
        s_add_u32       s0, -1, s0
        s_cmp_le_u32    s0, 1
        s_cbranch_scc0  .L21924_0
        buffer_load_dword v0, v0, s[16:19], s13 offset:128
        buffer_load_dword v4, v0, s[16:19], s13 offset:160
        buffer_load_dword v5, v0, s[16:19], s13 offset:224
        buffer_load_dword v6, v0, s[16:19], s13 offset:228
        buffer_load_dword v7, v0, s[16:19], s13 offset:232
        buffer_load_dword v8, v0, s[16:19], s13 offset:236
        buffer_load_dword v9, v0, s[16:19], s13 offset:192
        buffer_load_dword v10, v0, s[16:19], s13 offset:196
        buffer_load_dword v11, v0, s[16:19], s13 offset:200
        buffer_load_dword v12, v0, s[16:19], s13 offset:204
        buffer_load_dword v13, v0, s[16:19], s13 offset:164
        buffer_load_dword v14, v0, s[16:19], s13 offset:168
        buffer_load_dword v15, v0, s[16:19], s13 offset:132
        buffer_load_dword v16, v0, s[16:19], s13 offset:136
        s_load_dwordx4  s[24:27], s[2:3], 0x70
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x68
        s_waitcnt       lgkmcnt(0)
        s_bfe_u32       s3, s33, 0x100000
        s_mov_b32       s2, s32
        s_add_u32       s2, s2, s4
        s_addc_u32      s3, s3, s5
        s_load_dword    s0, s[2:3], 0x0
        s_mov_b64       s[2:3], exec
        s_mov_b64       s[36:37], exec
        v_mov_b32       v39, 0
.L20820_0:
        v_cmp_lt_i32    vcc, 31, v39
        s_and_saveexec_b64 s[38:39], vcc
        v_mov_b32       v17, 0
        s_cbranch_execz .L20844_0
        s_andn2_b64     s[36:37], s[36:37], exec
        s_cbranch_scc0  .L21904_0
.L20844_0:
        s_and_b64       exec, s[38:39], s[36:37]
        v_lshl_b32      v17, 1, v39
        s_waitcnt       vmcnt(4)
        v_and_b32       v18, v12, v17
        v_cmp_lg_i32    vcc, 0, v18
        v_mov_b32       v18, 0x20000000
        v_cndmask_b32   v18, 0, v18, vcc
        v_and_b32       v19, v80, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x10000000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v8, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x8000000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v59, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x4000000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        s_waitcnt       vmcnt(0)
        v_and_b32       v19, v16, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x2000000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v58, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x1000000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v14, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x800000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v73, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x400000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v11, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x200000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v81, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x100000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v7, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x80000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v84, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x40000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_lshrrev_b32   v19, 18, v18
        v_add_i32       v19, vcc, s6, v19
        v_mov_b32       v20, s7
        v_addc_u32      v20, vcc, v20, 0, vcc
        buffer_load_ubyte v19, v[19:20], s[24:27], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_lg_i32    vcc, 0, v19
        s_mov_b64       s[38:39], exec
        s_andn2_b64     exec, s[38:39], vcc
        v_and_b32       v19, v15, v17
        s_cbranch_execz .L21876_0
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x20000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v67, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x10000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v13, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x8000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v122, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x4000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v10, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x2000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v74, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x1000
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v6, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x800
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v86, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x400
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v0, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x200
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v120, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x100
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v4, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_mov_b32       v19, 0x80
        v_cndmask_b32   v19, 0, v19, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v121, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_cndmask_b32   v19, 0, 64, vcc
        v_or_b32        v18, v18, v19
        v_lshrrev_b32   v19, 6, v18
        v_add_i32       v19, vcc, s14, v19
        v_mov_b32       v20, s15
        v_addc_u32      v20, vcc, v20, 0, vcc
        buffer_load_ubyte v19, v[19:20], s[28:31], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v19
        s_and_saveexec_b64 s[40:41], vcc
        v_and_b32       v19, v9, v17
        s_cbranch_execz .L21856_0
        v_cmp_lg_i32    vcc, 0, v19
        v_cndmask_b32   v19, 0, 32, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v68, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_cndmask_b32   v19, 0, 16, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v19, v5, v17
        v_cmp_lg_i32    vcc, 0, v19
        v_cndmask_b32   v19, 0, 8, vcc
        v_or_b32        v18, v18, v19
        v_and_b32       v17, v76, v17
        v_cmp_lg_i32    vcc, 0, v17
        v_cndmask_b32   v17, 0, 4, vcc
        v_or_b32        v17, v18, v17
        s_mov_b64       s[42:43], exec
        s_mov_b64       s[44:45], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v24, s0
        v_mov_b32       v19, 0
        v_mov_b32       v20, s1
        v_mov_b32       v25, 0
.L21628_0:
        v_add_i32       v22, vcc, -1, v20
        s_mov_b64       s[46:47], exec
        s_mov_b64       s[48:49], exec
        v_mov_b32       v23, v25
.L21644_0:
        v_cmp_gt_i32    vcc, v25, v22
        v_cmp_eq_i32    s[50:51], v17, v24
        s_or_b64        vcc, vcc, s[50:51]
        s_and_saveexec_b64 s[52:53], vcc
        v_cndmask_b32   v24, 0, -1, s[50:51]
        s_cbranch_execz .L21692_0
        v_mov_b32       v19, 1
        v_mov_b32       v25, v23
        s_andn2_b64     s[48:49], s[48:49], exec
        s_cbranch_scc0  .L21792_0
.L21692_0:
        s_and_b64       exec, s[52:53], s[48:49]
        v_add_i32       v18, vcc, v22, v25
        v_ashrrev_i32   v20, 1, v18
        v_ashrrev_i32   v21, 31, v20
        v_lshl_b64      v[23:24], v[20:21], 2
        v_add_i32       v26, vcc, s4, v23
        v_mov_b32       v23, s5
        v_addc_u32      v27, vcc, v23, v24, vcc
        buffer_load_dword v24, v[26:27], s[32:35], 0 addr64
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    s[50:51], v17, v24
        v_add_i32       v23, vcc, 1, v20
        s_mov_b64       s[52:53], exec
        s_andn2_b64     exec, s[52:53], s[50:51]
        s_andn2_b64     s[48:49], s[48:49], exec
        s_cbranch_scc0  .L21792_0
        s_and_b64       exec, s[52:53], s[48:49]
        v_mov_b32       TEMP21, v23
        v_mov_b32       v23, v25
        v_mov_b32       v25, TEMP21
        s_branch        .L21644_0
        v_mov_b32       v25, v23
.L21792_0:
        s_mov_b64       exec, s[46:47]
        v_cmp_lg_u32    vcc, 0, v19
        s_and_saveexec_b64 s[46:47], vcc
        s_andn2_b64     s[44:45], s[44:45], exec
        s_cbranch_scc0  .L21820_0
        s_and_b64       exec, s[46:47], s[44:45]
        s_branch        .L21628_0
.L21820_0:
        s_mov_b64       exec, s[42:43]
        v_cmp_lg_u32    vcc, 0, v24
        s_and_saveexec_b64 s[42:43], vcc
        v_mov_b32       v17, 1
        s_cbranch_execz .L21848_0
        s_andn2_b64     s[36:37], s[36:37], exec
        s_cbranch_scc0  .L21904_0
.L21848_0:
        s_and_b64       exec, s[42:43], s[36:37]
        v_mov_b32       v17, 1
.L21856_0:
        s_andn2_b64     exec, s[40:41], exec
        s_and_b64       exec, exec, s[36:37]
        v_mov_b32       v17, 0
        s_cbranch_execz .L21872_0
.L21872_0:
        s_and_b64       exec, s[40:41], s[36:37]
.L21876_0:
        s_andn2_b64     exec, s[38:39], exec
        s_and_b64       exec, exec, s[36:37]
        v_mov_b32       v17, 0
        s_cbranch_execz .L21892_0
.L21892_0:
        s_and_b64       exec, s[38:39], s[36:37]
        v_add_i32       v39, vcc, 1, v39
        s_branch        .L20820_0
.L21904_0:
        s_mov_b64       exec, s[2:3]
        v_cmp_eq_i32    vcc, 0, v17
        v_cndmask_b32   v3, 0, 2, vcc
        s_branch        .L21928_0
.L21924_0:
        v_mov_b32       v3, 2
.L21928_0:
        s_mov_b64       exec, s[8:9]
        v_cmp_lg_i32    vcc, 2, v3
        s_and_b64       exec, s[8:9], vcc
        v_cmp_eq_u32    vcc, 0, v3
        s_cbranch_execz .L22856_0
        s_waitcnt       lgkmcnt(0)
        s_and_saveexec_b64 s[0:1], vcc
        s_cbranch_execz .L22856_0
        buffer_load_dword v3, v0, s[16:19], s13 offset:256
        buffer_load_dword v4, v0, s[16:19], s13 offset:260
        s_waitcnt       vmcnt(13)
        v_mov_b32       v5, 1
        s_waitcnt       vmcnt(0)
        buffer_store_byte v5, v[3:4], s[20:23], 0 glc addr64
        v_cmp_lg_i32    vcc, 0, v39
        s_and_saveexec_b64 s[2:3], vcc
        v_cmp_lg_i32    vcc, 1, v39
        s_cbranch_execz .L22832_0
        s_and_saveexec_b64 s[4:5], vcc
        v_cmp_lg_i32    vcc, 2, v39
        s_cbranch_execz .L22816_0
        s_and_saveexec_b64 s[6:7], vcc
        v_cmp_lg_i32    vcc, 3, v39
        s_cbranch_execz .L22800_0
        s_and_saveexec_b64 s[10:11], vcc
        v_cmp_lg_i32    vcc, 4, v39
        s_cbranch_execz .L22784_0
        s_and_saveexec_b64 s[12:13], vcc
        v_cmp_lg_i32    vcc, 5, v39
        s_cbranch_execz .L22768_0
        s_and_saveexec_b64 s[14:15], vcc
        v_cmp_lg_i32    vcc, 6, v39
        s_cbranch_execz .L22752_0
        s_and_saveexec_b64 s[16:17], vcc
        v_cmp_lg_i32    vcc, 7, v39
        s_cbranch_execz .L22736_0
        s_and_saveexec_b64 s[18:19], vcc
        v_cmp_lg_i32    vcc, 8, v39
        s_cbranch_execz .L22720_0
        s_and_saveexec_b64 s[24:25], vcc
        v_cmp_lg_i32    vcc, 9, v39
        s_cbranch_execz .L22704_0
        s_and_saveexec_b64 s[26:27], vcc
        v_cmp_lg_i32    vcc, 10, v39
        s_cbranch_execz .L22688_0
        s_and_saveexec_b64 s[28:29], vcc
        v_cmp_lg_i32    vcc, 11, v39
        s_cbranch_execz .L22672_0
        s_and_saveexec_b64 s[30:31], vcc
        v_cmp_lg_i32    vcc, 12, v39
        s_cbranch_execz .L22656_0
        s_and_saveexec_b64 s[32:33], vcc
        v_cmp_lg_i32    vcc, 13, v39
        s_cbranch_execz .L22640_0
        s_and_saveexec_b64 s[34:35], vcc
        v_cmp_lg_i32    vcc, 14, v39
        s_cbranch_execz .L22624_0
        s_and_saveexec_b64 s[36:37], vcc
        v_cmp_lg_i32    vcc, 15, v39
        s_cbranch_execz .L22608_0
        s_and_saveexec_b64 s[38:39], vcc
        v_cmp_lg_i32    vcc, 16, v39
        s_cbranch_execz .L22592_0
        s_and_saveexec_b64 s[40:41], vcc
        v_cmp_lg_i32    vcc, 17, v39
        s_cbranch_execz .L22576_0
        s_and_saveexec_b64 s[42:43], vcc
        v_cmp_lg_i32    vcc, 18, v39
        s_cbranch_execz .L22560_0
        s_and_saveexec_b64 s[44:45], vcc
        v_cmp_lg_i32    vcc, 19, v39
        s_cbranch_execz .L22544_0
        s_and_saveexec_b64 s[46:47], vcc
        v_cmp_lg_i32    vcc, 20, v39
        s_cbranch_execz .L22528_0
        s_and_saveexec_b64 s[48:49], vcc
        v_cmp_lg_i32    vcc, 21, v39
        s_cbranch_execz .L22512_0
        s_and_saveexec_b64 s[50:51], vcc
        v_cmp_lg_i32    vcc, 22, v39
        s_cbranch_execz .L22496_0
        s_and_saveexec_b64 s[52:53], vcc
        v_cmp_lg_i32    vcc, 23, v39
        s_cbranch_execz .L22480_0
        s_and_saveexec_b64 s[54:55], vcc
        v_cmp_lg_i32    vcc, 24, v39
        s_cbranch_execz .L22464_0
        s_and_saveexec_b64 s[56:57], vcc
        v_cmp_lg_i32    vcc, 25, v39
        s_cbranch_execz .L22448_0
        s_and_saveexec_b64 s[58:59], vcc
        v_cmp_lg_i32    vcc, 26, v39
        s_cbranch_execz .L22432_0
        s_and_saveexec_b64 s[60:61], vcc
        v_cmp_eq_i32    s[62:63], v39, 27
        s_cbranch_execz .L22416_0
        v_cmp_eq_i32    s[64:65], v39, 28
        v_cmp_eq_i32    s[66:67], v39, 29
        v_cmp_eq_i32    vcc, 30, v39
        v_mov_b32       v0, KEY7_30
        v_or_b32        v0, 0xffffff00, v0
        v_mov_b32       v3, KEY7_31
        v_or_b32        v3, 0xffffff00, v3
        v_cndmask_b32   v0, v3, v0, vcc
        v_mov_b32       v3, KEY7_29
        v_cndmask_b32   v0, v0, v3, s[66:67]
        v_mov_b32       v3, KEY7_28
        v_cndmask_b32   v0, v0, v3, s[64:65]
        v_mov_b32       v3, KEY7_27
        v_cndmask_b32   v0, v0, v3, s[62:63]
.L22416_0:
        s_andn2_b64     exec, s[60:61], exec
        v_mov_b32       v0, KEY7_26
        s_mov_b64       exec, s[60:61]
.L22432_0:
        s_andn2_b64     exec, s[58:59], exec
        v_mov_b32       v0, KEY7_25
        s_mov_b64       exec, s[58:59]
.L22448_0:
        s_andn2_b64     exec, s[56:57], exec
        v_mov_b32       v0, KEY7_24
        s_mov_b64       exec, s[56:57]
.L22464_0:
        s_andn2_b64     exec, s[54:55], exec
        v_mov_b32       v0, KEY7_23
        s_mov_b64       exec, s[54:55]
.L22480_0:
        s_andn2_b64     exec, s[52:53], exec
        v_mov_b32       v0, KEY7_22
        s_mov_b64       exec, s[52:53]
.L22496_0:
        s_andn2_b64     exec, s[50:51], exec
        v_mov_b32       v0, KEY7_21
        s_mov_b64       exec, s[50:51]
.L22512_0:
        s_andn2_b64     exec, s[48:49], exec
        v_mov_b32       v0, KEY7_20
        s_mov_b64       exec, s[48:49]
.L22528_0:
        s_andn2_b64     exec, s[46:47], exec
        v_mov_b32       v0, KEY7_19
        s_mov_b64       exec, s[46:47]
.L22544_0:
        s_andn2_b64     exec, s[44:45], exec
        v_mov_b32       v0, KEY7_18
        s_mov_b64       exec, s[44:45]
.L22560_0:
        s_andn2_b64     exec, s[42:43], exec
        v_mov_b32       v0, KEY7_17
        s_mov_b64       exec, s[42:43]
.L22576_0:
        s_andn2_b64     exec, s[40:41], exec
        v_mov_b32       v0, KEY7_16
        s_mov_b64       exec, s[40:41]
.L22592_0:
        s_andn2_b64     exec, s[38:39], exec
        v_mov_b32       v0, KEY7_15
        s_mov_b64       exec, s[38:39]
.L22608_0:
        s_andn2_b64     exec, s[36:37], exec
        v_mov_b32       v0, KEY7_14
        s_mov_b64       exec, s[36:37]
.L22624_0:
        s_andn2_b64     exec, s[34:35], exec
        v_mov_b32       v0, KEY7_13
        s_mov_b64       exec, s[34:35]
.L22640_0:
        s_andn2_b64     exec, s[32:33], exec
        v_mov_b32       v0, KEY7_12
        s_mov_b64       exec, s[32:33]
.L22656_0:
        s_andn2_b64     exec, s[30:31], exec
        v_mov_b32       v0, KEY7_11
        s_mov_b64       exec, s[30:31]
.L22672_0:
        s_andn2_b64     exec, s[28:29], exec
        v_mov_b32       v0, KEY7_10
        s_mov_b64       exec, s[28:29]
.L22688_0:
        s_andn2_b64     exec, s[26:27], exec
        v_mov_b32       v0, KEY7_09
        s_mov_b64       exec, s[26:27]
.L22704_0:
        s_andn2_b64     exec, s[24:25], exec
        v_mov_b32       v0, KEY7_08
        s_mov_b64       exec, s[24:25]
.L22720_0:
        s_andn2_b64     exec, s[18:19], exec
        v_mov_b32       v0, KEY7_07
        s_mov_b64       exec, s[18:19]
.L22736_0:
        s_andn2_b64     exec, s[16:17], exec
        v_mov_b32       v0, KEY7_06
        s_mov_b64       exec, s[16:17]
.L22752_0:
        s_andn2_b64     exec, s[14:15], exec
        v_mov_b32       v0, KEY7_05
        s_mov_b64       exec, s[14:15]
.L22768_0:
        s_andn2_b64     exec, s[12:13], exec
        v_mov_b32       v0, KEY7_04
        s_mov_b64       exec, s[12:13]
.L22784_0:
        s_andn2_b64     exec, s[10:11], exec
        v_mov_b32       v0, KEY7_03
        s_mov_b64       exec, s[10:11]
.L22800_0:
        s_andn2_b64     exec, s[6:7], exec
        v_mov_b32       v0, KEY7_02
        s_mov_b64       exec, s[6:7]
.L22816_0:
        s_andn2_b64     exec, s[4:5], exec
        v_mov_b32       v0, KEY7_01
        s_mov_b64       exec, s[4:5]
.L22832_0:
        s_andn2_b64     exec, s[2:3], exec
        v_mov_b32       v0, KEY7_00
        s_mov_b64       exec, s[2:3]
        buffer_store_byte v0, v[1:2], s[20:23], 0 offset:24 glc addr64
.L22856_0:
        s_mov_b64       exec, s[8:9]
        s_waitcnt       vmcnt(13)
        v_mov_b32       v0, 32
        buffer_store_dword v0, v[1:2], s[20:23], 0 addr64
        s_endpgm
