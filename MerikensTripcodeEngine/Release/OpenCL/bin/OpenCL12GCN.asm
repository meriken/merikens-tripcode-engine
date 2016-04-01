/* Disassembling '\\winserver2012\Depositories\GitHub\merikens-tripcode-engine\MerikensTripcodeEngine\Release\OpenCL\bin\OpenCL12GCN_0f865e1f.bin' */
.amd
.gpu Tahiti
.32bit
.compile_options ""
.driver_info "@(#) OpenCL 1.2 AMD-APP (1800.11).  Driver version: 1800.11 (VM)"
.globaldata
    .byte 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48
    .byte 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50
    .byte 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58
    .byte 0x59, 0x5a, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66
    .byte 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e
    .byte 0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76
    .byte 0x77, 0x78, 0x79, 0x7a, 0x30, 0x31, 0x32, 0x33
    .byte 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x2e, 0x2f
.kernel OpenCL_SHA1_PerformSearching_ForwardMatching
    .header
        .fill 8, 1, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x40, 0x11, 0x00, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
        .fill 8, 1, 0x00
    .metadata
        .ascii ";ARGSTART:__OpenCL_OpenCL_SHA1_PerformSearching_ForwardMatching_kernel\n"
        .ascii ";version:3:1:111\n"
        .ascii ";device:tahiti\n"
        .ascii ";uniqueid:1024\n"
        .ascii ";memory:uavprivate:0\n"
        .ascii ";memory:hwlocal:4416\n"
        .ascii ";memory:hwregion:0\n"
        .ascii ";pointer:outputArray:struct:1:1:0:uav:12:32:RW:0:0\n"
        .ascii ";pointer:key:u8:1:1:16:c:13:1:RO:0:0\n"
        .ascii ";constarg:1:key\n"
        .ascii ";pointer:tripcodeChunkArray:u32:1:1:32:uav:14:4:RO:0:0\n"
        .ascii ";constarg:2:tripcodeChunkArray\n"
        .ascii ";value:numTripcodeChunk:u32:1:1:48\n"
        .ascii ";pointer:keyCharTable_OneByte:u8:1:1:64:c:11:1:RO:0:0\n"
        .ascii ";constarg:4:keyCharTable_OneByte\n"
        .ascii ";pointer:keyCharTable_FirstByte:u8:1:1:80:c:15:1:RO:0:0\n"
        .ascii ";constarg:5:keyCharTable_FirstByte\n"
        .ascii ";pointer:keyCharTable_SecondByte:u8:1:1:96:c:11:1:RO:0:0\n"
        .ascii ";constarg:6:keyCharTable_SecondByte\n"
        .ascii ";pointer:keyCharTable_SecondByteAndOneByte:u8:1:1:112:c:16:1:RO:0:0\n"
        .ascii ";constarg:7:keyCharTable_SecondByteAndOneByte\n"
        .ascii ";pointer:smallChunkBitmap_constant:u8:1:1:128:c:17:1:RO:0:0\n"
        .ascii ";constarg:8:smallChunkBitmap_constant\n"
        .ascii ";pointer:chunkBitmap:u8:1:1:144:uav:18:1:RO:0:0\n"
        .ascii ";constarg:9:chunkBitmap\n"
        .ascii ";memory:datareqd\n"
        .ascii ";function:1:1035\n"
        .ascii ";uavid:11\n"
        .ascii ";printfid:9\n"
        .ascii ";cbid:10\n"
        .ascii ";privateid:8\n"
        .ascii ";reflection:0:GPUOutput*\n"
        .ascii ";reflection:1:uchar*\n"
        .ascii ";reflection:2:uint*\n"
        .ascii ";reflection:3:uint\n"
        .ascii ";reflection:4:uchar*\n"
        .ascii ";reflection:5:uchar*\n"
        .ascii ";reflection:6:uchar*\n"
        .ascii ";reflection:7:uchar*\n"
        .ascii ";reflection:8:uchar*\n"
        .ascii ";reflection:9:uchar*\n"
        .ascii ";ARGEND:__OpenCL_OpenCL_SHA1_PerformSearching_ForwardMatching_kernel\n"
    .data
        .fill 4736, 1, 0x00
    .inputs
    .outputs
    .uav
        .entry 12, 4, 0, 5
        .entry 14, 4, 0, 5
        .entry 18, 4, 0, 5
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
        .cbmask 13, 0
        .cbmask 11, 0
        .cbmask 15, 0
        .cbmask 11, 0
        .cbmask 16, 0
        .cbmask 17, 0
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
        .entry 0x80001041, 0x00000036
        .entry 0x80001042, 0x00000036
        .entry 0x80001863, 0x00000066
        .entry 0x80001864, 0x00000100
        .entry 0x80001043, 0x000000c0
        .entry 0x80001044, 0x00000000
        .entry 0x80001045, 0x00000000
        .entry 0x00002e13, 0x00090098
        .entry 0x8000001c, 0x00000100
        .entry 0x8000001d, 0x00000000
        .entry 0x8000001e, 0x00000000
        .entry 0x80001841, 0x00000000
        .entry 0x8000001f, 0x0007f400
        .entry 0x80001843, 0x0007f400
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
        .entry 0x80000082, 0x00001200
    .subconstantbuffers
    .uavmailboxsize 0
    .uavopmask
        .byte 0x00, 0xf4, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00
        .fill 120, 1, 0x00
    .text
        s_mov_b32       m0, 0x8000
        s_buffer_load_dword s0, s[8:11], 0x4
        s_load_dwordx4  s[16:19], s[2:3], 0x68
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v1, s0
        buffer_load_ubyte v2, v1, s[16:19], 0 offen offset:1
        buffer_load_ubyte v3, v1, s[16:19], 0 offen offset:11
        buffer_load_ubyte v4, v1, s[16:19], 0 offen
        s_buffer_load_dword s1, s[4:7], 0x4
        s_buffer_load_dword s13, s[4:7], 0x18
        s_buffer_load_dword s14, s[4:7], 0x1c
        s_buffer_load_dword s15, s[8:11], 0x14
        s_buffer_load_dword s20, s[8:11], 0x1c
        s_buffer_load_dword s21, s[8:11], 0x0
        s_waitcnt       lgkmcnt(0)
        s_min_u32       s1, s1, 0xffff
        s_mul_i32       s1, s12, s1
        s_add_u32       s1, s1, s13
        s_add_u32       s12, s12, s14
        v_add_i32       v5, vcc, s1, v0
        s_ashr_i32      s1, s12, 6
        v_and_b32       v6, 63, v0
        s_and_b32       s12, s12, 63
        s_load_dwordx4  s[24:27], s[2:3], 0x60
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x80
        v_lshlrev_b32   v5, 5, v5
        s_add_u32       s1, s1, s20
        s_waitcnt       vmcnt(2)
        v_add_i32       v2, vcc, v2, v6
        s_add_u32       s12, s12, s15
        v_add_i32       v5, vcc, s21, v5
        v_mov_b32       v6, 0
        s_waitcnt       vmcnt(1)
        v_add_i32       v3, vcc, s1, v3
        v_add_i32       v2, vcc, s20, v2
        s_waitcnt       vmcnt(0)
        v_add_i32       v4, vcc, s12, v4
        buffer_load_ubyte v7, v1, s[16:19], 0 offen offset:2
        buffer_load_ubyte v1, v1, s[16:19], 0 offen offset:3
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v3, v3, s[32:35], 0 offen
        buffer_load_ubyte v2, v2, s[32:35], 0 offen
        buffer_load_ubyte v4, v4, s[28:31], 0 offen
        s_buffer_load_dword s1, s[4:7], 0x20
        s_buffer_load_dword s4, s[8:11], 0x8
        s_buffer_load_dword s5, s[8:11], 0xc
        s_buffer_load_dword s6, s[8:11], 0x20
        s_buffer_load_dword s7, s[8:11], 0x24
        buffer_store_byte v6, v5, s[24:27], 0 offen offset:4 glc
        v_cmp_eq_i32    vcc, 0, v0
        s_and_saveexec_b64 s[8:9], vcc
        s_cbranch_execz .L4656_0
        s_load_dwordx4  s[36:39], s[2:3], 0x88
        s_movk_i32      s10, 0x0
        s_movk_i32      s11, 0x100
.L268_0:
        s_cmp_gt_u32    s11, 0
        s_cbranch_scc0  .L4656_0
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s12, s6, s10
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s12
        s_add_u32       s12, s10, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 1
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 2
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 3
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 4
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 5
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 6
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 7
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 8
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 9
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 10
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 11
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 12
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 13
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 14
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 15
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 16
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 17
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 18
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 19
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 20
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 22
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 23
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:16
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:17
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:18
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:19
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:20
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:21
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:22
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:23
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 24
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 25
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 26
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 27
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 28
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 29
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 30
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 31
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:24
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:25
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:26
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:27
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:28
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:29
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:30
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:31
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 32
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 33
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 34
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 35
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 36
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 37
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 38
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 39
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:32
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:33
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:34
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:35
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:36
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:37
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:38
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:39
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 40
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 41
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 42
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 43
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 44
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 45
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 46
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 47
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:40
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:41
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:42
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:43
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:44
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:45
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:46
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:47
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 48
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 49
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 50
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 51
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 52
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 53
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 54
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 55
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:48
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:49
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:50
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:51
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:52
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:53
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:54
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:55
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 56
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 57
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 58
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 59
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 60
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 61
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 62
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 63
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:56
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:57
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:58
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:59
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:60
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:61
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:62
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:63
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s10, s10, 64
        s_add_u32       s12, s10, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x141
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x142
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x143
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x144
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x145
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x146
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:64
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:65
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:66
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:67
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:68
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:69
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:70
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:71
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x147
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x148
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x149
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x14a
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x14b
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x14c
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x14d
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x14e
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:72
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:73
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:74
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:75
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:76
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:77
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:78
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:79
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x14f
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x150
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x151
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x152
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x153
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x154
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x155
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x156
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:80
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:81
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:82
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:83
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:84
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:85
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:86
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:87
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x157
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x158
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x159
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x15a
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x15b
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x15c
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x15d
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x15e
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:88
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:89
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:90
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:91
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:92
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:93
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:94
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:95
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x15f
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x160
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x161
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x162
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x163
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x164
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x165
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x166
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:96
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:97
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:98
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:99
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:100
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:101
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:102
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:103
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x167
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x168
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x169
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x16a
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x16b
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x16c
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x16d
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x16e
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:104
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:105
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:106
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:107
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:108
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:109
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:110
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:111
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x16f
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x170
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x171
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x172
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x173
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x174
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x175
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x176
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:112
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:113
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:114
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:115
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:116
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:117
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:118
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:119
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x177
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x178
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x179
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x17a
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x17b
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x17c
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x17d
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x17e
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:120
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:121
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:122
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:123
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:124
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:125
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:126
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:127
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x17f
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 64
        s_sub_i32       s11, s11, 8
        s_branch        .L268_0
.L4656_0:
        s_mov_b64       exec, s[8:9]
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s0
        buffer_load_ubyte v8, v6, s[16:19], 0 offen offset:5
        buffer_load_ubyte v9, v6, s[16:19], 0 offen offset:4
        buffer_load_ubyte v10, v6, s[16:19], 0 offen offset:6
        buffer_load_ubyte v11, v6, s[16:19], 0 offen offset:8
        buffer_load_ubyte v12, v6, s[16:19], 0 offen offset:9
        buffer_load_ubyte v13, v6, s[16:19], 0 offen offset:7
        buffer_load_ubyte v6, v6, s[16:19], 0 offen offset:10
        s_waitcnt       vmcnt(6)
        v_lshlrev_b32   v8, 16, v8
        s_waitcnt       vmcnt(5)
        v_lshlrev_b32   v9, 24, v9
        v_or_b32        v8, v8, v9
        s_waitcnt       vmcnt(4)
        v_lshlrev_b32   v9, 8, v10
        s_waitcnt       vmcnt(3)
        v_lshlrev_b32   v10, 24, v11
        s_movk_i32      s0, 0xff
        v_or_b32        v8, v8, v9
        v_bfi_b32       v9, s0, v3, v10
        s_waitcnt       vmcnt(2)
        v_lshlrev_b32   v10, 16, v12
        s_waitcnt       vmcnt(1)
        v_or_b32        v8, v13, v8
        v_mov_b32       v11, 0
        v_or_b32        v9, v9, v10
        s_waitcnt       vmcnt(0)
        v_lshlrev_b32   v6, 8, v6
        ds_write2_b32   v11, v11, v8 offset1:1
        v_or_b32        v6, v9, v6
        v_mov_b32       v9, 0x80000000
        ds_write2_b32   v11, v6, v9 offset0:2 offset1:3
        ds_write2_b32   v11, v11, v11 offset0:4 offset1:5
        ds_write2_b32   v11, v11, v11 offset0:6 offset1:7
        ds_write2_b32   v11, v11, v11 offset0:8 offset1:9
        ds_write2_b32   v11, v11, v11 offset0:10 offset1:11
        ds_write2_b32   v11, v11, v11 offset0:12 offset1:13
        v_mov_b32       v9, 0x60
        v_alignbit_b32  v10, v6, v6, 31
        v_xor_b32       v8, 0x80000000, v8
        ds_write2_b32   v11, v11, v9 offset0:14 offset1:15
        v_xor_b32       v6, 0x60, v6
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v9, 0x80000000, v10
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v12, v8, v8, 31
        ds_write2_b32   v11, v10, v8 offset0:16 offset1:17
        ds_write2_b32   v11, v6, v9 offset0:18 offset1:19
        v_alignbit_b32  v14, v6, v6, 31
        v_xor_b32       v15, 0x60, v12
        v_alignbit_b32  v16, v9, v9, 31
        ds_write2_b32   v11, v12, v14 offset0:20 offset1:21
        v_alignbit_b32  v15, v15, v15, 31
        ds_write2_b32   v11, v16, v15 offset0:22 offset1:23
        ds_read2_b32    v[17:18], v11 offset0:10 offset1:10
        ds_read2_b32    v[19:20], v11 offset0:11 offset1:11
        ds_read2_b32    v[21:22], v11 offset0:14 offset1:14
        ds_read_b32     v23, v11 offset:64
        ds_read2_b32    v[24:25], v11 offset0:12 offset1:12
        ds_read2_b32    v[26:27], v11 offset0:13 offset1:13
        v_xor_b32       v28, v6, v15
        v_xor_b32       v10, v10, v14
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v17, v17, v28
        v_xor_b32       v28, v16, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v28, v28, v28, 31
        v_xor_b32       v29, v9, v10
        v_xor_b32       v30, v14, v17
        v_xor_b32       v19, v19, v29
        v_xor_b32       v29, 0x60, v30
        v_xor_b32       v30, v12, v28
        v_alignbit_b32  v19, v19, v19, 31
        ds_write2_b32   v11, v10, v28 offset0:24 offset1:25
        v_xor_b32       v26, v26, v29
        v_xor_b32       v24, v24, v30
        ds_write2_b32   v11, v17, v19 offset0:26 offset1:27
        v_alignbit_b32  v26, v26, v26, 31
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v24, v26 offset0:28 offset1:29
        v_xor_b32       v29, v16, v19
        v_xor_b32       v15, v15, v24
        ds_read2_b32    v[30:31], v11 offset0:17 offset1:17
        ds_read2_b32    v[32:33], v11 offset0:18 offset1:18
        v_xor_b32       v29, v23, v29
        v_xor_b32       v8, v8, v15
        v_xor_b32       v15, v21, v29
        v_xor_b32       v8, 0x60, v8
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v21, v26, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read2_b32    v[34:35], v11 offset0:21 offset1:21
        ds_read2_b32    v[36:37], v11 offset0:23 offset1:23
        ds_read_b32     v29, v11 offset:76
        ds_read2_b32    v[38:39], v11 offset0:20 offset1:20
        v_xor_b32       v6, v6, v21
        v_xor_b32       v21, v28, v15
        v_xor_b32       v40, v17, v8
        v_xor_b32       v6, v23, v6
        v_xor_b32       v9, v9, v21
        v_xor_b32       v12, v12, v40
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v30, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v12, v32, v12
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v21, v19, v6
        v_xor_b32       v23, v24, v9
        v_xor_b32       v14, v14, v21
        v_xor_b32       v21, v26, v12
        ds_write2_b32   v11, v15, v8 offset0:30 offset1:31
        v_xor_b32       v23, v16, v23
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v14, v29, v14
        v_xor_b32       v21, v36, v21
        ds_write2_b32   v11, v6, v9 offset0:32 offset1:33
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v23, v38, v23
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v21, v34, v21
        v_alignbit_b32  v23, v23, v23, 31
        ds_write2_b32   v11, v12, v14 offset0:34 offset1:35
        v_alignbit_b32  v21, v21, v21, 31
        ds_write2_b32   v11, v23, v21 offset0:36 offset1:37
        ds_read_b32     v29, v11 offset:96
        v_xor_b32       v15, v15, v14
        ds_read_b32     v30, v11 offset:100
        v_xor_b32       v32, v23, v8
        v_xor_b32       v10, v10, v15
        v_xor_b32       v15, v6, v21
        ds_read_b32     v34, v11 offset:112
        ds_read_b32     v38, v11 offset:120
        ds_read2_b32    v[40:41], v11 offset0:26 offset1:26
        ds_read2_b32    v[42:43], v11 offset0:27 offset1:27
        v_xor_b32       v28, v28, v32
        v_xor_b32       v10, v16, v10
        v_xor_b32       v15, v17, v15
        v_xor_b32       v16, v36, v28
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v15, v29, v15
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v17, v9, v10
        v_xor_b32       v17, v19, v17
        v_xor_b32       v19, v14, v15
        v_xor_b32       v28, v12, v16
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v17, v30, v17
        v_xor_b32       v19, v26, v19
        v_xor_b32       v24, v24, v28
        v_alignbit_b32  v17, v17, v17, 31
        ds_write2_b32   v11, v10, v16 offset0:38 offset1:39
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v42, v19
        v_xor_b32       v24, v40, v24
        ds_write2_b32   v11, v15, v17 offset0:40 offset1:41
        v_alignbit_b32  v19, v19, v19, 31
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v24, v19 offset0:42 offset1:43
        v_xor_b32       v28, v23, v17
        v_xor_b32       v21, v21, v24
        ds_read_b32     v29, v11 offset:124
        ds_read_b32     v30, v11 offset:128
        v_xor_b32       v28, v38, v28
        v_xor_b32       v8, v8, v21
        v_xor_b32       v21, v34, v28
        v_xor_b32       v8, v26, v8
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v26, v19, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v28, v11 offset:140
        ds_read_b32     v32, v11 offset:148
        ds_read2_b32    v[44:45], v11 offset0:33 offset1:33
        ds_read_b32     v34, v11 offset:136
        v_xor_b32       v6, v6, v26
        v_xor_b32       v26, v16, v21
        v_xor_b32       v36, v15, v8
        v_xor_b32       v6, v38, v6
        v_xor_b32       v9, v9, v26
        v_xor_b32       v12, v12, v36
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v29, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v12, v30, v12
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v26, v17, v6
        v_xor_b32       v29, v24, v9
        v_xor_b32       v14, v14, v26
        v_xor_b32       v26, v19, v12
        ds_write2_b32   v11, v21, v8 offset0:44 offset1:45
        v_xor_b32       v29, v23, v29
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v14, v44, v14
        v_xor_b32       v26, v32, v26
        ds_write2_b32   v11, v6, v9 offset0:46 offset1:47
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v29, v34, v29
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v26, v28, v26
        v_alignbit_b32  v28, v29, v29, 31
        ds_write2_b32   v11, v12, v14 offset0:48 offset1:49
        v_alignbit_b32  v26, v26, v26, 31
        ds_write2_b32   v11, v28, v26 offset0:50 offset1:51
        ds_read_b32     v29, v11 offset:152
        v_xor_b32       v21, v21, v14
        ds_read2_b32    v[46:47], v11 offset0:39 offset1:39
        v_xor_b32       v30, v28, v8
        v_xor_b32       v10, v10, v21
        v_xor_b32       v21, v6, v26
        ds_read_b32     v34, v11 offset:168
        ds_read_b32     v36, v11 offset:176
        ds_read_b32     v38, v11 offset:160
        ds_read2_b32    v[48:49], v11 offset0:41 offset1:41
        v_xor_b32       v16, v16, v30
        v_xor_b32       v10, v23, v10
        v_xor_b32       v15, v15, v21
        v_xor_b32       v16, v32, v16
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v15, v29, v15
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v21, v9, v10
        v_xor_b32       v17, v17, v21
        v_xor_b32       v21, v14, v15
        v_xor_b32       v23, v12, v16
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v17, v46, v17
        v_xor_b32       v21, v19, v21
        v_xor_b32       v23, v24, v23
        v_alignbit_b32  v17, v17, v17, 31
        ds_write2_b32   v11, v10, v16 offset0:52 offset1:53
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v21, v48, v21
        v_xor_b32       v23, v38, v23
        ds_write2_b32   v11, v15, v17 offset0:54 offset1:55
        v_alignbit_b32  v21, v21, v21, 31
        v_alignbit_b32  v23, v23, v23, 31
        ds_write2_b32   v11, v23, v21 offset0:56 offset1:57
        v_xor_b32       v24, v28, v17
        v_xor_b32       v26, v26, v23
        ds_read2_b32    v[29:30], v11 offset0:45 offset1:45
        ds_read_b32     v32, v11 offset:184
        v_xor_b32       v24, v36, v24
        v_xor_b32       v8, v8, v26
        v_xor_b32       v24, v34, v24
        v_xor_b32       v8, v19, v8
        v_alignbit_b32  v19, v24, v24, 31
        v_xor_b32       v24, v21, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v26, v11 offset:196
        ds_read_b32     v34, v11 offset:204
        ds_read_b32     v38, v11 offset:188
        ds_read_b32     v40, v11 offset:192
        v_xor_b32       v6, v6, v24
        v_xor_b32       v24, v16, v19
        v_xor_b32       v42, v15, v8
        v_xor_b32       v6, v36, v6
        v_xor_b32       v9, v9, v24
        v_xor_b32       v12, v12, v42
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v29, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v12, v32, v12
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v24, v17, v6
        v_xor_b32       v29, v23, v9
        v_xor_b32       v14, v14, v24
        v_xor_b32       v24, v21, v12
        ds_write2_b32   v11, v19, v8 offset0:58 offset1:59
        v_xor_b32       v29, v28, v29
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v14, v38, v14
        v_xor_b32       v24, v34, v24
        ds_write2_b32   v11, v6, v9 offset0:60 offset1:61
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v29, v40, v29
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v24, v26, v24
        v_alignbit_b32  v26, v29, v29, 31
        ds_write2_b32   v11, v12, v14 offset0:62 offset1:63
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v26, v24 offset0:64 offset1:65
        ds_read_b32     v29, v11 offset:208
        v_xor_b32       v19, v19, v14
        ds_read2_b32    v[50:51], v11 offset0:53 offset1:53
        v_xor_b32       v32, v26, v8
        v_xor_b32       v10, v10, v19
        v_xor_b32       v19, v6, v24
        ds_read_b32     v36, v11 offset:224
        ds_read_b32     v38, v11 offset:232
        ds_read_b32     v40, v11 offset:216
        ds_read_b32     v42, v11 offset:220
        v_xor_b32       v16, v16, v32
        v_xor_b32       v10, v28, v10
        v_xor_b32       v15, v15, v19
        v_xor_b32       v16, v34, v16
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v15, v29, v15
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v19, v9, v10
        v_xor_b32       v17, v17, v19
        v_xor_b32       v19, v14, v15
        v_xor_b32       v28, v12, v16
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v17, v50, v17
        v_xor_b32       v19, v21, v19
        v_xor_b32       v23, v23, v28
        v_alignbit_b32  v17, v17, v17, 31
        ds_write2_b32   v11, v10, v16 offset0:66 offset1:67
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v42, v19
        v_xor_b32       v23, v40, v23
        ds_write2_b32   v11, v15, v17 offset0:68 offset1:69
        v_alignbit_b32  v19, v19, v19, 31
        v_alignbit_b32  v23, v23, v23, 31
        ds_write2_b32   v11, v23, v19 offset0:70 offset1:71
        v_xor_b32       v28, v26, v17
        v_xor_b32       v24, v24, v23
        ds_read_b32     v29, v11 offset:236
        ds_read_b32     v32, v11 offset:240
        v_xor_b32       v28, v38, v28
        v_xor_b32       v8, v8, v24
        v_xor_b32       v24, v36, v28
        v_xor_b32       v8, v21, v8
        v_alignbit_b32  v21, v24, v24, 31
        v_xor_b32       v10, v19, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v24, v11 offset:252
        ds_read2_b32    v[52:53], v11 offset0:65 offset1:65
        ds_read_b32     v28, v11 offset:244
        ds_read_b32     v34, v11 offset:248
        v_xor_b32       v6, v6, v10
        v_xor_b32       v10, v16, v21
        v_xor_b32       v15, v15, v8
        v_xor_b32       v6, v38, v6
        v_xor_b32       v9, v9, v10
        v_xor_b32       v10, v12, v15
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v29, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v10, v32, v10
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v12, v17, v6
        v_xor_b32       v15, v23, v9
        v_xor_b32       v12, v14, v12
        v_xor_b32       v14, v19, v10
        ds_write2_b32   v11, v21, v8 offset0:72 offset1:73
        v_xor_b32       v15, v26, v15
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v12, v28, v12
        v_xor_b32       v14, v52, v14
        ds_write2_b32   v11, v6, v9 offset0:74 offset1:75
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v6, v34, v15
        v_alignbit_b32  v9, v12, v12, 31
        v_xor_b32       v12, v24, v14
        v_alignbit_b32  v6, v6, v6, 31
        ds_write2_b32   v11, v10, v9 offset0:76 offset1:77
        v_alignbit_b32  v9, v12, v12, 31
        ds_write2_b32   v11, v6, v9 offset0:78 offset1:79
        ds_read_b32     v6, v11 offset:4
        ds_read_b32     v9, v11 offset:8
        ds_read_b32     v10, v11 offset:12
        ds_read_b32     v12, v11 offset:16
        v_mov_b32       v14, 0x5a827999
        s_waitcnt       lgkmcnt(3)
        v_add_i32       v6, vcc, v6, v14
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v9, vcc, v9, v14
        ds_write_b32    v11, v6 offset:4
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v6, vcc, v10, v14
        ds_write_b32    v11, v9 offset:8
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v9, vcc, v14, v12
        ds_write_b32    v11, v6 offset:12
        ds_write_b32    v11, v9 offset:16
        ds_read_b32     v6, v11 offset:20
        ds_read_b32     v9, v11 offset:28
        ds_read_b32     v10, v11 offset:32
        ds_read_b32     v12, v11 offset:24
        s_waitcnt       lgkmcnt(3)
        v_add_i32       v6, vcc, v6, v14
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v12, v14
        ds_write_b32    v11, v6 offset:20
        v_add_i32       v6, vcc, v9, v14
        ds_write_b32    v11, v12 offset:24
        v_add_i32       v9, vcc, v10, v14
        ds_write_b32    v11, v6 offset:28
        ds_write_b32    v11, v9 offset:32
        ds_read_b32     v6, v11 offset:36
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, v6, v14
        v_add_i32       v21, vcc, v18, v14
        ds_write_b32    v11, v6 offset:36
        v_add_i32       v6, vcc, v20, v14
        ds_write_b32    v11, v21 offset:40
        v_add_i32       v10, vcc, v25, v14
        ds_write_b32    v11, v6 offset:44
        ds_write_b32    v11, v10 offset:48
        v_add_i32       v6, vcc, v27, v14
        v_add_i32       v10, vcc, v22, v14
        ds_write_b32    v11, v6 offset:52
        ds_write_b32    v11, v10 offset:56
        ds_read_b32     v6, v11 offset:60
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, v6, v14
        ds_write_b32    v11, v6 offset:60
        v_add_i32       v6, vcc, v31, v14
        v_add_i32       v10, vcc, v33, v14
        s_nop           0x0
        ds_write_b32    v11, v6 offset:68
        ds_write_b32    v11, v10 offset:72
        v_add_i32       v6, vcc, 0x6ed9eba1, v39
        v_add_i32       v10, vcc, 0x6ed9eba1, v35
        ds_write_b32    v11, v6 offset:80
        ds_write_b32    v11, v10 offset:84
        v_add_i32       v6, vcc, 0x6ed9eba1, v37
        ds_write_b32    v11, v6 offset:92
        v_add_i32       v39, vcc, 0x6ed9eba1, v41
        v_add_i32       v10, vcc, 0x6ed9eba1, v43
        ds_write_b32    v11, v39 offset:104
        ds_write_b32    v11, v10 offset:108
        ds_read_b32     v10, v11 offset:116
        s_waitcnt       lgkmcnt(0)
        s_nop           0x0
        v_add_i32       v10, vcc, 0x6ed9eba1, v10
        ds_write_b32    v11, v10 offset:116
        v_add_i32       v10, vcc, 0x6ed9eba1, v45
        ds_write_b32    v11, v10 offset:132
        v_add_i32       v10, vcc, 0x6ed9eba1, v47
        ds_write_b32    v11, v10 offset:156
        v_add_i32       v10, vcc, 0x8f1bbcdc, v49
        ds_write_b32    v11, v10 offset:164
        v_add_i32       v10, vcc, 0x8f1bbcdc, v30
        ds_write_b32    v11, v10 offset:180
        v_add_i32       v10, vcc, 0x8f1bbcdc, v51
        ds_write_b32    v11, v10 offset:212
        v_add_i32       v10, vcc, 0xca62c1d6, v53
        ds_write_b32    v11, v10 offset:260
        ds_read_b32     v10, v11 offset:276
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0xca62c1d6, v10
        ds_write_b32    v11, v10 offset:276
        ds_read_b32     v10, v11 offset:308
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0xca62c1d6, v10
        v_lshrrev_b32   v0, 2, v0
        ds_write_b32    v11, v10 offset:308
        v_lshlrev_b32   v10, 24, v4
        v_lshlrev_b32   v38, 16, v2
        v_and_b32       v0, 48, v0
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[16:19], s[2:3], 0x90
        v_or_b32        v10, v10, v38
        v_add_i32       v0, vcc, v7, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        s_add_u32       s0, -1, s5
        s_mov_b64       s[12:13], exec
        s_mov_b64       s[22:23], exec
        v_mov_b32       v6, 0
        v_mov_b32       v9, 0x13c
        v_mov_b32       v7, v14
.L7492_0:
        s_movk_i32      s5, 0x3ff
        v_cmp_gt_i32    s[36:37], v6, s5
        s_and_saveexec_b64 s[38:39], s[36:37]
        v_cndmask_b32   v38, 0, -1, s[36:37]
        s_cbranch_execz .L7532_0
        v_mov_b32       v7, 0
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L12476_0
.L7532_0:
        s_and_b64       exec, s[38:39], s[22:23]
        v_ashrrev_i32   v7, 6, v6
        v_bfe_u32       v8, v0, 0, 8
        v_add_i32       v7, vcc, v8, v7
        v_add_i32       v7, vcc, s15, v7
        v_and_b32       v8, 63, v6
        v_add_i32       v8, vcc, v1, v8
        v_add_i32       v8, vcc, s20, v8
        buffer_load_ubyte v38, v7, s[28:31], 0 offen
        buffer_load_ubyte v39, v8, s[32:35], 0 offen
        s_waitcnt       vmcnt(0)
        s_barrier
        v_mov_b32       v9, 0
        ds_read2_b32    v[11:12], v9 offset0:1 offset1:2
        v_lshlrev_b32   v14, 8, v38
        v_or_b32        v14, v10, v14
        v_or_b32        v14, v14, v39
        v_add_i32       v15, vcc, 0x9fb498b3, v14
        v_alignbit_b32  v16, v15, v15, 27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v16, v11
        v_add_i32       v11, vcc, 0xc2e5374, v11
        v_mov_b32       v16, 0x7bf36ae2
        s_mov_b32       s5, 0x59d148c0
        v_bfi_b32       v16, v15, s5, v16
        v_alignbit_b32  v17, v11, v11, 27
        ds_read2_b32    v[18:19], v9 offset0:3 offset1:4
        v_add_i32       v16, vcc, v16, v17
        v_add_i32       v12, vcc, v12, v16
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0x98badcfe, v12
        v_bfi_b32       v16, v11, v15, s5
        v_alignbit_b32  v17, v12, v12, 27
        v_add_i32       v16, vcc, v17, v16
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v18
        v_add_i32       v16, vcc, 0x7bf36ae2, v16
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v17, v16, v16, 27
        v_bfi_b32       v18, v12, v11, v15
        v_add_i32       v17, vcc, v17, v18
        ds_read2_b32    v[20:21], v9 offset0:5 offset1:6
        v_add_i32       v17, vcc, v17, v19
        v_add_i32       v17, vcc, 0x59d148c0, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_alignbit_b32  v18, v17, v17, 27
        v_bfi_b32       v19, v16, v12, v11
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, v19, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v20
        v_alignbit_b32  v16, v16, v16, 2
        v_alignbit_b32  v18, v15, v15, 27
        v_bfi_b32       v19, v17, v16, v12
        v_add_i32       v11, vcc, v11, v18
        ds_read2_b32    v[22:23], v9 offset0:7 offset1:8
        v_add_i32       v11, vcc, v19, v11
        v_add_i32       v11, vcc, v21, v11
        v_alignbit_b32  v18, v11, v11, 27
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v12, vcc, v12, v18
        v_bfi_b32       v18, v15, v17, v16
        v_add_i32       v12, vcc, v12, v18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v22, v12
        v_alignbit_b32  v15, v15, v15, 2
        v_alignbit_b32  v18, v12, v12, 27
        v_bfi_b32       v19, v11, v15, v17
        v_add_i32       v16, vcc, v16, v18
        ds_read2_b32    v[20:21], v9 offset0:9 offset1:10
        v_add_i32       v16, vcc, v19, v16
        v_add_i32       v16, vcc, v23, v16
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v18, v16, v16, 27
        v_bfi_b32       v19, v12, v11, v15
        v_add_i32       v17, vcc, v17, v18
        v_add_i32       v17, vcc, v19, v17
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v20
        v_alignbit_b32  v18, v17, v17, 27
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v15, vcc, v15, v18
        v_bfi_b32       v18, v16, v12, v11
        ds_read2_b32    v[19:20], v9 offset0:11 offset1:12
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, v21, v15
        v_alignbit_b32  v16, v16, v16, 2
        v_alignbit_b32  v18, v15, v15, 27
        v_bfi_b32       v21, v17, v16, v12
        v_add_i32       v11, vcc, v11, v18
        v_add_i32       v11, vcc, v21, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v19, v11
        v_alignbit_b32  v17, v17, v17, 2
        v_alignbit_b32  v18, v11, v11, 27
        v_bfi_b32       v19, v15, v17, v16
        v_add_i32       v12, vcc, v12, v18
        ds_read2_b32    v[21:22], v9 offset0:13 offset1:14
        v_add_i32       v12, vcc, v19, v12
        v_add_i32       v12, vcc, v20, v12
        v_alignbit_b32  v18, v12, v12, 27
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v16, vcc, v16, v18
        v_bfi_b32       v18, v11, v15, v17
        v_add_i32       v16, vcc, v16, v18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v21
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v18, v16, v16, 27
        v_bfi_b32       v19, v12, v11, v15
        v_add_i32       v17, vcc, v17, v18
        ds_read2_b32    v[20:21], v9 offset0:15 offset1:16
        v_add_i32       v17, vcc, v19, v17
        v_add_i32       v17, vcc, v22, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_alignbit_b32  v18, v17, v17, 27
        v_bfi_b32       v19, v16, v12, v11
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, v19, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v20, v15
        v_alignbit_b32  v18, v15, v15, 27
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v11, vcc, v11, v18
        v_bfi_b32       v18, v17, v16, v12
        v_alignbit_b32  v19, v14, v14, 31
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v21, v19
        ds_read2_b32    v[19:20], v9 offset0:17 offset1:18
        v_add_i32       v11, vcc, v11, v18
        v_add_i32       v11, vcc, 0x5a827999, v11
        v_alignbit_b32  v17, v17, v17, 2
        v_alignbit_b32  v18, v11, v11, 27
        v_bfi_b32       v21, v15, v17, v16
        v_add_i32       v12, vcc, v12, v18
        v_add_i32       v12, vcc, v21, v12
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v12, v19
        v_alignbit_b32  v15, v15, v15, 2
        v_alignbit_b32  v18, v12, v12, 27
        ds_read2_b32    v[21:22], v9 offset0:19 offset1:20
        v_bfi_b32       v19, v11, v15, v17
        v_add_i32       v16, vcc, v16, v18
        v_add_i32       v16, vcc, v19, v16
        v_add_i32       v16, vcc, v20, v16
        v_alignbit_b32  v18, v16, v16, 27
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v17, vcc, v17, v18
        v_bfi_b32       v18, v12, v11, v15
        v_alignbit_b32  v19, v14, v14, 30
        v_add_i32       v17, vcc, v17, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v21, v19
        v_add_i32       v17, vcc, v17, v18
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v18, v16, v11
        v_add_i32       v17, vcc, 0x5a827999, v17
        v_xor_b32       v18, v12, v18
        ds_read2_b32    v[20:21], v9 offset0:21 offset1:22
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v18, v17, v17, 27
        v_xor_b32       v23, v17, v12
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v23, v16
        v_add_i32       v15, vcc, v22, v15
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v18, v15, v15, 27
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v16, v15
        v_alignbit_b32  v17, v17, v17, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v20
        v_xor_b32       v18, v18, v17
        v_alignbit_b32  v20, v11, v11, 27
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v18, v14, v14, 29
        ds_read2_b32    v[22:23], v9 offset0:23 offset1:24
        v_add_i32       v12, vcc, v20, v12
        v_xor_b32       v20, v21, v18
        v_add_i32       v12, vcc, v12, v20
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v20, v11, v17
        v_add_i32       v12, vcc, 0x6ed9eba1, v12
        v_xor_b32       v20, v15, v20
        v_add_i32       v16, vcc, v16, v20
        v_alignbit_b32  v20, v12, v12, 27
        v_xor_b32       v21, v12, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v20
        v_xor_b32       v20, v21, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v22, v16
        ds_read2_b32    v[21:22], v9 offset0:25 offset1:26
        v_add_i32       v17, vcc, v17, v20
        v_alignbit_b32  v20, v16, v16, 27
        v_add_i32       v17, vcc, v17, v20
        v_xor_b32       v20, v19, v23
        v_add_i32       v17, vcc, v17, v20
        v_xor_b32       v20, v11, v16
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0x6ed9eba1, v17
        v_xor_b32       v20, v20, v12
        v_alignbit_b32  v23, v17, v17, 27
        v_add_i32       v15, vcc, v15, v20
        v_alignbit_b32  v20, v14, v14, 28
        v_add_i32       v15, vcc, v23, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v21, v20, v21
        v_add_i32       v15, vcc, v15, v21
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v21, v17, v12
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        v_xor_b32       v21, v16, v21
        ds_read2_b32    v[23:24], v9 offset0:27 offset1:28
        v_add_i32       v11, vcc, v11, v21
        v_alignbit_b32  v21, v15, v15, 27
        v_xor_b32       v25, v15, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, v11, v21
        v_xor_b32       v21, v25, v17
        v_add_i32       v11, vcc, v22, v11
        v_add_i32       v12, vcc, v12, v21
        v_alignbit_b32  v21, v11, v11, 27
        v_add_i32       v12, vcc, v12, v21
        v_xor_b32       v21, v17, v11
        v_alignbit_b32  v15, v15, v15, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v23, v12
        v_xor_b32       v21, v21, v15
        v_alignbit_b32  v22, v12, v12, 27
        v_add_i32       v16, vcc, v16, v21
        v_alignbit_b32  v21, v14, v14, 27
        ds_read2_b32    v[25:26], v9 offset0:29 offset1:30
        v_add_i32       v16, vcc, v22, v16
        v_xor_b32       v22, v24, v21
        v_add_i32       v16, vcc, v16, v22
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v22, v12, v15
        v_add_i32       v16, vcc, 0x6ed9eba1, v16
        v_xor_b32       v22, v11, v22
        v_add_i32       v17, vcc, v17, v22
        v_alignbit_b32  v22, v16, v16, 27
        v_xor_b32       v23, v16, v11
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, v17, v22
        v_xor_b32       v22, v23, v12
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v25
        ds_read2_b32    v[23:24], v9 offset0:31 offset1:32
        v_add_i32       v15, vcc, v15, v22
        v_alignbit_b32  v22, v17, v17, 27
        v_xor_b32       v25, v19, v20
        v_add_i32       v15, vcc, v15, v22
        v_xor_b32       v22, v26, v25
        v_add_i32       v15, vcc, v15, v22
        v_xor_b32       v22, v12, v17
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        v_xor_b32       v22, v22, v16
        v_alignbit_b32  v25, v15, v15, 27
        v_add_i32       v11, vcc, v11, v22
        v_alignbit_b32  v22, v14, v14, 26
        v_add_i32       v11, vcc, v25, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v23, v23, v22
        v_add_i32       v11, vcc, v11, v23
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v23, v15, v16
        v_add_i32       v11, vcc, 0x6ed9eba1, v11
        v_xor_b32       v23, v17, v23
        v_add_i32       v12, vcc, v12, v23
        v_alignbit_b32  v23, v11, v11, 27
        v_xor_b32       v19, v19, v18
        ds_read2_b32    v[25:26], v9 offset0:33 offset1:34
        v_add_i32       v12, vcc, v12, v23
        v_xor_b32       v19, v24, v19
        v_xor_b32       v23, v11, v17
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, v12, v19
        v_xor_b32       v19, v23, v15
        v_add_i32       v12, vcc, 0x6ed9eba1, v12
        v_add_i32       v16, vcc, v16, v19
        v_alignbit_b32  v19, v12, v12, 27
        v_add_i32       v16, vcc, v16, v19
        v_xor_b32       v19, v15, v12
        v_alignbit_b32  v11, v11, v11, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v25
        v_xor_b32       v19, v19, v11
        ds_read2_b32    v[23:24], v9 offset0:35 offset1:36
        v_alignbit_b32  v25, v16, v16, 27
        v_add_i32       v17, vcc, v17, v19
        v_alignbit_b32  v19, v14, v14, 25
        v_add_i32       v17, vcc, v25, v17
        v_xor_b32       v25, v26, v19
        v_add_i32       v17, vcc, v17, v25
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v25, v16, v11
        v_add_i32       v17, vcc, 0x6ed9eba1, v17
        v_xor_b32       v25, v12, v25
        v_add_i32       v15, vcc, v15, v25
        v_alignbit_b32  v25, v17, v17, 27
        v_add_i32       v15, vcc, v15, v25
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v23, v20, v23
        v_xor_b32       v25, v17, v12
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v23
        v_xor_b32       v23, v25, v16
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        ds_read2_b32    v[25:26], v9 offset0:37 offset1:38
        v_add_i32       v11, vcc, v11, v23
        v_alignbit_b32  v23, v15, v15, 27
        v_xor_b32       v27, v20, v22
        v_add_i32       v11, vcc, v11, v23
        v_xor_b32       v23, v24, v27
        v_add_i32       v11, vcc, v11, v23
        v_xor_b32       v23, v16, v15
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, 0x6ed9eba1, v11
        v_xor_b32       v23, v23, v17
        v_alignbit_b32  v24, v11, v11, 27
        v_add_i32       v12, vcc, v12, v23
        v_alignbit_b32  v23, v14, v14, 24
        v_add_i32       v12, vcc, v24, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v24, v23, v25
        v_add_i32       v12, vcc, v12, v24
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v24, v11, v17
        v_add_i32       v12, vcc, 0x6ed9eba1, v12
        v_xor_b32       v24, v15, v24
        v_add_i32       v16, vcc, v16, v24
        v_alignbit_b32  v24, v12, v12, 27
        ds_read2_b32    v[28:29], v9 offset0:39 offset1:40
        v_add_i32       v16, vcc, v16, v24
        v_xor_b32       v24, v20, v26
        v_xor_b32       v25, v12, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v24
        v_xor_b32       v24, v25, v11
        v_add_i32       v16, vcc, 0x6ed9eba1, v16
        v_add_i32       v17, vcc, v17, v24
        v_alignbit_b32  v24, v16, v16, 27
        v_add_i32       v17, vcc, v17, v24
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v28, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_bfi_b32       v24, v11, v12, v16
        v_bfi_b32       v25, v12, 0, v16
        v_alignbit_b32  v26, v17, v17, 27
        v_alignbit_b32  v28, v14, v14, 23
        v_xor_b32       v24, v24, v25
        v_add_i32       v15, vcc, v15, v26
        v_xor_b32       v25, v20, v28
        v_add_i32       v15, vcc, v24, v15
        v_xor_b32       v24, v29, v25
        ds_read2_b32    v[25:26], v9 offset0:41 offset1:42
        v_add_i32       v15, vcc, v15, v24
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_bfi_b32       v24, v12, v16, v17
        v_bfi_b32       v28, v16, 0, v17
        v_alignbit_b32  v29, v15, v15, 27
        v_xor_b32       v24, v24, v28
        v_add_i32       v11, vcc, v11, v29
        v_add_i32       v11, vcc, v24, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v25
        v_alignbit_b32  v17, v17, v17, 2
        v_bfi_b32       v24, v16, v17, v15
        v_bfi_b32       v25, v17, 0, v15
        v_alignbit_b32  v28, v11, v11, 27
        v_xor_b32       v24, v24, v25
        v_add_i32       v12, vcc, v12, v28
        v_xor_b32       v25, v22, v23
        ds_read2_b32    v[28:29], v9 offset0:43 offset1:44
        v_add_i32       v12, vcc, v24, v12
        v_xor_b32       v24, v26, v25
        v_add_i32       v12, vcc, v12, v24
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_bfi_b32       v24, v17, v15, v11
        v_bfi_b32       v25, v15, 0, v11
        v_alignbit_b32  v26, v12, v12, 27
        v_xor_b32       v24, v24, v25
        v_add_i32       v16, vcc, v16, v26
        v_alignbit_b32  v25, v14, v14, 22
        v_add_i32       v16, vcc, v24, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v24, v28, v25
        v_add_i32       v16, vcc, v16, v24
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_alignbit_b32  v11, v11, v11, 2
        v_bfi_b32       v24, v15, v11, v12
        v_bfi_b32       v26, v11, 0, v12
        v_alignbit_b32  v28, v16, v16, 27
        v_xor_b32       v30, v18, v22
        v_xor_b32       v24, v24, v26
        v_add_i32       v17, vcc, v17, v28
        v_xor_b32       v26, v19, v30
        v_add_i32       v17, vcc, v24, v17
        v_xor_b32       v24, v29, v26
        ds_read2_b32    v[28:29], v9 offset0:45 offset1:46
        v_add_i32       v17, vcc, v17, v24
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_bfi_b32       v24, v11, v12, v16
        v_bfi_b32       v26, v12, 0, v16
        v_alignbit_b32  v30, v17, v17, 27
        v_xor_b32       v24, v24, v26
        v_add_i32       v15, vcc, v15, v30
        v_add_i32       v15, vcc, v24, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v28
        v_alignbit_b32  v16, v16, v16, 2
        v_bfi_b32       v24, v12, v16, v17
        v_bfi_b32       v26, v16, 0, v17
        v_alignbit_b32  v28, v15, v15, 27
        v_alignbit_b32  v30, v14, v14, 21
        v_xor_b32       v24, v24, v26
        v_add_i32       v11, vcc, v11, v28
        v_xor_b32       v26, v20, v30
        ds_read2_b32    v[31:32], v9 offset0:47 offset1:48
        v_add_i32       v11, vcc, v24, v11
        v_xor_b32       v24, v29, v26
        v_add_i32       v11, vcc, v11, v24
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_bfi_b32       v24, v16, v17, v15
        v_bfi_b32       v26, v17, 0, v15
        v_alignbit_b32  v28, v11, v11, 27
        v_xor_b32       v24, v24, v26
        v_add_i32       v12, vcc, v12, v28
        v_xor_b32       v26, v20, v23
        v_add_i32       v12, vcc, v24, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v24, v31, v26
        v_add_i32       v12, vcc, v12, v24
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v18, v18, v21
        v_bfi_b32       v24, v17, v15, v11
        v_bfi_b32       v28, v15, 0, v11
        v_alignbit_b32  v29, v12, v12, 27
        v_xor_b32       v18, v26, v18
        v_xor_b32       v24, v24, v28
        v_add_i32       v16, vcc, v16, v29
        v_xor_b32       v18, v25, v18
        ds_read2_b32    v[28:29], v9 offset0:49 offset1:50
        v_add_i32       v16, vcc, v24, v16
        v_xor_b32       v18, v32, v18
        v_add_i32       v16, vcc, v16, v18
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_bfi_b32       v18, v15, v11, v12
        v_bfi_b32       v24, v11, 0, v12
        v_alignbit_b32  v31, v16, v16, 27
        v_xor_b32       v18, v18, v24
        v_add_i32       v17, vcc, v17, v31
        v_alignbit_b32  v24, v14, v14, 20
        v_add_i32       v17, vcc, v18, v17
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v24, v28
        v_add_i32       v17, vcc, v17, v18
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_bfi_b32       v18, v11, v12, v16
        v_bfi_b32       v28, v12, 0, v16
        v_alignbit_b32  v31, v17, v17, 27
        v_xor_b32       v18, v18, v28
        v_add_i32       v15, vcc, v15, v31
        ds_read2_b32    v[31:32], v9 offset0:51 offset1:52
        v_add_i32       v15, vcc, v18, v15
        v_xor_b32       v18, v23, v29
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_bfi_b32       v18, v12, v16, v17
        v_bfi_b32       v28, v16, 0, v17
        v_alignbit_b32  v29, v15, v15, 27
        v_xor_b32       v18, v18, v28
        v_add_i32       v11, vcc, v11, v29
        v_add_i32       v11, vcc, v18, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v27, v31
        v_add_i32       v11, vcc, v11, v18
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_alignbit_b32  v17, v17, v17, 2
        v_bfi_b32       v18, v16, v17, v15
        v_bfi_b32       v28, v17, 0, v15
        v_alignbit_b32  v29, v11, v11, 27
        v_alignbit_b32  v31, v14, v14, 19
        v_xor_b32       v18, v18, v28
        v_add_i32       v12, vcc, v12, v29
        v_xor_b32       v28, v26, v31
        v_add_i32       v12, vcc, v18, v12
        v_xor_b32       v18, v28, v32
        ds_read2_b32    v[28:29], v9 offset0:53 offset1:54
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_bfi_b32       v18, v17, v15, v11
        v_bfi_b32       v32, v15, 0, v11
        v_alignbit_b32  v33, v12, v12, 27
        v_xor_b32       v18, v18, v32
        v_add_i32       v16, vcc, v16, v33
        v_add_i32       v16, vcc, v18, v16
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v28
        v_alignbit_b32  v11, v11, v11, 2
        v_bfi_b32       v18, v15, v11, v12
        v_bfi_b32       v28, v11, 0, v12
        v_alignbit_b32  v32, v16, v16, 27
        v_xor_b32       v33, v19, v25
        v_xor_b32       v18, v18, v28
        v_add_i32       v17, vcc, v17, v32
        v_xor_b32       v28, v24, v33
        ds_read2_b32    v[32:33], v9 offset0:55 offset1:56
        v_add_i32       v17, vcc, v18, v17
        v_xor_b32       v18, v28, v29
        v_add_i32       v17, vcc, v17, v18
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_bfi_b32       v18, v11, v12, v16
        v_bfi_b32       v28, v12, 0, v16
        v_alignbit_b32  v29, v17, v17, 27
        v_xor_b32       v18, v18, v28
        v_add_i32       v15, vcc, v15, v29
        v_alignbit_b32  v28, v14, v14, 18
        v_add_i32       v15, vcc, v18, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v28, v32
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v18, v19, v27
        v_bfi_b32       v29, v12, v16, v17
        v_bfi_b32       v32, v16, 0, v17
        v_alignbit_b32  v34, v15, v15, 27
        v_xor_b32       v25, v25, v18
        v_xor_b32       v29, v29, v32
        v_add_i32       v11, vcc, v11, v34
        v_xor_b32       v25, v30, v25
        ds_read2_b32    v[34:35], v9 offset0:57 offset1:58
        v_add_i32       v11, vcc, v29, v11
        v_xor_b32       v25, v25, v33
        v_add_i32       v11, vcc, v11, v25
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_bfi_b32       v25, v16, v17, v15
        v_bfi_b32       v29, v17, 0, v15
        v_alignbit_b32  v32, v11, v11, 27
        v_xor_b32       v25, v25, v29
        v_add_i32       v12, vcc, v12, v32
        v_add_i32       v12, vcc, v25, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v25, v23, v34
        v_add_i32       v12, vcc, v12, v25
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_alignbit_b32  v15, v15, v15, 2
        v_bfi_b32       v25, v17, v15, v11
        v_bfi_b32       v29, v15, 0, v11
        v_alignbit_b32  v32, v12, v12, 27
        v_alignbit_b32  v33, v14, v14, 17
        v_xor_b32       v25, v25, v29
        v_add_i32       v16, vcc, v16, v32
        v_xor_b32       v26, v26, v33
        ds_read2_b32    v[36:37], v9 offset0:59 offset1:60
        v_add_i32       v16, vcc, v25, v16
        v_xor_b32       v25, v26, v35
        v_add_i32       v16, vcc, v16, v25
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_bfi_b32       v25, v15, v11, v12
        v_bfi_b32       v26, v11, 0, v12
        v_alignbit_b32  v29, v16, v16, 27
        v_xor_b32       v25, v25, v26
        v_add_i32       v17, vcc, v17, v29
        v_xor_b32       v26, v23, v24
        v_add_i32       v17, vcc, v25, v17
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v25, v26, v36
        v_add_i32       v17, vcc, v17, v25
        v_xor_b32       v25, v11, v16
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v20, v20, v19
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_xor_b32       v25, v25, v12
        v_xor_b32       v20, v26, v20
        ds_read2_b32    v[34:35], v9 offset0:61 offset1:62
        v_alignbit_b32  v29, v17, v17, 27
        v_add_i32       v15, vcc, v15, v25
        v_xor_b32       v20, v28, v20
        v_add_i32       v15, vcc, v29, v15
        v_xor_b32       v20, v20, v37
        v_add_i32       v15, vcc, v15, v20
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v20, v17, v12
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_xor_b32       v20, v16, v20
        v_add_i32       v11, vcc, v11, v20
        v_alignbit_b32  v20, v15, v15, 27
        v_alignbit_b32  v25, v14, v14, 16
        v_add_i32       v11, vcc, v11, v20
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v20, v25, v34
        v_xor_b32       v29, v15, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, v11, v20
        v_xor_b32       v20, v29, v17
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        ds_read2_b32    v[36:37], v9 offset0:63 offset1:64
        v_add_i32       v12, vcc, v12, v20
        v_alignbit_b32  v20, v11, v11, 27
        v_xor_b32       v27, v27, v26
        v_add_i32       v12, vcc, v12, v20
        v_xor_b32       v20, v27, v35
        v_add_i32       v12, vcc, v12, v20
        v_xor_b32       v20, v17, v11
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0xca62c1d6, v12
        v_xor_b32       v20, v20, v15
        v_alignbit_b32  v27, v12, v12, 27
        v_add_i32       v16, vcc, v16, v20
        v_add_i32       v16, vcc, v27, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v20, v23, v36
        v_add_i32       v16, vcc, v16, v20
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v20, v12, v15
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        v_xor_b32       v20, v11, v20
        v_xor_b32       v18, v18, v26
        v_alignbit_b32  v26, v14, v14, 15
        v_add_i32       v17, vcc, v17, v20
        v_alignbit_b32  v20, v16, v16, 27
        v_xor_b32       v18, v18, v26
        ds_read2_b32    v[26:27], v9 offset0:65 offset1:66
        v_add_i32       v17, vcc, v17, v20
        v_xor_b32       v18, v18, v37
        v_xor_b32       v20, v16, v11
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, v17, v18
        v_xor_b32       v18, v20, v12
        v_add_i32       v17, vcc, 0xca62c1d6, v17
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v18, v17, v17, 27
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v12, v17
        v_alignbit_b32  v16, v16, v16, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v26
        v_xor_b32       v18, v18, v16
        ds_read2_b32    v[34:35], v9 offset0:67 offset1:68
        v_alignbit_b32  v20, v15, v15, 27
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v28, v25
        v_add_i32       v11, vcc, v20, v11
        v_xor_b32       v18, v18, v27
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v18, v15, v16
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_xor_b32       v18, v17, v18
        v_alignbit_b32  v20, v14, v14, 14
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v18, v11, v11, 27
        v_xor_b32       v26, v23, v20
        v_add_i32       v12, vcc, v12, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v26, v34
        v_xor_b32       v26, v11, v17
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, v12, v18
        v_xor_b32       v18, v26, v15
        v_add_i32       v12, vcc, 0xca62c1d6, v12
        v_xor_b32       v26, v30, v28
        v_add_i32       v16, vcc, v16, v18
        v_alignbit_b32  v18, v12, v12, 27
        v_xor_b32       v26, v33, v26
        ds_read2_b32    v[36:37], v9 offset0:69 offset1:70
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v26, v35
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v15, v12
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        v_xor_b32       v18, v18, v11
        v_alignbit_b32  v26, v16, v16, 27
        v_add_i32       v17, vcc, v17, v18
        v_add_i32       v17, vcc, v26, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v18, v16, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v36
        v_xor_b32       v18, v12, v18
        v_alignbit_b32  v26, v14, v14, 13
        ds_read2_b32    v[34:35], v9 offset0:71 offset1:72
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v18, v17, v17, 27
        v_xor_b32       v26, v24, v26
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v26, v37
        v_xor_b32       v26, v17, v12
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v26, v16
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v18, v15, v15, 27
        v_xor_b32       v26, v24, v25
        v_xor_b32       v21, v21, v30
        v_add_i32       v11, vcc, v11, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v26, v34
        v_xor_b32       v21, v24, v21
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v16, v15
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v21, v31, v21
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_xor_b32       v18, v18, v17
        v_xor_b32       v21, v25, v21
        ds_read2_b32    v[26:27], v9 offset0:73 offset1:74
        v_alignbit_b32  v29, v11, v11, 27
        v_add_i32       v12, vcc, v12, v18
        v_xor_b32       v18, v20, v21
        v_add_i32       v12, vcc, v29, v12
        v_xor_b32       v18, v18, v35
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v18, v11, v17
        v_add_i32       v12, vcc, 0xca62c1d6, v12
        v_xor_b32       v18, v15, v18
        v_add_i32       v16, vcc, v16, v18
        v_alignbit_b32  v18, v12, v12, 27
        v_alignbit_b32  v21, v14, v14, 12
        v_add_i32       v16, vcc, v16, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v21, v26
        v_xor_b32       v26, v12, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v26, v11
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        ds_read2_b32    v[29:30], v9 offset0:75 offset1:76
        v_add_i32       v17, vcc, v17, v18
        v_alignbit_b32  v18, v16, v16, 27
        v_xor_b32       v26, v23, v25
        v_add_i32       v17, vcc, v17, v18
        v_xor_b32       v18, v26, v27
        v_add_i32       v17, vcc, v17, v18
        v_xor_b32       v18, v11, v16
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0xca62c1d6, v17
        v_xor_b32       v18, v18, v12
        v_xor_b32       v22, v22, v24
        v_alignbit_b32  v26, v17, v17, 27
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v28, v22
        v_add_i32       v15, vcc, v26, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v18, v29
        v_xor_b32       v19, v19, v23
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v18, v17, v12
        v_xor_b32       v22, v24, v19
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_xor_b32       v18, v16, v18
        v_xor_b32       v22, v25, v22
        v_alignbit_b32  v24, v14, v14, 11
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v18, v15, v15, 27
        v_xor_b32       v22, v22, v24
        ds_read2_b32    v[24:25], v9 offset0:77 offset1:78
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v22, v30
        v_xor_b32       v22, v15, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v22, v17
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v18, v11, v11, 27
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v18, v17, v11
        v_xor_b32       v19, v33, v19
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, v12, v24
        v_xor_b32       v18, v15, v18
        v_xor_b32       v19, v20, v19
        ds_read_b32     v9, v9 offset:316
        v_alignbit_b32  v20, v8, v8, 27
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v21, v19
        v_add_i32       v16, vcc, v20, v16
        v_xor_b32       v18, v18, v25
        v_xor_b32       v15, v8, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v11, v15, v11
        v_add_i32       v15, vcc, 0xca62c1d6, v16
        v_alignbit_b32  v14, v14, v14, 10
        v_add_i32       v11, vcc, v17, v11
        v_alignbit_b32  v15, v15, v15, 27
        v_xor_b32       v14, v23, v14
        v_add_i32       v11, vcc, v11, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v9, v14, v9
        v_add_i32       v9, vcc, v11, v9
        v_add_i32       v9, vcc, 0x31a7e4d7, v9
        v_lshrrev_b32   v11, 20, v9
        v_mov_b32       v14, 0x140
        v_mad_u32_u24   v11, v14, 1, v11
        ds_read_u8      v11, v11
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v11, v11, 0, 8
        v_cmp_lg_i32    s[36:37], v11, 0
        s_mov_b64       s[38:39], exec
        s_andn2_b64     exec, s[38:39], s[36:37]
        v_lshrrev_b32   v11, 8, v9
        s_cbranch_execz .L12440_0
        v_add_i32       v11, vcc, s7, v11
        buffer_load_ubyte v11, v11, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[40:41], v11, 0
        s_and_saveexec_b64 s[42:43], s[40:41]
        v_lshrrev_b32   v11, 2, v9
        s_cbranch_execz .L12412_0
        v_alignbit_b32  v12, v8, v8, 2
        v_add_i32       v21, vcc, 0x98badcfe, v12
        v_add_i32       v8, vcc, 0xba306d5f, v16
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[44:45], exec
        s_mov_b64       s[46:47], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v7, s5
        v_mov_b32       v16, 0
        v_mov_b32       v17, s0
        s_movk_i32      s48, 0x0
        s_movk_i32      s49, 0x0
.L12288_0:
        v_cmp_gt_i32    s[50:51], v16, v17
        v_cmp_eq_i32    vcc, v11, v7
        s_andn2_b64     s[48:49], s[48:49], exec
        s_or_b64        s[48:49], vcc, s[48:49]
        s_or_b64        vcc, s[50:51], vcc
        s_and_saveexec_b64 s[50:51], vcc
        s_andn2_b64     s[46:47], s[46:47], exec
        s_cbranch_scc0  .L12380_0
        s_mov_b64       exec, s[46:47]
        v_add_i32       v15, vcc, v16, v17
        v_ashrrev_i32   v15, 1, v15
        v_lshlrev_b32   v18, 2, v15
        v_add_i32       v18, vcc, s4, v18
        v_add_i32       v19, vcc, -1, v15
        v_add_i32       v15, vcc, 1, v15
        tbuffer_load_format_x v7, v18, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v7, v11
        v_cndmask_b32   v17, v17, v19, vcc
        v_cndmask_b32   v16, v15, v16, vcc
        s_branch        .L12288_0
.L12380_0:
        s_mov_b64       exec, s[44:45]
        s_and_saveexec_b64 s[44:45], s[48:49]
        v_mov_b32       v7, 1
        s_cbranch_execz .L12404_0
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L12476_0
.L12404_0:
        s_and_b64       exec, s[44:45], s[22:23]
        v_mov_b32       v7, 1
.L12412_0:
        s_andn2_b64     exec, s[42:43], exec
        s_and_b64       exec, exec, s[22:23]
        v_cndmask_b32   v21, 0, -1, s[40:41]
        s_cbranch_execz .L12436_0
        v_mov_b32       v7, 0
.L12436_0:
        s_and_b64       exec, s[42:43], s[22:23]
.L12440_0:
        s_andn2_b64     exec, s[38:39], exec
        s_and_b64       exec, exec, s[22:23]
        v_cndmask_b32   v21, 0, -1, s[36:37]
        s_cbranch_execz .L12464_0
        v_mov_b32       v7, 0
.L12464_0:
        s_and_b64       exec, s[38:39], s[22:23]
        v_add_i32       v6, vcc, 1, v6
        s_branch        .L7492_0
.L12476_0:
        s_mov_b64       exec, s[12:13]
        v_cmp_eq_i32    vcc, 0, v7
        s_and_saveexec_b64 s[4:5], vcc
        v_mov_b32       v0, 0x400
        s_cbranch_execz .L12508_0
        tbuffer_store_format_x v0, v5, s[24:27], 0 offen format:[32,float]
.L12508_0:
        s_andn2_b64     exec, s[4:5], exec
        s_cbranch_execz .L12944_0
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_lshrrev_b32   v10, 26, v9
        v_add_i32       v10, vcc, s1, v10
        v_bfe_u32       v11, v9, 20, 6
        v_add_i32       v11, vcc, s1, v11
        v_bfe_u32       v12, v9, 14, 6
        v_add_i32       v12, vcc, s1, v12
        v_bfe_u32       v14, v9, 8, 6
        v_add_i32       v14, vcc, s1, v14
        v_bfe_u32       v15, v9, 2, 6
        v_lshrrev_b32   v16, 28, v8
        v_lshlrev_b32   v9, 4, v9
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v10, v10, s[8:11], 0 offen
        v_add_i32       v15, vcc, s1, v15
        v_bfi_b32       v9, 48, v9, v16
        buffer_load_ubyte v11, v11, s[8:11], 0 offen
        v_add_i32       v9, vcc, s1, v9
        v_bfe_u32       v16, v8, 22, 6
        buffer_load_ubyte v12, v12, s[8:11], 0 offen
        v_add_i32       v16, vcc, s1, v16
        v_bfe_u32       v17, v8, 16, 6
        buffer_load_ubyte v14, v14, s[8:11], 0 offen
        v_add_i32       v17, vcc, s1, v17
        v_bfe_u32       v18, v8, 10, 6
        buffer_load_ubyte v15, v15, s[8:11], 0 offen
        v_add_i32       v18, vcc, s1, v18
        v_bfe_u32       v19, v8, 4, 6
        v_lshrrev_b32   v20, 30, v21
        v_lshlrev_b32   v8, 2, v8
        buffer_load_ubyte v9, v9, s[8:11], 0 offen
        v_add_i32       v19, vcc, s1, v19
        v_bfi_b32       v8, 60, v8, v20
        buffer_load_ubyte v16, v16, s[8:11], 0 offen
        v_add_i32       v8, vcc, s1, v8
        v_bfe_u32       v7, v21, 24, 6
        buffer_load_ubyte v17, v17, s[8:11], 0 offen
        v_add_i32       v7, vcc, s1, v7
        buffer_load_ubyte v18, v18, s[8:11], 0 offen
        buffer_load_ubyte v19, v19, s[8:11], 0 offen
        buffer_load_ubyte v8, v8, s[8:11], 0 offen
        buffer_load_ubyte v7, v7, s[8:11], 0 offen
        buffer_store_byte v4, v5, s[24:27], 0 offen offset:17 glc
        buffer_store_byte v2, v5, s[24:27], 0 offen offset:18 glc
        buffer_store_byte v38, v5, s[24:27], 0 offen offset:19 glc
        buffer_store_byte v39, v5, s[24:27], 0 offen offset:20 glc
        buffer_store_byte v13, v5, s[24:27], 0 offen offset:24 glc
        buffer_store_byte v3, v5, s[24:27], 0 offen offset:28 glc
        buffer_store_byte v10, v5, s[24:27], 0 offen offset:5 glc
        buffer_store_byte v11, v5, s[24:27], 0 offen offset:6 glc
        buffer_store_byte v12, v5, s[24:27], 0 offen offset:7 glc
        buffer_store_byte v14, v5, s[24:27], 0 offen offset:8 glc
        buffer_store_byte v15, v5, s[24:27], 0 offen offset:9 glc
        buffer_store_byte v9, v5, s[24:27], 0 offen offset:10 glc
        buffer_store_byte v16, v5, s[24:27], 0 offen offset:11 glc
        buffer_store_byte v17, v5, s[24:27], 0 offen offset:12 glc
        buffer_store_byte v18, v5, s[24:27], 0 offen offset:13 glc
        v_mov_b32       v0, 1
        buffer_store_byte v19, v5, s[24:27], 0 offen offset:14 glc
        v_add_i32       v1, vcc, 1, v6
        buffer_store_byte v8, v5, s[24:27], 0 offen offset:15 glc
        buffer_store_byte v7, v5, s[24:27], 0 offen offset:16 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:4 glc
        tbuffer_store_format_x v1, v5, s[24:27], 0 offen format:[32,float]
.L12944_0:
        s_endpgm
.kernel OpenCL_SHA1_PerformSearching_BackwardMatching
    .header
        .fill 8, 1, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x40, 0x11, 0x00, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
        .fill 8, 1, 0x00
    .metadata
        .ascii ";ARGSTART:__OpenCL_OpenCL_SHA1_PerformSearching_BackwardMatching_kernel\n"
        .ascii ";version:3:1:111\n"
        .ascii ";device:tahiti\n"
        .ascii ";uniqueid:1025\n"
        .ascii ";memory:uavprivate:0\n"
        .ascii ";memory:hwlocal:4416\n"
        .ascii ";memory:hwregion:0\n"
        .ascii ";pointer:outputArray:struct:1:1:0:uav:12:32:RW:0:0\n"
        .ascii ";pointer:key:u8:1:1:16:c:13:1:RO:0:0\n"
        .ascii ";constarg:1:key\n"
        .ascii ";pointer:tripcodeChunkArray:u32:1:1:32:uav:14:4:RO:0:0\n"
        .ascii ";constarg:2:tripcodeChunkArray\n"
        .ascii ";value:numTripcodeChunk:u32:1:1:48\n"
        .ascii ";pointer:keyCharTable_OneByte:u8:1:1:64:c:11:1:RO:0:0\n"
        .ascii ";constarg:4:keyCharTable_OneByte\n"
        .ascii ";pointer:keyCharTable_FirstByte:u8:1:1:80:c:15:1:RO:0:0\n"
        .ascii ";constarg:5:keyCharTable_FirstByte\n"
        .ascii ";pointer:keyCharTable_SecondByte:u8:1:1:96:c:11:1:RO:0:0\n"
        .ascii ";constarg:6:keyCharTable_SecondByte\n"
        .ascii ";pointer:keyCharTable_SecondByteAndOneByte:u8:1:1:112:c:16:1:RO:0:0\n"
        .ascii ";constarg:7:keyCharTable_SecondByteAndOneByte\n"
        .ascii ";pointer:smallChunkBitmap_constant:u8:1:1:128:c:17:1:RO:0:0\n"
        .ascii ";constarg:8:smallChunkBitmap_constant\n"
        .ascii ";pointer:chunkBitmap:u8:1:1:144:uav:18:1:RO:0:0\n"
        .ascii ";constarg:9:chunkBitmap\n"
        .ascii ";memory:datareqd\n"
        .ascii ";function:1:1036\n"
        .ascii ";uavid:11\n"
        .ascii ";printfid:9\n"
        .ascii ";cbid:10\n"
        .ascii ";privateid:8\n"
        .ascii ";reflection:0:GPUOutput*\n"
        .ascii ";reflection:1:uchar*\n"
        .ascii ";reflection:2:uint*\n"
        .ascii ";reflection:3:uint\n"
        .ascii ";reflection:4:uchar*\n"
        .ascii ";reflection:5:uchar*\n"
        .ascii ";reflection:6:uchar*\n"
        .ascii ";reflection:7:uchar*\n"
        .ascii ";reflection:8:uchar*\n"
        .ascii ";reflection:9:uchar*\n"
        .ascii ";ARGEND:__OpenCL_OpenCL_SHA1_PerformSearching_BackwardMatching_kernel\n"
    .data
        .fill 4736, 1, 0x00
    .inputs
    .outputs
    .uav
        .entry 12, 4, 0, 5
        .entry 14, 4, 0, 5
        .entry 18, 4, 0, 5
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
        .cbmask 13, 0
        .cbmask 11, 0
        .cbmask 15, 0
        .cbmask 11, 0
        .cbmask 16, 0
        .cbmask 17, 0
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
        .entry 0x80001041, 0x00000036
        .entry 0x80001042, 0x00000034
        .entry 0x80001863, 0x00000066
        .entry 0x80001864, 0x00000100
        .entry 0x80001043, 0x000000c0
        .entry 0x80001044, 0x00000000
        .entry 0x80001045, 0x00000000
        .entry 0x00002e13, 0x00090098
        .entry 0x8000001c, 0x00000100
        .entry 0x8000001d, 0x00000000
        .entry 0x8000001e, 0x00000000
        .entry 0x80001841, 0x00000000
        .entry 0x8000001f, 0x0007f400
        .entry 0x80001843, 0x0007f400
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
        .entry 0x80000082, 0x00001200
    .subconstantbuffers
    .uavmailboxsize 0
    .uavopmask
        .byte 0x00, 0xf4, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00
        .fill 120, 1, 0x00
    .text
        s_mov_b32       m0, 0x8000
        s_buffer_load_dword s0, s[8:11], 0x4
        s_load_dwordx4  s[16:19], s[2:3], 0x68
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v1, s0
        buffer_load_ubyte v2, v1, s[16:19], 0 offen offset:1
        buffer_load_ubyte v3, v1, s[16:19], 0 offen offset:11
        buffer_load_ubyte v4, v1, s[16:19], 0 offen
        s_buffer_load_dword s1, s[4:7], 0x4
        s_buffer_load_dword s13, s[4:7], 0x18
        s_buffer_load_dword s14, s[4:7], 0x1c
        s_buffer_load_dword s15, s[8:11], 0x14
        s_buffer_load_dword s20, s[8:11], 0x1c
        s_buffer_load_dword s21, s[8:11], 0x0
        s_waitcnt       lgkmcnt(0)
        s_min_u32       s1, s1, 0xffff
        s_mul_i32       s1, s12, s1
        s_add_u32       s1, s1, s13
        s_add_u32       s12, s12, s14
        v_add_i32       v5, vcc, s1, v0
        s_ashr_i32      s1, s12, 6
        v_and_b32       v6, 63, v0
        s_and_b32       s12, s12, 63
        s_load_dwordx4  s[24:27], s[2:3], 0x60
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x80
        v_lshlrev_b32   v5, 5, v5
        s_add_u32       s1, s1, s20
        s_waitcnt       vmcnt(2)
        v_add_i32       v2, vcc, v2, v6
        s_add_u32       s12, s12, s15
        v_add_i32       v5, vcc, s21, v5
        v_mov_b32       v6, 0
        s_waitcnt       vmcnt(1)
        v_add_i32       v3, vcc, s1, v3
        v_add_i32       v2, vcc, s20, v2
        s_waitcnt       vmcnt(0)
        v_add_i32       v4, vcc, s12, v4
        buffer_load_ubyte v7, v1, s[16:19], 0 offen offset:2
        buffer_load_ubyte v1, v1, s[16:19], 0 offen offset:3
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v3, v3, s[32:35], 0 offen
        buffer_load_ubyte v2, v2, s[32:35], 0 offen
        buffer_load_ubyte v4, v4, s[28:31], 0 offen
        s_buffer_load_dword s1, s[4:7], 0x20
        s_buffer_load_dword s4, s[8:11], 0x8
        s_buffer_load_dword s5, s[8:11], 0xc
        s_buffer_load_dword s6, s[8:11], 0x20
        s_buffer_load_dword s7, s[8:11], 0x24
        buffer_store_byte v6, v5, s[24:27], 0 offen offset:4 glc
        v_cmp_eq_i32    vcc, 0, v0
        s_and_saveexec_b64 s[8:9], vcc
        s_cbranch_execz .L4656_1
        s_load_dwordx4  s[36:39], s[2:3], 0x88
        s_movk_i32      s10, 0x0
        s_movk_i32      s11, 0x100
.L268_1:
        s_cmp_gt_u32    s11, 0
        s_cbranch_scc0  .L4656_1
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s12, s6, s10
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s12
        s_add_u32       s12, s10, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 1
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 2
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 3
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 4
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 5
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 6
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 7
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 8
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 9
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 10
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 11
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 12
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 13
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 14
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 15
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 16
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 17
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 18
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 19
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 20
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 22
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 23
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:16
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:17
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:18
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:19
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:20
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:21
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:22
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:23
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 24
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 25
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 26
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 27
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 28
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 29
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 30
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 31
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:24
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:25
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:26
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:27
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:28
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:29
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:30
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:31
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 32
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 33
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 34
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 35
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 36
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 37
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 38
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 39
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:32
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:33
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:34
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:35
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:36
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:37
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:38
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:39
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 40
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 41
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 42
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 43
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 44
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 45
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 46
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 47
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:40
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:41
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:42
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:43
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:44
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:45
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:46
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:47
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 48
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 49
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 50
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 51
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 52
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 53
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 54
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 55
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:48
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:49
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:50
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:51
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:52
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:53
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:54
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:55
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 56
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 57
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 58
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 59
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 60
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 61
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 62
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 63
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:56
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:57
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:58
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:59
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:60
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:61
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:62
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:63
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s12, 0x140
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s10, s10, 64
        s_add_u32       s12, s10, 0x140
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x141
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x142
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x143
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x144
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x145
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x146
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:64
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:65
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:66
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:67
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:68
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:69
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:70
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:71
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x147
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x148
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x149
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x14a
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x14b
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x14c
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x14d
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x14e
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:72
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:73
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:74
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:75
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:76
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:77
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:78
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:79
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x14f
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x150
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x151
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x152
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x153
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x154
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x155
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x156
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:80
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:81
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:82
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:83
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:84
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:85
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:86
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:87
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x157
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x158
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x159
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x15a
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x15b
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x15c
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x15d
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x15e
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:88
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:89
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:90
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:91
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:92
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:93
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:94
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:95
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x15f
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x160
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x161
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x162
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x163
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x164
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x165
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x166
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:96
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:97
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:98
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:99
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:100
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:101
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:102
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:103
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x167
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x168
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x169
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x16a
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x16b
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x16c
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x16d
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x16e
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:104
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:105
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:106
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:107
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:108
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:109
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:110
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:111
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x16f
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x170
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x171
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x172
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x173
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x174
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x175
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x176
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:112
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:113
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:114
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:115
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:116
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:117
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:118
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:119
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x177
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 0x178
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 0x179
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 0x17a
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 0x17b
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 0x17c
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 0x17d
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 0x17e
        v_mov_b32       v14, s12
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:120
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:121
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:122
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:123
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:124
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:125
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:126
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:127
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        s_add_u32       s12, s10, 0x17f
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 64
        s_sub_i32       s11, s11, 8
        s_branch        .L268_1
.L4656_1:
        s_mov_b64       exec, s[8:9]
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s0
        buffer_load_ubyte v8, v6, s[16:19], 0 offen offset:5
        buffer_load_ubyte v9, v6, s[16:19], 0 offen offset:4
        buffer_load_ubyte v10, v6, s[16:19], 0 offen offset:6
        buffer_load_ubyte v11, v6, s[16:19], 0 offen offset:8
        buffer_load_ubyte v12, v6, s[16:19], 0 offen offset:9
        buffer_load_ubyte v13, v6, s[16:19], 0 offen offset:7
        buffer_load_ubyte v6, v6, s[16:19], 0 offen offset:10
        s_waitcnt       vmcnt(6)
        v_lshlrev_b32   v8, 16, v8
        s_waitcnt       vmcnt(5)
        v_lshlrev_b32   v9, 24, v9
        v_or_b32        v8, v8, v9
        s_waitcnt       vmcnt(4)
        v_lshlrev_b32   v9, 8, v10
        s_waitcnt       vmcnt(3)
        v_lshlrev_b32   v10, 24, v11
        s_movk_i32      s0, 0xff
        v_or_b32        v8, v8, v9
        v_bfi_b32       v9, s0, v3, v10
        s_waitcnt       vmcnt(2)
        v_lshlrev_b32   v10, 16, v12
        s_waitcnt       vmcnt(1)
        v_or_b32        v8, v13, v8
        v_mov_b32       v11, 0
        v_or_b32        v9, v9, v10
        s_waitcnt       vmcnt(0)
        v_lshlrev_b32   v6, 8, v6
        ds_write2_b32   v11, v11, v8 offset1:1
        v_or_b32        v6, v9, v6
        v_mov_b32       v9, 0x80000000
        ds_write2_b32   v11, v6, v9 offset0:2 offset1:3
        ds_write2_b32   v11, v11, v11 offset0:4 offset1:5
        ds_write2_b32   v11, v11, v11 offset0:6 offset1:7
        ds_write2_b32   v11, v11, v11 offset0:8 offset1:9
        ds_write2_b32   v11, v11, v11 offset0:10 offset1:11
        ds_write2_b32   v11, v11, v11 offset0:12 offset1:13
        v_mov_b32       v9, 0x60
        v_alignbit_b32  v10, v6, v6, 31
        v_xor_b32       v8, 0x80000000, v8
        ds_write2_b32   v11, v11, v9 offset0:14 offset1:15
        v_xor_b32       v6, 0x60, v6
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v9, 0x80000000, v10
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v12, v8, v8, 31
        ds_write2_b32   v11, v10, v8 offset0:16 offset1:17
        ds_write2_b32   v11, v6, v9 offset0:18 offset1:19
        v_alignbit_b32  v14, v6, v6, 31
        v_xor_b32       v15, 0x60, v12
        v_alignbit_b32  v16, v9, v9, 31
        ds_write2_b32   v11, v12, v14 offset0:20 offset1:21
        v_alignbit_b32  v15, v15, v15, 31
        ds_write2_b32   v11, v16, v15 offset0:22 offset1:23
        ds_read2_b32    v[17:18], v11 offset0:10 offset1:10
        ds_read2_b32    v[19:20], v11 offset0:11 offset1:11
        ds_read2_b32    v[21:22], v11 offset0:14 offset1:14
        ds_read_b32     v23, v11 offset:64
        ds_read2_b32    v[24:25], v11 offset0:12 offset1:12
        ds_read2_b32    v[26:27], v11 offset0:13 offset1:13
        v_xor_b32       v28, v6, v15
        v_xor_b32       v10, v10, v14
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v17, v17, v28
        v_xor_b32       v28, v16, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v28, v28, v28, 31
        v_xor_b32       v29, v9, v10
        v_xor_b32       v30, v14, v17
        v_xor_b32       v19, v19, v29
        v_xor_b32       v29, 0x60, v30
        v_xor_b32       v30, v12, v28
        v_alignbit_b32  v19, v19, v19, 31
        ds_write2_b32   v11, v10, v28 offset0:24 offset1:25
        v_xor_b32       v26, v26, v29
        v_xor_b32       v24, v24, v30
        ds_write2_b32   v11, v17, v19 offset0:26 offset1:27
        v_alignbit_b32  v26, v26, v26, 31
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v24, v26 offset0:28 offset1:29
        v_xor_b32       v29, v16, v19
        v_xor_b32       v15, v15, v24
        ds_read2_b32    v[30:31], v11 offset0:17 offset1:17
        ds_read2_b32    v[32:33], v11 offset0:18 offset1:18
        v_xor_b32       v29, v23, v29
        v_xor_b32       v8, v8, v15
        v_xor_b32       v15, v21, v29
        v_xor_b32       v8, 0x60, v8
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v21, v26, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read2_b32    v[34:35], v11 offset0:21 offset1:21
        ds_read2_b32    v[36:37], v11 offset0:23 offset1:23
        ds_read_b32     v29, v11 offset:76
        ds_read2_b32    v[38:39], v11 offset0:20 offset1:20
        v_xor_b32       v6, v6, v21
        v_xor_b32       v21, v28, v15
        v_xor_b32       v40, v17, v8
        v_xor_b32       v6, v23, v6
        v_xor_b32       v9, v9, v21
        v_xor_b32       v12, v12, v40
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v30, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v12, v32, v12
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v21, v19, v6
        v_xor_b32       v23, v24, v9
        v_xor_b32       v14, v14, v21
        v_xor_b32       v21, v26, v12
        ds_write2_b32   v11, v15, v8 offset0:30 offset1:31
        v_xor_b32       v23, v16, v23
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v14, v29, v14
        v_xor_b32       v21, v36, v21
        ds_write2_b32   v11, v6, v9 offset0:32 offset1:33
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v23, v38, v23
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v21, v34, v21
        v_alignbit_b32  v23, v23, v23, 31
        ds_write2_b32   v11, v12, v14 offset0:34 offset1:35
        v_alignbit_b32  v21, v21, v21, 31
        ds_write2_b32   v11, v23, v21 offset0:36 offset1:37
        ds_read_b32     v29, v11 offset:96
        v_xor_b32       v15, v15, v14
        ds_read_b32     v30, v11 offset:100
        v_xor_b32       v32, v23, v8
        v_xor_b32       v10, v10, v15
        v_xor_b32       v15, v6, v21
        ds_read_b32     v34, v11 offset:112
        ds_read_b32     v38, v11 offset:120
        ds_read2_b32    v[40:41], v11 offset0:26 offset1:26
        ds_read2_b32    v[42:43], v11 offset0:27 offset1:27
        v_xor_b32       v28, v28, v32
        v_xor_b32       v10, v16, v10
        v_xor_b32       v15, v17, v15
        v_xor_b32       v16, v36, v28
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v15, v29, v15
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v17, v9, v10
        v_xor_b32       v17, v19, v17
        v_xor_b32       v19, v14, v15
        v_xor_b32       v28, v12, v16
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v17, v30, v17
        v_xor_b32       v19, v26, v19
        v_xor_b32       v24, v24, v28
        v_alignbit_b32  v17, v17, v17, 31
        ds_write2_b32   v11, v10, v16 offset0:38 offset1:39
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v42, v19
        v_xor_b32       v24, v40, v24
        ds_write2_b32   v11, v15, v17 offset0:40 offset1:41
        v_alignbit_b32  v19, v19, v19, 31
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v24, v19 offset0:42 offset1:43
        v_xor_b32       v28, v23, v17
        v_xor_b32       v21, v21, v24
        ds_read_b32     v29, v11 offset:124
        ds_read_b32     v30, v11 offset:128
        v_xor_b32       v28, v38, v28
        v_xor_b32       v8, v8, v21
        v_xor_b32       v21, v34, v28
        v_xor_b32       v8, v26, v8
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v26, v19, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v28, v11 offset:140
        ds_read_b32     v32, v11 offset:148
        ds_read2_b32    v[44:45], v11 offset0:33 offset1:33
        ds_read_b32     v34, v11 offset:136
        v_xor_b32       v6, v6, v26
        v_xor_b32       v26, v16, v21
        v_xor_b32       v36, v15, v8
        v_xor_b32       v6, v38, v6
        v_xor_b32       v9, v9, v26
        v_xor_b32       v12, v12, v36
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v29, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v12, v30, v12
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v26, v17, v6
        v_xor_b32       v29, v24, v9
        v_xor_b32       v14, v14, v26
        v_xor_b32       v26, v19, v12
        ds_write2_b32   v11, v21, v8 offset0:44 offset1:45
        v_xor_b32       v29, v23, v29
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v14, v44, v14
        v_xor_b32       v26, v32, v26
        ds_write2_b32   v11, v6, v9 offset0:46 offset1:47
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v29, v34, v29
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v26, v28, v26
        v_alignbit_b32  v28, v29, v29, 31
        ds_write2_b32   v11, v12, v14 offset0:48 offset1:49
        v_alignbit_b32  v26, v26, v26, 31
        ds_write2_b32   v11, v28, v26 offset0:50 offset1:51
        ds_read_b32     v29, v11 offset:152
        v_xor_b32       v21, v21, v14
        ds_read2_b32    v[46:47], v11 offset0:39 offset1:39
        v_xor_b32       v30, v28, v8
        v_xor_b32       v10, v10, v21
        v_xor_b32       v21, v6, v26
        ds_read_b32     v34, v11 offset:168
        ds_read_b32     v36, v11 offset:176
        ds_read_b32     v38, v11 offset:160
        ds_read2_b32    v[48:49], v11 offset0:41 offset1:41
        v_xor_b32       v16, v16, v30
        v_xor_b32       v10, v23, v10
        v_xor_b32       v15, v15, v21
        v_xor_b32       v16, v32, v16
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v15, v29, v15
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v21, v9, v10
        v_xor_b32       v17, v17, v21
        v_xor_b32       v21, v14, v15
        v_xor_b32       v23, v12, v16
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v17, v46, v17
        v_xor_b32       v21, v19, v21
        v_xor_b32       v23, v24, v23
        v_alignbit_b32  v17, v17, v17, 31
        ds_write2_b32   v11, v10, v16 offset0:52 offset1:53
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v21, v48, v21
        v_xor_b32       v23, v38, v23
        ds_write2_b32   v11, v15, v17 offset0:54 offset1:55
        v_alignbit_b32  v21, v21, v21, 31
        v_alignbit_b32  v23, v23, v23, 31
        ds_write2_b32   v11, v23, v21 offset0:56 offset1:57
        v_xor_b32       v24, v28, v17
        v_xor_b32       v26, v26, v23
        ds_read2_b32    v[29:30], v11 offset0:45 offset1:45
        ds_read_b32     v32, v11 offset:184
        v_xor_b32       v24, v36, v24
        v_xor_b32       v8, v8, v26
        v_xor_b32       v24, v34, v24
        v_xor_b32       v8, v19, v8
        v_alignbit_b32  v19, v24, v24, 31
        v_xor_b32       v24, v21, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v26, v11 offset:196
        ds_read_b32     v34, v11 offset:204
        ds_read_b32     v38, v11 offset:188
        ds_read_b32     v40, v11 offset:192
        v_xor_b32       v6, v6, v24
        v_xor_b32       v24, v16, v19
        v_xor_b32       v42, v15, v8
        v_xor_b32       v6, v36, v6
        v_xor_b32       v9, v9, v24
        v_xor_b32       v12, v12, v42
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v29, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v12, v32, v12
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v24, v17, v6
        v_xor_b32       v29, v23, v9
        v_xor_b32       v14, v14, v24
        v_xor_b32       v24, v21, v12
        ds_write2_b32   v11, v19, v8 offset0:58 offset1:59
        v_xor_b32       v29, v28, v29
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v14, v38, v14
        v_xor_b32       v24, v34, v24
        ds_write2_b32   v11, v6, v9 offset0:60 offset1:61
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v29, v40, v29
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v24, v26, v24
        v_alignbit_b32  v26, v29, v29, 31
        ds_write2_b32   v11, v12, v14 offset0:62 offset1:63
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v26, v24 offset0:64 offset1:65
        ds_read_b32     v29, v11 offset:208
        v_xor_b32       v19, v19, v14
        ds_read2_b32    v[50:51], v11 offset0:53 offset1:53
        v_xor_b32       v32, v26, v8
        v_xor_b32       v10, v10, v19
        v_xor_b32       v19, v6, v24
        ds_read_b32     v36, v11 offset:224
        ds_read_b32     v38, v11 offset:232
        ds_read_b32     v40, v11 offset:216
        ds_read_b32     v42, v11 offset:220
        v_xor_b32       v16, v16, v32
        v_xor_b32       v10, v28, v10
        v_xor_b32       v15, v15, v19
        v_xor_b32       v16, v34, v16
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v15, v29, v15
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v19, v9, v10
        v_xor_b32       v17, v17, v19
        v_xor_b32       v19, v14, v15
        v_xor_b32       v28, v12, v16
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v17, v50, v17
        v_xor_b32       v19, v21, v19
        v_xor_b32       v23, v23, v28
        v_alignbit_b32  v17, v17, v17, 31
        ds_write2_b32   v11, v10, v16 offset0:66 offset1:67
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v42, v19
        v_xor_b32       v23, v40, v23
        ds_write2_b32   v11, v15, v17 offset0:68 offset1:69
        v_alignbit_b32  v19, v19, v19, 31
        v_alignbit_b32  v23, v23, v23, 31
        ds_write2_b32   v11, v23, v19 offset0:70 offset1:71
        v_xor_b32       v28, v26, v17
        v_xor_b32       v24, v24, v23
        ds_read_b32     v29, v11 offset:236
        ds_read_b32     v32, v11 offset:240
        v_xor_b32       v28, v38, v28
        v_xor_b32       v8, v8, v24
        v_xor_b32       v24, v36, v28
        v_xor_b32       v8, v21, v8
        v_alignbit_b32  v21, v24, v24, 31
        v_xor_b32       v10, v19, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v24, v11 offset:252
        ds_read2_b32    v[52:53], v11 offset0:65 offset1:65
        ds_read_b32     v28, v11 offset:244
        ds_read_b32     v34, v11 offset:248
        v_xor_b32       v6, v6, v10
        v_xor_b32       v10, v16, v21
        v_xor_b32       v15, v15, v8
        v_xor_b32       v6, v38, v6
        v_xor_b32       v9, v9, v10
        v_xor_b32       v10, v12, v15
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v29, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v10, v32, v10
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v12, v17, v6
        v_xor_b32       v15, v23, v9
        v_xor_b32       v12, v14, v12
        v_xor_b32       v14, v19, v10
        ds_write2_b32   v11, v21, v8 offset0:72 offset1:73
        v_xor_b32       v8, v26, v15
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v12, v28, v12
        v_xor_b32       v21, v52, v14
        ds_write2_b32   v11, v6, v9 offset0:74 offset1:75
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v6, v34, v8
        v_alignbit_b32  v8, v12, v12, 31
        v_xor_b32       v9, v24, v21
        v_alignbit_b32  v6, v6, v6, 31
        ds_write2_b32   v11, v10, v8 offset0:76 offset1:77
        v_alignbit_b32  v8, v9, v9, 31
        ds_write2_b32   v11, v6, v8 offset0:78 offset1:79
        ds_read_b32     v6, v11 offset:4
        ds_read_b32     v8, v11 offset:8
        ds_read_b32     v9, v11 offset:12
        ds_read_b32     v10, v11 offset:16
        v_mov_b32       v12, 0x5a827999
        s_waitcnt       lgkmcnt(3)
        v_add_i32       v6, vcc, v6, v12
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v8, vcc, v8, v12
        ds_write_b32    v11, v6 offset:4
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v6, vcc, v9, v12
        ds_write_b32    v11, v8 offset:8
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v8, vcc, v12, v10
        ds_write_b32    v11, v6 offset:12
        ds_write_b32    v11, v8 offset:16
        ds_read_b32     v6, v11 offset:20
        ds_read_b32     v8, v11 offset:28
        ds_read_b32     v9, v11 offset:32
        ds_read_b32     v10, v11 offset:24
        s_waitcnt       lgkmcnt(3)
        v_add_i32       v6, vcc, v6, v12
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, v10, v12
        ds_write_b32    v11, v6 offset:20
        v_add_i32       v6, vcc, v8, v12
        ds_write_b32    v11, v10 offset:24
        v_add_i32       v8, vcc, v9, v12
        ds_write_b32    v11, v6 offset:28
        ds_write_b32    v11, v8 offset:32
        ds_read_b32     v6, v11 offset:36
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, v6, v12
        v_add_i32       v40, vcc, v18, v12
        ds_write_b32    v11, v6 offset:36
        v_add_i32       v6, vcc, v20, v12
        ds_write_b32    v11, v40 offset:40
        v_add_i32       v9, vcc, v25, v12
        ds_write_b32    v11, v6 offset:44
        ds_write_b32    v11, v9 offset:48
        v_add_i32       v6, vcc, v27, v12
        v_add_i32       v9, vcc, v22, v12
        ds_write_b32    v11, v6 offset:52
        ds_write_b32    v11, v9 offset:56
        ds_read_b32     v6, v11 offset:60
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, v6, v12
        ds_write_b32    v11, v6 offset:60
        v_add_i32       v6, vcc, v31, v12
        v_add_i32       v9, vcc, v33, v12
        s_nop           0x0
        ds_write_b32    v11, v6 offset:68
        ds_write_b32    v11, v9 offset:72
        v_add_i32       v6, vcc, 0x6ed9eba1, v39
        v_add_i32       v9, vcc, 0x6ed9eba1, v35
        ds_write_b32    v11, v6 offset:80
        ds_write_b32    v11, v9 offset:84
        v_add_i32       v6, vcc, 0x6ed9eba1, v37
        ds_write_b32    v11, v6 offset:92
        v_add_i32       v39, vcc, 0x6ed9eba1, v41
        v_add_i32       v9, vcc, 0x6ed9eba1, v43
        ds_write_b32    v11, v39 offset:104
        ds_write_b32    v11, v9 offset:108
        ds_read_b32     v9, v11 offset:116
        s_waitcnt       lgkmcnt(0)
        s_nop           0x0
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v11, v9 offset:116
        v_add_i32       v9, vcc, 0x6ed9eba1, v45
        ds_write_b32    v11, v9 offset:132
        v_add_i32       v9, vcc, 0x6ed9eba1, v47
        ds_write_b32    v11, v9 offset:156
        v_add_i32       v9, vcc, 0x8f1bbcdc, v49
        ds_write_b32    v11, v9 offset:164
        v_add_i32       v9, vcc, 0x8f1bbcdc, v30
        ds_write_b32    v11, v9 offset:180
        v_add_i32       v9, vcc, 0x8f1bbcdc, v51
        ds_write_b32    v11, v9 offset:212
        v_add_i32       v9, vcc, 0xca62c1d6, v53
        ds_write_b32    v11, v9 offset:260
        ds_read_b32     v9, v11 offset:276
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v11, v9 offset:276
        ds_read_b32     v9, v11 offset:308
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        v_lshrrev_b32   v0, 2, v0
        ds_write_b32    v11, v9 offset:308
        v_lshlrev_b32   v9, 24, v4
        v_lshlrev_b32   v38, 16, v2
        v_and_b32       v0, 48, v0
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[16:19], s[2:3], 0x90
        v_or_b32        v9, v9, v38
        v_add_i32       v0, vcc, v7, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        s_add_u32       s0, -1, s5
        s_mov_b64       s[12:13], exec
        s_mov_b64       s[22:23], exec
        v_mov_b32       v6, 0
        v_mov_b32       v22, 0x13c
        v_mov_b32       v10, v15
.L7492_1:
        s_movk_i32      s5, 0x3ff
        v_cmp_gt_i32    s[36:37], v6, s5
        s_and_saveexec_b64 s[38:39], s[36:37]
        v_cndmask_b32   v38, 0, -1, s[36:37]
        s_cbranch_execz .L7532_1
        v_mov_b32       v10, 0
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L12484_1
.L7532_1:
        s_and_b64       exec, s[38:39], s[22:23]
        v_ashrrev_i32   v7, 6, v6
        v_bfe_u32       v8, v0, 0, 8
        v_add_i32       v7, vcc, v8, v7
        v_add_i32       v7, vcc, s15, v7
        v_and_b32       v8, 63, v6
        v_add_i32       v8, vcc, v1, v8
        v_add_i32       v8, vcc, s20, v8
        buffer_load_ubyte v38, v7, s[28:31], 0 offen
        buffer_load_ubyte v39, v8, s[32:35], 0 offen
        s_waitcnt       vmcnt(0)
        s_barrier
        v_mov_b32       v10, 0
        ds_read2_b32    v[11:12], v10 offset0:1 offset1:2
        v_lshlrev_b32   v14, 8, v38
        v_or_b32        v14, v9, v14
        v_or_b32        v40, v14, v39
        v_add_i32       v15, vcc, 0x9fb498b3, v40
        v_alignbit_b32  v16, v15, v15, 27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v16, v11
        v_add_i32       v11, vcc, 0xc2e5374, v11
        v_mov_b32       v16, 0x7bf36ae2
        s_mov_b32       s5, 0x59d148c0
        v_bfi_b32       v16, v15, s5, v16
        v_alignbit_b32  v17, v11, v11, 27
        ds_read2_b32    v[18:19], v10 offset0:3 offset1:4
        v_add_i32       v16, vcc, v16, v17
        v_add_i32       v12, vcc, v12, v16
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0x98badcfe, v12
        v_bfi_b32       v16, v11, v15, s5
        v_alignbit_b32  v17, v12, v12, 27
        v_add_i32       v16, vcc, v17, v16
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v18
        v_add_i32       v16, vcc, 0x7bf36ae2, v16
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v17, v16, v16, 27
        v_bfi_b32       v18, v12, v11, v15
        v_add_i32       v17, vcc, v17, v18
        ds_read2_b32    v[20:21], v10 offset0:5 offset1:6
        v_add_i32       v17, vcc, v17, v19
        v_add_i32       v17, vcc, 0x59d148c0, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_alignbit_b32  v18, v17, v17, 27
        v_bfi_b32       v19, v16, v12, v11
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, v19, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v20
        v_alignbit_b32  v16, v16, v16, 2
        v_alignbit_b32  v18, v15, v15, 27
        v_bfi_b32       v19, v17, v16, v12
        v_add_i32       v11, vcc, v11, v18
        ds_read2_b32    v[22:23], v10 offset0:7 offset1:8
        v_add_i32       v11, vcc, v19, v11
        v_add_i32       v11, vcc, v21, v11
        v_alignbit_b32  v18, v11, v11, 27
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v12, vcc, v12, v18
        v_bfi_b32       v18, v15, v17, v16
        v_add_i32       v12, vcc, v12, v18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v22, v12
        v_alignbit_b32  v15, v15, v15, 2
        v_alignbit_b32  v18, v12, v12, 27
        v_bfi_b32       v19, v11, v15, v17
        v_add_i32       v16, vcc, v16, v18
        ds_read2_b32    v[20:21], v10 offset0:9 offset1:10
        v_add_i32       v16, vcc, v19, v16
        v_add_i32       v16, vcc, v23, v16
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v18, v16, v16, 27
        v_bfi_b32       v19, v12, v11, v15
        v_add_i32       v17, vcc, v17, v18
        v_add_i32       v17, vcc, v19, v17
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v20
        v_alignbit_b32  v18, v17, v17, 27
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v15, vcc, v15, v18
        v_bfi_b32       v18, v16, v12, v11
        ds_read2_b32    v[19:20], v10 offset0:11 offset1:12
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, v21, v15
        v_alignbit_b32  v16, v16, v16, 2
        v_alignbit_b32  v18, v15, v15, 27
        v_bfi_b32       v21, v17, v16, v12
        v_add_i32       v11, vcc, v11, v18
        v_add_i32       v11, vcc, v21, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v19, v11
        v_alignbit_b32  v17, v17, v17, 2
        v_alignbit_b32  v18, v11, v11, 27
        v_bfi_b32       v19, v15, v17, v16
        v_add_i32       v12, vcc, v12, v18
        ds_read2_b32    v[21:22], v10 offset0:13 offset1:14
        v_add_i32       v12, vcc, v19, v12
        v_add_i32       v12, vcc, v20, v12
        v_alignbit_b32  v18, v12, v12, 27
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v16, vcc, v16, v18
        v_bfi_b32       v18, v11, v15, v17
        v_add_i32       v16, vcc, v16, v18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v21
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v18, v16, v16, 27
        v_bfi_b32       v19, v12, v11, v15
        v_add_i32       v17, vcc, v17, v18
        ds_read2_b32    v[20:21], v10 offset0:15 offset1:16
        v_add_i32       v17, vcc, v19, v17
        v_add_i32       v17, vcc, v22, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_alignbit_b32  v18, v17, v17, 27
        v_bfi_b32       v19, v16, v12, v11
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, v19, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v20, v15
        v_alignbit_b32  v18, v15, v15, 27
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v11, vcc, v11, v18
        v_bfi_b32       v18, v17, v16, v12
        v_alignbit_b32  v19, v40, v40, 31
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v21, v19
        ds_read2_b32    v[19:20], v10 offset0:17 offset1:18
        v_add_i32       v11, vcc, v11, v18
        v_add_i32       v11, vcc, 0x5a827999, v11
        v_alignbit_b32  v17, v17, v17, 2
        v_alignbit_b32  v18, v11, v11, 27
        v_bfi_b32       v21, v15, v17, v16
        v_add_i32       v12, vcc, v12, v18
        v_add_i32       v12, vcc, v21, v12
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v12, v19
        v_alignbit_b32  v15, v15, v15, 2
        v_alignbit_b32  v18, v12, v12, 27
        ds_read2_b32    v[21:22], v10 offset0:19 offset1:20
        v_bfi_b32       v19, v11, v15, v17
        v_add_i32       v16, vcc, v16, v18
        v_add_i32       v16, vcc, v19, v16
        v_add_i32       v16, vcc, v20, v16
        v_alignbit_b32  v18, v16, v16, 27
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v17, vcc, v17, v18
        v_bfi_b32       v18, v12, v11, v15
        v_alignbit_b32  v19, v40, v40, 30
        v_add_i32       v17, vcc, v17, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v21, v19
        v_add_i32       v17, vcc, v17, v18
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v18, v16, v11
        v_add_i32       v17, vcc, 0x5a827999, v17
        v_xor_b32       v18, v12, v18
        ds_read2_b32    v[20:21], v10 offset0:21 offset1:22
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v18, v17, v17, 27
        v_xor_b32       v23, v17, v12
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v23, v16
        v_add_i32       v15, vcc, v22, v15
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v18, v15, v15, 27
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v16, v15
        v_alignbit_b32  v17, v17, v17, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v20
        v_xor_b32       v18, v18, v17
        v_alignbit_b32  v20, v11, v11, 27
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v18, v40, v40, 29
        ds_read2_b32    v[22:23], v10 offset0:23 offset1:24
        v_add_i32       v12, vcc, v20, v12
        v_xor_b32       v20, v21, v18
        v_add_i32       v12, vcc, v12, v20
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v20, v11, v17
        v_add_i32       v12, vcc, 0x6ed9eba1, v12
        v_xor_b32       v20, v15, v20
        v_add_i32       v16, vcc, v16, v20
        v_alignbit_b32  v20, v12, v12, 27
        v_xor_b32       v21, v12, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v20
        v_xor_b32       v20, v21, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v22, v16
        ds_read2_b32    v[21:22], v10 offset0:25 offset1:26
        v_add_i32       v17, vcc, v17, v20
        v_alignbit_b32  v20, v16, v16, 27
        v_add_i32       v17, vcc, v17, v20
        v_xor_b32       v20, v19, v23
        v_add_i32       v17, vcc, v17, v20
        v_xor_b32       v20, v11, v16
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0x6ed9eba1, v17
        v_xor_b32       v20, v20, v12
        v_alignbit_b32  v23, v17, v17, 27
        v_add_i32       v15, vcc, v15, v20
        v_alignbit_b32  v20, v40, v40, 28
        v_add_i32       v15, vcc, v23, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v21, v20, v21
        v_add_i32       v15, vcc, v15, v21
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v21, v17, v12
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        v_xor_b32       v21, v16, v21
        ds_read2_b32    v[23:24], v10 offset0:27 offset1:28
        v_add_i32       v11, vcc, v11, v21
        v_alignbit_b32  v21, v15, v15, 27
        v_xor_b32       v25, v15, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, v11, v21
        v_xor_b32       v21, v25, v17
        v_add_i32       v11, vcc, v22, v11
        v_add_i32       v12, vcc, v12, v21
        v_alignbit_b32  v21, v11, v11, 27
        v_add_i32       v12, vcc, v12, v21
        v_xor_b32       v21, v17, v11
        v_alignbit_b32  v15, v15, v15, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v23, v12
        v_xor_b32       v21, v21, v15
        v_alignbit_b32  v22, v12, v12, 27
        v_add_i32       v16, vcc, v16, v21
        v_alignbit_b32  v21, v40, v40, 27
        ds_read2_b32    v[25:26], v10 offset0:29 offset1:30
        v_add_i32       v16, vcc, v22, v16
        v_xor_b32       v22, v24, v21
        v_add_i32       v16, vcc, v16, v22
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v22, v12, v15
        v_add_i32       v16, vcc, 0x6ed9eba1, v16
        v_xor_b32       v22, v11, v22
        v_add_i32       v17, vcc, v17, v22
        v_alignbit_b32  v22, v16, v16, 27
        v_xor_b32       v23, v16, v11
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, v17, v22
        v_xor_b32       v22, v23, v12
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v25
        ds_read2_b32    v[23:24], v10 offset0:31 offset1:32
        v_add_i32       v15, vcc, v15, v22
        v_alignbit_b32  v22, v17, v17, 27
        v_xor_b32       v25, v19, v20
        v_add_i32       v15, vcc, v15, v22
        v_xor_b32       v22, v26, v25
        v_add_i32       v15, vcc, v15, v22
        v_xor_b32       v22, v12, v17
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        v_xor_b32       v22, v22, v16
        v_alignbit_b32  v25, v15, v15, 27
        v_add_i32       v11, vcc, v11, v22
        v_alignbit_b32  v22, v40, v40, 26
        v_add_i32       v11, vcc, v25, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v23, v23, v22
        v_add_i32       v11, vcc, v11, v23
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v23, v15, v16
        v_add_i32       v11, vcc, 0x6ed9eba1, v11
        v_xor_b32       v23, v17, v23
        v_add_i32       v12, vcc, v12, v23
        v_alignbit_b32  v23, v11, v11, 27
        v_xor_b32       v19, v19, v18
        ds_read2_b32    v[25:26], v10 offset0:33 offset1:34
        v_add_i32       v12, vcc, v12, v23
        v_xor_b32       v19, v24, v19
        v_xor_b32       v23, v11, v17
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, v12, v19
        v_xor_b32       v19, v23, v15
        v_add_i32       v12, vcc, 0x6ed9eba1, v12
        v_add_i32       v16, vcc, v16, v19
        v_alignbit_b32  v19, v12, v12, 27
        v_add_i32       v16, vcc, v16, v19
        v_xor_b32       v19, v15, v12
        v_alignbit_b32  v11, v11, v11, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v25
        v_xor_b32       v19, v19, v11
        ds_read2_b32    v[23:24], v10 offset0:35 offset1:36
        v_alignbit_b32  v25, v16, v16, 27
        v_add_i32       v17, vcc, v17, v19
        v_alignbit_b32  v19, v40, v40, 25
        v_add_i32       v17, vcc, v25, v17
        v_xor_b32       v25, v26, v19
        v_add_i32       v17, vcc, v17, v25
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v25, v16, v11
        v_add_i32       v17, vcc, 0x6ed9eba1, v17
        v_xor_b32       v25, v12, v25
        v_add_i32       v15, vcc, v15, v25
        v_alignbit_b32  v25, v17, v17, 27
        v_add_i32       v15, vcc, v15, v25
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v23, v20, v23
        v_xor_b32       v25, v17, v12
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v23
        v_xor_b32       v23, v25, v16
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        ds_read2_b32    v[25:26], v10 offset0:37 offset1:38
        v_add_i32       v11, vcc, v11, v23
        v_alignbit_b32  v23, v15, v15, 27
        v_xor_b32       v27, v20, v22
        v_add_i32       v11, vcc, v11, v23
        v_xor_b32       v23, v24, v27
        v_add_i32       v11, vcc, v11, v23
        v_xor_b32       v23, v16, v15
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, 0x6ed9eba1, v11
        v_xor_b32       v23, v23, v17
        v_alignbit_b32  v24, v11, v11, 27
        v_add_i32       v12, vcc, v12, v23
        v_alignbit_b32  v23, v40, v40, 24
        v_add_i32       v12, vcc, v24, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v24, v23, v25
        v_add_i32       v12, vcc, v12, v24
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v24, v11, v17
        v_add_i32       v12, vcc, 0x6ed9eba1, v12
        v_xor_b32       v24, v15, v24
        v_add_i32       v16, vcc, v16, v24
        v_alignbit_b32  v24, v12, v12, 27
        ds_read2_b32    v[28:29], v10 offset0:39 offset1:40
        v_add_i32       v16, vcc, v16, v24
        v_xor_b32       v24, v20, v26
        v_xor_b32       v25, v12, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v24
        v_xor_b32       v24, v25, v11
        v_add_i32       v16, vcc, 0x6ed9eba1, v16
        v_add_i32       v17, vcc, v17, v24
        v_alignbit_b32  v24, v16, v16, 27
        v_add_i32       v17, vcc, v17, v24
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v28, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_bfi_b32       v24, v11, v12, v16
        v_bfi_b32       v25, v12, 0, v16
        v_alignbit_b32  v26, v17, v17, 27
        v_alignbit_b32  v28, v40, v40, 23
        v_xor_b32       v24, v24, v25
        v_add_i32       v15, vcc, v15, v26
        v_xor_b32       v25, v20, v28
        v_add_i32       v15, vcc, v24, v15
        v_xor_b32       v24, v29, v25
        ds_read2_b32    v[25:26], v10 offset0:41 offset1:42
        v_add_i32       v15, vcc, v15, v24
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_bfi_b32       v24, v12, v16, v17
        v_bfi_b32       v28, v16, 0, v17
        v_alignbit_b32  v29, v15, v15, 27
        v_xor_b32       v24, v24, v28
        v_add_i32       v11, vcc, v11, v29
        v_add_i32       v11, vcc, v24, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v25
        v_alignbit_b32  v17, v17, v17, 2
        v_bfi_b32       v24, v16, v17, v15
        v_bfi_b32       v25, v17, 0, v15
        v_alignbit_b32  v28, v11, v11, 27
        v_xor_b32       v24, v24, v25
        v_add_i32       v12, vcc, v12, v28
        v_xor_b32       v25, v22, v23
        ds_read2_b32    v[28:29], v10 offset0:43 offset1:44
        v_add_i32       v12, vcc, v24, v12
        v_xor_b32       v24, v26, v25
        v_add_i32       v12, vcc, v12, v24
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_bfi_b32       v24, v17, v15, v11
        v_bfi_b32       v25, v15, 0, v11
        v_alignbit_b32  v26, v12, v12, 27
        v_xor_b32       v24, v24, v25
        v_add_i32       v16, vcc, v16, v26
        v_alignbit_b32  v25, v40, v40, 22
        v_add_i32       v16, vcc, v24, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v24, v28, v25
        v_add_i32       v16, vcc, v16, v24
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_alignbit_b32  v11, v11, v11, 2
        v_bfi_b32       v24, v15, v11, v12
        v_bfi_b32       v26, v11, 0, v12
        v_alignbit_b32  v28, v16, v16, 27
        v_xor_b32       v30, v18, v22
        v_xor_b32       v24, v24, v26
        v_add_i32       v17, vcc, v17, v28
        v_xor_b32       v26, v19, v30
        v_add_i32       v17, vcc, v24, v17
        v_xor_b32       v24, v29, v26
        ds_read2_b32    v[28:29], v10 offset0:45 offset1:46
        v_add_i32       v17, vcc, v17, v24
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_bfi_b32       v24, v11, v12, v16
        v_bfi_b32       v26, v12, 0, v16
        v_alignbit_b32  v30, v17, v17, 27
        v_xor_b32       v24, v24, v26
        v_add_i32       v15, vcc, v15, v30
        v_add_i32       v15, vcc, v24, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v28
        v_alignbit_b32  v16, v16, v16, 2
        v_bfi_b32       v24, v12, v16, v17
        v_bfi_b32       v26, v16, 0, v17
        v_alignbit_b32  v28, v15, v15, 27
        v_alignbit_b32  v30, v40, v40, 21
        v_xor_b32       v24, v24, v26
        v_add_i32       v11, vcc, v11, v28
        v_xor_b32       v26, v20, v30
        ds_read2_b32    v[31:32], v10 offset0:47 offset1:48
        v_add_i32       v11, vcc, v24, v11
        v_xor_b32       v24, v29, v26
        v_add_i32       v11, vcc, v11, v24
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_bfi_b32       v24, v16, v17, v15
        v_bfi_b32       v26, v17, 0, v15
        v_alignbit_b32  v28, v11, v11, 27
        v_xor_b32       v24, v24, v26
        v_add_i32       v12, vcc, v12, v28
        v_xor_b32       v26, v20, v23
        v_add_i32       v12, vcc, v24, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v24, v31, v26
        v_add_i32       v12, vcc, v12, v24
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v18, v18, v21
        v_bfi_b32       v24, v17, v15, v11
        v_bfi_b32       v28, v15, 0, v11
        v_alignbit_b32  v29, v12, v12, 27
        v_xor_b32       v18, v26, v18
        v_xor_b32       v24, v24, v28
        v_add_i32       v16, vcc, v16, v29
        v_xor_b32       v18, v25, v18
        ds_read2_b32    v[28:29], v10 offset0:49 offset1:50
        v_add_i32       v16, vcc, v24, v16
        v_xor_b32       v18, v32, v18
        v_add_i32       v16, vcc, v16, v18
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_bfi_b32       v18, v15, v11, v12
        v_bfi_b32       v24, v11, 0, v12
        v_alignbit_b32  v31, v16, v16, 27
        v_xor_b32       v18, v18, v24
        v_add_i32       v17, vcc, v17, v31
        v_alignbit_b32  v24, v40, v40, 20
        v_add_i32       v17, vcc, v18, v17
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v24, v28
        v_add_i32       v17, vcc, v17, v18
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_bfi_b32       v18, v11, v12, v16
        v_bfi_b32       v28, v12, 0, v16
        v_alignbit_b32  v31, v17, v17, 27
        v_xor_b32       v18, v18, v28
        v_add_i32       v15, vcc, v15, v31
        ds_read2_b32    v[31:32], v10 offset0:51 offset1:52
        v_add_i32       v15, vcc, v18, v15
        v_xor_b32       v18, v23, v29
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_bfi_b32       v18, v12, v16, v17
        v_bfi_b32       v28, v16, 0, v17
        v_alignbit_b32  v29, v15, v15, 27
        v_xor_b32       v18, v18, v28
        v_add_i32       v11, vcc, v11, v29
        v_add_i32       v11, vcc, v18, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v27, v31
        v_add_i32       v11, vcc, v11, v18
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_alignbit_b32  v17, v17, v17, 2
        v_bfi_b32       v18, v16, v17, v15
        v_bfi_b32       v28, v17, 0, v15
        v_alignbit_b32  v29, v11, v11, 27
        v_alignbit_b32  v31, v40, v40, 19
        v_xor_b32       v18, v18, v28
        v_add_i32       v12, vcc, v12, v29
        v_xor_b32       v28, v26, v31
        v_add_i32       v12, vcc, v18, v12
        v_xor_b32       v18, v28, v32
        ds_read2_b32    v[28:29], v10 offset0:53 offset1:54
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_bfi_b32       v18, v17, v15, v11
        v_bfi_b32       v32, v15, 0, v11
        v_alignbit_b32  v33, v12, v12, 27
        v_xor_b32       v18, v18, v32
        v_add_i32       v16, vcc, v16, v33
        v_add_i32       v16, vcc, v18, v16
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v28
        v_alignbit_b32  v11, v11, v11, 2
        v_bfi_b32       v18, v15, v11, v12
        v_bfi_b32       v28, v11, 0, v12
        v_alignbit_b32  v32, v16, v16, 27
        v_xor_b32       v33, v19, v25
        v_xor_b32       v18, v18, v28
        v_add_i32       v17, vcc, v17, v32
        v_xor_b32       v28, v24, v33
        ds_read2_b32    v[32:33], v10 offset0:55 offset1:56
        v_add_i32       v17, vcc, v18, v17
        v_xor_b32       v18, v28, v29
        v_add_i32       v17, vcc, v17, v18
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_bfi_b32       v18, v11, v12, v16
        v_bfi_b32       v28, v12, 0, v16
        v_alignbit_b32  v29, v17, v17, 27
        v_xor_b32       v18, v18, v28
        v_add_i32       v15, vcc, v15, v29
        v_alignbit_b32  v28, v40, v40, 18
        v_add_i32       v15, vcc, v18, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v28, v32
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v18, v19, v27
        v_bfi_b32       v29, v12, v16, v17
        v_bfi_b32       v32, v16, 0, v17
        v_alignbit_b32  v34, v15, v15, 27
        v_xor_b32       v25, v25, v18
        v_xor_b32       v29, v29, v32
        v_add_i32       v11, vcc, v11, v34
        v_xor_b32       v25, v30, v25
        ds_read2_b32    v[34:35], v10 offset0:57 offset1:58
        v_add_i32       v11, vcc, v29, v11
        v_xor_b32       v25, v25, v33
        v_add_i32       v11, vcc, v11, v25
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_bfi_b32       v25, v16, v17, v15
        v_bfi_b32       v29, v17, 0, v15
        v_alignbit_b32  v32, v11, v11, 27
        v_xor_b32       v25, v25, v29
        v_add_i32       v12, vcc, v12, v32
        v_add_i32       v12, vcc, v25, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v25, v23, v34
        v_add_i32       v12, vcc, v12, v25
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_alignbit_b32  v15, v15, v15, 2
        v_bfi_b32       v25, v17, v15, v11
        v_bfi_b32       v29, v15, 0, v11
        v_alignbit_b32  v32, v12, v12, 27
        v_alignbit_b32  v33, v40, v40, 17
        v_xor_b32       v25, v25, v29
        v_add_i32       v16, vcc, v16, v32
        v_xor_b32       v26, v26, v33
        ds_read2_b32    v[36:37], v10 offset0:59 offset1:60
        v_add_i32       v16, vcc, v25, v16
        v_xor_b32       v25, v26, v35
        v_add_i32       v16, vcc, v16, v25
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_bfi_b32       v25, v15, v11, v12
        v_bfi_b32       v26, v11, 0, v12
        v_alignbit_b32  v29, v16, v16, 27
        v_xor_b32       v25, v25, v26
        v_add_i32       v17, vcc, v17, v29
        v_xor_b32       v26, v23, v24
        v_add_i32       v17, vcc, v25, v17
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v25, v26, v36
        v_add_i32       v17, vcc, v17, v25
        v_xor_b32       v25, v11, v16
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v20, v20, v19
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_xor_b32       v25, v25, v12
        v_xor_b32       v20, v26, v20
        ds_read2_b32    v[34:35], v10 offset0:61 offset1:62
        v_alignbit_b32  v29, v17, v17, 27
        v_add_i32       v15, vcc, v15, v25
        v_xor_b32       v20, v28, v20
        v_add_i32       v15, vcc, v29, v15
        v_xor_b32       v20, v20, v37
        v_add_i32       v15, vcc, v15, v20
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v20, v17, v12
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_xor_b32       v20, v16, v20
        v_add_i32       v11, vcc, v11, v20
        v_alignbit_b32  v20, v15, v15, 27
        v_alignbit_b32  v25, v40, v40, 16
        v_add_i32       v11, vcc, v11, v20
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v20, v25, v34
        v_xor_b32       v29, v15, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, v11, v20
        v_xor_b32       v20, v29, v17
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        ds_read2_b32    v[36:37], v10 offset0:63 offset1:64
        v_add_i32       v12, vcc, v12, v20
        v_alignbit_b32  v20, v11, v11, 27
        v_xor_b32       v27, v27, v26
        v_add_i32       v12, vcc, v12, v20
        v_xor_b32       v20, v27, v35
        v_add_i32       v12, vcc, v12, v20
        v_xor_b32       v20, v17, v11
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0xca62c1d6, v12
        v_xor_b32       v20, v20, v15
        v_alignbit_b32  v27, v12, v12, 27
        v_add_i32       v16, vcc, v16, v20
        v_add_i32       v16, vcc, v27, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v20, v23, v36
        v_add_i32       v16, vcc, v16, v20
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v20, v12, v15
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        v_xor_b32       v20, v11, v20
        v_xor_b32       v18, v18, v26
        v_alignbit_b32  v26, v40, v40, 15
        v_add_i32       v17, vcc, v17, v20
        v_alignbit_b32  v20, v16, v16, 27
        v_xor_b32       v18, v18, v26
        ds_read2_b32    v[26:27], v10 offset0:65 offset1:66
        v_add_i32       v17, vcc, v17, v20
        v_xor_b32       v18, v18, v37
        v_xor_b32       v20, v16, v11
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, v17, v18
        v_xor_b32       v18, v20, v12
        v_add_i32       v17, vcc, 0xca62c1d6, v17
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v18, v17, v17, 27
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v12, v17
        v_alignbit_b32  v16, v16, v16, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v26
        v_xor_b32       v18, v18, v16
        ds_read2_b32    v[34:35], v10 offset0:67 offset1:68
        v_alignbit_b32  v20, v15, v15, 27
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v28, v25
        v_add_i32       v11, vcc, v20, v11
        v_xor_b32       v18, v18, v27
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v18, v15, v16
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_xor_b32       v18, v17, v18
        v_alignbit_b32  v20, v40, v40, 14
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v18, v11, v11, 27
        v_xor_b32       v26, v23, v20
        v_add_i32       v12, vcc, v12, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v26, v34
        v_xor_b32       v26, v11, v17
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, v12, v18
        v_xor_b32       v18, v26, v15
        v_add_i32       v12, vcc, 0xca62c1d6, v12
        v_xor_b32       v26, v30, v28
        v_add_i32       v16, vcc, v16, v18
        v_alignbit_b32  v18, v12, v12, 27
        v_xor_b32       v26, v33, v26
        ds_read2_b32    v[36:37], v10 offset0:69 offset1:70
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v26, v35
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v15, v12
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        v_xor_b32       v18, v18, v11
        v_alignbit_b32  v26, v16, v16, 27
        v_add_i32       v17, vcc, v17, v18
        v_add_i32       v17, vcc, v26, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v18, v16, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v36
        v_xor_b32       v18, v12, v18
        v_alignbit_b32  v26, v40, v40, 13
        ds_read2_b32    v[34:35], v10 offset0:71 offset1:72
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v18, v17, v17, 27
        v_xor_b32       v26, v24, v26
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v26, v37
        v_xor_b32       v26, v17, v12
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v26, v16
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v18, v15, v15, 27
        v_xor_b32       v26, v24, v25
        v_xor_b32       v21, v21, v30
        v_add_i32       v11, vcc, v11, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v26, v34
        v_xor_b32       v21, v24, v21
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v16, v15
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v21, v31, v21
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_xor_b32       v18, v18, v17
        v_xor_b32       v21, v25, v21
        ds_read2_b32    v[26:27], v10 offset0:73 offset1:74
        v_alignbit_b32  v29, v11, v11, 27
        v_add_i32       v12, vcc, v12, v18
        v_xor_b32       v18, v20, v21
        v_add_i32       v12, vcc, v29, v12
        v_xor_b32       v18, v18, v35
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v18, v11, v17
        v_add_i32       v12, vcc, 0xca62c1d6, v12
        v_xor_b32       v18, v15, v18
        v_add_i32       v16, vcc, v16, v18
        v_alignbit_b32  v18, v12, v12, 27
        v_alignbit_b32  v21, v40, v40, 12
        v_add_i32       v16, vcc, v16, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v21, v26
        v_xor_b32       v26, v12, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v26, v11
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        ds_read2_b32    v[29:30], v10 offset0:75 offset1:76
        v_add_i32       v17, vcc, v17, v18
        v_alignbit_b32  v18, v16, v16, 27
        v_xor_b32       v26, v23, v25
        v_add_i32       v17, vcc, v17, v18
        v_xor_b32       v18, v26, v27
        v_add_i32       v17, vcc, v17, v18
        v_xor_b32       v18, v11, v16
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0xca62c1d6, v17
        v_xor_b32       v18, v18, v12
        v_xor_b32       v22, v22, v24
        v_alignbit_b32  v26, v17, v17, 27
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v28, v22
        v_add_i32       v15, vcc, v26, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v18, v29
        v_xor_b32       v19, v19, v23
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v18, v17, v12
        v_xor_b32       v22, v24, v19
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_xor_b32       v18, v16, v18
        v_xor_b32       v22, v25, v22
        v_alignbit_b32  v24, v40, v40, 11
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v18, v15, v15, 27
        v_xor_b32       v22, v22, v24
        ds_read2_b32    v[24:25], v10 offset0:77 offset1:78
        v_add_i32       v10, vcc, v11, v18
        v_xor_b32       v11, v22, v30
        v_xor_b32       v18, v15, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v10, vcc, v10, v11
        v_xor_b32       v11, v18, v17
        v_add_i32       v10, vcc, 0xca62c1d6, v10
        v_add_i32       v11, vcc, v12, v11
        v_alignbit_b32  v12, v10, v10, 27
        v_add_i32       v11, vcc, v11, v12
        v_xor_b32       v12, v17, v10
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v18, v33, v19
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v24
        v_xor_b32       v12, v12, v15
        v_xor_b32       v18, v20, v18
        v_alignbit_b32  v19, v11, v11, 27
        v_add_i32       v12, vcc, v16, v12
        v_xor_b32       v16, v21, v18
        v_add_i32       v12, vcc, v19, v12
        v_xor_b32       v16, v16, v25
        v_add_i32       v12, vcc, v12, v16
        v_add_i32       v22, vcc, 0xba306d5f, v12
        v_bfe_u32       v18, v22, 10, 12
        ds_read_u8      v18, v18 offset:320
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v18, v18, 0, 8
        v_cmp_lg_i32    s[36:37], v18, 0
        s_mov_b64       s[38:39], exec
        s_andn2_b64     exec, s[38:39], s[36:37]
        v_alignbit_b32  v18, v11, v11, 2
        s_cbranch_execz .L12448_1
        v_add_i32       v21, vcc, 0x98badcfe, v18
        v_lshlrev_b32   v19, 8, v12
        v_add_i32       v19, vcc, 0x306d5f00, v19
        v_lshrrev_b32   v20, 24, v21
        s_mov_b32       s5, 0x3fffff00
        v_bfi_b32       v19, s5, v19, v20
        v_lshrrev_b32   v20, 6, v19
        v_add_i32       v20, vcc, s7, v20
        buffer_load_ubyte v20, v20, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v20
        s_and_saveexec_b64 s[40:41], vcc
        v_mov_b32       v20, 0
        s_cbranch_execz .L12428_1
        ds_read_b32     v20, v20 offset:316
        v_xor_b32       v11, v11, v15
        v_alignbit_b32  v10, v10, v10, 2
        v_xor_b32       v10, v11, v10
        v_add_i32       v11, vcc, 0xca62c1d6, v12
        v_alignbit_b32  v12, v40, v40, 10
        v_add_i32       v10, vcc, v17, v10
        v_alignbit_b32  v11, v11, v11, 27
        v_xor_b32       v12, v23, v12
        v_add_i32       v10, vcc, v10, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v11, v12, v20
        v_add_i32       v10, vcc, v10, v11
        s_buffer_load_dword s5, s[8:11], s4
        v_add_i32       v40, vcc, 0x31a7e4d7, v10
        s_mov_b64       s[42:43], exec
        s_mov_b64       s[44:45], exec
        v_mov_b32       v11, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v8, s5
        v_mov_b32       v14, s0
        s_movk_i32      s46, 0x0
        s_movk_i32      s47, 0x0
.L12304_1:
        v_cmp_gt_i32    s[48:49], v11, v14
        v_cmp_eq_i32    vcc, v19, v8
        s_andn2_b64     s[46:47], s[46:47], exec
        s_or_b64        s[46:47], vcc, s[46:47]
        s_or_b64        vcc, s[48:49], vcc
        s_and_saveexec_b64 s[48:49], vcc
        s_andn2_b64     s[44:45], s[44:45], exec
        s_cbranch_scc0  .L12396_1
        s_mov_b64       exec, s[44:45]
        v_add_i32       v12, vcc, v11, v14
        v_ashrrev_i32   v12, 1, v12
        v_lshlrev_b32   v15, 2, v12
        v_add_i32       v15, vcc, s4, v15
        v_add_i32       v17, vcc, -1, v12
        v_add_i32       v12, vcc, 1, v12
        tbuffer_load_format_x v8, v15, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v8, v19
        v_cndmask_b32   v14, v14, v17, vcc
        v_cndmask_b32   v11, v12, v11, vcc
        s_branch        .L12304_1
.L12396_1:
        s_mov_b64       exec, s[42:43]
        s_and_saveexec_b64 s[42:43], s[46:47]
        v_mov_b32       v10, 1
        s_cbranch_execz .L12420_1
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L12484_1
.L12420_1:
        s_and_b64       exec, s[42:43], s[22:23]
        v_mov_b32       v10, 1
.L12428_1:
        s_andn2_b64     exec, s[40:41], exec
        s_and_b64       exec, exec, s[22:23]
        v_mov_b32       v10, 0
        s_cbranch_execz .L12444_1
.L12444_1:
        s_and_b64       exec, s[40:41], s[22:23]
.L12448_1:
        s_andn2_b64     exec, s[38:39], exec
        s_and_b64       exec, exec, s[22:23]
        v_cndmask_b32   v21, 0, -1, s[36:37]
        s_cbranch_execz .L12472_1
        v_mov_b32       v10, 0
.L12472_1:
        s_and_b64       exec, s[38:39], s[22:23]
        v_add_i32       v6, vcc, 1, v6
        s_branch        .L7492_1
.L12484_1:
        s_mov_b64       exec, s[12:13]
        v_cmp_eq_i32    vcc, 0, v10
        s_and_saveexec_b64 s[4:5], vcc
        v_mov_b32       v0, 0x400
        s_cbranch_execz .L12516_1
        tbuffer_store_format_x v0, v5, s[24:27], 0 offen format:[32,float]
.L12516_1:
        s_andn2_b64     exec, s[4:5], exec
        s_cbranch_execz .L12952_1
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_lshrrev_b32   v10, 26, v40
        v_add_i32       v10, vcc, s1, v10
        v_bfe_u32       v11, v40, 20, 6
        v_add_i32       v11, vcc, s1, v11
        v_bfe_u32       v12, v40, 14, 6
        v_add_i32       v12, vcc, s1, v12
        v_bfe_u32       v14, v40, 8, 6
        v_add_i32       v14, vcc, s1, v14
        v_bfe_u32       v15, v40, 2, 6
        v_lshrrev_b32   v16, 28, v22
        v_lshlrev_b32   v7, 4, v40
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v10, v10, s[8:11], 0 offen
        v_add_i32       v15, vcc, s1, v15
        v_bfi_b32       v7, 48, v7, v16
        buffer_load_ubyte v11, v11, s[8:11], 0 offen
        v_add_i32       v7, vcc, s1, v7
        v_bfe_u32       v16, v22, 22, 6
        buffer_load_ubyte v12, v12, s[8:11], 0 offen
        v_add_i32       v16, vcc, s1, v16
        v_bfe_u32       v17, v22, 16, 6
        buffer_load_ubyte v14, v14, s[8:11], 0 offen
        v_add_i32       v17, vcc, s1, v17
        v_bfe_u32       v18, v22, 10, 6
        buffer_load_ubyte v15, v15, s[8:11], 0 offen
        v_add_i32       v18, vcc, s1, v18
        v_bfe_u32       v19, v22, 4, 6
        v_lshrrev_b32   v20, 30, v21
        v_lshlrev_b32   v8, 2, v22
        buffer_load_ubyte v7, v7, s[8:11], 0 offen
        v_add_i32       v19, vcc, s1, v19
        v_bfi_b32       v8, 60, v8, v20
        buffer_load_ubyte v16, v16, s[8:11], 0 offen
        v_add_i32       v8, vcc, s1, v8
        v_bfe_u32       v9, v21, 24, 6
        buffer_load_ubyte v17, v17, s[8:11], 0 offen
        v_add_i32       v9, vcc, s1, v9
        buffer_load_ubyte v18, v18, s[8:11], 0 offen
        buffer_load_ubyte v19, v19, s[8:11], 0 offen
        buffer_load_ubyte v8, v8, s[8:11], 0 offen
        buffer_load_ubyte v9, v9, s[8:11], 0 offen
        buffer_store_byte v4, v5, s[24:27], 0 offen offset:17 glc
        buffer_store_byte v2, v5, s[24:27], 0 offen offset:18 glc
        buffer_store_byte v38, v5, s[24:27], 0 offen offset:19 glc
        buffer_store_byte v39, v5, s[24:27], 0 offen offset:20 glc
        buffer_store_byte v13, v5, s[24:27], 0 offen offset:24 glc
        buffer_store_byte v3, v5, s[24:27], 0 offen offset:28 glc
        buffer_store_byte v10, v5, s[24:27], 0 offen offset:5 glc
        buffer_store_byte v11, v5, s[24:27], 0 offen offset:6 glc
        buffer_store_byte v12, v5, s[24:27], 0 offen offset:7 glc
        buffer_store_byte v14, v5, s[24:27], 0 offen offset:8 glc
        buffer_store_byte v15, v5, s[24:27], 0 offen offset:9 glc
        buffer_store_byte v7, v5, s[24:27], 0 offen offset:10 glc
        buffer_store_byte v16, v5, s[24:27], 0 offen offset:11 glc
        buffer_store_byte v17, v5, s[24:27], 0 offen offset:12 glc
        buffer_store_byte v18, v5, s[24:27], 0 offen offset:13 glc
        v_mov_b32       v0, 1
        buffer_store_byte v19, v5, s[24:27], 0 offen offset:14 glc
        v_add_i32       v1, vcc, 1, v6
        buffer_store_byte v8, v5, s[24:27], 0 offen offset:15 glc
        buffer_store_byte v9, v5, s[24:27], 0 offen offset:16 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:4 glc
        tbuffer_store_format_x v1, v5, s[24:27], 0 offen format:[32,float]
.L12952_1:
        s_endpgm
.kernel OpenCL_SHA1_PerformSearching_Flexible
    .header
        .fill 8, 1, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x40, 0x11, 0x00, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
        .fill 8, 1, 0x00
    .metadata
        .ascii ";ARGSTART:__OpenCL_OpenCL_SHA1_PerformSearching_Flexible_kernel\n"
        .ascii ";version:3:1:111\n"
        .ascii ";device:tahiti\n"
        .ascii ";uniqueid:1026\n"
        .ascii ";memory:uavprivate:0\n"
        .ascii ";memory:hwlocal:4416\n"
        .ascii ";memory:hwregion:0\n"
        .ascii ";pointer:outputArray:struct:1:1:0:uav:12:32:RW:0:0\n"
        .ascii ";pointer:key:u8:1:1:16:c:13:1:RO:0:0\n"
        .ascii ";constarg:1:key\n"
        .ascii ";pointer:tripcodeChunkArray:u32:1:1:32:uav:14:4:RO:0:0\n"
        .ascii ";constarg:2:tripcodeChunkArray\n"
        .ascii ";value:numTripcodeChunk:u32:1:1:48\n"
        .ascii ";pointer:keyCharTable_OneByte:u8:1:1:64:c:11:1:RO:0:0\n"
        .ascii ";constarg:4:keyCharTable_OneByte\n"
        .ascii ";pointer:keyCharTable_FirstByte:u8:1:1:80:c:15:1:RO:0:0\n"
        .ascii ";constarg:5:keyCharTable_FirstByte\n"
        .ascii ";pointer:keyCharTable_SecondByte:u8:1:1:96:c:11:1:RO:0:0\n"
        .ascii ";constarg:6:keyCharTable_SecondByte\n"
        .ascii ";pointer:keyCharTable_SecondByteAndOneByte:u8:1:1:112:c:16:1:RO:0:0\n"
        .ascii ";constarg:7:keyCharTable_SecondByteAndOneByte\n"
        .ascii ";pointer:smallChunkBitmap_constant:u8:1:1:128:c:17:1:RO:0:0\n"
        .ascii ";constarg:8:smallChunkBitmap_constant\n"
        .ascii ";pointer:chunkBitmap:u8:1:1:144:uav:18:1:RO:0:0\n"
        .ascii ";constarg:9:chunkBitmap\n"
        .ascii ";memory:datareqd\n"
        .ascii ";function:1:1037\n"
        .ascii ";uavid:11\n"
        .ascii ";printfid:9\n"
        .ascii ";cbid:10\n"
        .ascii ";privateid:8\n"
        .ascii ";reflection:0:GPUOutput*\n"
        .ascii ";reflection:1:uchar*\n"
        .ascii ";reflection:2:uint*\n"
        .ascii ";reflection:3:uint\n"
        .ascii ";reflection:4:uchar*\n"
        .ascii ";reflection:5:uchar*\n"
        .ascii ";reflection:6:uchar*\n"
        .ascii ";reflection:7:uchar*\n"
        .ascii ";reflection:8:uchar*\n"
        .ascii ";reflection:9:uchar*\n"
        .ascii ";ARGEND:__OpenCL_OpenCL_SHA1_PerformSearching_Flexible_kernel\n"
    .data
        .fill 4736, 1, 0x00
    .inputs
    .outputs
    .uav
        .entry 12, 4, 0, 5
        .entry 14, 4, 0, 5
        .entry 18, 4, 0, 5
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
        .cbmask 13, 0
        .cbmask 11, 0
        .cbmask 15, 0
        .cbmask 11, 0
        .cbmask 16, 0
        .cbmask 17, 0
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
        .entry 0x80001041, 0x00000037
        .entry 0x80001042, 0x00000044
        .entry 0x80001863, 0x00000066
        .entry 0x80001864, 0x00000100
        .entry 0x80001043, 0x000000c0
        .entry 0x80001044, 0x00000000
        .entry 0x80001045, 0x00000000
        .entry 0x00002e13, 0x00090098
        .entry 0x8000001c, 0x00000100
        .entry 0x8000001d, 0x00000000
        .entry 0x8000001e, 0x00000000
        .entry 0x80001841, 0x00000000
        .entry 0x8000001f, 0x0007f400
        .entry 0x80001843, 0x0007f400
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
        .entry 0x80000082, 0x00001200
    .subconstantbuffers
    .uavmailboxsize 0
    .uavopmask
        .byte 0x00, 0xf4, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00
        .fill 120, 1, 0x00
    .text
        s_mov_b32       m0, 0x8000
        s_buffer_load_dword s0, s[8:11], 0x4
        s_load_dwordx4  s[16:19], s[2:3], 0x68
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v1, s0
        buffer_load_ubyte v2, v1, s[16:19], 0 offen offset:1
        buffer_load_ubyte v3, v1, s[16:19], 0 offen offset:11
        buffer_load_ubyte v4, v1, s[16:19], 0 offen
        s_buffer_load_dword s1, s[4:7], 0x4
        s_buffer_load_dword s13, s[4:7], 0x18
        s_buffer_load_dword s14, s[4:7], 0x1c
        s_buffer_load_dword s15, s[8:11], 0x14
        s_buffer_load_dword s20, s[8:11], 0x1c
        s_buffer_load_dword s21, s[8:11], 0x0
        s_waitcnt       lgkmcnt(0)
        s_min_u32       s1, s1, 0xffff
        s_mul_i32       s1, s12, s1
        s_add_u32       s1, s1, s13
        s_add_u32       s12, s12, s14
        v_add_i32       v5, vcc, s1, v0
        s_ashr_i32      s1, s12, 6
        v_and_b32       v6, 63, v0
        s_and_b32       s12, s12, 63
        s_load_dwordx4  s[24:27], s[2:3], 0x60
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x80
        v_lshlrev_b32   v5, 5, v5
        s_add_u32       s1, s1, s20
        s_waitcnt       vmcnt(2)
        v_add_i32       v2, vcc, v2, v6
        s_add_u32       s12, s12, s15
        v_add_i32       v5, vcc, s21, v5
        v_mov_b32       v6, 0
        s_waitcnt       vmcnt(1)
        v_add_i32       v3, vcc, s1, v3
        v_add_i32       v2, vcc, s20, v2
        s_waitcnt       vmcnt(0)
        v_add_i32       v4, vcc, s12, v4
        buffer_load_ubyte v7, v1, s[16:19], 0 offen offset:2
        buffer_load_ubyte v1, v1, s[16:19], 0 offen offset:3
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v3, v3, s[32:35], 0 offen
        buffer_load_ubyte v2, v2, s[32:35], 0 offen
        buffer_load_ubyte v4, v4, s[28:31], 0 offen
        s_buffer_load_dword s1, s[4:7], 0x20
        s_buffer_load_dword s4, s[8:11], 0x8
        s_buffer_load_dword s5, s[8:11], 0xc
        s_buffer_load_dword s6, s[8:11], 0x20
        s_buffer_load_dword s7, s[8:11], 0x24
        buffer_store_byte v6, v5, s[24:27], 0 offen offset:4 glc
        v_cmp_eq_i32    vcc, 0, v0
        s_and_saveexec_b64 s[8:9], vcc
        s_cbranch_execz .L3940_2
        s_load_dwordx4  s[36:39], s[2:3], 0x88
        s_movk_i32      s10, 0x0
        s_movk_i32      s11, 0x100
.L268_2:
        s_cmp_gt_u32    s11, 0
        s_cbranch_scc0  .L3940_2
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s12, s6, s10
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s12
        v_mov_b32       v8, s10
        s_add_u32       s12, s10, 1
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 2
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 3
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 4
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 5
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 6
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 7
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 8
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 9
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 10
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 11
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 12
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 13
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 14
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 15
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 16
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 17
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 18
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 19
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 20
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 21
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 22
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 23
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 24
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 25
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 26
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 27
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 28
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 29
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 30
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 31
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 32
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 33
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 34
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 35
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 36
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 37
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 38
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 39
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 40
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 41
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 42
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 43
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 44
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 45
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 46
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 47
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 48
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 49
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 50
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 51
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 52
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 53
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 54
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 55
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 56
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 57
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 58
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 59
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 60
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 61
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 62
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 63
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 64
        s_add_u32       s12, s6, s10
        v_mov_b32       v6, s12
        v_mov_b32       v8, s10
        s_add_u32       s12, s10, 1
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 2
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 3
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 4
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 5
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 6
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 7
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 8
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 9
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 10
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 11
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 12
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 13
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 14
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 15
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 16
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 17
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 18
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 19
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 20
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 21
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 22
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 23
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 24
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 25
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 26
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 27
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 28
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 29
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 30
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 31
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 32
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 33
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 34
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 35
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 36
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 37
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 38
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 39
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 40
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 41
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 42
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 43
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 44
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 45
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 46
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 47
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 48
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 49
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 50
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 51
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 52
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 53
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 54
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 55
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 56
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 57
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 58
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 59
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 60
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 61
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 62
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 63
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 64
        s_sub_i32       s11, s11, 8
        s_branch        .L268_2
.L3940_2:
        s_mov_b64       exec, s[8:9]
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s0
        buffer_load_ubyte v8, v6, s[16:19], 0 offen offset:5
        buffer_load_ubyte v9, v6, s[16:19], 0 offen offset:4
        buffer_load_ubyte v10, v6, s[16:19], 0 offen offset:6
        buffer_load_ubyte v11, v6, s[16:19], 0 offen offset:8
        buffer_load_ubyte v12, v6, s[16:19], 0 offen offset:9
        buffer_load_ubyte v13, v6, s[16:19], 0 offen offset:7
        buffer_load_ubyte v6, v6, s[16:19], 0 offen offset:10
        s_waitcnt       vmcnt(6)
        v_lshlrev_b32   v8, 16, v8
        s_waitcnt       vmcnt(5)
        v_lshlrev_b32   v9, 24, v9
        v_or_b32        v8, v8, v9
        s_waitcnt       vmcnt(4)
        v_lshlrev_b32   v9, 8, v10
        s_waitcnt       vmcnt(3)
        v_lshlrev_b32   v10, 24, v11
        s_movk_i32      s0, 0xff
        v_or_b32        v8, v8, v9
        v_bfi_b32       v9, s0, v3, v10
        s_waitcnt       vmcnt(2)
        v_lshlrev_b32   v10, 16, v12
        s_waitcnt       vmcnt(1)
        v_or_b32        v8, v13, v8
        v_mov_b32       v11, 0x1000
        v_mov_b32       v12, 0
        v_or_b32        v9, v9, v10
        s_waitcnt       vmcnt(0)
        v_lshlrev_b32   v6, 8, v6
        ds_write2_b32   v11, v12, v8 offset1:1
        v_or_b32        v6, v9, v6
        v_mov_b32       v9, 0x80000000
        ds_write2_b32   v11, v6, v9 offset0:2 offset1:3
        ds_write2_b32   v11, v12, v12 offset0:4 offset1:5
        ds_write2_b32   v11, v12, v12 offset0:6 offset1:7
        ds_write2_b32   v11, v12, v12 offset0:8 offset1:9
        ds_write2_b32   v11, v12, v12 offset0:10 offset1:11
        ds_write2_b32   v11, v12, v12 offset0:12 offset1:13
        v_mov_b32       v9, 0x60
        v_alignbit_b32  v10, v6, v6, 31
        v_xor_b32       v8, 0x80000000, v8
        ds_write2_b32   v11, v12, v9 offset0:14 offset1:15
        v_xor_b32       v6, 0x60, v6
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v9, 0x80000000, v10
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v14, v8, v8, 31
        ds_write2_b32   v11, v10, v8 offset0:16 offset1:17
        ds_write2_b32   v11, v6, v9 offset0:18 offset1:19
        v_alignbit_b32  v15, v6, v6, 31
        v_xor_b32       v16, 0x60, v14
        v_alignbit_b32  v17, v9, v9, 31
        ds_write2_b32   v11, v14, v15 offset0:20 offset1:21
        v_alignbit_b32  v16, v16, v16, 31
        ds_write2_b32   v11, v17, v16 offset0:22 offset1:23
        ds_read2_b32    v[18:19], v11 offset0:10 offset1:10
        ds_read2_b32    v[20:21], v11 offset0:11 offset1:11
        ds_read2_b32    v[22:23], v11 offset0:14 offset1:14
        ds_read_b32     v24, v12 offset:4160
        ds_read2_b32    v[25:26], v11 offset0:12 offset1:12
        ds_read2_b32    v[27:28], v11 offset0:13 offset1:13
        v_xor_b32       v29, v6, v16
        v_xor_b32       v10, v10, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v18, v29
        v_xor_b32       v29, v17, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_alignbit_b32  v18, v18, v18, 31
        v_alignbit_b32  v29, v29, v29, 31
        v_xor_b32       v30, v9, v10
        v_xor_b32       v31, v15, v18
        v_xor_b32       v20, v20, v30
        v_xor_b32       v30, 0x60, v31
        v_xor_b32       v31, v14, v29
        v_alignbit_b32  v20, v20, v20, 31
        ds_write2_b32   v11, v10, v29 offset0:24 offset1:25
        v_xor_b32       v27, v27, v30
        v_xor_b32       v25, v25, v31
        ds_write2_b32   v11, v18, v20 offset0:26 offset1:27
        v_alignbit_b32  v27, v27, v27, 31
        v_alignbit_b32  v25, v25, v25, 31
        ds_write2_b32   v11, v25, v27 offset0:28 offset1:29
        v_xor_b32       v30, v17, v20
        v_xor_b32       v16, v16, v25
        ds_read2_b32    v[31:32], v11 offset0:17 offset1:17
        ds_read2_b32    v[33:34], v11 offset0:18 offset1:18
        v_xor_b32       v30, v24, v30
        v_xor_b32       v8, v8, v16
        v_xor_b32       v16, v22, v30
        v_xor_b32       v8, 0x60, v8
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v22, v27, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read2_b32    v[35:36], v11 offset0:21 offset1:21
        ds_read2_b32    v[37:38], v11 offset0:23 offset1:23
        ds_read_b32     v30, v12 offset:4172
        ds_read2_b32    v[39:40], v11 offset0:20 offset1:20
        v_xor_b32       v6, v6, v22
        v_xor_b32       v22, v29, v16
        v_xor_b32       v41, v18, v8
        v_xor_b32       v6, v24, v6
        v_xor_b32       v9, v9, v22
        v_xor_b32       v14, v14, v41
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v31, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v14, v33, v14
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v22, v20, v6
        v_xor_b32       v24, v25, v9
        v_xor_b32       v15, v15, v22
        v_xor_b32       v22, v27, v14
        ds_write2_b32   v11, v16, v8 offset0:30 offset1:31
        v_xor_b32       v24, v17, v24
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v15, v30, v15
        v_xor_b32       v22, v37, v22
        ds_write2_b32   v11, v6, v9 offset0:32 offset1:33
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v24, v39, v24
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v22, v35, v22
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v14, v15 offset0:34 offset1:35
        v_alignbit_b32  v22, v22, v22, 31
        ds_write2_b32   v11, v24, v22 offset0:36 offset1:37
        ds_read_b32     v30, v12 offset:4192
        v_xor_b32       v16, v16, v15
        ds_read_b32     v31, v12 offset:4196
        v_xor_b32       v33, v24, v8
        v_xor_b32       v10, v10, v16
        v_xor_b32       v16, v6, v22
        ds_read_b32     v35, v12 offset:4208
        ds_read_b32     v39, v12 offset:4216
        ds_read2_b32    v[41:42], v11 offset0:26 offset1:26
        ds_read2_b32    v[43:44], v11 offset0:27 offset1:27
        v_xor_b32       v29, v29, v33
        v_xor_b32       v10, v17, v10
        v_xor_b32       v16, v18, v16
        v_xor_b32       v17, v37, v29
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v16, v30, v16
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v18, v9, v10
        v_xor_b32       v18, v20, v18
        v_xor_b32       v20, v15, v16
        v_xor_b32       v29, v14, v17
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v18, v31, v18
        v_xor_b32       v20, v27, v20
        v_xor_b32       v25, v25, v29
        v_alignbit_b32  v18, v18, v18, 31
        ds_write2_b32   v11, v10, v17 offset0:38 offset1:39
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v43, v20
        v_xor_b32       v25, v41, v25
        ds_write2_b32   v11, v16, v18 offset0:40 offset1:41
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v25, v25, v25, 31
        ds_write2_b32   v11, v25, v20 offset0:42 offset1:43
        v_xor_b32       v29, v24, v18
        v_xor_b32       v22, v22, v25
        ds_read_b32     v30, v12 offset:4220
        ds_read_b32     v31, v12 offset:4224
        v_xor_b32       v29, v39, v29
        v_xor_b32       v8, v8, v22
        v_xor_b32       v22, v35, v29
        v_xor_b32       v8, v27, v8
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v27, v20, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v29, v12 offset:4236
        ds_read_b32     v33, v12 offset:4244
        ds_read2_b32    v[45:46], v11 offset0:33 offset1:33
        ds_read_b32     v35, v12 offset:4232
        v_xor_b32       v6, v6, v27
        v_xor_b32       v27, v17, v22
        v_xor_b32       v37, v16, v8
        v_xor_b32       v6, v39, v6
        v_xor_b32       v9, v9, v27
        v_xor_b32       v14, v14, v37
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v30, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v14, v31, v14
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v27, v18, v6
        v_xor_b32       v30, v25, v9
        v_xor_b32       v15, v15, v27
        v_xor_b32       v27, v20, v14
        ds_write2_b32   v11, v22, v8 offset0:44 offset1:45
        v_xor_b32       v30, v24, v30
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v15, v45, v15
        v_xor_b32       v27, v33, v27
        ds_write2_b32   v11, v6, v9 offset0:46 offset1:47
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v30, v35, v30
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v27, v29, v27
        v_alignbit_b32  v29, v30, v30, 31
        ds_write2_b32   v11, v14, v15 offset0:48 offset1:49
        v_alignbit_b32  v27, v27, v27, 31
        ds_write2_b32   v11, v29, v27 offset0:50 offset1:51
        ds_read_b32     v30, v12 offset:4248
        v_xor_b32       v22, v22, v15
        ds_read2_b32    v[47:48], v11 offset0:39 offset1:39
        v_xor_b32       v31, v29, v8
        v_xor_b32       v10, v10, v22
        v_xor_b32       v22, v6, v27
        ds_read_b32     v35, v12 offset:4264
        ds_read_b32     v37, v12 offset:4272
        ds_read_b32     v39, v12 offset:4256
        ds_read2_b32    v[49:50], v11 offset0:41 offset1:41
        v_xor_b32       v17, v17, v31
        v_xor_b32       v10, v24, v10
        v_xor_b32       v16, v16, v22
        v_xor_b32       v17, v33, v17
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v16, v30, v16
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v22, v9, v10
        v_xor_b32       v18, v18, v22
        v_xor_b32       v22, v15, v16
        v_xor_b32       v24, v14, v17
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v18, v47, v18
        v_xor_b32       v22, v20, v22
        v_xor_b32       v24, v25, v24
        v_alignbit_b32  v18, v18, v18, 31
        ds_write2_b32   v11, v10, v17 offset0:52 offset1:53
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v22, v49, v22
        v_xor_b32       v24, v39, v24
        ds_write2_b32   v11, v16, v18 offset0:54 offset1:55
        v_alignbit_b32  v22, v22, v22, 31
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v24, v22 offset0:56 offset1:57
        v_xor_b32       v25, v29, v18
        v_xor_b32       v27, v27, v24
        ds_read2_b32    v[30:31], v11 offset0:45 offset1:45
        ds_read_b32     v33, v12 offset:4280
        v_xor_b32       v25, v37, v25
        v_xor_b32       v8, v8, v27
        v_xor_b32       v25, v35, v25
        v_xor_b32       v8, v20, v8
        v_alignbit_b32  v20, v25, v25, 31
        v_xor_b32       v25, v22, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v27, v12 offset:4292
        ds_read_b32     v35, v12 offset:4300
        ds_read_b32     v39, v12 offset:4284
        ds_read_b32     v41, v12 offset:4288
        v_xor_b32       v6, v6, v25
        v_xor_b32       v25, v17, v20
        v_xor_b32       v43, v16, v8
        v_xor_b32       v6, v37, v6
        v_xor_b32       v9, v9, v25
        v_xor_b32       v14, v14, v43
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v30, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v14, v33, v14
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v25, v18, v6
        v_xor_b32       v30, v24, v9
        v_xor_b32       v15, v15, v25
        v_xor_b32       v25, v22, v14
        ds_write2_b32   v11, v20, v8 offset0:58 offset1:59
        v_xor_b32       v30, v29, v30
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v15, v39, v15
        v_xor_b32       v25, v35, v25
        ds_write2_b32   v11, v6, v9 offset0:60 offset1:61
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v30, v41, v30
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v25, v27, v25
        v_alignbit_b32  v27, v30, v30, 31
        ds_write2_b32   v11, v14, v15 offset0:62 offset1:63
        v_alignbit_b32  v25, v25, v25, 31
        ds_write2_b32   v11, v27, v25 offset0:64 offset1:65
        ds_read_b32     v30, v12 offset:4304
        v_xor_b32       v20, v20, v15
        ds_read2_b32    v[51:52], v11 offset0:53 offset1:53
        v_xor_b32       v33, v27, v8
        v_xor_b32       v10, v10, v20
        v_xor_b32       v20, v6, v25
        ds_read_b32     v37, v12 offset:4320
        ds_read_b32     v39, v12 offset:4328
        ds_read_b32     v41, v12 offset:4312
        ds_read_b32     v43, v12 offset:4316
        v_xor_b32       v17, v17, v33
        v_xor_b32       v10, v29, v10
        v_xor_b32       v16, v16, v20
        v_xor_b32       v17, v35, v17
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v16, v30, v16
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v20, v9, v10
        v_xor_b32       v18, v18, v20
        v_xor_b32       v20, v15, v16
        v_xor_b32       v29, v14, v17
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v18, v51, v18
        v_xor_b32       v20, v22, v20
        v_xor_b32       v24, v24, v29
        v_alignbit_b32  v18, v18, v18, 31
        ds_write2_b32   v11, v10, v17 offset0:66 offset1:67
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v43, v20
        v_xor_b32       v24, v41, v24
        ds_write2_b32   v11, v16, v18 offset0:68 offset1:69
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v24, v20 offset0:70 offset1:71
        v_xor_b32       v29, v27, v18
        v_xor_b32       v25, v25, v24
        ds_read_b32     v30, v12 offset:4332
        ds_read_b32     v33, v12 offset:4336
        v_xor_b32       v29, v39, v29
        v_xor_b32       v8, v8, v25
        v_xor_b32       v25, v37, v29
        v_xor_b32       v8, v22, v8
        v_alignbit_b32  v22, v25, v25, 31
        v_xor_b32       v10, v20, v10
        v_alignbit_b32  v37, v8, v8, 31
        ds_read_b32     v25, v12 offset:4348
        ds_read2_b32    v[53:54], v11 offset0:65 offset1:65
        ds_read_b32     v29, v12 offset:4340
        ds_read_b32     v35, v12 offset:4344
        v_xor_b32       v6, v6, v10
        v_xor_b32       v10, v17, v22
        v_xor_b32       v16, v16, v37
        v_xor_b32       v6, v39, v6
        v_xor_b32       v9, v9, v10
        v_xor_b32       v10, v14, v16
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v30, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v10, v33, v10
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v14, v18, v6
        v_xor_b32       v16, v24, v9
        v_xor_b32       v14, v15, v14
        v_xor_b32       v15, v20, v10
        ds_write2_b32   v11, v22, v37 offset0:72 offset1:73
        v_xor_b32       v16, v27, v16
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v14, v29, v14
        v_xor_b32       v39, v53, v15
        ds_write2_b32   v11, v6, v9 offset0:74 offset1:75
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v6, v35, v16
        v_alignbit_b32  v9, v14, v14, 31
        v_xor_b32       v14, v25, v39
        v_alignbit_b32  v6, v6, v6, 31
        ds_write2_b32   v11, v10, v9 offset0:76 offset1:77
        v_alignbit_b32  v9, v14, v14, 31
        ds_write2_b32   v11, v6, v9 offset0:78 offset1:79
        ds_read_b32     v6, v12 offset:4100
        ds_read_b32     v9, v12 offset:4104
        ds_read_b32     v10, v12 offset:4108
        ds_read_b32     v11, v12 offset:4112
        v_mov_b32       v14, 0x5a827999
        s_waitcnt       lgkmcnt(3)
        v_add_i32       v6, vcc, v6, v14
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v9, vcc, v9, v14
        ds_write_b32    v12, v6 offset:4100
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v6, vcc, v10, v14
        ds_write_b32    v12, v9 offset:4104
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v9, vcc, v14, v11
        ds_write_b32    v12, v6 offset:4108
        ds_write_b32    v12, v9 offset:4112
        ds_read_b32     v6, v12 offset:4116
        ds_read_b32     v9, v12 offset:4124
        ds_read_b32     v10, v12 offset:4128
        ds_read_b32     v11, v12 offset:4120
        s_waitcnt       lgkmcnt(3)
        v_add_i32       v6, vcc, v6, v14
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v14
        ds_write_b32    v12, v6 offset:4116
        v_add_i32       v6, vcc, v9, v14
        ds_write_b32    v12, v11 offset:4120
        v_add_i32       v9, vcc, v10, v14
        ds_write_b32    v12, v6 offset:4124
        ds_write_b32    v12, v9 offset:4128
        ds_read_b32     v6, v12 offset:4132
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, v6, v14
        v_add_i32       v35, vcc, v19, v14
        ds_write_b32    v12, v6 offset:4132
        v_add_i32       v6, vcc, v21, v14
        ds_write_b32    v12, v35 offset:4136
        v_add_i32       v10, vcc, v26, v14
        ds_write_b32    v12, v6 offset:4140
        ds_write_b32    v12, v10 offset:4144
        v_add_i32       v6, vcc, v28, v14
        v_add_i32       v10, vcc, v23, v14
        ds_write_b32    v12, v6 offset:4148
        ds_write_b32    v12, v10 offset:4152
        ds_read_b32     v6, v12 offset:4156
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, v6, v14
        ds_write_b32    v12, v6 offset:4156
        v_add_i32       v6, vcc, v32, v14
        v_add_i32       v10, vcc, v34, v14
        ds_write_b32    v12, v6 offset:4164
        ds_write_b32    v12, v10 offset:4168
        v_add_i32       v6, vcc, 0x6ed9eba1, v40
        v_add_i32       v10, vcc, 0x6ed9eba1, v36
        ds_write_b32    v12, v6 offset:4176
        ds_write_b32    v12, v10 offset:4180
        v_add_i32       v6, vcc, 0x6ed9eba1, v38
        ds_write_b32    v12, v6 offset:4188
        v_add_i32       v6, vcc, 0x6ed9eba1, v42
        v_add_i32       v10, vcc, 0x6ed9eba1, v44
        ds_write_b32    v12, v6 offset:4200
        ds_write_b32    v12, v10 offset:4204
        ds_read_b32     v6, v12 offset:4212
        s_waitcnt       lgkmcnt(0)
        s_nop           0x0
        v_add_i32       v6, vcc, 0x6ed9eba1, v6
        ds_write_b32    v12, v6 offset:4212
        v_add_i32       v6, vcc, 0x6ed9eba1, v46
        ds_write_b32    v12, v6 offset:4228
        v_add_i32       v6, vcc, 0x6ed9eba1, v48
        ds_write_b32    v12, v6 offset:4252
        v_add_i32       v6, vcc, 0x8f1bbcdc, v50
        ds_write_b32    v12, v6 offset:4260
        v_add_i32       v6, vcc, 0x8f1bbcdc, v31
        ds_write_b32    v12, v6 offset:4276
        v_add_i32       v6, vcc, 0x8f1bbcdc, v52
        ds_write_b32    v12, v6 offset:4308
        v_add_i32       v6, vcc, 0xca62c1d6, v54
        ds_write_b32    v12, v6 offset:4356
        ds_read_b32     v6, v12 offset:4372
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, 0xca62c1d6, v6
        ds_write_b32    v12, v6 offset:4372
        ds_read_b32     v6, v12 offset:4404
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, 0xca62c1d6, v6
        v_lshrrev_b32   v0, 2, v0
        ds_write_b32    v12, v6 offset:4404
        v_lshlrev_b32   v6, 24, v4
        v_lshlrev_b32   v10, 16, v2
        v_and_b32       v0, 48, v0
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[16:19], s[2:3], 0x90
        v_or_b32        v6, v6, v10
        v_add_i32       v0, vcc, v7, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        s_add_u32       s0, -1, s5
        s_mov_b64       s[12:13], exec
        s_mov_b64       s[22:23], exec
        v_mov_b32       v7, 0
        v_mov_b32       v51, v0
        v_mov_b32       v8, v1
        v_mov_b32       v12, 0x13c
        v_mov_b32       v31, v16
        v_mov_b32       v9, 0
        v_mov_b32       v47, 0
        v_mov_b32       v48, 0
        v_mov_b32       v49, 0
        v_mov_b32       v50, 0
        v_mov_b32       v20, 0
        v_mov_b32       v21, 0
        v_mov_b32       v22, 0
        v_mov_b32       v25, 0
.L6824_2:
        v_add_f32       v26, v22, v25
        v_add_f32       v26, v21, v26
        v_add_f32       v26, v20, v26
        v_add_f32       v26, v50, v26
        v_add_f32       v26, v49, v26
        v_add_f32       v26, v48, v26
        v_add_f32       v26, v47, v26
        v_add_f32       v26, v9, v26
        v_cmp_eq_u32    vcc, 0, v26
        s_and_saveexec_b64 s[36:37], vcc
        s_andn2_b64     exec, s[36:37], exec
        s_cbranch_execz .L6880_2
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L13744_2
.L6880_2:
        s_and_b64       exec, s[36:37], s[22:23]
        s_movk_i32      s5, 0x3ff
        v_cmp_gt_i32    s[36:37], v7, s5
        v_cndmask_b32   v9, v9, 1.0, s[36:37]
        v_cmp_eq_u32    vcc, 0, v9
        s_and_saveexec_b64 s[38:39], vcc
        v_ashrrev_i32   v8, 6, v7
        s_cbranch_execz .L13720_2
        v_bfe_u32       v10, v0, 0, 8
        v_add_i32       v8, vcc, v10, v8
        v_add_i32       v8, vcc, s15, v8
        v_and_b32       v10, 63, v7
        v_bfe_u32       v11, v1, 0, 8
        v_add_i32       v10, vcc, v11, v10
        v_add_i32       v10, vcc, s20, v10
        buffer_load_ubyte v8, v8, s[28:31], 0 offen
        buffer_load_ubyte v51, v10, s[32:35], 0 offen
        s_waitcnt       vmcnt(0)
        s_barrier
        v_mov_b32       v11, 0x1000
        ds_read2_b32    v[14:15], v11 offset0:1 offset1:2
        v_lshlrev_b32   v12, 8, v8
        v_or_b32        v12, v6, v12
        v_or_b32        v12, v12, v51
        v_add_i32       v16, vcc, 0x9fb498b3, v12
        v_alignbit_b32  v17, v16, v16, 27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v14, vcc, v17, v14
        v_add_i32       v14, vcc, 0xc2e5374, v14
        v_mov_b32       v17, 0x7bf36ae2
        s_mov_b32       s5, 0x59d148c0
        v_bfi_b32       v17, v16, s5, v17
        v_alignbit_b32  v26, v14, v14, 27
        ds_read2_b32    v[27:28], v11 offset0:3 offset1:4
        v_add_i32       v17, vcc, v17, v26
        v_add_i32       v15, vcc, v15, v17
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x98badcfe, v15
        v_bfi_b32       v17, v14, v16, s5
        v_alignbit_b32  v26, v15, v15, 27
        v_add_i32       v17, vcc, v26, v17
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v27
        v_add_i32       v17, vcc, 0x7bf36ae2, v17
        v_alignbit_b32  v14, v14, v14, 2
        v_alignbit_b32  v26, v17, v17, 27
        v_bfi_b32       v27, v15, v14, v16
        v_add_i32       v26, vcc, v26, v27
        ds_read2_b32    v[29:30], v11 offset0:5 offset1:6
        v_add_i32       v26, vcc, v26, v28
        v_add_i32       v26, vcc, 0x59d148c0, v26
        v_alignbit_b32  v15, v15, v15, 2
        v_alignbit_b32  v27, v26, v26, 27
        v_bfi_b32       v28, v17, v15, v14
        v_add_i32       v16, vcc, v16, v27
        v_add_i32       v16, vcc, v28, v16
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v29
        v_alignbit_b32  v17, v17, v17, 2
        v_alignbit_b32  v27, v16, v16, 27
        v_bfi_b32       v28, v26, v17, v15
        v_add_i32       v14, vcc, v14, v27
        ds_read2_b32    v[31:32], v11 offset0:7 offset1:8
        v_add_i32       v14, vcc, v28, v14
        v_add_i32       v14, vcc, v30, v14
        v_alignbit_b32  v27, v14, v14, 27
        v_alignbit_b32  v26, v26, v26, 2
        v_add_i32       v15, vcc, v15, v27
        v_bfi_b32       v27, v16, v26, v17
        v_add_i32       v15, vcc, v15, v27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v31, v15
        v_alignbit_b32  v16, v16, v16, 2
        v_alignbit_b32  v27, v15, v15, 27
        v_bfi_b32       v28, v14, v16, v26
        v_add_i32       v17, vcc, v17, v27
        ds_read2_b32    v[29:30], v11 offset0:9 offset1:10
        v_add_i32       v17, vcc, v28, v17
        v_add_i32       v17, vcc, v32, v17
        v_alignbit_b32  v14, v14, v14, 2
        v_alignbit_b32  v27, v17, v17, 27
        v_bfi_b32       v28, v15, v14, v16
        v_add_i32       v26, vcc, v26, v27
        v_add_i32       v26, vcc, v28, v26
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v26, vcc, v26, v29
        v_alignbit_b32  v27, v26, v26, 27
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v16, vcc, v16, v27
        v_bfi_b32       v27, v17, v15, v14
        ds_read2_b32    v[28:29], v11 offset0:11 offset1:12
        v_add_i32       v16, vcc, v16, v27
        v_add_i32       v16, vcc, v30, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_alignbit_b32  v27, v16, v16, 27
        v_bfi_b32       v30, v26, v17, v15
        v_add_i32       v14, vcc, v14, v27
        v_add_i32       v14, vcc, v30, v14
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v14, vcc, v28, v14
        v_alignbit_b32  v26, v26, v26, 2
        v_alignbit_b32  v27, v14, v14, 27
        v_bfi_b32       v28, v16, v26, v17
        v_add_i32       v15, vcc, v15, v27
        ds_read2_b32    v[30:31], v11 offset0:13 offset1:14
        v_add_i32       v15, vcc, v28, v15
        v_add_i32       v15, vcc, v29, v15
        v_alignbit_b32  v27, v15, v15, 27
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v17, vcc, v17, v27
        v_bfi_b32       v27, v14, v16, v26
        v_add_i32       v17, vcc, v17, v27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v30
        v_alignbit_b32  v14, v14, v14, 2
        v_alignbit_b32  v27, v17, v17, 27
        v_bfi_b32       v28, v15, v14, v16
        v_add_i32       v26, vcc, v26, v27
        ds_read2_b32    v[29:30], v11 offset0:15 offset1:16
        v_add_i32       v26, vcc, v28, v26
        v_add_i32       v26, vcc, v31, v26
        v_alignbit_b32  v15, v15, v15, 2
        v_alignbit_b32  v27, v26, v26, 27
        v_bfi_b32       v28, v17, v15, v14
        v_add_i32       v16, vcc, v16, v27
        v_add_i32       v16, vcc, v28, v16
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v29, v16
        v_alignbit_b32  v27, v16, v16, 27
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v14, vcc, v14, v27
        v_bfi_b32       v27, v26, v17, v15
        v_alignbit_b32  v28, v12, v12, 31
        v_add_i32       v14, vcc, v14, v27
        v_xor_b32       v27, v30, v28
        ds_read2_b32    v[28:29], v11 offset0:17 offset1:18
        v_add_i32       v14, vcc, v14, v27
        v_add_i32       v14, vcc, 0x5a827999, v14
        v_alignbit_b32  v26, v26, v26, 2
        v_alignbit_b32  v27, v14, v14, 27
        v_bfi_b32       v30, v16, v26, v17
        v_add_i32       v15, vcc, v15, v27
        v_add_i32       v15, vcc, v30, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v28
        v_alignbit_b32  v16, v16, v16, 2
        v_alignbit_b32  v27, v15, v15, 27
        ds_read2_b32    v[30:31], v11 offset0:19 offset1:20
        v_bfi_b32       v28, v14, v16, v26
        v_add_i32       v17, vcc, v17, v27
        v_add_i32       v17, vcc, v28, v17
        v_add_i32       v17, vcc, v29, v17
        v_alignbit_b32  v27, v17, v17, 27
        v_alignbit_b32  v14, v14, v14, 2
        v_add_i32       v26, vcc, v26, v27
        v_bfi_b32       v27, v15, v14, v16
        v_alignbit_b32  v28, v12, v12, 30
        v_add_i32       v26, vcc, v26, v27
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v27, v30, v28
        v_add_i32       v26, vcc, v26, v27
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v27, v17, v14
        v_add_i32       v26, vcc, 0x5a827999, v26
        v_xor_b32       v27, v15, v27
        ds_read2_b32    v[29:30], v11 offset0:21 offset1:22
        v_add_i32       v16, vcc, v16, v27
        v_alignbit_b32  v27, v26, v26, 27
        v_xor_b32       v32, v26, v15
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v16, vcc, v16, v27
        v_xor_b32       v27, v32, v17
        v_add_i32       v16, vcc, v31, v16
        v_add_i32       v14, vcc, v14, v27
        v_alignbit_b32  v27, v16, v16, 27
        v_add_i32       v14, vcc, v14, v27
        v_xor_b32       v27, v17, v16
        v_alignbit_b32  v26, v26, v26, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v14, vcc, v14, v29
        v_xor_b32       v27, v27, v26
        v_alignbit_b32  v29, v14, v14, 27
        v_add_i32       v15, vcc, v15, v27
        v_alignbit_b32  v27, v12, v12, 29
        ds_read2_b32    v[31:32], v11 offset0:23 offset1:24
        v_add_i32       v15, vcc, v29, v15
        v_xor_b32       v29, v30, v27
        v_add_i32       v15, vcc, v15, v29
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v29, v14, v26
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        v_xor_b32       v29, v16, v29
        v_add_i32       v17, vcc, v17, v29
        v_alignbit_b32  v29, v15, v15, 27
        v_xor_b32       v30, v15, v16
        v_alignbit_b32  v14, v14, v14, 2
        v_add_i32       v17, vcc, v17, v29
        v_xor_b32       v29, v30, v14
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v31, v17
        ds_read2_b32    v[30:31], v11 offset0:25 offset1:26
        v_add_i32       v26, vcc, v26, v29
        v_alignbit_b32  v29, v17, v17, 27
        v_add_i32       v26, vcc, v26, v29
        v_xor_b32       v29, v28, v32
        v_add_i32       v26, vcc, v26, v29
        v_xor_b32       v29, v14, v17
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v26, vcc, 0x6ed9eba1, v26
        v_xor_b32       v29, v29, v15
        v_alignbit_b32  v32, v26, v26, 27
        v_add_i32       v16, vcc, v16, v29
        v_alignbit_b32  v29, v12, v12, 28
        v_add_i32       v16, vcc, v32, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v30, v29, v30
        v_add_i32       v16, vcc, v16, v30
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v30, v26, v15
        v_add_i32       v16, vcc, 0x6ed9eba1, v16
        v_xor_b32       v30, v17, v30
        ds_read2_b32    v[32:33], v11 offset0:27 offset1:28
        v_add_i32       v14, vcc, v14, v30
        v_alignbit_b32  v30, v16, v16, 27
        v_xor_b32       v34, v16, v17
        v_alignbit_b32  v26, v26, v26, 2
        v_add_i32       v14, vcc, v14, v30
        v_xor_b32       v30, v34, v26
        v_add_i32       v14, vcc, v31, v14
        v_add_i32       v15, vcc, v15, v30
        v_alignbit_b32  v30, v14, v14, 27
        v_add_i32       v15, vcc, v15, v30
        v_xor_b32       v30, v26, v14
        v_alignbit_b32  v16, v16, v16, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v32, v15
        v_xor_b32       v30, v30, v16
        v_alignbit_b32  v31, v15, v15, 27
        v_add_i32       v17, vcc, v17, v30
        v_alignbit_b32  v30, v12, v12, 27
        ds_read2_b32    v[34:35], v11 offset0:29 offset1:30
        v_add_i32       v17, vcc, v31, v17
        v_xor_b32       v31, v33, v30
        v_add_i32       v17, vcc, v17, v31
        v_alignbit_b32  v14, v14, v14, 2
        v_xor_b32       v31, v15, v16
        v_add_i32       v17, vcc, 0x6ed9eba1, v17
        v_xor_b32       v31, v14, v31
        v_add_i32       v26, vcc, v26, v31
        v_alignbit_b32  v31, v17, v17, 27
        v_xor_b32       v32, v17, v14
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v26, vcc, v26, v31
        v_xor_b32       v31, v32, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v26, vcc, v26, v34
        ds_read2_b32    v[32:33], v11 offset0:31 offset1:32
        v_add_i32       v16, vcc, v16, v31
        v_alignbit_b32  v31, v26, v26, 27
        v_xor_b32       v34, v28, v29
        v_add_i32       v16, vcc, v16, v31
        v_xor_b32       v31, v35, v34
        v_add_i32       v16, vcc, v16, v31
        v_xor_b32       v31, v15, v26
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v16, vcc, 0x6ed9eba1, v16
        v_xor_b32       v31, v31, v17
        v_alignbit_b32  v34, v16, v16, 27
        v_add_i32       v14, vcc, v14, v31
        v_alignbit_b32  v31, v12, v12, 26
        v_add_i32       v14, vcc, v34, v14
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v32, v32, v31
        v_add_i32       v14, vcc, v14, v32
        v_alignbit_b32  v26, v26, v26, 2
        v_xor_b32       v32, v16, v17
        v_add_i32       v14, vcc, 0x6ed9eba1, v14
        v_xor_b32       v32, v26, v32
        v_add_i32       v15, vcc, v15, v32
        v_alignbit_b32  v32, v14, v14, 27
        v_xor_b32       v28, v28, v27
        ds_read2_b32    v[34:35], v11 offset0:33 offset1:34
        v_add_i32       v15, vcc, v15, v32
        v_xor_b32       v28, v33, v28
        v_xor_b32       v32, v14, v26
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v28
        v_xor_b32       v28, v32, v16
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        v_add_i32       v17, vcc, v17, v28
        v_alignbit_b32  v28, v15, v15, 27
        v_add_i32       v17, vcc, v17, v28
        v_xor_b32       v28, v16, v15
        v_alignbit_b32  v14, v14, v14, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v34
        v_xor_b32       v28, v28, v14
        ds_read2_b32    v[32:33], v11 offset0:35 offset1:36
        v_alignbit_b32  v34, v17, v17, 27
        v_add_i32       v26, vcc, v26, v28
        v_alignbit_b32  v28, v12, v12, 25
        v_add_i32       v26, vcc, v34, v26
        v_xor_b32       v34, v35, v28
        v_add_i32       v26, vcc, v26, v34
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v34, v17, v14
        v_add_i32       v26, vcc, 0x6ed9eba1, v26
        v_xor_b32       v34, v15, v34
        v_add_i32       v16, vcc, v16, v34
        v_alignbit_b32  v34, v26, v26, 27
        v_add_i32       v16, vcc, v16, v34
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v32, v29, v32
        v_xor_b32       v34, v26, v15
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v16, vcc, v16, v32
        v_xor_b32       v32, v34, v17
        v_add_i32       v16, vcc, 0x6ed9eba1, v16
        ds_read2_b32    v[34:35], v11 offset0:37 offset1:38
        v_add_i32       v14, vcc, v14, v32
        v_alignbit_b32  v32, v16, v16, 27
        v_xor_b32       v36, v29, v31
        v_add_i32       v14, vcc, v14, v32
        v_xor_b32       v32, v33, v36
        v_add_i32       v14, vcc, v14, v32
        v_xor_b32       v32, v17, v16
        v_alignbit_b32  v26, v26, v26, 2
        v_add_i32       v14, vcc, 0x6ed9eba1, v14
        v_xor_b32       v32, v32, v26
        v_alignbit_b32  v33, v14, v14, 27
        v_add_i32       v15, vcc, v15, v32
        v_alignbit_b32  v32, v12, v12, 24
        v_add_i32       v15, vcc, v33, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v33, v32, v34
        v_add_i32       v15, vcc, v15, v33
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v33, v14, v26
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        v_xor_b32       v33, v16, v33
        v_add_i32       v17, vcc, v17, v33
        v_alignbit_b32  v33, v15, v15, 27
        ds_read2_b32    v[37:38], v11 offset0:39 offset1:40
        v_add_i32       v17, vcc, v17, v33
        v_xor_b32       v33, v29, v35
        v_xor_b32       v34, v15, v16
        v_alignbit_b32  v14, v14, v14, 2
        v_add_i32       v17, vcc, v17, v33
        v_xor_b32       v33, v34, v14
        v_add_i32       v17, vcc, 0x6ed9eba1, v17
        v_add_i32       v26, vcc, v26, v33
        v_alignbit_b32  v33, v17, v17, 27
        v_add_i32       v26, vcc, v26, v33
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v26, vcc, v37, v26
        v_alignbit_b32  v15, v15, v15, 2
        v_bfi_b32       v33, v14, v15, v17
        v_bfi_b32       v34, v15, 0, v17
        v_alignbit_b32  v35, v26, v26, 27
        v_alignbit_b32  v37, v12, v12, 23
        v_xor_b32       v33, v33, v34
        v_add_i32       v16, vcc, v16, v35
        v_xor_b32       v34, v29, v37
        v_add_i32       v16, vcc, v33, v16
        v_xor_b32       v33, v38, v34
        ds_read2_b32    v[34:35], v11 offset0:41 offset1:42
        v_add_i32       v16, vcc, v16, v33
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_bfi_b32       v33, v15, v17, v26
        v_bfi_b32       v37, v17, 0, v26
        v_alignbit_b32  v38, v16, v16, 27
        v_xor_b32       v33, v33, v37
        v_add_i32       v14, vcc, v14, v38
        v_add_i32       v14, vcc, v33, v14
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v14, vcc, v14, v34
        v_alignbit_b32  v26, v26, v26, 2
        v_bfi_b32       v33, v17, v26, v16
        v_bfi_b32       v34, v26, 0, v16
        v_alignbit_b32  v37, v14, v14, 27
        v_xor_b32       v33, v33, v34
        v_add_i32       v15, vcc, v15, v37
        v_xor_b32       v34, v31, v32
        ds_read2_b32    v[37:38], v11 offset0:43 offset1:44
        v_add_i32       v15, vcc, v33, v15
        v_xor_b32       v33, v35, v34
        v_add_i32       v15, vcc, v15, v33
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_bfi_b32       v33, v26, v16, v14
        v_bfi_b32       v34, v16, 0, v14
        v_alignbit_b32  v35, v15, v15, 27
        v_xor_b32       v33, v33, v34
        v_add_i32       v17, vcc, v17, v35
        v_alignbit_b32  v34, v12, v12, 22
        v_add_i32       v17, vcc, v33, v17
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v33, v37, v34
        v_add_i32       v17, vcc, v17, v33
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_alignbit_b32  v14, v14, v14, 2
        v_bfi_b32       v33, v16, v14, v15
        v_bfi_b32       v35, v14, 0, v15
        v_alignbit_b32  v37, v17, v17, 27
        v_xor_b32       v39, v27, v31
        v_xor_b32       v33, v33, v35
        v_add_i32       v26, vcc, v26, v37
        v_xor_b32       v35, v28, v39
        v_add_i32       v26, vcc, v33, v26
        v_xor_b32       v33, v38, v35
        ds_read2_b32    v[37:38], v11 offset0:45 offset1:46
        v_add_i32       v26, vcc, v26, v33
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v26, vcc, 0x8f1bbcdc, v26
        v_bfi_b32       v33, v14, v15, v17
        v_bfi_b32       v35, v15, 0, v17
        v_alignbit_b32  v39, v26, v26, 27
        v_xor_b32       v33, v33, v35
        v_add_i32       v16, vcc, v16, v39
        v_add_i32       v16, vcc, v33, v16
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v37
        v_alignbit_b32  v17, v17, v17, 2
        v_bfi_b32       v33, v15, v17, v26
        v_bfi_b32       v35, v17, 0, v26
        v_alignbit_b32  v37, v16, v16, 27
        v_alignbit_b32  v39, v12, v12, 21
        v_xor_b32       v33, v33, v35
        v_add_i32       v14, vcc, v14, v37
        v_xor_b32       v35, v29, v39
        ds_read2_b32    v[40:41], v11 offset0:47 offset1:48
        v_add_i32       v14, vcc, v33, v14
        v_xor_b32       v33, v38, v35
        v_add_i32       v14, vcc, v14, v33
        v_alignbit_b32  v26, v26, v26, 2
        v_add_i32       v14, vcc, 0x8f1bbcdc, v14
        v_bfi_b32       v33, v17, v26, v16
        v_bfi_b32       v35, v26, 0, v16
        v_alignbit_b32  v37, v14, v14, 27
        v_xor_b32       v33, v33, v35
        v_add_i32       v15, vcc, v15, v37
        v_xor_b32       v35, v29, v32
        v_add_i32       v15, vcc, v33, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v33, v40, v35
        v_add_i32       v15, vcc, v15, v33
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v27, v27, v30
        v_bfi_b32       v33, v26, v16, v14
        v_bfi_b32       v37, v16, 0, v14
        v_alignbit_b32  v38, v15, v15, 27
        v_xor_b32       v27, v35, v27
        v_xor_b32       v33, v33, v37
        v_add_i32       v17, vcc, v17, v38
        v_xor_b32       v27, v34, v27
        ds_read2_b32    v[37:38], v11 offset0:49 offset1:50
        v_add_i32       v17, vcc, v33, v17
        v_xor_b32       v27, v41, v27
        v_add_i32       v17, vcc, v17, v27
        v_alignbit_b32  v14, v14, v14, 2
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_bfi_b32       v27, v16, v14, v15
        v_bfi_b32       v33, v14, 0, v15
        v_alignbit_b32  v40, v17, v17, 27
        v_xor_b32       v27, v27, v33
        v_add_i32       v26, vcc, v26, v40
        v_alignbit_b32  v33, v12, v12, 20
        v_add_i32       v26, vcc, v27, v26
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v27, v33, v37
        v_add_i32       v26, vcc, v26, v27
        v_add_i32       v26, vcc, 0x8f1bbcdc, v26
        v_alignbit_b32  v15, v15, v15, 2
        v_bfi_b32       v27, v14, v15, v17
        v_bfi_b32       v37, v15, 0, v17
        v_alignbit_b32  v40, v26, v26, 27
        v_xor_b32       v27, v27, v37
        v_add_i32       v16, vcc, v16, v40
        ds_read2_b32    v[40:41], v11 offset0:51 offset1:52
        v_add_i32       v16, vcc, v27, v16
        v_xor_b32       v27, v32, v38
        v_add_i32       v16, vcc, v16, v27
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_bfi_b32       v27, v15, v17, v26
        v_bfi_b32       v37, v17, 0, v26
        v_alignbit_b32  v38, v16, v16, 27
        v_xor_b32       v27, v27, v37
        v_add_i32       v14, vcc, v14, v38
        v_add_i32       v14, vcc, v27, v14
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v27, v36, v40
        v_add_i32       v14, vcc, v14, v27
        v_add_i32       v14, vcc, 0x8f1bbcdc, v14
        v_alignbit_b32  v26, v26, v26, 2
        v_bfi_b32       v27, v17, v26, v16
        v_bfi_b32       v37, v26, 0, v16
        v_alignbit_b32  v38, v14, v14, 27
        v_alignbit_b32  v40, v12, v12, 19
        v_xor_b32       v27, v27, v37
        v_add_i32       v15, vcc, v15, v38
        v_xor_b32       v37, v35, v40
        v_add_i32       v15, vcc, v27, v15
        v_xor_b32       v27, v37, v41
        ds_read2_b32    v[37:38], v11 offset0:53 offset1:54
        v_add_i32       v15, vcc, v15, v27
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_bfi_b32       v27, v26, v16, v14
        v_bfi_b32       v41, v16, 0, v14
        v_alignbit_b32  v42, v15, v15, 27
        v_xor_b32       v27, v27, v41
        v_add_i32       v17, vcc, v17, v42
        v_add_i32       v17, vcc, v27, v17
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v37
        v_alignbit_b32  v14, v14, v14, 2
        v_bfi_b32       v27, v16, v14, v15
        v_bfi_b32       v37, v14, 0, v15
        v_alignbit_b32  v41, v17, v17, 27
        v_xor_b32       v42, v28, v34
        v_xor_b32       v27, v27, v37
        v_add_i32       v26, vcc, v26, v41
        v_xor_b32       v37, v33, v42
        ds_read2_b32    v[41:42], v11 offset0:55 offset1:56
        v_add_i32       v26, vcc, v27, v26
        v_xor_b32       v27, v37, v38
        v_add_i32       v26, vcc, v26, v27
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v26, vcc, 0x8f1bbcdc, v26
        v_bfi_b32       v27, v14, v15, v17
        v_bfi_b32       v37, v15, 0, v17
        v_alignbit_b32  v38, v26, v26, 27
        v_xor_b32       v27, v27, v37
        v_add_i32       v16, vcc, v16, v38
        v_alignbit_b32  v37, v12, v12, 18
        v_add_i32       v16, vcc, v27, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v27, v37, v41
        v_add_i32       v16, vcc, v16, v27
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v27, v28, v36
        v_bfi_b32       v38, v15, v17, v26
        v_bfi_b32       v41, v17, 0, v26
        v_alignbit_b32  v43, v16, v16, 27
        v_xor_b32       v34, v34, v27
        v_xor_b32       v38, v38, v41
        v_add_i32       v14, vcc, v14, v43
        v_xor_b32       v34, v39, v34
        ds_read2_b32    v[43:44], v11 offset0:57 offset1:58
        v_add_i32       v14, vcc, v38, v14
        v_xor_b32       v34, v34, v42
        v_add_i32       v14, vcc, v14, v34
        v_alignbit_b32  v26, v26, v26, 2
        v_add_i32       v14, vcc, 0x8f1bbcdc, v14
        v_bfi_b32       v34, v17, v26, v16
        v_bfi_b32       v38, v26, 0, v16
        v_alignbit_b32  v41, v14, v14, 27
        v_xor_b32       v34, v34, v38
        v_add_i32       v15, vcc, v15, v41
        v_add_i32       v15, vcc, v34, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v34, v32, v43
        v_add_i32       v15, vcc, v15, v34
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_alignbit_b32  v16, v16, v16, 2
        v_bfi_b32       v34, v26, v16, v14
        v_bfi_b32       v38, v16, 0, v14
        v_alignbit_b32  v41, v15, v15, 27
        v_alignbit_b32  v42, v12, v12, 17
        v_xor_b32       v34, v34, v38
        v_add_i32       v17, vcc, v17, v41
        v_xor_b32       v35, v35, v42
        ds_read2_b32    v[45:46], v11 offset0:59 offset1:60
        v_add_i32       v17, vcc, v34, v17
        v_xor_b32       v34, v35, v44
        v_add_i32       v17, vcc, v17, v34
        v_alignbit_b32  v14, v14, v14, 2
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_bfi_b32       v34, v16, v14, v15
        v_bfi_b32       v35, v14, 0, v15
        v_alignbit_b32  v38, v17, v17, 27
        v_xor_b32       v34, v34, v35
        v_add_i32       v26, vcc, v26, v38
        v_xor_b32       v35, v32, v33
        v_add_i32       v26, vcc, v34, v26
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v34, v35, v45
        v_add_i32       v26, vcc, v26, v34
        v_xor_b32       v34, v14, v17
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v29, v29, v28
        v_add_i32       v26, vcc, 0x8f1bbcdc, v26
        v_xor_b32       v34, v34, v15
        v_xor_b32       v29, v35, v29
        ds_read2_b32    v[43:44], v11 offset0:61 offset1:62
        v_alignbit_b32  v38, v26, v26, 27
        v_add_i32       v16, vcc, v16, v34
        v_xor_b32       v29, v37, v29
        v_add_i32       v16, vcc, v38, v16
        v_xor_b32       v29, v29, v46
        v_add_i32       v16, vcc, v16, v29
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v29, v26, v15
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        v_xor_b32       v29, v17, v29
        v_add_i32       v14, vcc, v14, v29
        v_alignbit_b32  v29, v16, v16, 27
        v_alignbit_b32  v34, v12, v12, 16
        v_add_i32       v14, vcc, v14, v29
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v29, v34, v43
        v_xor_b32       v38, v16, v17
        v_alignbit_b32  v26, v26, v26, 2
        v_add_i32       v14, vcc, v14, v29
        v_xor_b32       v29, v38, v26
        v_add_i32       v14, vcc, 0xca62c1d6, v14
        ds_read2_b32    v[45:46], v11 offset0:63 offset1:64
        v_add_i32       v15, vcc, v15, v29
        v_alignbit_b32  v29, v14, v14, 27
        v_xor_b32       v36, v36, v35
        v_add_i32       v15, vcc, v15, v29
        v_xor_b32       v29, v36, v44
        v_add_i32       v15, vcc, v15, v29
        v_xor_b32       v29, v26, v14
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_xor_b32       v29, v29, v16
        v_alignbit_b32  v36, v15, v15, 27
        v_add_i32       v17, vcc, v17, v29
        v_add_i32       v17, vcc, v36, v17
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v29, v32, v45
        v_add_i32       v17, vcc, v17, v29
        v_alignbit_b32  v14, v14, v14, 2
        v_xor_b32       v29, v15, v16
        v_add_i32       v17, vcc, 0xca62c1d6, v17
        v_xor_b32       v29, v14, v29
        v_xor_b32       v27, v27, v35
        v_alignbit_b32  v35, v12, v12, 15
        v_add_i32       v26, vcc, v26, v29
        v_alignbit_b32  v29, v17, v17, 27
        v_xor_b32       v27, v27, v35
        ds_read2_b32    v[35:36], v11 offset0:65 offset1:66
        v_add_i32       v26, vcc, v26, v29
        v_xor_b32       v27, v27, v46
        v_xor_b32       v29, v17, v14
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v26, vcc, v26, v27
        v_xor_b32       v27, v29, v15
        v_add_i32       v26, vcc, 0xca62c1d6, v26
        v_add_i32       v16, vcc, v16, v27
        v_alignbit_b32  v27, v26, v26, 27
        v_add_i32       v16, vcc, v16, v27
        v_xor_b32       v27, v15, v26
        v_alignbit_b32  v17, v17, v17, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v35
        v_xor_b32       v27, v27, v17
        ds_read2_b32    v[43:44], v11 offset0:67 offset1:68
        v_alignbit_b32  v29, v16, v16, 27
        v_add_i32       v14, vcc, v14, v27
        v_xor_b32       v27, v37, v34
        v_add_i32       v14, vcc, v29, v14
        v_xor_b32       v27, v27, v36
        v_add_i32       v14, vcc, v14, v27
        v_alignbit_b32  v26, v26, v26, 2
        v_xor_b32       v27, v16, v17
        v_add_i32       v14, vcc, 0xca62c1d6, v14
        v_xor_b32       v27, v26, v27
        v_alignbit_b32  v29, v12, v12, 14
        v_add_i32       v15, vcc, v15, v27
        v_alignbit_b32  v27, v14, v14, 27
        v_xor_b32       v35, v32, v29
        v_add_i32       v15, vcc, v15, v27
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v27, v35, v43
        v_xor_b32       v35, v14, v26
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v27
        v_xor_b32       v27, v35, v16
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_xor_b32       v35, v39, v37
        v_add_i32       v17, vcc, v17, v27
        v_alignbit_b32  v27, v15, v15, 27
        v_xor_b32       v35, v42, v35
        ds_read2_b32    v[45:46], v11 offset0:69 offset1:70
        v_add_i32       v17, vcc, v17, v27
        v_xor_b32       v27, v35, v44
        v_add_i32       v17, vcc, v17, v27
        v_xor_b32       v27, v16, v15
        v_alignbit_b32  v14, v14, v14, 2
        v_add_i32       v17, vcc, 0xca62c1d6, v17
        v_xor_b32       v27, v27, v14
        v_alignbit_b32  v35, v17, v17, 27
        v_add_i32       v26, vcc, v26, v27
        v_add_i32       v26, vcc, v35, v26
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v27, v17, v14
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v26, vcc, v26, v45
        v_xor_b32       v27, v15, v27
        v_alignbit_b32  v35, v12, v12, 13
        ds_read2_b32    v[43:44], v11 offset0:71 offset1:72
        v_add_i32       v16, vcc, v16, v27
        v_alignbit_b32  v27, v26, v26, 27
        v_xor_b32       v35, v33, v35
        v_add_i32       v16, vcc, v16, v27
        v_xor_b32       v27, v35, v46
        v_xor_b32       v35, v26, v15
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v16, vcc, v16, v27
        v_xor_b32       v27, v35, v17
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        v_add_i32       v14, vcc, v14, v27
        v_alignbit_b32  v27, v16, v16, 27
        v_xor_b32       v35, v33, v34
        v_xor_b32       v30, v30, v39
        v_add_i32       v14, vcc, v14, v27
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v27, v35, v43
        v_xor_b32       v30, v33, v30
        v_add_i32       v14, vcc, v14, v27
        v_xor_b32       v27, v17, v16
        v_alignbit_b32  v26, v26, v26, 2
        v_xor_b32       v30, v40, v30
        v_add_i32       v14, vcc, 0xca62c1d6, v14
        v_xor_b32       v27, v27, v26
        v_xor_b32       v30, v34, v30
        ds_read2_b32    v[35:36], v11 offset0:73 offset1:74
        v_alignbit_b32  v38, v14, v14, 27
        v_add_i32       v15, vcc, v15, v27
        v_xor_b32       v27, v29, v30
        v_add_i32       v15, vcc, v38, v15
        v_xor_b32       v27, v27, v44
        v_add_i32       v15, vcc, v15, v27
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v27, v14, v26
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_xor_b32       v27, v16, v27
        v_add_i32       v17, vcc, v17, v27
        v_alignbit_b32  v27, v15, v15, 27
        v_alignbit_b32  v30, v12, v12, 12
        v_add_i32       v17, vcc, v17, v27
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v27, v30, v35
        v_xor_b32       v35, v15, v16
        v_alignbit_b32  v14, v14, v14, 2
        v_add_i32       v17, vcc, v17, v27
        v_xor_b32       v27, v35, v14
        v_add_i32       v17, vcc, 0xca62c1d6, v17
        ds_read2_b32    v[38:39], v11 offset0:75 offset1:76
        v_add_i32       v26, vcc, v26, v27
        v_alignbit_b32  v27, v17, v17, 27
        v_xor_b32       v35, v32, v34
        v_add_i32       v26, vcc, v26, v27
        v_xor_b32       v27, v35, v36
        v_add_i32       v26, vcc, v26, v27
        v_xor_b32       v27, v14, v17
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v26, vcc, 0xca62c1d6, v26
        v_xor_b32       v27, v27, v15
        v_xor_b32       v31, v31, v33
        v_alignbit_b32  v35, v26, v26, 27
        v_add_i32       v16, vcc, v16, v27
        v_xor_b32       v27, v37, v31
        v_add_i32       v16, vcc, v35, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v27, v27, v38
        v_xor_b32       v28, v28, v32
        v_add_i32       v16, vcc, v16, v27
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v27, v26, v15
        v_xor_b32       v31, v33, v28
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        v_xor_b32       v27, v17, v27
        v_xor_b32       v31, v34, v31
        v_alignbit_b32  v33, v12, v12, 11
        v_add_i32       v14, vcc, v14, v27
        v_alignbit_b32  v27, v16, v16, 27
        v_xor_b32       v31, v31, v33
        ds_read2_b32    v[33:34], v11 offset0:77 offset1:78
        v_add_i32       v11, vcc, v14, v27
        v_xor_b32       v14, v31, v39
        v_xor_b32       v27, v16, v17
        v_alignbit_b32  v26, v26, v26, 2
        v_add_i32       v11, vcc, v11, v14
        v_xor_b32       v14, v27, v26
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_add_i32       v14, vcc, v15, v14
        v_alignbit_b32  v15, v11, v11, 27
        v_add_i32       v14, vcc, v14, v15
        v_alignbit_b32  v15, v16, v16, 2
        v_xor_b32       v16, v26, v11
        v_xor_b32       v27, v42, v28
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v14, vcc, v14, v33
        v_xor_b32       v16, v15, v16
        v_xor_b32       v27, v29, v27
        v_mov_b32       v28, 0
        ds_read_b32     v28, v28 offset:4412
        v_alignbit_b32  v29, v14, v14, 27
        v_add_i32       v16, vcc, v17, v16
        v_xor_b32       v17, v30, v27
        v_add_i32       v16, vcc, v29, v16
        v_xor_b32       v17, v17, v34
        v_xor_b32       v15, v14, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v17
        v_xor_b32       v11, v15, v11
        v_add_i32       v15, vcc, 0xca62c1d6, v16
        v_alignbit_b32  v12, v12, v12, 10
        v_add_i32       v11, vcc, v26, v11
        v_alignbit_b32  v15, v15, v15, 27
        v_xor_b32       v12, v32, v12
        v_add_i32       v11, vcc, v11, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v12, v12, v28
        v_add_i32       v11, vcc, v11, v12
        v_add_i32       v12, vcc, 0x31a7e4d7, v11
        v_lshrrev_b32   v15, 20, v12
        ds_read_u8      v15, v15
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v15, v15, 0, 8
        v_alignbit_b32  v14, v14, v14, 2
        v_lshrrev_b32   v17, 2, v12
        v_cmp_lg_i32    s[40:41], v15, 0
        v_add_i32       v35, vcc, 0x98badcfe, v14
        v_add_i32       v37, vcc, 0xba306d5f, v16
        s_mov_b64       s[42:43], exec
        s_andn2_b64     exec, s[42:43], s[40:41]
        v_lshrrev_b32   v26, 8, v12
        s_cbranch_execz .L11792_2
        v_add_i32       v26, vcc, s7, v26
        buffer_load_ubyte v26, v26, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[44:45], v26, 0
        s_and_saveexec_b64 s[46:47], s[44:45]
        s_cbranch_execz .L11768_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[48:49], exec
        s_mov_b64       s[50:51], exec
        v_mov_b32       v26, 0
        v_mov_b32       v27, s0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v53, s5
.L11660_2:
        v_cmp_gt_i32    s[52:53], v26, v27
        v_cmp_eq_i32    vcc, v17, v53
        s_or_b64        vcc, s[52:53], vcc
        s_and_saveexec_b64 s[52:53], vcc
        s_andn2_b64     s[50:51], s[50:51], exec
        s_cbranch_scc0  .L11744_2
        s_mov_b64       exec, s[50:51]
        v_add_i32       v28, vcc, v26, v27
        v_ashrrev_i32   v28, 1, v28
        v_lshlrev_b32   v29, 2, v28
        v_add_i32       v29, vcc, s4, v29
        v_add_i32       v30, vcc, -1, v28
        v_add_i32       v28, vcc, 1, v28
        tbuffer_load_format_x v53, v29, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v53, v17
        v_cndmask_b32   v27, v27, v30, vcc
        v_cndmask_b32   v26, v28, v26, vcc
        s_branch        .L11660_2
.L11744_2:
        s_mov_b64       exec, s[48:49]
        v_cmp_lg_i32    vcc, v17, v53
        v_cndmask_b32   v47, 1.0, v47, vcc
        v_cndmask_b32   v39, 0, -1, vcc
        v_mov_b32       v31, 1
.L11768_2:
        s_andn2_b64     exec, s[46:47], exec
        v_cndmask_b32   v39, 0, -1, s[44:45]
        v_mov_b32       v53, v16
        v_mov_b32       v31, 0
        s_mov_b64       exec, s[46:47]
.L11792_2:
        s_andn2_b64     exec, s[42:43], exec
        v_cndmask_b32   v39, 0, -1, s[40:41]
        v_mov_b32       v53, v16
        v_mov_b32       v31, 0
        s_mov_b64       exec, s[42:43]
        v_cmp_eq_u32    vcc, 0, v47
        s_and_b64       exec, s[42:43], vcc
        v_lshrrev_b32   v39, 28, v37
        s_cbranch_execz .L13716_2
        v_lshlrev_b32   v18, 4, v11
        v_add_i32       v53, vcc, 0x1a7e4d70, v18
        v_and_b32       v28, 0x3ffffff0, v53
        v_lshrrev_b32   v29, 18, v28
        ds_read_u8      v29, v29
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v29, v29, 0, 8
        v_cmp_eq_i32    vcc, 0, v29
        s_and_saveexec_b64 s[40:41], vcc
        v_lshrrev_b32   v28, 6, v28
        s_cbranch_execz .L12080_2
        v_add_i32       v28, vcc, s7, v28
        buffer_load_ubyte v28, v28, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v28
        s_and_saveexec_b64 s[44:45], vcc
        s_cbranch_execz .L12080_2
        s_mov_b32       s5, 0x3ffffff0
        v_bfi_b32       v26, s5, v53, v39
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[46:47], exec
        s_mov_b64       s[48:49], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v27, s5
        v_mov_b32       v29, 0
        v_mov_b32       v30, s0
        s_movk_i32      s50, 0x0
        s_movk_i32      s51, 0x0
.L11972_2:
        v_cmp_gt_i32    s[52:53], v29, v30
        v_cmp_eq_i32    vcc, v26, v27
        s_andn2_b64     s[50:51], s[50:51], exec
        s_or_b64        s[50:51], vcc, s[50:51]
        s_or_b64        vcc, s[52:53], vcc
        s_and_saveexec_b64 s[52:53], vcc
        s_andn2_b64     s[48:49], s[48:49], exec
        s_cbranch_scc0  .L12064_2
        s_mov_b64       exec, s[48:49]
        v_add_i32       v28, vcc, v29, v30
        v_ashrrev_i32   v28, 1, v28
        v_lshlrev_b32   v31, 2, v28
        v_add_i32       v31, vcc, s4, v31
        v_add_i32       v32, vcc, -1, v28
        v_add_i32       v28, vcc, 1, v28
        tbuffer_load_format_x v27, v31, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v27, v26
        v_cndmask_b32   v30, v30, v32, vcc
        v_cndmask_b32   v29, v28, v29, vcc
        s_branch        .L11972_2
.L12064_2:
        s_mov_b64       exec, s[46:47]
        v_cndmask_b32   v48, v48, 1.0, s[50:51]
        v_mov_b32       v31, 2
.L12080_2:
        s_mov_b64       exec, s[40:41]
        v_cmp_eq_u32    vcc, 0, v48
        s_and_b64       exec, s[40:41], vcc
        v_bfe_u32       v28, v12, 8, 12
        s_cbranch_execz .L13716_2
        ds_read_u8      v28, v28
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v28, v28, 0, 8
        v_cmp_eq_i32    vcc, 0, v28
        s_and_saveexec_b64 s[44:45], vcc
        v_lshrrev_b32   v28, 22, v37
        s_cbranch_execz .L12344_2
        v_lshlrev_b32   v29, 10, v11
        v_add_i32       v29, vcc, 0x9f935c00, v29
        s_mov_b32       s5, 0x3ffffc00
        v_bfi_b32       v28, s5, v29, v28
        v_lshrrev_b32   v29, 6, v28
        v_add_i32       v29, vcc, s7, v29
        buffer_load_ubyte v29, v29, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v29
        s_and_saveexec_b64 s[46:47], vcc
        s_cbranch_execz .L12344_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[48:49], exec
        s_mov_b64       s[50:51], exec
        v_mov_b32       v19, 0
        v_mov_b32       v29, s0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v26, s5
        s_movk_i32      s52, 0x0
        s_movk_i32      s53, 0x0
.L12236_2:
        v_cmp_gt_i32    s[54:55], v19, v29
        v_cmp_eq_i32    vcc, v28, v26
        s_andn2_b64     s[52:53], s[52:53], exec
        s_or_b64        s[52:53], vcc, s[52:53]
        s_or_b64        vcc, s[54:55], vcc
        s_and_saveexec_b64 s[54:55], vcc
        s_andn2_b64     s[50:51], s[50:51], exec
        s_cbranch_scc0  .L12328_2
        s_mov_b64       exec, s[50:51]
        v_add_i32       v30, vcc, v19, v29
        v_ashrrev_i32   v30, 1, v30
        v_lshlrev_b32   v31, 2, v30
        v_add_i32       v31, vcc, s4, v31
        v_add_i32       v32, vcc, -1, v30
        v_add_i32       v30, vcc, 1, v30
        tbuffer_load_format_x v26, v31, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v26, v28
        v_cndmask_b32   v29, v29, v32, vcc
        v_cndmask_b32   v19, v30, v19, vcc
        s_branch        .L12236_2
.L12328_2:
        s_mov_b64       exec, s[48:49]
        v_cndmask_b32   v49, v49, 1.0, s[52:53]
        v_mov_b32       v31, 2
.L12344_2:
        s_mov_b64       exec, s[44:45]
        v_cmp_eq_u32    vcc, 0, v49
        s_and_b64       exec, s[44:45], vcc
        v_bfe_u32       v28, v12, 2, 12
        s_cbranch_execz .L13716_2
        ds_read_u8      v28, v28
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v28, v28, 0, 8
        v_cmp_eq_i32    vcc, 0, v28
        s_and_saveexec_b64 s[46:47], vcc
        v_lshlrev_b32   v28, 16, v11
        s_cbranch_execz .L12612_2
        v_add_i32       v28, vcc, 0xe4d70000, v28
        v_lshrrev_b32   v29, 16, v37
        s_mov_b32       s5, 0x3fff0000
        v_bfi_b32       v28, s5, v28, v29
        v_lshrrev_b32   v29, 6, v28
        v_add_i32       v29, vcc, s7, v29
        buffer_load_ubyte v29, v29, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v29
        s_and_saveexec_b64 s[48:49], vcc
        s_cbranch_execz .L12612_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[50:51], exec
        s_mov_b64       s[52:53], exec
        v_mov_b32       v19, s0
        v_mov_b32       v29, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v26, s5
        s_movk_i32      s54, 0x0
        s_movk_i32      s55, 0x0
        s_nop           0x0
.L12504_2:
        v_cmp_gt_i32    s[56:57], v29, v19
        v_cmp_eq_i32    vcc, v28, v26
        s_andn2_b64     s[54:55], s[54:55], exec
        s_or_b64        s[54:55], vcc, s[54:55]
        s_or_b64        vcc, s[56:57], vcc
        s_and_saveexec_b64 s[56:57], vcc
        s_andn2_b64     s[52:53], s[52:53], exec
        s_cbranch_scc0  .L12596_2
        s_mov_b64       exec, s[52:53]
        v_add_i32       v30, vcc, v19, v29
        v_ashrrev_i32   v30, 1, v30
        v_lshlrev_b32   v31, 2, v30
        v_add_i32       v31, vcc, s4, v31
        v_add_i32       v32, vcc, -1, v30
        v_add_i32       v30, vcc, 1, v30
        tbuffer_load_format_x v26, v31, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v26, v28
        v_cndmask_b32   v29, v30, v29, vcc
        v_cndmask_b32   v19, v19, v32, vcc
        s_branch        .L12504_2
.L12596_2:
        s_mov_b64       exec, s[50:51]
        v_cndmask_b32   v50, v50, 1.0, s[54:55]
        v_mov_b32       v31, 2
.L12612_2:
        s_mov_b64       exec, s[46:47]
        v_cmp_eq_u32    vcc, 0, v50
        s_and_b64       exec, s[46:47], vcc
        v_lshrrev_b32   v28, 10, v37
        s_cbranch_execz .L13716_2
        v_lshlrev_b32   v29, 22, v11
        v_add_i32       v29, vcc, 0x35c00000, v29
        s_mov_b32       s5, 0x3fc00000
        v_bfi_b32       v28, s5, v29, v28
        v_lshrrev_b32   v29, 18, v28
        ds_read_u8      v29, v29
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v29, v29, 0, 8
        v_cmp_eq_i32    vcc, 0, v29
        s_and_saveexec_b64 s[48:49], vcc
        v_lshrrev_b32   v29, 6, v28
        s_cbranch_execz .L12884_2
        v_add_i32       v29, vcc, s7, v29
        buffer_load_ubyte v29, v29, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v29
        s_and_saveexec_b64 s[50:51], vcc
        s_cbranch_execz .L12884_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[52:53], exec
        s_mov_b64       s[54:55], exec
        v_mov_b32       v19, 0
        v_mov_b32       v29, s0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v26, s5
        s_movk_i32      s56, 0x0
        s_movk_i32      s57, 0x0
        s_nop           0x0
        s_nop           0x0
        s_nop           0x0
.L12776_2:
        v_cmp_gt_i32    s[58:59], v19, v29
        v_cmp_eq_i32    vcc, v28, v26
        s_andn2_b64     s[56:57], s[56:57], exec
        s_or_b64        s[56:57], vcc, s[56:57]
        s_or_b64        vcc, s[58:59], vcc
        s_and_saveexec_b64 s[58:59], vcc
        s_andn2_b64     s[54:55], s[54:55], exec
        s_cbranch_scc0  .L12868_2
        s_mov_b64       exec, s[54:55]
        v_add_i32       v30, vcc, v19, v29
        v_ashrrev_i32   v30, 1, v30
        v_lshlrev_b32   v31, 2, v30
        v_add_i32       v31, vcc, s4, v31
        v_add_i32       v32, vcc, -1, v30
        v_add_i32       v30, vcc, 1, v30
        tbuffer_load_format_x v26, v31, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v26, v28
        v_cndmask_b32   v29, v29, v32, vcc
        v_cndmask_b32   v19, v30, v19, vcc
        s_branch        .L12776_2
.L12868_2:
        s_mov_b64       exec, s[52:53]
        v_cndmask_b32   v20, v20, 1.0, s[56:57]
        v_mov_b32       v31, 2
.L12884_2:
        s_mov_b64       exec, s[48:49]
        v_cmp_eq_u32    vcc, 0, v20
        s_and_b64       exec, s[48:49], vcc
        v_lshrrev_b32   v28, 4, v37
        s_cbranch_execz .L13716_2
        v_lshlrev_b32   v11, 28, v11
        v_add_i32       v11, vcc, 0x70000000, v11
        s_mov_b32       s5, 0x30000000
        v_bfi_b32       v11, s5, v11, v28
        v_lshrrev_b32   v28, 18, v11
        ds_read_u8      v28, v28
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v28, v28, 0, 8
        v_cmp_eq_i32    vcc, 0, v28
        s_and_saveexec_b64 s[50:51], vcc
        v_lshrrev_b32   v28, 6, v11
        s_cbranch_execz .L13156_2
        v_add_i32       v28, vcc, s7, v28
        buffer_load_ubyte v28, v28, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v28
        s_and_saveexec_b64 s[52:53], vcc
        s_cbranch_execz .L13156_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[54:55], exec
        s_mov_b64       s[56:57], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v26, s5
        v_mov_b32       v28, 0
        v_mov_b32       v29, s0
        s_movk_i32      s58, 0x0
        s_movk_i32      s59, 0x0
        s_nop           0x0
        s_nop           0x0
        s_nop           0x0
.L13048_2:
        v_cmp_gt_i32    s[60:61], v28, v29
        v_cmp_eq_i32    vcc, v11, v26
        s_andn2_b64     s[58:59], s[58:59], exec
        s_or_b64        s[58:59], vcc, s[58:59]
        s_or_b64        vcc, s[60:61], vcc
        s_and_saveexec_b64 s[60:61], vcc
        s_andn2_b64     s[56:57], s[56:57], exec
        s_cbranch_scc0  .L13140_2
        s_mov_b64       exec, s[56:57]
        v_add_i32       v19, vcc, v28, v29
        v_ashrrev_i32   v19, 1, v19
        v_lshlrev_b32   v30, 2, v19
        v_add_i32       v30, vcc, s4, v30
        v_add_i32       v31, vcc, -1, v19
        v_add_i32       v19, vcc, 1, v19
        tbuffer_load_format_x v26, v30, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v26, v11
        v_cndmask_b32   v29, v29, v31, vcc
        v_cndmask_b32   v28, v19, v28, vcc
        s_branch        .L13048_2
.L13140_2:
        s_mov_b64       exec, s[54:55]
        v_cndmask_b32   v21, v21, 1.0, s[58:59]
        v_mov_b32       v31, 2
.L13156_2:
        s_mov_b64       exec, s[50:51]
        v_cmp_eq_u32    vcc, 0, v21
        s_and_b64       exec, s[50:51], vcc
        v_lshlrev_b32   v23, 2, v16
        s_cbranch_execz .L13716_2
        v_add_i32       v23, vcc, 0xe8c1b57c, v23
        v_and_b32       v28, 0x3ffffffc, v23
        v_lshrrev_b32   v29, 18, v28
        ds_read_u8      v29, v29
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v29, v29, 0, 8
        v_cmp_eq_i32    vcc, 0, v29
        s_and_saveexec_b64 s[52:53], vcc
        v_lshrrev_b32   v28, 6, v28
        s_cbranch_execz .L13428_2
        v_add_i32       v28, vcc, s7, v28
        buffer_load_ubyte v28, v28, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v28
        s_and_saveexec_b64 s[54:55], vcc
        v_lshrrev_b32   v11, 30, v35
        s_cbranch_execz .L13428_2
        s_mov_b32       s5, 0x3ffffffc
        v_bfi_b32       v11, s5, v23, v11
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[56:57], exec
        s_mov_b64       s[58:59], exec
        v_mov_b32       v23, 0
        v_mov_b32       v28, s0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v19, s5
        s_movk_i32      s60, 0x0
        s_movk_i32      s61, 0x0
        s_nop           0x0
.L13320_2:
        v_cmp_gt_i32    s[62:63], v23, v28
        v_cmp_eq_i32    vcc, v11, v19
        s_andn2_b64     s[60:61], s[60:61], exec
        s_or_b64        s[60:61], vcc, s[60:61]
        s_or_b64        vcc, s[62:63], vcc
        s_and_saveexec_b64 s[62:63], vcc
        s_andn2_b64     s[58:59], s[58:59], exec
        s_cbranch_scc0  .L13412_2
        s_mov_b64       exec, s[58:59]
        v_add_i32       v29, vcc, v23, v28
        v_ashrrev_i32   v29, 1, v29
        v_lshlrev_b32   v30, 2, v29
        v_add_i32       v30, vcc, s4, v30
        v_add_i32       v31, vcc, -1, v29
        v_add_i32       v29, vcc, 1, v29
        tbuffer_load_format_x v19, v30, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v19, v11
        v_cndmask_b32   v28, v28, v31, vcc
        v_cndmask_b32   v23, v29, v23, vcc
        s_branch        .L13320_2
.L13412_2:
        s_mov_b64       exec, s[56:57]
        v_cndmask_b32   v22, v22, 1.0, s[60:61]
        v_mov_b32       v31, 2
.L13428_2:
        s_mov_b64       exec, s[52:53]
        v_cmp_eq_u32    vcc, 0, v22
        s_and_b64       exec, s[52:53], vcc
        v_bfe_u32       v24, v37, 10, 12
        s_cbranch_execz .L13716_2
        ds_read_u8      v24, v24
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v24, v24, 0, 8
        v_cmp_eq_i32    vcc, 0, v24
        s_and_saveexec_b64 s[54:55], vcc
        v_lshlrev_b32   v16, 8, v16
        s_cbranch_execz .L13700_2
        v_add_i32       v16, vcc, 0x306d5f00, v16
        v_lshrrev_b32   v24, 24, v35
        s_mov_b32       s5, 0x3fffff00
        v_bfi_b32       v16, s5, v16, v24
        v_lshrrev_b32   v24, 6, v16
        v_add_i32       v24, vcc, s7, v24
        buffer_load_ubyte v24, v24, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v24
        s_and_saveexec_b64 s[56:57], vcc
        s_cbranch_execz .L13700_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[58:59], exec
        s_mov_b64       s[60:61], exec
        v_mov_b32       v11, s0
        v_mov_b32       v24, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v19, s5
        s_movk_i32      s62, 0x0
        s_movk_i32      s63, 0x0
        s_nop           0x0
        s_nop           0x0
.L13592_2:
        v_cmp_gt_i32    s[64:65], v24, v11
        v_cmp_eq_i32    vcc, v16, v19
        s_andn2_b64     s[62:63], s[62:63], exec
        s_or_b64        s[62:63], vcc, s[62:63]
        s_or_b64        vcc, s[64:65], vcc
        s_and_saveexec_b64 s[64:65], vcc
        s_andn2_b64     s[60:61], s[60:61], exec
        s_cbranch_scc0  .L13684_2
        s_mov_b64       exec, s[60:61]
        v_add_i32       v28, vcc, v11, v24
        v_ashrrev_i32   v28, 1, v28
        v_lshlrev_b32   v29, 2, v28
        v_add_i32       v29, vcc, s4, v29
        v_add_i32       v30, vcc, -1, v28
        v_add_i32       v28, vcc, 1, v28
        tbuffer_load_format_x v19, v29, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v19, v16
        v_cndmask_b32   v24, v28, v24, vcc
        v_cndmask_b32   v11, v11, v30, vcc
        s_branch        .L13592_2
.L13684_2:
        s_mov_b64       exec, s[58:59]
        v_cndmask_b32   v25, v25, 1.0, s[62:63]
        v_mov_b32       v31, 2
.L13700_2:
        s_mov_b64       exec, s[54:55]
        v_cmp_eq_u32    vcc, 0, v25
        v_addc_u32      v7, vcc, v7, 0, vcc
.L13716_2:
        s_mov_b64       exec, s[42:43]
.L13720_2:
        s_andn2_b64     exec, s[38:39], exec
        v_cndmask_b32   v8, 0, -1, s[36:37]
        v_mov_b32       v31, 0
        s_mov_b64       exec, s[38:39]
        s_branch        .L6824_2
.L13744_2:
        s_mov_b64       exec, s[12:13]
        v_cmp_eq_i32    vcc, 0, v31
        s_and_saveexec_b64 s[4:5], vcc
        v_mov_b32       v0, 0x400
        s_cbranch_execz .L13776_2
        tbuffer_store_format_x v0, v5, s[24:27], 0 offen format:[32,float]
.L13776_2:
        s_andn2_b64     exec, s[4:5], exec
        s_cbranch_execz .L14240_2
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_lshrrev_b32   v0, 26, v12
        v_add_i32       v0, vcc, s1, v0
        v_bfe_u32       v1, v12, 20, 6
        v_cmp_eq_i32    s[2:3], v31, 1
        v_lshlrev_b32   v6, 4, v12
        v_add_i32       v1, vcc, s1, v1
        v_bfe_u32       v16, v12, 14, 6
        v_lshrrev_b32   v17, 28, v37
        v_cndmask_b32   v6, v53, v6, s[2:3]
        v_add_i32       v15, vcc, s1, v16
        v_bfe_u32       v16, v12, 8, 6
        v_cndmask_b32   v14, v39, v17, s[2:3]
        v_add_i32       v16, vcc, s1, v16
        v_bfe_u32       v12, v12, 2, 6
        v_and_b32       v6, 48, v6
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v0, v0, s[8:11], 0 offen
        v_add_i32       v12, vcc, s1, v12
        v_or_b32        v6, v14, v6
        buffer_load_ubyte v1, v1, s[8:11], 0 offen
        v_add_i32       v6, vcc, s1, v6
        v_bfe_u32       v14, v37, 22, 6
        buffer_load_ubyte v15, v15, s[8:11], 0 offen
        v_add_i32       v14, vcc, s1, v14
        v_bfe_u32       v17, v37, 16, 6
        buffer_load_ubyte v16, v16, s[8:11], 0 offen
        v_add_i32       v17, vcc, s1, v17
        v_bfe_u32       v18, v37, 10, 6
        buffer_load_ubyte v12, v12, s[8:11], 0 offen
        v_add_i32       v18, vcc, s1, v18
        v_bfe_u32       v19, v37, 4, 6
        v_lshrrev_b32   v20, 30, v35
        v_lshlrev_b32   v11, 2, v37
        buffer_load_ubyte v6, v6, s[8:11], 0 offen
        v_add_i32       v19, vcc, s1, v19
        v_bfi_b32       v11, 60, v11, v20
        buffer_load_ubyte v14, v14, s[8:11], 0 offen
        v_add_i32       v11, vcc, s1, v11
        v_bfe_u32       v10, v35, 24, 6
        buffer_load_ubyte v17, v17, s[8:11], 0 offen
        v_add_i32       v10, vcc, s1, v10
        s_nop           0x0
        buffer_load_ubyte v18, v18, s[8:11], 0 offen
        buffer_load_ubyte v19, v19, s[8:11], 0 offen
        buffer_load_ubyte v11, v11, s[8:11], 0 offen
        buffer_load_ubyte v10, v10, s[8:11], 0 offen
        buffer_store_byte v4, v5, s[24:27], 0 offen offset:17 glc
        buffer_store_byte v2, v5, s[24:27], 0 offen offset:18 glc
        buffer_store_byte v8, v5, s[24:27], 0 offen offset:19 glc
        buffer_store_byte v51, v5, s[24:27], 0 offen offset:20 glc
        buffer_store_byte v13, v5, s[24:27], 0 offen offset:24 glc
        buffer_store_byte v3, v5, s[24:27], 0 offen offset:28 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:5 glc
        buffer_store_byte v1, v5, s[24:27], 0 offen offset:6 glc
        buffer_store_byte v15, v5, s[24:27], 0 offen offset:7 glc
        buffer_store_byte v16, v5, s[24:27], 0 offen offset:8 glc
        buffer_store_byte v12, v5, s[24:27], 0 offen offset:9 glc
        buffer_store_byte v6, v5, s[24:27], 0 offen offset:10 glc
        buffer_store_byte v14, v5, s[24:27], 0 offen offset:11 glc
        buffer_store_byte v17, v5, s[24:27], 0 offen offset:12 glc
        buffer_store_byte v18, v5, s[24:27], 0 offen offset:13 glc
        v_mov_b32       v0, 1
        buffer_store_byte v19, v5, s[24:27], 0 offen offset:14 glc
        v_add_i32       v1, vcc, 1, v7
        buffer_store_byte v11, v5, s[24:27], 0 offen offset:15 glc
        buffer_store_byte v10, v5, s[24:27], 0 offen offset:16 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:4 glc
        tbuffer_store_format_x v1, v5, s[24:27], 0 offen format:[32,float]
.L14240_2:
        s_endpgm
.kernel OpenCL_SHA1_PerformSearching_ForwardAndBackwardMatching
    .header
        .fill 8, 1, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x40, 0x11, 0x00, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
        .fill 8, 1, 0x00
    .metadata
        .ascii ";ARGSTART:__OpenCL_OpenCL_SHA1_PerformSearching_ForwardAndBackwardMatchi"
        .ascii "ng_kernel\n"
        .ascii ";version:3:1:111\n"
        .ascii ";device:tahiti\n"
        .ascii ";uniqueid:1027\n"
        .ascii ";memory:uavprivate:0\n"
        .ascii ";memory:hwlocal:4416\n"
        .ascii ";memory:hwregion:0\n"
        .ascii ";pointer:outputArray:struct:1:1:0:uav:12:32:RW:0:0\n"
        .ascii ";pointer:key:u8:1:1:16:c:13:1:RO:0:0\n"
        .ascii ";constarg:1:key\n"
        .ascii ";pointer:tripcodeChunkArray:u32:1:1:32:uav:14:4:RO:0:0\n"
        .ascii ";constarg:2:tripcodeChunkArray\n"
        .ascii ";value:numTripcodeChunk:u32:1:1:48\n"
        .ascii ";pointer:keyCharTable_OneByte:u8:1:1:64:c:11:1:RO:0:0\n"
        .ascii ";constarg:4:keyCharTable_OneByte\n"
        .ascii ";pointer:keyCharTable_FirstByte:u8:1:1:80:c:15:1:RO:0:0\n"
        .ascii ";constarg:5:keyCharTable_FirstByte\n"
        .ascii ";pointer:keyCharTable_SecondByte:u8:1:1:96:c:11:1:RO:0:0\n"
        .ascii ";constarg:6:keyCharTable_SecondByte\n"
        .ascii ";pointer:keyCharTable_SecondByteAndOneByte:u8:1:1:112:c:16:1:RO:0:0\n"
        .ascii ";constarg:7:keyCharTable_SecondByteAndOneByte\n"
        .ascii ";pointer:smallChunkBitmap_constant:u8:1:1:128:c:17:1:RO:0:0\n"
        .ascii ";constarg:8:smallChunkBitmap_constant\n"
        .ascii ";pointer:chunkBitmap:u8:1:1:144:uav:18:1:RO:0:0\n"
        .ascii ";constarg:9:chunkBitmap\n"
        .ascii ";memory:datareqd\n"
        .ascii ";function:1:1038\n"
        .ascii ";uavid:11\n"
        .ascii ";printfid:9\n"
        .ascii ";cbid:10\n"
        .ascii ";privateid:8\n"
        .ascii ";reflection:0:GPUOutput*\n"
        .ascii ";reflection:1:uchar*\n"
        .ascii ";reflection:2:uint*\n"
        .ascii ";reflection:3:uint\n"
        .ascii ";reflection:4:uchar*\n"
        .ascii ";reflection:5:uchar*\n"
        .ascii ";reflection:6:uchar*\n"
        .ascii ";reflection:7:uchar*\n"
        .ascii ";reflection:8:uchar*\n"
        .ascii ";reflection:9:uchar*\n"
        .ascii ";ARGEND:__OpenCL_OpenCL_SHA1_PerformSearching_ForwardAndBackwardMatching"
        .ascii "_kernel\n"
    .data
        .fill 4736, 1, 0x00
    .inputs
    .outputs
    .uav
        .entry 12, 4, 0, 5
        .entry 14, 4, 0, 5
        .entry 18, 4, 0, 5
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
        .cbmask 13, 0
        .cbmask 11, 0
        .cbmask 15, 0
        .cbmask 11, 0
        .cbmask 16, 0
        .cbmask 17, 0
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
        .entry 0x80001041, 0x00000037
        .entry 0x80001042, 0x00000032
        .entry 0x80001863, 0x00000066
        .entry 0x80001864, 0x00000100
        .entry 0x80001043, 0x000000c0
        .entry 0x80001044, 0x00000000
        .entry 0x80001045, 0x00000000
        .entry 0x00002e13, 0x00090098
        .entry 0x8000001c, 0x00000100
        .entry 0x8000001d, 0x00000000
        .entry 0x8000001e, 0x00000000
        .entry 0x80001841, 0x00000000
        .entry 0x8000001f, 0x0007f400
        .entry 0x80001843, 0x0007f400
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
        .entry 0x80000082, 0x00001200
    .subconstantbuffers
    .uavmailboxsize 0
    .uavopmask
        .byte 0x00, 0xf4, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00
        .fill 120, 1, 0x00
    .text
        s_mov_b32       m0, 0x8000
        s_buffer_load_dword s0, s[8:11], 0x4
        s_load_dwordx4  s[16:19], s[2:3], 0x68
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v1, s0
        buffer_load_ubyte v2, v1, s[16:19], 0 offen offset:1
        buffer_load_ubyte v3, v1, s[16:19], 0 offen offset:11
        buffer_load_ubyte v4, v1, s[16:19], 0 offen
        s_buffer_load_dword s1, s[4:7], 0x4
        s_buffer_load_dword s13, s[4:7], 0x18
        s_buffer_load_dword s14, s[4:7], 0x1c
        s_buffer_load_dword s15, s[8:11], 0x14
        s_buffer_load_dword s20, s[8:11], 0x1c
        s_buffer_load_dword s21, s[8:11], 0x0
        s_waitcnt       lgkmcnt(0)
        s_min_u32       s1, s1, 0xffff
        s_mul_i32       s1, s12, s1
        s_add_u32       s1, s1, s13
        s_add_u32       s12, s12, s14
        v_add_i32       v5, vcc, s1, v0
        s_ashr_i32      s1, s12, 6
        v_and_b32       v6, 63, v0
        s_and_b32       s12, s12, 63
        s_load_dwordx4  s[24:27], s[2:3], 0x60
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x80
        v_lshlrev_b32   v5, 5, v5
        s_add_u32       s1, s1, s20
        s_waitcnt       vmcnt(2)
        v_add_i32       v2, vcc, v2, v6
        s_add_u32       s12, s12, s15
        v_add_i32       v5, vcc, s21, v5
        v_mov_b32       v6, 0
        s_waitcnt       vmcnt(1)
        v_add_i32       v3, vcc, s1, v3
        v_add_i32       v2, vcc, s20, v2
        s_waitcnt       vmcnt(0)
        v_add_i32       v4, vcc, s12, v4
        buffer_load_ubyte v7, v1, s[16:19], 0 offen offset:2
        buffer_load_ubyte v1, v1, s[16:19], 0 offen offset:3
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v3, v3, s[32:35], 0 offen
        buffer_load_ubyte v2, v2, s[32:35], 0 offen
        buffer_load_ubyte v4, v4, s[28:31], 0 offen
        s_buffer_load_dword s1, s[4:7], 0x20
        s_buffer_load_dword s4, s[8:11], 0x8
        s_buffer_load_dword s5, s[8:11], 0xc
        s_buffer_load_dword s6, s[8:11], 0x20
        s_buffer_load_dword s7, s[8:11], 0x24
        buffer_store_byte v6, v5, s[24:27], 0 offen offset:4 glc
        v_cmp_eq_i32    vcc, 0, v0
        s_and_saveexec_b64 s[8:9], vcc
        s_cbranch_execz .L3940_3
        s_load_dwordx4  s[36:39], s[2:3], 0x88
        s_movk_i32      s10, 0x0
        s_movk_i32      s11, 0x100
.L268_3:
        s_cmp_gt_u32    s11, 0
        s_cbranch_scc0  .L3940_3
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s12, s6, s10
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s12
        v_mov_b32       v8, s10
        s_add_u32       s12, s10, 1
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 2
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 3
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 4
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 5
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 6
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 7
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 8
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 9
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 10
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 11
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 12
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 13
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 14
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 15
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 16
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 17
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 18
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 19
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 20
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 21
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 22
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 23
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 24
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 25
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 26
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 27
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 28
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 29
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 30
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 31
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 32
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 33
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 34
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 35
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 36
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 37
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 38
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 39
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 40
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 41
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 42
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 43
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 44
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 45
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 46
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 47
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 48
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 49
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 50
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 51
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 52
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 53
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 54
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 55
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 56
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 57
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 58
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 59
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 60
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 61
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 62
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 63
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 64
        s_add_u32       s12, s6, s10
        v_mov_b32       v6, s12
        v_mov_b32       v8, s10
        s_add_u32       s12, s10, 1
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 2
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 3
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 4
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 5
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 6
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 7
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 8
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 9
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 10
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 11
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 12
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 13
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 14
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 15
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 16
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 17
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 18
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 19
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 20
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 21
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 22
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 23
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 24
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 25
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 26
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 27
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 28
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 29
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 30
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 31
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 32
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 33
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 34
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 35
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 36
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 37
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 38
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 39
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 40
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 41
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 42
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 43
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 44
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 45
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 46
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 47
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s12, s10, 48
        s_add_u32       s13, s6, s12
        v_mov_b32       v6, s13
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 49
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 50
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 51
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 52
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 53
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 54
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 55
        buffer_load_ubyte v15, v6, s[36:39], 0 offen
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[36:39], 0 offen offset:7
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s12, s10, 56
        v_mov_b32       v8, s12
        s_add_u32       s12, s10, 57
        v_mov_b32       v9, s12
        s_add_u32       s12, s10, 58
        v_mov_b32       v10, s12
        s_add_u32       s12, s10, 59
        v_mov_b32       v11, s12
        s_add_u32       s12, s10, 60
        v_mov_b32       v12, s12
        s_add_u32       s12, s10, 61
        v_mov_b32       v13, s12
        s_add_u32       s12, s10, 62
        v_mov_b32       v14, s12
        s_add_u32       s12, s10, 63
        buffer_load_ubyte v15, v6, s[36:39], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[36:39], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[36:39], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[36:39], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[36:39], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[36:39], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[36:39], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[36:39], 0 offen offset:15
        s_waitcnt       vmcnt(7)
        ds_write_b8     v8, v15
        s_waitcnt       vmcnt(6)
        ds_write_b8     v9, v16
        s_waitcnt       vmcnt(5)
        ds_write_b8     v10, v17
        s_waitcnt       vmcnt(4)
        ds_write_b8     v11, v18
        s_waitcnt       vmcnt(3)
        ds_write_b8     v12, v19
        s_waitcnt       vmcnt(2)
        ds_write_b8     v13, v20
        s_waitcnt       vmcnt(1)
        ds_write_b8     v14, v21
        v_mov_b32       v8, s12
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 64
        s_sub_i32       s11, s11, 8
        s_branch        .L268_3
.L3940_3:
        s_mov_b64       exec, s[8:9]
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s0
        buffer_load_ubyte v8, v6, s[16:19], 0 offen offset:5
        buffer_load_ubyte v9, v6, s[16:19], 0 offen offset:4
        buffer_load_ubyte v10, v6, s[16:19], 0 offen offset:6
        buffer_load_ubyte v11, v6, s[16:19], 0 offen offset:8
        buffer_load_ubyte v12, v6, s[16:19], 0 offen offset:9
        buffer_load_ubyte v13, v6, s[16:19], 0 offen offset:7
        buffer_load_ubyte v6, v6, s[16:19], 0 offen offset:10
        s_waitcnt       vmcnt(6)
        v_lshlrev_b32   v8, 16, v8
        s_waitcnt       vmcnt(5)
        v_lshlrev_b32   v9, 24, v9
        v_or_b32        v8, v8, v9
        s_waitcnt       vmcnt(4)
        v_lshlrev_b32   v9, 8, v10
        s_waitcnt       vmcnt(3)
        v_lshlrev_b32   v10, 24, v11
        s_movk_i32      s0, 0xff
        v_or_b32        v8, v8, v9
        v_bfi_b32       v9, s0, v3, v10
        s_waitcnt       vmcnt(2)
        v_lshlrev_b32   v10, 16, v12
        s_waitcnt       vmcnt(1)
        v_or_b32        v8, v13, v8
        v_mov_b32       v11, 0x1000
        v_mov_b32       v12, 0
        v_or_b32        v9, v9, v10
        s_waitcnt       vmcnt(0)
        v_lshlrev_b32   v6, 8, v6
        ds_write2_b32   v11, v12, v8 offset1:1
        v_or_b32        v6, v9, v6
        v_mov_b32       v9, 0x80000000
        ds_write2_b32   v11, v6, v9 offset0:2 offset1:3
        ds_write2_b32   v11, v12, v12 offset0:4 offset1:5
        ds_write2_b32   v11, v12, v12 offset0:6 offset1:7
        ds_write2_b32   v11, v12, v12 offset0:8 offset1:9
        ds_write2_b32   v11, v12, v12 offset0:10 offset1:11
        ds_write2_b32   v11, v12, v12 offset0:12 offset1:13
        v_mov_b32       v9, 0x60
        v_alignbit_b32  v10, v6, v6, 31
        v_xor_b32       v8, 0x80000000, v8
        ds_write2_b32   v11, v12, v9 offset0:14 offset1:15
        v_xor_b32       v6, 0x60, v6
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v9, 0x80000000, v10
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v14, v8, v8, 31
        ds_write2_b32   v11, v10, v8 offset0:16 offset1:17
        ds_write2_b32   v11, v6, v9 offset0:18 offset1:19
        v_alignbit_b32  v15, v6, v6, 31
        v_xor_b32       v16, 0x60, v14
        v_alignbit_b32  v17, v9, v9, 31
        ds_write2_b32   v11, v14, v15 offset0:20 offset1:21
        v_alignbit_b32  v16, v16, v16, 31
        ds_write2_b32   v11, v17, v16 offset0:22 offset1:23
        ds_read2_b32    v[18:19], v11 offset0:10 offset1:10
        ds_read2_b32    v[20:21], v11 offset0:11 offset1:11
        ds_read2_b32    v[22:23], v11 offset0:14 offset1:14
        ds_read_b32     v24, v12 offset:4160
        ds_read2_b32    v[25:26], v11 offset0:12 offset1:12
        ds_read2_b32    v[27:28], v11 offset0:13 offset1:13
        v_xor_b32       v29, v6, v16
        v_xor_b32       v10, v10, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v18, v29
        v_xor_b32       v29, v17, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_alignbit_b32  v18, v18, v18, 31
        v_alignbit_b32  v29, v29, v29, 31
        v_xor_b32       v30, v9, v10
        v_xor_b32       v31, v15, v18
        v_xor_b32       v20, v20, v30
        v_xor_b32       v30, 0x60, v31
        v_xor_b32       v31, v14, v29
        v_alignbit_b32  v20, v20, v20, 31
        ds_write2_b32   v11, v10, v29 offset0:24 offset1:25
        v_xor_b32       v27, v27, v30
        v_xor_b32       v25, v25, v31
        ds_write2_b32   v11, v18, v20 offset0:26 offset1:27
        v_alignbit_b32  v27, v27, v27, 31
        v_alignbit_b32  v25, v25, v25, 31
        ds_write2_b32   v11, v25, v27 offset0:28 offset1:29
        v_xor_b32       v30, v17, v20
        v_xor_b32       v16, v16, v25
        ds_read2_b32    v[31:32], v11 offset0:17 offset1:17
        ds_read2_b32    v[33:34], v11 offset0:18 offset1:18
        v_xor_b32       v30, v24, v30
        v_xor_b32       v8, v8, v16
        v_xor_b32       v16, v22, v30
        v_xor_b32       v8, 0x60, v8
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v22, v27, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read2_b32    v[35:36], v11 offset0:21 offset1:21
        ds_read2_b32    v[37:38], v11 offset0:23 offset1:23
        ds_read_b32     v30, v12 offset:4172
        ds_read2_b32    v[39:40], v11 offset0:20 offset1:20
        v_xor_b32       v6, v6, v22
        v_xor_b32       v22, v29, v16
        v_xor_b32       v41, v18, v8
        v_xor_b32       v6, v24, v6
        v_xor_b32       v9, v9, v22
        v_xor_b32       v14, v14, v41
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v31, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v14, v33, v14
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v22, v20, v6
        v_xor_b32       v24, v25, v9
        v_xor_b32       v15, v15, v22
        v_xor_b32       v22, v27, v14
        ds_write2_b32   v11, v16, v8 offset0:30 offset1:31
        v_xor_b32       v24, v17, v24
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v15, v30, v15
        v_xor_b32       v22, v37, v22
        ds_write2_b32   v11, v6, v9 offset0:32 offset1:33
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v24, v39, v24
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v22, v35, v22
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v14, v15 offset0:34 offset1:35
        v_alignbit_b32  v22, v22, v22, 31
        ds_write2_b32   v11, v24, v22 offset0:36 offset1:37
        ds_read_b32     v30, v12 offset:4192
        v_xor_b32       v16, v16, v15
        ds_read_b32     v31, v12 offset:4196
        v_xor_b32       v33, v24, v8
        v_xor_b32       v10, v10, v16
        v_xor_b32       v16, v6, v22
        ds_read_b32     v35, v12 offset:4208
        ds_read_b32     v39, v12 offset:4216
        ds_read2_b32    v[41:42], v11 offset0:26 offset1:26
        ds_read2_b32    v[43:44], v11 offset0:27 offset1:27
        v_xor_b32       v29, v29, v33
        v_xor_b32       v10, v17, v10
        v_xor_b32       v16, v18, v16
        v_xor_b32       v17, v37, v29
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v16, v30, v16
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v18, v9, v10
        v_xor_b32       v18, v20, v18
        v_xor_b32       v20, v15, v16
        v_xor_b32       v29, v14, v17
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v18, v31, v18
        v_xor_b32       v20, v27, v20
        v_xor_b32       v25, v25, v29
        v_alignbit_b32  v18, v18, v18, 31
        ds_write2_b32   v11, v10, v17 offset0:38 offset1:39
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v43, v20
        v_xor_b32       v25, v41, v25
        ds_write2_b32   v11, v16, v18 offset0:40 offset1:41
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v25, v25, v25, 31
        ds_write2_b32   v11, v25, v20 offset0:42 offset1:43
        v_xor_b32       v29, v24, v18
        v_xor_b32       v22, v22, v25
        ds_read_b32     v30, v12 offset:4220
        ds_read_b32     v31, v12 offset:4224
        v_xor_b32       v29, v39, v29
        v_xor_b32       v8, v8, v22
        v_xor_b32       v22, v35, v29
        v_xor_b32       v8, v27, v8
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v27, v20, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v29, v12 offset:4236
        ds_read_b32     v33, v12 offset:4244
        ds_read2_b32    v[45:46], v11 offset0:33 offset1:33
        ds_read_b32     v35, v12 offset:4232
        v_xor_b32       v6, v6, v27
        v_xor_b32       v27, v17, v22
        v_xor_b32       v37, v16, v8
        v_xor_b32       v6, v39, v6
        v_xor_b32       v9, v9, v27
        v_xor_b32       v14, v14, v37
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v30, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v14, v31, v14
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v27, v18, v6
        v_xor_b32       v30, v25, v9
        v_xor_b32       v15, v15, v27
        v_xor_b32       v27, v20, v14
        ds_write2_b32   v11, v22, v8 offset0:44 offset1:45
        v_xor_b32       v30, v24, v30
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v15, v45, v15
        v_xor_b32       v27, v33, v27
        ds_write2_b32   v11, v6, v9 offset0:46 offset1:47
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v30, v35, v30
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v27, v29, v27
        v_alignbit_b32  v29, v30, v30, 31
        ds_write2_b32   v11, v14, v15 offset0:48 offset1:49
        v_alignbit_b32  v27, v27, v27, 31
        ds_write2_b32   v11, v29, v27 offset0:50 offset1:51
        ds_read_b32     v30, v12 offset:4248
        v_xor_b32       v22, v22, v15
        ds_read2_b32    v[47:48], v11 offset0:39 offset1:39
        v_xor_b32       v31, v29, v8
        v_xor_b32       v10, v10, v22
        v_xor_b32       v22, v6, v27
        ds_read_b32     v35, v12 offset:4264
        ds_read_b32     v37, v12 offset:4272
        ds_read_b32     v39, v12 offset:4256
        ds_read2_b32    v[49:50], v11 offset0:41 offset1:41
        v_xor_b32       v17, v17, v31
        v_xor_b32       v10, v24, v10
        v_xor_b32       v16, v16, v22
        v_xor_b32       v17, v33, v17
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v16, v30, v16
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v22, v9, v10
        v_xor_b32       v18, v18, v22
        v_xor_b32       v22, v15, v16
        v_xor_b32       v24, v14, v17
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v18, v47, v18
        v_xor_b32       v22, v20, v22
        v_xor_b32       v24, v25, v24
        v_alignbit_b32  v18, v18, v18, 31
        ds_write2_b32   v11, v10, v17 offset0:52 offset1:53
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v22, v49, v22
        v_xor_b32       v24, v39, v24
        ds_write2_b32   v11, v16, v18 offset0:54 offset1:55
        v_alignbit_b32  v22, v22, v22, 31
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v24, v22 offset0:56 offset1:57
        v_xor_b32       v25, v29, v18
        v_xor_b32       v27, v27, v24
        ds_read2_b32    v[30:31], v11 offset0:45 offset1:45
        ds_read_b32     v33, v12 offset:4280
        v_xor_b32       v25, v37, v25
        v_xor_b32       v8, v8, v27
        v_xor_b32       v25, v35, v25
        v_xor_b32       v8, v20, v8
        v_alignbit_b32  v20, v25, v25, 31
        v_xor_b32       v25, v22, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v27, v12 offset:4292
        ds_read_b32     v35, v12 offset:4300
        ds_read_b32     v39, v12 offset:4284
        ds_read_b32     v41, v12 offset:4288
        v_xor_b32       v6, v6, v25
        v_xor_b32       v25, v17, v20
        v_xor_b32       v43, v16, v8
        v_xor_b32       v6, v37, v6
        v_xor_b32       v9, v9, v25
        v_xor_b32       v14, v14, v43
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v30, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v14, v33, v14
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v25, v18, v6
        v_xor_b32       v30, v24, v9
        v_xor_b32       v15, v15, v25
        v_xor_b32       v25, v22, v14
        ds_write2_b32   v11, v20, v8 offset0:58 offset1:59
        v_xor_b32       v30, v29, v30
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v15, v39, v15
        v_xor_b32       v25, v35, v25
        ds_write2_b32   v11, v6, v9 offset0:60 offset1:61
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v30, v41, v30
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v25, v27, v25
        v_alignbit_b32  v27, v30, v30, 31
        ds_write2_b32   v11, v14, v15 offset0:62 offset1:63
        v_alignbit_b32  v25, v25, v25, 31
        ds_write2_b32   v11, v27, v25 offset0:64 offset1:65
        ds_read_b32     v30, v12 offset:4304
        v_xor_b32       v20, v20, v15
        ds_read2_b32    v[51:52], v11 offset0:53 offset1:53
        v_xor_b32       v33, v27, v8
        v_xor_b32       v10, v10, v20
        v_xor_b32       v20, v6, v25
        ds_read_b32     v37, v12 offset:4320
        ds_read_b32     v39, v12 offset:4328
        ds_read_b32     v41, v12 offset:4312
        ds_read_b32     v43, v12 offset:4316
        v_xor_b32       v17, v17, v33
        v_xor_b32       v10, v29, v10
        v_xor_b32       v16, v16, v20
        v_xor_b32       v17, v35, v17
        v_alignbit_b32  v10, v10, v10, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v16, v30, v16
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v20, v9, v10
        v_xor_b32       v18, v18, v20
        v_xor_b32       v20, v15, v16
        v_xor_b32       v29, v14, v17
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v18, v51, v18
        v_xor_b32       v20, v22, v20
        v_xor_b32       v24, v24, v29
        v_alignbit_b32  v18, v18, v18, 31
        ds_write2_b32   v11, v10, v17 offset0:66 offset1:67
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v43, v20
        v_xor_b32       v24, v41, v24
        ds_write2_b32   v11, v16, v18 offset0:68 offset1:69
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v24, v24, v24, 31
        ds_write2_b32   v11, v24, v20 offset0:70 offset1:71
        v_xor_b32       v29, v27, v18
        v_xor_b32       v25, v25, v24
        ds_read_b32     v30, v12 offset:4332
        ds_read_b32     v33, v12 offset:4336
        v_xor_b32       v29, v39, v29
        v_xor_b32       v8, v8, v25
        v_xor_b32       v25, v37, v29
        v_xor_b32       v8, v22, v8
        v_alignbit_b32  v22, v25, v25, 31
        v_xor_b32       v10, v20, v10
        v_alignbit_b32  v8, v8, v8, 31
        ds_read_b32     v25, v12 offset:4348
        ds_read2_b32    v[53:54], v11 offset0:65 offset1:65
        ds_read_b32     v29, v12 offset:4340
        ds_read_b32     v35, v12 offset:4344
        v_xor_b32       v6, v6, v10
        v_xor_b32       v10, v17, v22
        v_xor_b32       v16, v16, v8
        v_xor_b32       v6, v39, v6
        v_xor_b32       v9, v9, v10
        v_xor_b32       v10, v14, v16
        v_alignbit_b32  v6, v6, v6, 31
        s_waitcnt       lgkmcnt(5)
        v_xor_b32       v9, v30, v9
        s_waitcnt       lgkmcnt(4)
        v_xor_b32       v10, v33, v10
        v_alignbit_b32  v9, v9, v9, 31
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v14, v18, v6
        v_xor_b32       v16, v24, v9
        v_xor_b32       v14, v15, v14
        v_xor_b32       v15, v20, v10
        ds_write2_b32   v11, v22, v8 offset0:72 offset1:73
        v_xor_b32       v16, v27, v16
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v14, v29, v14
        v_xor_b32       v24, v53, v15
        ds_write2_b32   v11, v6, v9 offset0:74 offset1:75
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v6, v35, v16
        v_alignbit_b32  v9, v14, v14, 31
        v_xor_b32       v14, v25, v24
        v_alignbit_b32  v6, v6, v6, 31
        ds_write2_b32   v11, v10, v9 offset0:76 offset1:77
        v_alignbit_b32  v9, v14, v14, 31
        ds_write2_b32   v11, v6, v9 offset0:78 offset1:79
        ds_read_b32     v6, v12 offset:4100
        ds_read_b32     v9, v12 offset:4104
        ds_read_b32     v10, v12 offset:4108
        ds_read_b32     v11, v12 offset:4112
        v_mov_b32       v14, 0x5a827999
        s_waitcnt       lgkmcnt(3)
        v_add_i32       v6, vcc, v6, v14
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v9, vcc, v9, v14
        ds_write_b32    v12, v6 offset:4100
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v6, vcc, v10, v14
        ds_write_b32    v12, v9 offset:4104
        s_waitcnt       lgkmcnt(2)
        v_add_i32       v9, vcc, v14, v11
        ds_write_b32    v12, v6 offset:4108
        ds_write_b32    v12, v9 offset:4112
        ds_read_b32     v6, v12 offset:4116
        ds_read_b32     v9, v12 offset:4124
        ds_read_b32     v10, v12 offset:4128
        ds_read_b32     v11, v12 offset:4120
        s_waitcnt       lgkmcnt(3)
        v_add_i32       v6, vcc, v6, v14
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v14
        ds_write_b32    v12, v6 offset:4116
        v_add_i32       v6, vcc, v9, v14
        ds_write_b32    v12, v11 offset:4120
        v_add_i32       v9, vcc, v10, v14
        ds_write_b32    v12, v6 offset:4124
        ds_write_b32    v12, v9 offset:4128
        ds_read_b32     v6, v12 offset:4132
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, v6, v14
        v_add_i32       v22, vcc, v19, v14
        ds_write_b32    v12, v6 offset:4132
        v_add_i32       v6, vcc, v21, v14
        ds_write_b32    v12, v22 offset:4136
        v_add_i32       v10, vcc, v26, v14
        ds_write_b32    v12, v6 offset:4140
        ds_write_b32    v12, v10 offset:4144
        v_add_i32       v6, vcc, v28, v14
        v_add_i32       v10, vcc, v23, v14
        ds_write_b32    v12, v6 offset:4148
        ds_write_b32    v12, v10 offset:4152
        ds_read_b32     v6, v12 offset:4156
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v6, vcc, v6, v14
        ds_write_b32    v12, v6 offset:4156
        v_add_i32       v6, vcc, v32, v14
        v_add_i32       v10, vcc, v34, v14
        ds_write_b32    v12, v6 offset:4164
        ds_write_b32    v12, v10 offset:4168
        v_add_i32       v6, vcc, 0x6ed9eba1, v40
        v_add_i32       v10, vcc, 0x6ed9eba1, v36
        ds_write_b32    v12, v6 offset:4176
        ds_write_b32    v12, v10 offset:4180
        v_add_i32       v6, vcc, 0x6ed9eba1, v38
        ds_write_b32    v12, v6 offset:4188
        v_add_i32       v38, vcc, 0x6ed9eba1, v42
        v_add_i32       v10, vcc, 0x6ed9eba1, v44
        ds_write_b32    v12, v38 offset:4200
        ds_write_b32    v12, v10 offset:4204
        ds_read_b32     v10, v12 offset:4212
        s_waitcnt       lgkmcnt(0)
        s_nop           0x0
        v_add_i32       v10, vcc, 0x6ed9eba1, v10
        ds_write_b32    v12, v10 offset:4212
        v_add_i32       v10, vcc, 0x6ed9eba1, v46
        ds_write_b32    v12, v10 offset:4228
        v_add_i32       v10, vcc, 0x6ed9eba1, v48
        ds_write_b32    v12, v10 offset:4252
        v_add_i32       v10, vcc, 0x8f1bbcdc, v50
        ds_write_b32    v12, v10 offset:4260
        v_add_i32       v10, vcc, 0x8f1bbcdc, v31
        ds_write_b32    v12, v10 offset:4276
        v_add_i32       v10, vcc, 0x8f1bbcdc, v52
        ds_write_b32    v12, v10 offset:4308
        v_add_i32       v10, vcc, 0xca62c1d6, v54
        ds_write_b32    v12, v10 offset:4356
        ds_read_b32     v10, v12 offset:4372
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0xca62c1d6, v10
        ds_write_b32    v12, v10 offset:4372
        ds_read_b32     v10, v12 offset:4404
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0xca62c1d6, v10
        v_lshrrev_b32   v0, 2, v0
        ds_write_b32    v12, v10 offset:4404
        v_lshlrev_b32   v10, 24, v4
        v_lshlrev_b32   v11, 16, v2
        v_and_b32       v0, 48, v0
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[16:19], s[2:3], 0x90
        v_or_b32        v10, v10, v11
        v_add_i32       v0, vcc, v7, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        s_add_u32       s0, -1, s5
        s_mov_b64       s[12:13], exec
        s_mov_b64       s[22:23], exec
        v_mov_b32       v6, 0
        v_mov_b32       v39, v1
        v_mov_b32       v9, 0x13c
        v_mov_b32       v12, v16
.L6784_3:
        s_movk_i32      s5, 0x3ff
        v_cmp_gt_i32    s[36:37], v6, s5
        s_and_saveexec_b64 s[38:39], s[36:37]
        v_cndmask_b32   v39, 0, -1, s[36:37]
        s_cbranch_execz .L6824_3
        v_mov_b32       v12, 0
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L12060_3
.L6824_3:
        s_and_b64       exec, s[38:39], s[22:23]
        v_ashrrev_i32   v7, 6, v6
        v_bfe_u32       v8, v0, 0, 8
        v_add_i32       v7, vcc, v8, v7
        v_add_i32       v7, vcc, s15, v7
        v_and_b32       v8, 63, v6
        v_bfe_u32       v9, v1, 0, 8
        v_add_i32       v8, vcc, v9, v8
        v_add_i32       v8, vcc, s20, v8
        buffer_load_ubyte v39, v7, s[28:31], 0 offen
        buffer_load_ubyte v38, v8, s[32:35], 0 offen
        s_waitcnt       vmcnt(0)
        s_barrier
        v_mov_b32       v9, 0x1000
        ds_read2_b32    v[11:12], v9 offset0:1 offset1:2
        v_lshlrev_b32   v14, 8, v39
        v_or_b32        v14, v10, v14
        v_or_b32        v14, v14, v38
        v_add_i32       v15, vcc, 0x9fb498b3, v14
        v_alignbit_b32  v16, v15, v15, 27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v16, v11
        v_add_i32       v11, vcc, 0xc2e5374, v11
        v_mov_b32       v16, 0x7bf36ae2
        s_mov_b32       s5, 0x59d148c0
        v_bfi_b32       v16, v15, s5, v16
        v_alignbit_b32  v17, v11, v11, 27
        ds_read2_b32    v[18:19], v9 offset0:3 offset1:4
        v_add_i32       v16, vcc, v16, v17
        v_add_i32       v12, vcc, v12, v16
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0x98badcfe, v12
        v_bfi_b32       v16, v11, v15, s5
        v_alignbit_b32  v17, v12, v12, 27
        v_add_i32       v16, vcc, v17, v16
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v18
        v_add_i32       v16, vcc, 0x7bf36ae2, v16
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v17, v16, v16, 27
        v_bfi_b32       v18, v12, v11, v15
        v_add_i32       v17, vcc, v17, v18
        ds_read2_b32    v[20:21], v9 offset0:5 offset1:6
        v_add_i32       v17, vcc, v17, v19
        v_add_i32       v17, vcc, 0x59d148c0, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_alignbit_b32  v18, v17, v17, 27
        v_bfi_b32       v19, v16, v12, v11
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, v19, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v20
        v_alignbit_b32  v16, v16, v16, 2
        v_alignbit_b32  v18, v15, v15, 27
        v_bfi_b32       v19, v17, v16, v12
        v_add_i32       v11, vcc, v11, v18
        ds_read2_b32    v[22:23], v9 offset0:7 offset1:8
        v_add_i32       v11, vcc, v19, v11
        v_add_i32       v11, vcc, v21, v11
        v_alignbit_b32  v18, v11, v11, 27
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v12, vcc, v12, v18
        v_bfi_b32       v18, v15, v17, v16
        v_add_i32       v12, vcc, v12, v18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v22, v12
        v_alignbit_b32  v15, v15, v15, 2
        v_alignbit_b32  v18, v12, v12, 27
        v_bfi_b32       v19, v11, v15, v17
        v_add_i32       v16, vcc, v16, v18
        ds_read2_b32    v[20:21], v9 offset0:9 offset1:10
        v_add_i32       v16, vcc, v19, v16
        v_add_i32       v16, vcc, v23, v16
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v18, v16, v16, 27
        v_bfi_b32       v19, v12, v11, v15
        v_add_i32       v17, vcc, v17, v18
        v_add_i32       v17, vcc, v19, v17
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v20
        v_alignbit_b32  v18, v17, v17, 27
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v15, vcc, v15, v18
        v_bfi_b32       v18, v16, v12, v11
        ds_read2_b32    v[19:20], v9 offset0:11 offset1:12
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, v21, v15
        v_alignbit_b32  v16, v16, v16, 2
        v_alignbit_b32  v18, v15, v15, 27
        v_bfi_b32       v21, v17, v16, v12
        v_add_i32       v11, vcc, v11, v18
        v_add_i32       v11, vcc, v21, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v19, v11
        v_alignbit_b32  v17, v17, v17, 2
        v_alignbit_b32  v18, v11, v11, 27
        v_bfi_b32       v19, v15, v17, v16
        v_add_i32       v12, vcc, v12, v18
        ds_read2_b32    v[21:22], v9 offset0:13 offset1:14
        v_add_i32       v12, vcc, v19, v12
        v_add_i32       v12, vcc, v20, v12
        v_alignbit_b32  v18, v12, v12, 27
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v16, vcc, v16, v18
        v_bfi_b32       v18, v11, v15, v17
        v_add_i32       v16, vcc, v16, v18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v21
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v18, v16, v16, 27
        v_bfi_b32       v19, v12, v11, v15
        v_add_i32       v17, vcc, v17, v18
        ds_read2_b32    v[20:21], v9 offset0:15 offset1:16
        v_add_i32       v17, vcc, v19, v17
        v_add_i32       v17, vcc, v22, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_alignbit_b32  v18, v17, v17, 27
        v_bfi_b32       v19, v16, v12, v11
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, v19, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v20, v15
        v_alignbit_b32  v18, v15, v15, 27
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v11, vcc, v11, v18
        v_bfi_b32       v18, v17, v16, v12
        v_alignbit_b32  v19, v14, v14, 31
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v21, v19
        ds_read2_b32    v[19:20], v9 offset0:17 offset1:18
        v_add_i32       v11, vcc, v11, v18
        v_add_i32       v11, vcc, 0x5a827999, v11
        v_alignbit_b32  v17, v17, v17, 2
        v_alignbit_b32  v18, v11, v11, 27
        v_bfi_b32       v21, v15, v17, v16
        v_add_i32       v12, vcc, v12, v18
        v_add_i32       v12, vcc, v21, v12
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v12, v19
        v_alignbit_b32  v15, v15, v15, 2
        v_alignbit_b32  v18, v12, v12, 27
        ds_read2_b32    v[21:22], v9 offset0:19 offset1:20
        v_bfi_b32       v19, v11, v15, v17
        v_add_i32       v16, vcc, v16, v18
        v_add_i32       v16, vcc, v19, v16
        v_add_i32       v16, vcc, v20, v16
        v_alignbit_b32  v18, v16, v16, 27
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v17, vcc, v17, v18
        v_bfi_b32       v18, v12, v11, v15
        v_alignbit_b32  v19, v14, v14, 30
        v_add_i32       v17, vcc, v17, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v21, v19
        v_add_i32       v17, vcc, v17, v18
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v18, v16, v11
        v_add_i32       v17, vcc, 0x5a827999, v17
        v_xor_b32       v18, v12, v18
        ds_read2_b32    v[20:21], v9 offset0:21 offset1:22
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v18, v17, v17, 27
        v_xor_b32       v23, v17, v12
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v23, v16
        v_add_i32       v15, vcc, v22, v15
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v18, v15, v15, 27
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v16, v15
        v_alignbit_b32  v17, v17, v17, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v20
        v_xor_b32       v18, v18, v17
        v_alignbit_b32  v20, v11, v11, 27
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v18, v14, v14, 29
        ds_read2_b32    v[22:23], v9 offset0:23 offset1:24
        v_add_i32       v12, vcc, v20, v12
        v_xor_b32       v20, v21, v18
        v_add_i32       v12, vcc, v12, v20
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v20, v11, v17
        v_add_i32       v12, vcc, 0x6ed9eba1, v12
        v_xor_b32       v20, v15, v20
        v_add_i32       v16, vcc, v16, v20
        v_alignbit_b32  v20, v12, v12, 27
        v_xor_b32       v21, v12, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v20
        v_xor_b32       v20, v21, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v22, v16
        ds_read2_b32    v[21:22], v9 offset0:25 offset1:26
        v_add_i32       v17, vcc, v17, v20
        v_alignbit_b32  v20, v16, v16, 27
        v_add_i32       v17, vcc, v17, v20
        v_xor_b32       v20, v19, v23
        v_add_i32       v17, vcc, v17, v20
        v_xor_b32       v20, v11, v16
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0x6ed9eba1, v17
        v_xor_b32       v20, v20, v12
        v_alignbit_b32  v23, v17, v17, 27
        v_add_i32       v15, vcc, v15, v20
        v_alignbit_b32  v20, v14, v14, 28
        v_add_i32       v15, vcc, v23, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v21, v20, v21
        v_add_i32       v15, vcc, v15, v21
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v21, v17, v12
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        v_xor_b32       v21, v16, v21
        ds_read2_b32    v[23:24], v9 offset0:27 offset1:28
        v_add_i32       v11, vcc, v11, v21
        v_alignbit_b32  v21, v15, v15, 27
        v_xor_b32       v25, v15, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, v11, v21
        v_xor_b32       v21, v25, v17
        v_add_i32       v11, vcc, v22, v11
        v_add_i32       v12, vcc, v12, v21
        v_alignbit_b32  v21, v11, v11, 27
        v_add_i32       v12, vcc, v12, v21
        v_xor_b32       v21, v17, v11
        v_alignbit_b32  v15, v15, v15, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v12, vcc, v23, v12
        v_xor_b32       v21, v21, v15
        v_alignbit_b32  v22, v12, v12, 27
        v_add_i32       v16, vcc, v16, v21
        v_alignbit_b32  v21, v14, v14, 27
        ds_read2_b32    v[25:26], v9 offset0:29 offset1:30
        v_add_i32       v16, vcc, v22, v16
        v_xor_b32       v22, v24, v21
        v_add_i32       v16, vcc, v16, v22
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v22, v12, v15
        v_add_i32       v16, vcc, 0x6ed9eba1, v16
        v_xor_b32       v22, v11, v22
        v_add_i32       v17, vcc, v17, v22
        v_alignbit_b32  v22, v16, v16, 27
        v_xor_b32       v23, v16, v11
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, v17, v22
        v_xor_b32       v22, v23, v12
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v25
        ds_read2_b32    v[23:24], v9 offset0:31 offset1:32
        v_add_i32       v15, vcc, v15, v22
        v_alignbit_b32  v22, v17, v17, 27
        v_xor_b32       v25, v19, v20
        v_add_i32       v15, vcc, v15, v22
        v_xor_b32       v22, v26, v25
        v_add_i32       v15, vcc, v15, v22
        v_xor_b32       v22, v12, v17
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        v_xor_b32       v22, v22, v16
        v_alignbit_b32  v25, v15, v15, 27
        v_add_i32       v11, vcc, v11, v22
        v_alignbit_b32  v22, v14, v14, 26
        v_add_i32       v11, vcc, v25, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v23, v23, v22
        v_add_i32       v11, vcc, v11, v23
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v23, v15, v16
        v_add_i32       v11, vcc, 0x6ed9eba1, v11
        v_xor_b32       v23, v17, v23
        v_add_i32       v12, vcc, v12, v23
        v_alignbit_b32  v23, v11, v11, 27
        v_xor_b32       v19, v19, v18
        ds_read2_b32    v[25:26], v9 offset0:33 offset1:34
        v_add_i32       v12, vcc, v12, v23
        v_xor_b32       v19, v24, v19
        v_xor_b32       v23, v11, v17
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, v12, v19
        v_xor_b32       v19, v23, v15
        v_add_i32       v12, vcc, 0x6ed9eba1, v12
        v_add_i32       v16, vcc, v16, v19
        v_alignbit_b32  v19, v12, v12, 27
        v_add_i32       v16, vcc, v16, v19
        v_xor_b32       v19, v15, v12
        v_alignbit_b32  v11, v11, v11, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v25
        v_xor_b32       v19, v19, v11
        ds_read2_b32    v[23:24], v9 offset0:35 offset1:36
        v_alignbit_b32  v25, v16, v16, 27
        v_add_i32       v17, vcc, v17, v19
        v_alignbit_b32  v19, v14, v14, 25
        v_add_i32       v17, vcc, v25, v17
        v_xor_b32       v25, v26, v19
        v_add_i32       v17, vcc, v17, v25
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v25, v16, v11
        v_add_i32       v17, vcc, 0x6ed9eba1, v17
        v_xor_b32       v25, v12, v25
        v_add_i32       v15, vcc, v15, v25
        v_alignbit_b32  v25, v17, v17, 27
        v_add_i32       v15, vcc, v15, v25
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v23, v20, v23
        v_xor_b32       v25, v17, v12
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v23
        v_xor_b32       v23, v25, v16
        v_add_i32       v15, vcc, 0x6ed9eba1, v15
        ds_read2_b32    v[25:26], v9 offset0:37 offset1:38
        v_add_i32       v11, vcc, v11, v23
        v_alignbit_b32  v23, v15, v15, 27
        v_xor_b32       v27, v20, v22
        v_add_i32       v11, vcc, v11, v23
        v_xor_b32       v23, v24, v27
        v_add_i32       v11, vcc, v11, v23
        v_xor_b32       v23, v16, v15
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, 0x6ed9eba1, v11
        v_xor_b32       v23, v23, v17
        v_alignbit_b32  v24, v11, v11, 27
        v_add_i32       v12, vcc, v12, v23
        v_alignbit_b32  v23, v14, v14, 24
        v_add_i32       v12, vcc, v24, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v24, v23, v25
        v_add_i32       v12, vcc, v12, v24
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v24, v11, v17
        v_add_i32       v12, vcc, 0x6ed9eba1, v12
        v_xor_b32       v24, v15, v24
        v_add_i32       v16, vcc, v16, v24
        v_alignbit_b32  v24, v12, v12, 27
        ds_read2_b32    v[28:29], v9 offset0:39 offset1:40
        v_add_i32       v16, vcc, v16, v24
        v_xor_b32       v24, v20, v26
        v_xor_b32       v25, v12, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v24
        v_xor_b32       v24, v25, v11
        v_add_i32       v16, vcc, 0x6ed9eba1, v16
        v_add_i32       v17, vcc, v17, v24
        v_alignbit_b32  v24, v16, v16, 27
        v_add_i32       v17, vcc, v17, v24
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v28, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_bfi_b32       v24, v11, v12, v16
        v_bfi_b32       v25, v12, 0, v16
        v_alignbit_b32  v26, v17, v17, 27
        v_alignbit_b32  v28, v14, v14, 23
        v_xor_b32       v24, v24, v25
        v_add_i32       v15, vcc, v15, v26
        v_xor_b32       v25, v20, v28
        v_add_i32       v15, vcc, v24, v15
        v_xor_b32       v24, v29, v25
        ds_read2_b32    v[25:26], v9 offset0:41 offset1:42
        v_add_i32       v15, vcc, v15, v24
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_bfi_b32       v24, v12, v16, v17
        v_bfi_b32       v28, v16, 0, v17
        v_alignbit_b32  v29, v15, v15, 27
        v_xor_b32       v24, v24, v28
        v_add_i32       v11, vcc, v11, v29
        v_add_i32       v11, vcc, v24, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v25
        v_alignbit_b32  v17, v17, v17, 2
        v_bfi_b32       v24, v16, v17, v15
        v_bfi_b32       v25, v17, 0, v15
        v_alignbit_b32  v28, v11, v11, 27
        v_xor_b32       v24, v24, v25
        v_add_i32       v12, vcc, v12, v28
        v_xor_b32       v25, v22, v23
        ds_read2_b32    v[28:29], v9 offset0:43 offset1:44
        v_add_i32       v12, vcc, v24, v12
        v_xor_b32       v24, v26, v25
        v_add_i32       v12, vcc, v12, v24
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_bfi_b32       v24, v17, v15, v11
        v_bfi_b32       v25, v15, 0, v11
        v_alignbit_b32  v26, v12, v12, 27
        v_xor_b32       v24, v24, v25
        v_add_i32       v16, vcc, v16, v26
        v_alignbit_b32  v25, v14, v14, 22
        v_add_i32       v16, vcc, v24, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v24, v28, v25
        v_add_i32       v16, vcc, v16, v24
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_alignbit_b32  v11, v11, v11, 2
        v_bfi_b32       v24, v15, v11, v12
        v_bfi_b32       v26, v11, 0, v12
        v_alignbit_b32  v28, v16, v16, 27
        v_xor_b32       v30, v18, v22
        v_xor_b32       v24, v24, v26
        v_add_i32       v17, vcc, v17, v28
        v_xor_b32       v26, v19, v30
        v_add_i32       v17, vcc, v24, v17
        v_xor_b32       v24, v29, v26
        ds_read2_b32    v[28:29], v9 offset0:45 offset1:46
        v_add_i32       v17, vcc, v17, v24
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_bfi_b32       v24, v11, v12, v16
        v_bfi_b32       v26, v12, 0, v16
        v_alignbit_b32  v30, v17, v17, 27
        v_xor_b32       v24, v24, v26
        v_add_i32       v15, vcc, v15, v30
        v_add_i32       v15, vcc, v24, v15
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v28
        v_alignbit_b32  v16, v16, v16, 2
        v_bfi_b32       v24, v12, v16, v17
        v_bfi_b32       v26, v16, 0, v17
        v_alignbit_b32  v28, v15, v15, 27
        v_alignbit_b32  v30, v14, v14, 21
        v_xor_b32       v24, v24, v26
        v_add_i32       v11, vcc, v11, v28
        v_xor_b32       v26, v20, v30
        ds_read2_b32    v[31:32], v9 offset0:47 offset1:48
        v_add_i32       v11, vcc, v24, v11
        v_xor_b32       v24, v29, v26
        v_add_i32       v11, vcc, v11, v24
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_bfi_b32       v24, v16, v17, v15
        v_bfi_b32       v26, v17, 0, v15
        v_alignbit_b32  v28, v11, v11, 27
        v_xor_b32       v24, v24, v26
        v_add_i32       v12, vcc, v12, v28
        v_xor_b32       v26, v20, v23
        v_add_i32       v12, vcc, v24, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v24, v31, v26
        v_add_i32       v12, vcc, v12, v24
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v18, v18, v21
        v_bfi_b32       v24, v17, v15, v11
        v_bfi_b32       v28, v15, 0, v11
        v_alignbit_b32  v29, v12, v12, 27
        v_xor_b32       v18, v26, v18
        v_xor_b32       v24, v24, v28
        v_add_i32       v16, vcc, v16, v29
        v_xor_b32       v18, v25, v18
        ds_read2_b32    v[28:29], v9 offset0:49 offset1:50
        v_add_i32       v16, vcc, v24, v16
        v_xor_b32       v18, v32, v18
        v_add_i32       v16, vcc, v16, v18
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_bfi_b32       v18, v15, v11, v12
        v_bfi_b32       v24, v11, 0, v12
        v_alignbit_b32  v31, v16, v16, 27
        v_xor_b32       v18, v18, v24
        v_add_i32       v17, vcc, v17, v31
        v_alignbit_b32  v24, v14, v14, 20
        v_add_i32       v17, vcc, v18, v17
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v24, v28
        v_add_i32       v17, vcc, v17, v18
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_bfi_b32       v18, v11, v12, v16
        v_bfi_b32       v28, v12, 0, v16
        v_alignbit_b32  v31, v17, v17, 27
        v_xor_b32       v18, v18, v28
        v_add_i32       v15, vcc, v15, v31
        ds_read2_b32    v[31:32], v9 offset0:51 offset1:52
        v_add_i32       v15, vcc, v18, v15
        v_xor_b32       v18, v23, v29
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_bfi_b32       v18, v12, v16, v17
        v_bfi_b32       v28, v16, 0, v17
        v_alignbit_b32  v29, v15, v15, 27
        v_xor_b32       v18, v18, v28
        v_add_i32       v11, vcc, v11, v29
        v_add_i32       v11, vcc, v18, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v27, v31
        v_add_i32       v11, vcc, v11, v18
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_alignbit_b32  v17, v17, v17, 2
        v_bfi_b32       v18, v16, v17, v15
        v_bfi_b32       v28, v17, 0, v15
        v_alignbit_b32  v29, v11, v11, 27
        v_alignbit_b32  v31, v14, v14, 19
        v_xor_b32       v18, v18, v28
        v_add_i32       v12, vcc, v12, v29
        v_xor_b32       v28, v26, v31
        v_add_i32       v12, vcc, v18, v12
        v_xor_b32       v18, v28, v32
        ds_read2_b32    v[28:29], v9 offset0:53 offset1:54
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_bfi_b32       v18, v17, v15, v11
        v_bfi_b32       v32, v15, 0, v11
        v_alignbit_b32  v33, v12, v12, 27
        v_xor_b32       v18, v18, v32
        v_add_i32       v16, vcc, v16, v33
        v_add_i32       v16, vcc, v18, v16
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v16, vcc, v16, v28
        v_alignbit_b32  v11, v11, v11, 2
        v_bfi_b32       v18, v15, v11, v12
        v_bfi_b32       v28, v11, 0, v12
        v_alignbit_b32  v32, v16, v16, 27
        v_xor_b32       v33, v19, v25
        v_xor_b32       v18, v18, v28
        v_add_i32       v17, vcc, v17, v32
        v_xor_b32       v28, v24, v33
        ds_read2_b32    v[32:33], v9 offset0:55 offset1:56
        v_add_i32       v17, vcc, v18, v17
        v_xor_b32       v18, v28, v29
        v_add_i32       v17, vcc, v17, v18
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_bfi_b32       v18, v11, v12, v16
        v_bfi_b32       v28, v12, 0, v16
        v_alignbit_b32  v29, v17, v17, 27
        v_xor_b32       v18, v18, v28
        v_add_i32       v15, vcc, v15, v29
        v_alignbit_b32  v28, v14, v14, 18
        v_add_i32       v15, vcc, v18, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v28, v32
        v_add_i32       v15, vcc, v15, v18
        v_add_i32       v15, vcc, 0x8f1bbcdc, v15
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v18, v19, v27
        v_bfi_b32       v29, v12, v16, v17
        v_bfi_b32       v32, v16, 0, v17
        v_alignbit_b32  v34, v15, v15, 27
        v_xor_b32       v25, v25, v18
        v_xor_b32       v29, v29, v32
        v_add_i32       v11, vcc, v11, v34
        v_xor_b32       v25, v30, v25
        ds_read2_b32    v[34:35], v9 offset0:57 offset1:58
        v_add_i32       v11, vcc, v29, v11
        v_xor_b32       v25, v25, v33
        v_add_i32       v11, vcc, v11, v25
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_bfi_b32       v25, v16, v17, v15
        v_bfi_b32       v29, v17, 0, v15
        v_alignbit_b32  v32, v11, v11, 27
        v_xor_b32       v25, v25, v29
        v_add_i32       v12, vcc, v12, v32
        v_add_i32       v12, vcc, v25, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v25, v23, v34
        v_add_i32       v12, vcc, v12, v25
        v_add_i32       v12, vcc, 0x8f1bbcdc, v12
        v_alignbit_b32  v15, v15, v15, 2
        v_bfi_b32       v25, v17, v15, v11
        v_bfi_b32       v29, v15, 0, v11
        v_alignbit_b32  v32, v12, v12, 27
        v_alignbit_b32  v33, v14, v14, 17
        v_xor_b32       v25, v25, v29
        v_add_i32       v16, vcc, v16, v32
        v_xor_b32       v26, v26, v33
        ds_read2_b32    v[36:37], v9 offset0:59 offset1:60
        v_add_i32       v16, vcc, v25, v16
        v_xor_b32       v25, v26, v35
        v_add_i32       v16, vcc, v16, v25
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, 0x8f1bbcdc, v16
        v_bfi_b32       v25, v15, v11, v12
        v_bfi_b32       v26, v11, 0, v12
        v_alignbit_b32  v29, v16, v16, 27
        v_xor_b32       v25, v25, v26
        v_add_i32       v17, vcc, v17, v29
        v_xor_b32       v26, v23, v24
        v_add_i32       v17, vcc, v25, v17
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v25, v26, v36
        v_add_i32       v17, vcc, v17, v25
        v_xor_b32       v25, v11, v16
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v20, v20, v19
        v_add_i32       v17, vcc, 0x8f1bbcdc, v17
        v_xor_b32       v25, v25, v12
        v_xor_b32       v20, v26, v20
        ds_read2_b32    v[34:35], v9 offset0:61 offset1:62
        v_alignbit_b32  v29, v17, v17, 27
        v_add_i32       v15, vcc, v15, v25
        v_xor_b32       v20, v28, v20
        v_add_i32       v15, vcc, v29, v15
        v_xor_b32       v20, v20, v37
        v_add_i32       v15, vcc, v15, v20
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v20, v17, v12
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_xor_b32       v20, v16, v20
        v_add_i32       v11, vcc, v11, v20
        v_alignbit_b32  v20, v15, v15, 27
        v_alignbit_b32  v25, v14, v14, 16
        v_add_i32       v11, vcc, v11, v20
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v20, v25, v34
        v_xor_b32       v29, v15, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v11, vcc, v11, v20
        v_xor_b32       v20, v29, v17
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        ds_read2_b32    v[36:37], v9 offset0:63 offset1:64
        v_add_i32       v12, vcc, v12, v20
        v_alignbit_b32  v20, v11, v11, 27
        v_xor_b32       v27, v27, v26
        v_add_i32       v12, vcc, v12, v20
        v_xor_b32       v20, v27, v35
        v_add_i32       v12, vcc, v12, v20
        v_xor_b32       v20, v17, v11
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, 0xca62c1d6, v12
        v_xor_b32       v20, v20, v15
        v_alignbit_b32  v27, v12, v12, 27
        v_add_i32       v16, vcc, v16, v20
        v_add_i32       v16, vcc, v27, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v20, v23, v36
        v_add_i32       v16, vcc, v16, v20
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v20, v12, v15
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        v_xor_b32       v20, v11, v20
        v_xor_b32       v18, v18, v26
        v_alignbit_b32  v26, v14, v14, 15
        v_add_i32       v17, vcc, v17, v20
        v_alignbit_b32  v20, v16, v16, 27
        v_xor_b32       v18, v18, v26
        ds_read2_b32    v[26:27], v9 offset0:65 offset1:66
        v_add_i32       v17, vcc, v17, v20
        v_xor_b32       v18, v18, v37
        v_xor_b32       v20, v16, v11
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, v17, v18
        v_xor_b32       v18, v20, v12
        v_add_i32       v17, vcc, 0xca62c1d6, v17
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v18, v17, v17, 27
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v12, v17
        v_alignbit_b32  v16, v16, v16, 2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v15, vcc, v15, v26
        v_xor_b32       v18, v18, v16
        ds_read2_b32    v[34:35], v9 offset0:67 offset1:68
        v_alignbit_b32  v20, v15, v15, 27
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v28, v25
        v_add_i32       v11, vcc, v20, v11
        v_xor_b32       v18, v18, v27
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v18, v15, v16
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_xor_b32       v18, v17, v18
        v_alignbit_b32  v20, v14, v14, 14
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v18, v11, v11, 27
        v_xor_b32       v26, v23, v20
        v_add_i32       v12, vcc, v12, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v26, v34
        v_xor_b32       v26, v11, v17
        v_alignbit_b32  v15, v15, v15, 2
        v_add_i32       v12, vcc, v12, v18
        v_xor_b32       v18, v26, v15
        v_add_i32       v12, vcc, 0xca62c1d6, v12
        v_xor_b32       v26, v30, v28
        v_add_i32       v16, vcc, v16, v18
        v_alignbit_b32  v18, v12, v12, 27
        v_xor_b32       v26, v33, v26
        ds_read2_b32    v[36:37], v9 offset0:69 offset1:70
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v26, v35
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v15, v12
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        v_xor_b32       v18, v18, v11
        v_alignbit_b32  v26, v16, v16, 27
        v_add_i32       v17, vcc, v17, v18
        v_add_i32       v17, vcc, v26, v17
        v_alignbit_b32  v12, v12, v12, 2
        v_xor_b32       v18, v16, v11
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v17, vcc, v17, v36
        v_xor_b32       v18, v12, v18
        v_alignbit_b32  v26, v14, v14, 13
        ds_read2_b32    v[34:35], v9 offset0:71 offset1:72
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v18, v17, v17, 27
        v_xor_b32       v26, v24, v26
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v26, v37
        v_xor_b32       v26, v17, v12
        v_alignbit_b32  v16, v16, v16, 2
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v26, v16
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v18, v15, v15, 27
        v_xor_b32       v26, v24, v25
        v_xor_b32       v21, v21, v30
        v_add_i32       v11, vcc, v11, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v26, v34
        v_xor_b32       v21, v24, v21
        v_add_i32       v11, vcc, v11, v18
        v_xor_b32       v18, v16, v15
        v_alignbit_b32  v17, v17, v17, 2
        v_xor_b32       v21, v31, v21
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_xor_b32       v18, v18, v17
        v_xor_b32       v21, v25, v21
        ds_read2_b32    v[26:27], v9 offset0:73 offset1:74
        v_alignbit_b32  v29, v11, v11, 27
        v_add_i32       v12, vcc, v12, v18
        v_xor_b32       v18, v20, v21
        v_add_i32       v12, vcc, v29, v12
        v_xor_b32       v18, v18, v35
        v_add_i32       v12, vcc, v12, v18
        v_alignbit_b32  v15, v15, v15, 2
        v_xor_b32       v18, v11, v17
        v_add_i32       v12, vcc, 0xca62c1d6, v12
        v_xor_b32       v18, v15, v18
        v_add_i32       v16, vcc, v16, v18
        v_alignbit_b32  v18, v12, v12, 27
        v_alignbit_b32  v21, v14, v14, 12
        v_add_i32       v16, vcc, v16, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v21, v26
        v_xor_b32       v26, v12, v15
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v16, vcc, v16, v18
        v_xor_b32       v18, v26, v11
        v_add_i32       v16, vcc, 0xca62c1d6, v16
        ds_read2_b32    v[29:30], v9 offset0:75 offset1:76
        v_add_i32       v17, vcc, v17, v18
        v_alignbit_b32  v18, v16, v16, 27
        v_xor_b32       v26, v23, v25
        v_add_i32       v17, vcc, v17, v18
        v_xor_b32       v18, v26, v27
        v_add_i32       v17, vcc, v17, v18
        v_xor_b32       v18, v11, v16
        v_alignbit_b32  v12, v12, v12, 2
        v_add_i32       v17, vcc, 0xca62c1d6, v17
        v_xor_b32       v18, v18, v12
        v_xor_b32       v22, v22, v24
        v_alignbit_b32  v26, v17, v17, 27
        v_add_i32       v15, vcc, v15, v18
        v_xor_b32       v18, v28, v22
        v_add_i32       v15, vcc, v26, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v18, v29
        v_xor_b32       v19, v19, v23
        v_add_i32       v15, vcc, v15, v18
        v_alignbit_b32  v16, v16, v16, 2
        v_xor_b32       v18, v17, v12
        v_xor_b32       v22, v24, v19
        v_add_i32       v15, vcc, 0xca62c1d6, v15
        v_xor_b32       v18, v16, v18
        v_xor_b32       v22, v25, v22
        v_alignbit_b32  v24, v14, v14, 11
        v_add_i32       v11, vcc, v11, v18
        v_alignbit_b32  v18, v15, v15, 27
        v_xor_b32       v22, v22, v24
        ds_read2_b32    v[24:25], v9 offset0:77 offset1:78
        v_add_i32       v9, vcc, v11, v18
        v_xor_b32       v11, v22, v30
        v_xor_b32       v18, v15, v16
        v_alignbit_b32  v17, v17, v17, 2
        v_add_i32       v9, vcc, v9, v11
        v_xor_b32       v11, v18, v17
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        v_add_i32       v11, vcc, v12, v11
        v_alignbit_b32  v12, v9, v9, 27
        v_add_i32       v11, vcc, v11, v12
        v_alignbit_b32  v12, v15, v15, 2
        v_xor_b32       v15, v17, v9
        v_xor_b32       v18, v33, v19
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v11, vcc, v11, v24
        v_xor_b32       v15, v12, v15
        v_xor_b32       v18, v20, v18
        v_mov_b32       v19, 0
        ds_read_b32     v19, v19 offset:4412
        v_alignbit_b32  v20, v11, v11, 27
        v_add_i32       v15, vcc, v16, v15
        v_xor_b32       v16, v21, v18
        v_add_i32       v15, vcc, v20, v15
        v_xor_b32       v16, v16, v25
        v_xor_b32       v12, v11, v12
        v_alignbit_b32  v9, v9, v9, 2
        v_add_i32       v15, vcc, v15, v16
        v_xor_b32       v9, v12, v9
        v_add_i32       v12, vcc, 0xca62c1d6, v15
        v_alignbit_b32  v14, v14, v14, 10
        v_add_i32       v9, vcc, v17, v9
        v_alignbit_b32  v12, v12, v12, 27
        v_xor_b32       v14, v23, v14
        v_add_i32       v9, vcc, v9, v12
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v12, v14, v19
        v_add_i32       v9, vcc, v9, v12
        v_add_i32       v9, vcc, 0x31a7e4d7, v9
        v_lshrrev_b32   v12, 20, v9
        ds_read_u8      v12, v12
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v12, v12, 0, 8
        v_alignbit_b32  v11, v11, v11, 2
        v_cmp_lg_i32    s[36:37], v12, 0
        v_add_i32       v8, vcc, 0x98badcfe, v11
        v_add_i32       v22, vcc, 0xba306d5f, v15
        s_mov_b64       s[38:39], exec
        s_andn2_b64     exec, s[38:39], s[36:37]
        v_lshrrev_b32   v53, 8, v9
        s_cbranch_execz .L11716_3
        v_add_i32       v16, vcc, s7, v53
        buffer_load_ubyte v16, v16, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v16
        s_and_saveexec_b64 s[36:37], vcc
        v_lshrrev_b32   v16, 2, v9
        s_cbranch_execz .L11696_3
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[40:41], exec
        s_mov_b64       s[42:43], exec
        v_mov_b32       v17, s0
        v_mov_b32       v18, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v11, s5
.L11568_3:
        v_cmp_gt_i32    s[44:45], v18, v17
        v_cmp_eq_i32    vcc, v16, v11
        s_or_b64        vcc, s[44:45], vcc
        s_and_saveexec_b64 s[44:45], vcc
        s_andn2_b64     s[42:43], s[42:43], exec
        s_cbranch_scc0  .L11652_3
        s_mov_b64       exec, s[42:43]
        v_add_i32       v19, vcc, v17, v18
        v_ashrrev_i32   v19, 1, v19
        v_lshlrev_b32   v20, 2, v19
        v_add_i32       v20, vcc, s4, v20
        v_add_i32       v21, vcc, -1, v19
        v_add_i32       v19, vcc, 1, v19
        tbuffer_load_format_x v11, v20, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v11, v16
        v_cndmask_b32   v18, v19, v18, vcc
        v_cndmask_b32   v17, v17, v21, vcc
        s_branch        .L11568_3
.L11652_3:
        s_mov_b64       exec, s[40:41]
        v_cmp_lg_i32    vcc, v16, v11
        s_mov_b64       s[40:41], exec
        s_andn2_b64     exec, s[40:41], vcc
        v_mov_b32       v24, 0
        s_cbranch_execz .L11688_3
        v_mov_b32       v12, 1
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L12060_3
.L11688_3:
        s_and_b64       exec, s[40:41], s[22:23]
        v_mov_b32       v12, 1
.L11696_3:
        s_andn2_b64     exec, s[36:37], exec
        s_and_b64       exec, exec, s[22:23]
        v_mov_b32       v12, 0
        s_cbranch_execz .L11712_3
.L11712_3:
        s_and_b64       exec, s[36:37], s[22:23]
.L11716_3:
        s_andn2_b64     exec, s[38:39], exec
        s_and_b64       exec, exec, s[22:23]
        v_mov_b32       v12, 0
        s_cbranch_execz .L11732_3
.L11732_3:
        s_and_b64       exec, s[38:39], s[22:23]
        v_bfe_u32       v53, v22, 10, 12
        ds_read_u8      v17, v53
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v17, v17, 0, 8
        v_cmp_eq_i32    s[36:37], v17, 0
        s_and_saveexec_b64 s[38:39], s[36:37]
        v_lshlrev_b32   v15, 8, v15
        s_cbranch_execz .L12028_3
        v_lshrrev_b32   v24, 24, v8
        v_add_i32       v15, vcc, 0x306d5f00, v15
        s_mov_b32       s5, 0x3fffff00
        v_bfi_b32       v53, s5, v15, v24
        v_lshrrev_b32   v17, 6, v53
        v_add_i32       v17, vcc, s7, v17
        buffer_load_ubyte v17, v17, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v17
        s_and_saveexec_b64 s[40:41], vcc
        s_cbranch_execz .L12024_3
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[42:43], exec
        s_mov_b64       s[44:45], exec
        v_mov_b32       v14, s0
        v_mov_b32       v17, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v11, s5
        s_nop           0x0
        s_nop           0x0
.L11880_3:
        v_cmp_gt_i32    s[46:47], v17, v14
        v_cmp_eq_i32    vcc, v53, v11
        s_or_b64        vcc, s[46:47], vcc
        s_and_saveexec_b64 s[46:47], vcc
        s_andn2_b64     s[44:45], s[44:45], exec
        s_cbranch_scc0  .L11964_3
        s_mov_b64       exec, s[44:45]
        v_add_i32       v18, vcc, v14, v17
        v_ashrrev_i32   v18, 1, v18
        v_lshlrev_b32   v19, 2, v18
        v_add_i32       v19, vcc, s4, v19
        v_add_i32       v20, vcc, -1, v18
        v_add_i32       v18, vcc, 1, v18
        tbuffer_load_format_x v11, v19, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v11, v53
        v_cndmask_b32   v17, v18, v17, vcc
        v_cndmask_b32   v14, v14, v20, vcc
        s_branch        .L11880_3
.L11964_3:
        s_mov_b64       exec, s[42:43]
        v_cmp_lg_i32    s[42:43], v53, v11
        s_mov_b64       s[44:45], exec
        s_andn2_b64     exec, s[44:45], s[42:43]
        v_cndmask_b32   v53, 0, -1, s[42:43]
        s_cbranch_execz .L12008_3
        v_mov_b32       v12, 2
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L12060_3
.L12008_3:
        s_and_b64       exec, s[44:45], s[22:23]
        v_cndmask_b32   v53, 0, -1, s[42:43]
        v_mov_b32       v12, 2
.L12024_3:
        s_and_b64       exec, s[40:41], s[22:23]
.L12028_3:
        s_andn2_b64     exec, s[38:39], exec
        s_and_b64       exec, exec, s[22:23]
        v_cndmask_b32   v24, 0, -1, s[36:37]
        s_cbranch_execz .L12048_3
.L12048_3:
        s_and_b64       exec, s[38:39], s[22:23]
        v_add_i32       v6, vcc, 1, v6
        s_branch        .L6784_3
.L12060_3:
        s_mov_b64       exec, s[12:13]
        v_cmp_eq_i32    vcc, 0, v12
        s_and_saveexec_b64 s[4:5], vcc
        v_mov_b32       v0, 0x400
        s_cbranch_execz .L12092_3
        tbuffer_store_format_x v0, v5, s[24:27], 0 offen format:[32,float]
.L12092_3:
        s_andn2_b64     exec, s[4:5], exec
        s_cbranch_execz .L12552_3
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_lshrrev_b32   v14, 26, v9
        v_cmp_eq_i32    s[2:3], v12, 1
        v_lshrrev_b32   v12, 8, v9
        v_add_i32       v14, vcc, s1, v14
        v_bfe_u32       v15, v9, 20, 6
        v_cndmask_b32   v11, v12, v53, s[2:3]
        v_add_i32       v12, vcc, s1, v15
        v_bfe_u32       v15, v9, 14, 6
        v_add_i32       v15, vcc, s1, v15
        v_and_b32       v11, 63, v11
        v_add_i32       v11, vcc, s1, v11
        v_bfe_u32       v16, v9, 2, 6
        v_lshrrev_b32   v17, 28, v22
        v_lshlrev_b32   v9, 4, v9
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v14, v14, s[8:11], 0 offen
        v_add_i32       v16, vcc, s1, v16
        v_bfi_b32       v9, 48, v9, v17
        buffer_load_ubyte v12, v12, s[8:11], 0 offen
        v_add_i32       v9, vcc, s1, v9
        v_bfe_u32       v17, v22, 22, 6
        buffer_load_ubyte v15, v15, s[8:11], 0 offen
        v_add_i32       v17, vcc, s1, v17
        v_bfe_u32       v18, v22, 16, 6
        buffer_load_ubyte v11, v11, s[8:11], 0 offen
        v_add_i32       v18, vcc, s1, v18
        v_bfe_u32       v19, v22, 10, 6
        buffer_load_ubyte v16, v16, s[8:11], 0 offen
        v_lshrrev_b32   v20, 24, v8
        v_add_i32       v19, vcc, s1, v19
        v_bfe_u32       v21, v22, 4, 6
        v_lshrrev_b32   v8, 30, v8
        v_lshlrev_b32   v7, 2, v22
        buffer_load_ubyte v9, v9, s[8:11], 0 offen
        v_cndmask_b32   v10, v24, v20, s[2:3]
        v_add_i32       v20, vcc, s1, v21
        v_bfi_b32       v7, 60, v7, v8
        buffer_load_ubyte v8, v17, s[8:11], 0 offen
        v_add_i32       v7, vcc, s1, v7
        v_and_b32       v10, 63, v10
        buffer_load_ubyte v17, v18, s[8:11], 0 offen
        v_add_i32       v10, vcc, s1, v10
        buffer_load_ubyte v18, v19, s[8:11], 0 offen
        buffer_load_ubyte v19, v20, s[8:11], 0 offen
        buffer_load_ubyte v7, v7, s[8:11], 0 offen
        buffer_load_ubyte v10, v10, s[8:11], 0 offen
        buffer_store_byte v4, v5, s[24:27], 0 offen offset:17 glc
        buffer_store_byte v2, v5, s[24:27], 0 offen offset:18 glc
        buffer_store_byte v39, v5, s[24:27], 0 offen offset:19 glc
        buffer_store_byte v38, v5, s[24:27], 0 offen offset:20 glc
        buffer_store_byte v13, v5, s[24:27], 0 offen offset:24 glc
        buffer_store_byte v3, v5, s[24:27], 0 offen offset:28 glc
        buffer_store_byte v14, v5, s[24:27], 0 offen offset:5 glc
        buffer_store_byte v12, v5, s[24:27], 0 offen offset:6 glc
        buffer_store_byte v15, v5, s[24:27], 0 offen offset:7 glc
        buffer_store_byte v11, v5, s[24:27], 0 offen offset:8 glc
        buffer_store_byte v16, v5, s[24:27], 0 offen offset:9 glc
        buffer_store_byte v9, v5, s[24:27], 0 offen offset:10 glc
        buffer_store_byte v8, v5, s[24:27], 0 offen offset:11 glc
        buffer_store_byte v17, v5, s[24:27], 0 offen offset:12 glc
        buffer_store_byte v18, v5, s[24:27], 0 offen offset:13 glc
        v_mov_b32       v0, 1
        buffer_store_byte v19, v5, s[24:27], 0 offen offset:14 glc
        v_add_i32       v1, vcc, 1, v6
        buffer_store_byte v7, v5, s[24:27], 0 offen offset:15 glc
        buffer_store_byte v10, v5, s[24:27], 0 offen offset:16 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:4 glc
        tbuffer_store_format_x v1, v5, s[24:27], 0 offen format:[32,float]
.L12552_3:
        s_endpgm
