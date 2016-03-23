/*
.amd
.gpu Tahiti
*/
.32bit
.compile_options "-O1 -cl-mad-enable -DOPENCL_DES_LOCAL_WORK_SIZE=128  -DOPENCL_DES_BS_DEPTH=32  -w  -DFORWARD_MATCHING_1CHUNK "
.driver_info "@(#) OpenCL 1.2 AMD-APP (1800.11).  Driver version: 1800.11 (VM)"
.globaldata
    .byte 0x5e, 0x5f, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65
    .byte 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d
    .byte 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75
    .byte 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d
.kernel OpenCL_DES_PerformSearching
	.header
        .byte 0x10, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .byte 0x10, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
        .fill 8, 1, 0x00
    .metadata
        .ascii ";ARGSTART:__OpenCL_OpenCL_DES_PerformSearching_kernel\n"
        .ascii ";version:3:1:111\n"
        /*.ascii ";device:tahiti\n"*/
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
        .ascii ";memory:datareqd\n"
        .ascii ";function:1:1028\n"
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
        .int 0x00000000
    .persistentbuffers
    .proginfo
        .entry 0x80001000, 0x00000003
        .entry 0x80001001, 0x00000017
        .entry 0x80001002, 0x00000000
        .entry 0x80001003, 0x00000002
        .entry 0x80001004, 0x00000002
        .entry 0x80001005, 0x00000002
        .entry 0x80001006, 0x00000000
        .entry 0x80001007, 0x00000004
        .entry 0x80001008, 0x00000004
        .entry 0x80001009, 0x00000002
        .entry 0x8000100a, 0x00000001
        .entry 0x8000100b, 0x00000008
        .entry 0x8000100c, 0x00000004
        .entry 0x80001041, 0x00000080 /* # of VGPRs 0x0000007d, (125), Max 128, +3 */
        .entry 0x80001042, 0x00000068 /* # of SGPRs 0x0000005c, (90 + 2), Max 104, +12 */
        .entry 0x80001863, 0x00000066
        .entry 0x80001864, 0x00000100
        .entry 0x80001043, 0x000000c0
        .entry 0x80001044, 0x00000000
        .entry 0x80001045, 0x00000000
        .entry 0x00002e13, 0x00000998
        .entry 0x8000001c, 0x00000100
        .entry 0x8000001d, 0x00000000
        .entry 0x8000001e, 0x00000000
        .entry 0x80001841, 0x00000000
        .entry 0x8000001f, 0x0001f400
        .entry 0x80001843, 0x0001f400
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
        .byte 0x00, 0xf4, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00
        .fill 120, 1, 0x00
    .text
        v_writelane_b32 v2, s2, 0
        v_writelane_b32 v2, s3, 1
        s_buffer_load_dwordx2 s[0:1], s[4:7], 0x4
        s_buffer_load_dwordx2 s[14:15], s[4:7], 0x18
        s_waitcnt       lgkmcnt(0)
        s_buffer_load_dword s1, s[8:11], 0x20
        s_min_u32       s0, s0, 0xffff
        s_mul_i32       s0, s12, s0
        s_add_u32       s0, s0, s14
        v_add_i32       v0, vcc, s0, v0
        s_load_dwordx4  s[12:15], s[2:3], 0x80
        v_lshlrev_b32   v1, 2, v0
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v1, vcc, s1, v1
        buffer_load_ubyte v3, v1, s[12:15], 0 offen offset:2
        buffer_load_ubyte v4, v1, s[12:15], 0 offen offset:3
        buffer_load_ubyte v1, v1, s[12:15], 0 offen offset:1
        s_buffer_load_dword s0, s[8:11], 0x4
        s_buffer_load_dword s1, s[8:11], 0x24
        v_lshlrev_b32   v0, 5, v0
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v0, vcc, s0, v0
        v_mov_b32       v5, 0
        s_waitcnt       vmcnt(2)
        v_lshlrev_b32   v6, 7, v3
        s_waitcnt       vmcnt(1)
        v_lshlrev_b32   v7, 14, v4
        s_waitcnt       vmcnt(0)
        v_and_b32       v8, 8, v1
        v_and_b32       v9, 0x2000, v6
        s_and_b32       s0, s1, 0x8000000
        v_and_b32       v10, 0x400, v6
        v_and_b32       v11, 0x100000, v7
        v_and_b32       v12, 64, v1
        v_and_b32       v13, 0x20000, v7
        s_and_b32       s12, s1, 0x800
        s_and_b32       s13, s1, 16
        s_and_b32       s14, s1, 0x2000000
        s_and_b32       s15, s1, 0x40000
        v_and_b32       v14, 0x800, v6
        v_and_b32       v15, 16, v1
        v_and_b32       v16, 0x40000, v7
        s_and_b32       s16, s1, 0x1000
        s_and_b32       s17, s1, 32
        s_and_b32       s18, s1, 0x2000
        s_and_b32       s19, s1, 64
        s_and_b32       s20, s1, 0x100000
        s_and_b32       s21, s1, 0x4000000
        v_and_b32       v17, 0x1000, v6
        v_and_b32       v18, 2, v1
        v_and_b32       v19, 0x4000, v7
        s_and_b32       s22, s1, 0x400
        v_and_b32       v20, 0x200, v6
        v_and_b32       v21, 0x100, v6
        s_and_b32       s23, s1, 0x20000
        s_and_b32       s24, s1, 2
        s_and_b32       s25, s1, 0x80
        s_and_b32       s26, s1, 0x1000000
        s_and_b32       s27, s1, 0x10000
        s_and_b32       s28, s1, 0x8000
        s_and_b32       s29, s1, 0x200000
        s_and_b32       s30, s1, 0x200
        v_and_b32       v22, 4, v1
        v_and_b32       v6, 0x80, v6
        s_and_b32       s31, s1, 0x800000
        v_and_b32       v23, 0x10000, v7
        v_and_b32       v24, 0x8000, v7
        s_and_b32       s32, s1, 1
        s_and_b32       s33, s1, 0x4000
        s_and_b32       s34, s1, 0x400000
        s_and_b32       s35, s1, 4
        s_and_b32       s36, s1, 0x100
        s_and_b32       s37, s1, 8
        v_and_b32       v25, 1, v1
        v_and_b32       v26, 32, v1
        v_and_b32       v7, 0x80000, v7
        s_and_b32       s38, s1, 0x80000
        s_buffer_load_dword s4, s[4:7], 0x20
        s_waitcnt       lgkmcnt(0)
        v_writelane_b32 v2, s4, 2
        s_buffer_load_dword s4, s[8:11], 0x0
        s_buffer_load_dword s5, s[8:11], 0xc
        s_waitcnt       lgkmcnt(0)
        v_writelane_b32 v2, s5, 3
        s_buffer_load_dword s5, s[8:11], 0x10
        s_buffer_load_dword s6, s[8:11], 0x14
        s_buffer_load_dword s7, s[8:11], 0x1c
        s_load_dwordx4  s[8:11], s[2:3], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v5, v0, s[8:11], 0 offen offset:4 glc
        s_waitcnt       expcnt(0)
        v_bfe_i32       v5, v3, 0, 1
        v_bfe_i32       v67, v1, 0, 1
        s_bfe_i32       s2, s1, 0x10000
        v_bfe_i32       v80, v4, 0, 1
        v_bfe_i32       v57, v4, 5, 1
        s_bfe_i32       s3, s1, 0x10019
        s_bfe_i32       s8, s1, 0x10014
        s_bfe_i32       s9, s1, 0x1000c
        s_bfe_i32       s10, s1, 0x10004
        v_bfe_i32       v59, v3, 5, 1
        s_bfe_i32       s11, s1, 0x10013
        v_bfe_i32       v64, v1, 4, 1
        s_bfe_i32       s39, s1, 0x1001b
        s_bfe_i32       s40, s1, 0x1000b
        s_bfe_i32       s41, s1, 0x10005
        s_bfe_i32       s42, s1, 0x1001a
        s_bfe_i32       s43, s1, 0x1000d
        v_bfe_i32       v68, v4, 4, 1
        v_bfe_i32       v62, v3, 6, 1
        v_bfe_i32       v58, v1, 5, 1
        v_bfe_i32       v121, v4, 6, 1
        s_bfe_i32       s44, s1, 0x10006
        v_bfe_i32       v61, v3, 4, 1
        v_bfe_i32       v86, v3, 3, 1
        v_bfe_i32       v55, v1, 6, 1
        s_bfe_i32       s45, s1, 0x10012
        v_bfe_i32       v56, v1, 3, 1
        v_bfe_i32       v79, v4, 3, 1
        v_bfe_i32       v72, v1, 2, 1
        s_bfe_i32       s46, s1, 0x10015
        s_bfe_i32       s47, s1, 0x10009
        s_bfe_i32       s48, s1, 0x10002
        s_bfe_i32       s49, s1, 0x10016
        v_bfe_i32       v120, v3, 2, 1
        s_bfe_i32       s50, s1, 0x10001
        s_bfe_i32       s51, s1, 0x10010
        v_bfe_i32       v60, v4, 2, 1
        v_bfe_i32       v1, v1, 1, 1
        s_bfe_i32       s52, s1, 0x1000f
        s_bfe_i32       s53, s1, 0x1000e
        s_bfe_i32       s54, s1, 0x10003
        s_bfe_i32       s55, s1, 0x10017
        v_bfe_i32       v4, v4, 1, 1
        s_bfe_i32       s56, s1, 0x10008
        s_bfe_i32       s57, s1, 0x10011
        v_bfe_i32       v3, v3, 1, 1
        s_bfe_i32       s58, s1, 0x10007
        s_bfe_i32       s59, s1, 0x1000a
        s_bfe_i32       s1, s1, 0x10018
        s_nop           0x0
        v_cmp_lg_i32    s[60:61], v12, 0
        v_cmp_lg_i32    s[62:63], s20, 0
        v_cmp_lg_i32    s[64:65], v11, 0
        v_cmp_lg_i32    s[66:67], s0, 0
        v_cmp_lg_i32    s[68:69], s18, 0
        v_cmp_lg_i32    s[70:71], v9, 0
        v_cmp_lg_i32    s[72:73], v17, 0
        v_writelane_b32 v2, s72, 4
        v_writelane_b32 v2, s73, 5
        v_cmp_lg_i32    s[18:19], s19, 0
        v_cmp_lg_i32    s[20:21], s21, 0
        v_cmp_lg_i32    s[72:73], v7, 0
        v_cmp_lg_i32    s[74:75], s16, 0
        v_cmp_lg_i32    s[76:77], s38, 0
        v_cmp_lg_i32    s[78:79], v14, 0
        v_cmp_lg_i32    s[80:81], v16, 0
        v_writelane_b32 v2, s80, 6
        v_writelane_b32 v2, s81, 7
        v_cmp_lg_i32    s[80:81], v8, 0
        v_writelane_b32 v2, s80, 8
        v_writelane_b32 v2, s81, 9
        v_cmp_lg_i32    s[80:81], v15, 0
        v_writelane_b32 v2, s80, 10
        v_writelane_b32 v2, s81, 11
        v_cmp_lg_i32    s[80:81], v26, 0
        v_cmp_lg_i32    s[82:83], s15, 0
        v_cmp_lg_i32    s[84:85], s13, 0
        v_cmp_lg_i32    s[16:17], s17, 0
        v_cmp_lg_i32    s[86:87], v13, 0
        v_cmp_lg_i32    s[14:15], s14, 0
        v_cmp_lg_i32    s[88:89], s34, 0
        v_writelane_b32 v2, s88, 12
        v_writelane_b32 v2, s89, 13
        v_cmp_lg_i32    s[88:89], v6, 0
        v_writelane_b32 v2, s88, 14
        v_writelane_b32 v2, s89, 15
        v_cmp_lg_i32    s[88:89], s37, 0
        v_writelane_b32 v2, s88, 16
        v_writelane_b32 v2, s89, 17
        v_cmp_lg_i32    s[88:89], v22, 0
        v_writelane_b32 v2, s88, 18
        v_writelane_b32 v2, s89, 19
        v_cmp_lg_i32    s[88:89], v25, 0
        v_writelane_b32 v2, s88, 20
        v_writelane_b32 v2, s89, 21
        v_cmp_lg_i32    s[88:89], s31, 0
        v_writelane_b32 v2, s88, 22
        v_writelane_b32 v2, s89, 23
        v_cmp_lg_i32    s[88:89], s24, 0
        v_writelane_b32 v2, s88, 24
        v_writelane_b32 v2, s89, 25
        v_cmp_lg_i32    s[88:89], s33, 0
        v_cmp_lg_i32    s[30:31], s30, 0
        v_writelane_b32 v2, s30, 26
        v_writelane_b32 v2, s31, 27
        v_cmp_lg_i32    s[30:31], v23, 0
        v_writelane_b32 v2, s30, 28
        v_writelane_b32 v2, s31, 29
        v_cmp_lg_i32    s[30:31], s32, 0
        v_writelane_b32 v2, s30, 30
        v_writelane_b32 v2, s31, 31
        v_cmp_lg_i32    s[30:31], s29, 0
        v_writelane_b32 v2, s30, 32
        v_writelane_b32 v2, s31, 33
        v_cmp_lg_i32    s[30:31], s26, 0
        v_cmp_lg_i32    s[32:33], v24, 0
        v_writelane_b32 v2, s32, 34
        v_writelane_b32 v2, s33, 35
        v_cmp_lg_i32    s[24:25], s25, 0
        v_writelane_b32 v2, s24, 36
        v_writelane_b32 v2, s25, 37
        v_cmp_lg_i32    s[24:25], s22, 0
        v_writelane_b32 v2, s24, 38
        v_writelane_b32 v2, s25, 39
        v_cmp_lg_i32    s[24:25], s35, 0
        v_writelane_b32 v2, s24, 40
        v_writelane_b32 v2, s25, 41
        v_cmp_lg_i32    s[24:25], s28, 0
        v_writelane_b32 v2, s24, 42
        v_writelane_b32 v2, s25, 43
        v_cmp_lg_i32    s[24:25], v21, 0
        v_cmp_lg_i32    s[22:23], s23, 0
        v_writelane_b32 v2, s22, 44
        v_writelane_b32 v2, s23, 45
        v_cmp_lg_i32    s[22:23], s36, 0
        v_writelane_b32 v2, s22, 46
        v_writelane_b32 v2, s23, 47
        v_cmp_lg_i32    s[22:23], v20, 0
        v_writelane_b32 v2, s22, 48
        v_writelane_b32 v2, s23, 49
        v_cmp_lg_i32    s[22:23], s27, 0
        v_writelane_b32 v2, s22, 50
        v_writelane_b32 v2, s23, 51
        v_cmp_lg_i32    s[22:23], v18, 0
        v_writelane_b32 v2, s22, 52
        v_writelane_b32 v2, s23, 53
        v_cmp_lg_i32    s[22:23], v19, 0
        v_cmp_lg_i32    s[12:13], s12, 0
        v_cmp_lg_i32    s[26:27], v10, 0
        s_movk_i32      s0, 0x0

        v_mov_b32       v6, 0
        v_mov_b32       v7, 0
        v_mov_b32       v8, 0
        v_mov_b32       v9, 0
        v_mov_b32       v10, 0
        v_mov_b32       v11, 0
        v_mov_b32       v12, 0
        v_mov_b32       v13, 0
        v_mov_b32       v14, 0
        v_mov_b32       v15, 0
        v_mov_b32       v16, 0
        v_mov_b32       v17, 0
        v_mov_b32       v18, 0
        v_mov_b32       v19, 0
        v_mov_b32       v20, 0
        v_mov_b32       v21, 0
        v_mov_b32       v22, 0
        v_mov_b32       v23, 0
        v_mov_b32       v24, 0
        v_mov_b32       v25, 0
        v_mov_b32       v26, 0
        v_mov_b32       v27, 0
        v_mov_b32       v28, 0
        v_mov_b32       v29, 0
        v_mov_b32       v30, 0
        v_mov_b32       v31, 0
        v_mov_b32       v32, 0
        v_mov_b32       v33, 0
        v_mov_b32       v34, 0
        v_mov_b32       v35, 0
        v_mov_b32       v36, 0
        v_mov_b32       v37, 0
        v_mov_b32       v38, 0
        v_mov_b32       v39, 0
        v_mov_b32       v40, 0
        v_mov_b32       v41, 0
        v_mov_b32       v42, 0
        v_mov_b32       v43, 0
        v_mov_b32       v44, 0
        v_mov_b32       v45, 0
        v_mov_b32       v46, 0
        v_mov_b32       v47, 0
        v_mov_b32       v48, 0
        v_mov_b32       v49, 0
        v_mov_b32       v50, 0
        v_mov_b32       v51, 0
        v_mov_b32       v52, 0
        v_mov_b32       v53, 0
        v_mov_b32       v54, 0
        v_mov_b32       v69, 0
        v_mov_b32       v73, 0
        v_mov_b32       v122, 0
        v_mov_b32       v66, 0
        v_mov_b32       v71, 0
        v_mov_b32       v78, 0
        v_mov_b32       v123, 0
        v_mov_b32       v74, 0
        v_mov_b32       v65, 0
        v_mov_b32       v76, 0
        v_mov_b32       v63, 0
        v_mov_b32       v75, 0
        v_mov_b32       v77, 0
        v_mov_b32       v119, 0
        v_mov_b32       v85, 0

		s_movk_i32      s32, 13

.S1_S2_A:
		s_getpc_b64 s[98:99]
		s_add_u32 s98,s98,12
		s_addc_u32 s99,s99,0
		s_branch .S3_S4_A
		
        v_bfi_b32       v99, v111, v87, v97
        v_xor_b32       v100, v87, v97
        v_or_b32        v101, v105, v98
        v_xor_b32       v102, v100, v101
        v_bfi_b32       v103, v102, v99, v111
        v_xor_b32       v104, v98, v103
        v_xor_b32       v89, v105, v104
        v_bfi_b32       v105, v111, v89, v104
        v_bfi_b32       v106, v99, v101, v89
        v_bfi_b32       v107, v111, v102, v100
        v_xor_b32       v106, v106, v107
        v_bfi_b32       v101, v106, v89, v101
        v_bfi_b32       v108, v105, v106, v101
        v_xor_b32       v108, v99, v108
        v_bfi_b32       v109, v108, v99, v98
        v_bfi_b32       v99, v89, v102, v99
        v_bfi_b32       v88, v108, v99, v111
        v_bfi_b32       v101, v101, v104, v102
        v_xor_b32       v101, v88, v101
        v_bfi_b32       v99, v97, v99, v89
        v_bfi_b32       v104, v109, v99, v101
        v_not_b32       v104, v104
        v_bfi_b32       v101, v115, v101, v104
        v_xor_b32       v29, v101, v29
        v_bfi_b32       v88, v88, v97, v104
        v_bfi_b32       v93, v102, v87, v99
        v_bfi_b32       v88, v93, v98, v88
        v_xor_b32       v98, v108, v88
        v_bfi_b32       v99, v115, v89, v98
        v_xor_b32       v21, v99, v21
        v_bfi_b32       v99, v88, v107, v105
        v_bfi_b32       v93, v103, v89, v93
        v_xor_b32       v99, v99, v93
        v_bfi_b32       v99, v115, v108, v99
        v_xor_b32       v7, v99, v7
        v_xor_b32       v89, v89, v98
        v_bfi_b32       v88, v88, v89, v97
        v_bfi_b32       v88, v93, v100, v88
        v_bfi_b32       v88, v115, v106, v88
        v_xor_b32       v15, v88, v15
        v_bfi_b32       v88, v110, v114, v94
        v_bfi_b32       v89, v113, v88, v110
        v_bfi_b32       v92, v89, v116, v114
        v_xor_b32       v92, v94, v92
        v_bfi_b32       v93, v110, v92, v116
        v_not_b32       v97, v93
        v_xor_b32       v88, v88, v97
        v_xor_b32       v98, v110, v113
        v_xor_b32       v99, v88, v98
        v_xor_b32       v100, v92, v98
        v_bfi_b32       v99, v112, v100, v99
        v_xor_b32       v10, v99, v10
        v_xor_b32       v99, v116, v89
        v_bfi_b32       v101, v113, v99, v88
        v_xor_b32       v102, v114, v99
        v_bfi_b32       v101, v94, v102, v101
        v_bfi_b32       v95, v113, v101, v116
        v_bfi_b32       v102, v88, v100, v92
        v_xor_b32       v97, v97, v102
        v_xor_b32       v97, v95, v97
        v_bfi_b32       v103, v112, v101, v97
        v_xor_b32       v25, v103, v25
        v_bfi_b32       v102, v101, v97, v102
        v_bfi_b32       v90, v94, v88, v100
        v_bfi_b32       v89, v89, v114, v90
        v_bfi_b32       v94, v113, v89, v102
        v_bfi_b32       v92, v98, v110, v92
        v_bfi_b32       v88, v92, v99, v88
        v_bfi_b32       v88, v112, v94, v88
        v_xor_b32       v20, v88, v20
        v_bfi_b32       v87, v110, v95, v90
        v_bfi_b32       v88, v98, v97, v101
        v_bfi_b32       v88, v92, v90, v88
        v_bfi_b32       v87, v87, v88, v93
        v_xor_b32       v87, v89, v87
        v_bfi_b32       v87, v112, v87, v88
        v_xor_b32       v36, v87, v36
		s_setpc_b64 s[100:101]



.S3_S4_A:
		s_getpc_b64 s[96:97]
		s_add_u32 s96,s96,12
		s_addc_u32 s97,s97,0
		s_branch .S5_S6_A

        v_bfi_b32       v99, v87, v98, v88
        v_xor_b32       v99, v113, v99
        v_bfi_b32       v100, v115, v99, v87
        v_xor_b32       v101, v115, v99
        v_bfi_b32       v102, v88, v100, v101
        v_bfi_b32       v103, v99, v98, v87
        v_bfi_b32       v104, v100, v88, v103
        v_bfi_b32       v105, v101, v113, v98
        v_xor_b32       v105, v104, v105
        v_bfi_b32       v98, v98, v105, v102
        v_not_b32       v106, v98
        v_bfi_b32       v107, v110, v106, v105
        v_xor_b32       v22, v107, v22
        v_xor_b32       v106, v103, v106
        v_bfi_b32       v102, v101, v102, v106
        v_bfi_b32       v104, v104, v99, v115
        v_xor_b32       v107, v102, v104
        v_bfi_b32       v108, v106, v113, v107
        v_bfi_b32       v98, v87, v115, v98
        v_bfi_b32       v99, v99, v113, v88
        v_bfi_b32       v100, v100, v99, v106
        v_bfi_b32       v100, v108, v98, v100
        v_xor_b32       v106, v107, v98
        v_bfi_b32       v106, v110, v106, v100
        v_xor_b32       v14, v106, v14
        v_bfi_b32       v89, v87, v107, v102
        v_bfi_b32       v96, v88, v103, v99
        v_bfi_b32       v89, v96, v100, v89
        v_bfi_b32       v89, v110, v89, v101
        v_xor_b32       v32, v89, v32
        v_bfi_b32       v89, v104, v115, v102
        v_bfi_b32       v89, v113, v96, v89
        v_xor_b32       v89, v98, v89
        v_xor_b32       v92, v103, v105
        v_bfi_b32       v92, v98, v104, v92
        v_bfi_b32       v88, v110, v92, v89
        v_xor_b32       v8, v88, v8
        v_bfi_b32       v88, v111, v116, v90
        v_xor_b32       v89, v114, v88
        v_bfi_b32       v92, v116, v90, v89
        v_bfi_b32       v96, v88, v89, v92
        v_bfi_b32       v93, v111, v90, v116
        v_bfi_b32       v97, v114, v111, v93
        v_xor_b32       v95, v90, v97
        v_bfi_b32       v95, v112, v95, v111
        v_xor_b32       v92, v92, v95
        v_not_b32       v95, v92
        v_bfi_b32       v96, v112, v96, v95
        v_bfi_b32       v97, v97, v112, v114
        v_xor_b32       v90, v111, v93
        v_bfi_b32       v93, v90, v97, v95
        v_xor_b32       v88, v88, v93
        v_not_b32       v93, v88
        v_bfi_b32       v98, v114, v93, v90
        v_xor_b32       v96, v96, v98
        v_bfi_b32       v92, v109, v92, v96
        v_xor_b32       v28, v92, v28
        v_bfi_b32       v92, v109, v96, v95
        v_xor_b32       v37, v92, v37
        v_bfi_b32       v89, v89, v114, v112
        v_bfi_b32       v89, v90, v89, v97
        v_xor_b32       v90, v93, v96
        v_xor_b32       v89, v89, v90
        v_bfi_b32       v90, v109, v89, v93
        v_xor_b32       v12, v90, v12
        v_bfi_b32       v87, v109, v88, v89
        v_xor_b32       v18, v87, v18
		s_setpc_b64 s[100:101]



.S5_S6_A:
		s_getpc_b64 s[94:95]
		s_add_u32 s94,s94,12
		s_addc_u32 s95,s95,0
		s_branch .S7_S8_A

        v_bfi_b32       v99, v112, v98, v87
        v_not_b32       v100, v99
        v_bfi_b32       v101, v98, v87, v100
        v_xor_b32       v102, v118, v101
        v_xor_b32       v103, v112, v114
        v_xor_b32       v104, v102, v103
        v_bfi_b32       v105, v102, v104, v118
        v_bfi_b32       v106, v105, v99, v114
        v_bfi_b32       v107, v87, v112, v106
        v_bfi_b32       v98, v118, v100, v98
        v_xor_b32       v108, v107, v98
        v_bfi_b32       v109, v102, v108, v103
        v_bfi_b32       v110, v109, v87, v114
        v_bfi_b32       v105, v110, v114, v105
        v_xor_b32       v111, v108, v105
        v_bfi_b32       v108, v94, v108, v111
        v_xor_b32       v13, v108, v13
        v_bfi_b32       v100, v109, v106, v100
        v_bfi_b32       v92, v87, v99, v105
        v_xor_b32       v99, v100, v92
        v_bfi_b32       v106, v94, v104, v99
        v_xor_b32       v24, v106, v24
        v_bfi_b32       v106, v114, v92, v99
        v_bfi_b32       v107, v118, v107, v106
        v_bfi_b32       v97, v104, v118, v98
        v_bfi_b32       v108, v99, v97, v107
        v_bfi_b32       v87, v104, v99, v112
        v_bfi_b32       v92, v87, v103, v92
        v_bfi_b32       v97, v97, v107, v105
        v_xor_b32       v92, v92, v97
        v_bfi_b32       v92, v94, v92, v108
        v_xor_b32       v35, v92, v35
        v_bfi_b32       v92, v100, v111, v102
        v_bfi_b32       v87, v107, v92, v87
        v_bfi_b32       v89, v114, v101, v98
        v_bfi_b32       v92, v110, v104, v102
        v_bfi_b32       v89, v106, v92, v89
        v_bfi_b32       v87, v94, v87, v89
        v_xor_b32       v30, v87, v30
        v_bfi_b32       v87, v115, v116, v117
        v_xor_b32       v89, v88, v87
        v_bfi_b32       v92, v93, v116, v89
        v_xor_b32       v96, v117, v92
        v_xor_b32       v97, v115, v96
        v_bfi_b32       v98, v116, v97, v96
        v_bfi_b32       v99, v98, v96, v116
        v_xor_b32       v99, v93, v99
        v_bfi_b32       v98, v98, v116, v93
        v_xor_b32       v89, v89, v98
        v_bfi_b32       v94, v97, v93, v116
        v_bfi_b32       v95, v89, v94, v99
        v_bfi_b32       v100, v95, v99, v115
        v_not_b32       v101, v97
        v_bfi_b32       v102, v89, v94, v101
        v_bfi_b32       v100, v100, v97, v102
        v_bfi_b32       v101, v113, v100, v101
        v_xor_b32       v34, v101, v34
        v_bfi_b32       v91, v88, v100, v96
        v_bfi_b32       v90, v91, v102, v117
        v_xor_b32       v89, v97, v89
        v_xor_b32       v91, v90, v89
        v_bfi_b32       v89, v113, v91, v89
        v_xor_b32       v19, v89, v19
        v_bfi_b32       v89, v97, v92, v99
        v_bfi_b32       v94, v98, v94, v89
        v_xor_b32       v94, v91, v94
        v_xor_b32       v87, v87, v94
        v_bfi_b32       v93, v102, v100, v115
        v_bfi_b32       v96, v93, v94, v87
        v_not_b32       v96, v96
        v_bfi_b32       v87, v113, v87, v96
        v_xor_b32       v9, v87, v9
        v_bfi_b32       v87, v94, v91, v93
        v_bfi_b32       v89, v92, v89, v90
        v_xor_b32       v87, v87, v89
        v_bfi_b32       v87, v113, v87, v95
        v_xor_b32       v27, v87, v27
		s_setpc_b64 s[100:101]



.S7_S8_A:
        s_getpc_b64 s[92:93]
		s_add_u32 s92,s92,12
		s_addc_u32 s93,s93,0
		s_branch .S1_S2_B
		
		v_bfi_b32       v99, v98, v110, v94
        v_bfi_b32       v100, v116, v98, v114
        v_bfi_b32       v99, v110, v100, v99
        v_bfi_b32       v101, v94, v114, v98
        v_xor_b32       v101, v116, v101
        v_xor_b32       v102, v99, v101
        v_bfi_b32       v99, v116, v99, v94
        v_xor_b32       v103, v94, v98
        v_bfi_b32       v104, v101, v99, v103
        v_xor_b32       v105, v114, v110
        v_xor_b32       v106, v104, v105
        v_bfi_b32       v107, v87, v102, v106
        v_xor_b32       v6, v107, v6
        v_xor_b32       v107, v98, v106
        v_bfi_b32       v108, v103, v110, v107
        v_bfi_b32       v108, v114, v108, v106
        v_not_b32       v89, v110
        v_bfi_b32       v89, v99, v107, v89
        v_bfi_b32       v88, v114, v107, v101
        v_bfi_b32       v88, v105, v103, v88
        v_xor_b32       v88, v100, v88
        v_bfi_b32       v98, v98, v88, v101
        v_xor_b32       v99, v89, v98
        v_bfi_b32       v100, v87, v108, v99
        v_xor_b32       v26, v100, v26
        v_xor_b32       v99, v103, v99
        v_bfi_b32       v98, v98, v99, v108
        v_bfi_b32       v89, v89, v102, v98
        v_bfi_b32       v88, v87, v88, v89
        v_xor_b32       v16, v88, v16
        v_bfi_b32       v88, v104, v106, v107
        v_xor_b32       v89, v107, v99
        v_bfi_b32       v88, v116, v89, v88
        v_bfi_b32       v89, v106, v102, v108
        v_bfi_b32       v89, v89, v94, v88
        v_not_b32       v89, v89
        v_bfi_b32       v88, v87, v89, v88
        v_xor_b32       v31, v88, v31
        v_bfi_b32       v88, v117, v112, v113
        v_bfi_b32       v89, v111, v117, v109
        v_bfi_b32       v93, v113, v111, v117
        v_xor_b32       v93, v112, v93
        v_bfi_b32       v88, v89, v88, v93
        v_xor_b32       v89, v109, v88
        v_bfi_b32       v96, v93, v117, v89
        v_bfi_b32       v93, v113, v112, v93
        v_bfi_b32       v94, v93, v111, v96
        v_bfi_b32       v93, v109, v93, v117
        v_bfi_b32       v96, v93, v89, v111
        v_bfi_b32       v95, v109, v117, v113
        v_xor_b32       v97, v96, v95
        v_xor_b32       v98, v94, v97
        v_bfi_b32       v99, v115, v97, v98
        v_xor_b32       v23, v99, v23
        v_bfi_b32       v90, v117, v98, v95
        v_bfi_b32       v98, v90, v109, v88
        v_xor_b32       v90, v93, v90
        v_xor_b32       v93, v89, v90
        v_not_b32       v99, v93
        v_bfi_b32       v100, v94, v98, v99
        v_xor_b32       v90, v90, v100
        v_bfi_b32       v89, v115, v89, v90
        v_xor_b32       v11, v89, v11
        v_bfi_b32       v89, v98, v95, v96
        v_bfi_b32       v89, v97, v89, v88
        v_xor_b32       v89, v99, v89
        v_bfi_b32       v89, v115, v89, v99
        v_xor_b32       v17, v89, v17
        v_or_b32        v89, v111, v94
        v_xor_b32       v89, v100, v89
        v_bfi_b32       v87, v97, v109, v88
        v_xor_b32       v87, v89, v87
        v_bfi_b32       v87, v115, v93, v87
        v_xor_b32       v33, v87, v33
		s_setpc_b64 s[100:101]
		


.S1_S2_B:
        s_getpc_b64 s[90:91]
		s_add_u32 s90,s90,12
		s_addc_u32 s91,s91,0
		s_branch .S3_S4_B
		
        v_bfi_b32       v99, v110, v98, v92
        v_xor_b32       v100, v92, v98
        v_or_b32        v101, v89, v87
        v_xor_b32       v102, v100, v101
        v_bfi_b32       v103, v102, v99, v110
        v_xor_b32       v104, v87, v103
        v_xor_b32       v90, v89, v104
        v_bfi_b32       v105, v110, v90, v104
        v_bfi_b32       v106, v99, v101, v90
        v_bfi_b32       v107, v110, v102, v100
        v_xor_b32       v106, v106, v107
        v_bfi_b32       v101, v106, v90, v101
        v_bfi_b32       v108, v105, v106, v101
        v_xor_b32       v108, v99, v108
        v_bfi_b32       v109, v108, v99, v87
        v_bfi_b32       v99, v90, v102, v99
        v_bfi_b32       v89, v108, v99, v110
        v_bfi_b32       v101, v101, v104, v102
        v_xor_b32       v101, v89, v101
        v_bfi_b32       v99, v92, v99, v90
        v_bfi_b32       v104, v109, v99, v101
        v_not_b32       v104, v104
        v_bfi_b32       v89, v89, v92, v104
        v_bfi_b32       v98, v102, v98, v99
        v_bfi_b32       v89, v98, v87, v89
        v_xor_b32       v96, v108, v89
        v_xor_b32       v99, v90, v96
        v_bfi_b32       v97, v89, v99, v92
        v_bfi_b32       v98, v103, v90, v98
        v_bfi_b32       v97, v98, v100, v97
        v_bfi_b32       v97, v111, v106, v97
        v_xor_b32       v47, v47, v97
        v_bfi_b32       v97, v111, v101, v104
        v_xor_b32       v123, v123, v97
        v_bfi_b32       v90, v111, v90, v96
        v_xor_b32       v53, v53, v90
        v_bfi_b32       v89, v89, v107, v105
        v_xor_b32       v89, v98, v89
        v_bfi_b32       v89, v111, v108, v89
        v_xor_b32       v39, v39, v89
        v_bfi_b32       v89, v81, v84, v88
        v_bfi_b32       v90, v82, v89, v81
        v_bfi_b32       v91, v90, v83, v84
        v_xor_b32       v91, v88, v91
        v_bfi_b32       v96, v81, v91, v83
        v_not_b32       v97, v96
        v_xor_b32       v89, v89, v97
        v_xor_b32       v98, v81, v82
        v_xor_b32       v99, v91, v98
        v_bfi_b32       v100, v88, v89, v99
        v_xor_b32       v101, v83, v90
        v_bfi_b32       v102, v82, v101, v89
        v_xor_b32       v103, v84, v101
        v_bfi_b32       v88, v88, v103, v102
        v_bfi_b32       v94, v82, v88, v83
        v_bfi_b32       v102, v81, v94, v100
        v_bfi_b32       v103, v89, v99, v91
        v_xor_b32       v97, v97, v103
        v_xor_b32       v94, v94, v97
        v_bfi_b32       v97, v98, v94, v88
        v_bfi_b32       v91, v98, v81, v91
        v_bfi_b32       v92, v91, v100, v97
        v_bfi_b32       v96, v102, v92, v96
        v_bfi_b32       v90, v90, v84, v100
        v_xor_b32       v95, v96, v90
        v_bfi_b32       v92, v70, v95, v92
        v_xor_b32       v119, v119, v92
        v_bfi_b32       v92, v70, v88, v94
        v_xor_b32       v122, v122, v92
        v_bfi_b32       v88, v88, v94, v103
        v_bfi_b32       v88, v82, v90, v88
        v_bfi_b32       v90, v91, v101, v89
        v_bfi_b32       v88, v70, v88, v90
        v_xor_b32       v52, v52, v88
        v_xor_b32       v88, v89, v98
        v_bfi_b32       v87, v70, v99, v88
        v_xor_b32       v42, v42, v87
		s_setpc_b64 s[100:101]



.S3_S4_B:
        s_getpc_b64 s[28:29]
		s_add_u32 s28,s28,12
		s_addc_u32 s29,s29,0
		s_branch .startLoop

        v_bfi_b32       v99, v84, v93, v87
        v_xor_b32       v99, v82, v99
        v_bfi_b32       v100, v98, v99, v84
        v_xor_b32       v101, v98, v99
        v_bfi_b32       v102, v87, v100, v101
        v_bfi_b32       v103, v99, v93, v84
        v_bfi_b32       v104, v100, v87, v103
        v_bfi_b32       v105, v101, v82, v93
        v_xor_b32       v105, v104, v105
        v_bfi_b32       v97, v93, v105, v102
        v_not_b32       v106, v97
        v_xor_b32       v107, v103, v106
        v_bfi_b32       v102, v101, v102, v107
        v_bfi_b32       v104, v104, v99, v98
        v_xor_b32       v108, v102, v104
        v_bfi_b32       v109, v107, v82, v108
        v_bfi_b32       v97, v84, v98, v97
        v_bfi_b32       v99, v99, v82, v87
        v_bfi_b32       v100, v100, v99, v107
        v_bfi_b32       v100, v109, v97, v100
        v_xor_b32       v107, v108, v97
        v_bfi_b32       v107, v113, v107, v100
        v_xor_b32       v46, v46, v107
        v_bfi_b32       v92, v84, v108, v102
        v_bfi_b32       v96, v87, v103, v99
        v_bfi_b32       v92, v96, v100, v92
        v_bfi_b32       v92, v113, v92, v101
        v_xor_b32       v76, v76, v92
        v_bfi_b32       v92, v104, v98, v102
        v_bfi_b32       v90, v82, v96, v92
        v_xor_b32       v90, v97, v90
        v_xor_b32       v92, v103, v105
        v_bfi_b32       v92, v97, v104, v92
        v_bfi_b32       v90, v113, v92, v90
        v_xor_b32       v40, v40, v90
        v_bfi_b32       v90, v81, v111, v112
        v_bfi_b32       v92, v110, v81, v90
        v_bfi_b32       v96, v92, v70, v110
        v_bfi_b32       v97, v81, v112, v111
        v_xor_b32       v98, v110, v97
        v_bfi_b32       v99, v98, v110, v70
        v_xor_b32       v90, v81, v90
        v_bfi_b32       v99, v90, v99, v96
        v_bfi_b32       v93, v112, v111, v98
        v_bfi_b32       v98, v97, v98, v93
        v_xor_b32       v92, v111, v92
        v_bfi_b32       v89, v70, v92, v81
        v_xor_b32       v89, v93, v89
        v_not_b32       v92, v89
        v_bfi_b32       v87, v70, v98, v92
        v_bfi_b32       v93, v90, v96, v92
        v_xor_b32       v93, v97, v93
        v_not_b32       v95, v93
        v_bfi_b32       v90, v110, v95, v90
        v_xor_b32       v87, v87, v90
        v_xor_b32       v90, v95, v87
        v_xor_b32       v90, v99, v90
        v_bfi_b32       v93, v83, v93, v90
        v_xor_b32       v50, v50, v93
        v_bfi_b32       v90, v83, v90, v95
        v_xor_b32       v44, v44, v90
        v_bfi_b32       v88, v113, v106, v105
        v_xor_b32       v54, v54, v88
        v_bfi_b32       v88, v83, v87, v92
        v_xor_b32       v85, v85, v88
        v_bfi_b32       v87, v83, v89, v87
        v_xor_b32       v78, v78, v87
		s_setpc_b64 s[100:101]



.S5_S6_B:
        v_bfi_b32       v99, v82, v94, v81
        v_not_b32       v100, v99
        v_bfi_b32       v101, v94, v81, v100
        v_xor_b32       v102, v98, v101
        v_xor_b32       v103, v82, v83
        v_xor_b32       v104, v102, v103
        v_bfi_b32       v105, v102, v104, v98
        v_bfi_b32       v106, v105, v99, v83
        v_bfi_b32       v107, v81, v82, v106
        v_bfi_b32       v97, v98, v100, v94
        v_xor_b32       v108, v107, v97
        v_bfi_b32       v109, v102, v108, v103
        v_bfi_b32       v100, v109, v106, v100
        v_bfi_b32       v106, v109, v81, v83
        v_bfi_b32       v105, v106, v83, v105
        v_xor_b32       v109, v108, v105
        v_bfi_b32       v110, v100, v109, v102
        v_bfi_b32       v89, v81, v99, v105
        v_xor_b32       v99, v100, v89
        v_bfi_b32       v91, v104, v99, v82
        v_bfi_b32       v100, v83, v89, v99
        v_bfi_b32       v107, v98, v107, v100
        v_bfi_b32       v110, v107, v110, v91
        v_bfi_b32       v92, v83, v101, v97
        v_bfi_b32       v101, v106, v104, v102
        v_bfi_b32       v92, v100, v101, v92
        v_bfi_b32       v92, v112, v110, v92
        v_xor_b32       v74, v74, v92
        v_bfi_b32       v92, v104, v98, v97
        v_bfi_b32       v97, v99, v92, v107
        v_bfi_b32       v89, v91, v103, v89
        v_bfi_b32       v91, v92, v107, v105
        v_xor_b32       v89, v89, v91
        v_bfi_b32       v89, v112, v89, v97
        v_xor_b32       v77, v77, v89
        v_bfi_b32       v89, v84, v111, v114
        v_xor_b32       v91, v70, v89
        v_bfi_b32       v92, v93, v111, v91
        v_xor_b32       v97, v114, v92
        v_xor_b32       v98, v84, v97
        v_bfi_b32       v100, v111, v98, v97
        v_bfi_b32       v101, v100, v111, v93
        v_bfi_b32       v100, v100, v97, v111
        v_xor_b32       v100, v93, v100
        v_bfi_b32       v102, v98, v92, v100
        v_bfi_b32       v94, v98, v93, v111
        v_bfi_b32       v95, v101, v94, v102
        v_xor_b32       v91, v91, v101
        v_bfi_b32       v101, v91, v94, v100
        v_bfi_b32       v100, v101, v100, v84
        v_not_b32       v103, v98
        v_bfi_b32       v94, v91, v94, v103
        v_bfi_b32       v100, v100, v98, v94
        v_bfi_b32       v87, v70, v100, v97
        v_bfi_b32       v87, v87, v94, v114
        v_xor_b32       v88, v98, v91
        v_xor_b32       v91, v87, v88
        v_xor_b32       v95, v95, v91
        v_xor_b32       v89, v89, v95
        v_bfi_b32       v93, v94, v100, v84
        v_bfi_b32       v94, v93, v95, v89
        v_not_b32       v94, v94
        v_bfi_b32       v89, v113, v89, v94
        v_xor_b32       v41, v41, v89
        v_bfi_b32       v89, v112, v104, v99
        v_xor_b32       v73, v73, v89
        v_bfi_b32       v89, v95, v91, v93
        v_bfi_b32       v87, v92, v102, v87
        v_xor_b32       v87, v89, v87
        v_bfi_b32       v87, v113, v87, v101
        v_xor_b32       v71, v71, v87
        v_bfi_b32       v87, v113, v100, v103
        v_xor_b32       v75, v75, v87
        v_bfi_b32       v87, v112, v108, v109
        v_xor_b32       v45, v45, v87
        v_bfi_b32       v87, v113, v91, v88
        v_xor_b32       v51, v51, v87
		s_setpc_b64 s[100:101]



.S7_S8_B:
        v_bfi_b32       v99, v84, v90, v88
        v_bfi_b32       v100, v81, v84, v106
        v_bfi_b32       v101, v88, v81, v84
        v_xor_b32       v101, v90, v101
        v_bfi_b32       v99, v100, v99, v101
        v_xor_b32       v100, v106, v99
        v_bfi_b32       v102, v101, v84, v100
        v_bfi_b32       v94, v88, v90, v101
        v_bfi_b32       v101, v94, v81, v102
        v_bfi_b32       v94, v106, v94, v84
        v_bfi_b32       v102, v94, v100, v81
        v_bfi_b32       v95, v106, v84, v88
        v_xor_b32       v103, v102, v95
        v_xor_b32       v104, v101, v103
        v_bfi_b32       v93, v84, v104, v95
        v_bfi_b32       v105, v93, v106, v99
        v_bfi_b32       v95, v105, v95, v102
        v_bfi_b32       v95, v103, v95, v99
        v_xor_b32       v93, v94, v93
        v_xor_b32       v94, v100, v93
        v_not_b32       v102, v94
        v_xor_b32       v95, v95, v102
        v_bfi_b32       v95, v82, v95, v102
        v_xor_b32       v49, v49, v95
        v_bfi_b32       v95, v101, v105, v102
        v_xor_b32       v93, v93, v95
        v_bfi_b32       v93, v82, v100, v93
        v_xor_b32       v43, v43, v93
        v_or_b32        v90, v81, v101
        v_xor_b32       v90, v95, v90
        v_bfi_b32       v88, v103, v106, v99
        v_xor_b32       v88, v90, v88
        v_bfi_b32       v88, v82, v94, v88
        v_xor_b32       v63, v63, v88
        v_bfi_b32       v88, v98, v109, v108
        v_bfi_b32       v90, v107, v98, v83
        v_bfi_b32       v88, v109, v90, v88
        v_bfi_b32       v93, v107, v88, v108
        v_bfi_b32       v94, v108, v83, v98
        v_xor_b32       v94, v107, v94
        v_xor_b32       v95, v108, v98
        v_bfi_b32       v99, v94, v93, v95
        v_xor_b32       v100, v109, v83
        v_xor_b32       v101, v99, v100
        v_xor_b32       v102, v98, v101
        v_bfi_b32       v99, v99, v101, v102
        v_not_b32       v105, v109
        v_bfi_b32       v93, v93, v102, v105
        v_bfi_b32       v105, v83, v102, v94
        v_bfi_b32       v100, v100, v95, v105
        v_xor_b32       v90, v90, v100
        v_bfi_b32       v98, v98, v90, v94
        v_xor_b32       v100, v93, v98
        v_xor_b32       v105, v95, v100
        v_xor_b32       v106, v102, v105
        v_bfi_b32       v96, v107, v106, v99
        v_bfi_b32       v89, v95, v109, v102
        v_bfi_b32       v89, v83, v89, v101
        v_xor_b32       v88, v88, v94
        v_bfi_b32       v92, v101, v88, v89
        v_bfi_b32       v92, v92, v108, v96
        v_not_b32       v92, v92
        v_bfi_b32       v92, v70, v92, v96
        v_xor_b32       v65, v65, v92
        v_bfi_b32       v91, v82, v103, v104
        v_xor_b32       v69, v69, v91
        v_bfi_b32       v91, v70, v89, v100
        v_xor_b32       v66, v66, v91
        v_bfi_b32       v89, v98, v105, v89
        v_bfi_b32       v89, v93, v88, v89
        v_bfi_b32       v89, v70, v90, v89
        v_xor_b32       v48, v48, v89
        v_bfi_b32       v87, v70, v88, v101
        v_xor_b32       v38, v38, v87
		s_setpc_b64 s[100:101]



.startLoop:
		/*********************************************/
		/* A 0 */
        v_not_b32       v87, v75
        v_cndmask_b32   v94, v75, v87, s[60:61]
        v_not_b32       v112, v63
        v_cndmask_b32   v115, v63, v112, s[62:63]
        v_cndmask_b32   v111, v75, v87, s[64:65]
        v_xor_b32       v87, v68, v85
        v_xor_b32       v105, s9, v38
        v_xor_b32       v110, v59, v123
        v_xor_b32       v113, s45, v74
        v_xor_b32       v116, s43, v65
        v_xor_b32       v114, s41, v76
        v_xor_b32       v97, v58, v119
        v_xor_b32       v98, 0xfc03fc03, v77
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32       v110, s10, v74
        v_xor_b32       v109, v62, v53
        v_xor_b32       v116, s11, v54
        v_xor_b32       v114, s3, v69
        v_xor_b32       v90, v56, v73
        v_xor_b32       v112, s44, v122
        v_xor_b32       v87, v86, v66
        v_xor_b32       v88, s39, v71
        v_xor_b32       v98, s42, v78
        v_xor_b32       v115, v64, v123
        v_xor_b32       v111, 0xfffc0003, v66
        v_xor_b32       v113, -4, v122
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 12
        v_readlane_b32  s35, v2, 13
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v117, v50, v89, s[34:35]
        v_readlane_b32  s34, v2, 16
        v_readlane_b32  s35, v2, 17
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v112, v50, v89, s[34:35]
        v_xor_b32       v87, s52, v54
        v_xor_b32       v113, s55, v45
        v_xor_b32       v115, s53, v46
        v_xor_b32       v116, v60, v47
        v_xor_b32       v93, s48, v48
        v_xor_b32       v94, v4, v51
        v_xor_b32       v98, v67, v52
        v_xor_b32       v118, s1, v53
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 46
        v_readlane_b32  s35, v2, 47
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_not_b32       v89, v42
        v_readlane_b32  s34, v2, 48
        v_readlane_b32  s35, v2, 49
        v_cndmask_b32   v111, v42, v89, s[34:35]
        v_readlane_b32  s34, v2, 44
        v_readlane_b32  s35, v2, 45
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v110, v42, v89, s[34:35]
        v_xor_b32       v115, s46, v85
        v_xor_b32       v117, v80, v38
        v_xor_b32       v113, s47, v40
        v_xor_b32       v94, v1, v44
        v_xor_b32       v98, s51, v45
        v_xor_b32       v87, 0xc3c3c3c3, v46
        v_xor_b32       v112, 0x33333333, v39
        v_xor_b32       v116, 0xaaaaaaaa, v43
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 1 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[64:65]
        v_not_b32       v89, v34
        v_cndmask_b32   v88, v34, v89, s[66:67]
        v_cndmask_b32   v111, v33, v87, s[68:69]
        v_cndmask_b32   v110, v34, v89, s[70:71]
        v_xor_b32       v89, s41, v6
        v_xor_b32       v81, v58, v29
        v_xor_b32       v82, s40, v30
        v_xor_b32       v83, s44, v31
        v_xor_b32       v87, v79, v35
        v_xor_b32       v92, s42, v36
        v_xor_b32       v98, v61, v37
        v_xor_b32       v84, 0xfffc0003, v32
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v26
        v_readlane_b32  s34, v2, 6
        v_readlane_b32  s35, v2, 7
        v_cndmask_b32   v81, v26, v87, s[34:35]
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v84, v26, v87, s[34:35]
        v_xor_b32       v83, v55, v21
        v_xor_b32       v112, s9, v22
        v_xor_b32       v110, s45, v23
        v_xor_b32       v82, v57, v25
        v_xor_b32       v87, s8, v27
        v_xor_b32       v93, s11, v28
        v_xor_b32       v98, s3, v29
        v_xor_b32       v113, 0xfc03fc03, v30
        v_not_b32       v111, v24
        v_xor_b32       v70, -4, v25
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v18
        v_readlane_b32  s34, v2, 20
        v_readlane_b32  s35, v2, 21
        v_cndmask_b32   v114, v18, v87, s[34:35]
        v_readlane_b32  s34, v2, 22
        v_readlane_b32  s35, v2, 23
        v_cndmask_b32   v82, v18, v87, s[34:35]
        v_xor_b32       v81, s56, v22
        v_xor_b32       v113, s51, v13
        v_xor_b32       v84, s58, v14
        v_xor_b32       v111, v120, v15
        v_xor_b32       v93, s1, v16
        v_xor_b32       v70, s52, v17
        v_xor_b32       v112, v3, v19
        v_xor_b32       v94, s46, v20
        v_xor_b32       v98, s57, v21
        v_xor_b32       v83, 0xaaaaaaaa, v17
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_not_b32       v89, v10
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v81, v10, v89, s[34:35]
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 30
        v_readlane_b32  s35, v2, 31
        v_cndmask_b32   v109, v10, v89, s[34:35]
        v_xor_b32       v70, v60, v14
        v_xor_b32       v82, s53, v37
        v_xor_b32       v84, v5, v6
        v_xor_b32       v90, v4, v7
        v_xor_b32       v88, s48, v8
        v_xor_b32       v107, v80, v11
        v_xor_b32       v108, s49, v12
        v_xor_b32       v98, s47, v13
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B

		/*********************************************/
		/* A 2 */
        v_not_b32       v87, v75
        v_cndmask_b32   v94, v75, v87, s[68:69]
        v_cndmask_b32   v111, v75, v87, s[66:67]
        v_xor_b32       v87, s3, v85
        v_xor_b32       v105, v68, v38
        v_xor_b32       v110, s11, v123
        v_xor_b32       v116, v57, v65
        v_xor_b32       v114, v61, v76
        v_xor_b32       v112, v55, v63
        v_xor_b32       v98, v56, v77
        v_xor_b32       v97, s9, v119
        v_xor_b32       v113, 0xfc03fc03, v74
        v_xor_b32       v115, -4, v63
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_readlane_b32  s34, v2, 4
        v_readlane_b32  s35, v2, 5
        v_cndmask_b32   v112, v122, v87, s[34:35]
        v_not_b32       v89, v66
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v111, v66, v89, s[34:35]
        v_cndmask_b32   v113, v122, v87, s[80:81]
        v_cndmask_b32   v87, v66, v89, s[64:65]
        v_xor_b32       v110, v86, v74
        v_xor_b32       v109, s8, v53
        v_xor_b32       v114, s10, v69
        v_xor_b32       v90, v62, v73
        v_xor_b32       v88, s44, v71
        v_xor_b32       v98, s41, v78
        v_xor_b32       v115, s40, v123
        v_xor_b32       v116, 0xfffc0003, v54
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_cndmask_b32   v117, v50, v89, s[88:89]
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_readlane_b32  s34, v2, 26
        v_readlane_b32  s35, v2, 27
        v_cndmask_b32   v112, v50, v89, s[34:35]
        v_xor_b32       v113, s48, v45
        v_xor_b32       v116, s55, v47
        v_xor_b32       v93, s59, v48
        v_xor_b32       v94, s49, v51
        v_xor_b32       v98, s58, v52
        v_xor_b32       v118, s54, v53
        v_xor_b32       v87, 0xc3c3c3c3, v54
        v_xor_b32       v115, 0x33333333, v46
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v42
        v_readlane_b32  s34, v2, 50
        v_readlane_b32  s35, v2, 51
        v_cndmask_b32   v111, v42, v87, s[34:35]
        v_readlane_b32  s34, v2, 34
        v_readlane_b32  s35, v2, 35
        v_cndmask_b32   v110, v42, v87, s[34:35]
        v_xor_b32       v115, s2, v85
        v_xor_b32       v87, v72, v46
        v_xor_b32       v117, s46, v38
        v_xor_b32       v112, v1, v39
        v_xor_b32       v113, s57, v40
        v_xor_b32       v109, v60, v41
        v_xor_b32       v116, v67, v43
        v_xor_b32       v94, s56, v44
        v_xor_b32       v98, s1, v45
        v_xor_b32       v114, 0xaaaaaaaa, v41
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 3 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[62:63]
        v_readlane_b32  s34, v2, 4
        v_readlane_b32  s35, v2, 5
        v_cndmask_b32   v111, v33, v87, s[34:35]
        v_xor_b32       v89, v64, v6
        v_xor_b32       v81, s41, v29
        v_xor_b32       v82, v86, v30
        v_xor_b32       v83, v58, v31
        v_xor_b32       v84, s3, v32
        v_xor_b32       v110, s43, v34
        v_xor_b32       v87, v121, v35
        v_xor_b32       v98, s40, v37
        v_xor_b32       v88, -4, v34
        v_xor_b32       v92, 0xfffc0003, v36
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[20:21]
        v_not_b32       v89, v26
        v_cndmask_b32   v81, v26, v89, s[82:83]
        v_cndmask_b32   v82, v25, v87, s[76:77]
        v_cndmask_b32   v84, v26, v89, s[60:61]
        v_xor_b32       v83, s44, v21
        v_xor_b32       v112, v61, v22
        v_xor_b32       v110, v79, v23
        v_xor_b32       v111, s39, v24
        v_xor_b32       v87, v57, v27
        v_xor_b32       v93, v68, v28
        v_not_b32       v113, v30
        v_xor_b32       v98, 0xfc03fc03, v29
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_readlane_b32  s34, v2, 30
        v_readlane_b32  s35, v2, 31
        v_cndmask_b32   v114, v18, v89, s[34:35]
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_cndmask_b32   v82, v18, v89, s[30:31]
        v_xor_b32       v81, v120, v22
        v_xor_b32       v113, s57, v13
        v_xor_b32       v84, v3, v14
        v_xor_b32       v111, s47, v15
        v_xor_b32       v112, s56, v19
        v_xor_b32       v98, v80, v21
        v_xor_b32       v93, 0xaaaaaaaa, v16
        v_xor_b32       v94, 0x33333333, v20
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_not_b32       v89, v10
        v_readlane_b32  s34, v2, 40
        v_readlane_b32  s35, v2, 41
        v_cndmask_b32   v81, v10, v89, s[34:35]
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 52
        v_readlane_b32  s35, v2, 53
        v_cndmask_b32   v109, v10, v89, s[34:35]
        v_xor_b32       v70, s51, v14
        v_xor_b32       v82, v4, v37
        v_xor_b32       v84, s58, v6
        v_xor_b32       v90, s52, v7
        v_xor_b32       v88, s54, v8
        v_xor_b32       v107, s53, v11
        v_xor_b32       v98, s59, v13
        v_xor_b32       v108, 0xc3c3c3c3, v12
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 4 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[18:19]
        v_cndmask_b32   v115, v63, v87, s[20:21]
        v_xor_b32       v105, s45, v38
        v_xor_b32       v110, v68, v123
        v_xor_b32       v116, s11, v65
        v_xor_b32       v114, s40, v76
        v_xor_b32       v94, v59, v75
        v_xor_b32       v98, v55, v77
        v_xor_b32       v97, v61, v119
        v_xor_b32       v87, 0xfc03fc03, v85
        v_not_b32       v113, v74
        v_xor_b32       v111, -4, v75
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[74:75]
        v_not_b32       v89, v66
        v_cndmask_b32   v111, v66, v89, s[84:85]
        v_cndmask_b32   v113, v122, v87, s[16:17]
        v_cndmask_b32   v87, v66, v89, s[62:63]
        v_xor_b32       v110, v62, v74
        v_xor_b32       v109, v57, v53
        v_xor_b32       v116, s3, v54
        v_xor_b32       v114, v56, v69
        v_xor_b32       v90, s43, v73
        v_xor_b32       v88, v58, v71
        v_xor_b32       v98, v64, v78
        v_xor_b32       v115, v86, v123
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_readlane_b32  s34, v2, 34
        v_readlane_b32  s35, v2, 35
        v_cndmask_b32   v117, v50, v89, s[34:35]
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v112, v50, v89, s[34:35]
        v_xor_b32       v87, s55, v54
        v_xor_b32       v113, s54, v45
        v_xor_b32       v115, s49, v46
        v_xor_b32       v116, s1, v47
        v_xor_b32       v93, v5, v48
        v_xor_b32       v98, v3, v52
        v_xor_b32       v118, v67, v53
        v_xor_b32       v94, 0xc3c3c3c3, v51
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 50
        v_readlane_b32  s35, v2, 51
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_not_b32       v89, v42
        v_readlane_b32  s34, v2, 44
        v_readlane_b32  s35, v2, 45
        v_cndmask_b32   v111, v42, v89, s[34:35]
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v110, v42, v89, s[34:35]
        v_xor_b32       v115, v1, v85
        v_xor_b32       v87, s48, v46
        v_xor_b32       v112, s50, v39
        v_xor_b32       v113, v80, v40
        v_xor_b32       v116, s2, v43
        v_xor_b32       v94, v120, v44
        v_xor_b32       v117, 0x33333333, v38
        v_xor_b32       v98, 0xaaaaaaaa, v45
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 5 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[72:73]
        v_not_b32       v89, v34
        v_cndmask_b32   v88, v34, v89, s[20:21]
        v_cndmask_b32   v111, v33, v87, s[74:75]
        v_readlane_b32  s34, v2, 4
        v_readlane_b32  s35, v2, 5
        v_cndmask_b32   v110, v34, v89, s[34:35]
        v_xor_b32       v89, s10, v6
        v_xor_b32       v81, v64, v29
        v_xor_b32       v82, v62, v30
        v_xor_b32       v83, s41, v31
        v_xor_b32       v87, s8, v35
        v_xor_b32       v92, s3, v36
        v_xor_b32       v98, v86, v37
        v_xor_b32       v84, 0xfc03fc03, v32
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v26
        v_cndmask_b32   v81, v26, v87, s[86:87]
        v_cndmask_b32   v84, v26, v87, s[18:19]
        v_xor_b32       v113, s39, v30
        v_xor_b32       v83, v58, v21
        v_xor_b32       v112, s40, v22
        v_xor_b32       v110, v121, v23
        v_xor_b32       v82, v68, v25
        v_xor_b32       v87, s11, v27
        v_xor_b32       v93, s45, v28
        v_xor_b32       v111, -4, v24
        v_xor_b32       v70, 0xfffc0003, v25
        v_not_b32       v98, v29
        s_swappc_b64 s[100:101], s[28:29]

        v_xor_b32       v81, s47, v22
        v_xor_b32       v113, v80, v13
        v_xor_b32       v84, s56, v14
        v_xor_b32       v111, s59, v15
        v_xor_b32       v93, s46, v16
        v_xor_b32       v70, s51, v17
        v_xor_b32       v114, v1, v18
        v_xor_b32       v112, v120, v19
        v_xor_b32       v94, s49, v20
        v_xor_b32       v98, s53, v21
        v_xor_b32       v83, 0x33333333, v17
        v_xor_b32       v82, 0xaaaaaaaa, v18
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 40
        v_readlane_b32  s35, v2, 41
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_not_b32       v89, v10
        v_readlane_b32  s34, v2, 16
        v_readlane_b32  s35, v2, 17
        v_cndmask_b32   v81, v10, v89, s[34:35]
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v109, v10, v89, s[34:35]
        v_xor_b32       v70, s57, v14
        v_xor_b32       v82, s52, v37
        v_xor_b32       v84, v3, v6
        v_xor_b32       v90, v60, v7
        v_xor_b32       v88, v67, v8
        v_xor_b32       v107, v4, v11
        v_xor_b32       v108, s55, v12
        v_xor_b32       v98, v5, v13
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 6 */
        v_not_b32       v87, v75
        v_cndmask_b32   v94, v75, v87, s[74:75]
        v_cndmask_b32   v111, v75, v87, s[20:21]
        v_xor_b32       v105, v79, v38
        v_xor_b32       v110, s45, v123
        v_xor_b32       v113, s39, v74
        v_xor_b32       v116, v68, v65
        v_xor_b32       v114, v86, v76
        v_xor_b32       v112, v58, v63
        v_xor_b32       v98, s44, v77
        v_xor_b32       v97, s40, v119
        v_not_b32       v87, v85
        v_xor_b32       v115, 0xfffc0003, v63
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[78:79]
        v_not_b32       v89, v66
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v111, v66, v89, s[34:35]
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v113, v122, v87, s[34:35]
        v_cndmask_b32   v87, v66, v89, s[72:73]
        v_xor_b32       v110, s43, v74
        v_xor_b32       v109, s11, v53
        v_xor_b32       v114, v55, v69
        v_xor_b32       v90, v59, v73
        v_xor_b32       v88, s41, v71
        v_xor_b32       v98, s10, v78
        v_xor_b32       v115, v62, v123
        v_xor_b32       v116, 0xfc03fc03, v54
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 40
        v_readlane_b32  s35, v2, 41
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v117, v50, v89, s[34:35]
        v_cndmask_b32   v114, v49, v87, s[24:25]
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v112, v50, v89, s[34:35]
        v_xor_b32       v87, s1, v54
        v_xor_b32       v113, v67, v45
        v_xor_b32       v93, s58, v48
        v_xor_b32       v94, s55, v51
        v_xor_b32       v98, s56, v52
        v_xor_b32       v118, s2, v53
        v_xor_b32       v115, 0xc3c3c3c3, v46
        v_xor_b32       v116, 0xaaaaaaaa, v47
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v42
        v_cndmask_b32   v111, v42, v87, s[22:23]
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v110, v42, v87, s[34:35]
        v_xor_b32       v115, s50, v85
        v_xor_b32       v87, s54, v46
        v_xor_b32       v117, s49, v38
        v_xor_b32       v112, v72, v39
        v_xor_b32       v113, s53, v40
        v_xor_b32       v109, s57, v41
        v_xor_b32       v116, v1, v43
        v_xor_b32       v94, s47, v44
        v_xor_b32       v98, s46, v45
        v_xor_b32       v114, 0x33333333, v41
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 7 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[76:77]
        v_cndmask_b32   v111, v33, v87, s[78:79]
        v_xor_b32       v89, v56, v6
        v_xor_b32       v81, s10, v29
        v_xor_b32       v82, s43, v30
        v_xor_b32       v83, v64, v31
        v_xor_b32       v110, s9, v34
        v_xor_b32       v87, v57, v35
        v_xor_b32       v98, v62, v37
        v_not_b32       v84, v32
        v_xor_b32       v88, 0xfffc0003, v34
        v_xor_b32       v92, 0xfc03fc03, v36
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[14:15]
        v_not_b32       v89, v26
        v_cndmask_b32   v81, v26, v89, s[64:65]
        v_cndmask_b32   v82, v25, v87, s[82:83]
        v_cndmask_b32   v84, v26, v89, s[80:81]
        v_xor_b32       v83, s41, v21
        v_xor_b32       v112, v86, v22
        v_xor_b32       v110, s8, v23
        v_xor_b32       v111, s42, v24
        v_xor_b32       v87, v68, v27
        v_xor_b32       v93, v79, v28
        v_xor_b32       v98, s39, v29
        v_xor_b32       v113, -4, v30
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 44
        v_readlane_b32  s35, v2, 45
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v114, v18, v89, s[34:35]
        v_readlane_b32  s34, v2, 12
        v_readlane_b32  s35, v2, 13
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v82, v18, v89, s[34:35]
        v_xor_b32       v81, s59, v22
        v_xor_b32       v113, s53, v13
        v_xor_b32       v84, v120, v14
        v_xor_b32       v111, v5, v15
        v_xor_b32       v112, s47, v19
        v_xor_b32       v98, v4, v21
        v_xor_b32       v93, 0x33333333, v16
        v_xor_b32       v94, 0xc3c3c3c3, v20
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 16
        v_readlane_b32  s35, v2, 17
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_not_b32       v89, v10
        v_readlane_b32  s34, v2, 20
        v_readlane_b32  s35, v2, 21
        v_cndmask_b32   v81, v10, v89, s[34:35]
        v_cndmask_b32   v83, v9, v87, s[24:25]
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v109, v10, v89, s[34:35]
        v_xor_b32       v70, v80, v14
        v_xor_b32       v82, v60, v37
        v_xor_b32       v84, s56, v6
        v_xor_b32       v90, s51, v7
        v_xor_b32       v88, s2, v8
        v_xor_b32       v107, s52, v11
        v_xor_b32       v108, s1, v12
        v_xor_b32       v98, s58, v13
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 8 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[74:75]
        v_not_b32       v89, v75
        v_readlane_b32  s34, v2, 6
        v_readlane_b32  s35, v2, 7
        v_cndmask_b32   v94, v75, v89, s[34:35]
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v115, v63, v87, s[34:35]
        v_cndmask_b32   v111, v75, v89, s[16:17]
        v_xor_b32       v87, v55, v85
        v_xor_b32       v113, s44, v74
        v_xor_b32       v116, s3, v65
        v_xor_b32       v114, v121, v76
        v_xor_b32       v98, v59, v77
        v_xor_b32       v97, v79, v119
        v_not_b32       v105, v38
        v_xor_b32       v110, 0xfc03fc03, v123
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[82:83]
        v_not_b32       v89, v66
        v_cndmask_b32   v111, v66, v89, s[70:71]
        v_cndmask_b32   v113, v122, v87, s[12:13]
        v_cndmask_b32   v87, v66, v89, s[20:21]
        v_xor_b32       v110, v57, v74
        v_xor_b32       v116, v56, v54
        v_xor_b32       v114, s43, v69
        v_xor_b32       v90, s11, v73
        v_xor_b32       v88, v61, v71
        v_xor_b32       v98, v86, v78
        v_xor_b32       v115, s8, v123
        v_xor_b32       v109, 0xfffc0003, v53
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_xor_b32       v87, s54, v54
        v_xor_b32       v113, s58, v45
        v_xor_b32       v115, v72, v46
        v_xor_b32       v116, v67, v47
        v_xor_b32       v93, v4, v48
        v_xor_b32       v112, s53, v50
        v_xor_b32       v94, s48, v51
        v_xor_b32       v98, v60, v52
        v_xor_b32       v118, v3, v53
        v_xor_b32       v117, 0xc3c3c3c3, v50
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v42
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v111, v42, v87, s[34:35]
        v_readlane_b32  s34, v2, 22
        v_readlane_b32  s35, v2, 23
        v_cndmask_b32   v110, v42, v87, s[34:35]
        v_xor_b32       v115, v120, v85
        v_xor_b32       v87, v5, v46
        v_xor_b32       v117, s50, v38
        v_xor_b32       v112, s47, v39
        v_xor_b32       v114, v1, v41
        v_xor_b32       v116, s56, v43
        v_xor_b32       v94, s57, v44
        v_xor_b32       v98, s2, v45
        v_xor_b32       v113, 0x33333333, v40
        v_xor_b32       v109, 0xaaaaaaaa, v41
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 9 */
        v_not_b32       v87, v34
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v88, v34, v87, s[34:35]
        v_readlane_b32  s34, v2, 6
        v_readlane_b32  s35, v2, 7
        v_cndmask_b32   v110, v34, v87, s[34:35]
        v_xor_b32       v89, v62, v6
        v_xor_b32       v81, v86, v29
        v_xor_b32       v82, v57, v30
        v_xor_b32       v83, s40, v31
        v_xor_b32       v84, v55, v32
        v_xor_b32       v111, s45, v33
        v_xor_b32       v87, s42, v35
        v_xor_b32       v92, v56, v36
        v_xor_b32       v98, s8, v37
        v_xor_b32       v70, 0xfffc0003, v33
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v26
        v_cndmask_b32   v81, v26, v87, s[66:67]
        v_cndmask_b32   v84, v26, v87, s[74:75]
        v_xor_b32       v113, v58, v30
        v_xor_b32       v83, v61, v21
        v_xor_b32       v112, v121, v22
        v_xor_b32       v111, s41, v24
        v_xor_b32       v70, s10, v25
        v_xor_b32       v87, s3, v27
        v_xor_b32       v98, s44, v29
        v_xor_b32       v110, -4, v23
        v_xor_b32       v82, 0xfc03fc03, v25
        v_not_b32       v93, v28
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v18
        v_readlane_b32  s34, v2, 48
        v_readlane_b32  s35, v2, 49
        v_cndmask_b32   v114, v18, v87, s[34:35]
        v_readlane_b32  s34, v2, 30
        v_readlane_b32  s35, v2, 31
        v_cndmask_b32   v82, v18, v87, s[34:35]
        v_xor_b32       v81, v80, v22
        v_xor_b32       v84, s51, v14
        v_xor_b32       v111, s53, v15
        v_xor_b32       v93, v1, v16
        v_xor_b32       v83, s50, v17
        v_xor_b32       v112, s57, v19
        v_xor_b32       v94, v72, v20
        v_xor_b32       v98, s49, v21
        v_xor_b32       v113, 0x33333333, v13
        v_xor_b32       v70, 0xaaaaaaaa, v17
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_not_b32       v89, v10
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v81, v10, v89, s[34:35]
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 26
        v_readlane_b32  s35, v2, 27
        v_cndmask_b32   v109, v10, v89, s[34:35]
        v_xor_b32       v70, s46, v14
        v_xor_b32       v82, s55, v37
        v_xor_b32       v84, v60, v6
        v_xor_b32       v90, s1, v7
        v_xor_b32       v88, v3, v8
        v_xor_b32       v108, s54, v12
        v_xor_b32       v98, v4, v13
        v_xor_b32       v107, 0xc3c3c3c3, v11
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 10 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[78:79]
        v_not_b32       v89, v75
        v_cndmask_b32   v94, v75, v89, s[82:83]
        v_cndmask_b32   v115, v63, v87, s[84:85]
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v111, v75, v89, s[34:35]
        v_xor_b32       v87, s44, v85
        v_xor_b32       v105, s39, v38
        v_xor_b32       v113, v58, v74
        v_xor_b32       v114, s8, v76
        v_xor_b32       v98, s9, v77
        v_xor_b32       v97, v121, v119
        v_not_b32       v110, v123
        v_xor_b32       v116, 0xfc03fc03, v65
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[86:87]
        v_cndmask_b32   v113, v122, v87, s[26:27]
        v_xor_b32       v110, s11, v74
        v_xor_b32       v109, s3, v53
        v_xor_b32       v116, v55, v54
        v_xor_b32       v114, v59, v69
        v_xor_b32       v90, v68, v73
        v_xor_b32       v111, s43, v66
        v_xor_b32       v88, s40, v71
        v_xor_b32       v98, v62, v78
        v_xor_b32       v115, v57, v123
        v_xor_b32       v87, 0xfffc0003, v66
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_readlane_b32  s34, v2, 22
        v_readlane_b32  s35, v2, 23
        v_cndmask_b32   v117, v50, v89, s[34:35]
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_readlane_b32  s34, v2, 34
        v_readlane_b32  s35, v2, 35
        v_cndmask_b32   v112, v50, v89, s[34:35]
        v_xor_b32       v87, v67, v54
        v_xor_b32       v113, v3, v45
        v_xor_b32       v115, s48, v46
        v_xor_b32       v116, s2, v47
        v_xor_b32       v93, s52, v48
        v_xor_b32       v94, s54, v51
        v_xor_b32       v98, s51, v52
        v_xor_b32       v118, s56, v53
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_xor_b32       v115, s47, v85
        v_xor_b32       v87, s58, v46
        v_xor_b32       v117, v72, v38
        v_xor_b32       v112, s59, v39
        v_xor_b32       v113, s49, v40
        v_xor_b32       v110, s1, v42
        v_xor_b32       v116, v120, v43
        v_xor_b32       v94, v80, v44
        v_xor_b32       v98, v1, v45
        v_xor_b32       v111, 0x33333333, v42
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 11 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[14:15]
        v_not_b32       v89, v34
        v_cndmask_b32   v88, v34, v89, s[84:85]
        v_cndmask_b32   v111, v33, v87, s[86:87]
        v_cndmask_b32   v110, v34, v89, s[82:83]
        v_xor_b32       v89, s43, v6
        v_xor_b32       v81, v62, v29
        v_xor_b32       v82, s11, v30
        v_xor_b32       v83, v86, v31
        v_xor_b32       v84, s44, v32
        v_xor_b32       v92, v55, v36
        v_xor_b32       v98, v57, v37
        v_xor_b32       v87, 0xfffc0003, v35
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v82, v25
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v70, v25, v82, s[34:35]
        v_xor_b32       v113, s41, v30
        v_xor_b32       v83, s40, v21
        v_xor_b32       v112, s8, v22
        v_xor_b32       v110, s42, v23
        v_xor_b32       v111, v64, v24
        v_xor_b32       v84, v61, v26
        v_xor_b32       v93, s39, v28
        v_xor_b32       v98, v58, v29
        v_xor_b32       v81, -4, v26
        v_xor_b32       v87, 0xfc03fc03, v27
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_readlane_b32  s34, v2, 26
        v_readlane_b32  s35, v2, 27
        v_cndmask_b32   v114, v18, v89, s[34:35]
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_readlane_b32  s34, v2, 52
        v_readlane_b32  s35, v2, 53
        v_cndmask_b32   v82, v18, v89, s[34:35]
        v_xor_b32       v81, s53, v22
        v_xor_b32       v113, s49, v13
        v_xor_b32       v84, s57, v14
        v_xor_b32       v111, v4, v15
        v_xor_b32       v93, s50, v16
        v_xor_b32       v112, v80, v19
        v_xor_b32       v94, s48, v20
        v_xor_b32       v98, 0xc3c3c3c3, v21
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_not_b32       v89, v10
        v_cndmask_b32   v81, v10, v89, s[24:25]
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v109, v10, v89, s[34:35]
        v_xor_b32       v82, s1, v37
        v_xor_b32       v84, s51, v6
        v_xor_b32       v88, s56, v8
        v_xor_b32       v107, s55, v11
        v_xor_b32       v108, v67, v12
        v_xor_b32       v98, s52, v13
        v_xor_b32       v70, 0x33333333, v14
        v_xor_b32       v90, 0xaaaaaaaa, v7
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 12 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[12:13]
        v_not_b32       v89, v75
        v_cndmask_b32   v94, v75, v89, s[86:87]
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v115, v63, v87, s[34:35]
        v_cndmask_b32   v111, v75, v89, s[84:85]
        v_xor_b32       v87, v58, v85
        v_xor_b32       v110, s39, v123
        v_xor_b32       v113, s41, v74
        v_xor_b32       v114, v57, v76
        v_xor_b32       v98, v61, v77
        v_xor_b32       v97, s8, v119
        v_xor_b32       v105, -4, v38
        v_not_b32       v116, v65
        s_swappc_b64 s[100:101], s[98:99]

		v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[64:65]
        v_not_b32       v89, v66
        v_readlane_b32  s34, v2, 4
        v_readlane_b32  s35, v2, 5
        v_cndmask_b32   v111, v66, v89, s[34:35]
        v_cndmask_b32   v113, v122, v87, s[70:71]
        v_cndmask_b32   v87, v66, v89, s[14:15]
        v_xor_b32       v110, v68, v74
        v_xor_b32       v116, s44, v54
        v_xor_b32       v114, s9, v69
        v_xor_b32       v90, s45, v73
        v_xor_b32       v88, v86, v71
        v_xor_b32       v98, s43, v78
        v_xor_b32       v115, s11, v123
        v_xor_b32       v109, 0xfc03fc03, v53
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_cndmask_b32   v117, v50, v89, s[30:31]
        v_readlane_b32  s34, v2, 50
        v_readlane_b32  s35, v2, 51
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v112, v50, v89, s[34:35]
        v_xor_b32       v87, s2, v54
        v_xor_b32       v113, s56, v45
        v_xor_b32       v115, s54, v46
        v_xor_b32       v116, v1, v47
        v_xor_b32       v93, v60, v48
        v_xor_b32       v94, v67, v51
        v_xor_b32       v98, s57, v52
        v_xor_b32       v118, v120, v53
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32       v115, s59, v85
        v_xor_b32       v87, v3, v46
        v_xor_b32       v117, s48, v38
        v_xor_b32       v112, v5, v39
        v_xor_b32       v111, s49, v42
        v_xor_b32       v114, v72, v41
        v_xor_b32       v116, s47, v43
        v_xor_b32       v94, s53, v44
        v_xor_b32       v98, s50, v45
        v_xor_b32       v113, 0xc3c3c3c3, v40
        v_xor_b32       v109, 0x33333333, v41
        v_xor_b32       v110, 0xaaaaaaaa, v42
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 13 */
        v_not_b32       v87, v34
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v88, v34, v87, s[34:35]
        v_cndmask_b32   v110, v34, v87, s[86:87]
        v_xor_b32       v89, v59, v6
        v_xor_b32       v81, s43, v29
        v_xor_b32       v82, v68, v30
        v_xor_b32       v83, v62, v31
        v_xor_b32       v84, v58, v32
        v_xor_b32       v111, v121, v33
        v_xor_b32       v87, s3, v35
        v_xor_b32       v92, s44, v36
        v_xor_b32       v98, s11, v37
        v_xor_b32       v70, 0xfc03fc03, v33
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[60:61]
        v_not_b32       v89, v26
        v_cndmask_b32   v81, v26, v89, s[20:21]
        v_cndmask_b32   v82, v25, v87, s[66:67]
        v_cndmask_b32   v84, v26, v89, s[12:13]
        v_xor_b32       v113, v64, v30
        v_xor_b32       v83, v86, v21
        v_xor_b32       v112, v57, v22
        v_xor_b32       v111, s10, v24
        v_xor_b32       v98, s41, v29
        v_xor_b32       v110, 0xfffc0003, v23
        v_not_b32       v87, v27
        v_xor_b32       v93, -4, v28
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v18
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v114, v18, v87, s[34:35]
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v82, v18, v87, s[34:35]
        v_xor_b32       v81, v4, v22
        v_xor_b32       v84, v80, v14
        v_xor_b32       v111, s52, v15
        v_xor_b32       v93, v72, v16
        v_xor_b32       v83, s48, v17
        v_xor_b32       v112, s53, v19
        v_xor_b32       v94, s54, v20
        v_xor_b32       v98, s55, v21
        v_xor_b32       v113, 0xc3c3c3c3, v13
        v_xor_b32       v70, 0x33333333, v17
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_cndmask_b32   v106, v9, v87, s[24:25]
        v_not_b32       v89, v10
        v_readlane_b32  s34, v2, 46
        v_readlane_b32  s35, v2, 47
        v_cndmask_b32   v81, v10, v89, s[34:35]
        v_readlane_b32  s34, v2, 50
        v_readlane_b32  s35, v2, 51
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v109, v10, v89, s[34:35]
        v_xor_b32       v70, s49, v14
        v_xor_b32       v84, s57, v6
        v_xor_b32       v90, s46, v7
        v_xor_b32       v88, v120, v8
        v_xor_b32       v107, s1, v11
        v_xor_b32       v108, s2, v12
        v_xor_b32       v98, v60, v13
        v_xor_b32       v82, 0xaaaaaaaa, v37
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 14 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[26:27]
        v_not_b32       v89, v75
        v_cndmask_b32   v94, v75, v89, s[64:65]
        v_cndmask_b32   v115, v63, v87, s[60:61]
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v111, v75, v89, s[34:35]
        v_xor_b32       v87, s41, v85
        v_xor_b32       v105, s42, v38
        v_xor_b32       v113, v64, v74
        v_xor_b32       v116, s39, v65
        v_xor_b32       v114, s11, v76
        v_xor_b32       v98, s40, v77
        v_xor_b32       v97, v57, v119
        v_xor_b32       v110, -4, v123
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[62:63]
        v_cndmask_b32   v113, v122, v87, s[68:69]
        v_xor_b32       v110, s45, v74
        v_xor_b32       v116, v58, v54
        v_xor_b32       v114, v61, v69
        v_xor_b32       v90, v79, v73
        v_xor_b32       v111, s9, v66
        v_xor_b32       v88, v62, v71
        v_xor_b32       v98, v59, v78
        v_xor_b32       v115, v68, v123
        v_not_b32       v109, v53
        v_xor_b32       v87, 0xfc03fc03, v66
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_cndmask_b32   v88, v49, v87, s[24:25]
        v_readlane_b32  s34, v2, 44
        v_readlane_b32  s35, v2, 45
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_xor_b32       v87, v1, v54
        v_xor_b32       v113, v120, v45
        v_xor_b32       v115, v67, v46
        v_xor_b32       v116, s50, v47
        v_xor_b32       v93, s51, v48
        v_xor_b32       v112, v60, v50
        v_xor_b32       v94, s2, v51
        v_xor_b32       v98, v80, v52
        v_xor_b32       v118, s47, v53
        v_xor_b32       v117, 0xaaaaaaaa, v50
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 12
        v_readlane_b32  s35, v2, 13
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 40
        v_readlane_b32  s35, v2, 41
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_xor_b32       v115, v5, v85
        v_xor_b32       v87, s56, v46
        v_xor_b32       v117, s54, v38
        v_xor_b32       v112, s58, v39
        v_xor_b32       v113, s55, v40
        v_xor_b32       v110, s46, v42
        v_xor_b32       v116, s59, v43
        v_xor_b32       v94, v4, v44
        v_xor_b32       v98, v72, v45
        v_xor_b32       v111, 0xc3c3c3c3, v42
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 15 */
        v_not_b32       v87, v33
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v70, v33, v87, s[34:35]
        v_not_b32       v110, v34
        v_cndmask_b32   v88, v34, v110, s[70:71]
        v_cndmask_b32   v111, v33, v87, s[66:67]
        v_xor_b32       v89, s11, v6
        v_xor_b32       v81, v57, v29
        v_xor_b32       v82, s3, v30
        v_xor_b32       v83, s8, v31
        v_xor_b32       v84, s9, v32
        v_xor_b32       v87, s10, v35
        v_xor_b32       v92, v59, v36
        v_xor_b32       v98, 0xfffc0003, v37
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[68:69]
        v_not_b32       v89, v26
        v_cndmask_b32   v81, v26, v89, s[16:17]
        v_cndmask_b32   v82, v25, v87, s[18:19]
        v_cndmask_b32   v84, v26, v89, s[86:87]
        v_xor_b32       v113, s40, v30
        v_xor_b32       v83, v121, v21
        v_xor_b32       v112, s42, v22
        v_xor_b32       v110, v64, v23
        v_xor_b32       v111, v86, v24
        v_xor_b32       v87, v55, v27
        v_xor_b32       v93, v58, v28
        v_xor_b32       v98, v61, v29
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 52
        v_readlane_b32  s35, v2, 53
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_cndmask_b32   v114, v18, v89, s[22:23]
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_readlane_b32  s34, v2, 48
        v_readlane_b32  s35, v2, 49
        v_cndmask_b32   v82, v18, v89, s[34:35]
        v_xor_b32       v81, s49, v22
        v_xor_b32       v113, v72, v13
        v_xor_b32       v84, s46, v14
        v_xor_b32       v93, s47, v16
        v_xor_b32       v94, v5, v20
        v_xor_b32       v98, s48, v21
        v_xor_b32       v111, 0xc3c3c3c3, v15
        v_xor_b32       v112, 0x33333333, v19
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B

        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_not_b32       v89, v10
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v81, v10, v89, s[34:35]
        v_cndmask_b32   v83, v9, v87, s[30:31]
        v_cndmask_b32   v109, v10, v89, s[88:89]
        v_xor_b32       v70, s50, v14
        v_xor_b32       v82, v67, v37
        v_xor_b32       v90, s2, v7
        v_xor_b32       v88, s51, v8
        v_xor_b32       v107, s54, v11
        v_xor_b32       v108, v3, v12
        v_xor_b32       v98, s55, v13
        v_xor_b32       v84, 0xaaaaaaaa, v6
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
        
		/*********************************************/
	    s_cmp_eq_i32    s32, 1
        s_cbranch_scc1  .quitLoop
		/*********************************************/

		/*********************************************/
		/* B 0 */
        v_not_b32       v87, v34
        v_cndmask_b32   v88, v34, v87, s[60:61]
        v_not_b32       v70, v33
        v_cndmask_b32   v111, v33, v70, s[62:63]
        v_cndmask_b32   v110, v34, v87, s[64:65]
        v_xor_b32       v89, s9, v6
        v_xor_b32       v81, v59, v29
        v_xor_b32       v82, s45, v30
        v_xor_b32       v83, s43, v31
        v_xor_b32       v84, s41, v32
        v_xor_b32       v92, v58, v36
        v_xor_b32       v98, v68, v37
        v_xor_b32       v87, 0xfc03fc03, v35
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32       v113, s10, v30
        v_xor_b32       v83, v62, v21
        v_xor_b32       v112, s11, v22
        v_xor_b32       v110, s3, v23
        v_xor_b32       v111, v56, v24
        v_xor_b32       v70, s44, v25
        v_xor_b32       v84, v86, v26
        v_xor_b32       v87, s39, v27
        v_xor_b32       v93, s42, v28
        v_xor_b32       v98, v64, v29
        v_xor_b32       v81, 0xfffc0003, v26
        v_xor_b32       v82, -4, v25
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 12
        v_readlane_b32  s35, v2, 13
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v114, v18, v89, s[34:35]
        v_readlane_b32  s34, v2, 16
        v_readlane_b32  s35, v2, 17
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v82, v18, v89, s[34:35]
        v_xor_b32       v81, s52, v22
        v_xor_b32       v113, s55, v13
        v_xor_b32       v84, s53, v14
        v_xor_b32       v111, v60, v15
        v_xor_b32       v93, s48, v16
        v_xor_b32       v112, v4, v19
        v_xor_b32       v94, v67, v20
        v_xor_b32       v98, s1, v21
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 46
        v_readlane_b32  s35, v2, 47
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_not_b32       v89, v10
        v_readlane_b32  s34, v2, 48
        v_readlane_b32  s35, v2, 49
        v_cndmask_b32   v81, v10, v89, s[34:35]
        v_readlane_b32  s34, v2, 44
        v_readlane_b32  s35, v2, 45
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v109, v10, v89, s[34:35]
        v_xor_b32       v82, s46, v37
        v_xor_b32       v84, v80, v6
        v_xor_b32       v88, s47, v8
        v_xor_b32       v108, v1, v12
        v_xor_b32       v98, s51, v13
        v_xor_b32       v70, 0xc3c3c3c3, v14
        v_xor_b32       v90, 0x33333333, v7
        v_xor_b32       v107, 0xaaaaaaaa, v11
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 1 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[64:65]
        v_not_b32       v89, v75
        v_cndmask_b32   v94, v75, v89, s[66:67]
        v_cndmask_b32   v115, v63, v87, s[68:69]
        v_cndmask_b32   v111, v75, v89, s[70:71]
        v_xor_b32       v87, v61, v85
        v_xor_b32       v105, s41, v38
        v_xor_b32       v110, v58, v123
        v_xor_b32       v113, s40, v74
        v_xor_b32       v116, s44, v65
        v_xor_b32       v98, v79, v77
        v_xor_b32       v97, s42, v119
        v_xor_b32       v114, 0xfffc0003, v76
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v66
        v_readlane_b32  s34, v2, 6
        v_readlane_b32  s35, v2, 7
        v_cndmask_b32   v111, v66, v87, s[34:35]
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v87, v66, v87, s[34:35]
        v_xor_b32       v109, v55, v53
        v_xor_b32       v116, s9, v54
        v_xor_b32       v114, s45, v69
        v_xor_b32       v113, v57, v122
        v_xor_b32       v88, s8, v71
        v_xor_b32       v98, s11, v78
        v_xor_b32       v115, s3, v123
        v_xor_b32       v110, 0xfc03fc03, v74
        v_not_b32       v90, v73
        v_xor_b32       v112, -4, v122
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v50
        v_readlane_b32  s34, v2, 20
        v_readlane_b32  s35, v2, 21
        v_cndmask_b32   v117, v50, v87, s[34:35]
        v_readlane_b32  s34, v2, 22
        v_readlane_b32  s35, v2, 23
        v_cndmask_b32   v112, v50, v87, s[34:35]
        v_xor_b32       v87, s56, v54
        v_xor_b32       v113, s51, v45
        v_xor_b32       v115, s58, v46
        v_xor_b32       v116, v120, v47
        v_xor_b32       v93, s1, v48
        v_xor_b32       v88, s52, v49
        v_xor_b32       v94, v3, v51
        v_xor_b32       v98, s46, v52
        v_xor_b32       v118, s57, v53
        v_xor_b32       v114, 0xaaaaaaaa, v49
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_not_b32       v89, v42
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v111, v42, v89, s[34:35]
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 30
        v_readlane_b32  s35, v2, 31
        v_cndmask_b32   v110, v42, v89, s[34:35]
        v_xor_b32       v115, s53, v85
        v_xor_b32       v87, v60, v46
        v_xor_b32       v117, v5, v38
        v_xor_b32       v112, v4, v39
        v_xor_b32       v113, s48, v40
        v_xor_b32       v116, v80, v43
        v_xor_b32       v94, s49, v44
        v_xor_b32       v98, s47, v45
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 2 */
        v_not_b32       v87, v34
        v_cndmask_b32   v88, v34, v87, s[68:69]
        v_cndmask_b32   v110, v34, v87, s[66:67]
        v_xor_b32       v89, v68, v6
        v_xor_b32       v81, s11, v29
        v_xor_b32       v83, v57, v31
        v_xor_b32       v84, v61, v32
        v_xor_b32       v70, v55, v33
        v_xor_b32       v87, v56, v35
        v_xor_b32       v92, s9, v36
        v_xor_b32       v98, s3, v37
        v_xor_b32       v82, 0xfc03fc03, v30
        v_xor_b32       v111, -4, v33
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_readlane_b32  s34, v2, 4
        v_readlane_b32  s35, v2, 5
        v_cndmask_b32   v70, v25, v87, s[34:35]
        v_not_b32       v89, v26
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v81, v26, v89, s[34:35]
        v_cndmask_b32   v82, v25, v87, s[80:81]
        v_cndmask_b32   v84, v26, v89, s[64:65]
        v_xor_b32       v113, v86, v30
        v_xor_b32       v83, s8, v21
        v_xor_b32       v110, s10, v23
        v_xor_b32       v111, v62, v24
        v_xor_b32       v87, s44, v27
        v_xor_b32       v93, s41, v28
        v_xor_b32       v98, s40, v29
        v_xor_b32       v112, 0xfffc0003, v22
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_cndmask_b32   v114, v18, v89, s[88:89]
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_readlane_b32  s34, v2, 26
        v_readlane_b32  s35, v2, 27
        v_cndmask_b32   v82, v18, v89, s[34:35]
        v_xor_b32       v113, s48, v13
        v_xor_b32       v111, s55, v15
        v_xor_b32       v93, s59, v16
        v_xor_b32       v112, s49, v19
        v_xor_b32       v94, s58, v20
        v_xor_b32       v98, s54, v21
        v_xor_b32       v81, 0xc3c3c3c3, v22
        v_xor_b32       v84, 0x33333333, v14
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v10
        v_readlane_b32  s34, v2, 50
        v_readlane_b32  s35, v2, 51
        v_cndmask_b32   v81, v10, v87, s[34:35]
        v_readlane_b32  s34, v2, 34
        v_readlane_b32  s35, v2, 35
        v_cndmask_b32   v109, v10, v87, s[34:35]
        v_xor_b32       v70, v72, v14
        v_xor_b32       v82, s2, v37
        v_xor_b32       v84, s46, v6
        v_xor_b32       v90, v1, v7
        v_xor_b32       v88, s57, v8
        v_xor_b32       v106, v60, v9
        v_xor_b32       v107, v67, v11
        v_xor_b32       v108, s56, v12
        v_xor_b32       v98, s1, v13
        v_xor_b32       v83, 0xaaaaaaaa, v9
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 3 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[62:63]
        v_readlane_b32  s34, v2, 4
        v_readlane_b32  s35, v2, 5
        v_cndmask_b32   v115, v63, v87, s[34:35]
        v_xor_b32       v87, s40, v85
        v_xor_b32       v105, v64, v38
        v_xor_b32       v110, s41, v123
        v_xor_b32       v113, v86, v74
        v_xor_b32       v116, v58, v65
        v_xor_b32       v114, s3, v76
        v_xor_b32       v111, s43, v75
        v_xor_b32       v98, v121, v77
        v_xor_b32       v94, -4, v75
        v_xor_b32       v97, 0xfffc0003, v119
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[20:21]
		v_not_b32       v89, v66
        v_cndmask_b32   v111, v66, v89, s[82:83]
        v_cndmask_b32   v113, v122, v87, s[76:77]
        v_cndmask_b32   v87, v66, v89, s[60:61]
        v_xor_b32       v109, s44, v53
        v_xor_b32       v116, v61, v54
        v_xor_b32       v114, v79, v69
        v_xor_b32       v90, s39, v73
        v_xor_b32       v88, v57, v71
        v_xor_b32       v98, v68, v78
        v_not_b32       v110, v74
        v_xor_b32       v115, 0xfc03fc03, v123
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_readlane_b32  s34, v2, 30
        v_readlane_b32  s35, v2, 31
        v_cndmask_b32   v117, v50, v89, s[34:35]
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_cndmask_b32   v112, v50, v89, s[30:31]
        v_xor_b32       v87, v120, v54
        v_xor_b32       v113, s57, v45
        v_xor_b32       v115, v3, v46
        v_xor_b32       v116, s47, v47
        v_xor_b32       v94, s56, v51
        v_xor_b32       v118, v80, v53
        v_xor_b32       v93, 0xaaaaaaaa, v48
        v_xor_b32       v98, 0x33333333, v52
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_not_b32       v89, v42
        v_readlane_b32  s34, v2, 40
        v_readlane_b32  s35, v2, 41
        v_cndmask_b32   v111, v42, v89, s[34:35]
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 52
        v_readlane_b32  s35, v2, 53
        v_cndmask_b32   v110, v42, v89, s[34:35]
        v_xor_b32       v115, v4, v85
        v_xor_b32       v87, s51, v46
        v_xor_b32       v117, s58, v38
        v_xor_b32       v112, s52, v39
        v_xor_b32       v113, s54, v40
        v_xor_b32       v116, s53, v43
        v_xor_b32       v98, s59, v45
        v_xor_b32       v94, 0xc3c3c3c3, v44
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 4 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[18:19]
        v_cndmask_b32   v111, v33, v87, s[20:21]
        v_xor_b32       v89, s45, v6
        v_xor_b32       v81, v68, v29
        v_xor_b32       v83, s11, v31
        v_xor_b32       v84, s40, v32
        v_xor_b32       v88, v59, v34
        v_xor_b32       v87, v55, v35
        v_xor_b32       v92, v61, v36
        v_not_b32       v82, v30
        v_xor_b32       v110, -4, v34
        v_xor_b32       v98, 0xfc03fc03, v37
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[74:75]
        v_not_b32       v89, v26
        v_cndmask_b32   v81, v26, v89, s[84:85]
        v_cndmask_b32   v82, v25, v87, s[16:17]
        v_cndmask_b32   v84, v26, v89, s[62:63]
        v_xor_b32       v113, v62, v30
        v_xor_b32       v83, v57, v21
        v_xor_b32       v112, s3, v22
        v_xor_b32       v110, v56, v23
        v_xor_b32       v111, s43, v24
        v_xor_b32       v87, v58, v27
        v_xor_b32       v93, v64, v28
        v_xor_b32       v98, v86, v29
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_readlane_b32  s34, v2, 34
        v_readlane_b32  s35, v2, 35
        v_cndmask_b32   v114, v18, v89, s[34:35]
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v82, v18, v89, s[34:35]
        v_xor_b32       v81, s55, v22
        v_xor_b32       v113, s54, v13
        v_xor_b32       v84, s49, v14
        v_xor_b32       v111, s1, v15
        v_xor_b32       v93, v5, v16
        v_xor_b32       v94, v3, v20
        v_xor_b32       v98, v67, v21
        v_xor_b32       v112, 0xc3c3c3c3, v19
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 50
        v_readlane_b32  s35, v2, 51
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_not_b32       v89, v10
        v_readlane_b32  s34, v2, 44
        v_readlane_b32  s35, v2, 45
        v_cndmask_b32   v81, v10, v89, s[34:35]
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v109, v10, v89, s[34:35]
        v_xor_b32       v70, s48, v14
        v_xor_b32       v82, v1, v37
        v_xor_b32       v90, s50, v7
        v_xor_b32       v88, v80, v8
        v_xor_b32       v107, s2, v11
        v_xor_b32       v108, v120, v12
        v_xor_b32       v84, 0x33333333, v6
        v_xor_b32       v98, 0xaaaaaaaa, v13
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 5 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[72:73]
        v_not_b32       v89, v75
        v_cndmask_b32   v94, v75, v89, s[20:21]
        v_cndmask_b32   v115, v63, v87, s[74:75]
        v_readlane_b32  s34, v2, 4
        v_readlane_b32  s35, v2, 5
        v_cndmask_b32   v111, v75, v89, s[34:35]
        v_xor_b32       v87, v86, v85
        v_xor_b32       v105, s10, v38
        v_xor_b32       v110, v64, v123
        v_xor_b32       v113, v62, v74
        v_xor_b32       v116, s41, v65
        v_xor_b32       v98, s8, v77
        v_xor_b32       v97, s3, v119
        v_xor_b32       v114, 0xfc03fc03, v76
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v66
        v_cndmask_b32   v111, v66, v87, s[86:87]
        v_cndmask_b32   v87, v66, v87, s[18:19]
        v_xor_b32       v110, s39, v74
        v_xor_b32       v109, v58, v53
        v_xor_b32       v116, s40, v54
        v_xor_b32       v114, v121, v69
        v_xor_b32       v113, v68, v122
        v_xor_b32       v88, s11, v71
        v_xor_b32       v98, s45, v78
        v_xor_b32       v90, -4, v73
        v_xor_b32       v112, 0xfffc0003, v122
        v_not_b32       v115, v123
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32       v87, s47, v54
        v_xor_b32       v113, v80, v45
        v_xor_b32       v115, s56, v46
        v_xor_b32       v116, s59, v47
        v_xor_b32       v93, s46, v48
        v_xor_b32       v88, s51, v49
        v_xor_b32       v117, v1, v50
        v_xor_b32       v94, v120, v51
        v_xor_b32       v98, s49, v52
        v_xor_b32       v118, s53, v53
        v_xor_b32       v114, 0x33333333, v49
        v_xor_b32       v112, 0xaaaaaaaa, v50
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 40
        v_readlane_b32  s35, v2, 41
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_not_b32       v89, v42
        v_readlane_b32  s34, v2, 16
        v_readlane_b32  s35, v2, 17
        v_cndmask_b32   v111, v42, v89, s[34:35]
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v110, v42, v89, s[34:35]
        v_xor_b32       v115, s52, v85
        v_xor_b32       v87, s57, v46
        v_xor_b32       v117, v3, v38
        v_xor_b32       v112, v60, v39
        v_xor_b32       v113, v67, v40
        v_xor_b32       v116, v4, v43
        v_xor_b32       v94, s55, v44
        v_xor_b32       v98, v5, v45
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 6 */
        v_not_b32       v87, v34
        v_cndmask_b32   v88, v34, v87, s[74:75]
        v_cndmask_b32   v110, v34, v87, s[20:21]
        v_xor_b32       v89, v79, v6
        v_xor_b32       v81, s45, v29
        v_xor_b32       v82, s39, v30
        v_xor_b32       v83, v68, v31
        v_xor_b32       v84, v86, v32
        v_xor_b32       v70, v58, v33
        v_xor_b32       v87, s44, v35
        v_xor_b32       v92, s40, v36
        v_xor_b32       v111, 0xfffc0003, v33
        v_not_b32       v98, v37
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[78:79]
        v_not_b32       v89, v26
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v81, v26, v89, s[34:35]
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v82, v25, v87, s[34:35]
        v_cndmask_b32   v84, v26, v89, s[72:73]
        v_xor_b32       v113, s43, v30
        v_xor_b32       v83, s11, v21
        v_xor_b32       v110, v55, v23
        v_xor_b32       v111, v59, v24
        v_xor_b32       v87, s41, v27
        v_xor_b32       v93, s10, v28
        v_xor_b32       v98, v62, v29
        v_xor_b32       v112, 0xfc03fc03, v22
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 40
        v_readlane_b32  s35, v2, 41
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v114, v18, v89, s[34:35]
        v_cndmask_b32   v83, v17, v87, s[24:25]
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v82, v18, v89, s[34:35]
        v_xor_b32       v81, s1, v22
        v_xor_b32       v113, v67, v13
        v_xor_b32       v93, s58, v16
        v_xor_b32       v112, s55, v19
        v_xor_b32       v94, s56, v20
        v_xor_b32       v98, s2, v21
        v_xor_b32       v84, 0xc3c3c3c3, v14
        v_xor_b32       v111, 0xaaaaaaaa, v15
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v10
        v_cndmask_b32   v81, v10, v87, s[22:23]
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v109, v10, v87, s[34:35]
        v_xor_b32       v70, s54, v14
        v_xor_b32       v82, s50, v37
        v_xor_b32       v84, s49, v6
        v_xor_b32       v90, v72, v7
        v_xor_b32       v88, s53, v8
        v_xor_b32       v106, s57, v9
        v_xor_b32       v107, v1, v11
        v_xor_b32       v108, s47, v12
        v_xor_b32       v98, s46, v13
        v_xor_b32       v83, 0x33333333, v9
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 7 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[76:77]
        v_cndmask_b32   v115, v63, v87, s[78:79]
        v_xor_b32       v87, v62, v85
        v_xor_b32       v105, v56, v38
        v_xor_b32       v110, s10, v123
        v_xor_b32       v113, s43, v74
        v_xor_b32       v116, v64, v65
        v_xor_b32       v111, s9, v75
        v_xor_b32       v98, v57, v77
        v_not_b32       v114, v76
        v_xor_b32       v94, 0xfffc0003, v75
        v_xor_b32       v97, 0xfc03fc03, v119
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[14:15]
        v_not_b32       v89, v66
        v_cndmask_b32   v111, v66, v89, s[64:65]
        v_cndmask_b32   v113, v122, v87, s[82:83]
        v_cndmask_b32   v87, v66, v89, s[80:81]
        v_xor_b32       v109, s41, v53
        v_xor_b32       v116, v86, v54
        v_xor_b32       v114, s8, v69
        v_xor_b32       v90, s42, v73
        v_xor_b32       v88, v68, v71
        v_xor_b32       v98, v79, v78
        v_xor_b32       v115, s39, v123
        v_xor_b32       v110, -4, v74
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 44
        v_readlane_b32  s35, v2, 45
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v117, v50, v89, s[34:35]
        v_readlane_b32  s34, v2, 12
        v_readlane_b32  s35, v2, 13
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v112, v50, v89, s[34:35]
        v_xor_b32       v87, s59, v54
        v_xor_b32       v113, s53, v45
        v_xor_b32       v115, v120, v46
        v_xor_b32       v116, v5, v47
        v_xor_b32       v94, s47, v51
        v_xor_b32       v118, v4, v53
        v_xor_b32       v93, 0x33333333, v48
        v_xor_b32       v98, 0xc3c3c3c3, v52
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 16
        v_readlane_b32  s35, v2, 17
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_not_b32       v89, v42
        v_readlane_b32  s34, v2, 20
        v_readlane_b32  s35, v2, 21
        v_cndmask_b32   v111, v42, v89, s[34:35]
        v_cndmask_b32   v114, v41, v87, s[24:25]
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v110, v42, v89, s[34:35]
        v_xor_b32       v115, v60, v85
        v_xor_b32       v87, v80, v46
        v_xor_b32       v117, s56, v38
        v_xor_b32       v112, s51, v39
        v_xor_b32       v113, s2, v40
        v_xor_b32       v116, s52, v43
        v_xor_b32       v94, s1, v44
        v_xor_b32       v98, s58, v45
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 8 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[74:75]
        v_not_b32       v89, v34
        v_readlane_b32  s34, v2, 6
        v_readlane_b32  s35, v2, 7
        v_cndmask_b32   v88, v34, v89, s[34:35]
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v111, v33, v87, s[34:35]
        v_cndmask_b32   v110, v34, v89, s[16:17]
        v_xor_b32       v82, s44, v30
        v_xor_b32       v83, s3, v31
        v_xor_b32       v84, v121, v32
        v_xor_b32       v87, v59, v35
        v_xor_b32       v92, v79, v36
        v_xor_b32       v98, v55, v37
        v_not_b32       v89, v6
        v_xor_b32       v81, 0xfc03fc03, v29
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[82:83]
        v_not_b32       v89, v26
        v_cndmask_b32   v81, v26, v89, s[70:71]
        v_cndmask_b32   v82, v25, v87, s[12:13]
        v_cndmask_b32   v84, v26, v89, s[20:21]
        v_xor_b32       v113, v57, v30
        v_xor_b32       v112, v56, v22
        v_xor_b32       v110, s43, v23
        v_xor_b32       v111, s11, v24
        v_xor_b32       v87, v61, v27
        v_xor_b32       v93, v86, v28
        v_xor_b32       v98, s8, v29
        v_xor_b32       v83, 0xfffc0003, v21
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_xor_b32       v81, s54, v22
        v_xor_b32       v113, s58, v13
        v_xor_b32       v84, v72, v14
        v_xor_b32       v111, v67, v15
        v_xor_b32       v93, v4, v16
        v_xor_b32       v82, s53, v18
        v_xor_b32       v112, s48, v19
        v_xor_b32       v94, v60, v20
        v_xor_b32       v98, v3, v21
        v_xor_b32       v114, 0xc3c3c3c3, v18
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v10
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v81, v10, v87, s[34:35]
        v_readlane_b32  s34, v2, 22
        v_readlane_b32  s35, v2, 23
        v_cndmask_b32   v109, v10, v87, s[34:35]
        v_xor_b32       v70, v5, v14
        v_xor_b32       v82, v120, v37
        v_xor_b32       v84, s50, v6
        v_xor_b32       v90, s47, v7
        v_xor_b32       v83, v1, v9
        v_xor_b32       v107, s56, v11
        v_xor_b32       v108, s57, v12
        v_xor_b32       v98, s2, v13
        v_xor_b32       v88, 0x33333333, v8
        v_xor_b32       v106, 0xaaaaaaaa, v9
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 9 */
        v_not_b32       v87, v75
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v94, v75, v87, s[34:35]
        v_readlane_b32  s34, v2, 6
        v_readlane_b32  s35, v2, 7
        v_cndmask_b32   v111, v75, v87, s[34:35]
        v_xor_b32       v87, s8, v85
        v_xor_b32       v105, v62, v38
        v_xor_b32       v110, v86, v123
        v_xor_b32       v113, v57, v74
        v_xor_b32       v116, s40, v65
        v_xor_b32       v114, v55, v76
        v_xor_b32       v115, s45, v63
        v_xor_b32       v98, s42, v77
        v_xor_b32       v97, v56, v119
        v_xor_b32       v112, 0xfffc0003, v63
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v66
        v_cndmask_b32   v111, v66, v87, s[66:67]
        v_cndmask_b32   v87, v66, v87, s[74:75]
        v_xor_b32       v110, v58, v74
        v_xor_b32       v109, v61, v53
        v_xor_b32       v116, v121, v54
        v_xor_b32       v90, s41, v73
        v_xor_b32       v112, s10, v122
        v_xor_b32       v88, s3, v71
        v_xor_b32       v115, s44, v123
        v_xor_b32       v114, -4, v69
        v_xor_b32       v113, 0xfc03fc03, v122
        v_not_b32       v98, v78
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v50
        v_readlane_b32  s34, v2, 48
        v_readlane_b32  s35, v2, 49
        v_cndmask_b32   v117, v50, v87, s[34:35]
        v_readlane_b32  s34, v2, 30
        v_readlane_b32  s35, v2, 31
        v_cndmask_b32   v112, v50, v87, s[34:35]
        v_xor_b32       v87, v80, v54
        v_xor_b32       v115, s51, v46
        v_xor_b32       v116, s53, v47
        v_xor_b32       v93, v1, v48
        v_xor_b32       v114, s50, v49
        v_xor_b32       v94, s57, v51
        v_xor_b32       v98, v72, v52
        v_xor_b32       v118, s49, v53
        v_xor_b32       v113, 0x33333333, v45
        v_xor_b32       v88, 0xaaaaaaaa, v49
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_not_b32       v89, v42
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v111, v42, v89, s[34:35]
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 26
        v_readlane_b32  s35, v2, 27
        v_cndmask_b32   v110, v42, v89, s[34:35]
        v_xor_b32       v115, s55, v85
        v_xor_b32       v87, s46, v46
        v_xor_b32       v117, v60, v38
        v_xor_b32       v112, s1, v39
        v_xor_b32       v113, v3, v40
        v_xor_b32       v94, s54, v44
        v_xor_b32       v98, v4, v45
        v_xor_b32       v116, 0xc3c3c3c3, v43
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 10 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[78:79]
        v_not_b32       v89, v34
        v_cndmask_b32   v88, v34, v89, s[82:83]
        v_cndmask_b32   v111, v33, v87, s[84:85]
        v_readlane_b32  s34, v2, 10
        v_readlane_b32  s35, v2, 11
        v_cndmask_b32   v110, v34, v89, s[34:35]
        v_xor_b32       v89, s39, v6
        v_xor_b32       v82, v58, v30
        v_xor_b32       v84, s8, v32
        v_xor_b32       v87, s9, v35
        v_xor_b32       v92, v121, v36
        v_xor_b32       v98, s44, v37
        v_not_b32       v81, v29
        v_xor_b32       v83, 0xfc03fc03, v31
        s_swappc_b64 s[100:101], s[90:91]
     
        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[86:87]
        v_cndmask_b32   v82, v25, v87, s[26:27]
		v_xor_b32       v113, s11, v30
        v_xor_b32       v83, s3, v21
        v_xor_b32       v112, v55, v22
        v_xor_b32       v110, v59, v23
        v_xor_b32       v111, v68, v24
        v_xor_b32       v81, s43, v26
        v_xor_b32       v87, s40, v27
        v_xor_b32       v93, v62, v28
        v_xor_b32       v98, v57, v29
        v_xor_b32       v84, 0xfffc0003, v26
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_readlane_b32  s34, v2, 22
        v_readlane_b32  s35, v2, 23
        v_cndmask_b32   v114, v18, v89, s[34:35]
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_readlane_b32  s34, v2, 34
        v_readlane_b32  s35, v2, 35
        v_cndmask_b32   v82, v18, v89, s[34:35]
        v_xor_b32       v81, v67, v22
        v_xor_b32       v113, v3, v13
        v_xor_b32       v84, s48, v14
        v_xor_b32       v111, s2, v15
        v_xor_b32       v93, s52, v16
        v_xor_b32       v112, s54, v19
        v_xor_b32       v94, s51, v20
        v_xor_b32       v98, s56, v21
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_xor_b32       v70, s58, v14
        v_xor_b32       v82, s47, v37
        v_xor_b32       v84, v72, v6
        v_xor_b32       v90, s59, v7
        v_xor_b32       v88, s49, v8
        v_xor_b32       v109, s1, v10
        v_xor_b32       v107, v120, v11
        v_xor_b32       v108, v80, v12
        v_xor_b32       v98, v1, v13
        v_xor_b32       v81, 0x33333333, v10
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 11 */
        v_not_b32       v87, v63
        v_cndmask_b32   v112, v63, v87, s[14:15]
        v_not_b32       v89, v75
        v_cndmask_b32   v94, v75, v89, s[84:85]
        v_cndmask_b32   v115, v63, v87, s[86:87]
        v_cndmask_b32   v111, v75, v89, s[82:83]
        v_xor_b32       v87, v57, v85
        v_xor_b32       v105, s43, v38
        v_xor_b32       v110, v62, v123
        v_xor_b32       v113, s11, v74
        v_xor_b32       v116, v86, v65
        v_xor_b32       v114, s44, v76
        v_xor_b32       v97, v55, v119
        v_xor_b32       v98, 0xfffc0003, v77
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v113, v122
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v112, v122, v113, s[34:35]
        v_xor_b32       v110, s41, v74
        v_xor_b32       v109, s40, v53
        v_xor_b32       v116, s8, v54
        v_xor_b32       v114, s42, v69
        v_xor_b32       v90, v64, v73
        v_xor_b32       v87, v61, v66
        v_xor_b32       v98, s39, v78
        v_xor_b32       v115, v58, v123
        v_xor_b32       v111, -4, v66
        v_xor_b32       v88, 0xfc03fc03, v71
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 32
        v_readlane_b32  s35, v2, 33
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_readlane_b32  s34, v2, 26
        v_readlane_b32  s35, v2, 27
        v_cndmask_b32   v117, v50, v89, s[34:35]
        v_readlane_b32  s34, v2, 18
        v_readlane_b32  s35, v2, 19
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_readlane_b32  s34, v2, 52
        v_readlane_b32  s35, v2, 53
        v_cndmask_b32   v112, v50, v89, s[34:35]
        v_xor_b32       v87, s53, v54
        v_xor_b32       v113, s49, v45
        v_xor_b32       v115, s57, v46
        v_xor_b32       v116, v4, v47
        v_xor_b32       v93, s50, v48
        v_xor_b32       v94, v80, v51
        v_xor_b32       v98, s48, v52
        v_xor_b32       v118, 0xc3c3c3c3, v53
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_not_b32       v89, v42
        v_cndmask_b32   v111, v42, v89, s[24:25]
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v110, v42, v89, s[34:35]
        v_xor_b32       v115, s1, v85
        v_xor_b32       v117, s51, v38
        v_xor_b32       v113, s56, v40
        v_xor_b32       v116, s55, v43
        v_xor_b32       v94, v67, v44
        v_xor_b32       v98, s52, v45
        v_xor_b32       v87, 0x33333333, v46
        v_xor_b32       v112, 0xaaaaaaaa, v39
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 12 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[12:13]
        v_not_b32       v89, v34
        v_cndmask_b32   v88, v34, v89, s[86:87]
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v111, v33, v87, s[34:35]
        v_cndmask_b32   v110, v34, v89, s[84:85]
        v_xor_b32       v81, s39, v29
        v_xor_b32       v82, s41, v30
        v_xor_b32       v84, v57, v32
        v_xor_b32       v87, v61, v35
        v_xor_b32       v92, s8, v36
        v_xor_b32       v98, v58, v37
        v_xor_b32       v89, -4, v6
        v_not_b32       v83, v31
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[64:65]
        v_not_b32       v89, v26
        v_readlane_b32  s34, v2, 4
        v_readlane_b32  s35, v2, 5
        v_cndmask_b32   v81, v26, v89, s[34:35]
        v_cndmask_b32   v82, v25, v87, s[70:71]
        v_cndmask_b32   v84, v26, v89, s[14:15]
        v_xor_b32       v113, v68, v30
        v_xor_b32       v112, s44, v22
        v_xor_b32       v110, s9, v23
        v_xor_b32       v111, s45, v24
        v_xor_b32       v87, v86, v27
        v_xor_b32       v93, s43, v28
        v_xor_b32       v98, s11, v29
        v_xor_b32       v83, 0xfc03fc03, v21
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_readlane_b32  s34, v2, 36
        v_readlane_b32  s35, v2, 37
        v_cndmask_b32   v70, v17, v87, s[34:35]
        v_not_b32       v89, v18
        v_cndmask_b32   v114, v18, v89, s[30:31]
        v_readlane_b32  s34, v2, 50
        v_readlane_b32  s35, v2, 51
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v82, v18, v89, s[34:35]
        v_xor_b32       v81, s2, v22
        v_xor_b32       v113, s56, v13
        v_xor_b32       v84, s54, v14
        v_xor_b32       v111, v1, v15
        v_xor_b32       v93, v60, v16
        v_xor_b32       v112, v67, v19
        v_xor_b32       v94, s57, v20
        v_xor_b32       v98, v120, v21
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_xor_b32       v70, v3, v14
        v_xor_b32       v82, s59, v37
        v_xor_b32       v84, s48, v6
        v_xor_b32       v90, v5, v7
        v_xor_b32       v81, s49, v10
        v_xor_b32       v83, v72, v9
        v_xor_b32       v107, s47, v11
        v_xor_b32       v108, s53, v12
        v_xor_b32       v98, s50, v13
        v_xor_b32       v88, 0xc3c3c3c3, v8
        v_xor_b32       v106, 0x33333333, v9
        v_xor_b32       v109, 0xaaaaaaaa, v10
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 13 */
        v_not_b32       v87, v75
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v94, v75, v87, s[34:35]
        v_cndmask_b32   v111, v75, v87, s[86:87]
        v_xor_b32       v87, s11, v85
        v_xor_b32       v105, v59, v38
        v_xor_b32       v110, s43, v123
        v_xor_b32       v113, v68, v74
        v_xor_b32       v116, v62, v65
        v_xor_b32       v114, v58, v76
        v_xor_b32       v115, v121, v63
        v_xor_b32       v98, s3, v77
        v_xor_b32       v97, s44, v119
        v_xor_b32       v112, 0xfc03fc03, v63
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[60:61]
        v_not_b32       v89, v66
        v_cndmask_b32   v111, v66, v89, s[20:21]
        v_cndmask_b32   v113, v122, v87, s[66:67]
        v_cndmask_b32   v87, v66, v89, s[12:13]
        v_xor_b32       v110, v64, v74
        v_xor_b32       v109, v86, v53
        v_xor_b32       v116, v57, v54
        v_xor_b32       v90, s10, v73
        v_xor_b32       v115, s41, v123
        v_xor_b32       v114, 0xfffc0003, v69
        v_not_b32       v88, v71
        v_xor_b32       v98, -4, v78
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v50
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v117, v50, v87, s[34:35]
        v_readlane_b32  s34, v2, 24
        v_readlane_b32  s35, v2, 25
        v_cndmask_b32   v112, v50, v87, s[34:35]
        v_xor_b32       v87, v4, v54
        v_xor_b32       v115, v80, v46
        v_xor_b32       v116, s52, v47
        v_xor_b32       v93, v72, v48
        v_xor_b32       v114, s48, v49
        v_xor_b32       v94, s53, v51
        v_xor_b32       v98, s54, v52
        v_xor_b32       v118, s55, v53
        v_xor_b32       v113, 0xc3c3c3c3, v45
        v_xor_b32       v88, 0x33333333, v49
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_cndmask_b32   v109, v41, v87, s[24:25]
        v_not_b32       v89, v42
        v_readlane_b32  s34, v2, 46
        v_readlane_b32  s35, v2, 47
        v_cndmask_b32   v111, v42, v89, s[34:35]
        v_readlane_b32  s34, v2, 50
        v_readlane_b32  s35, v2, 51
        v_cndmask_b32   v114, v41, v87, s[34:35]
        v_readlane_b32  s34, v2, 14
        v_readlane_b32  s35, v2, 15
        v_cndmask_b32   v110, v42, v89, s[34:35]
        v_xor_b32       v87, s49, v46
        v_xor_b32       v117, s57, v38
        v_xor_b32       v112, s46, v39
        v_xor_b32       v113, v120, v40
        v_xor_b32       v116, s1, v43
        v_xor_b32       v94, s2, v44
        v_xor_b32       v98, v60, v45
        v_xor_b32       v115, 0xaaaaaaaa, v85
        s_swappc_b64 s[100:101], s[92:93]
		/*********************************************/
		/* B 14 */
        v_not_b32       v87, v33
        v_cndmask_b32   v70, v33, v87, s[26:27]
        v_not_b32       v89, v34
        v_cndmask_b32   v88, v34, v89, s[64:65]
        v_cndmask_b32   v111, v33, v87, s[60:61]
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v110, v34, v89, s[34:35]
        v_xor_b32       v89, s42, v6
        v_xor_b32       v82, v64, v30
        v_xor_b32       v83, s39, v31
        v_xor_b32       v84, s11, v32
        v_xor_b32       v87, s40, v35
        v_xor_b32       v92, v57, v36
        v_xor_b32       v98, s41, v37
        v_xor_b32       v81, -4, v29
        s_swappc_b64 s[100:101], s[90:91]

        v_not_b32       v87, v25
        v_cndmask_b32   v70, v25, v87, s[62:63]
        v_cndmask_b32   v82, v25, v87, s[68:69]
        v_xor_b32       v113, s45, v30
        v_xor_b32       v112, v58, v22
        v_xor_b32       v110, v61, v23
        v_xor_b32       v111, v79, v24
        v_xor_b32       v81, s9, v26
        v_xor_b32       v87, v62, v27
        v_xor_b32       v93, v59, v28
        v_xor_b32       v98, v68, v29
        v_not_b32       v83, v21
        v_xor_b32       v84, 0xfc03fc03, v26
        s_swappc_b64 s[100:101], s[28:29]

        v_not_b32       v87, v17
        v_cndmask_b32   v70, v17, v87, s[24:25]
        v_readlane_b32  s34, v2, 44
        v_readlane_b32  s35, v2, 45
        v_cndmask_b32   v83, v17, v87, s[34:35]
        v_xor_b32       v81, v1, v22
        v_xor_b32       v113, v120, v13
        v_xor_b32       v84, v67, v14
        v_xor_b32       v111, s50, v15
        v_xor_b32       v93, s51, v16
        v_xor_b32       v82, v60, v18
        v_xor_b32       v112, s2, v19
        v_xor_b32       v94, v80, v20
        v_xor_b32       v98, s47, v21
        v_xor_b32       v114, 0xaaaaaaaa, v18
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S5_S6_B
        v_not_b32       v87, v9
        v_readlane_b32  s34, v2, 12
        v_readlane_b32  s35, v2, 13
        v_cndmask_b32   v106, v9, v87, s[34:35]
        v_readlane_b32  s34, v2, 40
        v_readlane_b32  s35, v2, 41
        v_cndmask_b32   v83, v9, v87, s[34:35]
        v_xor_b32       v70, s56, v14
        v_xor_b32       v82, v5, v37
        v_xor_b32       v84, s54, v6
        v_xor_b32       v90, s58, v7
        v_xor_b32       v88, s55, v8
        v_xor_b32       v109, s46, v10
        v_xor_b32       v107, s59, v11
        v_xor_b32       v108, v4, v12
        v_xor_b32       v98, v72, v13
        v_xor_b32       v81, 0xc3c3c3c3, v10
        s_getpc_b64 s[100:101]
		s_add_u32 s100,s100,12
		s_addc_u32 s101,s101,0
		s_branch .S7_S8_B
		/*********************************************/
		/* A 15 */
        v_not_b32       v87, v63
        v_readlane_b32  s34, v2, 8
        v_readlane_b32  s35, v2, 9
        v_cndmask_b32   v112, v63, v87, s[34:35]
        v_not_b32       v111, v75
        v_cndmask_b32   v94, v75, v111, s[70:71]
        v_cndmask_b32   v115, v63, v87, s[66:67]
        v_xor_b32       v105, s11, v38
        v_xor_b32       v110, v57, v123
        v_xor_b32       v113, s3, v74
        v_xor_b32       v116, s8, v65
        v_xor_b32       v114, s9, v76
        v_xor_b32       v98, s10, v77
        v_xor_b32       v97, v59, v119
        v_xor_b32       v87, 0xfffc0003, v85
        s_swappc_b64 s[100:101], s[98:99]

        v_not_b32       v87, v122
        v_cndmask_b32   v112, v122, v87, s[68:69]
        v_not_b32       v89, v66
        v_cndmask_b32   v111, v66, v89, s[16:17]
        v_cndmask_b32   v113, v122, v87, s[18:19]
        v_cndmask_b32   v87, v66, v89, s[86:87]
        v_xor_b32       v110, s40, v74
        v_xor_b32       v109, v121, v53
        v_xor_b32       v116, s42, v54
        v_xor_b32       v114, v64, v69
        v_xor_b32       v90, v86, v73
        v_xor_b32       v88, v55, v71
        v_xor_b32       v98, v58, v78
        v_xor_b32       v115, v61, v123
        s_swappc_b64 s[100:101], s[96:97]

        v_not_b32       v87, v49
        v_readlane_b32  s34, v2, 52
        v_readlane_b32  s35, v2, 53
        v_cndmask_b32   v88, v49, v87, s[34:35]
        v_not_b32       v89, v50
        v_cndmask_b32   v117, v50, v89, s[22:23]
        v_readlane_b32  s34, v2, 38
        v_readlane_b32  s35, v2, 39
        v_cndmask_b32   v114, v49, v87, s[34:35]
        v_readlane_b32  s34, v2, 48
        v_readlane_b32  s35, v2, 49
        v_cndmask_b32   v112, v50, v89, s[34:35]
        v_xor_b32       v87, s49, v54
        v_xor_b32       v113, v72, v45
        v_xor_b32       v115, s46, v46
        v_xor_b32       v93, s47, v48
        v_xor_b32       v98, v5, v52
        v_xor_b32       v118, s48, v53
        v_xor_b32       v116, 0xc3c3c3c3, v47
        v_xor_b32       v94, 0x33333333, v51
        s_swappc_b64 s[100:101], s[94:95]

        v_not_b32       v87, v41
        v_readlane_b32  s34, v2, 42
        v_readlane_b32  s35, v2, 43
        v_cndmask_b32   v109, v41, v87, s[34:35]
        v_not_b32       v89, v42
        v_readlane_b32  s34, v2, 28
        v_readlane_b32  s35, v2, 29
        v_cndmask_b32   v111, v42, v89, s[34:35]
        v_cndmask_b32   v114, v41, v87, s[30:31]
        v_cndmask_b32   v110, v42, v89, s[88:89]
        v_xor_b32       v115, v67, v85
        v_xor_b32       v87, s50, v46
        v_xor_b32       v112, s2, v39
        v_xor_b32       v113, s51, v40
        v_xor_b32       v116, s54, v43
        v_xor_b32       v94, v3, v44
        v_xor_b32       v98, s55, v45
        v_xor_b32       v117, 0xaaaaaaaa, v38
        s_swappc_b64 s[100:101], s[92:93]

        s_add_u32 s32, -1, s32
		s_branch  .startLoop



.quitLoop:
        s_cmp_eq_i32    s4, 0
        s_cbranch_scc0  .L19112_0
        v_readlane_b32  s0, v2, 0
        v_readlane_b32  s1, v2, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[0:1], 0x70
        s_load_dwordx4  s[12:15], s[0:1], 0x78
        s_load_dwordx4  s[0:3], s[0:1], 0x68
        s_mov_b64       s[16:17], exec
        s_mov_b64       s[18:19], exec
        v_mov_b32       v1, 0
        v_mov_b32       v3, v80
.L17884_0:
        v_cmp_lt_i32    vcc, 31, v1
        s_and_saveexec_b64 s[20:21], vcc
        v_mov_b32       v3, 0
        s_cbranch_execz .L17908_0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L19008_0
.L17908_0:
        s_and_b64       exec, s[20:21], s[18:19]
        v_lshl_b32      v3, 1, v1
        v_and_b32       v4, v6, v3
        v_cmp_lg_i32    vcc, 0, v4
        v_mov_b32       v4, 0x20000000
        v_cndmask_b32   v4, 0, v4, vcc
        v_and_b32       v5, v38, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x10000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v31, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x8000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v65, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x4000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v23, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x2000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v69, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x1000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v15, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x800000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v47, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x400000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v7, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x200000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v39, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x100000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v32, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x80000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v76, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x40000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_lshrrev_b32   v5, 18, v4
        v_add_i32       v5, vcc, s6, v5
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v5, v5, s[8:11], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_lg_i32    vcc, 0, v5
        s_mov_b64       s[20:21], exec
        s_andn2_b64     exec, s[20:21], vcc
        v_and_b32       v5, v24, v3
        s_cbranch_execz .L18980_0
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x20000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v73, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x10000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v16, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x8000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v48, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x4000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v8, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x2000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v40, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x1000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v33, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x800
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v63, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x400
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v25, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x200
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v122, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x100
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v17, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x80
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v49, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 64, vcc
        v_or_b32        v4, v4, v5
        v_lshrrev_b32   v5, 6, v4
        v_add_i32       v5, vcc, s7, v5
        buffer_load_ubyte v5, v5, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v5
        s_and_saveexec_b64 s[22:23], vcc
        v_and_b32       v5, v9, v3
        s_cbranch_execz .L18960_0
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 32, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v41, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 16, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v34, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 8, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v75, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 4, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v26, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 2, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v3, v66, v3
        v_cmp_lg_i32    vcc, 0, v3
        v_cndmask_b32   v3, 0, 1, vcc
        v_or_b32        v3, v4, v3
        s_mov_b64       s[24:25], exec
        s_mov_b64       s[26:27], exec
        v_mov_b32       v22, s5
        v_mov_b32       v4, 0
        v_mov_b32       v5, 0
        v_mov_b32       v57, 0
.L18700_0:
        v_add_i32       v67, vcc, -1, v22
        s_mov_b64       s[28:29], exec
        s_mov_b64       s[30:31], exec
        v_mov_b32       v80, v57
.L18716_0:
        v_lshlrev_b32   v4, 2, v4
        v_readlane_b32  s32, v2, 3
        v_add_i32       v4, vcc, s32, v4
        tbuffer_load_format_x v4, v4, s[0:3], 0 offen format:[32,float]
        v_cmp_gt_i32    s[32:33], v57, v67
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[34:35], v3, v4
        s_or_b64        vcc, s[32:33], s[34:35]
        s_and_saveexec_b64 s[36:37], vcc
        v_cndmask_b32   v4, 0, -1, s[34:35]
        s_cbranch_execz .L18800_0
        v_cndmask_b32   v22, 0, -1, s[32:33]
        v_mov_b32       v5, 1
        v_mov_b32       v57, v80
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L18896_0
.L18800_0:
        s_and_b64       exec, s[36:37], s[30:31]
        v_add_i32       v4, vcc, v67, v57
        v_ashrrev_i32   v4, 1, v4
        v_lshlrev_b32   v22, 2, v4
        v_readlane_b32  s32, v2, 3
        v_add_i32       v22, vcc, s32, v22
        v_add_i32       v80, vcc, 1, v4
        tbuffer_load_format_x v22, v22, s[0:3], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    vcc, v3, v22
        s_mov_b64       s[32:33], exec
        s_andn2_b64     exec, s[32:33], vcc
        v_mov_b32       v22, v4
        s_cbranch_execz .L18868_0
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L18896_0
.L18868_0:
        s_mov_b64       exec, s[30:31]
        v_mov_b32       v22, v4
        v_mov_b32       v124, v80
        v_mov_b32       v80, v57
        v_mov_b32       v57, v124
        s_branch        .L18716_0
        v_mov_b32       v57, v80
.L18896_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_lg_u32    vcc, 0, v5
        s_and_saveexec_b64 s[28:29], vcc
        s_andn2_b64     s[26:27], s[26:27], exec
        s_cbranch_scc0  .L18924_0
        s_mov_b64       exec, s[26:27]
        s_branch        .L18700_0
.L18924_0:
        s_mov_b64       exec, s[24:25]
        v_cmp_lg_u32    vcc, 0, v4
        s_and_saveexec_b64 s[24:25], vcc
        v_mov_b32       v3, 1
        s_cbranch_execz .L18952_0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L19008_0
.L18952_0:
        s_and_b64       exec, s[24:25], s[18:19]
        v_mov_b32       v3, 1
.L18960_0:
        s_andn2_b64     exec, s[22:23], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32       v3, 0
        s_cbranch_execz .L18976_0
.L18976_0:
        s_and_b64       exec, s[22:23], s[18:19]
.L18980_0:
        s_andn2_b64     exec, s[20:21], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32       v3, 0
        s_cbranch_execz .L18996_0
.L18996_0:
        s_and_b64       exec, s[20:21], s[18:19]
        v_add_i32       v1, vcc, 1, v1
        s_branch        .L17884_0
.L19008_0:
        s_mov_b64       exec, s[16:17]
        v_cmp_lg_i32    vcc, 0, v3
        s_waitcnt       lgkmcnt(0)
        s_and_saveexec_b64 s[0:1], vcc
        v_readlane_b32  s2, v2, 0
        s_cbranch_execz .L19096_0
        v_readlane_b32  s3, v2, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_readlane_b32  s12, v2, 2
        v_add_i32       v1, vcc, s12, v1
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v1, v1, s[8:11], 0 offen
        v_mov_b32       v3, 1
        s_load_dwordx4  s[8:11], s[2:3], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v3, v0, s[8:11], 0 offen offset:4 glc
        s_waitcnt       vmcnt(1)
        buffer_store_byte v1, v0, s[8:11], 0 offen offset:24 glc
.L19096_0:
        s_mov_b64       exec, s[0:1]
        s_waitcnt       expcnt(1)
        v_mov_b32       v3, 2
        s_branch        .L23616_0
.L19112_0:
        s_cmp_eq_i32    s4, 3
        s_cbranch_scc0  .L22320_0
        s_add_u32       s0, -1, s5
        v_readlane_b32  s2, v2, 0
        v_readlane_b32  s3, v2, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[12:15], s[2:3], 0x78
        s_load_dwordx4  s[16:19], s[2:3], 0x68
        s_mov_b64       s[2:3], exec
        s_mov_b64       s[20:21], exec
        v_mov_b32       v1, 0
        v_mov_b32       v61, v80
        v_mov_b32       v3, 0
        v_mov_b32       v86, 0
        v_mov_b32       v57, 0
        v_mov_b32       v14, 0
        v_mov_b32       v22, 0
        v_mov_b32       v67, 0
        v_mov_b32       v80, 0
.L19192_0:
        v_add_f32       v59, v67, v80
        v_add_f32       v59, v22, v59
        v_add_f32       v59, v14, v59
        v_add_f32       v59, v57, v59
        v_add_f32       v59, v86, v59
        v_add_f32       v59, v3, v59
        v_cmp_eq_u32    vcc, 0, v59
        s_and_saveexec_b64 s[22:23], vcc
        s_andn2_b64     exec, s[22:23], exec
        s_cbranch_execz .L19240_0
        s_andn2_b64     s[20:21], s[20:21], exec
        s_cbranch_scc0  .L22216_0
.L19240_0:
        s_and_b64       exec, s[22:23], s[20:21]
        v_cmp_ge_i32    vcc, 31, v1
        v_cndmask_b32   v3, 1.0, v3, vcc
        v_cmp_eq_u32    vcc, 0, v3
        s_and_saveexec_b64 s[22:23], vcc
        v_lshl_b32      v4, 1, v1
        s_cbranch_execz .L22200_0
        v_and_b32       v59, v6, v4
        v_and_b32       v64, v38, v4
        v_cmp_lg_i32    s[24:25], v59, 0
        v_mov_b32       v59, 0x20000000
        v_cmp_lg_i32    vcc, 0, v64
        v_mov_b32       v64, 0x10000000
        v_and_b32       v68, v31, v4
        v_cndmask_b32   v59, 0, v59, s[24:25]
        v_cndmask_b32   v64, 0, v64, vcc
        v_cmp_lg_i32    vcc, 0, v68
        v_mov_b32       v68, 0x8000000
        v_and_b32       v62, v65, v4
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v68, 0x4000000
        v_and_b32       v62, v23, v4
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v68, 0x2000000
        v_and_b32       v62, v69, v4
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v68, 0x1000000
        v_and_b32       v62, v15, v4
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v68, 0x800000
        v_and_b32       v62, v47, v4
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v68, 0x400000
        v_and_b32       v62, v7, v4
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v68, 0x200000
        v_and_b32       v62, v39, v4
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v68, 0x100000
        v_and_b32       v62, v32, v4
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v68, 0x80000
        v_and_b32       v62, v76, v4
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v68, 0x40000
        v_or_b32        v59, v59, v64
        v_cndmask_b32   v64, 0, v68, vcc
        v_or_b32        v59, v59, v64
        v_lshrrev_b32   v64, 18, v59
        v_add_i32       v64, vcc, s6, v64
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v64, v64, s[8:11], 0 offen
        v_and_b32       v68, v24, v4
        v_cmp_lg_i32    vcc, 0, v68
        v_mov_b32       v68, 0x20000
        v_and_b32       v62, v73, v4
        v_cndmask_b32   v68, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_mov_b32       v62, 0x10000
        v_and_b32       v58, v16, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_mov_b32       v62, 0x8000
        v_and_b32       v58, v48, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_mov_b32       v62, 0x4000
        v_and_b32       v58, v8, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_mov_b32       v62, 0x2000
        v_and_b32       v58, v40, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_mov_b32       v62, 0x1000
        v_and_b32       v58, v33, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_mov_b32       v62, 0x800
        v_and_b32       v58, v63, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_mov_b32       v62, 0x400
        v_and_b32       v58, v25, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_mov_b32       v62, 0x200
        v_and_b32       v58, v122, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_mov_b32       v62, 0x100
        v_and_b32       v58, v17, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_mov_b32       v62, 0x80
        v_and_b32       v58, v49, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, v62, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v62, v9, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, 64, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_and_b32       v62, v41, v4
        v_or_b32        v59, v59, v68
        v_cndmask_b32   v68, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_and_b32       v62, v34, v4
        v_or_b32        v68, v59, v68
        v_cndmask_b32   v58, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_and_b32       v62, v75, v4
        v_or_b32        v68, v68, v58
        v_cndmask_b32   v58, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_and_b32       v62, v26, v4
        v_or_b32        v68, v68, v58
        v_cndmask_b32   v58, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_and_b32       v62, v66, v4
        v_or_b32        v68, v68, v58
        v_cndmask_b32   v58, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v62
        v_or_b32        v68, v68, v58
        v_cndmask_b32   v62, 0, 1, vcc
        v_or_b32        v68, v68, v62
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v64
        s_and_saveexec_b64 s[24:25], vcc
        v_lshrrev_b32   v59, 6, v59
        s_cbranch_execz .L20300_0
        v_add_i32       v59, vcc, s7, v59
        buffer_load_ubyte v59, v59, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v59
        s_and_saveexec_b64 s[26:27], vcc
        s_cbranch_execz .L20288_0
        s_mov_b64       s[28:29], exec
        s_mov_b64       s[30:31], exec
        v_mov_b32       v64, s5
        v_mov_b32       v59, 0
        v_mov_b32       v62, 0
        v_mov_b32       v58, 0
.L20056_0:
        v_add_i32       v64, vcc, -1, v64
        s_mov_b64       s[32:33], exec
        s_mov_b64       s[34:35], exec
        v_mov_b32       v121, v62
.L20072_0:
        v_lshlrev_b32   v62, 2, v59
        v_readlane_b32  s1, v2, 3
        v_add_i32       v62, vcc, s1, v62
        tbuffer_load_format_x v62, v62, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[36:37], v121, v64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[38:39], v68, v62
        s_or_b64        vcc, s[36:37], s[38:39]
        s_and_saveexec_b64 s[40:41], vcc
        v_cndmask_b32   v64, 0, -1, s[38:39]
        s_cbranch_execz .L20152_0
        v_cndmask_b32   v62, 0, -1, s[36:37]
        v_mov_b32       v58, 1
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L20244_0
.L20152_0:
        s_and_b64       exec, s[40:41], s[34:35]
        v_add_i32       v59, vcc, v64, v121
        v_ashrrev_i32   v59, 1, v59
        v_lshlrev_b32   v62, 2, v59
        v_readlane_b32  s1, v2, 3
        v_add_i32       v62, vcc, s1, v62
        v_add_i32       v61, vcc, 1, v59
        tbuffer_load_format_x v62, v62, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    vcc, v68, v62
        s_mov_b64       s[36:37], exec
        s_andn2_b64     exec, s[36:37], vcc
        v_mov_b32       v64, v59
        s_cbranch_execz .L20224_0
        v_mov_b32       v62, v121
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L20244_0
.L20224_0:
        s_mov_b64       exec, s[34:35]
        v_mov_b32       v62, v121
        v_mov_b32       v121, v61
        s_branch        .L20072_0
        v_mov_b32       v64, v59
.L20244_0:
        s_mov_b64       exec, s[32:33]
        v_cmp_lg_u32    vcc, 0, v58
        s_and_saveexec_b64 s[32:33], vcc
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L20272_0
        s_mov_b64       exec, s[30:31]
        s_branch        .L20056_0
.L20272_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_eq_u32    vcc, 0, v64
        v_cndmask_b32   v86, 1.0, v86, vcc
        v_mov_b32       v61, 1
.L20288_0:
        s_andn2_b64     exec, s[26:27], exec
        v_mov_b32       v61, 0
        s_mov_b64       exec, s[26:27]
.L20300_0:
        s_andn2_b64     exec, s[24:25], exec
        v_mov_b32       v61, 0
        s_mov_b64       exec, s[24:25]
        v_cmp_eq_u32    vcc, 0, v86
        s_and_b64       exec, s[24:25], vcc
        v_lshlrev_b32   v64, 6, v68
        s_cbranch_execz .L22196_0
        v_and_b32       v64, 0x3fffffc0, v64
        v_lshrrev_b32   v62, 18, v64
        v_add_i32       v62, vcc, s6, v62
        buffer_load_ubyte v62, v62, s[8:11], 0 offen
        v_and_b32       v58, v18, v4
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v50, v4
        v_cndmask_b32   v121, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v10, v4
        v_or_b32        v64, v121, v64
        v_cndmask_b32   v121, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v42, v4
        v_or_b32        v64, v64, v121
        v_cndmask_b32   v121, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v35, v4
        v_or_b32        v64, v64, v121
        v_cndmask_b32   v121, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v77, v4
        v_or_b32        v64, v64, v121
        v_cndmask_b32   v121, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_or_b32        v64, v64, v121
        v_cndmask_b32   v58, 0, 1, vcc
        v_or_b32        v64, v64, v58
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v62
        s_and_saveexec_b64 s[26:27], vcc
        v_bfe_u32       v68, v68, 0, 24
        s_cbranch_execz .L20688_0
        v_add_i32       v68, vcc, s7, v68
        buffer_load_ubyte v68, v68, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v68
        s_and_saveexec_b64 s[28:29], vcc
        s_cbranch_execz .L20688_0
        s_mov_b64       s[30:31], exec
        s_mov_b64       s[32:33], exec
        v_mov_b32       v5, s0
        v_mov_b32       v68, 0
        v_mov_b32       v62, 0
        s_movk_i32      s34, 0x0
        s_movk_i32      s35, 0x0
.L20552_0:
        v_lshlrev_b32   v62, 2, v62
        v_readlane_b32  s1, v2, 3
        v_add_i32       v62, vcc, s1, v62
        tbuffer_load_format_x v62, v62, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[36:37], v68, v5
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v64, v62
        s_andn2_b64     s[34:35], s[34:35], exec
        s_or_b64        s[34:35], vcc, s[34:35]
        s_or_b64        vcc, s[36:37], vcc
        s_and_saveexec_b64 s[36:37], vcc
        s_andn2_b64     s[32:33], s[32:33], exec
        s_cbranch_scc0  .L20672_0
        s_mov_b64       exec, s[32:33]
        v_add_i32       v62, vcc, v5, v68
        v_ashrrev_i32   v62, 1, v62
        v_lshlrev_b32   v58, 2, v62
        v_readlane_b32  s1, v2, 3
        v_add_i32       v58, vcc, s1, v58
        v_add_i32       v121, vcc, -1, v62
        v_add_i32       v61, vcc, 1, v62
        tbuffer_load_format_x v58, v58, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v58, v64
        v_cndmask_b32   v68, v61, v68, vcc
        v_cndmask_b32   v5, v5, v121, vcc
        s_branch        .L20552_0
.L20672_0:
        s_mov_b64       exec, s[30:31]
        v_cndmask_b32   v57, v57, 1.0, s[34:35]
        v_mov_b32       v61, 1
.L20688_0:
        s_mov_b64       exec, s[26:27]
        v_cmp_eq_u32    vcc, 0, v57
        s_and_b64       exec, s[26:27], vcc
        v_lshlrev_b32   v68, 6, v64
        s_cbranch_execz .L22196_0
        v_and_b32       v68, 0x3fffffc0, v68
        v_lshrrev_b32   v62, 18, v68
        v_add_i32       v62, vcc, s6, v62
        buffer_load_ubyte v62, v62, s[8:11], 0 offen
        v_and_b32       v58, v27, v4
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v71, v4
        v_cndmask_b32   v121, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v19, v4
        v_or_b32        v68, v121, v68
        v_cndmask_b32   v121, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v51, v4
        v_or_b32        v68, v68, v121
        v_cndmask_b32   v121, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v11, v4
        v_or_b32        v68, v68, v121
        v_cndmask_b32   v121, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v43, v4
        v_or_b32        v68, v68, v121
        v_cndmask_b32   v121, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_or_b32        v68, v68, v121
        v_cndmask_b32   v58, 0, 1, vcc
        v_or_b32        v68, v68, v58
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v62
        s_and_saveexec_b64 s[28:29], vcc
        v_bfe_u32       v64, v64, 0, 24
        s_cbranch_execz .L21072_0
        v_add_i32       v64, vcc, s7, v64
        buffer_load_ubyte v64, v64, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v64
        s_and_saveexec_b64 s[30:31], vcc
        s_cbranch_execz .L21072_0
        s_mov_b64       s[32:33], exec
        s_mov_b64       s[34:35], exec
        v_mov_b32       v5, s0
        v_mov_b32       v64, 0
        v_mov_b32       v62, 0
        s_movk_i32      s36, 0x0
        s_movk_i32      s37, 0x0
        s_nop           0x0
.L20936_0:
        v_lshlrev_b32   v62, 2, v62
        v_readlane_b32  s1, v2, 3
        v_add_i32       v62, vcc, s1, v62
        tbuffer_load_format_x v62, v62, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[38:39], v64, v5
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v68, v62
        s_andn2_b64     s[36:37], s[36:37], exec
        s_or_b64        s[36:37], vcc, s[36:37]
        s_or_b64        vcc, s[38:39], vcc
        s_and_saveexec_b64 s[38:39], vcc
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L21056_0
        s_mov_b64       exec, s[34:35]
        v_add_i32       v62, vcc, v5, v64
        v_ashrrev_i32   v62, 1, v62
        v_lshlrev_b32   v58, 2, v62
        v_readlane_b32  s1, v2, 3
        v_add_i32       v58, vcc, s1, v58
        v_add_i32       v121, vcc, -1, v62
        v_add_i32       v61, vcc, 1, v62
        tbuffer_load_format_x v58, v58, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v58, v68
        v_cndmask_b32   v64, v61, v64, vcc
        v_cndmask_b32   v5, v5, v121, vcc
        s_branch        .L20936_0
.L21056_0:
        s_mov_b64       exec, s[32:33]
        v_cndmask_b32   v14, v14, 1.0, s[36:37]
        v_mov_b32       v61, 1
.L21072_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_eq_u32    vcc, 0, v14
        s_and_b64       exec, s[28:29], vcc
        v_lshlrev_b32   v64, 6, v68
        s_cbranch_execz .L22196_0
        v_and_b32       v64, 0x3fffffc0, v64
        v_lshrrev_b32   v62, 18, v64
        v_add_i32       v62, vcc, s6, v62
        buffer_load_ubyte v62, v62, s[8:11], 0 offen
        v_and_b32       v58, v36, v4
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v119, v4
        v_cndmask_b32   v121, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v28, v4
        v_or_b32        v64, v121, v64
        v_cndmask_b32   v121, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v78, v4
        v_or_b32        v64, v64, v121
        v_cndmask_b32   v121, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v20, v4
        v_or_b32        v64, v64, v121
        v_cndmask_b32   v121, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v52, v4
        v_or_b32        v64, v64, v121
        v_cndmask_b32   v121, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_or_b32        v64, v64, v121
        v_cndmask_b32   v58, 0, 1, vcc
        v_or_b32        v64, v64, v58
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v62
        s_and_saveexec_b64 s[30:31], vcc
        v_bfe_u32       v68, v68, 0, 24
        s_cbranch_execz .L21452_0
        v_add_i32       v68, vcc, s7, v68
        buffer_load_ubyte v68, v68, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v68
        s_and_saveexec_b64 s[32:33], vcc
        s_cbranch_execz .L21452_0
        s_mov_b64       s[34:35], exec
        s_mov_b64       s[36:37], exec
        v_mov_b32       v5, s0
        v_mov_b32       v68, 0
        v_mov_b32       v62, 0
        s_movk_i32      s38, 0x0
        s_movk_i32      s39, 0x0
.L21316_0:
        v_lshlrev_b32   v62, 2, v62
        v_readlane_b32  s1, v2, 3
        v_add_i32       v62, vcc, s1, v62
        tbuffer_load_format_x v62, v62, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[40:41], v68, v5
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v64, v62
        s_andn2_b64     s[38:39], s[38:39], exec
        s_or_b64        s[38:39], vcc, s[38:39]
        s_or_b64        vcc, s[40:41], vcc
        s_and_saveexec_b64 s[40:41], vcc
        s_andn2_b64     s[36:37], s[36:37], exec
        s_cbranch_scc0  .L21436_0
        s_mov_b64       exec, s[36:37]
        v_add_i32       v62, vcc, v5, v68
        v_ashrrev_i32   v62, 1, v62
        v_lshlrev_b32   v58, 2, v62
        v_readlane_b32  s1, v2, 3
        v_add_i32       v58, vcc, s1, v58
        v_add_i32       v121, vcc, -1, v62
        v_add_i32       v61, vcc, 1, v62
        tbuffer_load_format_x v58, v58, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v58, v64
        v_cndmask_b32   v68, v61, v68, vcc
        v_cndmask_b32   v5, v5, v121, vcc
        s_branch        .L21316_0
.L21436_0:
        s_mov_b64       exec, s[34:35]
        v_cndmask_b32   v22, v22, 1.0, s[38:39]
        v_mov_b32       v61, 1
.L21452_0:
        s_mov_b64       exec, s[30:31]
        v_cmp_eq_u32    vcc, 0, v22
        s_and_b64       exec, s[30:31], vcc
        v_lshlrev_b32   v68, 6, v64
        s_cbranch_execz .L22196_0
        v_and_b32       v68, 0x3fffffc0, v68
        v_lshrrev_b32   v62, 18, v68
        v_add_i32       v62, vcc, s6, v62
        buffer_load_ubyte v62, v62, s[8:11], 0 offen
        v_and_b32       v58, v12, v4
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v44, v4
        v_cndmask_b32   v121, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v37, v4
        v_or_b32        v68, v121, v68
        v_cndmask_b32   v121, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v85, v4
        v_or_b32        v68, v68, v121
        v_cndmask_b32   v121, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v29, v4
        v_or_b32        v68, v68, v121
        v_cndmask_b32   v121, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_and_b32       v58, v123, v4
        v_or_b32        v68, v68, v121
        v_cndmask_b32   v121, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v58
        v_or_b32        v68, v68, v121
        v_cndmask_b32   v58, 0, 1, vcc
        v_or_b32        v68, v68, v58
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v62
        s_and_saveexec_b64 s[32:33], vcc
        v_bfe_u32       v64, v64, 0, 24
        s_cbranch_execz .L21840_0
        v_add_i32       v64, vcc, s7, v64
        buffer_load_ubyte v64, v64, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v64
        s_and_saveexec_b64 s[34:35], vcc
        s_cbranch_execz .L21840_0
        s_mov_b64       s[36:37], exec
        s_mov_b64       s[38:39], exec
        v_mov_b32       v5, s0
        v_mov_b32       v64, 0
        v_mov_b32       v62, 0
        s_movk_i32      s40, 0x0
        s_movk_i32      s41, 0x0
        s_nop           0x0
        s_nop           0x0
.L21704_0:
        v_lshlrev_b32   v62, 2, v62
        v_readlane_b32  s1, v2, 3
        v_add_i32       v62, vcc, s1, v62
        tbuffer_load_format_x v62, v62, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[42:43], v64, v5
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v68, v62
        s_andn2_b64     s[40:41], s[40:41], exec
        s_or_b64        s[40:41], vcc, s[40:41]
        s_or_b64        vcc, s[42:43], vcc
        s_and_saveexec_b64 s[42:43], vcc
        s_andn2_b64     s[38:39], s[38:39], exec
        s_cbranch_scc0  .L21824_0
        s_mov_b64       exec, s[38:39]
        v_add_i32       v62, vcc, v5, v64
        v_ashrrev_i32   v62, 1, v62
        v_lshlrev_b32   v58, 2, v62
        v_readlane_b32  s1, v2, 3
        v_add_i32       v58, vcc, s1, v58
        v_add_i32       v121, vcc, -1, v62
        v_add_i32       v61, vcc, 1, v62
        tbuffer_load_format_x v58, v58, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v58, v68
        v_cndmask_b32   v64, v61, v64, vcc
        v_cndmask_b32   v5, v5, v121, vcc
        s_branch        .L21704_0
.L21824_0:
        s_mov_b64       exec, s[36:37]
        v_cndmask_b32   v67, v67, 1.0, s[40:41]
        v_mov_b32       v61, 1
.L21840_0:
        s_mov_b64       exec, s[32:33]
        v_cmp_eq_u32    vcc, 0, v67
        s_and_b64       exec, s[32:33], vcc
        v_lshlrev_b32   v64, 6, v68
        s_cbranch_execz .L22196_0
        v_and_b32       v64, 0x3fffffc0, v64
        v_lshrrev_b32   v62, 18, v64
        v_add_i32       v62, vcc, s6, v62
        buffer_load_ubyte v62, v62, s[8:11], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v62
        s_and_saveexec_b64 s[34:35], vcc
        v_bfe_u32       v68, v68, 0, 24
        s_cbranch_execz .L22180_0
        v_add_i32       v68, vcc, s7, v68
        buffer_load_ubyte v68, v68, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v68
        s_and_saveexec_b64 s[36:37], vcc
        v_and_b32       v5, v21, v4
        s_cbranch_execz .L22180_0
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 32, vcc
        v_or_b32        v5, v64, v5
        v_and_b32       v64, v53, v4
        v_cmp_lg_i32    vcc, 0, v64
        v_cndmask_b32   v64, 0, 16, vcc
        v_or_b32        v5, v5, v64
        v_and_b32       v64, v13, v4
        v_cmp_lg_i32    vcc, 0, v64
        v_cndmask_b32   v64, 0, 8, vcc
        v_or_b32        v5, v5, v64
        v_and_b32       v4, v45, v4
        v_cmp_lg_i32    vcc, 0, v4
        v_cndmask_b32   v4, 0, 4, vcc
        v_or_b32        v4, v5, v4
        s_mov_b64       s[38:39], exec
        s_mov_b64       s[40:41], exec
        v_mov_b32       v5, s0
        v_mov_b32       v64, 0
        v_mov_b32       v68, 0
        s_movk_i32      s42, 0x0
        s_movk_i32      s43, 0x0
.L22044_0:
        v_lshlrev_b32   v64, 2, v64
        v_readlane_b32  s1, v2, 3
        v_add_i32       v64, vcc, s1, v64
        tbuffer_load_format_x v64, v64, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[44:45], v68, v5
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v4, v64
        s_andn2_b64     s[42:43], s[42:43], exec
        s_or_b64        s[42:43], vcc, s[42:43]
        s_or_b64        vcc, s[44:45], vcc
        s_and_saveexec_b64 s[44:45], vcc
        s_andn2_b64     s[40:41], s[40:41], exec
        s_cbranch_scc0  .L22164_0
        s_mov_b64       exec, s[40:41]
        v_add_i32       v64, vcc, v5, v68
        v_ashrrev_i32   v64, 1, v64
        v_lshlrev_b32   v62, 2, v64
        v_readlane_b32  s1, v2, 3
        v_add_i32       v62, vcc, s1, v62
        v_add_i32       v58, vcc, -1, v64
        v_add_i32       v121, vcc, 1, v64
        tbuffer_load_format_x v62, v62, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v62, v4
        v_cndmask_b32   v68, v121, v68, vcc
        v_cndmask_b32   v5, v5, v58, vcc
        s_branch        .L22044_0
.L22164_0:
        s_mov_b64       exec, s[38:39]
        v_cndmask_b32   v80, v80, 1.0, s[42:43]
        v_mov_b32       v61, 1
.L22180_0:
        s_mov_b64       exec, s[34:35]
        v_cmp_eq_u32    vcc, 0, v80
        v_addc_u32      v1, vcc, v1, 0, vcc
.L22196_0:
        s_mov_b64       exec, s[24:25]
.L22200_0:
        s_andn2_b64     exec, s[22:23], exec
        v_mov_b32       v61, 0
        s_mov_b64       exec, s[22:23]
        s_branch        .L19192_0
.L22216_0:
        s_mov_b64       exec, s[2:3]
        v_cmp_lg_i32    vcc, 0, v61
        s_and_saveexec_b64 s[0:1], vcc
        v_readlane_b32  s2, v2, 0
        s_cbranch_execz .L22304_0
        v_readlane_b32  s3, v2, 1
        s_waitcnt       lgkmcnt(0)
        s_nop           0x2
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_readlane_b32  s12, v2, 2
        v_add_i32       v1, vcc, s12, v1
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v1, v1, s[8:11], 0 offen
        v_mov_b32       v3, 1
        s_load_dwordx4  s[8:11], s[2:3], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v3, v0, s[8:11], 0 offen offset:4 glc
        s_waitcnt       vmcnt(1)
        buffer_store_byte v1, v0, s[8:11], 0 offen offset:24 glc
.L22304_0:
        s_mov_b64       exec, s[0:1]
        s_waitcnt       expcnt(1)
        v_mov_b32       v3, 2
        s_branch        .L23616_0
.L22320_0:
        s_cmp_eq_i32    s4, 2
        s_cbranch_scc1  .L22336_0
        v_mov_b32       v3, 1
        s_branch        .L23616_0
.L22336_0:
        v_readlane_b32  s0, v2, 0
        v_readlane_b32  s1, v2, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[0:1], 0x70
        s_load_dwordx4  s[12:15], s[0:1], 0x78
        s_load_dwordx4  s[0:3], s[0:1], 0x68
        s_mov_b64       s[16:17], exec
        s_mov_b64       s[18:19], exec
        v_mov_b32       v1, 0
        v_mov_b32       v3, v80
.L22376_0:
        v_cmp_lt_i32    vcc, 31, v1
        s_and_saveexec_b64 s[20:21], vcc
        v_mov_b32       v3, 0
        s_cbranch_execz .L22400_0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L23508_0
.L22400_0:
        s_and_b64       exec, s[20:21], s[18:19]
        v_lshl_b32      v3, 1, v1
        v_and_b32       v4, v6, v3
        v_cmp_lg_i32    vcc, 0, v4
        v_mov_b32       v4, 0x20000000
        v_cndmask_b32   v4, 0, v4, vcc
        v_and_b32       v5, v38, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x10000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v31, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x8000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v65, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x4000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v23, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x2000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v69, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x1000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v15, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x800000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v47, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x400000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v7, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x200000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v39, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x100000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v32, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x80000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v76, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x40000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_lshrrev_b32   v5, 18, v4
        v_add_i32       v5, vcc, s6, v5
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v5, v5, s[8:11], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_lg_i32    vcc, 0, v5
        s_mov_b64       s[20:21], exec
        s_andn2_b64     exec, s[20:21], vcc
        v_and_b32       v5, v24, v3
        s_cbranch_execz .L23480_0
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x20000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v73, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x10000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v16, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x8000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v48, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x4000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v8, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x2000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v40, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x1000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v33, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x800
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v63, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x400
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v25, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x200
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v122, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x100
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v17, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x80
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v49, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 64, vcc
        v_or_b32        v4, v4, v5
        v_lshrrev_b32   v5, 6, v4
        v_add_i32       v5, vcc, s7, v5
        buffer_load_ubyte v5, v5, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v5
        s_and_saveexec_b64 s[22:23], vcc
        v_and_b32       v5, v9, v3
        s_cbranch_execz .L23460_0
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 32, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v41, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 16, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v34, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 8, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v75, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 4, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v26, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 2, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v3, v66, v3
        v_cmp_lg_i32    vcc, 0, v3
        v_cndmask_b32   v3, 0, 1, vcc
        v_or_b32        v3, v4, v3
        s_mov_b64       s[24:25], exec
        s_mov_b64       s[26:27], exec
        v_mov_b32       v22, s5
        v_mov_b32       v4, 0
        v_mov_b32       v5, 0
        v_mov_b32       v57, 0
.L23192_0:
        v_add_i32       v67, vcc, -1, v22
        s_mov_b64       s[28:29], exec
        s_mov_b64       s[30:31], exec
        v_mov_b32       v80, v57
        s_nop           0x0
        s_nop           0x0
.L23216_0:
        v_lshlrev_b32   v4, 2, v4
        v_readlane_b32  s32, v2, 3
        v_add_i32       v4, vcc, s32, v4
        tbuffer_load_format_x v4, v4, s[0:3], 0 offen format:[32,float]
        v_cmp_gt_i32    s[32:33], v57, v67
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[34:35], v3, v4
        s_or_b64        vcc, s[32:33], s[34:35]
        s_and_saveexec_b64 s[36:37], vcc
        v_cndmask_b32   v4, 0, -1, s[34:35]
        s_cbranch_execz .L23300_0
        v_cndmask_b32   v22, 0, -1, s[32:33]
        v_mov_b32       v5, 1
        v_mov_b32       v57, v80
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L23396_0
.L23300_0:
        s_and_b64       exec, s[36:37], s[30:31]
        v_add_i32       v4, vcc, v67, v57
        v_ashrrev_i32   v4, 1, v4
        v_lshlrev_b32   v22, 2, v4
        v_readlane_b32  s32, v2, 3
        v_add_i32       v22, vcc, s32, v22
        v_add_i32       v80, vcc, 1, v4
        tbuffer_load_format_x v22, v22, s[0:3], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    vcc, v3, v22
        s_mov_b64       s[32:33], exec
        s_andn2_b64     exec, s[32:33], vcc
        v_mov_b32       v22, v4
        s_cbranch_execz .L23368_0
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L23396_0
.L23368_0:
        s_mov_b64       exec, s[30:31]
        v_mov_b32       v22, v4
        v_mov_b32       v124, v80
        v_mov_b32       v80, v57
        v_mov_b32       v57, v124
        s_branch        .L23216_0
        v_mov_b32       v57, v80
.L23396_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_lg_u32    vcc, 0, v5
        s_and_saveexec_b64 s[28:29], vcc
        s_andn2_b64     s[26:27], s[26:27], exec
        s_cbranch_scc0  .L23424_0
        s_mov_b64       exec, s[26:27]
        s_branch        .L23192_0
.L23424_0:
        s_mov_b64       exec, s[24:25]
        v_cmp_lg_u32    vcc, 0, v4
        s_and_saveexec_b64 s[24:25], vcc
        v_mov_b32       v3, 1
        s_cbranch_execz .L23452_0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L23508_0
.L23452_0:
        s_and_b64       exec, s[24:25], s[18:19]
        v_mov_b32       v3, 1
.L23460_0:
        s_andn2_b64     exec, s[22:23], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32       v3, 0
        s_cbranch_execz .L23476_0
.L23476_0:
        s_and_b64       exec, s[22:23], s[18:19]
.L23480_0:
        s_andn2_b64     exec, s[20:21], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32       v3, 0
        s_cbranch_execz .L23496_0
.L23496_0:
        s_and_b64       exec, s[20:21], s[18:19]
        v_add_i32       v1, vcc, 1, v1
        s_branch        .L22376_0
.L23508_0:
        s_mov_b64       exec, s[16:17]
        v_cmp_eq_i32    vcc, 0, v3
        s_waitcnt       lgkmcnt(0)
        s_and_saveexec_b64 s[0:1], vcc
        v_mov_b32       v3, 1
        s_andn2_b64     exec, s[0:1], exec
        v_readlane_b32  s2, v2, 0
        s_cbranch_execz .L23612_0
        v_readlane_b32  s3, v2, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_readlane_b32  s12, v2, 2
        v_add_i32       v1, vcc, s12, v1
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v1, v1, s[8:11], 0 offen
        v_mov_b32       v3, 1
        s_load_dwordx4  s[8:11], s[2:3], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v3, v0, s[8:11], 0 offen offset:4 glc
        s_waitcnt       vmcnt(1)
        buffer_store_byte v1, v0, s[8:11], 0 offen offset:24 glc
        s_waitcnt       expcnt(1)
        v_mov_b32       v3, 0
.L23612_0:
        s_mov_b64       exec, s[0:1]
.L23616_0:
        v_cmp_lg_i32    vcc, 2, v3
        s_and_saveexec_b64 s[0:1], vcc
        v_cmp_lg_u32    vcc, 0, v3
        s_cbranch_execz .L24872_0
        s_and_saveexec_b64 s[2:3], vcc
        s_cbranch_execz .L24872_0
        s_add_u32       s4, -1, s4
        s_cmp_le_u32    s4, 1
        s_cbranch_scc0  .L24872_0
        s_waitcnt       lgkmcnt(0)
        v_readlane_b32  s8, v2, 0
        v_readlane_b32  s9, v2, 1
        s_nop           0x3
        s_load_dwordx4  s[12:15], s[8:9], 0x70
        s_load_dwordx4  s[16:19], s[8:9], 0x78
        s_load_dwordx4  s[8:11], s[8:9], 0x68
        s_mov_b64       s[20:21], exec
        s_mov_b64       s[22:23], exec
        s_waitcnt       expcnt(0)
        v_mov_b32       v1, 0
.L23696_0:
        v_cmp_gt_i32    s[24:25], v1, 31
        s_and_saveexec_b64 s[24:25], s[24:25]
        v_mov_b32       v3, 0
        s_cbranch_execz .L23724_0
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L24784_0
.L23724_0:
        s_and_b64       exec, s[24:25], s[22:23]
        v_lshl_b32      v3, 1, v1
        v_and_b32       v4, v18, v3
        v_cmp_lg_i32    vcc, 0, v4
        v_mov_b32       v4, 0x20000000
        v_cndmask_b32   v4, 0, v4, vcc
        v_and_b32       v5, v50, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x10000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v10, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x8000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v42, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x4000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v35, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x2000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v77, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x1000000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v27, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x800000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v71, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x400000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v19, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x200000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v51, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x100000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v11, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x80000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v43, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x40000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_lshrrev_b32   v5, 18, v4
        v_add_i32       v5, vcc, s6, v5
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v5, v5, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_lg_i32    vcc, 0, v5
        s_mov_b64       s[24:25], exec
        s_andn2_b64     exec, s[24:25], vcc
        v_and_b32       v5, v36, v3
        s_cbranch_execz .L24756_0
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x20000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v119, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x10000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v28, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x8000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v78, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x4000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v20, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x2000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v52, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x1000
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v12, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x800
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v44, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x400
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v37, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x200
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v85, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x100
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v29, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_mov_b32       v5, 0x80
        v_cndmask_b32   v5, 0, v5, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v123, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 64, vcc
        v_or_b32        v4, v4, v5
        v_lshrrev_b32   v5, 6, v4
        v_add_i32       v5, vcc, s7, v5
        buffer_load_ubyte v5, v5, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v5
        s_and_saveexec_b64 s[26:27], vcc
        v_and_b32       v5, v21, v3
        s_cbranch_execz .L24736_0
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 32, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v53, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 16, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v5, v13, v3
        v_cmp_lg_i32    vcc, 0, v5
        v_cndmask_b32   v5, 0, 8, vcc
        v_or_b32        v4, v4, v5
        v_and_b32       v3, v45, v3
        v_cmp_lg_i32    vcc, 0, v3
        v_cndmask_b32   v3, 0, 4, vcc
        v_or_b32        v3, v4, v3
        s_mov_b64       s[28:29], exec
        s_mov_b64       s[30:31], exec
        v_mov_b32       v7, s5
        v_mov_b32       v4, 0
        v_mov_b32       v6, 0
        v_mov_b32       v14, 0
.L24476_0:
        v_add_i32       v8, vcc, -1, v7
        s_mov_b64       s[32:33], exec
        s_mov_b64       s[34:35], exec
        v_mov_b32       v9, v14
.L24492_0:
        v_lshlrev_b32   v4, 2, v4
        v_readlane_b32  s4, v2, 3
        v_add_i32       v4, vcc, s4, v4
        tbuffer_load_format_x v4, v4, s[8:11], 0 offen format:[32,float]
        v_cmp_gt_i32    s[36:37], v14, v8
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[38:39], v3, v4
        s_or_b64        vcc, s[36:37], s[38:39]
        s_and_saveexec_b64 s[40:41], vcc
        v_cndmask_b32   v4, 0, -1, s[38:39]
        s_cbranch_execz .L24576_0
        v_cndmask_b32   v7, 0, -1, s[36:37]
        v_mov_b32       v6, 1
        v_mov_b32       v14, v9
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L24672_0
.L24576_0:
        s_and_b64       exec, s[40:41], s[34:35]
        v_add_i32       v4, vcc, v8, v14
        v_ashrrev_i32   v4, 1, v4
        v_lshlrev_b32   v7, 2, v4
        v_readlane_b32  s4, v2, 3
        v_add_i32       v7, vcc, s4, v7
        v_add_i32       v9, vcc, 1, v4
        tbuffer_load_format_x v7, v7, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    vcc, v3, v7
        s_mov_b64       s[36:37], exec
        s_andn2_b64     exec, s[36:37], vcc
        v_mov_b32       v7, v4
        s_cbranch_execz .L24644_0
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L24672_0
.L24644_0:
        s_mov_b64       exec, s[34:35]
        v_mov_b32       v7, v4
        v_mov_b32       v124, v9
        v_mov_b32       v9, v14
        v_mov_b32       v14, v124
        s_branch        .L24492_0
        v_mov_b32       v14, v9
.L24672_0:
        s_mov_b64       exec, s[32:33]
        v_cmp_lg_u32    vcc, 0, v6
        s_and_saveexec_b64 s[32:33], vcc
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L24700_0
        s_mov_b64       exec, s[30:31]
        s_branch        .L24476_0
.L24700_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_lg_u32    vcc, 0, v4
        s_and_saveexec_b64 s[28:29], vcc
        v_mov_b32       v3, 1
        s_cbranch_execz .L24728_0
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L24784_0
.L24728_0:
        s_and_b64       exec, s[28:29], s[22:23]
        v_mov_b32       v3, 1
.L24736_0:
        s_andn2_b64     exec, s[26:27], exec
        s_and_b64       exec, exec, s[22:23]
        v_mov_b32       v3, 0
        s_cbranch_execz .L24752_0
.L24752_0:
        s_and_b64       exec, s[26:27], s[22:23]
.L24756_0:
        s_andn2_b64     exec, s[24:25], exec
        s_and_b64       exec, exec, s[22:23]
        v_mov_b32       v3, 0
        s_cbranch_execz .L24772_0
.L24772_0:
        s_mov_b64       exec, s[22:23]
        v_add_i32       v1, vcc, 1, v1
        s_branch        .L23696_0
.L24784_0:
        s_mov_b64       exec, s[20:21]
        v_cmp_lg_i32    vcc, 0, v3
        s_and_saveexec_b64 s[4:5], vcc
        v_readlane_b32  s6, v2, 0
        s_cbranch_execz .L24872_0
        v_readlane_b32  s7, v2, 1
        s_waitcnt       lgkmcnt(0)
        s_nop           0x2
        s_load_dwordx4  s[8:11], s[6:7], 0x50
        v_readlane_b32  s12, v2, 2
        v_add_i32       v1, vcc, s12, v1
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v1, v1, s[8:11], 0 offen
        v_mov_b32       v3, 1
        s_load_dwordx4  s[8:11], s[6:7], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v3, v0, s[8:11], 0 offen offset:4 glc
        s_waitcnt       vmcnt(1)
        buffer_store_byte v1, v0, s[8:11], 0 offen offset:24 glc
.L24872_0:
        s_mov_b64       exec, s[0:1]
        s_waitcnt       expcnt(0)
        v_mov_b32       v1, 32
        v_readlane_b32  s0, v2, 0
        v_readlane_b32  s1, v2, 1
        s_nop           0x3
        s_load_dwordx4  s[0:3], s[0:1], 0x60
        s_waitcnt       lgkmcnt(0)
        tbuffer_store_format_x v1, v0, s[0:3], 0 offen format:[32,float]
        s_endpgm
