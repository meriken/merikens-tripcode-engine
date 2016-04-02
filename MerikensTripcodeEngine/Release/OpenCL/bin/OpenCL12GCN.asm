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
	.config

    .dims x	
	.driver_version 200460

	.arg outputArray,              structure*, 32,  global
	.arg key,                      uchar*,          global, const
	.arg tripcodeChunkArray,       uint*,           global
	.arg numTripcodeChunk,         uint
	.arg keyCharTable_OneByte,         uchar*,          global, const
	.arg keyCharTable_FirstByte,         uchar*,          global, const
	.arg keyCharTable_SecondByte,         uchar*,          global, const
	.arg keyCharTable_SecondByteAndOneByte,         uchar*,          global, const
	.arg smallChunkBitmap,         uchar*,          global, const
	.arg chunkBitmap,              uchar*,          global

	.useconstdata
    .userdata PTR_UAV_TABLE,0,2,2
    .userdata IMM_CONST_BUFFER,0,4,4
    .userdata IMM_CONST_BUFFER,1,8,4
	.localsize 4416

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
        s_buffer_load_dword s15, s[8:11], 0x0
        s_waitcnt       lgkmcnt(0)
        s_min_u32       s1, s1, 0xffff
        s_buffer_load_dword s20, s[8:11], 0x14
        s_buffer_load_dword s21, s[8:11], 0x1c
        s_mul_i32       s1, s12, s1
        s_add_u32       s1, s1, s13
        v_add_i32       v5, vcc, s1, v0
        s_load_dwordx4  s[24:27], s[2:3], 0x60
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x80
        s_add_u32       s1, s12, s14
        v_lshlrev_b32   v5, 5, v5
        v_add_i32       v5, vcc, s15, v5
        v_mov_b32       v6, 0
        s_ashr_i32      s12, s1, 6
        v_and_b32       v7, 63, v0
        s_and_b32       s1, s1, 63
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s12, s12, s21
        s_waitcnt       vmcnt(2)
        v_add_i32       v2, vcc, v2, v7
        s_add_u32       s1, s1, s20
        s_waitcnt       vmcnt(1)
        v_add_i32       v3, vcc, s12, v3
        v_add_i32       v2, vcc, s21, v2
        s_waitcnt       vmcnt(0)
        v_add_i32       v4, vcc, s1, v4
        buffer_load_ubyte v7, v1, s[16:19], 0 offen offset:2
        buffer_load_ubyte v1, v1, s[16:19], 0 offen offset:3
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
        s_cbranch_execz .L4196_0
        s_load_dwordx4  s[12:15], s[2:3], 0x88
        s_movk_i32      s10, 0x0
        s_movk_i32      s11, 0x100
.L268_0:
        s_cmp_gt_u32    s11, 0
        s_cbranch_scc0  .L4196_0
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s22, s6, s10
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s22
        v_mov_b32       v8, s10
        s_add_u32       s22, s10, 1
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 2
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 3
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 4
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 5
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 6
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 7
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 8
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 9
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 10
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 11
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 12
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 13
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 14
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 15
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 16
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 17
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 18
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 19
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 20
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 21
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 22
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 23
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 24
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 25
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 26
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 27
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 28
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 29
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 30
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 31
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 32
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 33
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 34
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 35
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 36
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 37
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 38
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 39
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 40
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 41
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 42
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 43
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 44
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 45
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 46
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 47
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 48
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 49
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 50
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 51
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 52
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 53
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 54
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 55
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 56
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 57
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 58
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 59
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 60
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 61
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 62
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 63
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 64
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x41
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x42
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x43
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x44
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x45
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x46
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x47
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x48
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x49
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x4a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x4b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x4c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x4d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x4e
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x4f
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 0x50
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x51
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x52
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x53
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x54
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x55
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x56
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x57
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x58
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x59
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x5a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x5b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x5c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x5d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x5e
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x5f
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 0x60
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x61
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x62
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x63
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x64
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x65
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x66
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x67
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x68
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x69
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x6a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x6b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x6c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x6d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x6e
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x6f
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 0x70
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x71
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x72
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x73
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x74
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x75
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x76
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x77
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x78
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x79
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x7a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x7b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x7c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x7d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x7e
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x7f
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 0x80
        s_sub_i32       s11, s11, 8
        s_branch        .L268_0
.L4196_0:
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
        ds_read2_b32    v[18:19], v11 offset0:10 offset1:11
        v_xor_b32       v10, v10, v15
        ds_read2_b32    v[20:21], v11 offset0:14 offset1:16
        ds_read2_b32    v[22:23], v11 offset0:12 offset1:13
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v24, v6, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v18, v24
        v_xor_b32       v24, v9, v10
        v_xor_b32       v25, v17, v8
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v19, v19, v24
        v_alignbit_b32  v24, v25, v25, 31
        v_alignbit_b32  v19, v19, v19, 31
        v_xor_b32       v25, v15, v18
        v_xor_b32       v25, 0x60, v25
        v_xor_b32       v26, v14, v24
        v_xor_b32       v27, v17, v19
        ds_write2_b32   v11, v10, v24 offset0:24 offset1:25
        v_xor_b32       v23, v23, v25
        v_xor_b32       v22, v22, v26
        v_xor_b32       v25, v21, v27
        ds_write2_b32   v11, v18, v19 offset0:26 offset1:27
        v_alignbit_b32  v23, v23, v23, 31
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v20, v20, v25
        ds_write2_b32   v11, v22, v23 offset0:28 offset1:29
        v_alignbit_b32  v20, v20, v20, 31
        ds_write_b32    v12, v20 offset:4216
        ds_read2_b32    v[25:26], v11 offset0:17 offset1:18
        v_xor_b32       v16, v16, v22
        v_xor_b32       v8, v8, v16
        v_xor_b32       v8, 0x60, v8
        v_xor_b32       v16, v23, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v27, v24, v20
        ds_read2_b32    v[28:29], v11 offset0:21 offset1:23
        ds_read2_b32    v[30:31], v11 offset0:19 offset1:20
        v_xor_b32       v6, v6, v16
        v_xor_b32       v9, v9, v27
        v_xor_b32       v16, v18, v8
        v_xor_b32       v6, v21, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v25, v9
        v_xor_b32       v14, v14, v16
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v14, v26, v14
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v16, v22, v9
        v_xor_b32       v21, v19, v6
        v_xor_b32       v16, v17, v16
        v_xor_b32       v15, v15, v21
        v_xor_b32       v21, v23, v14
        ds_write2_b32   v11, v8, v6 offset0:31 offset1:32
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v16, v31, v16
        v_xor_b32       v15, v30, v15
        v_xor_b32       v21, v29, v21
        ds_write2_b32   v11, v9, v14 offset0:33 offset1:34
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v21, v28, v21
        ds_write2_b32   v11, v15, v16 offset0:35 offset1:36
        v_alignbit_b32  v21, v21, v21, 31
        ds_write_b32    v12, v21 offset:4244
        ds_read2_b32    v[25:26], v11 offset0:24 offset1:25
        v_xor_b32       v20, v20, v15
        v_xor_b32       v10, v10, v20
        v_xor_b32       v10, v17, v10
        v_xor_b32       v17, v16, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v20, v6, v21
        ds_read2_b32    v[27:28], v11 offset0:28 offset1:30
        ds_read2_b32    v[30:31], v11 offset0:26 offset1:27
        v_xor_b32       v17, v24, v17
        v_xor_b32       v18, v18, v20
        v_xor_b32       v20, v9, v10
        v_xor_b32       v17, v29, v17
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v18, v25, v18
        v_xor_b32       v19, v19, v20
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v19, v26, v19
        v_alignbit_b32  v19, v19, v19, 31
        v_xor_b32       v20, v15, v18
        v_xor_b32       v24, v14, v17
        v_xor_b32       v20, v23, v20
        v_xor_b32       v22, v22, v24
        v_xor_b32       v24, v16, v19
        ds_write2_b32   v11, v10, v17 offset0:38 offset1:39
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v31, v20
        v_xor_b32       v22, v30, v22
        v_xor_b32       v24, v28, v24
        ds_write2_b32   v11, v18, v19 offset0:40 offset1:41
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v24, v27, v24
        ds_write2_b32   v11, v22, v20 offset0:42 offset1:43
        v_alignbit_b32  v24, v24, v24, 31
        ds_write_b32    v12, v24 offset:4272
        ds_read2_b32    v[25:26], v11 offset0:31 offset1:32
        v_xor_b32       v21, v21, v22
        v_xor_b32       v8, v8, v21
        v_xor_b32       v8, v23, v8
        v_xor_b32       v21, v20, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v23, v17, v24
        ds_read2_b32    v[29:30], v11 offset0:35 offset1:37
        ds_read2_b32    v[31:32], v11 offset0:33 offset1:34
        v_xor_b32       v6, v6, v21
        v_xor_b32       v9, v9, v23
        v_xor_b32       v21, v18, v8
        v_xor_b32       v6, v28, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v25, v9
        v_xor_b32       v14, v14, v21
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v14, v26, v14
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v21, v22, v9
        v_xor_b32       v23, v19, v6
        v_xor_b32       v21, v16, v21
        v_xor_b32       v15, v15, v23
        v_xor_b32       v23, v20, v14
        ds_write2_b32   v11, v8, v6 offset0:45 offset1:46
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v21, v32, v21
        v_xor_b32       v15, v31, v15
        v_xor_b32       v23, v30, v23
        ds_write2_b32   v11, v9, v14 offset0:47 offset1:48
        v_alignbit_b32  v21, v21, v21, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v23, v29, v23
        ds_write2_b32   v11, v15, v21 offset0:49 offset1:50
        v_alignbit_b32  v23, v23, v23, 31
        ds_write_b32    v12, v23 offset:4300
        ds_read2_b32    v[25:26], v11 offset0:38 offset1:39
        v_xor_b32       v24, v24, v15
        v_xor_b32       v10, v10, v24
        v_xor_b32       v10, v16, v10
        v_xor_b32       v16, v21, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v24, v6, v23
        ds_read2_b32    v[27:28], v11 offset0:42 offset1:44
        ds_read2_b32    v[31:32], v11 offset0:40 offset1:41
        v_xor_b32       v16, v17, v16
        v_xor_b32       v17, v18, v24
        v_xor_b32       v18, v9, v10
        v_xor_b32       v16, v30, v16
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v17, v25, v17
        v_xor_b32       v18, v19, v18
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v26, v18
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v19, v15, v17
        v_xor_b32       v24, v14, v16
        v_xor_b32       v19, v20, v19
        v_xor_b32       v22, v22, v24
        v_xor_b32       v24, v21, v18
        ds_write2_b32   v11, v10, v16 offset0:52 offset1:53
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v32, v19
        v_xor_b32       v22, v31, v22
        v_xor_b32       v24, v28, v24
        ds_write2_b32   v11, v17, v18 offset0:54 offset1:55
        v_alignbit_b32  v19, v19, v19, 31
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v24, v27, v24
        ds_write2_b32   v11, v22, v19 offset0:56 offset1:57
        v_alignbit_b32  v24, v24, v24, 31
        ds_write_b32    v12, v24 offset:4328
        ds_read2_b32    v[25:26], v11 offset0:45 offset1:46
        v_xor_b32       v23, v23, v22
        v_xor_b32       v8, v8, v23
        v_xor_b32       v8, v20, v8
        v_xor_b32       v20, v19, v10
        v_alignbit_b32  v49, v8, v8, 31
        v_xor_b32       v23, v16, v24
        ds_read2_b32    v[29:30], v11 offset0:49 offset1:51
        ds_read2_b32    v[31:32], v11 offset0:47 offset1:48
        v_xor_b32       v6, v6, v20
        v_xor_b32       v9, v9, v23
        v_xor_b32       v20, v17, v49
        v_xor_b32       v6, v28, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v25, v9
        v_xor_b32       v14, v14, v20
        v_alignbit_b32  v44, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v14, v26, v14
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v20, v22, v9
        v_xor_b32       v23, v18, v44
        v_xor_b32       v20, v21, v20
        v_xor_b32       v15, v15, v23
        v_xor_b32       v23, v19, v14
        ds_write2_b32   v11, v49, v44 offset0:59 offset1:60
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v32, v20
        v_xor_b32       v15, v31, v15
        v_xor_b32       v23, v30, v23
        ds_write2_b32   v11, v9, v14 offset0:61 offset1:62
        v_alignbit_b32  v61, v20, v20, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v23, v29, v23
        ds_write2_b32   v11, v15, v61 offset0:63 offset1:64
        v_alignbit_b32  v45, v23, v23, 31
        ds_write_b32    v12, v45 offset:4356
        ds_read2_b32    v[25:26], v11 offset0:52 offset1:53
        v_xor_b32       v24, v24, v15
        v_xor_b32       v10, v10, v24
        v_xor_b32       v10, v21, v10
        v_xor_b32       v21, v61, v49
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v24, v44, v45
        ds_read2_b32    v[27:28], v11 offset0:56 offset1:58
        ds_read2_b32    v[31:32], v11 offset0:54 offset1:55
        v_xor_b32       v16, v16, v21
        v_xor_b32       v17, v17, v24
        v_xor_b32       v21, v9, v10
        v_xor_b32       v16, v30, v16
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v17, v25, v17
        v_xor_b32       v18, v18, v21
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v26, v18
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v21, v15, v17
        v_xor_b32       v24, v14, v16
        v_xor_b32       v21, v19, v21
        v_xor_b32       v22, v22, v24
        v_xor_b32       v24, v61, v18
        ds_write2_b32   v11, v10, v16 offset0:66 offset1:67
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v21, v32, v21
        v_xor_b32       v22, v31, v22
        v_xor_b32       v24, v28, v24
        ds_write2_b32   v11, v17, v18 offset0:68 offset1:69
        v_alignbit_b32  v21, v21, v21, 31
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v24, v27, v24
        ds_write2_b32   v11, v22, v21 offset0:70 offset1:71
        v_alignbit_b32  v24, v24, v24, 31
        ds_write_b32    v12, v24 offset:4384
        ds_read2_b32    v[25:26], v11 offset0:59 offset1:60
        v_xor_b32       v27, v45, v22
        v_xor_b32       v27, v49, v27
        v_xor_b32       v19, v19, v27
        v_xor_b32       v10, v21, v10
        v_alignbit_b32  v19, v19, v19, 31
        v_xor_b32       v16, v16, v24
        ds_read2_b32    v[29:30], v11 offset0:63 offset1:65
        ds_read2_b32    v[31:32], v11 offset0:61 offset1:62
        v_xor_b32       v10, v44, v10
        v_xor_b32       v9, v9, v16
        v_xor_b32       v16, v17, v19
        v_xor_b32       v10, v28, v10
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v25, v9
        v_xor_b32       v14, v14, v16
        v_alignbit_b32  v10, v10, v10, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v14, v26, v14
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v16, v22, v9
        v_xor_b32       v17, v18, v10
        v_xor_b32       v16, v61, v16
        v_xor_b32       v15, v15, v17
        v_xor_b32       v17, v21, v14
        ds_write2_b32   v11, v19, v10 offset0:73 offset1:74
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v10, v32, v16
        v_xor_b32       v15, v31, v15
        v_xor_b32       v16, v30, v17
        ds_write2_b32   v11, v9, v14 offset0:75 offset1:76
        v_alignbit_b32  v9, v10, v10, 31
        v_alignbit_b32  v62, v15, v15, 31
        v_xor_b32       v14, v29, v16
        ds_write2_b32   v11, v62, v9 offset0:77 offset1:78
        v_alignbit_b32  v9, v14, v14, 31
        ds_write_b32    v12, v9 offset:4412
        ds_read2_b32    v[14:15], v11 offset0:1 offset1:2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x5a827999, v15
        v_add_i32       v14, vcc, 0x5a827999, v14
        ds_write2_b32   v11, v14, v9 offset0:1 offset1:2
        ds_read2_b32    v[14:15], v11 offset0:17 offset1:18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x5a827999, v15
        v_add_i32       v14, vcc, 0x5a827999, v14
        ds_write2_b32   v11, v14, v9 offset0:17 offset1:18
        ds_read2_b32    v[14:15], v11 offset0:20 offset1:21
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v15
        v_add_i32       v14, vcc, 0x6ed9eba1, v14
        ds_write2_b32   v11, v14, v9 offset0:20 offset1:21
        ds_read_b32     v9, v12 offset:4188
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v12, v9 offset:4188
        ds_read2_b32    v[14:15], v11 offset0:26 offset1:27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v15
        v_add_i32       v14, vcc, 0x6ed9eba1, v14
        ds_write2_b32   v11, v14, v9 offset0:26 offset1:27
        ds_read_b32     v9, v12 offset:4212
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v12, v9 offset:4212
        ds_read_b32     v9, v12 offset:4228
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v12, v9 offset:4228
        ds_read_b32     v9, v12 offset:4252
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v12, v9 offset:4252
        ds_read_b32     v9, v12 offset:4260
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x8f1bbcdc, v9
        ds_write_b32    v12, v9 offset:4260
        ds_read_b32     v9, v12 offset:4276
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x8f1bbcdc, v9
        ds_write_b32    v12, v9 offset:4276
        ds_read_b32     v9, v12 offset:4308
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x8f1bbcdc, v9
        ds_write_b32    v12, v9 offset:4308
        ds_read_b32     v9, v12 offset:4356
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v12, v9 offset:4356
        ds_read_b32     v9, v12 offset:4372
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v12, v9 offset:4372
        ds_read_b32     v9, v12 offset:4404
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v12, v9 offset:4404
        v_lshrrev_b32   v0, 2, v0
        v_lshlrev_b32   v9, 24, v4
        v_lshlrev_b32   v12, 16, v2
        v_and_b32       v0, 48, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        ds_read2_b32    v[14:15], v11 offset0:38 offset1:39
        ds_read2_b32    v[16:17], v11 offset0:36 offset1:37
        ds_read2_b32    v[18:19], v11 offset0:34 offset1:35
        ds_read2_b32    v[21:22], v11 offset0:32 offset1:33
        ds_read2_b32    v[24:25], v11 offset0:30 offset1:31
        ds_read2_b32    v[26:27], v11 offset0:28 offset1:29
        ds_read2_b32    v[28:29], v11 offset0:26 offset1:27
        ds_read2_b32    v[30:31], v11 offset0:24 offset1:25
        ds_read2_b32    v[32:33], v11 offset0:22 offset1:23
        ds_read2_b32    v[34:35], v11 offset0:20 offset1:21
        ds_read2_b32    v[36:37], v11 offset0:18 offset1:19
        ds_read2_b32    v[38:39], v11 offset0:16 offset1:17
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[12:15], s[2:3], 0x90
        v_or_b32        v9, v9, v12
        v_add_i32       v0, vcc, v7, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        s_add_u32       s0, -1, s5
        s_mov_b64       s[16:17], exec
        s_mov_b64       s[18:19], exec
        s_movk_i32      s5, 0x0
        v_mov_b32       v6, v40
.L6764_0:
        s_cmp_gt_i32    s5, 0x3ff
        s_cbranch_scc0  .L6800_0
        s_cmp_gt_i32    s5, 0x3ff
        s_cselect_b32   s0, -1, 0
        v_mov_b32       v62, s0
        v_mov_b32       v6, 0
        s_branch        .L11556_0
.L6800_0:
        s_ashr_i32      s6, s5, 6
        s_add_u32       s6, s6, s20
        v_bfe_u32       v6, v0, 0, 8
        v_add_i32       v6, vcc, s6, v6
        s_and_b32       s6, s5, 63
        s_add_u32       s6, s6, s21
        buffer_load_ubyte v62, v6, s[28:31], 0 offen
        v_add_i32       v7, vcc, s6, v1
        buffer_load_ubyte v61, v7, s[32:35], 0 offen
        v_mov_b32       v8, 0x1000
        s_waitcnt       vmcnt(0)
        s_barrier
        ds_read2_b32    v[10:11], v8 offset0:1 offset1:2
        v_lshlrev_b32   v12, 8, v62
        v_or_b32        v12, v9, v12
        v_or_b32        v12, v12, v61
        v_add_i32       v20, vcc, 0x9fb498b3, v12
        v_alignbit_b32  v23, v20, v20, 27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, v23, v10
        v_add_i32       v10, vcc, 0xc2e5374, v10
        v_mov_b32       v23, 0x7bf36ae2
        s_mov_b32       s6, 0x59d148c0
        v_bfi_b32       v23, v20, s6, v23
        v_alignbit_b32  v40, v10, v10, 27
        v_add_i32       v23, vcc, v23, v40
        v_add_i32       v11, vcc, v11, v23
        v_alignbit_b32  v20, v20, v20, 2
        v_add_i32       v11, vcc, 0x98badcfe, v11
        v_bfi_b32       v23, v10, v20, s6
        v_alignbit_b32  v40, v11, v11, 27
        v_add_i32       v23, vcc, v40, v23
        v_add_i32       v23, vcc, 0x7bf36ae2, v23
        v_xor_b32       v23, 0x80000000, v23
        v_add_i32       v23, vcc, 0x5a827999, v23
        v_alignbit_b32  v10, v10, v10, 2
        v_alignbit_b32  v40, v23, v23, 27
        v_bfi_b32       v41, v11, v10, v20
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, 0xb453c259, v40
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v41, v40, v40, 27
        v_bfi_b32       v42, v23, v11, v10
        v_add_i32       v20, vcc, v20, v41
        v_add_i32       v20, vcc, v42, v20
        v_add_i32       v20, vcc, 0x5a827999, v20
        v_alignbit_b32  v23, v23, v23, 2
        v_alignbit_b32  v41, v20, v20, 27
        v_bfi_b32       v42, v40, v23, v11
        v_add_i32       v10, vcc, v10, v41
        v_add_i32       v10, vcc, v42, v10
        v_add_i32       v10, vcc, 0x5a827999, v10
        v_alignbit_b32  v41, v10, v10, 27
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v11, vcc, v11, v41
        v_bfi_b32       v41, v20, v40, v23
        v_add_i32       v11, vcc, v11, v41
        v_add_i32       v11, vcc, 0x5a827999, v11
        v_alignbit_b32  v20, v20, v20, 2
        v_alignbit_b32  v41, v11, v11, 27
        v_bfi_b32       v42, v10, v20, v40
        v_add_i32       v23, vcc, v23, v41
        v_add_i32       v23, vcc, v42, v23
        v_add_i32       v23, vcc, 0x5a827999, v23
        v_alignbit_b32  v10, v10, v10, 2
        v_alignbit_b32  v41, v23, v23, 27
        v_bfi_b32       v42, v11, v10, v20
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, v42, v40
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_alignbit_b32  v41, v40, v40, 27
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v20, vcc, v20, v41
        v_bfi_b32       v41, v23, v11, v10
        v_add_i32       v20, vcc, v20, v41
        v_add_i32       v20, vcc, 0x5a827999, v20
        v_alignbit_b32  v23, v23, v23, 2
        v_alignbit_b32  v41, v20, v20, 27
        v_bfi_b32       v42, v40, v23, v11
        v_add_i32       v10, vcc, v10, v41
        v_add_i32       v10, vcc, v42, v10
        v_add_i32       v10, vcc, 0x5a827999, v10
        v_alignbit_b32  v40, v40, v40, 2
        v_alignbit_b32  v41, v10, v10, 27
        v_bfi_b32       v42, v20, v40, v23
        v_add_i32       v11, vcc, v11, v41
        v_add_i32       v11, vcc, v42, v11
        v_add_i32       v11, vcc, 0x5a827999, v11
        v_alignbit_b32  v41, v11, v11, 27
        v_alignbit_b32  v20, v20, v20, 2
        v_add_i32       v23, vcc, v23, v41
        v_bfi_b32       v41, v10, v20, v40
        v_add_i32       v23, vcc, v23, v41
        v_add_i32       v23, vcc, 0x5a827999, v23
        v_alignbit_b32  v10, v10, v10, 2
        v_alignbit_b32  v41, v23, v23, 27
        v_bfi_b32       v42, v11, v10, v20
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, v42, v40
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_alignbit_b32  v11, v11, v11, 2
        v_alignbit_b32  v41, v40, v40, 27
        v_bfi_b32       v42, v23, v11, v10
        v_add_i32       v20, vcc, v20, v41
        v_add_i32       v20, vcc, v42, v20
        v_alignbit_b32  v41, v12, v12, 31
        v_add_i32       v20, vcc, 0x5a8279f9, v20
        v_xor_b32       v41, v38, v41
        v_alignbit_b32  v42, v20, v20, 27
        v_add_i32       v10, vcc, v10, v41
        v_alignbit_b32  v23, v23, v23, 2
        v_add_i32       v10, vcc, v42, v10
        v_bfi_b32       v41, v40, v23, v11
        v_add_i32       v10, vcc, v10, v41
        v_add_i32       v10, vcc, 0x5a827999, v10
        v_alignbit_b32  v40, v40, v40, 2
        v_alignbit_b32  v41, v10, v10, 27
        v_add_i32       v11, vcc, v39, v11
        v_bfi_b32       v42, v20, v40, v23
        v_add_i32       v11, vcc, v41, v11
        v_add_i32       v11, vcc, v42, v11
        v_alignbit_b32  v20, v20, v20, 2
        v_alignbit_b32  v41, v11, v11, 27
        v_add_i32       v23, vcc, v36, v23
        v_bfi_b32       v42, v10, v20, v40
        v_add_i32       v23, vcc, v41, v23
        v_alignbit_b32  v41, v12, v12, 30
        v_add_i32       v23, vcc, v42, v23
        v_xor_b32       v42, v37, v41
        v_alignbit_b32  v43, v23, v23, 27
        v_add_i32       v40, vcc, v40, v42
        v_alignbit_b32  v10, v10, v10, 2
        v_add_i32       v40, vcc, v43, v40
        v_bfi_b32       v42, v11, v10, v20
        v_add_i32       v40, vcc, v40, v42
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v42, v23, v10
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_xor_b32       v42, v11, v42
        v_add_i32       v20, vcc, v34, v20
        v_xor_b32       v43, v40, v11
        v_alignbit_b32  v23, v23, v23, 2
        v_add_i32       v20, vcc, v42, v20
        v_alignbit_b32  v42, v40, v40, 27
        v_xor_b32       v43, v43, v23
        v_add_i32       v10, vcc, v35, v10
        v_add_i32       v20, vcc, v20, v42
        v_alignbit_b32  v42, v12, v12, 29
        v_add_i32       v10, vcc, v43, v10
        v_alignbit_b32  v43, v20, v20, 27
        v_xor_b32       v44, v23, v20
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v45, v32, v42
        v_add_i32       v10, vcc, v10, v43
        v_xor_b32       v43, v44, v40
        v_add_i32       v11, vcc, v11, v45
        v_alignbit_b32  v44, v10, v10, 27
        v_add_i32       v11, vcc, v43, v11
        v_add_i32       v11, vcc, v44, v11
        v_alignbit_b32  v20, v20, v20, 2
        v_xor_b32       v43, v10, v40
        v_add_i32       v11, vcc, 0x6ed9eba1, v11
        v_xor_b32       v43, v20, v43
        v_add_i32       v23, vcc, v33, v23
        v_xor_b32       v44, v11, v20
        v_alignbit_b32  v10, v10, v10, 2
        v_xor_b32       v45, v30, v41
        v_add_i32       v23, vcc, v43, v23
        v_alignbit_b32  v43, v11, v11, 27
        v_xor_b32       v44, v44, v10
        v_add_i32       v40, vcc, v40, v45
        v_add_i32       v23, vcc, v23, v43
        v_add_i32       v40, vcc, v44, v40
        v_alignbit_b32  v43, v23, v23, 27
        v_alignbit_b32  v44, v12, v12, 28
        v_add_i32       v40, vcc, v40, v43
        v_xor_b32       v43, v10, v23
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v45, v31, v44
        v_add_i32       v40, vcc, 0x6ed9eba1, v40
        v_xor_b32       v43, v43, v11
        v_add_i32       v20, vcc, v20, v45
        v_alignbit_b32  v45, v40, v40, 27
        v_add_i32       v20, vcc, v43, v20
        v_add_i32       v20, vcc, v45, v20
        v_alignbit_b32  v23, v23, v23, 2
        v_xor_b32       v43, v40, v11
        v_add_i32       v20, vcc, 0x6ed9eba1, v20
        v_xor_b32       v43, v23, v43
        v_add_i32       v10, vcc, v28, v10
        v_xor_b32       v45, v20, v23
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v10, vcc, v43, v10
        v_alignbit_b32  v43, v20, v20, 27
        v_xor_b32       v45, v45, v40
        v_add_i32       v11, vcc, v29, v11
        v_add_i32       v10, vcc, v10, v43
        v_alignbit_b32  v43, v12, v12, 27
        v_add_i32       v11, vcc, v45, v11
        v_alignbit_b32  v45, v10, v10, 27
        v_xor_b32       v46, v40, v10
        v_alignbit_b32  v20, v20, v20, 2
        v_xor_b32       v47, v26, v43
        v_add_i32       v11, vcc, v11, v45
        v_xor_b32       v45, v46, v20
        v_add_i32       v23, vcc, v23, v47
        v_alignbit_b32  v46, v11, v11, 27
        v_add_i32       v23, vcc, v45, v23
        v_add_i32       v23, vcc, v46, v23
        v_alignbit_b32  v10, v10, v10, 2
        v_xor_b32       v45, v11, v20
        v_add_i32       v23, vcc, 0x6ed9eba1, v23
        v_xor_b32       v46, v24, v41
        v_xor_b32       v45, v10, v45
        v_add_i32       v40, vcc, v27, v40
        v_xor_b32       v47, v23, v10
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v46, v44, v46
        v_add_i32       v40, vcc, v45, v40
        v_alignbit_b32  v45, v23, v23, 27
        v_xor_b32       v47, v47, v11
        v_add_i32       v20, vcc, v20, v46
        v_add_i32       v40, vcc, v40, v45
        v_add_i32       v20, vcc, v47, v20
        v_alignbit_b32  v45, v40, v40, 27
        v_alignbit_b32  v46, v12, v12, 26
        v_add_i32       v20, vcc, v20, v45
        v_xor_b32       v45, v11, v40
        v_alignbit_b32  v23, v23, v23, 2
        v_xor_b32       v47, v25, v46
        v_add_i32       v20, vcc, 0x6ed9eba1, v20
        v_xor_b32       v45, v45, v23
        v_add_i32       v10, vcc, v10, v47
        v_alignbit_b32  v47, v20, v20, 27
        v_add_i32       v10, vcc, v45, v10
        v_xor_b32       v41, v21, v41
        v_add_i32       v10, vcc, v47, v10
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v45, v20, v23
        v_xor_b32       v41, v42, v41
        v_add_i32       v10, vcc, 0x6ed9eba1, v10
        v_xor_b32       v45, v40, v45
        v_add_i32       v11, vcc, v11, v41
        v_add_i32       v11, vcc, v45, v11
        v_alignbit_b32  v41, v10, v10, 27
        v_xor_b32       v45, v10, v40
        v_alignbit_b32  v20, v20, v20, 2
        v_add_i32       v11, vcc, v11, v41
        v_xor_b32       v41, v45, v20
        v_add_i32       v23, vcc, v22, v23
        v_add_i32       v11, vcc, 0x6ed9eba1, v11
        v_alignbit_b32  v45, v12, v12, 25
        v_add_i32       v23, vcc, v41, v23
        v_alignbit_b32  v41, v11, v11, 27
        v_xor_b32       v47, v20, v11
        v_alignbit_b32  v10, v10, v10, 2
        v_xor_b32       v48, v18, v45
        v_add_i32       v23, vcc, v23, v41
        v_xor_b32       v41, v47, v10
        v_add_i32       v40, vcc, v40, v48
        v_alignbit_b32  v47, v23, v23, 27
        v_add_i32       v40, vcc, v41, v40
        v_add_i32       v40, vcc, v47, v40
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v41, v23, v10
        v_xor_b32       v47, v19, v44
        v_add_i32       v40, vcc, 0x6ed9eba1, v40
        v_xor_b32       v41, v11, v41
        v_add_i32       v20, vcc, v20, v47
        v_xor_b32       v47, v44, v46
        v_add_i32       v20, vcc, v41, v20
        v_alignbit_b32  v41, v40, v40, 27
        v_xor_b32       v48, v40, v11
        v_alignbit_b32  v23, v23, v23, 2
        v_xor_b32       v49, v16, v47
        v_add_i32       v20, vcc, v20, v41
        v_xor_b32       v41, v48, v23
        v_add_i32       v10, vcc, v10, v49
        v_add_i32       v20, vcc, 0x6ed9eba1, v20
        v_add_i32       v10, vcc, v41, v10
        v_alignbit_b32  v41, v20, v20, 27
        v_alignbit_b32  v48, v12, v12, 24
        v_add_i32       v10, vcc, v10, v41
        v_xor_b32       v41, v23, v20
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v49, v17, v48
        v_add_i32       v10, vcc, 0x6ed9eba1, v10
        v_xor_b32       v41, v41, v40
        v_add_i32       v11, vcc, v11, v49
        v_alignbit_b32  v49, v10, v10, 27
        v_add_i32       v11, vcc, v41, v11
        v_add_i32       v11, vcc, v49, v11
        v_alignbit_b32  v20, v20, v20, 2
        v_xor_b32       v41, v10, v40
        v_xor_b32       v49, v14, v44
        v_add_i32       v11, vcc, 0x6ed9eba1, v11
        v_xor_b32       v41, v20, v41
        v_add_i32       v23, vcc, v23, v49
        v_add_i32       v23, vcc, v41, v23
        v_alignbit_b32  v41, v11, v11, 27
        v_xor_b32       v49, v11, v20
        v_alignbit_b32  v10, v10, v10, 2
        v_add_i32       v23, vcc, v23, v41
        ds_read2_b32    v[50:51], v8 offset0:40 offset1:41
        v_xor_b32       v41, v49, v10
        v_add_i32       v40, vcc, v15, v40
        v_add_i32       v23, vcc, 0x6ed9eba1, v23
        v_add_i32       v40, vcc, v41, v40
        v_alignbit_b32  v41, v23, v23, 27
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v11, v11, v11, 2
        v_bfi_b32       v41, v10, v11, v23
        v_bfi_b32       v49, v11, 0, v23
        v_alignbit_b32  v52, v40, v40, 27
        v_alignbit_b32  v53, v12, v12, 23
        v_xor_b32       v41, v41, v49
        v_add_i32       v20, vcc, v20, v52
        v_xor_b32       v49, v44, v53
        v_add_i32       v20, vcc, v41, v20
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v49, v50
        v_add_i32       v20, vcc, v20, v41
        v_alignbit_b32  v23, v23, v23, 2
        v_add_i32       v20, vcc, 0x8f1bbcdc, v20
        v_bfi_b32       v41, v11, v23, v40
        v_bfi_b32       v49, v23, 0, v40
        v_alignbit_b32  v50, v20, v20, 27
        ds_read2_b32    v[52:53], v8 offset0:42 offset1:43
        v_xor_b32       v41, v41, v49
        v_add_i32       v10, vcc, v10, v50
        v_add_i32       v10, vcc, v41, v10
        v_add_i32       v10, vcc, v51, v10
        v_alignbit_b32  v40, v40, v40, 2
        v_bfi_b32       v41, v23, v40, v20
        v_bfi_b32       v49, v40, 0, v20
        v_alignbit_b32  v50, v10, v10, 27
        v_xor_b32       v41, v41, v49
        v_add_i32       v11, vcc, v11, v50
        v_xor_b32       v49, v46, v48
        v_add_i32       v11, vcc, v41, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v52, v49
        v_add_i32       v11, vcc, v11, v41
        v_alignbit_b32  v20, v20, v20, 2
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_bfi_b32       v41, v40, v20, v10
        v_bfi_b32       v49, v20, 0, v10
        v_alignbit_b32  v50, v11, v11, 27
        v_xor_b32       v41, v41, v49
        v_add_i32       v23, vcc, v23, v50
        v_alignbit_b32  v49, v12, v12, 22
        ds_read2_b32    v[50:51], v8 offset0:44 offset1:45
        v_add_i32       v23, vcc, v41, v23
        v_xor_b32       v41, v53, v49
        v_add_i32       v23, vcc, v23, v41
        v_add_i32       v23, vcc, 0x8f1bbcdc, v23
        v_alignbit_b32  v10, v10, v10, 2
        v_bfi_b32       v41, v20, v10, v11
        v_bfi_b32       v52, v10, 0, v11
        v_alignbit_b32  v53, v23, v23, 27
        v_xor_b32       v54, v42, v46
        v_xor_b32       v41, v41, v52
        v_add_i32       v40, vcc, v40, v53
        v_xor_b32       v52, v45, v54
        v_add_i32       v40, vcc, v41, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v52, v50
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_bfi_b32       v41, v10, v11, v23
        v_bfi_b32       v50, v11, 0, v23
        v_alignbit_b32  v52, v40, v40, 27
        ds_read2_b32    v[53:54], v8 offset0:46 offset1:47
        v_xor_b32       v41, v41, v50
        v_add_i32       v20, vcc, v20, v52
        v_add_i32       v20, vcc, v41, v20
        v_add_i32       v20, vcc, v51, v20
        v_alignbit_b32  v23, v23, v23, 2
        v_bfi_b32       v41, v11, v23, v40
        v_bfi_b32       v50, v23, 0, v40
        v_alignbit_b32  v51, v20, v20, 27
        v_alignbit_b32  v52, v12, v12, 21
        v_xor_b32       v41, v41, v50
        v_add_i32       v10, vcc, v10, v51
        v_xor_b32       v50, v44, v52
        v_add_i32       v10, vcc, v41, v10
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v53, v50
        v_add_i32       v10, vcc, v10, v41
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v10, vcc, 0x8f1bbcdc, v10
        v_bfi_b32       v41, v23, v40, v20
        v_bfi_b32       v50, v40, 0, v20
        v_alignbit_b32  v51, v10, v10, 27
        v_xor_b32       v41, v41, v50
        v_add_i32       v11, vcc, v11, v51
        v_xor_b32       v50, v44, v48
        ds_read2_b32    v[55:56], v8 offset0:48 offset1:49
        v_add_i32       v11, vcc, v41, v11
        v_xor_b32       v41, v54, v50
        v_add_i32       v11, vcc, v11, v41
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_alignbit_b32  v20, v20, v20, 2
        v_xor_b32       v41, v42, v43
        v_bfi_b32       v42, v40, v20, v10
        v_bfi_b32       v51, v20, 0, v10
        v_alignbit_b32  v53, v11, v11, 27
        v_xor_b32       v41, v50, v41
        v_xor_b32       v42, v42, v51
        v_add_i32       v23, vcc, v23, v53
        v_xor_b32       v41, v49, v41
        v_add_i32       v23, vcc, v42, v23
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v55
        v_add_i32       v23, vcc, v23, v41
        v_alignbit_b32  v10, v10, v10, 2
        v_add_i32       v23, vcc, 0x8f1bbcdc, v23
        v_bfi_b32       v41, v20, v10, v11
        v_bfi_b32       v42, v10, 0, v11
        v_alignbit_b32  v51, v23, v23, 27
        v_xor_b32       v41, v41, v42
        v_add_i32       v40, vcc, v40, v51
        v_alignbit_b32  v42, v12, v12, 20
        ds_read2_b32    v[53:54], v8 offset0:50 offset1:51
        v_add_i32       v40, vcc, v41, v40
        v_xor_b32       v41, v56, v42
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_alignbit_b32  v11, v11, v11, 2
        v_bfi_b32       v41, v10, v11, v23
        v_bfi_b32       v51, v11, 0, v23
        v_alignbit_b32  v55, v40, v40, 27
        v_xor_b32       v41, v41, v51
        v_add_i32       v20, vcc, v20, v55
        v_add_i32       v20, vcc, v41, v20
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v48, v53
        v_add_i32       v20, vcc, v20, v41
        v_alignbit_b32  v23, v23, v23, 2
        v_add_i32       v20, vcc, 0x8f1bbcdc, v20
        v_bfi_b32       v41, v11, v23, v40
        v_bfi_b32       v51, v23, 0, v40
        v_alignbit_b32  v53, v20, v20, 27
        v_xor_b32       v41, v41, v51
        v_add_i32       v10, vcc, v10, v53
        ds_read2_b32    v[55:56], v8 offset0:52 offset1:53
        v_add_i32       v10, vcc, v41, v10
        v_xor_b32       v41, v47, v54
        v_add_i32       v10, vcc, v10, v41
        v_add_i32       v10, vcc, 0x8f1bbcdc, v10
        v_alignbit_b32  v40, v40, v40, 2
        v_bfi_b32       v41, v23, v40, v20
        v_bfi_b32       v51, v40, 0, v20
        v_alignbit_b32  v53, v10, v10, 27
        v_alignbit_b32  v54, v12, v12, 19
        v_xor_b32       v41, v41, v51
        v_add_i32       v11, vcc, v11, v53
        v_xor_b32       v51, v50, v54
        v_add_i32       v11, vcc, v41, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v51, v55
        v_add_i32       v11, vcc, v11, v41
        v_alignbit_b32  v20, v20, v20, 2
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_bfi_b32       v41, v40, v20, v10
        v_bfi_b32       v51, v20, 0, v10
        v_alignbit_b32  v53, v11, v11, 27
        ds_read2_b32    v[57:58], v8 offset0:54 offset1:55
        v_xor_b32       v41, v41, v51
        v_add_i32       v23, vcc, v23, v53
        v_add_i32       v23, vcc, v41, v23
        v_add_i32       v23, vcc, v56, v23
        v_alignbit_b32  v10, v10, v10, 2
        v_bfi_b32       v41, v20, v10, v11
        v_bfi_b32       v51, v10, 0, v11
        v_alignbit_b32  v53, v23, v23, 27
        v_xor_b32       v55, v45, v49
        v_xor_b32       v41, v41, v51
        v_add_i32       v40, vcc, v40, v53
        v_xor_b32       v51, v42, v55
        v_add_i32       v40, vcc, v41, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v51, v57
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_bfi_b32       v41, v10, v11, v23
        v_bfi_b32       v51, v11, 0, v23
        v_alignbit_b32  v53, v40, v40, 27
        v_xor_b32       v41, v41, v51
        v_add_i32       v20, vcc, v20, v53
        v_alignbit_b32  v51, v12, v12, 18
        ds_read2_b32    v[55:56], v8 offset0:56 offset1:57
        v_add_i32       v20, vcc, v41, v20
        v_xor_b32       v41, v51, v58
        v_add_i32       v20, vcc, v20, v41
        v_add_i32       v20, vcc, 0x8f1bbcdc, v20
        v_alignbit_b32  v23, v23, v23, 2
        v_xor_b32       v41, v45, v47
        v_bfi_b32       v53, v11, v23, v40
        v_bfi_b32       v57, v23, 0, v40
        v_alignbit_b32  v58, v20, v20, 27
        v_xor_b32       v49, v49, v41
        v_xor_b32       v53, v53, v57
        v_add_i32       v10, vcc, v10, v58
        v_xor_b32       v49, v52, v49
        v_add_i32       v10, vcc, v53, v10
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v49, v49, v55
        v_add_i32       v10, vcc, v10, v49
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v10, vcc, 0x8f1bbcdc, v10
        v_bfi_b32       v49, v23, v40, v20
        v_bfi_b32       v53, v40, 0, v20
        v_alignbit_b32  v55, v10, v10, 27
        v_xor_b32       v49, v49, v53
        v_add_i32       v11, vcc, v11, v55
        ds_read2_b32    v[57:58], v8 offset0:58 offset1:59
        v_add_i32       v11, vcc, v49, v11
        v_xor_b32       v49, v48, v56
        v_add_i32       v11, vcc, v11, v49
        v_add_i32       v11, vcc, 0x8f1bbcdc, v11
        v_alignbit_b32  v20, v20, v20, 2
        v_bfi_b32       v49, v40, v20, v10
        v_bfi_b32       v53, v20, 0, v10
        v_alignbit_b32  v55, v11, v11, 27
        v_alignbit_b32  v56, v12, v12, 17
        v_xor_b32       v49, v49, v53
        v_add_i32       v23, vcc, v23, v55
        v_xor_b32       v50, v50, v56
        v_add_i32       v23, vcc, v49, v23
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v49, v50, v57
        v_add_i32       v23, vcc, v23, v49
        v_alignbit_b32  v10, v10, v10, 2
        v_add_i32       v23, vcc, 0x8f1bbcdc, v23
        v_bfi_b32       v49, v20, v10, v11
        v_bfi_b32       v50, v10, 0, v11
        v_alignbit_b32  v53, v23, v23, 27
        ds_read2_b32    v[59:60], v8 offset0:60 offset1:61
        v_xor_b32       v49, v49, v50
        v_add_i32       v40, vcc, v40, v53
        v_xor_b32       v50, v48, v42
        v_add_i32       v40, vcc, v49, v40
        v_xor_b32       v49, v50, v58
        v_add_i32       v40, vcc, v40, v49
        v_xor_b32       v49, v10, v23
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v44, v44, v45
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_xor_b32       v49, v49, v11
        v_xor_b32       v44, v50, v44
        v_alignbit_b32  v53, v40, v40, 27
        v_add_i32       v20, vcc, v20, v49
        v_xor_b32       v44, v51, v44
        v_add_i32       v20, vcc, v53, v20
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v44, v44, v59
        v_add_i32       v20, vcc, v20, v44
        v_alignbit_b32  v23, v23, v23, 2
        v_xor_b32       v44, v40, v11
        v_add_i32       v20, vcc, 0xca62c1d6, v20
        v_xor_b32       v44, v23, v44
        ds_read2_b32    v[57:58], v8 offset0:62 offset1:63
        v_add_i32       v10, vcc, v10, v44
        v_alignbit_b32  v44, v20, v20, 27
        v_alignbit_b32  v49, v12, v12, 16
        v_add_i32       v10, vcc, v10, v44
        v_xor_b32       v44, v49, v60
        v_xor_b32       v53, v20, v23
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v10, vcc, v10, v44
        v_xor_b32       v44, v53, v40
        v_add_i32       v10, vcc, 0xca62c1d6, v10
        v_add_i32       v11, vcc, v11, v44
        v_alignbit_b32  v44, v10, v10, 27
        v_xor_b32       v47, v47, v50
        v_add_i32       v11, vcc, v11, v44
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v44, v47, v57
        v_add_i32       v11, vcc, v11, v44
        v_xor_b32       v44, v40, v10
        v_alignbit_b32  v20, v20, v20, 2
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_xor_b32       v44, v44, v20
        ds_read2_b32    v[59:60], v8 offset0:64 offset1:65
        v_alignbit_b32  v47, v11, v11, 27
        v_add_i32       v23, vcc, v23, v44
        v_add_i32       v23, vcc, v47, v23
        v_xor_b32       v44, v48, v58
        v_add_i32       v23, vcc, v23, v44
        v_alignbit_b32  v10, v10, v10, 2
        v_xor_b32       v44, v11, v20
        v_add_i32       v23, vcc, 0xca62c1d6, v23
        v_xor_b32       v44, v10, v44
        v_xor_b32       v41, v41, v50
        v_alignbit_b32  v47, v12, v12, 15
        v_add_i32       v40, vcc, v40, v44
        v_alignbit_b32  v44, v23, v23, 27
        v_xor_b32       v41, v41, v47
        v_add_i32       v40, vcc, v40, v44
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v59
        v_xor_b32       v44, v23, v10
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v40, vcc, v40, v41
        ds_read2_b32    v[57:58], v8 offset0:66 offset1:67
        v_xor_b32       v41, v44, v11
        v_add_i32       v40, vcc, 0xca62c1d6, v40
        v_add_i32       v20, vcc, v20, v41
        v_alignbit_b32  v41, v40, v40, 27
        v_add_i32       v20, vcc, v20, v41
        v_xor_b32       v41, v11, v40
        v_alignbit_b32  v23, v23, v23, 2
        v_add_i32       v20, vcc, v20, v60
        v_xor_b32       v41, v41, v23
        v_alignbit_b32  v44, v20, v20, 27
        v_add_i32       v10, vcc, v10, v41
        v_xor_b32       v41, v51, v49
        v_add_i32       v10, vcc, v44, v10
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v57
        v_add_i32       v10, vcc, v10, v41
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v41, v20, v23
        v_add_i32       v10, vcc, 0xca62c1d6, v10
        v_xor_b32       v41, v40, v41
        v_alignbit_b32  v44, v12, v12, 14
        ds_read2_b32    v[59:60], v8 offset0:68 offset1:69
        v_add_i32       v11, vcc, v11, v41
        v_alignbit_b32  v41, v10, v10, 27
        v_xor_b32       v47, v48, v44
        v_add_i32       v11, vcc, v11, v41
        v_xor_b32       v41, v47, v58
        v_xor_b32       v47, v10, v40
        v_alignbit_b32  v20, v20, v20, 2
        v_add_i32       v11, vcc, v11, v41
        v_xor_b32       v41, v47, v20
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_xor_b32       v47, v52, v51
        v_add_i32       v23, vcc, v23, v41
        v_alignbit_b32  v41, v11, v11, 27
        v_xor_b32       v47, v56, v47
        v_add_i32       v23, vcc, v23, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v47, v59
        v_add_i32       v23, vcc, v23, v41
        v_xor_b32       v41, v20, v11
        v_alignbit_b32  v10, v10, v10, 2
        ds_read2_b32    v[57:58], v8 offset0:70 offset1:71
        v_add_i32       v23, vcc, 0xca62c1d6, v23
        v_xor_b32       v41, v41, v10
        v_alignbit_b32  v47, v23, v23, 27
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, v47, v40
        v_alignbit_b32  v11, v11, v11, 2
        v_xor_b32       v41, v23, v10
        v_add_i32       v40, vcc, v40, v60
        v_xor_b32       v41, v11, v41
        v_alignbit_b32  v47, v12, v12, 13
        v_add_i32       v20, vcc, v20, v41
        v_alignbit_b32  v41, v40, v40, 27
        v_xor_b32       v47, v42, v47
        v_add_i32       v20, vcc, v20, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v47, v57
        v_xor_b32       v47, v40, v11
        v_alignbit_b32  v23, v23, v23, 2
        v_add_i32       v20, vcc, v20, v41
        v_xor_b32       v41, v47, v23
        v_add_i32       v20, vcc, 0xca62c1d6, v20
        ds_read2_b32    v[59:60], v8 offset0:72 offset1:73
        v_add_i32       v10, vcc, v10, v41
        v_alignbit_b32  v41, v20, v20, 27
        v_xor_b32       v47, v42, v49
        v_xor_b32       v43, v43, v52
        v_add_i32       v10, vcc, v10, v41
        v_xor_b32       v41, v47, v58
        v_xor_b32       v43, v42, v43
        v_add_i32       v10, vcc, v10, v41
        v_xor_b32       v41, v23, v20
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v43, v54, v43
        v_add_i32       v10, vcc, 0xca62c1d6, v10
        v_xor_b32       v41, v41, v40
        v_xor_b32       v43, v49, v43
        v_alignbit_b32  v47, v10, v10, 27
        v_add_i32       v11, vcc, v11, v41
        v_xor_b32       v41, v44, v43
        v_add_i32       v11, vcc, v47, v11
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v59
        v_add_i32       v11, vcc, v11, v41
        v_alignbit_b32  v20, v20, v20, 2
        v_xor_b32       v41, v10, v40
        v_add_i32       v11, vcc, 0xca62c1d6, v11
        v_xor_b32       v41, v20, v41
        ds_read2_b32    v[52:53], v8 offset0:74 offset1:75
        v_add_i32       v23, vcc, v23, v41
        v_alignbit_b32  v41, v11, v11, 27
        v_alignbit_b32  v43, v12, v12, 12
        v_add_i32       v23, vcc, v23, v41
        v_xor_b32       v41, v43, v60
        v_xor_b32       v47, v11, v20
        v_alignbit_b32  v10, v10, v10, 2
        v_add_i32       v23, vcc, v23, v41
        v_xor_b32       v41, v47, v10
        v_add_i32       v23, vcc, 0xca62c1d6, v23
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v41, v23, v23, 27
        v_xor_b32       v47, v48, v49
        v_add_i32       v40, vcc, v40, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v47, v52
        v_add_i32       v40, vcc, v40, v41
        v_xor_b32       v41, v10, v23
        v_alignbit_b32  v11, v11, v11, 2
        v_add_i32       v40, vcc, 0xca62c1d6, v40
        v_xor_b32       v41, v41, v11
        v_xor_b32       v46, v46, v42
        ds_read2_b32    v[54:55], v8 offset0:76 offset1:77
        v_alignbit_b32  v47, v40, v40, 27
        v_add_i32       v20, vcc, v20, v41
        v_xor_b32       v41, v51, v46
        v_add_i32       v20, vcc, v47, v20
        v_xor_b32       v41, v41, v53
        v_xor_b32       v45, v45, v48
        v_add_i32       v20, vcc, v20, v41
        v_alignbit_b32  v23, v23, v23, 2
        v_xor_b32       v41, v40, v11
        v_xor_b32       v42, v42, v45
        v_add_i32       v20, vcc, 0xca62c1d6, v20
        v_xor_b32       v41, v23, v41
        v_xor_b32       v42, v49, v42
        v_alignbit_b32  v46, v12, v12, 11
        v_add_i32       v10, vcc, v10, v41
        v_alignbit_b32  v41, v20, v20, 27
        v_xor_b32       v42, v42, v46
        v_add_i32       v10, vcc, v10, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v42, v54
        v_xor_b32       v42, v20, v23
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v10, vcc, v10, v41
        ds_read2_b32    v[46:47], v8 offset0:78 offset1:79
        v_xor_b32       v8, v42, v40
        v_add_i32       v10, vcc, 0xca62c1d6, v10
        v_add_i32       v8, vcc, v11, v8
        v_alignbit_b32  v11, v10, v10, 27
        v_add_i32       v8, vcc, v8, v11
        v_alignbit_b32  v11, v20, v20, 2
        v_xor_b32       v20, v40, v10
        v_xor_b32       v41, v56, v45
        v_add_i32       v49, vcc, v8, v55
        v_xor_b32       v20, v11, v20
        v_xor_b32       v41, v44, v41
        v_alignbit_b32  v42, v49, v49, 27
        v_add_i32       v20, vcc, v23, v20
        v_xor_b32       v23, v43, v41
        v_add_i32       v20, vcc, v42, v20
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v23, v23, v46
        v_xor_b32       v11, v49, v11
        v_alignbit_b32  v10, v10, v10, 2
        v_add_i32       v20, vcc, v20, v23
        v_xor_b32       v10, v11, v10
        v_add_i32       v11, vcc, 0xca62c1d6, v20
        v_alignbit_b32  v12, v12, v12, 10
        v_add_i32       v10, vcc, v40, v10
        v_alignbit_b32  v11, v11, v11, 27
        v_xor_b32       v12, v48, v12
        v_add_i32       v10, vcc, v10, v11
        v_xor_b32       v11, v12, v47
        v_add_i32       v10, vcc, v10, v11
        v_add_i32       v45, vcc, 0x31a7e4d7, v10
        v_lshrrev_b32   v11, 20, v45
        ds_read_u8      v11, v11
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v11, v11, 0, 8
        v_cmp_lg_i32    s[22:23], v11, 0
        s_mov_b64       s[36:37], exec
        s_andn2_b64     exec, s[36:37], s[22:23]
        v_lshrrev_b32   v11, 8, v45
        s_cbranch_execz .L11520_0
        v_add_i32       v11, vcc, s7, v11
        buffer_load_ubyte v11, v11, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[38:39], v11, 0
        s_and_saveexec_b64 s[40:41], s[38:39]
        v_lshrrev_b32   v11, 2, v45
        s_cbranch_execz .L11492_0
        v_alignbit_b32  v8, v49, v49, 2
        v_add_i32       v44, vcc, 0x98badcfe, v8
        v_add_i32       v49, vcc, 0xba306d5f, v20
        s_buffer_load_dword s6, s[8:11], s4
        s_mov_b64       s[42:43], exec
        s_mov_b64       s[44:45], exec
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v7, s6
        v_mov_b32       v23, 0
        v_mov_b32       v40, s0
        s_movk_i32      s46, 0x0
        s_movk_i32      s47, 0x0
        s_nop           0x0
.L11368_0:
        v_cmp_gt_i32    s[48:49], v23, v40
        v_cmp_eq_i32    vcc, v11, v7
        s_andn2_b64     s[46:47], s[46:47], exec
        s_or_b64        s[46:47], vcc, s[46:47]
        s_or_b64        vcc, s[48:49], vcc
        s_and_saveexec_b64 s[48:49], vcc
        s_andn2_b64     s[44:45], s[44:45], exec
        s_cbranch_scc0  .L11460_0
        s_and_b64       exec, s[48:49], s[44:45]
        v_add_i32       v20, vcc, v23, v40
        v_ashrrev_i32   v20, 1, v20
        v_lshlrev_b32   v41, 2, v20
        v_add_i32       v41, vcc, s4, v41
        v_add_i32       v42, vcc, -1, v20
        v_add_i32       v20, vcc, 1, v20
        tbuffer_load_format_x v7, v41, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v7, v11
        v_cndmask_b32   v40, v40, v42, vcc
        v_cndmask_b32   v23, v20, v23, vcc
        s_branch        .L11368_0
.L11460_0:
        s_mov_b64       exec, s[42:43]
        s_and_saveexec_b64 s[42:43], s[46:47]
        v_mov_b32       v6, 1
        s_cbranch_execz .L11484_0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L11556_0
.L11484_0:
        s_and_b64       exec, s[42:43], s[18:19]
        v_mov_b32       v6, 1
.L11492_0:
        s_andn2_b64     exec, s[40:41], exec
        s_and_b64       exec, exec, s[18:19]
        v_cndmask_b32   v44, 0, -1, s[38:39]
        s_cbranch_execz .L11516_0
        v_mov_b32       v6, 0
.L11516_0:
        s_and_b64       exec, s[40:41], s[18:19]
.L11520_0:
        s_andn2_b64     exec, s[36:37], exec
        s_and_b64       exec, exec, s[18:19]
        v_cndmask_b32   v44, 0, -1, s[22:23]
        s_cbranch_execz .L11544_0
        v_mov_b32       v6, 0
.L11544_0:
        s_and_b64       exec, s[36:37], s[18:19]
        s_add_u32       s5, s5, 1
        s_branch        .L6764_0
.L11556_0:
        s_mov_b64       exec, s[16:17]
        v_cmp_eq_i32    vcc, 0, v6
        s_and_saveexec_b64 s[6:7], vcc
        v_mov_b32       v0, 0x400
        s_cbranch_execz .L11588_0
        tbuffer_store_format_x v0, v5, s[24:27], 0 offen format:[32,float]
.L11588_0:
        s_andn2_b64     exec, s[6:7], exec
        s_cbranch_execz .L12068_0
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_lshrrev_b32   v9, 26, v45
        v_add_i32       v9, vcc, s1, v9
        v_bfe_u32       v10, v45, 20, 6
        v_add_i32       v10, vcc, s1, v10
        v_bfe_u32       v11, v45, 14, 6
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v9, v9, s[8:11], 0 offen
        v_add_i32       v11, vcc, s1, v11
        v_bfe_u32       v12, v45, 8, 6
        buffer_load_ubyte v10, v10, s[8:11], 0 offen
        v_add_i32       v12, vcc, s1, v12
        v_bfe_u32       v14, v45, 2, 6
        v_lshrrev_b32   v15, 28, v49
        v_lshlrev_b32   v7, 4, v45
        buffer_load_ubyte v11, v11, s[8:11], 0 offen
        v_add_i32       v14, vcc, s1, v14
        v_bfi_b32       v7, 48, v7, v15
        buffer_load_ubyte v12, v12, s[8:11], 0 offen
        v_add_i32       v7, vcc, s1, v7
        v_bfe_u32       v15, v49, 22, 6
        buffer_load_ubyte v14, v14, s[8:11], 0 offen
        v_add_i32       v15, vcc, s1, v15
        v_bfe_u32       v16, v49, 16, 6
        buffer_load_ubyte v7, v7, s[8:11], 0 offen
        v_add_i32       v16, vcc, s1, v16
        v_bfe_u32       v17, v49, 10, 6
        buffer_load_ubyte v15, v15, s[8:11], 0 offen
        v_add_i32       v17, vcc, s1, v17
        v_bfe_u32       v18, v49, 4, 6
        v_lshrrev_b32   v19, 30, v44
        v_lshlrev_b32   v6, 2, v49
        buffer_load_ubyte v16, v16, s[8:11], 0 offen
        v_add_i32       v18, vcc, s1, v18
        v_bfi_b32       v6, 60, v6, v19
        buffer_load_ubyte v17, v17, s[8:11], 0 offen
        v_add_i32       v6, vcc, s1, v6
        v_bfe_u32       v1, v44, 24, 6
        buffer_load_ubyte v18, v18, s[8:11], 0 offen
        v_add_i32       v1, vcc, s1, v1
        buffer_load_ubyte v6, v6, s[8:11], 0 offen
        buffer_load_ubyte v1, v1, s[8:11], 0 offen
        v_bfe_u32       v4, v4, 0, 8
        v_bfe_u32       v8, v62, 0, 8
        v_bfe_u32       v0, v61, 0, 8
        v_bfe_u32       v13, v13, 0, 8
        buffer_store_byte v4, v5, s[24:27], 0 offen offset:17 glc
        v_bfe_u32       v3, v3, 0, 8
        buffer_store_byte v2, v5, s[24:27], 0 offen offset:18 glc
        buffer_store_byte v8, v5, s[24:27], 0 offen offset:19 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:20 glc
        buffer_store_byte v13, v5, s[24:27], 0 offen offset:24 glc
        buffer_store_byte v3, v5, s[24:27], 0 offen offset:28 glc
        buffer_store_byte v9, v5, s[24:27], 0 offen offset:5 glc
        buffer_store_byte v10, v5, s[24:27], 0 offen offset:6 glc
        buffer_store_byte v11, v5, s[24:27], 0 offen offset:7 glc
        buffer_store_byte v12, v5, s[24:27], 0 offen offset:8 glc
        buffer_store_byte v14, v5, s[24:27], 0 offen offset:9 glc
        buffer_store_byte v7, v5, s[24:27], 0 offen offset:10 glc
        buffer_store_byte v15, v5, s[24:27], 0 offen offset:11 glc
        buffer_store_byte v16, v5, s[24:27], 0 offen offset:12 glc
        buffer_store_byte v17, v5, s[24:27], 0 offen offset:13 glc
        v_mov_b32       v0, 1
        s_add_u32       s0, s5, 1
        buffer_store_byte v18, v5, s[24:27], 0 offen offset:14 glc
        v_mov_b32       v2, s0
        buffer_store_byte v6, v5, s[24:27], 0 offen offset:15 glc
        buffer_store_byte v1, v5, s[24:27], 0 offen offset:16 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:4 glc
        tbuffer_store_format_x v2, v5, s[24:27], 0 offen format:[32,float]
.L12068_0:
        s_endpgm



.kernel OpenCL_SHA1_PerformSearching_BackwardMatching
	.config

    .dims x	
	.driver_version 200460

	.arg outputArray,              structure*, 32,  global
	.arg key,                      uchar*,          global, const
	.arg tripcodeChunkArray,       uint*,           global
	.arg numTripcodeChunk,         uint
	.arg keyCharTable_OneByte,         uchar*,          global, const
	.arg keyCharTable_FirstByte,         uchar*,          global, const
	.arg keyCharTable_SecondByte,         uchar*,          global, const
	.arg keyCharTable_SecondByteAndOneByte,         uchar*,          global, const
	.arg smallChunkBitmap,         uchar*,          global, const
	.arg chunkBitmap,              uchar*,          global

	.useconstdata
    .userdata PTR_UAV_TABLE,0,2,2
    .userdata IMM_CONST_BUFFER,0,4,4
    .userdata IMM_CONST_BUFFER,1,8,4
	.localsize 4416

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
        s_buffer_load_dword s15, s[8:11], 0x0
        s_waitcnt       lgkmcnt(0)
        s_min_u32       s1, s1, 0xffff
        s_buffer_load_dword s20, s[8:11], 0x14
        s_buffer_load_dword s21, s[8:11], 0x1c
        s_mul_i32       s1, s12, s1
        s_add_u32       s1, s1, s13
        v_add_i32       v5, vcc, s1, v0
        s_load_dwordx4  s[24:27], s[2:3], 0x60
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x80
        s_add_u32       s1, s12, s14
        v_lshlrev_b32   v5, 5, v5
        v_add_i32       v5, vcc, s15, v5
        v_mov_b32       v6, 0
        s_ashr_i32      s12, s1, 6
        v_and_b32       v7, 63, v0
        s_and_b32       s1, s1, 63
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s12, s12, s21
        s_waitcnt       vmcnt(2)
        v_add_i32       v2, vcc, v2, v7
        s_add_u32       s1, s1, s20
        s_waitcnt       vmcnt(1)
        v_add_i32       v3, vcc, s12, v3
        v_add_i32       v2, vcc, s21, v2
        s_waitcnt       vmcnt(0)
        v_add_i32       v4, vcc, s1, v4
        buffer_load_ubyte v7, v1, s[16:19], 0 offen offset:2
        buffer_load_ubyte v1, v1, s[16:19], 0 offen offset:3
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
        s_cbranch_execz .L4404_1
        s_load_dwordx4  s[12:15], s[2:3], 0x88
        s_movk_i32      s10, 0x0
        s_movk_i32      s11, 0x100
.L268_1:
        s_cmp_gt_u32    s11, 0
        s_cbranch_scc0  .L4404_1
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s22, s6, s10
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s22
        s_add_u32       s22, s10, 0x140
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x141
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x142
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x143
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x144
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x145
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x146
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        s_add_u32       s22, s10, 0x147
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x148
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x149
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x14a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x14b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x14c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x14d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x14e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:15
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
        s_add_u32       s22, s10, 0x14f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x150
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x151
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x152
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x153
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x154
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x155
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x156
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:16
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:17
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:18
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:19
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:20
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:21
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:22
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:23
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
        s_add_u32       s22, s10, 0x157
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x158
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x159
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x15a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x15b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x15c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x15d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x15e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:24
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:25
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:26
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:27
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:28
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:29
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:30
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:31
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
        s_add_u32       s22, s10, 0x15f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x160
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x161
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x162
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x163
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x164
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x165
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x166
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:32
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:33
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:34
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:35
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:36
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:37
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:38
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:39
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
        s_add_u32       s22, s10, 0x167
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x168
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x169
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x16a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x16b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x16c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x16d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x16e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:40
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:41
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:42
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:43
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:44
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:45
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:46
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:47
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
        s_add_u32       s22, s10, 0x16f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x170
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x171
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x172
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x173
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x174
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x175
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x176
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:48
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:49
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:50
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:51
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:52
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:53
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:54
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:55
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
        s_add_u32       s22, s10, 0x177
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x178
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x179
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x17a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x17b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x17c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x17d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x17e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:56
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:57
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:58
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:59
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:60
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:61
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:62
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:63
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
        s_add_u32       s22, s10, 0x17f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x180
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x181
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x182
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x183
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x184
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x185
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x186
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:64
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:65
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:66
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:67
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:68
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:69
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:70
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:71
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
        s_add_u32       s22, s10, 0x187
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x188
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x189
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x18a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x18b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x18c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x18d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x18e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:72
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:73
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:74
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:75
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:76
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:77
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:78
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:79
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
        s_add_u32       s22, s10, 0x18f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x190
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x191
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x192
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x193
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x194
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x195
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x196
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:80
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:81
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:82
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:83
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:84
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:85
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:86
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:87
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
        s_add_u32       s22, s10, 0x197
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x198
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x199
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x19a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x19b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x19c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x19d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x19e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:88
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:89
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:90
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:91
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:92
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:93
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:94
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:95
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
        s_add_u32       s22, s10, 0x19f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x1a0
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x1a1
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x1a2
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x1a3
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x1a4
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x1a5
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x1a6
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:96
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:97
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:98
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:99
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:100
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:101
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:102
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:103
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
        s_add_u32       s22, s10, 0x1a7
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x1a8
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x1a9
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x1aa
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x1ab
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x1ac
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x1ad
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x1ae
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:104
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:105
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:106
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:107
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:108
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:109
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:110
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:111
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
        s_add_u32       s22, s10, 0x1af
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x1b0
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x1b1
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x1b2
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x1b3
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x1b4
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x1b5
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x1b6
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:112
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:113
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:114
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:115
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:116
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:117
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:118
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:119
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
        s_add_u32       s22, s10, 0x1b7
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x1b8
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x1b9
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x1ba
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x1bb
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x1bc
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x1bd
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x1be
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:120
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:121
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:122
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:123
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:124
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:125
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:126
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:127
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
        s_add_u32       s22, s10, 0x1bf
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 0x80
        s_sub_i32       s11, s11, 8
        s_branch        .L268_1
.L4404_1:
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
        ds_read2_b32    v[17:18], v11 offset0:10 offset1:11
        v_xor_b32       v10, v10, v14
        ds_read2_b32    v[19:20], v11 offset0:14 offset1:16
        ds_read2_b32    v[21:22], v11 offset0:12 offset1:13
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v23, v6, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v17, v17, v23
        v_xor_b32       v23, v9, v10
        v_xor_b32       v24, v16, v8
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v18, v23
        v_alignbit_b32  v23, v24, v24, 31
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v24, v14, v17
        v_xor_b32       v24, 0x60, v24
        v_xor_b32       v25, v12, v23
        v_xor_b32       v26, v16, v18
        ds_write2_b32   v11, v10, v23 offset0:24 offset1:25
        v_xor_b32       v22, v22, v24
        v_xor_b32       v21, v21, v25
        v_xor_b32       v24, v20, v26
        ds_write2_b32   v11, v17, v18 offset0:26 offset1:27
        v_alignbit_b32  v22, v22, v22, 31
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v19, v19, v24
        ds_write2_b32   v11, v21, v22 offset0:28 offset1:29
        v_alignbit_b32  v19, v19, v19, 31
        ds_write_b32    v11, v19 offset:120
        ds_read2_b32    v[24:25], v11 offset0:17 offset1:18
        v_xor_b32       v15, v15, v21
        v_xor_b32       v8, v8, v15
        v_xor_b32       v8, 0x60, v8
        v_xor_b32       v15, v22, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v26, v23, v19
        ds_read2_b32    v[27:28], v11 offset0:21 offset1:23
        ds_read2_b32    v[29:30], v11 offset0:19 offset1:20
        v_xor_b32       v6, v6, v15
        v_xor_b32       v9, v9, v26
        v_xor_b32       v15, v17, v8
        v_xor_b32       v6, v20, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v24, v9
        v_xor_b32       v12, v12, v15
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v12, v25, v12
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v15, v21, v9
        v_xor_b32       v20, v18, v6
        v_xor_b32       v15, v16, v15
        v_xor_b32       v14, v14, v20
        v_xor_b32       v20, v22, v12
        ds_write2_b32   v11, v8, v6 offset0:31 offset1:32
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v15, v30, v15
        v_xor_b32       v14, v29, v14
        v_xor_b32       v20, v28, v20
        ds_write2_b32   v11, v9, v12 offset0:33 offset1:34
        v_alignbit_b32  v15, v15, v15, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v20, v27, v20
        ds_write2_b32   v11, v14, v15 offset0:35 offset1:36
        v_alignbit_b32  v20, v20, v20, 31
        ds_write_b32    v11, v20 offset:148
        ds_read2_b32    v[24:25], v11 offset0:24 offset1:25
        v_xor_b32       v19, v19, v14
        v_xor_b32       v10, v10, v19
        v_xor_b32       v10, v16, v10
        v_xor_b32       v16, v15, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v19, v6, v20
        ds_read2_b32    v[26:27], v11 offset0:28 offset1:30
        ds_read2_b32    v[29:30], v11 offset0:26 offset1:27
        v_xor_b32       v16, v23, v16
        v_xor_b32       v17, v17, v19
        v_xor_b32       v19, v9, v10
        v_xor_b32       v16, v28, v16
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v17, v24, v17
        v_xor_b32       v18, v18, v19
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v25, v18
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v19, v14, v17
        v_xor_b32       v23, v12, v16
        v_xor_b32       v19, v22, v19
        v_xor_b32       v21, v21, v23
        v_xor_b32       v23, v15, v18
        ds_write2_b32   v11, v10, v16 offset0:38 offset1:39
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v30, v19
        v_xor_b32       v21, v29, v21
        v_xor_b32       v23, v27, v23
        ds_write2_b32   v11, v17, v18 offset0:40 offset1:41
        v_alignbit_b32  v19, v19, v19, 31
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v23, v26, v23
        ds_write2_b32   v11, v21, v19 offset0:42 offset1:43
        v_alignbit_b32  v23, v23, v23, 31
        ds_write_b32    v11, v23 offset:176
        ds_read2_b32    v[24:25], v11 offset0:31 offset1:32
        v_xor_b32       v20, v20, v21
        v_xor_b32       v8, v8, v20
        v_xor_b32       v8, v22, v8
        v_xor_b32       v20, v19, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v22, v16, v23
        ds_read2_b32    v[28:29], v11 offset0:35 offset1:37
        ds_read2_b32    v[30:31], v11 offset0:33 offset1:34
        v_xor_b32       v6, v6, v20
        v_xor_b32       v9, v9, v22
        v_xor_b32       v20, v17, v8
        v_xor_b32       v6, v27, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v24, v9
        v_xor_b32       v12, v12, v20
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v12, v25, v12
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v20, v21, v9
        v_xor_b32       v22, v18, v6
        v_xor_b32       v20, v15, v20
        v_xor_b32       v14, v14, v22
        v_xor_b32       v22, v19, v12
        ds_write2_b32   v11, v8, v6 offset0:45 offset1:46
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v31, v20
        v_xor_b32       v14, v30, v14
        v_xor_b32       v22, v29, v22
        ds_write2_b32   v11, v9, v12 offset0:47 offset1:48
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v22, v28, v22
        ds_write2_b32   v11, v14, v20 offset0:49 offset1:50
        v_alignbit_b32  v22, v22, v22, 31
        ds_write_b32    v11, v22 offset:204
        ds_read2_b32    v[24:25], v11 offset0:38 offset1:39
        v_xor_b32       v23, v23, v14
        v_xor_b32       v10, v10, v23
        v_xor_b32       v10, v15, v10
        v_xor_b32       v15, v20, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v23, v6, v22
        ds_read2_b32    v[26:27], v11 offset0:42 offset1:44
        ds_read2_b32    v[30:31], v11 offset0:40 offset1:41
        v_xor_b32       v15, v16, v15
        v_xor_b32       v16, v17, v23
        v_xor_b32       v17, v9, v10
        v_xor_b32       v15, v29, v15
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v16, v24, v16
        v_xor_b32       v17, v18, v17
        v_alignbit_b32  v15, v15, v15, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v17, v25, v17
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v14, v16
        v_xor_b32       v23, v12, v15
        v_xor_b32       v18, v19, v18
        v_xor_b32       v21, v21, v23
        v_xor_b32       v23, v20, v17
        ds_write2_b32   v11, v10, v15 offset0:52 offset1:53
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v18, v31, v18
        v_xor_b32       v21, v30, v21
        v_xor_b32       v23, v27, v23
        ds_write2_b32   v11, v16, v17 offset0:54 offset1:55
        v_alignbit_b32  v18, v18, v18, 31
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v23, v26, v23
        ds_write2_b32   v11, v21, v18 offset0:56 offset1:57
        v_alignbit_b32  v23, v23, v23, 31
        ds_write_b32    v11, v23 offset:232
        ds_read2_b32    v[24:25], v11 offset0:45 offset1:46
        v_xor_b32       v22, v22, v21
        v_xor_b32       v8, v8, v22
        v_xor_b32       v8, v19, v8
        v_xor_b32       v19, v18, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v22, v15, v23
        ds_read2_b32    v[28:29], v11 offset0:49 offset1:51
        ds_read2_b32    v[30:31], v11 offset0:47 offset1:48
        v_xor_b32       v6, v6, v19
        v_xor_b32       v9, v9, v22
        v_xor_b32       v19, v16, v8
        v_xor_b32       v6, v27, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v24, v9
        v_xor_b32       v12, v12, v19
        v_alignbit_b32  v62, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v12, v25, v12
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v19, v21, v9
        v_xor_b32       v22, v17, v62
        v_xor_b32       v19, v20, v19
        v_xor_b32       v14, v14, v22
        v_xor_b32       v22, v18, v12
        ds_write2_b32   v11, v8, v62 offset0:59 offset1:60
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v31, v19
        v_xor_b32       v14, v30, v14
        v_xor_b32       v22, v29, v22
        ds_write2_b32   v11, v9, v12 offset0:61 offset1:62
        v_alignbit_b32  v61, v19, v19, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v22, v28, v22
        ds_write2_b32   v11, v14, v61 offset0:63 offset1:64
        v_alignbit_b32  v44, v22, v22, 31
        ds_write_b32    v11, v44 offset:260
        ds_read2_b32    v[24:25], v11 offset0:52 offset1:53
        v_xor_b32       v23, v23, v14
        v_xor_b32       v10, v10, v23
        v_xor_b32       v10, v20, v10
        v_xor_b32       v20, v61, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v23, v62, v44
        ds_read2_b32    v[26:27], v11 offset0:56 offset1:58
        ds_read2_b32    v[30:31], v11 offset0:54 offset1:55
        v_xor_b32       v15, v15, v20
        v_xor_b32       v16, v16, v23
        v_xor_b32       v20, v9, v10
        v_xor_b32       v15, v29, v15
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v16, v24, v16
        v_xor_b32       v17, v17, v20
        v_alignbit_b32  v15, v15, v15, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v17, v25, v17
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v20, v14, v16
        v_xor_b32       v23, v12, v15
        v_xor_b32       v20, v18, v20
        v_xor_b32       v21, v21, v23
        v_xor_b32       v23, v61, v17
        ds_write2_b32   v11, v10, v15 offset0:66 offset1:67
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v31, v20
        v_xor_b32       v21, v30, v21
        v_xor_b32       v23, v27, v23
        ds_write2_b32   v11, v16, v17 offset0:68 offset1:69
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v23, v26, v23
        ds_write2_b32   v11, v21, v20 offset0:70 offset1:71
        v_alignbit_b32  v23, v23, v23, 31
        ds_write_b32    v11, v23 offset:288
        ds_read2_b32    v[24:25], v11 offset0:59 offset1:60
        v_xor_b32       v26, v44, v21
        v_xor_b32       v8, v8, v26
        v_xor_b32       v8, v18, v8
        v_xor_b32       v10, v20, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v15, v15, v23
        ds_read2_b32    v[28:29], v11 offset0:63 offset1:65
        ds_read2_b32    v[30:31], v11 offset0:61 offset1:62
        v_xor_b32       v10, v62, v10
        v_xor_b32       v9, v9, v15
        v_xor_b32       v15, v16, v8
        v_xor_b32       v10, v27, v10
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v24, v9
        v_xor_b32       v12, v12, v15
        v_alignbit_b32  v10, v10, v10, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v12, v25, v12
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v15, v21, v9
        v_xor_b32       v16, v17, v10
        v_xor_b32       v15, v61, v15
        v_xor_b32       v14, v14, v16
        v_xor_b32       v16, v20, v12
        ds_write2_b32   v11, v8, v10 offset0:73 offset1:74
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v8, v31, v15
        v_xor_b32       v10, v30, v14
        v_xor_b32       v14, v29, v16
        ds_write2_b32   v11, v9, v12 offset0:75 offset1:76
        v_alignbit_b32  v8, v8, v8, 31
        v_alignbit_b32  v63, v10, v10, 31
        v_xor_b32       v10, v28, v14
        ds_write2_b32   v11, v63, v8 offset0:77 offset1:78
        v_alignbit_b32  v8, v10, v10, 31
        ds_write_b32    v11, v8 offset:316
        ds_read2_b32    v[14:15], v11 offset0:1 offset1:2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x5a827999, v15
        v_add_i32       v10, vcc, 0x5a827999, v14
        ds_write2_b32   v11, v10, v8 offset0:1 offset1:2
        ds_read2_b32    v[14:15], v11 offset0:17 offset1:18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x5a827999, v15
        v_add_i32       v10, vcc, 0x5a827999, v14
        ds_write2_b32   v11, v10, v8 offset0:17 offset1:18
        ds_read2_b32    v[14:15], v11 offset0:20 offset1:21
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x6ed9eba1, v15
        v_add_i32       v10, vcc, 0x6ed9eba1, v14
        ds_write2_b32   v11, v10, v8 offset0:20 offset1:21
        ds_read_b32     v8, v11 offset:92
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x6ed9eba1, v8
        ds_write_b32    v11, v8 offset:92
        ds_read2_b32    v[14:15], v11 offset0:26 offset1:27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x6ed9eba1, v15
        v_add_i32       v10, vcc, 0x6ed9eba1, v14
        ds_write2_b32   v11, v10, v8 offset0:26 offset1:27
        ds_read_b32     v8, v11 offset:116
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x6ed9eba1, v8
        ds_write_b32    v11, v8 offset:116
        ds_read_b32     v8, v11 offset:132
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x6ed9eba1, v8
        ds_write_b32    v11, v8 offset:132
        ds_read_b32     v8, v11 offset:156
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x6ed9eba1, v8
        ds_write_b32    v11, v8 offset:156
        ds_read_b32     v8, v11 offset:164
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x8f1bbcdc, v8
        ds_write_b32    v11, v8 offset:164
        ds_read_b32     v8, v11 offset:180
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x8f1bbcdc, v8
        ds_write_b32    v11, v8 offset:180
        ds_read_b32     v8, v11 offset:212
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0x8f1bbcdc, v8
        ds_write_b32    v11, v8 offset:212
        ds_read_b32     v8, v11 offset:260
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0xca62c1d6, v8
        ds_write_b32    v11, v8 offset:260
        ds_read_b32     v8, v11 offset:276
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0xca62c1d6, v8
        ds_write_b32    v11, v8 offset:276
        ds_read_b32     v8, v11 offset:308
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v8, vcc, 0xca62c1d6, v8
        ds_write_b32    v11, v8 offset:308
        v_lshrrev_b32   v0, 2, v0
        v_lshlrev_b32   v8, 24, v4
        v_lshlrev_b32   v10, 16, v2
        v_and_b32       v0, 48, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        ds_read2_b32    v[14:15], v11 offset0:38 offset1:39
        ds_read2_b32    v[16:17], v11 offset0:36 offset1:37
        ds_read2_b32    v[20:21], v11 offset0:34 offset1:35
        ds_read2_b32    v[23:24], v11 offset0:32 offset1:33
        ds_read2_b32    v[25:26], v11 offset0:30 offset1:31
        ds_read2_b32    v[27:28], v11 offset0:28 offset1:29
        ds_read2_b32    v[29:30], v11 offset0:26 offset1:27
        ds_read2_b32    v[31:32], v11 offset0:24 offset1:25
        ds_read2_b32    v[33:34], v11 offset0:22 offset1:23
        ds_read2_b32    v[35:36], v11 offset0:20 offset1:21
        ds_read2_b32    v[37:38], v11 offset0:18 offset1:19
        ds_read2_b32    v[11:12], v11 offset0:16 offset1:17
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[12:15], s[2:3], 0x90
        v_or_b32        v8, v8, v10
        v_add_i32       v0, vcc, v7, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        s_add_u32       s0, -1, s5
        s_mov_b64       s[16:17], exec
        s_mov_b64       s[18:19], exec
        s_movk_i32      s5, 0x0
        v_mov_b32       v6, v39
.L6964_1:
        s_cmp_gt_i32    s5, 0x3ff
        s_cbranch_scc0  .L7000_1
        s_cmp_gt_i32    s5, 0x3ff
        s_cselect_b32   s0, -1, 0
        v_mov_b32       v63, s0
        v_mov_b32       v6, 0
        s_branch        .L11784_1
.L7000_1:
        s_ashr_i32      s6, s5, 6
        s_add_u32       s6, s6, s20
        v_bfe_u32       v6, v0, 0, 8
        v_add_i32       v6, vcc, s6, v6
        s_and_b32       s6, s5, 63
        s_add_u32       s6, s6, s21
        buffer_load_ubyte v63, v6, s[28:31], 0 offen
        v_add_i32       v7, vcc, s6, v1
        buffer_load_ubyte v61, v7, s[32:35], 0 offen
        v_mov_b32       v9, 0
        s_waitcnt       vmcnt(0)
        s_barrier
        ds_read2_b32    v[18:19], v9 offset0:1 offset1:2
        v_lshlrev_b32   v10, 8, v63
        v_or_b32        v10, v8, v10
        v_or_b32        v62, v10, v61
        v_add_i32       v22, vcc, 0x9fb498b3, v62
        v_alignbit_b32  v39, v22, v22, 27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v18, vcc, v39, v18
        v_add_i32       v18, vcc, 0xc2e5374, v18
        v_mov_b32       v39, 0x7bf36ae2
        s_mov_b32       s6, 0x59d148c0
        v_bfi_b32       v39, v22, s6, v39
        v_alignbit_b32  v40, v18, v18, 27
        v_add_i32       v39, vcc, v39, v40
        v_add_i32       v19, vcc, v19, v39
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, 0x98badcfe, v19
        v_bfi_b32       v39, v18, v22, s6
        v_alignbit_b32  v40, v19, v19, 27
        v_add_i32       v39, vcc, v40, v39
        v_add_i32       v39, vcc, 0x7bf36ae2, v39
        v_xor_b32       v39, 0x80000000, v39
        v_add_i32       v39, vcc, 0x5a827999, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_alignbit_b32  v40, v39, v39, 27
        v_bfi_b32       v41, v19, v18, v22
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, 0xb453c259, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_alignbit_b32  v41, v40, v40, 27
        v_bfi_b32       v42, v39, v19, v18
        v_add_i32       v22, vcc, v22, v41
        v_add_i32       v22, vcc, v42, v22
        v_add_i32       v22, vcc, 0x5a827999, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_alignbit_b32  v41, v22, v22, 27
        v_bfi_b32       v42, v40, v39, v19
        v_add_i32       v18, vcc, v18, v41
        v_add_i32       v18, vcc, v42, v18
        v_add_i32       v18, vcc, 0x5a827999, v18
        v_alignbit_b32  v41, v18, v18, 27
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v19, vcc, v19, v41
        v_bfi_b32       v41, v22, v40, v39
        v_add_i32       v19, vcc, v19, v41
        v_add_i32       v19, vcc, 0x5a827999, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_alignbit_b32  v41, v19, v19, 27
        v_bfi_b32       v42, v18, v22, v40
        v_add_i32       v39, vcc, v39, v41
        v_add_i32       v39, vcc, v42, v39
        v_add_i32       v39, vcc, 0x5a827999, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_alignbit_b32  v41, v39, v39, 27
        v_bfi_b32       v42, v19, v18, v22
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, v42, v40
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_alignbit_b32  v41, v40, v40, 27
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v22, vcc, v22, v41
        v_bfi_b32       v41, v39, v19, v18
        v_add_i32       v22, vcc, v22, v41
        v_add_i32       v22, vcc, 0x5a827999, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_alignbit_b32  v41, v22, v22, 27
        v_bfi_b32       v42, v40, v39, v19
        v_add_i32       v18, vcc, v18, v41
        v_add_i32       v18, vcc, v42, v18
        v_add_i32       v18, vcc, 0x5a827999, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_alignbit_b32  v41, v18, v18, 27
        v_bfi_b32       v42, v22, v40, v39
        v_add_i32       v19, vcc, v19, v41
        v_add_i32       v19, vcc, v42, v19
        v_add_i32       v19, vcc, 0x5a827999, v19
        v_alignbit_b32  v41, v19, v19, 27
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v39, vcc, v39, v41
        v_bfi_b32       v41, v18, v22, v40
        v_add_i32       v39, vcc, v39, v41
        v_add_i32       v39, vcc, 0x5a827999, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_alignbit_b32  v41, v39, v39, 27
        v_bfi_b32       v42, v19, v18, v22
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, v42, v40
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_alignbit_b32  v41, v40, v40, 27
        v_bfi_b32       v42, v39, v19, v18
        v_add_i32       v22, vcc, v22, v41
        v_add_i32       v22, vcc, v42, v22
        v_alignbit_b32  v41, v62, v62, 31
        v_add_i32       v22, vcc, 0x5a8279f9, v22
        v_xor_b32       v41, v11, v41
        v_alignbit_b32  v42, v22, v22, 27
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v18, vcc, v42, v18
        v_bfi_b32       v41, v40, v39, v19
        v_add_i32       v18, vcc, v18, v41
        v_add_i32       v18, vcc, 0x5a827999, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_alignbit_b32  v41, v18, v18, 27
        v_add_i32       v19, vcc, v12, v19
        v_bfi_b32       v42, v22, v40, v39
        v_add_i32       v19, vcc, v41, v19
        v_add_i32       v19, vcc, v42, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_alignbit_b32  v41, v19, v19, 27
        v_add_i32       v39, vcc, v37, v39
        v_bfi_b32       v42, v18, v22, v40
        v_add_i32       v39, vcc, v41, v39
        v_alignbit_b32  v41, v62, v62, 30
        v_add_i32       v39, vcc, v42, v39
        v_xor_b32       v42, v38, v41
        v_alignbit_b32  v43, v39, v39, 27
        v_add_i32       v40, vcc, v40, v42
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v40, vcc, v43, v40
        v_bfi_b32       v42, v19, v18, v22
        v_add_i32       v40, vcc, v40, v42
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v42, v39, v18
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_xor_b32       v42, v19, v42
        v_add_i32       v22, vcc, v35, v22
        v_xor_b32       v43, v40, v19
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, v42, v22
        v_alignbit_b32  v42, v40, v40, 27
        v_xor_b32       v43, v43, v39
        v_add_i32       v18, vcc, v36, v18
        v_add_i32       v22, vcc, v22, v42
        v_alignbit_b32  v42, v62, v62, 29
        v_add_i32       v18, vcc, v43, v18
        v_alignbit_b32  v43, v22, v22, 27
        v_xor_b32       v44, v39, v22
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v45, v33, v42
        v_add_i32       v18, vcc, v18, v43
        v_xor_b32       v43, v44, v40
        v_add_i32       v19, vcc, v19, v45
        v_alignbit_b32  v44, v18, v18, 27
        v_add_i32       v19, vcc, v43, v19
        v_add_i32       v19, vcc, v44, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v43, v18, v40
        v_add_i32       v19, vcc, 0x6ed9eba1, v19
        v_xor_b32       v43, v22, v43
        v_add_i32       v39, vcc, v34, v39
        v_xor_b32       v44, v19, v22
        v_alignbit_b32  v18, v18, v18, 2
        v_xor_b32       v45, v31, v41
        v_add_i32       v39, vcc, v43, v39
        v_alignbit_b32  v43, v19, v19, 27
        v_xor_b32       v44, v44, v18
        v_add_i32       v40, vcc, v40, v45
        v_add_i32       v39, vcc, v39, v43
        v_add_i32       v40, vcc, v44, v40
        v_alignbit_b32  v43, v39, v39, 27
        v_alignbit_b32  v44, v62, v62, 28
        v_add_i32       v40, vcc, v40, v43
        v_xor_b32       v43, v18, v39
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v45, v32, v44
        v_add_i32       v40, vcc, 0x6ed9eba1, v40
        v_xor_b32       v43, v43, v19
        v_add_i32       v22, vcc, v22, v45
        v_alignbit_b32  v45, v40, v40, 27
        v_add_i32       v22, vcc, v43, v22
        v_add_i32       v22, vcc, v45, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v43, v40, v19
        v_add_i32       v22, vcc, 0x6ed9eba1, v22
        v_xor_b32       v43, v39, v43
        v_add_i32       v18, vcc, v29, v18
        v_xor_b32       v45, v22, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, v43, v18
        v_alignbit_b32  v43, v22, v22, 27
        v_xor_b32       v45, v45, v40
        v_add_i32       v19, vcc, v30, v19
        v_add_i32       v18, vcc, v18, v43
        v_alignbit_b32  v43, v62, v62, 27
        v_add_i32       v19, vcc, v45, v19
        v_alignbit_b32  v45, v18, v18, 27
        v_xor_b32       v46, v40, v18
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v47, v27, v43
        v_add_i32       v19, vcc, v19, v45
        v_xor_b32       v45, v46, v22
        v_add_i32       v39, vcc, v39, v47
        v_alignbit_b32  v46, v19, v19, 27
        v_add_i32       v39, vcc, v45, v39
        v_add_i32       v39, vcc, v46, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_xor_b32       v45, v19, v22
        v_add_i32       v39, vcc, 0x6ed9eba1, v39
        v_xor_b32       v46, v25, v41
        v_xor_b32       v45, v18, v45
        v_add_i32       v40, vcc, v28, v40
        v_xor_b32       v47, v39, v18
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v46, v44, v46
        v_add_i32       v40, vcc, v45, v40
        v_alignbit_b32  v45, v39, v39, 27
        v_xor_b32       v47, v47, v19
        v_add_i32       v22, vcc, v22, v46
        v_add_i32       v40, vcc, v40, v45
        v_add_i32       v22, vcc, v47, v22
        v_alignbit_b32  v45, v40, v40, 27
        v_alignbit_b32  v46, v62, v62, 26
        v_add_i32       v22, vcc, v22, v45
        v_xor_b32       v45, v19, v40
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v47, v26, v46
        v_add_i32       v22, vcc, 0x6ed9eba1, v22
        v_xor_b32       v45, v45, v39
        v_add_i32       v18, vcc, v18, v47
        v_alignbit_b32  v47, v22, v22, 27
        v_add_i32       v18, vcc, v45, v18
        v_xor_b32       v41, v23, v41
        v_add_i32       v18, vcc, v47, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v45, v22, v39
        v_xor_b32       v41, v42, v41
        v_add_i32       v18, vcc, 0x6ed9eba1, v18
        v_xor_b32       v45, v40, v45
        v_add_i32       v19, vcc, v19, v41
        v_add_i32       v19, vcc, v45, v19
        v_alignbit_b32  v41, v18, v18, 27
        v_xor_b32       v45, v18, v40
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, v19, v41
        v_xor_b32       v41, v45, v22
        v_add_i32       v39, vcc, v24, v39
        v_add_i32       v19, vcc, 0x6ed9eba1, v19
        v_alignbit_b32  v45, v62, v62, 25
        v_add_i32       v39, vcc, v41, v39
        v_alignbit_b32  v41, v19, v19, 27
        v_xor_b32       v47, v22, v19
        v_alignbit_b32  v18, v18, v18, 2
        v_xor_b32       v48, v20, v45
        v_add_i32       v39, vcc, v39, v41
        v_xor_b32       v41, v47, v18
        v_add_i32       v40, vcc, v40, v48
        v_alignbit_b32  v47, v39, v39, 27
        v_add_i32       v40, vcc, v41, v40
        v_add_i32       v40, vcc, v47, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v41, v39, v18
        v_xor_b32       v47, v21, v44
        v_add_i32       v40, vcc, 0x6ed9eba1, v40
        v_xor_b32       v41, v19, v41
        v_add_i32       v22, vcc, v22, v47
        v_xor_b32       v47, v44, v46
        v_add_i32       v22, vcc, v41, v22
        v_alignbit_b32  v41, v40, v40, 27
        v_xor_b32       v48, v40, v19
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v49, v16, v47
        v_add_i32       v22, vcc, v22, v41
        v_xor_b32       v41, v48, v39
        v_add_i32       v18, vcc, v18, v49
        v_add_i32       v22, vcc, 0x6ed9eba1, v22
        v_add_i32       v18, vcc, v41, v18
        v_alignbit_b32  v41, v22, v22, 27
        v_alignbit_b32  v48, v62, v62, 24
        v_add_i32       v18, vcc, v18, v41
        v_xor_b32       v41, v39, v22
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v49, v17, v48
        v_add_i32       v18, vcc, 0x6ed9eba1, v18
        v_xor_b32       v41, v41, v40
        v_add_i32       v19, vcc, v19, v49
        v_alignbit_b32  v49, v18, v18, 27
        v_add_i32       v19, vcc, v41, v19
        v_add_i32       v19, vcc, v49, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v41, v18, v40
        v_xor_b32       v49, v14, v44
        v_add_i32       v19, vcc, 0x6ed9eba1, v19
        v_xor_b32       v41, v22, v41
        v_add_i32       v39, vcc, v39, v49
        v_add_i32       v39, vcc, v41, v39
        v_alignbit_b32  v41, v19, v19, 27
        v_xor_b32       v49, v19, v22
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v39, vcc, v39, v41
        ds_read2_b32    v[50:51], v9 offset0:40 offset1:41
        v_xor_b32       v41, v49, v18
        v_add_i32       v40, vcc, v15, v40
        v_add_i32       v39, vcc, 0x6ed9eba1, v39
        v_add_i32       v40, vcc, v41, v40
        v_alignbit_b32  v41, v39, v39, 27
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v19, v19, v19, 2
        v_bfi_b32       v41, v18, v19, v39
        v_bfi_b32       v49, v19, 0, v39
        v_alignbit_b32  v52, v40, v40, 27
        v_alignbit_b32  v53, v62, v62, 23
        v_xor_b32       v41, v41, v49
        v_add_i32       v22, vcc, v22, v52
        v_xor_b32       v49, v44, v53
        v_add_i32       v22, vcc, v41, v22
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v49, v50
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, 0x8f1bbcdc, v22
        v_bfi_b32       v41, v19, v39, v40
        v_bfi_b32       v49, v39, 0, v40
        v_alignbit_b32  v50, v22, v22, 27
        ds_read2_b32    v[52:53], v9 offset0:42 offset1:43
        v_xor_b32       v41, v41, v49
        v_add_i32       v18, vcc, v18, v50
        v_add_i32       v18, vcc, v41, v18
        v_add_i32       v18, vcc, v51, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_bfi_b32       v41, v39, v40, v22
        v_bfi_b32       v49, v40, 0, v22
        v_alignbit_b32  v50, v18, v18, 27
        v_xor_b32       v41, v41, v49
        v_add_i32       v19, vcc, v19, v50
        v_xor_b32       v49, v46, v48
        v_add_i32       v19, vcc, v41, v19
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v52, v49
        v_add_i32       v19, vcc, v19, v41
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, 0x8f1bbcdc, v19
        v_bfi_b32       v41, v40, v22, v18
        v_bfi_b32       v49, v22, 0, v18
        v_alignbit_b32  v50, v19, v19, 27
        v_xor_b32       v41, v41, v49
        v_add_i32       v39, vcc, v39, v50
        v_alignbit_b32  v49, v62, v62, 22
        ds_read2_b32    v[50:51], v9 offset0:44 offset1:45
        v_add_i32       v39, vcc, v41, v39
        v_xor_b32       v41, v53, v49
        v_add_i32       v39, vcc, v39, v41
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_bfi_b32       v41, v22, v18, v19
        v_bfi_b32       v52, v18, 0, v19
        v_alignbit_b32  v53, v39, v39, 27
        v_xor_b32       v54, v42, v46
        v_xor_b32       v41, v41, v52
        v_add_i32       v40, vcc, v40, v53
        v_xor_b32       v52, v45, v54
        v_add_i32       v40, vcc, v41, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v52, v50
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_bfi_b32       v41, v18, v19, v39
        v_bfi_b32       v50, v19, 0, v39
        v_alignbit_b32  v52, v40, v40, 27
        ds_read2_b32    v[53:54], v9 offset0:46 offset1:47
        v_xor_b32       v41, v41, v50
        v_add_i32       v22, vcc, v22, v52
        v_add_i32       v22, vcc, v41, v22
        v_add_i32       v22, vcc, v51, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_bfi_b32       v41, v19, v39, v40
        v_bfi_b32       v50, v39, 0, v40
        v_alignbit_b32  v51, v22, v22, 27
        v_alignbit_b32  v52, v62, v62, 21
        v_xor_b32       v41, v41, v50
        v_add_i32       v18, vcc, v18, v51
        v_xor_b32       v50, v44, v52
        v_add_i32       v18, vcc, v41, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v53, v50
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, 0x8f1bbcdc, v18
        v_bfi_b32       v41, v39, v40, v22
        v_bfi_b32       v50, v40, 0, v22
        v_alignbit_b32  v51, v18, v18, 27
        v_xor_b32       v41, v41, v50
        v_add_i32       v19, vcc, v19, v51
        v_xor_b32       v50, v44, v48
        ds_read2_b32    v[55:56], v9 offset0:48 offset1:49
        v_add_i32       v19, vcc, v41, v19
        v_xor_b32       v41, v54, v50
        v_add_i32       v19, vcc, v19, v41
        v_add_i32       v19, vcc, 0x8f1bbcdc, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v41, v42, v43
        v_bfi_b32       v42, v40, v22, v18
        v_bfi_b32       v51, v22, 0, v18
        v_alignbit_b32  v53, v19, v19, 27
        v_xor_b32       v41, v50, v41
        v_xor_b32       v42, v42, v51
        v_add_i32       v39, vcc, v39, v53
        v_xor_b32       v41, v49, v41
        v_add_i32       v39, vcc, v42, v39
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v55
        v_add_i32       v39, vcc, v39, v41
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_bfi_b32       v41, v22, v18, v19
        v_bfi_b32       v42, v18, 0, v19
        v_alignbit_b32  v51, v39, v39, 27
        v_xor_b32       v41, v41, v42
        v_add_i32       v40, vcc, v40, v51
        v_alignbit_b32  v42, v62, v62, 20
        ds_read2_b32    v[53:54], v9 offset0:50 offset1:51
        v_add_i32       v40, vcc, v41, v40
        v_xor_b32       v41, v56, v42
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_bfi_b32       v41, v18, v19, v39
        v_bfi_b32       v51, v19, 0, v39
        v_alignbit_b32  v55, v40, v40, 27
        v_xor_b32       v41, v41, v51
        v_add_i32       v22, vcc, v22, v55
        v_add_i32       v22, vcc, v41, v22
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v48, v53
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, 0x8f1bbcdc, v22
        v_bfi_b32       v41, v19, v39, v40
        v_bfi_b32       v51, v39, 0, v40
        v_alignbit_b32  v53, v22, v22, 27
        v_xor_b32       v41, v41, v51
        v_add_i32       v18, vcc, v18, v53
        ds_read2_b32    v[55:56], v9 offset0:52 offset1:53
        v_add_i32       v18, vcc, v41, v18
        v_xor_b32       v41, v47, v54
        v_add_i32       v18, vcc, v18, v41
        v_add_i32       v18, vcc, 0x8f1bbcdc, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_bfi_b32       v41, v39, v40, v22
        v_bfi_b32       v51, v40, 0, v22
        v_alignbit_b32  v53, v18, v18, 27
        v_alignbit_b32  v54, v62, v62, 19
        v_xor_b32       v41, v41, v51
        v_add_i32       v19, vcc, v19, v53
        v_xor_b32       v51, v50, v54
        v_add_i32       v19, vcc, v41, v19
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v51, v55
        v_add_i32       v19, vcc, v19, v41
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, 0x8f1bbcdc, v19
        v_bfi_b32       v41, v40, v22, v18
        v_bfi_b32       v51, v22, 0, v18
        v_alignbit_b32  v53, v19, v19, 27
        ds_read2_b32    v[57:58], v9 offset0:54 offset1:55
        v_xor_b32       v41, v41, v51
        v_add_i32       v39, vcc, v39, v53
        v_add_i32       v39, vcc, v41, v39
        v_add_i32       v39, vcc, v56, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_bfi_b32       v41, v22, v18, v19
        v_bfi_b32       v51, v18, 0, v19
        v_alignbit_b32  v53, v39, v39, 27
        v_xor_b32       v55, v45, v49
        v_xor_b32       v41, v41, v51
        v_add_i32       v40, vcc, v40, v53
        v_xor_b32       v51, v42, v55
        v_add_i32       v40, vcc, v41, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v51, v57
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_bfi_b32       v41, v18, v19, v39
        v_bfi_b32       v51, v19, 0, v39
        v_alignbit_b32  v53, v40, v40, 27
        v_xor_b32       v41, v41, v51
        v_add_i32       v22, vcc, v22, v53
        v_alignbit_b32  v51, v62, v62, 18
        ds_read2_b32    v[55:56], v9 offset0:56 offset1:57
        v_add_i32       v22, vcc, v41, v22
        v_xor_b32       v41, v51, v58
        v_add_i32       v22, vcc, v22, v41
        v_add_i32       v22, vcc, 0x8f1bbcdc, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v41, v45, v47
        v_bfi_b32       v53, v19, v39, v40
        v_bfi_b32       v57, v39, 0, v40
        v_alignbit_b32  v58, v22, v22, 27
        v_xor_b32       v49, v49, v41
        v_xor_b32       v53, v53, v57
        v_add_i32       v18, vcc, v18, v58
        v_xor_b32       v49, v52, v49
        v_add_i32       v18, vcc, v53, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v49, v49, v55
        v_add_i32       v18, vcc, v18, v49
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, 0x8f1bbcdc, v18
        v_bfi_b32       v49, v39, v40, v22
        v_bfi_b32       v53, v40, 0, v22
        v_alignbit_b32  v55, v18, v18, 27
        v_xor_b32       v49, v49, v53
        v_add_i32       v19, vcc, v19, v55
        ds_read2_b32    v[57:58], v9 offset0:58 offset1:59
        v_add_i32       v19, vcc, v49, v19
        v_xor_b32       v49, v48, v56
        v_add_i32       v19, vcc, v19, v49
        v_add_i32       v19, vcc, 0x8f1bbcdc, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_bfi_b32       v49, v40, v22, v18
        v_bfi_b32       v53, v22, 0, v18
        v_alignbit_b32  v55, v19, v19, 27
        v_alignbit_b32  v56, v62, v62, 17
        v_xor_b32       v49, v49, v53
        v_add_i32       v39, vcc, v39, v55
        v_xor_b32       v50, v50, v56
        v_add_i32       v39, vcc, v49, v39
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v49, v50, v57
        v_add_i32       v39, vcc, v39, v49
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_bfi_b32       v49, v22, v18, v19
        v_bfi_b32       v50, v18, 0, v19
        v_alignbit_b32  v53, v39, v39, 27
        ds_read2_b32    v[59:60], v9 offset0:60 offset1:61
        v_xor_b32       v49, v49, v50
        v_add_i32       v40, vcc, v40, v53
        v_xor_b32       v50, v48, v42
        v_add_i32       v40, vcc, v49, v40
        v_xor_b32       v49, v50, v58
        v_add_i32       v40, vcc, v40, v49
        v_xor_b32       v49, v18, v39
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v44, v44, v45
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_xor_b32       v49, v49, v19
        v_xor_b32       v44, v50, v44
        v_alignbit_b32  v53, v40, v40, 27
        v_add_i32       v22, vcc, v22, v49
        v_xor_b32       v44, v51, v44
        v_add_i32       v22, vcc, v53, v22
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v44, v44, v59
        v_add_i32       v22, vcc, v22, v44
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v44, v40, v19
        v_add_i32       v22, vcc, 0xca62c1d6, v22
        v_xor_b32       v44, v39, v44
        ds_read2_b32    v[57:58], v9 offset0:62 offset1:63
        v_add_i32       v18, vcc, v18, v44
        v_alignbit_b32  v44, v22, v22, 27
        v_alignbit_b32  v49, v62, v62, 16
        v_add_i32       v18, vcc, v18, v44
        v_xor_b32       v44, v49, v60
        v_xor_b32       v53, v22, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, v18, v44
        v_xor_b32       v44, v53, v40
        v_add_i32       v18, vcc, 0xca62c1d6, v18
        v_add_i32       v19, vcc, v19, v44
        v_alignbit_b32  v44, v18, v18, 27
        v_xor_b32       v47, v47, v50
        v_add_i32       v19, vcc, v19, v44
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v44, v47, v57
        v_add_i32       v19, vcc, v19, v44
        v_xor_b32       v44, v40, v18
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, 0xca62c1d6, v19
        v_xor_b32       v44, v44, v22
        ds_read2_b32    v[59:60], v9 offset0:64 offset1:65
        v_alignbit_b32  v47, v19, v19, 27
        v_add_i32       v39, vcc, v39, v44
        v_add_i32       v39, vcc, v47, v39
        v_xor_b32       v44, v48, v58
        v_add_i32       v39, vcc, v39, v44
        v_alignbit_b32  v18, v18, v18, 2
        v_xor_b32       v44, v19, v22
        v_add_i32       v39, vcc, 0xca62c1d6, v39
        v_xor_b32       v44, v18, v44
        v_xor_b32       v41, v41, v50
        v_alignbit_b32  v47, v62, v62, 15
        v_add_i32       v40, vcc, v40, v44
        v_alignbit_b32  v44, v39, v39, 27
        v_xor_b32       v41, v41, v47
        v_add_i32       v40, vcc, v40, v44
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v59
        v_xor_b32       v44, v39, v18
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v40, vcc, v40, v41
        ds_read2_b32    v[57:58], v9 offset0:66 offset1:67
        v_xor_b32       v41, v44, v19
        v_add_i32       v40, vcc, 0xca62c1d6, v40
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v41, v40, v40, 27
        v_add_i32       v22, vcc, v22, v41
        v_xor_b32       v41, v19, v40
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, v22, v60
        v_xor_b32       v41, v41, v39
        v_alignbit_b32  v44, v22, v22, 27
        v_add_i32       v18, vcc, v18, v41
        v_xor_b32       v41, v51, v49
        v_add_i32       v18, vcc, v44, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v57
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v41, v22, v39
        v_add_i32       v18, vcc, 0xca62c1d6, v18
        v_xor_b32       v41, v40, v41
        v_alignbit_b32  v44, v62, v62, 14
        ds_read2_b32    v[59:60], v9 offset0:68 offset1:69
        v_add_i32       v19, vcc, v19, v41
        v_alignbit_b32  v41, v18, v18, 27
        v_xor_b32       v47, v48, v44
        v_add_i32       v19, vcc, v19, v41
        v_xor_b32       v41, v47, v58
        v_xor_b32       v47, v18, v40
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, v19, v41
        v_xor_b32       v41, v47, v22
        v_add_i32       v19, vcc, 0xca62c1d6, v19
        v_xor_b32       v47, v52, v51
        v_add_i32       v39, vcc, v39, v41
        v_alignbit_b32  v41, v19, v19, 27
        v_xor_b32       v47, v56, v47
        v_add_i32       v39, vcc, v39, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v47, v59
        v_add_i32       v39, vcc, v39, v41
        v_xor_b32       v41, v22, v19
        v_alignbit_b32  v18, v18, v18, 2
        ds_read2_b32    v[57:58], v9 offset0:70 offset1:71
        v_add_i32       v39, vcc, 0xca62c1d6, v39
        v_xor_b32       v41, v41, v18
        v_alignbit_b32  v47, v39, v39, 27
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, v47, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v41, v39, v18
        v_add_i32       v40, vcc, v40, v60
        v_xor_b32       v41, v19, v41
        v_alignbit_b32  v47, v62, v62, 13
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v41, v40, v40, 27
        v_xor_b32       v47, v42, v47
        v_add_i32       v22, vcc, v22, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v47, v57
        v_xor_b32       v47, v40, v19
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, v22, v41
        v_xor_b32       v41, v47, v39
        v_add_i32       v22, vcc, 0xca62c1d6, v22
        ds_read2_b32    v[59:60], v9 offset0:72 offset1:73
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v41, v22, v22, 27
        v_xor_b32       v47, v42, v49
        v_xor_b32       v43, v43, v52
        v_add_i32       v18, vcc, v18, v41
        v_xor_b32       v41, v47, v58
        v_xor_b32       v43, v42, v43
        v_add_i32       v18, vcc, v18, v41
        v_xor_b32       v41, v39, v22
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v43, v54, v43
        v_add_i32       v18, vcc, 0xca62c1d6, v18
        v_xor_b32       v41, v41, v40
        v_xor_b32       v43, v49, v43
        v_alignbit_b32  v47, v18, v18, 27
        v_add_i32       v19, vcc, v19, v41
        v_xor_b32       v41, v44, v43
        v_add_i32       v19, vcc, v47, v19
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v59
        v_add_i32       v19, vcc, v19, v41
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v41, v18, v40
        v_add_i32       v19, vcc, 0xca62c1d6, v19
        v_xor_b32       v41, v22, v41
        ds_read2_b32    v[52:53], v9 offset0:74 offset1:75
        v_add_i32       v39, vcc, v39, v41
        v_alignbit_b32  v41, v19, v19, 27
        v_alignbit_b32  v43, v62, v62, 12
        v_add_i32       v39, vcc, v39, v41
        v_xor_b32       v41, v43, v60
        v_xor_b32       v47, v19, v22
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v39, vcc, v39, v41
        v_xor_b32       v41, v47, v18
        v_add_i32       v39, vcc, 0xca62c1d6, v39
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v41, v39, v39, 27
        v_xor_b32       v47, v48, v49
        v_add_i32       v40, vcc, v40, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v47, v52
        v_add_i32       v40, vcc, v40, v41
        v_xor_b32       v41, v18, v39
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v40, vcc, 0xca62c1d6, v40
        v_xor_b32       v41, v41, v19
        v_xor_b32       v46, v46, v42
        ds_read2_b32    v[54:55], v9 offset0:76 offset1:77
        v_alignbit_b32  v47, v40, v40, 27
        v_add_i32       v22, vcc, v22, v41
        v_xor_b32       v41, v51, v46
        v_add_i32       v22, vcc, v47, v22
        v_xor_b32       v41, v41, v53
        v_xor_b32       v45, v45, v48
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v41, v40, v19
        v_xor_b32       v42, v42, v45
        v_add_i32       v22, vcc, 0xca62c1d6, v22
        v_xor_b32       v41, v39, v41
        v_xor_b32       v42, v49, v42
        v_alignbit_b32  v46, v62, v62, 11
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v41, v22, v22, 27
        v_xor_b32       v42, v42, v46
        v_add_i32       v18, vcc, v18, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v42, v54
        v_xor_b32       v42, v22, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, v18, v41
        ds_read_b32     v9, v9 offset:312
        v_xor_b32       v41, v42, v40
        v_add_i32       v18, vcc, 0xca62c1d6, v18
        v_add_i32       v19, vcc, v19, v41
        v_alignbit_b32  v41, v18, v18, 27
        v_add_i32       v19, vcc, v19, v41
        v_xor_b32       v41, v40, v18
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v42, v56, v45
        v_add_i32       v19, vcc, v19, v55
        v_xor_b32       v41, v41, v22
        v_xor_b32       v42, v44, v42
        v_alignbit_b32  v44, v19, v19, 27
        v_add_i32       v39, vcc, v39, v41
        v_xor_b32       v41, v43, v42
        v_add_i32       v39, vcc, v44, v39
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v9, v41, v9
        v_add_i32       v9, vcc, v39, v9
        v_add_i32       v44, vcc, 0xba306d5f, v9
        v_bfe_u32       v41, v44, 10, 12
        ds_read_u8      v41, v41 offset:320
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v41, v41, 0, 8
        v_cmp_lg_i32    s[22:23], v41, 0
        s_mov_b64       s[36:37], exec
        s_andn2_b64     exec, s[36:37], s[22:23]
        v_alignbit_b32  v41, v19, v19, 2
        s_cbranch_execz .L11748_1
        v_add_i32       v39, vcc, 0x98badcfe, v41
        v_lshlrev_b32   v42, 8, v9
        v_add_i32       v42, vcc, 0x306d5f00, v42
        v_lshrrev_b32   v43, 24, v39
        s_mov_b32       s6, 0x3fffff00
        v_bfi_b32       v42, s6, v42, v43
        v_lshrrev_b32   v43, 6, v42
        v_add_i32       v43, vcc, s7, v43
        buffer_load_ubyte v43, v43, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v43
        s_and_saveexec_b64 s[38:39], vcc
        v_mov_b32       v43, 0
        s_cbranch_execz .L11728_1
        ds_read_b32     v43, v43 offset:316
        v_xor_b32       v19, v19, v22
        v_alignbit_b32  v18, v18, v18, 2
        v_xor_b32       v18, v19, v18
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        v_alignbit_b32  v10, v62, v62, 10
        v_add_i32       v18, vcc, v40, v18
        v_alignbit_b32  v9, v9, v9, 27
        v_xor_b32       v10, v48, v10
        v_add_i32       v9, vcc, v18, v9
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v10, v10, v43
        v_add_i32       v9, vcc, v9, v10
        s_buffer_load_dword s6, s[8:11], s4
        v_add_i32       v62, vcc, 0x31a7e4d7, v9
        s_mov_b64       s[40:41], exec
        s_mov_b64       s[42:43], exec
        v_mov_b32       v10, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v7, s6
        v_mov_b32       v19, s0
        s_movk_i32      s44, 0x0
        s_movk_i32      s45, 0x0
.L11604_1:
        v_cmp_gt_i32    s[46:47], v10, v19
        v_cmp_eq_i32    vcc, v42, v7
        s_andn2_b64     s[44:45], s[44:45], exec
        s_or_b64        s[44:45], vcc, s[44:45]
        s_or_b64        vcc, s[46:47], vcc
        s_and_saveexec_b64 s[46:47], vcc
        s_andn2_b64     s[42:43], s[42:43], exec
        s_cbranch_scc0  .L11696_1
        s_and_b64       exec, s[46:47], s[42:43]
        v_add_i32       v18, vcc, v10, v19
        v_ashrrev_i32   v18, 1, v18
        v_lshlrev_b32   v22, 2, v18
        v_add_i32       v22, vcc, s4, v22
        v_add_i32       v40, vcc, -1, v18
        v_add_i32       v18, vcc, 1, v18
        tbuffer_load_format_x v7, v22, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v7, v42
        v_cndmask_b32   v19, v19, v40, vcc
        v_cndmask_b32   v10, v18, v10, vcc
        s_branch        .L11604_1
.L11696_1:
        s_mov_b64       exec, s[40:41]
        s_and_saveexec_b64 s[40:41], s[44:45]
        v_mov_b32       v6, 1
        s_cbranch_execz .L11720_1
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L11784_1
.L11720_1:
        s_and_b64       exec, s[40:41], s[18:19]
        v_mov_b32       v6, 1
.L11728_1:
        s_andn2_b64     exec, s[38:39], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32       v6, 0
        s_cbranch_execz .L11744_1
.L11744_1:
        s_and_b64       exec, s[38:39], s[18:19]
.L11748_1:
        s_andn2_b64     exec, s[36:37], exec
        s_and_b64       exec, exec, s[18:19]
        v_cndmask_b32   v39, 0, -1, s[22:23]
        s_cbranch_execz .L11772_1
        v_mov_b32       v6, 0
.L11772_1:
        s_and_b64       exec, s[36:37], s[18:19]
        s_add_u32       s5, s5, 1
        s_branch        .L6964_1
.L11784_1:
        s_mov_b64       exec, s[16:17]
        v_cmp_eq_i32    vcc, 0, v6
        s_and_saveexec_b64 s[6:7], vcc
        v_mov_b32       v0, 0x400
        s_cbranch_execz .L11816_1
        tbuffer_store_format_x v0, v5, s[24:27], 0 offen format:[32,float]
.L11816_1:
        s_andn2_b64     exec, s[6:7], exec
        s_cbranch_execz .L12304_1
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_lshrrev_b32   v8, 26, v62
        v_add_i32       v8, vcc, s1, v8
        v_bfe_u32       v10, v62, 20, 6
        v_add_i32       v10, vcc, s1, v10
        v_bfe_u32       v11, v62, 14, 6
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v8, v8, s[8:11], 0 offen
        v_add_i32       v11, vcc, s1, v11
        v_bfe_u32       v12, v62, 8, 6
        buffer_load_ubyte v10, v10, s[8:11], 0 offen
        v_add_i32       v12, vcc, s1, v12
        v_bfe_u32       v14, v62, 2, 6
        v_lshrrev_b32   v15, 28, v44
        v_lshlrev_b32   v1, 4, v62
        buffer_load_ubyte v11, v11, s[8:11], 0 offen
        v_add_i32       v14, vcc, s1, v14
        v_bfi_b32       v1, 48, v1, v15
        buffer_load_ubyte v12, v12, s[8:11], 0 offen
        v_add_i32       v1, vcc, s1, v1
        v_bfe_u32       v15, v44, 22, 6
        buffer_load_ubyte v14, v14, s[8:11], 0 offen
        v_add_i32       v15, vcc, s1, v15
        v_bfe_u32       v16, v44, 16, 6
        buffer_load_ubyte v1, v1, s[8:11], 0 offen
        v_add_i32       v16, vcc, s1, v16
        v_bfe_u32       v17, v44, 10, 6
        buffer_load_ubyte v15, v15, s[8:11], 0 offen
        v_add_i32       v17, vcc, s1, v17
        v_bfe_u32       v18, v44, 4, 6
        v_lshrrev_b32   v19, 30, v39
        v_lshlrev_b32   v6, 2, v44
        buffer_load_ubyte v16, v16, s[8:11], 0 offen
        v_add_i32       v18, vcc, s1, v18
        v_bfi_b32       v6, 60, v6, v19
        buffer_load_ubyte v17, v17, s[8:11], 0 offen
        v_add_i32       v6, vcc, s1, v6
        v_bfe_u32       v9, v39, 24, 6
        buffer_load_ubyte v18, v18, s[8:11], 0 offen
        v_add_i32       v9, vcc, s1, v9
        s_nop           0x0
        buffer_load_ubyte v6, v6, s[8:11], 0 offen
        buffer_load_ubyte v9, v9, s[8:11], 0 offen
        v_bfe_u32       v4, v4, 0, 8
        v_bfe_u32       v7, v63, 0, 8
        v_bfe_u32       v0, v61, 0, 8
        v_bfe_u32       v13, v13, 0, 8
        buffer_store_byte v4, v5, s[24:27], 0 offen offset:17 glc
        v_bfe_u32       v3, v3, 0, 8
        buffer_store_byte v2, v5, s[24:27], 0 offen offset:18 glc
        buffer_store_byte v7, v5, s[24:27], 0 offen offset:19 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:20 glc
        buffer_store_byte v13, v5, s[24:27], 0 offen offset:24 glc
        buffer_store_byte v3, v5, s[24:27], 0 offen offset:28 glc
        buffer_store_byte v8, v5, s[24:27], 0 offen offset:5 glc
        buffer_store_byte v10, v5, s[24:27], 0 offen offset:6 glc
        buffer_store_byte v11, v5, s[24:27], 0 offen offset:7 glc
        buffer_store_byte v12, v5, s[24:27], 0 offen offset:8 glc
        buffer_store_byte v14, v5, s[24:27], 0 offen offset:9 glc
        buffer_store_byte v1, v5, s[24:27], 0 offen offset:10 glc
        buffer_store_byte v15, v5, s[24:27], 0 offen offset:11 glc
        buffer_store_byte v16, v5, s[24:27], 0 offen offset:12 glc
        buffer_store_byte v17, v5, s[24:27], 0 offen offset:13 glc
        v_mov_b32       v0, 1
        s_add_u32       s0, s5, 1
        buffer_store_byte v18, v5, s[24:27], 0 offen offset:14 glc
        s_waitcnt       expcnt(4)
        v_mov_b32       v1, s0
        buffer_store_byte v6, v5, s[24:27], 0 offen offset:15 glc
        buffer_store_byte v9, v5, s[24:27], 0 offen offset:16 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:4 glc
        tbuffer_store_format_x v1, v5, s[24:27], 0 offen format:[32,float]
.L12304_1:
        s_endpgm



.kernel OpenCL_SHA1_PerformSearching_Flexible
	.config

    .dims x	
	.driver_version 200460

	.arg outputArray,              structure*, 32,  global
	.arg key,                      uchar*,          global, const
	.arg tripcodeChunkArray,       uint*,           global
	.arg numTripcodeChunk,         uint
	.arg keyCharTable_OneByte,         uchar*,          global, const
	.arg keyCharTable_FirstByte,         uchar*,          global, const
	.arg keyCharTable_SecondByte,         uchar*,          global, const
	.arg keyCharTable_SecondByteAndOneByte,         uchar*,          global, const
	.arg smallChunkBitmap,         uchar*,          global, const
	.arg chunkBitmap,              uchar*,          global

	.useconstdata
    .userdata PTR_UAV_TABLE,0,2,2
    .userdata IMM_CONST_BUFFER,0,4,4
    .userdata IMM_CONST_BUFFER,1,8,4
	.localsize 4416

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
        s_buffer_load_dword s15, s[8:11], 0x0
        s_waitcnt       lgkmcnt(0)
        s_min_u32       s1, s1, 0xffff
        s_buffer_load_dword s20, s[8:11], 0x14
        s_buffer_load_dword s21, s[8:11], 0x1c
        s_mul_i32       s1, s12, s1
        s_add_u32       s1, s1, s13
        v_add_i32       v5, vcc, s1, v0
        s_load_dwordx4  s[24:27], s[2:3], 0x60
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x80
        s_add_u32       s1, s12, s14
        v_lshlrev_b32   v5, 5, v5
        v_add_i32       v5, vcc, s15, v5
        v_mov_b32       v6, 0
        s_ashr_i32      s12, s1, 6
        v_and_b32       v7, 63, v0
        s_and_b32       s1, s1, 63
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s12, s12, s21
        s_waitcnt       vmcnt(2)
        v_add_i32       v2, vcc, v2, v7
        s_add_u32       s1, s1, s20
        s_waitcnt       vmcnt(1)
        v_add_i32       v3, vcc, s12, v3
        v_add_i32       v2, vcc, s21, v2
        s_waitcnt       vmcnt(0)
        v_add_i32       v4, vcc, s1, v4
        buffer_load_ubyte v7, v1, s[16:19], 0 offen offset:2
        buffer_load_ubyte v1, v1, s[16:19], 0 offen offset:3
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
        s_cbranch_execz .L4196_2
        s_load_dwordx4  s[12:15], s[2:3], 0x88
        s_movk_i32      s10, 0x0
        s_movk_i32      s11, 0x100
.L268_2:
        s_cmp_gt_u32    s11, 0
        s_cbranch_scc0  .L4196_2
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s22, s6, s10
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s22
        v_mov_b32       v8, s10
        s_add_u32       s22, s10, 1
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 2
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 3
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 4
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 5
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 6
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 7
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 8
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 9
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 10
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 11
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 12
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 13
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 14
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 15
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 16
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 17
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 18
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 19
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 20
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 21
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 22
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 23
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 24
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 25
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 26
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 27
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 28
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 29
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 30
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 31
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 32
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 33
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 34
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 35
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 36
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 37
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 38
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 39
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 40
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 41
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 42
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 43
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 44
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 45
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 46
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 47
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 48
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 49
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 50
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 51
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 52
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 53
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 54
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 55
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 56
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 57
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 58
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 59
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 60
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 61
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 62
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 63
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 64
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x41
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x42
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x43
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x44
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x45
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x46
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x47
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x48
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x49
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x4a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x4b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x4c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x4d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x4e
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x4f
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 0x50
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x51
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x52
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x53
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x54
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x55
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x56
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x57
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x58
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x59
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x5a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x5b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x5c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x5d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x5e
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x5f
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 0x60
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x61
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x62
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x63
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x64
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x65
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x66
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x67
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x68
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x69
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x6a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x6b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x6c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x6d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x6e
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x6f
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s22, s10, 0x70
        s_add_u32       s23, s6, s22
        v_mov_b32       v6, s23
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x71
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x72
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x73
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x74
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x75
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x76
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x77
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x78
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x79
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x7a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x7b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x7c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x7d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x7e
        v_mov_b32       v14, s22
        s_add_u32       s22, s10, 0x7f
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:15
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
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 0x80
        s_sub_i32       s11, s11, 8
        s_branch        .L268_2
.L4196_2:
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
        ds_read2_b32    v[18:19], v11 offset0:10 offset1:11
        v_xor_b32       v10, v10, v15
        ds_read2_b32    v[20:21], v11 offset0:14 offset1:16
        ds_read2_b32    v[22:23], v11 offset0:12 offset1:13
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v24, v6, v16
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v18, v18, v24
        v_xor_b32       v24, v9, v10
        v_xor_b32       v25, v17, v8
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v19, v19, v24
        v_alignbit_b32  v24, v25, v25, 31
        v_alignbit_b32  v19, v19, v19, 31
        v_xor_b32       v25, v15, v18
        v_xor_b32       v25, 0x60, v25
        v_xor_b32       v26, v14, v24
        v_xor_b32       v27, v17, v19
        ds_write2_b32   v11, v10, v24 offset0:24 offset1:25
        v_xor_b32       v23, v23, v25
        v_xor_b32       v22, v22, v26
        v_xor_b32       v25, v21, v27
        ds_write2_b32   v11, v18, v19 offset0:26 offset1:27
        v_alignbit_b32  v23, v23, v23, 31
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v20, v20, v25
        ds_write2_b32   v11, v22, v23 offset0:28 offset1:29
        v_alignbit_b32  v20, v20, v20, 31
        ds_write_b32    v12, v20 offset:4216
        ds_read2_b32    v[25:26], v11 offset0:17 offset1:18
        v_xor_b32       v16, v16, v22
        v_xor_b32       v8, v8, v16
        v_xor_b32       v8, 0x60, v8
        v_xor_b32       v16, v23, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v27, v24, v20
        ds_read2_b32    v[28:29], v11 offset0:21 offset1:23
        ds_read2_b32    v[30:31], v11 offset0:19 offset1:20
        v_xor_b32       v6, v6, v16
        v_xor_b32       v9, v9, v27
        v_xor_b32       v16, v18, v8
        v_xor_b32       v6, v21, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v25, v9
        v_xor_b32       v14, v14, v16
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v14, v26, v14
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v16, v22, v9
        v_xor_b32       v21, v19, v6
        v_xor_b32       v16, v17, v16
        v_xor_b32       v15, v15, v21
        v_xor_b32       v21, v23, v14
        ds_write2_b32   v11, v8, v6 offset0:31 offset1:32
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v16, v31, v16
        v_xor_b32       v15, v30, v15
        v_xor_b32       v21, v29, v21
        ds_write2_b32   v11, v9, v14 offset0:33 offset1:34
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v21, v28, v21
        ds_write2_b32   v11, v15, v16 offset0:35 offset1:36
        v_alignbit_b32  v21, v21, v21, 31
        ds_write_b32    v12, v21 offset:4244
        ds_read2_b32    v[25:26], v11 offset0:24 offset1:25
        v_xor_b32       v20, v20, v15
        v_xor_b32       v10, v10, v20
        v_xor_b32       v10, v17, v10
        v_xor_b32       v17, v16, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v20, v6, v21
        ds_read2_b32    v[27:28], v11 offset0:28 offset1:30
        ds_read2_b32    v[30:31], v11 offset0:26 offset1:27
        v_xor_b32       v17, v24, v17
        v_xor_b32       v18, v18, v20
        v_xor_b32       v20, v9, v10
        v_xor_b32       v17, v29, v17
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v18, v25, v18
        v_xor_b32       v19, v19, v20
        v_alignbit_b32  v17, v17, v17, 31
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v19, v26, v19
        v_alignbit_b32  v19, v19, v19, 31
        v_xor_b32       v20, v15, v18
        v_xor_b32       v24, v14, v17
        v_xor_b32       v20, v23, v20
        v_xor_b32       v22, v22, v24
        v_xor_b32       v24, v16, v19
        ds_write2_b32   v11, v10, v17 offset0:38 offset1:39
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v31, v20
        v_xor_b32       v22, v30, v22
        v_xor_b32       v24, v28, v24
        ds_write2_b32   v11, v18, v19 offset0:40 offset1:41
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v24, v27, v24
        ds_write2_b32   v11, v22, v20 offset0:42 offset1:43
        v_alignbit_b32  v24, v24, v24, 31
        ds_write_b32    v12, v24 offset:4272
        ds_read2_b32    v[25:26], v11 offset0:31 offset1:32
        v_xor_b32       v21, v21, v22
        v_xor_b32       v8, v8, v21
        v_xor_b32       v8, v23, v8
        v_xor_b32       v21, v20, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v23, v17, v24
        ds_read2_b32    v[29:30], v11 offset0:35 offset1:37
        ds_read2_b32    v[31:32], v11 offset0:33 offset1:34
        v_xor_b32       v6, v6, v21
        v_xor_b32       v9, v9, v23
        v_xor_b32       v21, v18, v8
        v_xor_b32       v6, v28, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v25, v9
        v_xor_b32       v14, v14, v21
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v14, v26, v14
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v21, v22, v9
        v_xor_b32       v23, v19, v6
        v_xor_b32       v21, v16, v21
        v_xor_b32       v15, v15, v23
        v_xor_b32       v23, v20, v14
        ds_write2_b32   v11, v8, v6 offset0:45 offset1:46
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v21, v32, v21
        v_xor_b32       v15, v31, v15
        v_xor_b32       v23, v30, v23
        ds_write2_b32   v11, v9, v14 offset0:47 offset1:48
        v_alignbit_b32  v21, v21, v21, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v23, v29, v23
        ds_write2_b32   v11, v15, v21 offset0:49 offset1:50
        v_alignbit_b32  v23, v23, v23, 31
        ds_write_b32    v12, v23 offset:4300
        ds_read2_b32    v[25:26], v11 offset0:38 offset1:39
        v_xor_b32       v24, v24, v15
        v_xor_b32       v10, v10, v24
        v_xor_b32       v10, v16, v10
        v_xor_b32       v16, v21, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v24, v6, v23
        ds_read2_b32    v[27:28], v11 offset0:42 offset1:44
        ds_read2_b32    v[31:32], v11 offset0:40 offset1:41
        v_xor_b32       v16, v17, v16
        v_xor_b32       v17, v18, v24
        v_xor_b32       v18, v9, v10
        v_xor_b32       v16, v30, v16
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v17, v25, v17
        v_xor_b32       v18, v19, v18
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v26, v18
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v19, v15, v17
        v_xor_b32       v24, v14, v16
        v_xor_b32       v19, v20, v19
        v_xor_b32       v22, v22, v24
        v_xor_b32       v24, v21, v18
        ds_write2_b32   v11, v10, v16 offset0:52 offset1:53
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v32, v19
        v_xor_b32       v22, v31, v22
        v_xor_b32       v24, v28, v24
        ds_write2_b32   v11, v17, v18 offset0:54 offset1:55
        v_alignbit_b32  v19, v19, v19, 31
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v24, v27, v24
        ds_write2_b32   v11, v22, v19 offset0:56 offset1:57
        v_alignbit_b32  v24, v24, v24, 31
        ds_write_b32    v12, v24 offset:4328
        ds_read2_b32    v[25:26], v11 offset0:45 offset1:46
        v_xor_b32       v23, v23, v22
        v_xor_b32       v8, v8, v23
        v_xor_b32       v8, v20, v8
        v_xor_b32       v20, v19, v10
        v_alignbit_b32  v60, v8, v8, 31
        v_xor_b32       v23, v16, v24
        ds_read2_b32    v[29:30], v11 offset0:49 offset1:51
        ds_read2_b32    v[31:32], v11 offset0:47 offset1:48
        v_xor_b32       v6, v6, v20
        v_xor_b32       v9, v9, v23
        v_xor_b32       v20, v17, v60
        v_xor_b32       v6, v28, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v25, v9
        v_xor_b32       v14, v14, v20
        v_alignbit_b32  v59, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v14, v26, v14
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v20, v22, v9
        v_xor_b32       v23, v18, v59
        v_xor_b32       v20, v21, v20
        v_xor_b32       v15, v15, v23
        v_xor_b32       v23, v19, v14
        ds_write2_b32   v11, v60, v59 offset0:59 offset1:60
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v32, v20
        v_xor_b32       v15, v31, v15
        v_xor_b32       v23, v30, v23
        ds_write2_b32   v11, v9, v14 offset0:61 offset1:62
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v15, v15, v15, 31
        v_xor_b32       v23, v29, v23
        ds_write2_b32   v11, v15, v20 offset0:63 offset1:64
        v_alignbit_b32  v61, v23, v23, 31
        ds_write_b32    v12, v61 offset:4356
        ds_read2_b32    v[25:26], v11 offset0:52 offset1:53
        v_xor_b32       v24, v24, v15
        v_xor_b32       v10, v10, v24
        v_xor_b32       v10, v21, v10
        v_xor_b32       v21, v20, v60
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v24, v59, v61
        ds_read2_b32    v[27:28], v11 offset0:56 offset1:58
        ds_read2_b32    v[31:32], v11 offset0:54 offset1:55
        v_xor_b32       v16, v16, v21
        v_xor_b32       v17, v17, v24
        v_xor_b32       v21, v9, v10
        v_xor_b32       v16, v30, v16
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v17, v25, v17
        v_xor_b32       v18, v18, v21
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v26, v18
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v21, v15, v17
        v_xor_b32       v24, v14, v16
        v_xor_b32       v21, v19, v21
        v_xor_b32       v22, v22, v24
        v_xor_b32       v24, v20, v18
        ds_write2_b32   v11, v10, v16 offset0:66 offset1:67
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v21, v32, v21
        v_xor_b32       v22, v31, v22
        v_xor_b32       v24, v28, v24
        ds_write2_b32   v11, v17, v18 offset0:68 offset1:69
        v_alignbit_b32  v21, v21, v21, 31
        v_alignbit_b32  v22, v22, v22, 31
        v_xor_b32       v24, v27, v24
        ds_write2_b32   v11, v22, v21 offset0:70 offset1:71
        v_alignbit_b32  v24, v24, v24, 31
        ds_write_b32    v12, v24 offset:4384
        ds_read2_b32    v[25:26], v11 offset0:59 offset1:60
        v_xor_b32       v27, v61, v22
        v_xor_b32       v27, v60, v27
        v_xor_b32       v19, v19, v27
        v_xor_b32       v10, v21, v10
        v_alignbit_b32  v19, v19, v19, 31
        v_xor_b32       v16, v16, v24
        ds_read2_b32    v[29:30], v11 offset0:63 offset1:65
        ds_read2_b32    v[31:32], v11 offset0:61 offset1:62
        v_xor_b32       v10, v59, v10
        v_xor_b32       v9, v9, v16
        v_xor_b32       v16, v17, v19
        v_xor_b32       v10, v28, v10
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v25, v9
        v_xor_b32       v14, v14, v16
        v_alignbit_b32  v10, v10, v10, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v14, v26, v14
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v16, v22, v9
        v_xor_b32       v17, v18, v10
        v_xor_b32       v16, v20, v16
        v_xor_b32       v15, v15, v17
        v_xor_b32       v17, v21, v14
        ds_write2_b32   v11, v19, v10 offset0:73 offset1:74
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v10, v32, v16
        v_xor_b32       v15, v31, v15
        v_xor_b32       v16, v30, v17
        ds_write2_b32   v11, v9, v14 offset0:75 offset1:76
        v_alignbit_b32  v9, v10, v10, 31
        v_alignbit_b32  v10, v15, v15, 31
        v_xor_b32       v14, v29, v16
        ds_write2_b32   v11, v10, v9 offset0:77 offset1:78
        v_alignbit_b32  v9, v14, v14, 31
        ds_write_b32    v12, v9 offset:4412
        ds_read2_b32    v[9:10], v11 offset0:1 offset1:2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0x5a827999, v10
        v_add_i32       v9, vcc, 0x5a827999, v9
        ds_write2_b32   v11, v9, v10 offset0:1 offset1:2
        ds_read2_b32    v[9:10], v11 offset0:17 offset1:18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0x5a827999, v10
        v_add_i32       v9, vcc, 0x5a827999, v9
        ds_write2_b32   v11, v9, v10 offset0:17 offset1:18
        ds_read2_b32    v[9:10], v11 offset0:20 offset1:21
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0x6ed9eba1, v10
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write2_b32   v11, v9, v10 offset0:20 offset1:21
        ds_read_b32     v9, v12 offset:4188
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v12, v9 offset:4188
        ds_read2_b32    v[9:10], v11 offset0:26 offset1:27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0x6ed9eba1, v10
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write2_b32   v11, v9, v10 offset0:26 offset1:27
        ds_read_b32     v9, v12 offset:4212
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v12, v9 offset:4212
        ds_read_b32     v9, v12 offset:4228
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v12, v9 offset:4228
        ds_read_b32     v9, v12 offset:4252
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v12, v9 offset:4252
        ds_read_b32     v9, v12 offset:4260
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x8f1bbcdc, v9
        ds_write_b32    v12, v9 offset:4260
        ds_read_b32     v9, v12 offset:4276
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x8f1bbcdc, v9
        ds_write_b32    v12, v9 offset:4276
        ds_read_b32     v9, v12 offset:4308
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x8f1bbcdc, v9
        ds_write_b32    v12, v9 offset:4308
        ds_read_b32     v9, v12 offset:4356
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v12, v9 offset:4356
        ds_read_b32     v9, v12 offset:4372
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v12, v9 offset:4372
        ds_read_b32     v9, v12 offset:4404
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v12, v9 offset:4404
        v_lshrrev_b32   v0, 2, v0
        v_lshlrev_b32   v9, 24, v4
        v_lshlrev_b32   v10, 16, v2
        v_and_b32       v0, 48, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        ds_read2_b32    v[14:15], v11 offset0:38 offset1:39
        ds_read2_b32    v[16:17], v11 offset0:36 offset1:37
        ds_read2_b32    v[18:19], v11 offset0:34 offset1:35
        ds_read2_b32    v[20:21], v11 offset0:32 offset1:33
        ds_read2_b32    v[24:25], v11 offset0:30 offset1:31
        ds_read2_b32    v[26:27], v11 offset0:28 offset1:29
        ds_read2_b32    v[28:29], v11 offset0:26 offset1:27
        ds_read2_b32    v[30:31], v11 offset0:24 offset1:25
        ds_read2_b32    v[32:33], v11 offset0:22 offset1:23
        ds_read2_b32    v[34:35], v11 offset0:20 offset1:21
        ds_read2_b32    v[36:37], v11 offset0:18 offset1:19
        ds_read2_b32    v[11:12], v11 offset0:16 offset1:17
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[12:15], s[2:3], 0x90
        v_or_b32        v9, v9, v10
        v_add_i32       v0, vcc, v7, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        s_add_u32       s0, -1, s5
        s_mov_b64       s[16:17], exec
        s_mov_b64       s[18:19], exec
        v_mov_b32       v6, 0
        v_mov_b32       v71, v1
        v_mov_b32       v74, v11
        v_mov_b32       v57, v38
        v_mov_b32       v58, v38
        v_mov_b32       v7, 0
        v_mov_b32       v72, 0
        v_mov_b32       v42, 0
        v_mov_b32       v43, 0
        v_mov_b32       v73, 0
        v_mov_b32       v44, 0
        v_mov_b32       v45, 0
        v_mov_b32       v46, 0
        v_mov_b32       v49, 0
.L6812_2:
        v_add_f32       v50, v46, v49
        v_add_f32       v50, v45, v50
        v_add_f32       v50, v44, v50
        v_add_f32       v50, v73, v50
        v_add_f32       v50, v43, v50
        v_add_f32       v50, v42, v50
        v_add_f32       v50, v72, v50
        v_add_f32       v50, v7, v50
        v_cmp_eq_u32    vcc, 0, v50
        s_and_saveexec_b64 s[22:23], vcc
        s_andn2_b64     exec, s[22:23], exec
        s_cbranch_execz .L6868_2
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L13552_2
.L6868_2:
        s_and_b64       exec, s[22:23], s[18:19]
        s_movk_i32      s5, 0x3ff
        v_cmp_gt_i32    s[22:23], v6, s5
        v_cndmask_b32   v7, v7, 1.0, s[22:23]
        v_cmp_eq_u32    vcc, 0, v7
        s_and_saveexec_b64 s[36:37], vcc
        v_ashrrev_i32   v8, 6, v6
        s_cbranch_execz .L13528_2
        v_bfe_u32       v10, v0, 0, 8
        v_add_i32       v8, vcc, v10, v8
        v_add_i32       v8, vcc, s20, v8
        v_and_b32       v10, 63, v6
        v_bfe_u32       v22, v1, 0, 8
        v_add_i32       v10, vcc, v22, v10
        buffer_load_ubyte v71, v8, s[28:31], 0 offen
        v_add_i32       v10, vcc, s21, v10
        buffer_load_ubyte v74, v10, s[32:35], 0 offen
        v_mov_b32       v22, 0x1000
        s_waitcnt       vmcnt(0)
        s_barrier
        ds_read2_b32    v[38:39], v22 offset0:1 offset1:2
        v_lshlrev_b32   v23, 8, v71
        v_or_b32        v23, v9, v23
        v_or_b32        v23, v23, v74
        v_add_i32       v40, vcc, 0x9fb498b3, v23
        v_alignbit_b32  v41, v40, v40, 27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v38, vcc, v41, v38
        v_add_i32       v38, vcc, 0xc2e5374, v38
        v_mov_b32       v41, 0x7bf36ae2
        s_mov_b32       s5, 0x59d148c0
        v_bfi_b32       v41, v40, s5, v41
        v_alignbit_b32  v50, v38, v38, 27
        v_add_i32       v41, vcc, v41, v50
        v_add_i32       v39, vcc, v39, v41
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v39, vcc, 0x98badcfe, v39
        v_bfi_b32       v41, v38, v40, s5
        v_alignbit_b32  v50, v39, v39, 27
        v_add_i32       v41, vcc, v50, v41
        v_add_i32       v41, vcc, 0x7bf36ae2, v41
        v_xor_b32       v41, 0x80000000, v41
        v_add_i32       v41, vcc, 0x5a827999, v41
        v_alignbit_b32  v38, v38, v38, 2
        v_alignbit_b32  v50, v41, v41, 27
        v_bfi_b32       v51, v39, v38, v40
        v_add_i32       v50, vcc, v50, v51
        v_add_i32       v50, vcc, 0xb453c259, v50
        v_alignbit_b32  v39, v39, v39, 2
        v_alignbit_b32  v51, v50, v50, 27
        v_bfi_b32       v52, v41, v39, v38
        v_add_i32       v40, vcc, v40, v51
        v_add_i32       v40, vcc, v52, v40
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_alignbit_b32  v41, v41, v41, 2
        v_alignbit_b32  v51, v40, v40, 27
        v_bfi_b32       v52, v50, v41, v39
        v_add_i32       v38, vcc, v38, v51
        v_add_i32       v38, vcc, v52, v38
        v_add_i32       v38, vcc, 0x5a827999, v38
        v_alignbit_b32  v51, v38, v38, 27
        v_alignbit_b32  v50, v50, v50, 2
        v_add_i32       v39, vcc, v39, v51
        v_bfi_b32       v51, v40, v50, v41
        v_add_i32       v39, vcc, v39, v51
        v_add_i32       v39, vcc, 0x5a827999, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_alignbit_b32  v51, v39, v39, 27
        v_bfi_b32       v52, v38, v40, v50
        v_add_i32       v41, vcc, v41, v51
        v_add_i32       v41, vcc, v52, v41
        v_add_i32       v41, vcc, 0x5a827999, v41
        v_alignbit_b32  v38, v38, v38, 2
        v_alignbit_b32  v51, v41, v41, 27
        v_bfi_b32       v52, v39, v38, v40
        v_add_i32       v50, vcc, v50, v51
        v_add_i32       v50, vcc, v52, v50
        v_add_i32       v50, vcc, 0x5a827999, v50
        v_alignbit_b32  v51, v50, v50, 27
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v40, vcc, v40, v51
        v_bfi_b32       v51, v41, v39, v38
        v_add_i32       v40, vcc, v40, v51
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_alignbit_b32  v41, v41, v41, 2
        v_alignbit_b32  v51, v40, v40, 27
        v_bfi_b32       v52, v50, v41, v39
        v_add_i32       v38, vcc, v38, v51
        v_add_i32       v38, vcc, v52, v38
        v_add_i32       v38, vcc, 0x5a827999, v38
        v_alignbit_b32  v50, v50, v50, 2
        v_alignbit_b32  v51, v38, v38, 27
        v_bfi_b32       v52, v40, v50, v41
        v_add_i32       v39, vcc, v39, v51
        v_add_i32       v39, vcc, v52, v39
        v_add_i32       v39, vcc, 0x5a827999, v39
        v_alignbit_b32  v51, v39, v39, 27
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v41, vcc, v41, v51
        v_bfi_b32       v51, v38, v40, v50
        v_add_i32       v41, vcc, v41, v51
        v_add_i32       v41, vcc, 0x5a827999, v41
        v_alignbit_b32  v38, v38, v38, 2
        v_alignbit_b32  v51, v41, v41, 27
        v_bfi_b32       v52, v39, v38, v40
        v_add_i32       v50, vcc, v50, v51
        v_add_i32       v50, vcc, v52, v50
        v_add_i32       v50, vcc, 0x5a827999, v50
        v_alignbit_b32  v39, v39, v39, 2
        v_alignbit_b32  v51, v50, v50, 27
        v_bfi_b32       v52, v41, v39, v38
        v_add_i32       v40, vcc, v40, v51
        v_add_i32       v40, vcc, v52, v40
        v_alignbit_b32  v51, v23, v23, 31
        v_add_i32       v40, vcc, 0x5a8279f9, v40
        v_xor_b32       v51, v11, v51
        v_alignbit_b32  v52, v40, v40, 27
        v_add_i32       v38, vcc, v38, v51
        v_alignbit_b32  v41, v41, v41, 2
        v_add_i32       v38, vcc, v52, v38
        v_bfi_b32       v51, v50, v41, v39
        v_add_i32       v38, vcc, v38, v51
        v_add_i32       v38, vcc, 0x5a827999, v38
        v_alignbit_b32  v50, v50, v50, 2
        v_alignbit_b32  v51, v38, v38, 27
        v_add_i32       v39, vcc, v12, v39
        v_bfi_b32       v52, v40, v50, v41
        v_add_i32       v39, vcc, v51, v39
        v_add_i32       v39, vcc, v52, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_alignbit_b32  v51, v39, v39, 27
        v_add_i32       v41, vcc, v36, v41
        v_bfi_b32       v52, v38, v40, v50
        v_add_i32       v41, vcc, v51, v41
        v_alignbit_b32  v51, v23, v23, 30
        v_add_i32       v41, vcc, v52, v41
        v_xor_b32       v52, v37, v51
        v_alignbit_b32  v53, v41, v41, 27
        v_add_i32       v50, vcc, v50, v52
        v_alignbit_b32  v38, v38, v38, 2
        v_add_i32       v50, vcc, v53, v50
        v_bfi_b32       v52, v39, v38, v40
        v_add_i32       v50, vcc, v50, v52
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v52, v41, v38
        v_add_i32       v50, vcc, 0x5a827999, v50
        v_xor_b32       v52, v39, v52
        v_add_i32       v40, vcc, v34, v40
        v_xor_b32       v53, v50, v39
        v_alignbit_b32  v41, v41, v41, 2
        v_add_i32       v40, vcc, v52, v40
        v_alignbit_b32  v52, v50, v50, 27
        v_xor_b32       v53, v53, v41
        v_add_i32       v38, vcc, v35, v38
        v_add_i32       v40, vcc, v40, v52
        v_alignbit_b32  v52, v23, v23, 29
        v_add_i32       v38, vcc, v53, v38
        v_alignbit_b32  v53, v40, v40, 27
        v_xor_b32       v54, v41, v40
        v_alignbit_b32  v50, v50, v50, 2
        v_xor_b32       v55, v32, v52
        v_add_i32       v38, vcc, v38, v53
        v_xor_b32       v53, v54, v50
        v_add_i32       v39, vcc, v39, v55
        v_alignbit_b32  v54, v38, v38, 27
        v_add_i32       v39, vcc, v53, v39
        v_add_i32       v39, vcc, v54, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v53, v38, v50
        v_add_i32       v39, vcc, 0x6ed9eba1, v39
        v_xor_b32       v53, v40, v53
        v_add_i32       v41, vcc, v33, v41
        v_xor_b32       v54, v39, v40
        v_alignbit_b32  v38, v38, v38, 2
        v_xor_b32       v55, v30, v51
        v_add_i32       v41, vcc, v53, v41
        v_alignbit_b32  v53, v39, v39, 27
        v_xor_b32       v54, v54, v38
        v_add_i32       v50, vcc, v50, v55
        v_add_i32       v41, vcc, v41, v53
        v_add_i32       v50, vcc, v54, v50
        v_alignbit_b32  v53, v41, v41, 27
        v_alignbit_b32  v54, v23, v23, 28
        v_add_i32       v50, vcc, v50, v53
        v_xor_b32       v53, v38, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v55, v31, v54
        v_add_i32       v50, vcc, 0x6ed9eba1, v50
        v_xor_b32       v53, v53, v39
        v_add_i32       v40, vcc, v40, v55
        v_alignbit_b32  v55, v50, v50, 27
        v_add_i32       v40, vcc, v53, v40
        v_add_i32       v40, vcc, v55, v40
        v_alignbit_b32  v41, v41, v41, 2
        v_xor_b32       v53, v50, v39
        v_add_i32       v40, vcc, 0x6ed9eba1, v40
        v_xor_b32       v53, v41, v53
        v_add_i32       v38, vcc, v28, v38
        v_xor_b32       v55, v40, v41
        v_alignbit_b32  v50, v50, v50, 2
        v_add_i32       v38, vcc, v53, v38
        v_alignbit_b32  v53, v40, v40, 27
        v_xor_b32       v55, v55, v50
        v_add_i32       v39, vcc, v29, v39
        v_add_i32       v38, vcc, v38, v53
        v_alignbit_b32  v53, v23, v23, 27
        v_add_i32       v39, vcc, v55, v39
        v_alignbit_b32  v55, v38, v38, 27
        v_xor_b32       v56, v50, v38
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v57, v26, v53
        v_add_i32       v39, vcc, v39, v55
        v_xor_b32       v55, v56, v40
        v_add_i32       v41, vcc, v41, v57
        v_alignbit_b32  v56, v39, v39, 27
        v_add_i32       v41, vcc, v55, v41
        v_add_i32       v41, vcc, v56, v41
        v_alignbit_b32  v38, v38, v38, 2
        v_xor_b32       v55, v39, v40
        v_add_i32       v41, vcc, 0x6ed9eba1, v41
        v_xor_b32       v56, v24, v51
        v_xor_b32       v55, v38, v55
        v_add_i32       v50, vcc, v27, v50
        v_xor_b32       v57, v41, v38
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v56, v54, v56
        v_add_i32       v50, vcc, v55, v50
        v_alignbit_b32  v55, v41, v41, 27
        v_xor_b32       v57, v57, v39
        v_add_i32       v40, vcc, v40, v56
        v_add_i32       v50, vcc, v50, v55
        v_add_i32       v40, vcc, v57, v40
        v_alignbit_b32  v55, v50, v50, 27
        v_alignbit_b32  v56, v23, v23, 26
        v_add_i32       v40, vcc, v40, v55
        v_xor_b32       v55, v39, v50
        v_alignbit_b32  v41, v41, v41, 2
        v_xor_b32       v57, v25, v56
        v_add_i32       v40, vcc, 0x6ed9eba1, v40
        v_xor_b32       v55, v55, v41
        v_add_i32       v38, vcc, v38, v57
        v_alignbit_b32  v57, v40, v40, 27
        v_add_i32       v38, vcc, v55, v38
        v_xor_b32       v51, v20, v51
        v_add_i32       v38, vcc, v57, v38
        v_alignbit_b32  v50, v50, v50, 2
        v_xor_b32       v55, v40, v41
        v_xor_b32       v51, v52, v51
        v_add_i32       v38, vcc, 0x6ed9eba1, v38
        v_xor_b32       v55, v50, v55
        v_add_i32       v39, vcc, v39, v51
        v_add_i32       v39, vcc, v55, v39
        v_alignbit_b32  v51, v38, v38, 27
        v_xor_b32       v55, v38, v50
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v39, vcc, v39, v51
        v_xor_b32       v51, v55, v40
        v_add_i32       v41, vcc, v21, v41
        v_add_i32       v39, vcc, 0x6ed9eba1, v39
        v_alignbit_b32  v55, v23, v23, 25
        v_add_i32       v41, vcc, v51, v41
        v_alignbit_b32  v51, v39, v39, 27
        v_xor_b32       v57, v40, v39
        v_alignbit_b32  v38, v38, v38, 2
        v_xor_b32       v58, v18, v55
        v_add_i32       v41, vcc, v41, v51
        v_xor_b32       v51, v57, v38
        v_add_i32       v50, vcc, v50, v58
        v_alignbit_b32  v57, v41, v41, 27
        v_add_i32       v50, vcc, v51, v50
        v_add_i32       v50, vcc, v57, v50
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v51, v41, v38
        v_xor_b32       v57, v19, v54
        v_add_i32       v50, vcc, 0x6ed9eba1, v50
        v_xor_b32       v51, v39, v51
        v_add_i32       v40, vcc, v40, v57
        v_xor_b32       v57, v54, v56
        v_add_i32       v40, vcc, v51, v40
        v_alignbit_b32  v51, v50, v50, 27
        v_xor_b32       v58, v50, v39
        v_alignbit_b32  v41, v41, v41, 2
        v_xor_b32       v59, v16, v57
        v_add_i32       v40, vcc, v40, v51
        v_xor_b32       v51, v58, v41
        v_add_i32       v38, vcc, v38, v59
        v_add_i32       v40, vcc, 0x6ed9eba1, v40
        v_add_i32       v38, vcc, v51, v38
        v_alignbit_b32  v51, v40, v40, 27
        v_alignbit_b32  v58, v23, v23, 24
        v_add_i32       v38, vcc, v38, v51
        v_xor_b32       v51, v41, v40
        v_alignbit_b32  v50, v50, v50, 2
        v_xor_b32       v59, v17, v58
        v_add_i32       v38, vcc, 0x6ed9eba1, v38
        v_xor_b32       v51, v51, v50
        v_add_i32       v39, vcc, v39, v59
        v_alignbit_b32  v59, v38, v38, 27
        v_add_i32       v39, vcc, v51, v39
        v_add_i32       v39, vcc, v59, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v51, v38, v50
        v_xor_b32       v59, v14, v54
        v_add_i32       v39, vcc, 0x6ed9eba1, v39
        v_xor_b32       v51, v40, v51
        v_add_i32       v41, vcc, v41, v59
        v_add_i32       v41, vcc, v51, v41
        v_alignbit_b32  v51, v39, v39, 27
        v_xor_b32       v59, v39, v40
        v_alignbit_b32  v38, v38, v38, 2
        v_add_i32       v41, vcc, v41, v51
        ds_read2_b32    v[60:61], v22 offset0:40 offset1:41
        v_xor_b32       v51, v59, v38
        v_add_i32       v50, vcc, v15, v50
        v_add_i32       v41, vcc, 0x6ed9eba1, v41
        v_add_i32       v50, vcc, v51, v50
        v_alignbit_b32  v51, v41, v41, 27
        v_add_i32       v50, vcc, v50, v51
        v_alignbit_b32  v39, v39, v39, 2
        v_bfi_b32       v51, v38, v39, v41
        v_bfi_b32       v59, v39, 0, v41
        v_alignbit_b32  v62, v50, v50, 27
        v_alignbit_b32  v63, v23, v23, 23
        v_xor_b32       v51, v51, v59
        v_add_i32       v40, vcc, v40, v62
        v_xor_b32       v59, v54, v63
        v_add_i32       v40, vcc, v51, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v59, v60
        v_add_i32       v40, vcc, v40, v51
        v_alignbit_b32  v41, v41, v41, 2
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_bfi_b32       v51, v39, v41, v50
        v_bfi_b32       v59, v41, 0, v50
        v_alignbit_b32  v60, v40, v40, 27
        ds_read2_b32    v[62:63], v22 offset0:42 offset1:43
        v_xor_b32       v51, v51, v59
        v_add_i32       v38, vcc, v38, v60
        v_add_i32       v38, vcc, v51, v38
        v_add_i32       v38, vcc, v61, v38
        v_alignbit_b32  v50, v50, v50, 2
        v_bfi_b32       v51, v41, v50, v40
        v_bfi_b32       v59, v50, 0, v40
        v_alignbit_b32  v60, v38, v38, 27
        v_xor_b32       v51, v51, v59
        v_add_i32       v39, vcc, v39, v60
        v_xor_b32       v59, v56, v58
        v_add_i32       v39, vcc, v51, v39
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v62, v59
        v_add_i32       v39, vcc, v39, v51
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_bfi_b32       v51, v50, v40, v38
        v_bfi_b32       v59, v40, 0, v38
        v_alignbit_b32  v60, v39, v39, 27
        v_xor_b32       v51, v51, v59
        v_add_i32       v41, vcc, v41, v60
        v_alignbit_b32  v59, v23, v23, 22
        ds_read2_b32    v[60:61], v22 offset0:44 offset1:45
        v_add_i32       v41, vcc, v51, v41
        v_xor_b32       v51, v63, v59
        v_add_i32       v41, vcc, v41, v51
        v_add_i32       v41, vcc, 0x8f1bbcdc, v41
        v_alignbit_b32  v38, v38, v38, 2
        v_bfi_b32       v51, v40, v38, v39
        v_bfi_b32       v62, v38, 0, v39
        v_alignbit_b32  v63, v41, v41, 27
        v_xor_b32       v64, v52, v56
        v_xor_b32       v51, v51, v62
        v_add_i32       v50, vcc, v50, v63
        v_xor_b32       v62, v55, v64
        v_add_i32       v50, vcc, v51, v50
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v62, v60
        v_add_i32       v50, vcc, v50, v51
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v50, vcc, 0x8f1bbcdc, v50
        v_bfi_b32       v51, v38, v39, v41
        v_bfi_b32       v60, v39, 0, v41
        v_alignbit_b32  v62, v50, v50, 27
        ds_read2_b32    v[63:64], v22 offset0:46 offset1:47
        v_xor_b32       v51, v51, v60
        v_add_i32       v40, vcc, v40, v62
        v_add_i32       v40, vcc, v51, v40
        v_add_i32       v40, vcc, v61, v40
        v_alignbit_b32  v41, v41, v41, 2
        v_bfi_b32       v51, v39, v41, v50
        v_bfi_b32       v60, v41, 0, v50
        v_alignbit_b32  v61, v40, v40, 27
        v_alignbit_b32  v62, v23, v23, 21
        v_xor_b32       v51, v51, v60
        v_add_i32       v38, vcc, v38, v61
        v_xor_b32       v60, v54, v62
        v_add_i32       v38, vcc, v51, v38
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v63, v60
        v_add_i32       v38, vcc, v38, v51
        v_alignbit_b32  v50, v50, v50, 2
        v_add_i32       v38, vcc, 0x8f1bbcdc, v38
        v_bfi_b32       v51, v41, v50, v40
        v_bfi_b32       v60, v50, 0, v40
        v_alignbit_b32  v61, v38, v38, 27
        v_xor_b32       v51, v51, v60
        v_add_i32       v39, vcc, v39, v61
        v_xor_b32       v60, v54, v58
        ds_read2_b32    v[65:66], v22 offset0:48 offset1:49
        v_add_i32       v39, vcc, v51, v39
        v_xor_b32       v51, v64, v60
        v_add_i32       v39, vcc, v39, v51
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v51, v52, v53
        v_bfi_b32       v52, v50, v40, v38
        v_bfi_b32       v61, v40, 0, v38
        v_alignbit_b32  v63, v39, v39, 27
        v_xor_b32       v51, v60, v51
        v_xor_b32       v52, v52, v61
        v_add_i32       v41, vcc, v41, v63
        v_xor_b32       v51, v59, v51
        v_add_i32       v41, vcc, v52, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v51, v65
        v_add_i32       v41, vcc, v41, v51
        v_alignbit_b32  v38, v38, v38, 2
        v_add_i32       v41, vcc, 0x8f1bbcdc, v41
        v_bfi_b32       v51, v40, v38, v39
        v_bfi_b32       v52, v38, 0, v39
        v_alignbit_b32  v61, v41, v41, 27
        v_xor_b32       v51, v51, v52
        v_add_i32       v50, vcc, v50, v61
        v_alignbit_b32  v52, v23, v23, 20
        ds_read2_b32    v[63:64], v22 offset0:50 offset1:51
        v_add_i32       v50, vcc, v51, v50
        v_xor_b32       v51, v66, v52
        v_add_i32       v50, vcc, v50, v51
        v_add_i32       v50, vcc, 0x8f1bbcdc, v50
        v_alignbit_b32  v39, v39, v39, 2
        v_bfi_b32       v51, v38, v39, v41
        v_bfi_b32       v61, v39, 0, v41
        v_alignbit_b32  v65, v50, v50, 27
        v_xor_b32       v51, v51, v61
        v_add_i32       v40, vcc, v40, v65
        v_add_i32       v40, vcc, v51, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v58, v63
        v_add_i32       v40, vcc, v40, v51
        v_alignbit_b32  v41, v41, v41, 2
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_bfi_b32       v51, v39, v41, v50
        v_bfi_b32       v61, v41, 0, v50
        v_alignbit_b32  v63, v40, v40, 27
        v_xor_b32       v51, v51, v61
        v_add_i32       v38, vcc, v38, v63
        ds_read2_b32    v[65:66], v22 offset0:52 offset1:53
        v_add_i32       v38, vcc, v51, v38
        v_xor_b32       v51, v57, v64
        v_add_i32       v38, vcc, v38, v51
        v_add_i32       v38, vcc, 0x8f1bbcdc, v38
        v_alignbit_b32  v50, v50, v50, 2
        v_bfi_b32       v51, v41, v50, v40
        v_bfi_b32       v61, v50, 0, v40
        v_alignbit_b32  v63, v38, v38, 27
        v_alignbit_b32  v64, v23, v23, 19
        v_xor_b32       v51, v51, v61
        v_add_i32       v39, vcc, v39, v63
        v_xor_b32       v61, v60, v64
        v_add_i32       v39, vcc, v51, v39
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v61, v65
        v_add_i32       v39, vcc, v39, v51
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_bfi_b32       v51, v50, v40, v38
        v_bfi_b32       v61, v40, 0, v38
        v_alignbit_b32  v63, v39, v39, 27
        ds_read2_b32    v[67:68], v22 offset0:54 offset1:55
        v_xor_b32       v51, v51, v61
        v_add_i32       v41, vcc, v41, v63
        v_add_i32       v41, vcc, v51, v41
        v_add_i32       v41, vcc, v66, v41
        v_alignbit_b32  v38, v38, v38, 2
        v_bfi_b32       v51, v40, v38, v39
        v_bfi_b32       v61, v38, 0, v39
        v_alignbit_b32  v63, v41, v41, 27
        v_xor_b32       v65, v55, v59
        v_xor_b32       v51, v51, v61
        v_add_i32       v50, vcc, v50, v63
        v_xor_b32       v61, v52, v65
        v_add_i32       v50, vcc, v51, v50
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v61, v67
        v_add_i32       v50, vcc, v50, v51
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v50, vcc, 0x8f1bbcdc, v50
        v_bfi_b32       v51, v38, v39, v41
        v_bfi_b32       v61, v39, 0, v41
        v_alignbit_b32  v63, v50, v50, 27
        v_xor_b32       v51, v51, v61
        v_add_i32       v40, vcc, v40, v63
        v_alignbit_b32  v61, v23, v23, 18
        ds_read2_b32    v[65:66], v22 offset0:56 offset1:57
        v_add_i32       v40, vcc, v51, v40
        v_xor_b32       v51, v61, v68
        v_add_i32       v40, vcc, v40, v51
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_alignbit_b32  v41, v41, v41, 2
        v_xor_b32       v51, v55, v57
        v_bfi_b32       v63, v39, v41, v50
        v_bfi_b32       v67, v41, 0, v50
        v_alignbit_b32  v68, v40, v40, 27
        v_xor_b32       v59, v59, v51
        v_xor_b32       v63, v63, v67
        v_add_i32       v38, vcc, v38, v68
        v_xor_b32       v59, v62, v59
        v_add_i32       v38, vcc, v63, v38
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v59, v59, v65
        v_add_i32       v38, vcc, v38, v59
        v_alignbit_b32  v50, v50, v50, 2
        v_add_i32       v38, vcc, 0x8f1bbcdc, v38
        v_bfi_b32       v59, v41, v50, v40
        v_bfi_b32       v63, v50, 0, v40
        v_alignbit_b32  v65, v38, v38, 27
        v_xor_b32       v59, v59, v63
        v_add_i32       v39, vcc, v39, v65
        ds_read2_b32    v[67:68], v22 offset0:58 offset1:59
        v_add_i32       v39, vcc, v59, v39
        v_xor_b32       v59, v58, v66
        v_add_i32       v39, vcc, v39, v59
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_bfi_b32       v59, v50, v40, v38
        v_bfi_b32       v63, v40, 0, v38
        v_alignbit_b32  v65, v39, v39, 27
        v_alignbit_b32  v66, v23, v23, 17
        v_xor_b32       v59, v59, v63
        v_add_i32       v41, vcc, v41, v65
        v_xor_b32       v60, v60, v66
        v_add_i32       v41, vcc, v59, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v59, v60, v67
        v_add_i32       v41, vcc, v41, v59
        v_alignbit_b32  v38, v38, v38, 2
        v_add_i32       v41, vcc, 0x8f1bbcdc, v41
        v_bfi_b32       v59, v40, v38, v39
        v_bfi_b32       v60, v38, 0, v39
        v_alignbit_b32  v63, v41, v41, 27
        ds_read2_b32    v[69:70], v22 offset0:60 offset1:61
        v_xor_b32       v59, v59, v60
        v_add_i32       v50, vcc, v50, v63
        v_xor_b32       v60, v58, v52
        v_add_i32       v50, vcc, v59, v50
        v_xor_b32       v59, v60, v68
        v_add_i32       v50, vcc, v50, v59
        v_xor_b32       v59, v38, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v54, v54, v55
        v_add_i32       v50, vcc, 0x8f1bbcdc, v50
        v_xor_b32       v59, v59, v39
        v_xor_b32       v54, v60, v54
        v_alignbit_b32  v63, v50, v50, 27
        v_add_i32       v40, vcc, v40, v59
        v_xor_b32       v54, v61, v54
        v_add_i32       v40, vcc, v63, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v54, v54, v69
        v_add_i32       v40, vcc, v40, v54
        v_alignbit_b32  v41, v41, v41, 2
        v_xor_b32       v54, v50, v39
        v_add_i32       v40, vcc, 0xca62c1d6, v40
        v_xor_b32       v54, v41, v54
        ds_read2_b32    v[67:68], v22 offset0:62 offset1:63
        v_add_i32       v38, vcc, v38, v54
        v_alignbit_b32  v54, v40, v40, 27
        v_alignbit_b32  v59, v23, v23, 16
        v_add_i32       v38, vcc, v38, v54
        v_xor_b32       v54, v59, v70
        v_xor_b32       v63, v40, v41
        v_alignbit_b32  v50, v50, v50, 2
        v_add_i32       v38, vcc, v38, v54
        v_xor_b32       v54, v63, v50
        v_add_i32       v38, vcc, 0xca62c1d6, v38
        v_add_i32       v39, vcc, v39, v54
        v_alignbit_b32  v54, v38, v38, 27
        v_xor_b32       v57, v57, v60
        v_add_i32       v39, vcc, v39, v54
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v54, v57, v67
        v_add_i32       v39, vcc, v39, v54
        v_xor_b32       v54, v50, v38
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v39, vcc, 0xca62c1d6, v39
        v_xor_b32       v54, v54, v40
        ds_read2_b32    v[69:70], v22 offset0:64 offset1:65
        v_alignbit_b32  v57, v39, v39, 27
        v_add_i32       v41, vcc, v41, v54
        v_add_i32       v41, vcc, v57, v41
        v_xor_b32       v54, v58, v68
        v_add_i32       v41, vcc, v41, v54
        v_alignbit_b32  v38, v38, v38, 2
        v_xor_b32       v54, v39, v40
        v_add_i32       v41, vcc, 0xca62c1d6, v41
        v_xor_b32       v54, v38, v54
        v_xor_b32       v51, v51, v60
        v_alignbit_b32  v57, v23, v23, 15
        v_add_i32       v50, vcc, v50, v54
        v_alignbit_b32  v54, v41, v41, 27
        v_xor_b32       v51, v51, v57
        v_add_i32       v50, vcc, v50, v54
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v51, v69
        v_xor_b32       v54, v41, v38
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v50, vcc, v50, v51
        ds_read2_b32    v[67:68], v22 offset0:66 offset1:67
        v_xor_b32       v51, v54, v39
        v_add_i32       v50, vcc, 0xca62c1d6, v50
        v_add_i32       v40, vcc, v40, v51
        v_alignbit_b32  v51, v50, v50, 27
        v_add_i32       v40, vcc, v40, v51
        v_xor_b32       v51, v39, v50
        v_alignbit_b32  v41, v41, v41, 2
        v_add_i32       v40, vcc, v40, v70
        v_xor_b32       v51, v51, v41
        v_alignbit_b32  v54, v40, v40, 27
        v_add_i32       v38, vcc, v38, v51
        v_xor_b32       v51, v61, v59
        v_add_i32       v38, vcc, v54, v38
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v51, v67
        v_add_i32       v38, vcc, v38, v51
        v_alignbit_b32  v50, v50, v50, 2
        v_xor_b32       v51, v40, v41
        v_add_i32       v38, vcc, 0xca62c1d6, v38
        v_xor_b32       v51, v50, v51
        v_alignbit_b32  v54, v23, v23, 14
        ds_read2_b32    v[69:70], v22 offset0:68 offset1:69
        v_add_i32       v39, vcc, v39, v51
        v_alignbit_b32  v51, v38, v38, 27
        v_xor_b32       v57, v58, v54
        v_add_i32       v39, vcc, v39, v51
        v_xor_b32       v51, v57, v68
        v_xor_b32       v57, v38, v50
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v39, vcc, v39, v51
        v_xor_b32       v51, v57, v40
        v_add_i32       v39, vcc, 0xca62c1d6, v39
        v_xor_b32       v57, v62, v61
        v_add_i32       v41, vcc, v41, v51
        v_alignbit_b32  v51, v39, v39, 27
        v_xor_b32       v57, v66, v57
        v_add_i32       v41, vcc, v41, v51
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v57, v69
        v_add_i32       v41, vcc, v41, v51
        v_xor_b32       v51, v40, v39
        v_alignbit_b32  v38, v38, v38, 2
        ds_read2_b32    v[67:68], v22 offset0:70 offset1:71
        v_add_i32       v41, vcc, 0xca62c1d6, v41
        v_xor_b32       v51, v51, v38
        v_alignbit_b32  v57, v41, v41, 27
        v_add_i32       v50, vcc, v50, v51
        v_add_i32       v50, vcc, v57, v50
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v51, v41, v38
        v_add_i32       v50, vcc, v50, v70
        v_xor_b32       v51, v39, v51
        v_alignbit_b32  v57, v23, v23, 13
        v_add_i32       v40, vcc, v40, v51
        v_alignbit_b32  v51, v50, v50, 27
        v_xor_b32       v57, v52, v57
        v_add_i32       v40, vcc, v40, v51
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v57, v67
        v_xor_b32       v57, v50, v39
        v_alignbit_b32  v41, v41, v41, 2
        v_add_i32       v40, vcc, v40, v51
        v_xor_b32       v51, v57, v41
        v_add_i32       v40, vcc, 0xca62c1d6, v40
        ds_read2_b32    v[69:70], v22 offset0:72 offset1:73
        v_add_i32       v38, vcc, v38, v51
        v_alignbit_b32  v51, v40, v40, 27
        v_xor_b32       v57, v52, v59
        v_xor_b32       v53, v53, v62
        v_add_i32       v38, vcc, v38, v51
        v_xor_b32       v51, v57, v68
        v_xor_b32       v53, v52, v53
        v_add_i32       v38, vcc, v38, v51
        v_xor_b32       v51, v41, v40
        v_alignbit_b32  v50, v50, v50, 2
        v_xor_b32       v53, v64, v53
        v_add_i32       v38, vcc, 0xca62c1d6, v38
        v_xor_b32       v51, v51, v50
        v_xor_b32       v53, v59, v53
        v_alignbit_b32  v57, v38, v38, 27
        v_add_i32       v39, vcc, v39, v51
        v_xor_b32       v51, v54, v53
        v_add_i32       v39, vcc, v57, v39
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v51, v69
        v_add_i32       v39, vcc, v39, v51
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v51, v38, v50
        v_add_i32       v39, vcc, 0xca62c1d6, v39
        v_xor_b32       v51, v40, v51
        ds_read2_b32    v[62:63], v22 offset0:74 offset1:75
        v_add_i32       v41, vcc, v41, v51
        v_alignbit_b32  v51, v39, v39, 27
        v_alignbit_b32  v53, v23, v23, 12
        v_add_i32       v41, vcc, v41, v51
        v_xor_b32       v51, v53, v70
        v_xor_b32       v57, v39, v40
        v_alignbit_b32  v38, v38, v38, 2
        v_add_i32       v41, vcc, v41, v51
        v_xor_b32       v51, v57, v38
        v_add_i32       v41, vcc, 0xca62c1d6, v41
        v_add_i32       v50, vcc, v50, v51
        v_alignbit_b32  v51, v41, v41, 27
        v_xor_b32       v57, v58, v59
        v_add_i32       v50, vcc, v50, v51
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v57, v62
        v_add_i32       v50, vcc, v50, v51
        v_xor_b32       v51, v38, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v50, vcc, 0xca62c1d6, v50
        v_xor_b32       v51, v51, v39
        v_xor_b32       v56, v56, v52
        ds_read2_b32    v[64:65], v22 offset0:76 offset1:77
        v_alignbit_b32  v57, v50, v50, 27
        v_add_i32       v40, vcc, v40, v51
        v_xor_b32       v51, v61, v56
        v_add_i32       v40, vcc, v57, v40
        v_xor_b32       v51, v51, v63
        v_xor_b32       v55, v55, v58
        v_add_i32       v40, vcc, v40, v51
        v_alignbit_b32  v41, v41, v41, 2
        v_xor_b32       v51, v50, v39
        v_xor_b32       v52, v52, v55
        v_add_i32       v40, vcc, 0xca62c1d6, v40
        v_xor_b32       v51, v41, v51
        v_xor_b32       v52, v59, v52
        v_alignbit_b32  v56, v23, v23, 11
        v_add_i32       v38, vcc, v38, v51
        v_alignbit_b32  v51, v40, v40, 27
        v_xor_b32       v52, v52, v56
        v_add_i32       v38, vcc, v38, v51
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v51, v52, v64
        v_xor_b32       v52, v40, v41
        v_alignbit_b32  v50, v50, v50, 2
        v_add_i32       v38, vcc, v38, v51
        ds_read2_b32    v[56:57], v22 offset0:78 offset1:79
        v_xor_b32       v22, v52, v50
        v_add_i32       v38, vcc, 0xca62c1d6, v38
        v_add_i32       v22, vcc, v39, v22
        v_alignbit_b32  v39, v38, v38, 27
        v_add_i32       v22, vcc, v22, v39
        v_alignbit_b32  v39, v40, v40, 2
        v_xor_b32       v40, v50, v38
        v_xor_b32       v51, v66, v55
        v_add_i32       v22, vcc, v22, v65
        v_xor_b32       v40, v39, v40
        v_xor_b32       v51, v54, v51
        v_alignbit_b32  v52, v22, v22, 27
        v_add_i32       v40, vcc, v41, v40
        v_xor_b32       v41, v53, v51
        v_add_i32       v40, vcc, v52, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v56
        v_xor_b32       v39, v22, v39
        v_alignbit_b32  v38, v38, v38, 2
        v_add_i32       v40, vcc, v40, v41
        v_xor_b32       v38, v39, v38
        v_add_i32       v39, vcc, 0xca62c1d6, v40
        v_alignbit_b32  v23, v23, v23, 10
        v_add_i32       v38, vcc, v50, v38
        v_alignbit_b32  v39, v39, v39, 27
        v_xor_b32       v23, v58, v23
        v_add_i32       v38, vcc, v38, v39
        v_xor_b32       v23, v23, v57
        v_add_i32       v23, vcc, v38, v23
        v_add_i32       v61, vcc, 0x31a7e4d7, v23
        v_lshrrev_b32   v39, 20, v61
        ds_read_u8      v39, v39
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v39, v39, 0, 8
        v_alignbit_b32  v22, v22, v22, 2
        v_lshrrev_b32   v41, 2, v61
        v_cmp_lg_i32    s[38:39], v39, 0
        v_add_i32       v59, vcc, 0x98badcfe, v22
        v_add_i32       v60, vcc, 0xba306d5f, v40
        s_mov_b64       s[40:41], exec
        s_andn2_b64     exec, s[40:41], s[38:39]
        v_lshrrev_b32   v50, 8, v61
        s_cbranch_execz .L11604_2
        v_add_i32       v50, vcc, s7, v50
        buffer_load_ubyte v50, v50, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[42:43], v50, 0
        s_and_saveexec_b64 s[44:45], s[42:43]
        s_cbranch_execz .L11576_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[46:47], exec
        s_mov_b64       s[48:49], exec
        v_mov_b32       v50, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v58, s5
        v_mov_b32       v52, s0
.L11468_2:
        v_cmp_gt_i32    s[50:51], v50, v52
        v_cmp_eq_i32    vcc, v41, v58
        s_or_b64        vcc, s[50:51], vcc
        s_and_saveexec_b64 s[50:51], vcc
        s_andn2_b64     s[48:49], s[48:49], exec
        s_cbranch_scc0  .L11552_2
        s_and_b64       exec, s[50:51], s[48:49]
        v_add_i32       v51, vcc, v50, v52
        v_ashrrev_i32   v51, 1, v51
        v_lshlrev_b32   v53, 2, v51
        v_add_i32       v53, vcc, s4, v53
        v_add_i32       v54, vcc, -1, v51
        v_add_i32       v51, vcc, 1, v51
        tbuffer_load_format_x v58, v53, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v58, v41
        v_cndmask_b32   v52, v52, v54, vcc
        v_cndmask_b32   v50, v51, v50, vcc
        s_branch        .L11468_2
.L11552_2:
        s_mov_b64       exec, s[46:47]
        v_cmp_lg_i32    vcc, v41, v58
        v_cndmask_b32   v72, 1.0, v72, vcc
        v_cndmask_b32   v57, 0, -1, vcc
        v_mov_b32       v38, 1
.L11576_2:
        s_andn2_b64     exec, s[44:45], exec
        v_cndmask_b32   v57, 0, -1, s[42:43]
        v_cndmask_b32   v58, 0, -1, s[38:39]
        v_mov_b32       v38, 0
        s_mov_b64       exec, s[44:45]
.L11604_2:
        s_andn2_b64     exec, s[40:41], exec
        v_cndmask_b32   v58, 0, -1, s[38:39]
        v_mov_b32       v38, 0
        v_mov_b32       v57, v40
        s_mov_b64       exec, s[40:41]
        v_cmp_eq_u32    vcc, 0, v72
        s_and_b64       exec, s[40:41], vcc
        v_lshrrev_b32   v57, 28, v60
        s_cbranch_execz .L13524_2
        v_lshlrev_b32   v50, 4, v23
        v_add_i32       v58, vcc, 0x1a7e4d70, v50
        v_and_b32       v52, 0x3ffffff0, v58
        v_lshrrev_b32   v53, 18, v52
        ds_read_u8      v53, v53
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v53, v53, 0, 8
        v_cmp_eq_i32    vcc, 0, v53
        s_and_saveexec_b64 s[38:39], vcc
        v_lshrrev_b32   v52, 6, v52
        s_cbranch_execz .L11892_2
        v_add_i32       v52, vcc, s7, v52
        buffer_load_ubyte v52, v52, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v52
        s_and_saveexec_b64 s[42:43], vcc
        s_cbranch_execz .L11892_2
        s_mov_b32       s5, 0x3ffffff0
        v_bfi_b32       v41, s5, v58, v57
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[44:45], exec
        s_mov_b64       s[46:47], exec
        v_mov_b32       v52, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v8, s5
        v_mov_b32       v54, s0
        s_movk_i32      s48, 0x0
        s_movk_i32      s49, 0x0
.L11784_2:
        v_cmp_gt_i32    s[50:51], v52, v54
        v_cmp_eq_i32    vcc, v41, v8
        s_andn2_b64     s[48:49], s[48:49], exec
        s_or_b64        s[48:49], vcc, s[48:49]
        s_or_b64        vcc, s[50:51], vcc
        s_and_saveexec_b64 s[50:51], vcc
        s_andn2_b64     s[46:47], s[46:47], exec
        s_cbranch_scc0  .L11876_2
        s_and_b64       exec, s[50:51], s[46:47]
        v_add_i32       v53, vcc, v52, v54
        v_ashrrev_i32   v53, 1, v53
        v_lshlrev_b32   v55, 2, v53
        v_add_i32       v55, vcc, s4, v55
        v_add_i32       v56, vcc, -1, v53
        v_add_i32       v53, vcc, 1, v53
        tbuffer_load_format_x v8, v55, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v8, v41
        v_cndmask_b32   v54, v54, v56, vcc
        v_cndmask_b32   v52, v53, v52, vcc
        s_branch        .L11784_2
.L11876_2:
        s_mov_b64       exec, s[44:45]
        v_cndmask_b32   v42, v42, 1.0, s[48:49]
        v_mov_b32       v38, 2
.L11892_2:
        s_mov_b64       exec, s[38:39]
        v_cmp_eq_u32    vcc, 0, v42
        s_and_b64       exec, s[38:39], vcc
        v_bfe_u32       v52, v61, 8, 12
        s_cbranch_execz .L13524_2
        ds_read_u8      v52, v52
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v52, v52, 0, 8
        v_cmp_eq_i32    vcc, 0, v52
        s_and_saveexec_b64 s[42:43], vcc
        v_lshrrev_b32   v52, 22, v60
        s_cbranch_execz .L12156_2
        v_lshlrev_b32   v53, 10, v23
        v_add_i32       v53, vcc, 0x9f935c00, v53
        s_mov_b32       s5, 0x3ffffc00
        v_bfi_b32       v52, s5, v53, v52
        v_lshrrev_b32   v53, 6, v52
        v_add_i32       v53, vcc, s7, v53
        buffer_load_ubyte v53, v53, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v53
        s_and_saveexec_b64 s[44:45], vcc
        s_cbranch_execz .L12156_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[46:47], exec
        s_mov_b64       s[48:49], exec
        v_mov_b32       v41, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v8, s5
        v_mov_b32       v54, s0
        s_movk_i32      s50, 0x0
        s_movk_i32      s51, 0x0
.L12048_2:
        v_cmp_gt_i32    s[52:53], v41, v54
        v_cmp_eq_i32    vcc, v52, v8
        s_andn2_b64     s[50:51], s[50:51], exec
        s_or_b64        s[50:51], vcc, s[50:51]
        s_or_b64        vcc, s[52:53], vcc
        s_and_saveexec_b64 s[52:53], vcc
        s_andn2_b64     s[48:49], s[48:49], exec
        s_cbranch_scc0  .L12140_2
        s_and_b64       exec, s[52:53], s[48:49]
        v_add_i32       v53, vcc, v41, v54
        v_ashrrev_i32   v53, 1, v53
        v_lshlrev_b32   v55, 2, v53
        v_add_i32       v55, vcc, s4, v55
        v_add_i32       v56, vcc, -1, v53
        v_add_i32       v53, vcc, 1, v53
        tbuffer_load_format_x v8, v55, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v8, v52
        v_cndmask_b32   v54, v54, v56, vcc
        v_cndmask_b32   v41, v53, v41, vcc
        s_branch        .L12048_2
.L12140_2:
        s_mov_b64       exec, s[46:47]
        v_cndmask_b32   v43, v43, 1.0, s[50:51]
        v_mov_b32       v38, 2
.L12156_2:
        s_mov_b64       exec, s[42:43]
        v_cmp_eq_u32    vcc, 0, v43
        s_and_b64       exec, s[42:43], vcc
        v_bfe_u32       v52, v61, 2, 12
        s_cbranch_execz .L13524_2
        ds_read_u8      v52, v52
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v52, v52, 0, 8
        v_cmp_eq_i32    vcc, 0, v52
        s_and_saveexec_b64 s[44:45], vcc
        v_lshlrev_b32   v52, 16, v23
        s_cbranch_execz .L12420_2
        v_add_i32       v52, vcc, 0xe4d70000, v52
        v_lshrrev_b32   v53, 16, v60
        s_mov_b32       s5, 0x3fff0000
        v_bfi_b32       v52, s5, v52, v53
        v_lshrrev_b32   v53, 6, v52
        v_add_i32       v53, vcc, s7, v53
        buffer_load_ubyte v53, v53, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v53
        s_and_saveexec_b64 s[46:47], vcc
        s_cbranch_execz .L12420_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[48:49], exec
        s_mov_b64       s[50:51], exec
        v_mov_b32       v41, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v8, s5
        v_mov_b32       v54, s0
        s_movk_i32      s52, 0x0
        s_movk_i32      s53, 0x0
.L12312_2:
        v_cmp_gt_i32    s[54:55], v41, v54
        v_cmp_eq_i32    vcc, v52, v8
        s_andn2_b64     s[52:53], s[52:53], exec
        s_or_b64        s[52:53], vcc, s[52:53]
        s_or_b64        vcc, s[54:55], vcc
        s_and_saveexec_b64 s[54:55], vcc
        s_andn2_b64     s[50:51], s[50:51], exec
        s_cbranch_scc0  .L12404_2
        s_and_b64       exec, s[54:55], s[50:51]
        v_add_i32       v53, vcc, v41, v54
        v_ashrrev_i32   v53, 1, v53
        v_lshlrev_b32   v55, 2, v53
        v_add_i32       v55, vcc, s4, v55
        v_add_i32       v56, vcc, -1, v53
        v_add_i32       v53, vcc, 1, v53
        tbuffer_load_format_x v8, v55, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v8, v52
        v_cndmask_b32   v54, v54, v56, vcc
        v_cndmask_b32   v41, v53, v41, vcc
        s_branch        .L12312_2
.L12404_2:
        s_mov_b64       exec, s[48:49]
        v_cndmask_b32   v73, v73, 1.0, s[52:53]
        v_mov_b32       v38, 2
.L12420_2:
        s_mov_b64       exec, s[44:45]
        v_cmp_eq_u32    vcc, 0, v73
        s_and_b64       exec, s[44:45], vcc
        v_lshrrev_b32   v52, 10, v60
        s_cbranch_execz .L13524_2
        v_lshlrev_b32   v53, 22, v23
        v_add_i32       v53, vcc, 0x35c00000, v53
        s_mov_b32       s5, 0x3fc00000
        v_bfi_b32       v52, s5, v53, v52
        v_lshrrev_b32   v53, 18, v52
        ds_read_u8      v53, v53
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v53, v53, 0, 8
        v_cmp_eq_i32    vcc, 0, v53
        s_and_saveexec_b64 s[46:47], vcc
        v_lshrrev_b32   v53, 6, v52
        s_cbranch_execz .L12692_2
        v_add_i32       v53, vcc, s7, v53
        buffer_load_ubyte v53, v53, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v53
        s_and_saveexec_b64 s[48:49], vcc
        s_cbranch_execz .L12692_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[50:51], exec
        s_mov_b64       s[52:53], exec
        v_mov_b32       v41, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v8, s5
        v_mov_b32       v54, s0
        s_movk_i32      s54, 0x0
        s_movk_i32      s55, 0x0
        s_nop           0x0
        s_nop           0x0
        s_nop           0x0
.L12584_2:
        v_cmp_gt_i32    s[56:57], v41, v54
        v_cmp_eq_i32    vcc, v52, v8
        s_andn2_b64     s[54:55], s[54:55], exec
        s_or_b64        s[54:55], vcc, s[54:55]
        s_or_b64        vcc, s[56:57], vcc
        s_and_saveexec_b64 s[56:57], vcc
        s_andn2_b64     s[52:53], s[52:53], exec
        s_cbranch_scc0  .L12676_2
        s_and_b64       exec, s[56:57], s[52:53]
        v_add_i32       v53, vcc, v41, v54
        v_ashrrev_i32   v53, 1, v53
        v_lshlrev_b32   v55, 2, v53
        v_add_i32       v55, vcc, s4, v55
        v_add_i32       v56, vcc, -1, v53
        v_add_i32       v53, vcc, 1, v53
        tbuffer_load_format_x v8, v55, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v8, v52
        v_cndmask_b32   v54, v54, v56, vcc
        v_cndmask_b32   v41, v53, v41, vcc
        s_branch        .L12584_2
.L12676_2:
        s_mov_b64       exec, s[50:51]
        v_cndmask_b32   v44, v44, 1.0, s[54:55]
        v_mov_b32       v38, 2
.L12692_2:
        s_mov_b64       exec, s[46:47]
        v_cmp_eq_u32    vcc, 0, v44
        s_and_b64       exec, s[46:47], vcc
        v_lshrrev_b32   v52, 4, v60
        s_cbranch_execz .L13524_2
        v_lshlrev_b32   v23, 28, v23
        v_add_i32       v23, vcc, 0x70000000, v23
        s_mov_b32       s5, 0x30000000
        v_bfi_b32       v23, s5, v23, v52
        v_lshrrev_b32   v52, 18, v23
        ds_read_u8      v52, v52
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v52, v52, 0, 8
        v_cmp_eq_i32    vcc, 0, v52
        s_and_saveexec_b64 s[48:49], vcc
        v_lshrrev_b32   v52, 6, v23
        s_cbranch_execz .L12964_2
        v_add_i32       v52, vcc, s7, v52
        buffer_load_ubyte v52, v52, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v52
        s_and_saveexec_b64 s[50:51], vcc
        s_cbranch_execz .L12964_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[52:53], exec
        s_mov_b64       s[54:55], exec
        v_mov_b32       v41, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v8, s5
        v_mov_b32       v53, s0
        s_movk_i32      s56, 0x0
        s_movk_i32      s57, 0x0
        s_nop           0x0
        s_nop           0x0
        s_nop           0x0
.L12856_2:
        v_cmp_gt_i32    s[58:59], v41, v53
        v_cmp_eq_i32    vcc, v23, v8
        s_andn2_b64     s[56:57], s[56:57], exec
        s_or_b64        s[56:57], vcc, s[56:57]
        s_or_b64        vcc, s[58:59], vcc
        s_and_saveexec_b64 s[58:59], vcc
        s_andn2_b64     s[54:55], s[54:55], exec
        s_cbranch_scc0  .L12948_2
        s_and_b64       exec, s[58:59], s[54:55]
        v_add_i32       v52, vcc, v41, v53
        v_ashrrev_i32   v52, 1, v52
        v_lshlrev_b32   v54, 2, v52
        v_add_i32       v54, vcc, s4, v54
        v_add_i32       v55, vcc, -1, v52
        v_add_i32       v52, vcc, 1, v52
        tbuffer_load_format_x v8, v54, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v8, v23
        v_cndmask_b32   v53, v53, v55, vcc
        v_cndmask_b32   v41, v52, v41, vcc
        s_branch        .L12856_2
.L12948_2:
        s_mov_b64       exec, s[52:53]
        v_cndmask_b32   v45, v45, 1.0, s[56:57]
        v_mov_b32       v38, 2
.L12964_2:
        s_mov_b64       exec, s[48:49]
        v_cmp_eq_u32    vcc, 0, v45
        s_and_b64       exec, s[48:49], vcc
        v_lshlrev_b32   v47, 2, v40
        s_cbranch_execz .L13524_2
        v_add_i32       v47, vcc, 0xe8c1b57c, v47
        v_and_b32       v52, 0x3ffffffc, v47
        v_lshrrev_b32   v53, 18, v52
        ds_read_u8      v53, v53
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v53, v53, 0, 8
        v_cmp_eq_i32    vcc, 0, v53
        s_and_saveexec_b64 s[50:51], vcc
        v_lshrrev_b32   v52, 6, v52
        s_cbranch_execz .L13236_2
        v_add_i32       v52, vcc, s7, v52
        buffer_load_ubyte v52, v52, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v52
        s_and_saveexec_b64 s[52:53], vcc
        v_lshrrev_b32   v23, 30, v59
        s_cbranch_execz .L13236_2
        s_mov_b32       s5, 0x3ffffffc
        v_bfi_b32       v23, s5, v47, v23
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[54:55], exec
        s_mov_b64       s[56:57], exec
        v_mov_b32       v47, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v8, s5
        v_mov_b32       v53, s0
        s_movk_i32      s58, 0x0
        s_movk_i32      s59, 0x0
        s_nop           0x0
.L13128_2:
        v_cmp_gt_i32    s[60:61], v47, v53
        v_cmp_eq_i32    vcc, v23, v8
        s_andn2_b64     s[58:59], s[58:59], exec
        s_or_b64        s[58:59], vcc, s[58:59]
        s_or_b64        vcc, s[60:61], vcc
        s_and_saveexec_b64 s[60:61], vcc
        s_andn2_b64     s[56:57], s[56:57], exec
        s_cbranch_scc0  .L13220_2
        s_and_b64       exec, s[60:61], s[56:57]
        v_add_i32       v52, vcc, v47, v53
        v_ashrrev_i32   v52, 1, v52
        v_lshlrev_b32   v54, 2, v52
        v_add_i32       v54, vcc, s4, v54
        v_add_i32       v55, vcc, -1, v52
        v_add_i32       v52, vcc, 1, v52
        tbuffer_load_format_x v8, v54, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v8, v23
        v_cndmask_b32   v53, v53, v55, vcc
        v_cndmask_b32   v47, v52, v47, vcc
        s_branch        .L13128_2
.L13220_2:
        s_mov_b64       exec, s[54:55]
        v_cndmask_b32   v46, v46, 1.0, s[58:59]
        v_mov_b32       v38, 2
.L13236_2:
        s_mov_b64       exec, s[50:51]
        v_cmp_eq_u32    vcc, 0, v46
        s_and_b64       exec, s[50:51], vcc
        v_bfe_u32       v48, v60, 10, 12
        s_cbranch_execz .L13524_2
        ds_read_u8      v48, v48
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v48, v48, 0, 8
        v_cmp_eq_i32    vcc, 0, v48
        s_and_saveexec_b64 s[52:53], vcc
        v_lshlrev_b32   v40, 8, v40
        s_cbranch_execz .L13508_2
        v_add_i32       v40, vcc, 0x306d5f00, v40
        v_lshrrev_b32   v48, 24, v59
        s_mov_b32       s5, 0x3fffff00
        v_bfi_b32       v40, s5, v40, v48
        v_lshrrev_b32   v48, 6, v40
        v_add_i32       v48, vcc, s7, v48
        buffer_load_ubyte v48, v48, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v48
        s_and_saveexec_b64 s[54:55], vcc
        s_cbranch_execz .L13508_2
        s_buffer_load_dword s5, s[8:11], s4
        s_mov_b64       s[56:57], exec
        s_mov_b64       s[58:59], exec
        v_mov_b32       v23, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v8, s5
        v_mov_b32       v52, s0
        s_movk_i32      s60, 0x0
        s_movk_i32      s61, 0x0
        s_nop           0x0
        s_nop           0x0
.L13400_2:
        v_cmp_gt_i32    s[62:63], v23, v52
        v_cmp_eq_i32    vcc, v40, v8
        s_andn2_b64     s[60:61], s[60:61], exec
        s_or_b64        s[60:61], vcc, s[60:61]
        s_or_b64        vcc, s[62:63], vcc
        s_and_saveexec_b64 s[62:63], vcc
        s_andn2_b64     s[58:59], s[58:59], exec
        s_cbranch_scc0  .L13492_2
        s_and_b64       exec, s[62:63], s[58:59]
        v_add_i32       v48, vcc, v23, v52
        v_ashrrev_i32   v48, 1, v48
        v_lshlrev_b32   v53, 2, v48
        v_add_i32       v53, vcc, s4, v53
        v_add_i32       v54, vcc, -1, v48
        v_add_i32       v48, vcc, 1, v48
        tbuffer_load_format_x v8, v53, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v8, v40
        v_cndmask_b32   v52, v52, v54, vcc
        v_cndmask_b32   v23, v48, v23, vcc
        s_branch        .L13400_2
.L13492_2:
        s_mov_b64       exec, s[56:57]
        v_cndmask_b32   v49, v49, 1.0, s[60:61]
        v_mov_b32       v38, 2
.L13508_2:
        s_mov_b64       exec, s[52:53]
        v_cmp_eq_u32    vcc, 0, v49
        v_addc_u32      v6, vcc, v6, 0, vcc
.L13524_2:
        s_mov_b64       exec, s[40:41]
.L13528_2:
        s_andn2_b64     exec, s[36:37], exec
        v_cndmask_b32   v71, 0, -1, s[22:23]
        v_mov_b32       v38, 0
        s_mov_b64       exec, s[36:37]
        s_branch        .L6812_2
.L13552_2:
        s_mov_b64       exec, s[16:17]
        v_cmp_eq_i32    vcc, 0, v38
        s_and_saveexec_b64 s[4:5], vcc
        v_mov_b32       v0, 0x400
        s_cbranch_execz .L13584_2
        tbuffer_store_format_x v0, v5, s[24:27], 0 offen format:[32,float]
.L13584_2:
        s_andn2_b64     exec, s[4:5], exec
        s_cbranch_execz .L14088_2
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_lshrrev_b32   v0, 26, v61
        v_add_i32       v0, vcc, s1, v0
        v_bfe_u32       v1, v61, 20, 6
        v_cmp_eq_i32    s[2:3], v38, 1
        v_lshlrev_b32   v9, 4, v61
        v_add_i32       v1, vcc, s1, v1
        v_bfe_u32       v11, v61, 14, 6
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v0, v0, s[8:11], 0 offen
        v_lshrrev_b32   v12, 28, v60
        v_cndmask_b32   v9, v58, v9, s[2:3]
        v_add_i32       v11, vcc, s1, v11
        v_bfe_u32       v14, v61, 8, 6
        buffer_load_ubyte v1, v1, s[8:11], 0 offen
        v_cndmask_b32   v12, v57, v12, s[2:3]
        v_add_i32       v14, vcc, s1, v14
        v_bfe_u32       v15, v61, 2, 6
        v_and_b32       v9, 48, v9
        buffer_load_ubyte v11, v11, s[8:11], 0 offen
        v_add_i32       v15, vcc, s1, v15
        v_or_b32        v9, v12, v9
        buffer_load_ubyte v12, v14, s[8:11], 0 offen
        v_add_i32       v9, vcc, s1, v9
        v_bfe_u32       v14, v60, 22, 6
        buffer_load_ubyte v15, v15, s[8:11], 0 offen
        v_add_i32       v14, vcc, s1, v14
        v_bfe_u32       v16, v60, 16, 6
        buffer_load_ubyte v9, v9, s[8:11], 0 offen
        v_add_i32       v16, vcc, s1, v16
        v_bfe_u32       v17, v60, 10, 6
        buffer_load_ubyte v14, v14, s[8:11], 0 offen
        v_add_i32       v17, vcc, s1, v17
        v_bfe_u32       v18, v60, 4, 6
        v_lshrrev_b32   v19, 30, v59
        v_lshlrev_b32   v10, 2, v60
        buffer_load_ubyte v16, v16, s[8:11], 0 offen
        v_add_i32       v18, vcc, s1, v18
        v_bfi_b32       v10, 60, v10, v19
        buffer_load_ubyte v17, v17, s[8:11], 0 offen
        v_add_i32       v10, vcc, s1, v10
        v_bfe_u32       v8, v59, 24, 6
        buffer_load_ubyte v18, v18, s[8:11], 0 offen
        v_add_i32       v8, vcc, s1, v8
        s_nop           0x0
        buffer_load_ubyte v10, v10, s[8:11], 0 offen
        buffer_load_ubyte v8, v8, s[8:11], 0 offen
        v_bfe_u32       v4, v4, 0, 8
        v_bfe_u32       v7, v71, 0, 8
        v_bfe_u32       v19, v74, 0, 8
        v_bfe_u32       v13, v13, 0, 8
        buffer_store_byte v4, v5, s[24:27], 0 offen offset:17 glc
        v_bfe_u32       v3, v3, 0, 8
        buffer_store_byte v2, v5, s[24:27], 0 offen offset:18 glc
        buffer_store_byte v7, v5, s[24:27], 0 offen offset:19 glc
        buffer_store_byte v19, v5, s[24:27], 0 offen offset:20 glc
        buffer_store_byte v13, v5, s[24:27], 0 offen offset:24 glc
        buffer_store_byte v3, v5, s[24:27], 0 offen offset:28 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:5 glc
        buffer_store_byte v1, v5, s[24:27], 0 offen offset:6 glc
        buffer_store_byte v11, v5, s[24:27], 0 offen offset:7 glc
        buffer_store_byte v12, v5, s[24:27], 0 offen offset:8 glc
        buffer_store_byte v15, v5, s[24:27], 0 offen offset:9 glc
        buffer_store_byte v9, v5, s[24:27], 0 offen offset:10 glc
        buffer_store_byte v14, v5, s[24:27], 0 offen offset:11 glc
        buffer_store_byte v16, v5, s[24:27], 0 offen offset:12 glc
        buffer_store_byte v17, v5, s[24:27], 0 offen offset:13 glc
        v_mov_b32       v0, 1
        buffer_store_byte v18, v5, s[24:27], 0 offen offset:14 glc
        v_add_i32       v1, vcc, 1, v6
        buffer_store_byte v10, v5, s[24:27], 0 offen offset:15 glc
        buffer_store_byte v8, v5, s[24:27], 0 offen offset:16 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:4 glc
        tbuffer_store_format_x v1, v5, s[24:27], 0 offen format:[32,float]
.L14088_2:
        s_endpgm



.kernel OpenCL_SHA1_PerformSearching_ForwardAndBackwardMatching
	.config

    .dims x	
	.driver_version 200460

	.arg outputArray,              structure*, 32,  global
	.arg key,                      uchar*,          global, const
	.arg tripcodeChunkArray,       uint*,           global
	.arg numTripcodeChunk,         uint
	.arg keyCharTable_OneByte,         uchar*,          global, const
	.arg keyCharTable_FirstByte,         uchar*,          global, const
	.arg keyCharTable_SecondByte,         uchar*,          global, const
	.arg keyCharTable_SecondByteAndOneByte,         uchar*,          global, const
	.arg smallChunkBitmap,         uchar*,          global, const
	.arg chunkBitmap,              uchar*,          global

	.useconstdata
    .userdata PTR_UAV_TABLE,0,2,2
    .userdata IMM_CONST_BUFFER,0,4,4
    .userdata IMM_CONST_BUFFER,1,8,4
	.localsize 4416

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
        s_buffer_load_dword s15, s[8:11], 0x0
        s_waitcnt       lgkmcnt(0)
        s_min_u32       s1, s1, 0xffff
        s_buffer_load_dword s20, s[8:11], 0x14
        s_buffer_load_dword s21, s[8:11], 0x1c
        s_mul_i32       s1, s12, s1
        s_add_u32       s1, s1, s13
        v_add_i32       v5, vcc, s1, v0
        s_load_dwordx4  s[24:27], s[2:3], 0x60
        s_load_dwordx4  s[28:31], s[2:3], 0x78
        s_load_dwordx4  s[32:35], s[2:3], 0x80
        s_add_u32       s1, s12, s14
        v_lshlrev_b32   v5, 5, v5
        v_add_i32       v5, vcc, s15, v5
        v_mov_b32       v6, 0
        s_ashr_i32      s12, s1, 6
        v_and_b32       v7, 63, v0
        s_and_b32       s1, s1, 63
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s12, s12, s21
        s_waitcnt       vmcnt(2)
        v_add_i32       v2, vcc, v2, v7
        s_add_u32       s1, s1, s20
        s_waitcnt       vmcnt(1)
        v_add_i32       v3, vcc, s12, v3
        v_add_i32       v2, vcc, s21, v2
        s_waitcnt       vmcnt(0)
        v_add_i32       v4, vcc, s1, v4
        buffer_load_ubyte v7, v1, s[16:19], 0 offen offset:2
        buffer_load_ubyte v1, v1, s[16:19], 0 offen offset:3
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
        s_cbranch_execz .L4404_3
        s_load_dwordx4  s[12:15], s[2:3], 0x88
        s_movk_i32      s10, 0x0
        s_movk_i32      s11, 0x100
.L268_3:
        s_cmp_gt_u32    s11, 0
        s_cbranch_scc0  .L4404_3
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s22, s6, s10
        s_waitcnt       expcnt(0)
        v_mov_b32       v6, s22
        s_add_u32       s22, s10, 0x140
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x141
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x142
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x143
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x144
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x145
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x146
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:1
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:2
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:3
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:4
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:5
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:6
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:7
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
        s_add_u32       s22, s10, 0x147
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x148
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x149
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x14a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x14b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x14c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x14d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x14e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:8
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:9
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:10
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:11
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:12
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:13
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:14
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:15
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
        s_add_u32       s22, s10, 0x14f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x150
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x151
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x152
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x153
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x154
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x155
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x156
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:16
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:17
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:18
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:19
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:20
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:21
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:22
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:23
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
        s_add_u32       s22, s10, 0x157
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x158
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x159
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x15a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x15b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x15c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x15d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x15e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:24
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:25
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:26
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:27
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:28
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:29
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:30
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:31
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
        s_add_u32       s22, s10, 0x15f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x160
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x161
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x162
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x163
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x164
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x165
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x166
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:32
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:33
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:34
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:35
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:36
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:37
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:38
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:39
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
        s_add_u32       s22, s10, 0x167
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x168
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x169
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x16a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x16b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x16c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x16d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x16e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:40
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:41
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:42
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:43
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:44
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:45
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:46
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:47
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
        s_add_u32       s22, s10, 0x16f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x170
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x171
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x172
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x173
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x174
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x175
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x176
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:48
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:49
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:50
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:51
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:52
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:53
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:54
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:55
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
        s_add_u32       s22, s10, 0x177
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x178
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x179
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x17a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x17b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x17c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x17d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x17e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:56
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:57
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:58
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:59
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:60
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:61
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:62
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:63
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
        s_add_u32       s22, s10, 0x17f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x180
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x181
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x182
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x183
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x184
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x185
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x186
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:64
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:65
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:66
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:67
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:68
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:69
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:70
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:71
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
        s_add_u32       s22, s10, 0x187
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x188
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x189
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x18a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x18b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x18c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x18d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x18e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:72
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:73
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:74
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:75
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:76
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:77
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:78
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:79
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
        s_add_u32       s22, s10, 0x18f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x190
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x191
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x192
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x193
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x194
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x195
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x196
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:80
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:81
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:82
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:83
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:84
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:85
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:86
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:87
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
        s_add_u32       s22, s10, 0x197
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x198
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x199
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x19a
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x19b
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x19c
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x19d
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x19e
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:88
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:89
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:90
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:91
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:92
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:93
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:94
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:95
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
        s_add_u32       s22, s10, 0x19f
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x1a0
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x1a1
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x1a2
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x1a3
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x1a4
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x1a5
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x1a6
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:96
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:97
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:98
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:99
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:100
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:101
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:102
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:103
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
        s_add_u32       s22, s10, 0x1a7
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x1a8
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x1a9
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x1aa
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x1ab
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x1ac
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x1ad
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x1ae
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:104
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:105
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:106
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:107
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:108
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:109
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:110
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:111
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
        s_add_u32       s22, s10, 0x1af
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x1b0
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x1b1
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x1b2
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x1b3
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x1b4
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x1b5
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x1b6
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:112
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:113
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:114
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:115
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:116
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:117
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:118
        buffer_load_ubyte v22, v6, s[12:15], 0 offen offset:119
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
        s_add_u32       s22, s10, 0x1b7
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v22
        s_add_u32       s22, s10, 0x1b8
        v_mov_b32       v8, s22
        s_add_u32       s22, s10, 0x1b9
        v_mov_b32       v9, s22
        s_add_u32       s22, s10, 0x1ba
        v_mov_b32       v10, s22
        s_add_u32       s22, s10, 0x1bb
        v_mov_b32       v11, s22
        s_add_u32       s22, s10, 0x1bc
        v_mov_b32       v12, s22
        s_add_u32       s22, s10, 0x1bd
        v_mov_b32       v13, s22
        s_add_u32       s22, s10, 0x1be
        v_mov_b32       v14, s22
        buffer_load_ubyte v15, v6, s[12:15], 0 offen offset:120
        buffer_load_ubyte v16, v6, s[12:15], 0 offen offset:121
        buffer_load_ubyte v17, v6, s[12:15], 0 offen offset:122
        buffer_load_ubyte v18, v6, s[12:15], 0 offen offset:123
        buffer_load_ubyte v19, v6, s[12:15], 0 offen offset:124
        buffer_load_ubyte v20, v6, s[12:15], 0 offen offset:125
        buffer_load_ubyte v21, v6, s[12:15], 0 offen offset:126
        buffer_load_ubyte v6, v6, s[12:15], 0 offen offset:127
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
        s_add_u32       s22, s10, 0x1bf
        v_mov_b32       v8, s22
        s_waitcnt       vmcnt(0)
        ds_write_b8     v8, v6
        s_add_u32       s10, s10, 0x80
        s_sub_i32       s11, s11, 8
        s_branch        .L268_3
.L4404_3:
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
        ds_read2_b32    v[17:18], v11 offset0:10 offset1:11
        v_xor_b32       v10, v10, v14
        ds_read2_b32    v[19:20], v11 offset0:14 offset1:16
        ds_read2_b32    v[21:22], v11 offset0:12 offset1:13
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v23, v6, v15
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v17, v17, v23
        v_xor_b32       v23, v9, v10
        v_xor_b32       v24, v16, v8
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v18, v23
        v_alignbit_b32  v23, v24, v24, 31
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v24, v14, v17
        v_xor_b32       v24, 0x60, v24
        v_xor_b32       v25, v12, v23
        v_xor_b32       v26, v16, v18
        ds_write2_b32   v11, v10, v23 offset0:24 offset1:25
        v_xor_b32       v22, v22, v24
        v_xor_b32       v21, v21, v25
        v_xor_b32       v24, v20, v26
        ds_write2_b32   v11, v17, v18 offset0:26 offset1:27
        v_alignbit_b32  v22, v22, v22, 31
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v19, v19, v24
        ds_write2_b32   v11, v21, v22 offset0:28 offset1:29
        v_alignbit_b32  v19, v19, v19, 31
        ds_write_b32    v11, v19 offset:120
        ds_read2_b32    v[24:25], v11 offset0:17 offset1:18
        v_xor_b32       v15, v15, v21
        v_xor_b32       v8, v8, v15
        v_xor_b32       v8, 0x60, v8
        v_xor_b32       v15, v22, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v26, v23, v19
        ds_read2_b32    v[27:28], v11 offset0:21 offset1:23
        ds_read2_b32    v[29:30], v11 offset0:19 offset1:20
        v_xor_b32       v6, v6, v15
        v_xor_b32       v9, v9, v26
        v_xor_b32       v15, v17, v8
        v_xor_b32       v6, v20, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v24, v9
        v_xor_b32       v12, v12, v15
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v12, v25, v12
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v15, v21, v9
        v_xor_b32       v20, v18, v6
        v_xor_b32       v15, v16, v15
        v_xor_b32       v14, v14, v20
        v_xor_b32       v20, v22, v12
        ds_write2_b32   v11, v8, v6 offset0:31 offset1:32
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v15, v30, v15
        v_xor_b32       v14, v29, v14
        v_xor_b32       v20, v28, v20
        ds_write2_b32   v11, v9, v12 offset0:33 offset1:34
        v_alignbit_b32  v15, v15, v15, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v20, v27, v20
        ds_write2_b32   v11, v14, v15 offset0:35 offset1:36
        v_alignbit_b32  v20, v20, v20, 31
        ds_write_b32    v11, v20 offset:148
        ds_read2_b32    v[24:25], v11 offset0:24 offset1:25
        v_xor_b32       v19, v19, v14
        v_xor_b32       v10, v10, v19
        v_xor_b32       v10, v16, v10
        v_xor_b32       v16, v15, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v19, v6, v20
        ds_read2_b32    v[26:27], v11 offset0:28 offset1:30
        ds_read2_b32    v[29:30], v11 offset0:26 offset1:27
        v_xor_b32       v16, v23, v16
        v_xor_b32       v17, v17, v19
        v_xor_b32       v19, v9, v10
        v_xor_b32       v16, v28, v16
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v17, v24, v17
        v_xor_b32       v18, v18, v19
        v_alignbit_b32  v16, v16, v16, 31
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v25, v18
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v19, v14, v17
        v_xor_b32       v23, v12, v16
        v_xor_b32       v19, v22, v19
        v_xor_b32       v21, v21, v23
        v_xor_b32       v23, v15, v18
        ds_write2_b32   v11, v10, v16 offset0:38 offset1:39
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v30, v19
        v_xor_b32       v21, v29, v21
        v_xor_b32       v23, v27, v23
        ds_write2_b32   v11, v17, v18 offset0:40 offset1:41
        v_alignbit_b32  v19, v19, v19, 31
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v23, v26, v23
        ds_write2_b32   v11, v21, v19 offset0:42 offset1:43
        v_alignbit_b32  v23, v23, v23, 31
        ds_write_b32    v11, v23 offset:176
        ds_read2_b32    v[24:25], v11 offset0:31 offset1:32
        v_xor_b32       v20, v20, v21
        v_xor_b32       v8, v8, v20
        v_xor_b32       v8, v22, v8
        v_xor_b32       v20, v19, v10
        v_alignbit_b32  v8, v8, v8, 31
        v_xor_b32       v22, v16, v23
        ds_read2_b32    v[28:29], v11 offset0:35 offset1:37
        ds_read2_b32    v[30:31], v11 offset0:33 offset1:34
        v_xor_b32       v6, v6, v20
        v_xor_b32       v9, v9, v22
        v_xor_b32       v20, v17, v8
        v_xor_b32       v6, v27, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v24, v9
        v_xor_b32       v12, v12, v20
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v12, v25, v12
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v20, v21, v9
        v_xor_b32       v22, v18, v6
        v_xor_b32       v20, v15, v20
        v_xor_b32       v14, v14, v22
        v_xor_b32       v22, v19, v12
        ds_write2_b32   v11, v8, v6 offset0:45 offset1:46
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v31, v20
        v_xor_b32       v14, v30, v14
        v_xor_b32       v22, v29, v22
        ds_write2_b32   v11, v9, v12 offset0:47 offset1:48
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v22, v28, v22
        ds_write2_b32   v11, v14, v20 offset0:49 offset1:50
        v_alignbit_b32  v22, v22, v22, 31
        ds_write_b32    v11, v22 offset:204
        ds_read2_b32    v[24:25], v11 offset0:38 offset1:39
        v_xor_b32       v23, v23, v14
        v_xor_b32       v10, v10, v23
        v_xor_b32       v10, v15, v10
        v_xor_b32       v15, v20, v8
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v23, v6, v22
        ds_read2_b32    v[26:27], v11 offset0:42 offset1:44
        ds_read2_b32    v[30:31], v11 offset0:40 offset1:41
        v_xor_b32       v15, v16, v15
        v_xor_b32       v16, v17, v23
        v_xor_b32       v17, v9, v10
        v_xor_b32       v15, v29, v15
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v16, v24, v16
        v_xor_b32       v17, v18, v17
        v_alignbit_b32  v15, v15, v15, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v17, v25, v17
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v18, v14, v16
        v_xor_b32       v23, v12, v15
        v_xor_b32       v18, v19, v18
        v_xor_b32       v21, v21, v23
        v_xor_b32       v23, v20, v17
        ds_write2_b32   v11, v10, v15 offset0:52 offset1:53
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v18, v31, v18
        v_xor_b32       v21, v30, v21
        v_xor_b32       v23, v27, v23
        ds_write2_b32   v11, v16, v17 offset0:54 offset1:55
        v_alignbit_b32  v18, v18, v18, 31
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v23, v26, v23
        ds_write2_b32   v11, v21, v18 offset0:56 offset1:57
        v_alignbit_b32  v23, v23, v23, 31
        ds_write_b32    v11, v23 offset:232
        ds_read2_b32    v[24:25], v11 offset0:45 offset1:46
        v_xor_b32       v22, v22, v21
        v_xor_b32       v8, v8, v22
        v_xor_b32       v8, v19, v8
        v_xor_b32       v19, v18, v10
        v_alignbit_b32  v45, v8, v8, 31
        v_xor_b32       v22, v15, v23
        ds_read2_b32    v[28:29], v11 offset0:49 offset1:51
        ds_read2_b32    v[30:31], v11 offset0:47 offset1:48
        v_xor_b32       v6, v6, v19
        v_xor_b32       v9, v9, v22
        v_xor_b32       v19, v16, v45
        v_xor_b32       v6, v27, v6
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v24, v9
        v_xor_b32       v12, v12, v19
        v_alignbit_b32  v6, v6, v6, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v12, v25, v12
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v19, v21, v9
        v_xor_b32       v22, v17, v6
        v_xor_b32       v19, v20, v19
        v_xor_b32       v14, v14, v22
        v_xor_b32       v22, v18, v12
        ds_write2_b32   v11, v45, v6 offset0:59 offset1:60
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v19, v31, v19
        v_xor_b32       v14, v30, v14
        v_xor_b32       v22, v29, v22
        ds_write2_b32   v11, v9, v12 offset0:61 offset1:62
        v_alignbit_b32  v61, v19, v19, 31
        v_alignbit_b32  v14, v14, v14, 31
        v_xor_b32       v22, v28, v22
        ds_write2_b32   v11, v14, v61 offset0:63 offset1:64
        v_alignbit_b32  v46, v22, v22, 31
        ds_write_b32    v11, v46 offset:260
        ds_read2_b32    v[24:25], v11 offset0:52 offset1:53
        v_xor_b32       v23, v23, v14
        v_xor_b32       v10, v10, v23
        v_xor_b32       v10, v20, v10
        v_xor_b32       v20, v61, v45
        v_alignbit_b32  v10, v10, v10, 31
        v_xor_b32       v23, v6, v46
        ds_read2_b32    v[26:27], v11 offset0:56 offset1:58
        ds_read2_b32    v[30:31], v11 offset0:54 offset1:55
        v_xor_b32       v15, v15, v20
        v_xor_b32       v16, v16, v23
        v_xor_b32       v20, v9, v10
        v_xor_b32       v15, v29, v15
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v16, v24, v16
        v_xor_b32       v17, v17, v20
        v_alignbit_b32  v15, v15, v15, 31
        v_alignbit_b32  v16, v16, v16, 31
        v_xor_b32       v17, v25, v17
        v_alignbit_b32  v17, v17, v17, 31
        v_xor_b32       v20, v14, v16
        v_xor_b32       v23, v12, v15
        v_xor_b32       v20, v18, v20
        v_xor_b32       v21, v21, v23
        v_xor_b32       v23, v61, v17
        ds_write2_b32   v11, v10, v15 offset0:66 offset1:67
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v20, v31, v20
        v_xor_b32       v21, v30, v21
        v_xor_b32       v23, v27, v23
        ds_write2_b32   v11, v16, v17 offset0:68 offset1:69
        v_alignbit_b32  v20, v20, v20, 31
        v_alignbit_b32  v21, v21, v21, 31
        v_xor_b32       v23, v26, v23
        ds_write2_b32   v11, v21, v20 offset0:70 offset1:71
        v_alignbit_b32  v23, v23, v23, 31
        ds_write_b32    v11, v23 offset:288
        ds_read2_b32    v[24:25], v11 offset0:59 offset1:60
        v_xor_b32       v26, v46, v21
        v_xor_b32       v26, v45, v26
        v_xor_b32       v18, v18, v26
        v_xor_b32       v10, v20, v10
        v_alignbit_b32  v18, v18, v18, 31
        v_xor_b32       v15, v15, v23
        ds_read2_b32    v[28:29], v11 offset0:63 offset1:65
        ds_read2_b32    v[30:31], v11 offset0:61 offset1:62
        v_xor_b32       v10, v6, v10
        v_xor_b32       v9, v9, v15
        v_xor_b32       v15, v16, v18
        v_xor_b32       v10, v27, v10
        s_waitcnt       lgkmcnt(2)
        v_xor_b32       v9, v24, v9
        v_xor_b32       v12, v12, v15
        v_alignbit_b32  v10, v10, v10, 31
        v_alignbit_b32  v9, v9, v9, 31
        v_xor_b32       v12, v25, v12
        v_alignbit_b32  v12, v12, v12, 31
        v_xor_b32       v15, v21, v9
        v_xor_b32       v16, v17, v10
        v_xor_b32       v15, v61, v15
        v_xor_b32       v14, v14, v16
        v_xor_b32       v16, v20, v12
        ds_write2_b32   v11, v18, v10 offset0:73 offset1:74
        s_waitcnt       lgkmcnt(1)
        v_xor_b32       v10, v31, v15
        v_xor_b32       v14, v30, v14
        v_xor_b32       v15, v29, v16
        ds_write2_b32   v11, v9, v12 offset0:75 offset1:76
        v_alignbit_b32  v9, v10, v10, 31
        v_alignbit_b32  v10, v14, v14, 31
        v_xor_b32       v12, v28, v15
        ds_write2_b32   v11, v10, v9 offset0:77 offset1:78
        v_alignbit_b32  v9, v12, v12, 31
        ds_write_b32    v11, v9 offset:316
        ds_read2_b32    v[9:10], v11 offset0:1 offset1:2
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0x5a827999, v10
        v_add_i32       v9, vcc, 0x5a827999, v9
        ds_write2_b32   v11, v9, v10 offset0:1 offset1:2
        ds_read2_b32    v[9:10], v11 offset0:17 offset1:18
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0x5a827999, v10
        v_add_i32       v9, vcc, 0x5a827999, v9
        ds_write2_b32   v11, v9, v10 offset0:17 offset1:18
        ds_read2_b32    v[9:10], v11 offset0:20 offset1:21
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0x6ed9eba1, v10
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write2_b32   v11, v9, v10 offset0:20 offset1:21
        ds_read_b32     v9, v11 offset:92
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v11, v9 offset:92
        ds_read2_b32    v[9:10], v11 offset0:26 offset1:27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v10, vcc, 0x6ed9eba1, v10
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write2_b32   v11, v9, v10 offset0:26 offset1:27
        ds_read_b32     v9, v11 offset:116
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v11, v9 offset:116
        ds_read_b32     v9, v11 offset:132
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v11, v9 offset:132
        ds_read_b32     v9, v11 offset:156
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x6ed9eba1, v9
        ds_write_b32    v11, v9 offset:156
        ds_read_b32     v9, v11 offset:164
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x8f1bbcdc, v9
        ds_write_b32    v11, v9 offset:164
        ds_read_b32     v9, v11 offset:180
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x8f1bbcdc, v9
        ds_write_b32    v11, v9 offset:180
        ds_read_b32     v9, v11 offset:212
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0x8f1bbcdc, v9
        ds_write_b32    v11, v9 offset:212
        ds_read_b32     v9, v11 offset:260
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v11, v9 offset:260
        ds_read_b32     v9, v11 offset:276
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v11, v9 offset:276
        ds_read_b32     v9, v11 offset:308
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v9, vcc, 0xca62c1d6, v9
        ds_write_b32    v11, v9 offset:308
        v_lshrrev_b32   v0, 2, v0
        v_lshlrev_b32   v9, 24, v4
        v_lshlrev_b32   v10, 16, v2
        v_and_b32       v0, 48, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        ds_read2_b32    v[14:15], v11 offset0:38 offset1:39
        ds_read2_b32    v[16:17], v11 offset0:36 offset1:37
        ds_read2_b32    v[20:21], v11 offset0:34 offset1:35
        ds_read2_b32    v[23:24], v11 offset0:32 offset1:33
        ds_read2_b32    v[25:26], v11 offset0:30 offset1:31
        ds_read2_b32    v[27:28], v11 offset0:28 offset1:29
        ds_read2_b32    v[29:30], v11 offset0:26 offset1:27
        ds_read2_b32    v[31:32], v11 offset0:24 offset1:25
        ds_read2_b32    v[33:34], v11 offset0:22 offset1:23
        ds_read2_b32    v[35:36], v11 offset0:20 offset1:21
        ds_read2_b32    v[37:38], v11 offset0:18 offset1:19
        ds_read2_b32    v[11:12], v11 offset0:16 offset1:17
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[12:15], s[2:3], 0x90
        v_or_b32        v9, v9, v10
        v_add_i32       v0, vcc, v7, v0
        s_waitcnt       lgkmcnt(0)
        s_barrier
        s_add_u32       s0, -1, s5
        s_mov_b64       s[16:17], exec
        s_mov_b64       s[18:19], exec
        s_movk_i32      s5, 0x0
        v_mov_b32       v62, v1
        v_mov_b32       v7, v39
        v_mov_b32       v10, v39
        v_mov_b32       v8, v39
.L6976_3:
        s_cmp_gt_i32    s5, 0x3ff
        s_cbranch_scc0  .L7012_3
        s_cmp_gt_i32    s5, 0x3ff
        s_cselect_b32   s0, -1, 0
        v_mov_b32       v62, s0
        v_mov_b32       v7, 0
        s_branch        .L12068_3
.L7012_3:
        s_ashr_i32      s6, s5, 6
        s_add_u32       s6, s6, s20
        v_bfe_u32       v6, v0, 0, 8
        v_add_i32       v6, vcc, s6, v6
        s_and_b32       s6, s5, 63
        s_add_u32       s6, s6, s21
        v_bfe_u32       v7, v1, 0, 8
        buffer_load_ubyte v62, v6, s[28:31], 0 offen
        v_add_i32       v7, vcc, s6, v7
        buffer_load_ubyte v61, v7, s[32:35], 0 offen
        v_mov_b32       v8, 0
        s_waitcnt       vmcnt(0)
        s_barrier
        ds_read2_b32    v[18:19], v8 offset0:1 offset1:2
        v_lshlrev_b32   v10, 8, v62
        v_or_b32        v10, v9, v10
        v_or_b32        v10, v10, v61
        v_add_i32       v22, vcc, 0x9fb498b3, v10
        v_alignbit_b32  v39, v22, v22, 27
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v18, vcc, v39, v18
        v_add_i32       v18, vcc, 0xc2e5374, v18
        v_mov_b32       v39, 0x7bf36ae2
        s_mov_b32       s6, 0x59d148c0
        v_bfi_b32       v39, v22, s6, v39
        v_alignbit_b32  v40, v18, v18, 27
        v_add_i32       v39, vcc, v39, v40
        v_add_i32       v19, vcc, v19, v39
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, 0x98badcfe, v19
        v_bfi_b32       v39, v18, v22, s6
        v_alignbit_b32  v40, v19, v19, 27
        v_add_i32       v39, vcc, v40, v39
        v_add_i32       v39, vcc, 0x7bf36ae2, v39
        v_xor_b32       v39, 0x80000000, v39
        v_add_i32       v39, vcc, 0x5a827999, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_alignbit_b32  v40, v39, v39, 27
        v_bfi_b32       v41, v19, v18, v22
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, 0xb453c259, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_alignbit_b32  v41, v40, v40, 27
        v_bfi_b32       v42, v39, v19, v18
        v_add_i32       v22, vcc, v22, v41
        v_add_i32       v22, vcc, v42, v22
        v_add_i32       v22, vcc, 0x5a827999, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_alignbit_b32  v41, v22, v22, 27
        v_bfi_b32       v42, v40, v39, v19
        v_add_i32       v18, vcc, v18, v41
        v_add_i32       v18, vcc, v42, v18
        v_add_i32       v18, vcc, 0x5a827999, v18
        v_alignbit_b32  v41, v18, v18, 27
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v19, vcc, v19, v41
        v_bfi_b32       v41, v22, v40, v39
        v_add_i32       v19, vcc, v19, v41
        v_add_i32       v19, vcc, 0x5a827999, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_alignbit_b32  v41, v19, v19, 27
        v_bfi_b32       v42, v18, v22, v40
        v_add_i32       v39, vcc, v39, v41
        v_add_i32       v39, vcc, v42, v39
        v_add_i32       v39, vcc, 0x5a827999, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_alignbit_b32  v41, v39, v39, 27
        v_bfi_b32       v42, v19, v18, v22
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, v42, v40
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_alignbit_b32  v41, v40, v40, 27
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v22, vcc, v22, v41
        v_bfi_b32       v41, v39, v19, v18
        v_add_i32       v22, vcc, v22, v41
        v_add_i32       v22, vcc, 0x5a827999, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_alignbit_b32  v41, v22, v22, 27
        v_bfi_b32       v42, v40, v39, v19
        v_add_i32       v18, vcc, v18, v41
        v_add_i32       v18, vcc, v42, v18
        v_add_i32       v18, vcc, 0x5a827999, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_alignbit_b32  v41, v18, v18, 27
        v_bfi_b32       v42, v22, v40, v39
        v_add_i32       v19, vcc, v19, v41
        v_add_i32       v19, vcc, v42, v19
        v_add_i32       v19, vcc, 0x5a827999, v19
        v_alignbit_b32  v41, v19, v19, 27
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v39, vcc, v39, v41
        v_bfi_b32       v41, v18, v22, v40
        v_add_i32       v39, vcc, v39, v41
        v_add_i32       v39, vcc, 0x5a827999, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_alignbit_b32  v41, v39, v39, 27
        v_bfi_b32       v42, v19, v18, v22
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, v42, v40
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_alignbit_b32  v41, v40, v40, 27
        v_bfi_b32       v42, v39, v19, v18
        v_add_i32       v22, vcc, v22, v41
        v_add_i32       v22, vcc, v42, v22
        v_alignbit_b32  v41, v10, v10, 31
        v_add_i32       v22, vcc, 0x5a8279f9, v22
        v_xor_b32       v41, v11, v41
        v_alignbit_b32  v42, v22, v22, 27
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v18, vcc, v42, v18
        v_bfi_b32       v41, v40, v39, v19
        v_add_i32       v18, vcc, v18, v41
        v_add_i32       v18, vcc, 0x5a827999, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_alignbit_b32  v41, v18, v18, 27
        v_add_i32       v19, vcc, v12, v19
        v_bfi_b32       v42, v22, v40, v39
        v_add_i32       v19, vcc, v41, v19
        v_add_i32       v19, vcc, v42, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_alignbit_b32  v41, v19, v19, 27
        v_add_i32       v39, vcc, v37, v39
        v_bfi_b32       v42, v18, v22, v40
        v_add_i32       v39, vcc, v41, v39
        v_alignbit_b32  v41, v10, v10, 30
        v_add_i32       v39, vcc, v42, v39
        v_xor_b32       v42, v38, v41
        v_alignbit_b32  v43, v39, v39, 27
        v_add_i32       v40, vcc, v40, v42
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v40, vcc, v43, v40
        v_bfi_b32       v42, v19, v18, v22
        v_add_i32       v40, vcc, v40, v42
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v42, v39, v18
        v_add_i32       v40, vcc, 0x5a827999, v40
        v_xor_b32       v42, v19, v42
        v_add_i32       v22, vcc, v35, v22
        v_xor_b32       v43, v40, v19
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, v42, v22
        v_alignbit_b32  v42, v40, v40, 27
        v_xor_b32       v43, v43, v39
        v_add_i32       v18, vcc, v36, v18
        v_add_i32       v22, vcc, v22, v42
        v_alignbit_b32  v42, v10, v10, 29
        v_add_i32       v18, vcc, v43, v18
        v_alignbit_b32  v43, v22, v22, 27
        v_xor_b32       v44, v39, v22
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v45, v33, v42
        v_add_i32       v18, vcc, v18, v43
        v_xor_b32       v43, v44, v40
        v_add_i32       v19, vcc, v19, v45
        v_alignbit_b32  v44, v18, v18, 27
        v_add_i32       v19, vcc, v43, v19
        v_add_i32       v19, vcc, v44, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v43, v18, v40
        v_add_i32       v19, vcc, 0x6ed9eba1, v19
        v_xor_b32       v43, v22, v43
        v_add_i32       v39, vcc, v34, v39
        v_xor_b32       v44, v19, v22
        v_alignbit_b32  v18, v18, v18, 2
        v_xor_b32       v45, v31, v41
        v_add_i32       v39, vcc, v43, v39
        v_alignbit_b32  v43, v19, v19, 27
        v_xor_b32       v44, v44, v18
        v_add_i32       v40, vcc, v40, v45
        v_add_i32       v39, vcc, v39, v43
        v_add_i32       v40, vcc, v44, v40
        v_alignbit_b32  v43, v39, v39, 27
        v_alignbit_b32  v44, v10, v10, 28
        v_add_i32       v40, vcc, v40, v43
        v_xor_b32       v43, v18, v39
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v45, v32, v44
        v_add_i32       v40, vcc, 0x6ed9eba1, v40
        v_xor_b32       v43, v43, v19
        v_add_i32       v22, vcc, v22, v45
        v_alignbit_b32  v45, v40, v40, 27
        v_add_i32       v22, vcc, v43, v22
        v_add_i32       v22, vcc, v45, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v43, v40, v19
        v_add_i32       v22, vcc, 0x6ed9eba1, v22
        v_xor_b32       v43, v39, v43
        v_add_i32       v18, vcc, v29, v18
        v_xor_b32       v45, v22, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, v43, v18
        v_alignbit_b32  v43, v22, v22, 27
        v_xor_b32       v45, v45, v40
        v_add_i32       v19, vcc, v30, v19
        v_add_i32       v18, vcc, v18, v43
        v_alignbit_b32  v43, v10, v10, 27
        v_add_i32       v19, vcc, v45, v19
        v_alignbit_b32  v45, v18, v18, 27
        v_xor_b32       v46, v40, v18
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v47, v27, v43
        v_add_i32       v19, vcc, v19, v45
        v_xor_b32       v45, v46, v22
        v_add_i32       v39, vcc, v39, v47
        v_alignbit_b32  v46, v19, v19, 27
        v_add_i32       v39, vcc, v45, v39
        v_add_i32       v39, vcc, v46, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_xor_b32       v45, v19, v22
        v_add_i32       v39, vcc, 0x6ed9eba1, v39
        v_xor_b32       v46, v25, v41
        v_xor_b32       v45, v18, v45
        v_add_i32       v40, vcc, v28, v40
        v_xor_b32       v47, v39, v18
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v46, v44, v46
        v_add_i32       v40, vcc, v45, v40
        v_alignbit_b32  v45, v39, v39, 27
        v_xor_b32       v47, v47, v19
        v_add_i32       v22, vcc, v22, v46
        v_add_i32       v40, vcc, v40, v45
        v_add_i32       v22, vcc, v47, v22
        v_alignbit_b32  v45, v40, v40, 27
        v_alignbit_b32  v46, v10, v10, 26
        v_add_i32       v22, vcc, v22, v45
        v_xor_b32       v45, v19, v40
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v47, v26, v46
        v_add_i32       v22, vcc, 0x6ed9eba1, v22
        v_xor_b32       v45, v45, v39
        v_add_i32       v18, vcc, v18, v47
        v_alignbit_b32  v47, v22, v22, 27
        v_add_i32       v18, vcc, v45, v18
        v_xor_b32       v41, v23, v41
        v_add_i32       v18, vcc, v47, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v45, v22, v39
        v_xor_b32       v41, v42, v41
        v_add_i32       v18, vcc, 0x6ed9eba1, v18
        v_xor_b32       v45, v40, v45
        v_add_i32       v19, vcc, v19, v41
        v_add_i32       v19, vcc, v45, v19
        v_alignbit_b32  v41, v18, v18, 27
        v_xor_b32       v45, v18, v40
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, v19, v41
        v_xor_b32       v41, v45, v22
        v_add_i32       v39, vcc, v24, v39
        v_add_i32       v19, vcc, 0x6ed9eba1, v19
        v_alignbit_b32  v45, v10, v10, 25
        v_add_i32       v39, vcc, v41, v39
        v_alignbit_b32  v41, v19, v19, 27
        v_xor_b32       v47, v22, v19
        v_alignbit_b32  v18, v18, v18, 2
        v_xor_b32       v48, v20, v45
        v_add_i32       v39, vcc, v39, v41
        v_xor_b32       v41, v47, v18
        v_add_i32       v40, vcc, v40, v48
        v_alignbit_b32  v47, v39, v39, 27
        v_add_i32       v40, vcc, v41, v40
        v_add_i32       v40, vcc, v47, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v41, v39, v18
        v_xor_b32       v47, v21, v44
        v_add_i32       v40, vcc, 0x6ed9eba1, v40
        v_xor_b32       v41, v19, v41
        v_add_i32       v22, vcc, v22, v47
        v_xor_b32       v47, v44, v46
        v_add_i32       v22, vcc, v41, v22
        v_alignbit_b32  v41, v40, v40, 27
        v_xor_b32       v48, v40, v19
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v49, v16, v47
        v_add_i32       v22, vcc, v22, v41
        v_xor_b32       v41, v48, v39
        v_add_i32       v18, vcc, v18, v49
        v_add_i32       v22, vcc, 0x6ed9eba1, v22
        v_add_i32       v18, vcc, v41, v18
        v_alignbit_b32  v41, v22, v22, 27
        v_alignbit_b32  v48, v10, v10, 24
        v_add_i32       v18, vcc, v18, v41
        v_xor_b32       v41, v39, v22
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v49, v17, v48
        v_add_i32       v18, vcc, 0x6ed9eba1, v18
        v_xor_b32       v41, v41, v40
        v_add_i32       v19, vcc, v19, v49
        v_alignbit_b32  v49, v18, v18, 27
        v_add_i32       v19, vcc, v41, v19
        v_add_i32       v19, vcc, v49, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v41, v18, v40
        v_xor_b32       v49, v14, v44
        v_add_i32       v19, vcc, 0x6ed9eba1, v19
        v_xor_b32       v41, v22, v41
        v_add_i32       v39, vcc, v39, v49
        v_add_i32       v39, vcc, v41, v39
        v_alignbit_b32  v41, v19, v19, 27
        v_xor_b32       v49, v19, v22
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v39, vcc, v39, v41
        ds_read2_b32    v[50:51], v8 offset0:40 offset1:41
        v_xor_b32       v41, v49, v18
        v_add_i32       v40, vcc, v15, v40
        v_add_i32       v39, vcc, 0x6ed9eba1, v39
        v_add_i32       v40, vcc, v41, v40
        v_alignbit_b32  v41, v39, v39, 27
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v19, v19, v19, 2
        v_bfi_b32       v41, v18, v19, v39
        v_bfi_b32       v49, v19, 0, v39
        v_alignbit_b32  v52, v40, v40, 27
        v_alignbit_b32  v53, v10, v10, 23
        v_xor_b32       v41, v41, v49
        v_add_i32       v22, vcc, v22, v52
        v_xor_b32       v49, v44, v53
        v_add_i32       v22, vcc, v41, v22
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v49, v50
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, 0x8f1bbcdc, v22
        v_bfi_b32       v41, v19, v39, v40
        v_bfi_b32       v49, v39, 0, v40
        v_alignbit_b32  v50, v22, v22, 27
        ds_read2_b32    v[52:53], v8 offset0:42 offset1:43
        v_xor_b32       v41, v41, v49
        v_add_i32       v18, vcc, v18, v50
        v_add_i32       v18, vcc, v41, v18
        v_add_i32       v18, vcc, v51, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_bfi_b32       v41, v39, v40, v22
        v_bfi_b32       v49, v40, 0, v22
        v_alignbit_b32  v50, v18, v18, 27
        v_xor_b32       v41, v41, v49
        v_add_i32       v19, vcc, v19, v50
        v_xor_b32       v49, v46, v48
        v_add_i32       v19, vcc, v41, v19
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v52, v49
        v_add_i32       v19, vcc, v19, v41
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, 0x8f1bbcdc, v19
        v_bfi_b32       v41, v40, v22, v18
        v_bfi_b32       v49, v22, 0, v18
        v_alignbit_b32  v50, v19, v19, 27
        v_xor_b32       v41, v41, v49
        v_add_i32       v39, vcc, v39, v50
        v_alignbit_b32  v49, v10, v10, 22
        ds_read2_b32    v[50:51], v8 offset0:44 offset1:45
        v_add_i32       v39, vcc, v41, v39
        v_xor_b32       v41, v53, v49
        v_add_i32       v39, vcc, v39, v41
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_bfi_b32       v41, v22, v18, v19
        v_bfi_b32       v52, v18, 0, v19
        v_alignbit_b32  v53, v39, v39, 27
        v_xor_b32       v54, v42, v46
        v_xor_b32       v41, v41, v52
        v_add_i32       v40, vcc, v40, v53
        v_xor_b32       v52, v45, v54
        v_add_i32       v40, vcc, v41, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v52, v50
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_bfi_b32       v41, v18, v19, v39
        v_bfi_b32       v50, v19, 0, v39
        v_alignbit_b32  v52, v40, v40, 27
        ds_read2_b32    v[53:54], v8 offset0:46 offset1:47
        v_xor_b32       v41, v41, v50
        v_add_i32       v22, vcc, v22, v52
        v_add_i32       v22, vcc, v41, v22
        v_add_i32       v22, vcc, v51, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_bfi_b32       v41, v19, v39, v40
        v_bfi_b32       v50, v39, 0, v40
        v_alignbit_b32  v51, v22, v22, 27
        v_alignbit_b32  v52, v10, v10, 21
        v_xor_b32       v41, v41, v50
        v_add_i32       v18, vcc, v18, v51
        v_xor_b32       v50, v44, v52
        v_add_i32       v18, vcc, v41, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v53, v50
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, 0x8f1bbcdc, v18
        v_bfi_b32       v41, v39, v40, v22
        v_bfi_b32       v50, v40, 0, v22
        v_alignbit_b32  v51, v18, v18, 27
        v_xor_b32       v41, v41, v50
        v_add_i32       v19, vcc, v19, v51
        v_xor_b32       v50, v44, v48
        ds_read2_b32    v[55:56], v8 offset0:48 offset1:49
        v_add_i32       v19, vcc, v41, v19
        v_xor_b32       v41, v54, v50
        v_add_i32       v19, vcc, v19, v41
        v_add_i32       v19, vcc, 0x8f1bbcdc, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v41, v42, v43
        v_bfi_b32       v42, v40, v22, v18
        v_bfi_b32       v51, v22, 0, v18
        v_alignbit_b32  v53, v19, v19, 27
        v_xor_b32       v41, v50, v41
        v_xor_b32       v42, v42, v51
        v_add_i32       v39, vcc, v39, v53
        v_xor_b32       v41, v49, v41
        v_add_i32       v39, vcc, v42, v39
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v55
        v_add_i32       v39, vcc, v39, v41
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_bfi_b32       v41, v22, v18, v19
        v_bfi_b32       v42, v18, 0, v19
        v_alignbit_b32  v51, v39, v39, 27
        v_xor_b32       v41, v41, v42
        v_add_i32       v40, vcc, v40, v51
        v_alignbit_b32  v42, v10, v10, 20
        ds_read2_b32    v[53:54], v8 offset0:50 offset1:51
        v_add_i32       v40, vcc, v41, v40
        v_xor_b32       v41, v56, v42
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_bfi_b32       v41, v18, v19, v39
        v_bfi_b32       v51, v19, 0, v39
        v_alignbit_b32  v55, v40, v40, 27
        v_xor_b32       v41, v41, v51
        v_add_i32       v22, vcc, v22, v55
        v_add_i32       v22, vcc, v41, v22
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v48, v53
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, 0x8f1bbcdc, v22
        v_bfi_b32       v41, v19, v39, v40
        v_bfi_b32       v51, v39, 0, v40
        v_alignbit_b32  v53, v22, v22, 27
        v_xor_b32       v41, v41, v51
        v_add_i32       v18, vcc, v18, v53
        ds_read2_b32    v[55:56], v8 offset0:52 offset1:53
        v_add_i32       v18, vcc, v41, v18
        v_xor_b32       v41, v47, v54
        v_add_i32       v18, vcc, v18, v41
        v_add_i32       v18, vcc, 0x8f1bbcdc, v18
        v_alignbit_b32  v40, v40, v40, 2
        v_bfi_b32       v41, v39, v40, v22
        v_bfi_b32       v51, v40, 0, v22
        v_alignbit_b32  v53, v18, v18, 27
        v_alignbit_b32  v54, v10, v10, 19
        v_xor_b32       v41, v41, v51
        v_add_i32       v19, vcc, v19, v53
        v_xor_b32       v51, v50, v54
        v_add_i32       v19, vcc, v41, v19
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v51, v55
        v_add_i32       v19, vcc, v19, v41
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, 0x8f1bbcdc, v19
        v_bfi_b32       v41, v40, v22, v18
        v_bfi_b32       v51, v22, 0, v18
        v_alignbit_b32  v53, v19, v19, 27
        ds_read2_b32    v[57:58], v8 offset0:54 offset1:55
        v_xor_b32       v41, v41, v51
        v_add_i32       v39, vcc, v39, v53
        v_add_i32       v39, vcc, v41, v39
        v_add_i32       v39, vcc, v56, v39
        v_alignbit_b32  v18, v18, v18, 2
        v_bfi_b32       v41, v22, v18, v19
        v_bfi_b32       v51, v18, 0, v19
        v_alignbit_b32  v53, v39, v39, 27
        v_xor_b32       v55, v45, v49
        v_xor_b32       v41, v41, v51
        v_add_i32       v40, vcc, v40, v53
        v_xor_b32       v51, v42, v55
        v_add_i32       v40, vcc, v41, v40
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v51, v57
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_bfi_b32       v41, v18, v19, v39
        v_bfi_b32       v51, v19, 0, v39
        v_alignbit_b32  v53, v40, v40, 27
        v_xor_b32       v41, v41, v51
        v_add_i32       v22, vcc, v22, v53
        v_alignbit_b32  v51, v10, v10, 18
        ds_read2_b32    v[55:56], v8 offset0:56 offset1:57
        v_add_i32       v22, vcc, v41, v22
        v_xor_b32       v41, v51, v58
        v_add_i32       v22, vcc, v22, v41
        v_add_i32       v22, vcc, 0x8f1bbcdc, v22
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v41, v45, v47
        v_bfi_b32       v53, v19, v39, v40
        v_bfi_b32       v57, v39, 0, v40
        v_alignbit_b32  v58, v22, v22, 27
        v_xor_b32       v49, v49, v41
        v_xor_b32       v53, v53, v57
        v_add_i32       v18, vcc, v18, v58
        v_xor_b32       v49, v52, v49
        v_add_i32       v18, vcc, v53, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v49, v49, v55
        v_add_i32       v18, vcc, v18, v49
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, 0x8f1bbcdc, v18
        v_bfi_b32       v49, v39, v40, v22
        v_bfi_b32       v53, v40, 0, v22
        v_alignbit_b32  v55, v18, v18, 27
        v_xor_b32       v49, v49, v53
        v_add_i32       v19, vcc, v19, v55
        ds_read2_b32    v[57:58], v8 offset0:58 offset1:59
        v_add_i32       v19, vcc, v49, v19
        v_xor_b32       v49, v48, v56
        v_add_i32       v19, vcc, v19, v49
        v_add_i32       v19, vcc, 0x8f1bbcdc, v19
        v_alignbit_b32  v22, v22, v22, 2
        v_bfi_b32       v49, v40, v22, v18
        v_bfi_b32       v53, v22, 0, v18
        v_alignbit_b32  v55, v19, v19, 27
        v_alignbit_b32  v56, v10, v10, 17
        v_xor_b32       v49, v49, v53
        v_add_i32       v39, vcc, v39, v55
        v_xor_b32       v50, v50, v56
        v_add_i32       v39, vcc, v49, v39
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v49, v50, v57
        v_add_i32       v39, vcc, v39, v49
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v39, vcc, 0x8f1bbcdc, v39
        v_bfi_b32       v49, v22, v18, v19
        v_bfi_b32       v50, v18, 0, v19
        v_alignbit_b32  v53, v39, v39, 27
        ds_read2_b32    v[59:60], v8 offset0:60 offset1:61
        v_xor_b32       v49, v49, v50
        v_add_i32       v40, vcc, v40, v53
        v_xor_b32       v50, v48, v42
        v_add_i32       v40, vcc, v49, v40
        v_xor_b32       v49, v50, v58
        v_add_i32       v40, vcc, v40, v49
        v_xor_b32       v49, v18, v39
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v44, v44, v45
        v_add_i32       v40, vcc, 0x8f1bbcdc, v40
        v_xor_b32       v49, v49, v19
        v_xor_b32       v44, v50, v44
        v_alignbit_b32  v53, v40, v40, 27
        v_add_i32       v22, vcc, v22, v49
        v_xor_b32       v44, v51, v44
        v_add_i32       v22, vcc, v53, v22
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v44, v44, v59
        v_add_i32       v22, vcc, v22, v44
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v44, v40, v19
        v_add_i32       v22, vcc, 0xca62c1d6, v22
        v_xor_b32       v44, v39, v44
        ds_read2_b32    v[57:58], v8 offset0:62 offset1:63
        v_add_i32       v18, vcc, v18, v44
        v_alignbit_b32  v44, v22, v22, 27
        v_alignbit_b32  v49, v10, v10, 16
        v_add_i32       v18, vcc, v18, v44
        v_xor_b32       v44, v49, v60
        v_xor_b32       v53, v22, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, v18, v44
        v_xor_b32       v44, v53, v40
        v_add_i32       v18, vcc, 0xca62c1d6, v18
        v_add_i32       v19, vcc, v19, v44
        v_alignbit_b32  v44, v18, v18, 27
        v_xor_b32       v47, v47, v50
        v_add_i32       v19, vcc, v19, v44
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v44, v47, v57
        v_add_i32       v19, vcc, v19, v44
        v_xor_b32       v44, v40, v18
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, 0xca62c1d6, v19
        v_xor_b32       v44, v44, v22
        ds_read2_b32    v[59:60], v8 offset0:64 offset1:65
        v_alignbit_b32  v47, v19, v19, 27
        v_add_i32       v39, vcc, v39, v44
        v_add_i32       v39, vcc, v47, v39
        v_xor_b32       v44, v48, v58
        v_add_i32       v39, vcc, v39, v44
        v_alignbit_b32  v18, v18, v18, 2
        v_xor_b32       v44, v19, v22
        v_add_i32       v39, vcc, 0xca62c1d6, v39
        v_xor_b32       v44, v18, v44
        v_xor_b32       v41, v41, v50
        v_alignbit_b32  v47, v10, v10, 15
        v_add_i32       v40, vcc, v40, v44
        v_alignbit_b32  v44, v39, v39, 27
        v_xor_b32       v41, v41, v47
        v_add_i32       v40, vcc, v40, v44
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v59
        v_xor_b32       v44, v39, v18
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v40, vcc, v40, v41
        ds_read2_b32    v[57:58], v8 offset0:66 offset1:67
        v_xor_b32       v41, v44, v19
        v_add_i32       v40, vcc, 0xca62c1d6, v40
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v41, v40, v40, 27
        v_add_i32       v22, vcc, v22, v41
        v_xor_b32       v41, v19, v40
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, v22, v60
        v_xor_b32       v41, v41, v39
        v_alignbit_b32  v44, v22, v22, 27
        v_add_i32       v18, vcc, v18, v41
        v_xor_b32       v41, v51, v49
        v_add_i32       v18, vcc, v44, v18
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v57
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v41, v22, v39
        v_add_i32       v18, vcc, 0xca62c1d6, v18
        v_xor_b32       v41, v40, v41
        v_alignbit_b32  v44, v10, v10, 14
        ds_read2_b32    v[59:60], v8 offset0:68 offset1:69
        v_add_i32       v19, vcc, v19, v41
        v_alignbit_b32  v41, v18, v18, 27
        v_xor_b32       v47, v48, v44
        v_add_i32       v19, vcc, v19, v41
        v_xor_b32       v41, v47, v58
        v_xor_b32       v47, v18, v40
        v_alignbit_b32  v22, v22, v22, 2
        v_add_i32       v19, vcc, v19, v41
        v_xor_b32       v41, v47, v22
        v_add_i32       v19, vcc, 0xca62c1d6, v19
        v_xor_b32       v47, v52, v51
        v_add_i32       v39, vcc, v39, v41
        v_alignbit_b32  v41, v19, v19, 27
        v_xor_b32       v47, v56, v47
        v_add_i32       v39, vcc, v39, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v47, v59
        v_add_i32       v39, vcc, v39, v41
        v_xor_b32       v41, v22, v19
        v_alignbit_b32  v18, v18, v18, 2
        ds_read2_b32    v[57:58], v8 offset0:70 offset1:71
        v_add_i32       v39, vcc, 0xca62c1d6, v39
        v_xor_b32       v41, v41, v18
        v_alignbit_b32  v47, v39, v39, 27
        v_add_i32       v40, vcc, v40, v41
        v_add_i32       v40, vcc, v47, v40
        v_alignbit_b32  v19, v19, v19, 2
        v_xor_b32       v41, v39, v18
        v_add_i32       v40, vcc, v40, v60
        v_xor_b32       v41, v19, v41
        v_alignbit_b32  v47, v10, v10, 13
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v41, v40, v40, 27
        v_xor_b32       v47, v42, v47
        v_add_i32       v22, vcc, v22, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v47, v57
        v_xor_b32       v47, v40, v19
        v_alignbit_b32  v39, v39, v39, 2
        v_add_i32       v22, vcc, v22, v41
        v_xor_b32       v41, v47, v39
        v_add_i32       v22, vcc, 0xca62c1d6, v22
        ds_read2_b32    v[59:60], v8 offset0:72 offset1:73
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v41, v22, v22, 27
        v_xor_b32       v47, v42, v49
        v_xor_b32       v43, v43, v52
        v_add_i32       v18, vcc, v18, v41
        v_xor_b32       v41, v47, v58
        v_xor_b32       v43, v42, v43
        v_add_i32       v18, vcc, v18, v41
        v_xor_b32       v41, v39, v22
        v_alignbit_b32  v40, v40, v40, 2
        v_xor_b32       v43, v54, v43
        v_add_i32       v18, vcc, 0xca62c1d6, v18
        v_xor_b32       v41, v41, v40
        v_xor_b32       v43, v49, v43
        v_alignbit_b32  v47, v18, v18, 27
        v_add_i32       v19, vcc, v19, v41
        v_xor_b32       v41, v44, v43
        v_add_i32       v19, vcc, v47, v19
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v41, v59
        v_add_i32       v19, vcc, v19, v41
        v_alignbit_b32  v22, v22, v22, 2
        v_xor_b32       v41, v18, v40
        v_add_i32       v19, vcc, 0xca62c1d6, v19
        v_xor_b32       v41, v22, v41
        ds_read2_b32    v[52:53], v8 offset0:74 offset1:75
        v_add_i32       v39, vcc, v39, v41
        v_alignbit_b32  v41, v19, v19, 27
        v_alignbit_b32  v43, v10, v10, 12
        v_add_i32       v39, vcc, v39, v41
        v_xor_b32       v41, v43, v60
        v_xor_b32       v47, v19, v22
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v39, vcc, v39, v41
        v_xor_b32       v41, v47, v18
        v_add_i32       v39, vcc, 0xca62c1d6, v39
        v_add_i32       v40, vcc, v40, v41
        v_alignbit_b32  v41, v39, v39, 27
        v_xor_b32       v47, v48, v49
        v_add_i32       v40, vcc, v40, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v47, v52
        v_add_i32       v40, vcc, v40, v41
        v_xor_b32       v41, v18, v39
        v_alignbit_b32  v19, v19, v19, 2
        v_add_i32       v40, vcc, 0xca62c1d6, v40
        v_xor_b32       v41, v41, v19
        v_xor_b32       v46, v46, v42
        ds_read2_b32    v[54:55], v8 offset0:76 offset1:77
        v_alignbit_b32  v47, v40, v40, 27
        v_add_i32       v22, vcc, v22, v41
        v_xor_b32       v41, v51, v46
        v_add_i32       v22, vcc, v47, v22
        v_xor_b32       v41, v41, v53
        v_xor_b32       v45, v45, v48
        v_add_i32       v22, vcc, v22, v41
        v_alignbit_b32  v39, v39, v39, 2
        v_xor_b32       v41, v40, v19
        v_xor_b32       v42, v42, v45
        v_add_i32       v22, vcc, 0xca62c1d6, v22
        v_xor_b32       v41, v39, v41
        v_xor_b32       v42, v49, v42
        v_alignbit_b32  v46, v10, v10, 11
        v_add_i32       v18, vcc, v18, v41
        v_alignbit_b32  v41, v22, v22, 27
        v_xor_b32       v42, v42, v46
        v_add_i32       v18, vcc, v18, v41
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v41, v42, v54
        v_xor_b32       v42, v22, v39
        v_alignbit_b32  v40, v40, v40, 2
        v_add_i32       v18, vcc, v18, v41
        ds_read2_b32    v[46:47], v8 offset0:78 offset1:79
        v_xor_b32       v8, v42, v40
        v_add_i32       v18, vcc, 0xca62c1d6, v18
        v_add_i32       v8, vcc, v19, v8
        v_alignbit_b32  v19, v18, v18, 27
        v_add_i32       v8, vcc, v8, v19
        v_alignbit_b32  v19, v22, v22, 2
        v_xor_b32       v22, v40, v18
        v_xor_b32       v41, v56, v45
        v_add_i32       v8, vcc, v8, v55
        v_xor_b32       v22, v19, v22
        v_xor_b32       v41, v44, v41
        v_alignbit_b32  v42, v8, v8, 27
        v_add_i32       v22, vcc, v39, v22
        v_xor_b32       v39, v43, v41
        v_add_i32       v22, vcc, v42, v22
        s_waitcnt       lgkmcnt(0)
        v_xor_b32       v39, v39, v46
        v_xor_b32       v19, v8, v19
        v_alignbit_b32  v18, v18, v18, 2
        v_add_i32       v22, vcc, v22, v39
        v_xor_b32       v18, v19, v18
        v_add_i32       v19, vcc, 0xca62c1d6, v22
        v_alignbit_b32  v10, v10, v10, 10
        v_add_i32       v18, vcc, v40, v18
        v_alignbit_b32  v19, v19, v19, 27
        v_xor_b32       v10, v48, v10
        v_add_i32       v18, vcc, v18, v19
        v_xor_b32       v10, v10, v47
        v_add_i32       v10, vcc, v18, v10
        v_add_i32       v46, vcc, 0x31a7e4d7, v10
        v_lshrrev_b32   v18, 20, v46
        v_add_i32       v18, vcc, 0x140, v18
        ds_read_u8      v18, v18
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v18, v18, 0, 8
        v_alignbit_b32  v8, v8, v8, 2
        v_cmp_lg_i32    s[22:23], v18, 0
        v_add_i32       v45, vcc, 0x98badcfe, v8
        v_add_i32       v6, vcc, 0xba306d5f, v22
        s_mov_b64       s[36:37], exec
        s_andn2_b64     exec, s[36:37], s[22:23]
        v_lshrrev_b32   v8, 8, v46
        s_cbranch_execz .L11724_3
        v_add_i32       v39, vcc, s7, v8
        buffer_load_ubyte v39, v39, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v39
        s_and_saveexec_b64 s[22:23], vcc
        v_lshrrev_b32   v39, 2, v46
        s_cbranch_execz .L11704_3
        s_buffer_load_dword s6, s[8:11], s4
        s_mov_b64       s[38:39], exec
        s_mov_b64       s[40:41], exec
        v_mov_b32       v40, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v7, s6
        v_mov_b32       v42, s0
.L11576_3:
        v_cmp_gt_i32    s[42:43], v40, v42
        v_cmp_eq_i32    vcc, v39, v7
        s_or_b64        vcc, s[42:43], vcc
        s_and_saveexec_b64 s[42:43], vcc
        s_andn2_b64     s[40:41], s[40:41], exec
        s_cbranch_scc0  .L11660_3
        s_and_b64       exec, s[42:43], s[40:41]
        v_add_i32       v41, vcc, v40, v42
        v_ashrrev_i32   v41, 1, v41
        v_lshlrev_b32   v43, 2, v41
        v_add_i32       v43, vcc, s4, v43
        v_add_i32       v44, vcc, -1, v41
        v_add_i32       v41, vcc, 1, v41
        tbuffer_load_format_x v7, v43, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v7, v39
        v_cndmask_b32   v42, v42, v44, vcc
        v_cndmask_b32   v40, v41, v40, vcc
        s_branch        .L11576_3
.L11660_3:
        s_mov_b64       exec, s[38:39]
        v_cmp_lg_i32    vcc, v39, v7
        s_mov_b64       s[38:39], exec
        s_andn2_b64     exec, s[38:39], vcc
        v_mov_b32       v7, 1
        s_cbranch_execz .L11696_3
        v_mov_b32       v10, 0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L12068_3
.L11696_3:
        s_and_b64       exec, s[38:39], s[18:19]
        v_mov_b32       v7, 1
.L11704_3:
        s_andn2_b64     exec, s[22:23], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32       v7, 0
        s_cbranch_execz .L11720_3
.L11720_3:
        s_and_b64       exec, s[22:23], s[18:19]
.L11724_3:
        s_andn2_b64     exec, s[36:37], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32       v7, 0
        s_cbranch_execz .L11740_3
.L11740_3:
        s_and_b64       exec, s[36:37], s[18:19]
        v_bfe_u32       v8, v6, 10, 12
        ds_read_u8      v40, v8 offset:320
        s_waitcnt       lgkmcnt(0)
        v_bfe_u32       v40, v40, 0, 8
        v_cmp_eq_i32    s[22:23], v40, 0
        s_and_saveexec_b64 s[36:37], s[22:23]
        v_lshlrev_b32   v22, 8, v22
        s_cbranch_execz .L12036_3
        v_lshrrev_b32   v10, 24, v45
        v_add_i32       v22, vcc, 0x306d5f00, v22
        s_mov_b32       s6, 0x3fffff00
        v_bfi_b32       v8, s6, v22, v10
        v_lshrrev_b32   v40, 6, v8
        v_add_i32       v40, vcc, s7, v40
        buffer_load_ubyte v40, v40, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v40
        s_and_saveexec_b64 s[38:39], vcc
        s_cbranch_execz .L12032_3
        s_buffer_load_dword s6, s[8:11], s4
        s_mov_b64       s[40:41], exec
        s_mov_b64       s[42:43], exec
        v_mov_b32       v19, 0
        s_waitcnt       lgkmcnt(0)
        v_mov_b32       v7, s6
        v_mov_b32       v41, s0
        s_nop           0x0
        s_nop           0x0
.L11888_3:
        v_cmp_gt_i32    s[44:45], v19, v41
        v_cmp_eq_i32    vcc, v8, v7
        s_or_b64        vcc, s[44:45], vcc
        s_and_saveexec_b64 s[44:45], vcc
        s_andn2_b64     s[42:43], s[42:43], exec
        s_cbranch_scc0  .L11972_3
        s_and_b64       exec, s[44:45], s[42:43]
        v_add_i32       v40, vcc, v19, v41
        v_ashrrev_i32   v40, 1, v40
        v_lshlrev_b32   v42, 2, v40
        v_add_i32       v42, vcc, s4, v42
        v_add_i32       v43, vcc, -1, v40
        v_add_i32       v40, vcc, 1, v40
        tbuffer_load_format_x v7, v42, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v7, v8
        v_cndmask_b32   v41, v41, v43, vcc
        v_cndmask_b32   v19, v40, v19, vcc
        s_branch        .L11888_3
.L11972_3:
        s_mov_b64       exec, s[40:41]
        v_cmp_lg_i32    s[40:41], v8, v7
        s_mov_b64       s[42:43], exec
        s_andn2_b64     exec, s[42:43], s[40:41]
        v_cndmask_b32   v8, 0, -1, s[40:41]
        s_cbranch_execz .L12016_3
        v_mov_b32       v7, 2
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L12068_3
.L12016_3:
        s_and_b64       exec, s[42:43], s[18:19]
        v_cndmask_b32   v8, 0, -1, s[40:41]
        v_mov_b32       v7, 2
.L12032_3:
        s_and_b64       exec, s[38:39], s[18:19]
.L12036_3:
        s_andn2_b64     exec, s[36:37], exec
        s_and_b64       exec, exec, s[18:19]
        v_cndmask_b32   v10, 0, -1, s[22:23]
        s_cbranch_execz .L12056_3
.L12056_3:
        s_and_b64       exec, s[36:37], s[18:19]
        s_add_u32       s5, s5, 1
        s_branch        .L6976_3
.L12068_3:
        s_mov_b64       exec, s[16:17]
        v_cmp_eq_i32    vcc, 0, v7
        s_and_saveexec_b64 s[6:7], vcc
        v_mov_b32       v0, 0x400
        s_cbranch_execz .L12100_3
        tbuffer_store_format_x v0, v5, s[24:27], 0 offen format:[32,float]
.L12100_3:
        s_andn2_b64     exec, s[6:7], exec
        s_cbranch_execz .L12604_3
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_lshrrev_b32   v12, 26, v46
        v_cmp_eq_i32    s[2:3], v7, 1
        v_lshrrev_b32   v9, 8, v46
        v_add_i32       v12, vcc, s1, v12
        v_bfe_u32       v14, v46, 20, 6
        v_cndmask_b32   v9, v9, v8, s[2:3]
        v_add_i32       v11, vcc, s1, v14
        v_bfe_u32       v14, v46, 14, 6
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v12, v12, s[8:11], 0 offen
        v_add_i32       v14, vcc, s1, v14
        v_and_b32       v9, 63, v9
        buffer_load_ubyte v11, v11, s[8:11], 0 offen
        v_add_i32       v9, vcc, s1, v9
        v_bfe_u32       v15, v46, 2, 6
        v_lshrrev_b32   v16, 28, v6
        v_lshlrev_b32   v8, 4, v46
        buffer_load_ubyte v14, v14, s[8:11], 0 offen
        v_add_i32       v15, vcc, s1, v15
        v_bfi_b32       v8, 48, v8, v16
        buffer_load_ubyte v9, v9, s[8:11], 0 offen
        v_add_i32       v8, vcc, s1, v8
        v_bfe_u32       v16, v6, 22, 6
        buffer_load_ubyte v15, v15, s[8:11], 0 offen
        v_add_i32       v16, vcc, s1, v16
        v_bfe_u32       v17, v6, 16, 6
        buffer_load_ubyte v8, v8, s[8:11], 0 offen
        v_add_i32       v17, vcc, s1, v17
        v_bfe_u32       v18, v6, 10, 6
        buffer_load_ubyte v16, v16, s[8:11], 0 offen
        v_lshrrev_b32   v19, 24, v45
        v_add_i32       v18, vcc, s1, v18
        v_bfe_u32       v20, v6, 4, 6
        v_lshrrev_b32   v7, 30, v45
        v_lshlrev_b32   v6, 2, v6
        buffer_load_ubyte v17, v17, s[8:11], 0 offen
        v_cndmask_b32   v10, v10, v19, s[2:3]
        v_add_i32       v19, vcc, s1, v20
        v_bfi_b32       v6, 60, v6, v7
        buffer_load_ubyte v7, v18, s[8:11], 0 offen
        v_add_i32       v6, vcc, s1, v6
        v_and_b32       v10, 63, v10
        buffer_load_ubyte v18, v19, s[8:11], 0 offen
        v_add_i32       v10, vcc, s1, v10
        buffer_load_ubyte v6, v6, s[8:11], 0 offen
        buffer_load_ubyte v10, v10, s[8:11], 0 offen
        v_bfe_u32       v4, v4, 0, 8
        v_bfe_u32       v0, v62, 0, 8
        v_bfe_u32       v1, v61, 0, 8
        v_bfe_u32       v13, v13, 0, 8
        buffer_store_byte v4, v5, s[24:27], 0 offen offset:17 glc
        v_bfe_u32       v3, v3, 0, 8
        buffer_store_byte v2, v5, s[24:27], 0 offen offset:18 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:19 glc
        buffer_store_byte v1, v5, s[24:27], 0 offen offset:20 glc
        buffer_store_byte v13, v5, s[24:27], 0 offen offset:24 glc
        buffer_store_byte v3, v5, s[24:27], 0 offen offset:28 glc
        buffer_store_byte v12, v5, s[24:27], 0 offen offset:5 glc
        buffer_store_byte v11, v5, s[24:27], 0 offen offset:6 glc
        buffer_store_byte v14, v5, s[24:27], 0 offen offset:7 glc
        buffer_store_byte v9, v5, s[24:27], 0 offen offset:8 glc
        buffer_store_byte v15, v5, s[24:27], 0 offen offset:9 glc
        buffer_store_byte v8, v5, s[24:27], 0 offen offset:10 glc
        buffer_store_byte v16, v5, s[24:27], 0 offen offset:11 glc
        buffer_store_byte v17, v5, s[24:27], 0 offen offset:12 glc
        buffer_store_byte v7, v5, s[24:27], 0 offen offset:13 glc
        v_mov_b32       v0, 1
        s_add_u32       s0, s5, 1
        buffer_store_byte v18, v5, s[24:27], 0 offen offset:14 glc
        v_mov_b32       v1, s0
        buffer_store_byte v6, v5, s[24:27], 0 offen offset:15 glc
        buffer_store_byte v10, v5, s[24:27], 0 offen offset:16 glc
        buffer_store_byte v0, v5, s[24:27], 0 offen offset:4 glc
        tbuffer_store_format_x v1, v5, s[24:27], 0 offen format:[32,float]
.L12604_3:
        s_endpgm
