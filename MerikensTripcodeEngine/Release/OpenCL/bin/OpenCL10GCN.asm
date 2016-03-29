	
	/* # of VGPRs: 128 */
	/*
	v[0:63]: datablocks
	v[64:84]: keys[28:48]
	v[85:86]: misc
	v[87:89]: free
	v[90:98]: temp vars for S-Boxes
	v99: Lane ID
	v[100:127]: arguments for S-Boxes
	*/

	/* # of SGPRs: 104 */

.globaldata
    .byte 0x5e, 0x5f, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65
    .byte 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d
    .byte 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75
    .byte 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d
.kernel OpenCL_DES_PerformSearching
    .config
    .dims x	

	.driver_version 180011

	.arg searchMode,               int
	.arg outputArray,              structure*, 32,  global
	.arg keyInfo,                  structure*, 106, global, const
	.arg tripcodeChunkArray,       uint*,           global
	.arg numTripcodeChunk,         uint
	.arg smallChunkBitmap,         uchar*,          global, const
	.arg compactMediumChunkBitmap, uint*,           global, const
	.arg chunkBitmap,              uchar*,          global
	.arg partialKeyFrom3To6Array,  structure*, 4,   global
	.arg keyFrom00To27,            uint

	.useconstdata
    .userdata PTR_UAV_TABLE,0,2,2
    .userdata IMM_CONST_BUFFER,0,4,4
    .userdata IMM_CONST_BUFFER,1,8,4
    .text
		v_mov_b32 v99, v0
		
        v_writelane_b32 v86, s2, 0
        v_writelane_b32 v86, s3, 1
        s_buffer_load_dwordx2 s[0:1], s[4:7], 0x4
        s_buffer_load_dwordx2 s[14:15], s[4:7], 0x18
        s_waitcnt       lgkmcnt(0)
        s_buffer_load_dword s1, s[8:11], 0x20 
        s_min_u32       s0, s0, 0xffff
        s_mul_i32       s0, s12, s0
        s_add_u32       s0, s0, s14
        v_add_i32       v99, vcc, s0, v99
        s_load_dwordx4  s[12:15], s[2:3], 0x80
        v_lshlrev_b32 v70, 2, v99
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v70, vcc, s1, v70
        buffer_load_ubyte v77, v70, s[12:15], 0 offen offset:2
        buffer_load_ubyte v84, v70, s[12:15], 0 offen offset:3
        buffer_load_ubyte v70, v70, s[12:15], 0 offen offset:1
        s_buffer_load_dword s0, s[8:11], 0x4
        s_buffer_load_dword s1, s[8:11], 0x24
        v_lshlrev_b32 v99, 5, v99
        s_waitcnt       lgkmcnt(0)
        v_add_i32       v99, vcc, s0, v99
        v_mov_b32 v71, 0
        s_waitcnt       vmcnt(2)
        v_lshlrev_b32 v63, 7, v77
        s_waitcnt       vmcnt(1)
        v_lshlrev_b32 v62, 14, v84
        s_waitcnt       vmcnt(0)

        s_buffer_load_dword s80, s[4:7], 0x20
        s_waitcnt       lgkmcnt(0)
        v_writelane_b32 v86, s80, 2
        s_buffer_load_dword s80, s[8:11], 0x0
        s_buffer_load_dword s81, s[8:11], 0xc
        s_waitcnt       lgkmcnt(0)
        v_writelane_b32 v86, s81, 3
        s_buffer_load_dword s81, s[8:11], 0x10
        s_buffer_load_dword s82, s[8:11], 0x14
        s_buffer_load_dword s83, s[8:11], 0x1c
        s_load_dwordx4  s[8:11], s[2:3], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v71, v99, s[8:11], 0 offen offset:4 glc
        s_waitcnt       expcnt(0)

		s_mov_b32 s27, s1

		s_bfe_i32       s0, s27, 0x10000
        s_bfe_i32       s1, s27, 0x10001
        s_bfe_i32       s2, s27, 0x10002
        s_bfe_i32       s3, s27, 0x10003
        s_bfe_i32       s4, s27, 0x10004
        s_bfe_i32       s5, s27, 0x10005
        s_bfe_i32       s6, s27, 0x10006
        s_bfe_i32       s7, s27, 0x10007
        s_bfe_i32       s8, s27, 0x10008
        s_bfe_i32       s9, s27, 0x10009

        s_bfe_i32       s10, s27, 0x1000a
        s_bfe_i32       s11, s27, 0x1000b
        s_bfe_i32       s12, s27, 0x1000c
        s_bfe_i32       s13, s27, 0x1000d
        s_bfe_i32       s14, s27, 0x1000e
        s_bfe_i32       s15, s27, 0x1000f
        s_bfe_i32       s16, s27, 0x10010
        s_bfe_i32       s17, s27, 0x10011
        s_bfe_i32       s18, s27, 0x10012
        s_bfe_i32       s19, s27, 0x10013

        s_bfe_i32       s20, s27, 0x10014
        s_bfe_i32       s21, s27, 0x10015
        s_bfe_i32       s22, s27, 0x10016
        s_bfe_i32       s23, s27, 0x10017
        s_bfe_i32       s24, s27, 0x10018
        s_bfe_i32       s25, s27, 0x10019
        s_bfe_i32       s26, s27, 0x1001a
        s_bfe_i32       s27, s27, 0x1001b

        v_bfe_i32       v64, v70, 0, 1
		v_bfe_i32       v65, v70, 1, 1
        v_bfe_i32       v66, v70, 2, 1
        v_bfe_i32       v67, v70, 3, 1
        v_bfe_i32       v68, v70, 4, 1
        v_bfe_i32       v69, v70, 5, 1
        v_bfe_i32       v70, v70, 6, 1

        v_bfe_i32       v71, v77, 0, 1
        v_bfe_i32       v72, v77, 1, 1
        v_bfe_i32       v73, v77, 2, 1
        v_bfe_i32       v74, v77, 3, 1
        v_bfe_i32       v75, v77, 4, 1
        v_bfe_i32       v76, v77, 5, 1
        v_bfe_i32       v77, v77, 6, 1
	
        v_bfe_i32       v78, v84, 0, 1
        v_bfe_i32       v79, v84, 1, 1
        v_bfe_i32       v80, v84, 2, 1
        v_bfe_i32       v81, v84, 3, 1
        v_bfe_i32       v82, v84, 4, 1
        v_bfe_i32       v83, v84, 5, 1
        v_bfe_i32       v84, v84, 6, 1
        
		v_mov_b32 v0, 0
        v_mov_b32 v1, 0
        v_mov_b32 v2, 0
        v_mov_b32 v3, 0
        v_mov_b32 v4, 0
        v_mov_b32 v5, 0
        v_mov_b32 v6, 0
        v_mov_b32 v7, 0
        v_mov_b32 v8, 0
        v_mov_b32 v9, 0
        v_mov_b32 v10, 0
        v_mov_b32 v11, 0
        v_mov_b32 v12, 0
        v_mov_b32 v13, 0
        v_mov_b32 v14, 0
        v_mov_b32 v15, 0
        v_mov_b32 v16, 0
        v_mov_b32 v17, 0
        v_mov_b32 v18, 0
        v_mov_b32 v19, 0
        v_mov_b32 v20, 0
        v_mov_b32 v21, 0
        v_mov_b32 v22, 0
        v_mov_b32 v23, 0
        v_mov_b32 v24, 0
        v_mov_b32 v25, 0
        v_mov_b32 v26, 0
        v_mov_b32 v27, 0
        v_mov_b32 v28, 0
        v_mov_b32 v29, 0
        v_mov_b32 v30, 0
        v_mov_b32 v31, 0
        v_mov_b32 v32, 0
        v_mov_b32 v33, 0
        v_mov_b32 v34, 0
        v_mov_b32 v35, 0
        v_mov_b32 v36, 0
        v_mov_b32 v37, 0
        v_mov_b32 v38, 0
        v_mov_b32 v39, 0
        v_mov_b32 v40, 0
        v_mov_b32 v41, 0
        v_mov_b32 v42, 0
        v_mov_b32 v46, 0
        v_mov_b32 v47, 0
        v_mov_b32 v48, 0
        v_mov_b32 v49, 0
        v_mov_b32 v51, 0
        v_mov_b32 v56, 0
        v_mov_b32 v59, 0
        v_mov_b32 v61, 0
        v_mov_b32 v63, 0

        v_mov_b32 v62, 0
        v_mov_b32 v44, 0
        v_mov_b32 v54, 0
        v_mov_b32 v60, 0
        v_mov_b32 v58, 0
        v_mov_b32 v57, 0
        v_mov_b32 v55, 0
        v_mov_b32 v53, 0
        v_mov_b32 v52, 0
        v_mov_b32 v50, 0
        v_mov_b32 v45, 0
        v_mov_b32 v43, 0

		s_movk_i32      s32, 13

.S1_S2_A:
		s_getpc_b64 s[98:99]
		s_add_u32 s98,s98,12
		s_addc_u32 s99,s99,0
		s_branch .S3_S4_A
		
        v_bfi_b32 v90, v119, v116, v117
        v_xor_b32 v98, v116, v117
        v_or_b32  v97, v115, v118
        v_xor_b32 v94, v98, v97
        v_bfi_b32 v93, v94, v90, v119
        v_xor_b32 v92, v118, v93
        v_xor_b32 v108, v115, v92
        v_bfi_b32 v115, v119, v108, v92
        v_bfi_b32 v101, v90, v97, v108
        v_bfi_b32 v100, v119, v94, v98
        v_xor_b32 v101, v101, v100
        v_bfi_b32 v97, v101, v108, v97
        v_bfi_b32 v127, v115, v101, v97
        v_xor_b32 v127, v90, v127
        v_bfi_b32 v112, v127, v90, v118
        v_bfi_b32 v90, v108, v94, v90
        v_bfi_b32 v114, v127, v90, v119
        v_bfi_b32 v97, v97, v92, v94
        v_xor_b32 v97, v114, v97
        v_bfi_b32 v90, v117, v90, v108
        v_bfi_b32 v92, v112, v90, v97
        v_not_b32 v92, v92
        v_bfi_b32 v97, v120, v97, v92
        v_xor_b32 v40, v97, v40
        v_bfi_b32 v114, v114, v117, v92
        v_bfi_b32 v110, v94, v116, v90
        v_bfi_b32 v114, v110, v118, v114
        v_xor_b32 v118, v127, v114
        v_bfi_b32 v90, v120, v108, v118
        v_xor_b32 v48, v90, v48
        v_bfi_b32 v90, v114, v100, v115
        v_bfi_b32 v110, v93, v108, v110
        v_xor_b32 v90, v90, v110
        v_bfi_b32 v90, v120, v127, v90
        v_xor_b32 v62, v90, v62
        v_xor_b32 v108, v108, v118
        v_bfi_b32 v114, v114, v108, v117
        v_bfi_b32 v114, v110, v98, v114
        v_bfi_b32 v114, v120, v101, v114
        v_xor_b32 v54, v114, v54

        v_bfi_b32 v114, v126, v123, v121
        v_bfi_b32 v108, v125, v114, v126
        v_bfi_b32 v105, v108, v124, v123
        v_xor_b32 v105, v121, v105
        v_bfi_b32 v110, v126, v105, v124
        v_not_b32 v117, v110
        v_xor_b32 v114, v114, v117
        v_xor_b32 v118, v126, v125
        v_xor_b32 v90, v114, v118
        v_xor_b32 v98, v105, v118
        v_bfi_b32 v90, v122, v98, v90
        v_xor_b32 v59, v90, v59
        v_xor_b32 v90, v124, v108
        v_bfi_b32 v97, v125, v90, v114
        v_xor_b32 v94, v123, v90
        v_bfi_b32 v97, v121, v94, v97
        v_bfi_b32 v95, v125, v97, v124
        v_bfi_b32 v94, v114, v98, v105
        v_xor_b32 v117, v117, v94
        v_xor_b32 v117, v95, v117
        v_bfi_b32 v93, v122, v97, v117
        v_xor_b32 v44, v93, v44
        v_bfi_b32 v94, v97, v117, v94
        v_bfi_b32 v113, v121, v114, v98
        v_bfi_b32 v108, v108, v123, v113
        v_bfi_b32 v121, v125, v108, v94
        v_bfi_b32 v105, v118, v126, v105
        v_bfi_b32 v114, v105, v90, v114
        v_bfi_b32 v114, v122, v121, v114
        v_xor_b32 v49, v114, v49
        v_bfi_b32 v116, v126, v95, v113
        v_bfi_b32 v114, v118, v117, v97
        v_bfi_b32 v114, v105, v113, v114
        v_bfi_b32 v116, v116, v114, v110
        v_xor_b32 v116, v108, v116
        v_bfi_b32 v116, v122, v116, v114
        v_xor_b32 v33, v116, v33

		s_setpc_b64 s[100:101]



.S3_S4_A:
		s_getpc_b64 s[96:97]
		s_add_u32 s96,s96,12
		s_addc_u32 s97,s97,0
		s_branch .S5_S6_A

        v_bfi_b32 v90, v116, v118, v114
        v_xor_b32 v90, v125, v90
        v_bfi_b32 v98, v120, v90, v116
        v_xor_b32 v97, v120, v90
        v_bfi_b32 v94, v114, v98, v97
        v_bfi_b32 v93, v90, v118, v116
        v_bfi_b32 v92, v98, v114, v93
        v_bfi_b32 v115, v97, v125, v118
        v_xor_b32 v115, v92, v115
        v_bfi_b32 v118, v118, v115, v94
        v_not_b32 v101, v118
        v_bfi_b32 v100, v126, v101, v115
        v_xor_b32 v47, v100, v47
        v_xor_b32 v101, v93, v101
        v_bfi_b32 v94, v97, v94, v101
        v_bfi_b32 v92, v92, v90, v120
        v_xor_b32 v100, v94, v92
        v_bfi_b32 v127, v101, v125, v100
        v_bfi_b32 v118, v116, v120, v118
        v_bfi_b32 v90, v90, v125, v114
        v_bfi_b32 v98, v98, v90, v101
        v_bfi_b32 v98, v127, v118, v98
        v_xor_b32 v101, v100, v118
        v_bfi_b32 v101, v126, v101, v98
        v_xor_b32 v55, v101, v55
        v_bfi_b32 v108, v116, v100, v94
        v_bfi_b32 v96, v114, v93, v90
        v_bfi_b32 v108, v96, v98, v108
        v_bfi_b32 v108, v126, v108, v97
        v_xor_b32 v37, v108, v37
        v_bfi_b32 v108, v92, v120, v94
        v_bfi_b32 v108, v125, v96, v108
        v_xor_b32 v108, v118, v108
        v_xor_b32 v105, v93, v115
        v_bfi_b32 v105, v118, v92, v105
        v_bfi_b32 v114, v126, v105, v108
        v_xor_b32 v61, v114, v61

        v_bfi_b32 v114, v119, v124, v113
        v_xor_b32 v108, v123, v114
        v_bfi_b32 v105, v124, v113, v108
        v_bfi_b32 v96, v114, v108, v105
        v_bfi_b32 v110, v119, v113, v124
        v_bfi_b32 v117, v123, v119, v110
        v_xor_b32 v95, v113, v117
        v_bfi_b32 v95, v122, v95, v119
        v_xor_b32 v105, v105, v95
        v_not_b32 v95, v105
        v_bfi_b32 v96, v122, v96, v95
        v_bfi_b32 v117, v117, v122, v123
        v_xor_b32 v113, v119, v110
        v_bfi_b32 v110, v113, v117, v95
        v_xor_b32 v114, v114, v110
        v_not_b32 v110, v114
        v_bfi_b32 v118, v123, v110, v113
        v_xor_b32 v96, v96, v118
        v_bfi_b32 v105, v112, v105, v96
        v_xor_b32 v41, v105, v41
        v_bfi_b32 v105, v112, v96, v95
        v_xor_b32 v32, v105, v32
        v_bfi_b32 v108, v108, v123, v122
        v_bfi_b32 v108, v113, v108, v117
        v_xor_b32 v113, v110, v96
        v_xor_b32 v108, v108, v113
        v_bfi_b32 v113, v112, v108, v110
        v_xor_b32 v57, v113, v57
        v_bfi_b32 v116, v112, v114, v108
        v_xor_b32 v51, v116, v51
		s_setpc_b64 s[100:101]



.S5_S6_A:
		s_getpc_b64 s[94:95]
		s_add_u32 s94,s94,12
		s_addc_u32 s95,s95,0
		s_branch .S7_S8_A

        v_bfi_b32 v90, v122, v118, v116
        v_not_b32 v98, v90
        v_bfi_b32 v97, v118, v116, v98
        v_xor_b32 v94, v109, v97
        v_xor_b32 v93, v122, v123
        v_xor_b32 v92, v94, v93
        v_bfi_b32 v115, v94, v92, v109
        v_bfi_b32 v101, v115, v90, v123
        v_bfi_b32 v100, v116, v122, v101
        v_bfi_b32 v118, v109, v98, v118
        v_xor_b32 v127, v100, v118
        v_bfi_b32 v112, v94, v127, v93
        v_bfi_b32 v126, v112, v116, v123
        v_bfi_b32 v115, v126, v123, v115
        v_xor_b32 v119, v127, v115
        v_bfi_b32 v127, v121, v127, v119
        v_xor_b32 v56, v127, v56
        v_bfi_b32 v98, v112, v101, v98
        v_bfi_b32 v105, v116, v90, v115
        v_xor_b32 v90, v98, v105
        v_bfi_b32 v101, v121, v92, v90
        v_xor_b32 v45, v101, v45
        v_bfi_b32 v101, v123, v105, v90
        v_bfi_b32 v100, v109, v100, v101
        v_bfi_b32 v117, v92, v109, v118
        v_bfi_b32 v127, v90, v117, v100
        v_bfi_b32 v116, v92, v90, v122
        v_bfi_b32 v105, v116, v93, v105
        v_bfi_b32 v117, v117, v100, v115
        v_xor_b32 v105, v105, v117
        v_bfi_b32 v105, v121, v105, v127
        v_xor_b32 v34, v105, v34
        v_bfi_b32 v105, v98, v119, v94
        v_bfi_b32 v116, v100, v105, v116
        v_bfi_b32 v108, v123, v97, v118
        v_bfi_b32 v105, v126, v92, v94
        v_bfi_b32 v108, v101, v105, v108
        v_bfi_b32 v116, v121, v116, v108
        v_xor_b32 v39, v116, v39

        v_bfi_b32 v116, v120, v124, v111
        v_xor_b32 v108, v114, v116
        v_bfi_b32 v105, v110, v124, v108
        v_xor_b32 v96, v111, v105
        v_xor_b32 v117, v120, v96
        v_bfi_b32 v118, v124, v117, v96
        v_bfi_b32 v90, v118, v96, v124
        v_xor_b32 v90, v110, v90
        v_bfi_b32 v118, v118, v124, v110
        v_xor_b32 v108, v108, v118
        v_bfi_b32 v121, v117, v110, v124
        v_bfi_b32 v95, v108, v121, v90
        v_bfi_b32 v98, v95, v90, v120
        v_not_b32 v97, v117
        v_bfi_b32 v94, v108, v121, v97
        v_bfi_b32 v98, v98, v117, v94
        v_bfi_b32 v97, v125, v98, v97
        v_xor_b32 v35, v97, v35
        v_bfi_b32 v91, v114, v98, v96
        v_bfi_b32 v113, v91, v94, v111
        v_xor_b32 v108, v117, v108
        v_xor_b32 v91, v113, v108
        v_bfi_b32 v108, v125, v91, v108
        v_xor_b32 v50, v108, v50
        v_bfi_b32 v108, v117, v105, v90
        v_bfi_b32 v121, v118, v121, v108
        v_xor_b32 v121, v91, v121
        v_xor_b32 v116, v116, v121
        v_bfi_b32 v110, v94, v98, v120
        v_bfi_b32 v96, v110, v121, v116
        v_not_b32 v96, v96
        v_bfi_b32 v116, v125, v116, v96
        v_xor_b32 v60, v116, v60
        v_bfi_b32 v116, v121, v91, v110
        v_bfi_b32 v108, v105, v108, v113
        v_xor_b32 v116, v116, v108
        v_bfi_b32 v116, v125, v116, v95
        v_xor_b32 v42, v116, v42
		s_setpc_b64 s[100:101]



.S7_S8_A:
        s_getpc_b64 s[92:93]
		s_add_u32 s92,s92,12
		s_addc_u32 s93,s93,0
		s_branch .S1_S2_B
		
		v_bfi_b32 v90, v118, v126, v121
        v_bfi_b32 v98, v124, v118, v123
        v_bfi_b32 v90, v126, v98, v90
        v_bfi_b32 v97, v121, v123, v118
        v_xor_b32 v97, v124, v97
        v_xor_b32 v94, v90, v97
        v_bfi_b32 v90, v124, v90, v121
        v_xor_b32 v93, v121, v118
        v_bfi_b32 v92, v97, v90, v93
        v_xor_b32 v115, v123, v126
        v_xor_b32 v101, v92, v115
        v_bfi_b32 v100, v116, v94, v101
        v_xor_b32 v63, v100, v63
        v_xor_b32 v100, v118, v101
        v_bfi_b32 v127, v93, v126, v100
        v_bfi_b32 v127, v123, v127, v101
        v_not_b32 v108, v126
        v_bfi_b32 v108, v90, v100, v108
        v_bfi_b32 v114, v123, v100, v97
        v_bfi_b32 v114, v115, v93, v114
        v_xor_b32 v114, v98, v114
        v_bfi_b32 v118, v118, v114, v97
        v_xor_b32 v90, v108, v118
        v_bfi_b32 v98, v116, v127, v90
        v_xor_b32 v43, v98, v43
        v_xor_b32 v90, v93, v90
        v_bfi_b32 v118, v118, v90, v127
        v_bfi_b32 v108, v108, v94, v118
        v_bfi_b32 v114, v116, v114, v108
        v_xor_b32 v53, v114, v53
        v_bfi_b32 v114, v92, v101, v100
        v_xor_b32 v108, v100, v90
        v_bfi_b32 v114, v124, v108, v114
        v_bfi_b32 v108, v101, v94, v127
        v_bfi_b32 v108, v108, v121, v114
        v_not_b32 v108, v108
        v_bfi_b32 v114, v116, v108, v114
        v_xor_b32 v38, v114, v38

        v_bfi_b32 v114, v111, v122, v125
        v_bfi_b32 v108, v119, v111, v112
        v_bfi_b32 v110, v125, v119, v111
        v_xor_b32 v110, v122, v110
        v_bfi_b32 v114, v108, v114, v110
        v_xor_b32 v108, v112, v114
        v_bfi_b32 v96, v110, v111, v108
        v_bfi_b32 v110, v125, v122, v110
        v_bfi_b32 v121, v110, v119, v96
        v_bfi_b32 v110, v112, v110, v111
        v_bfi_b32 v96, v110, v108, v119
        v_bfi_b32 v95, v112, v111, v125
        v_xor_b32 v117, v96, v95
        v_xor_b32 v118, v121, v117
        v_bfi_b32 v90, v120, v117, v118
        v_xor_b32 v46, v90, v46
        v_bfi_b32 v113, v111, v118, v95
        v_bfi_b32 v118, v113, v112, v114
        v_xor_b32 v113, v110, v113
        v_xor_b32 v110, v108, v113
        v_not_b32 v90, v110
        v_bfi_b32 v98, v121, v118, v90
        v_xor_b32 v113, v113, v98
        v_bfi_b32 v108, v120, v108, v113
        v_xor_b32 v58, v108, v58
        v_bfi_b32 v108, v118, v95, v96
        v_bfi_b32 v108, v117, v108, v114
        v_xor_b32 v108, v90, v108
        v_bfi_b32 v108, v120, v108, v90
        v_xor_b32 v52, v108, v52
        v_or_b32 v108, v119, v121
        v_xor_b32 v108, v98, v108
        v_bfi_b32 v116, v117, v112, v114
        v_xor_b32 v116, v108, v116
        v_bfi_b32 v116, v120, v110, v116
        v_xor_b32 v36, v116, v36
		s_setpc_b64 s[100:101]
		


.S1_S2_B:
        s_getpc_b64 s[90:91]
		s_add_u32 s90,s90,12
		s_addc_u32 s91,s91,0
		s_branch .S3_S4_B
		
        v_bfi_b32 v90, v126, v118, v105
        v_xor_b32 v98, v105, v118
        v_or_b32 v97, v108, v116
        v_xor_b32 v94, v98, v97
        v_bfi_b32 v93, v94, v90, v126
        v_xor_b32 v92, v116, v93
        v_xor_b32 v113, v108, v92
        v_bfi_b32 v115, v126, v113, v92
        v_bfi_b32 v101, v90, v97, v113
        v_bfi_b32 v100, v126, v94, v98
        v_xor_b32 v101, v101, v100
        v_bfi_b32 v97, v101, v113, v97
        v_bfi_b32 v127, v115, v101, v97
        v_xor_b32 v127, v90, v127
        v_bfi_b32 v112, v127, v90, v116
        v_bfi_b32 v90, v113, v94, v90
        v_bfi_b32 v108, v127, v90, v126
        v_bfi_b32 v97, v97, v92, v94
        v_xor_b32 v97, v108, v97
        v_bfi_b32 v90, v105, v90, v113
        v_bfi_b32 v92, v112, v90, v97
        v_not_b32 v92, v92
        v_bfi_b32 v108, v108, v105, v92
        v_bfi_b32 v118, v94, v118, v90
        v_bfi_b32 v108, v118, v116, v108
        v_xor_b32 v96, v127, v108
        v_xor_b32 v90, v113, v96
        v_bfi_b32 v117, v108, v90, v105
        v_bfi_b32 v118, v93, v113, v118
        v_bfi_b32 v117, v118, v98, v117
        v_bfi_b32 v117, v119, v101, v117
        v_xor_b32 v22, v22, v117
        v_bfi_b32 v117, v119, v97, v92
        v_xor_b32 v8, v8, v117
        v_bfi_b32 v113, v119, v113, v96
        v_xor_b32 v16, v16, v113
        v_bfi_b32 v108, v108, v100, v115
        v_xor_b32 v108, v118, v108
        v_bfi_b32 v108, v119, v127, v108
        v_xor_b32 v30, v30, v108

        v_bfi_b32 v108, v103, v102, v114
        v_bfi_b32 v113, v104, v108, v103
        v_bfi_b32 v91, v113, v107, v102
        v_xor_b32 v91, v114, v91
        v_bfi_b32 v96, v103, v91, v107
        v_not_b32 v117, v96
        v_xor_b32 v108, v108, v117
        v_xor_b32 v118, v103, v104
        v_xor_b32 v90, v91, v118
        v_bfi_b32 v98, v114, v108, v90
        v_xor_b32 v97, v107, v113
        v_bfi_b32 v94, v104, v97, v108
        v_xor_b32 v93, v102, v97
        v_bfi_b32 v114, v114, v93, v94
        v_bfi_b32 v121, v104, v114, v107
        v_bfi_b32 v94, v103, v121, v98
        v_bfi_b32 v93, v108, v90, v91
        v_xor_b32 v117, v117, v93
        v_xor_b32 v121, v121, v117
        v_bfi_b32 v117, v118, v121, v114
        v_bfi_b32 v91, v118, v103, v91
        v_bfi_b32 v105, v91, v98, v117
        v_bfi_b32 v96, v94, v105, v96
        v_bfi_b32 v113, v113, v102, v98
        v_xor_b32 v95, v96, v113
        v_bfi_b32 v105, v106, v95, v105
        v_xor_b32 v1, v1, v105
        v_bfi_b32 v105, v106, v114, v121
        v_xor_b32 v12, v12, v105
        v_bfi_b32 v114, v114, v121, v93
        v_bfi_b32 v114, v104, v113, v114
        v_bfi_b32 v113, v91, v97, v108
        v_bfi_b32 v114, v106, v114, v113
        v_xor_b32 v17, v17, v114
        v_xor_b32 v114, v108, v118
        v_bfi_b32 v116, v106, v90, v114
        v_xor_b32 v27, v27, v116
		s_setpc_b64 s[100:101]



.S3_S4_B:
        s_getpc_b64 s[88:89]
		s_add_u32 s88,s88,12
		s_addc_u32 s89,s89,0
		s_branch .S5_S6_B

        v_bfi_b32 v90, v102, v110, v116
        v_xor_b32 v90, v104, v90
        v_bfi_b32 v98, v118, v90, v102
        v_xor_b32 v97, v118, v90
        v_bfi_b32 v94, v116, v98, v97
        v_bfi_b32 v93, v90, v110, v102
        v_bfi_b32 v92, v98, v116, v93
        v_bfi_b32 v115, v97, v104, v110
        v_xor_b32 v115, v92, v115
        v_bfi_b32 v117, v110, v115, v94
        v_not_b32 v101, v117
        v_xor_b32 v100, v93, v101
        v_bfi_b32 v94, v97, v94, v100
        v_bfi_b32 v92, v92, v90, v118
        v_xor_b32 v127, v94, v92
        v_bfi_b32 v112, v100, v104, v127
        v_bfi_b32 v117, v102, v118, v117
        v_bfi_b32 v90, v90, v104, v116
        v_bfi_b32 v98, v98, v90, v100
        v_bfi_b32 v98, v112, v117, v98
        v_xor_b32 v100, v127, v117
        v_bfi_b32 v100, v125, v100, v98
        v_xor_b32 v23, v23, v100
        v_bfi_b32 v105, v102, v127, v94
        v_bfi_b32 v96, v116, v93, v90
        v_bfi_b32 v105, v96, v98, v105
        v_bfi_b32 v105, v125, v105, v97
        v_xor_b32 v5, v5, v105
        v_bfi_b32 v105, v92, v118, v94
        v_bfi_b32 v113, v104, v96, v105
        v_xor_b32 v113, v117, v113
        v_xor_b32 v105, v93, v115
        v_bfi_b32 v105, v117, v92, v105
        v_bfi_b32 v113, v125, v105, v113
        v_xor_b32 v29, v29, v113

        v_bfi_b32 v113, v103, v119, v122
        v_bfi_b32 v105, v126, v103, v113
        v_bfi_b32 v96, v105, v106, v126
        v_bfi_b32 v117, v103, v122, v119
        v_xor_b32 v118, v126, v117
        v_bfi_b32 v90, v118, v126, v106
        v_xor_b32 v113, v103, v113
        v_bfi_b32 v90, v113, v90, v96
        v_bfi_b32 v110, v122, v119, v118
        v_bfi_b32 v118, v117, v118, v110
        v_xor_b32 v105, v119, v105
        v_bfi_b32 v108, v106, v105, v103
        v_xor_b32 v108, v110, v108
        v_not_b32 v105, v108
        v_bfi_b32 v116, v106, v118, v105
        v_bfi_b32 v110, v113, v96, v105
        v_xor_b32 v110, v117, v110
        v_not_b32 v95, v110
        v_bfi_b32 v113, v126, v95, v113
        v_xor_b32 v116, v116, v113
        v_xor_b32 v113, v95, v116
        v_xor_b32 v113, v90, v113
        v_bfi_b32 v110, v107, v110, v113
        v_xor_b32 v19, v19, v110
        v_bfi_b32 v113, v107, v113, v95
        v_xor_b32 v25, v25, v113
        v_bfi_b32 v114, v125, v101, v115
        v_xor_b32 v15, v15, v114
        v_bfi_b32 v114, v107, v116, v105
        v_xor_b32 v0, v0, v114
        v_bfi_b32 v116, v107, v108, v116
        v_xor_b32 v9, v9, v116
		s_setpc_b64 s[100:101]



.S5_S6_B:
        s_getpc_b64 s[86:87]
		s_add_u32 s86,s86,12
		s_addc_u32 s87,s87,0
		s_branch .S7_S8_B

        v_bfi_b32 v90, v104, v121, v103
        v_not_b32 v98, v90
        v_bfi_b32 v97, v121, v103, v98
        v_xor_b32 v94, v118, v97
        v_xor_b32 v93, v104, v107
        v_xor_b32 v92, v94, v93
        v_bfi_b32 v115, v94, v92, v118
        v_bfi_b32 v101, v115, v90, v107
        v_bfi_b32 v100, v103, v104, v101
        v_bfi_b32 v117, v118, v98, v121
        v_xor_b32 v127, v100, v117
        v_bfi_b32 v112, v94, v127, v93
        v_bfi_b32 v98, v112, v101, v98
        v_bfi_b32 v101, v112, v103, v107
        v_bfi_b32 v115, v101, v107, v115
        v_xor_b32 v112, v127, v115
        v_bfi_b32 v126, v98, v112, v94
        v_bfi_b32 v108, v103, v90, v115
        v_xor_b32 v90, v98, v108
        v_bfi_b32 v91, v92, v90, v104
        v_bfi_b32 v98, v107, v108, v90
        v_bfi_b32 v100, v118, v100, v98
        v_bfi_b32 v126, v100, v126, v91
        v_bfi_b32 v105, v107, v97, v117
        v_bfi_b32 v97, v101, v92, v94
        v_bfi_b32 v105, v98, v97, v105
        v_bfi_b32 v105, v122, v126, v105
        v_xor_b32 v7, v7, v105
        v_bfi_b32 v105, v92, v118, v117
        v_bfi_b32 v117, v90, v105, v100
        v_bfi_b32 v108, v91, v93, v108
        v_bfi_b32 v91, v105, v100, v115
        v_xor_b32 v108, v108, v91
        v_bfi_b32 v108, v122, v108, v117
        v_xor_b32 v2, v2, v108

        v_bfi_b32 v108, v102, v119, v123
        v_xor_b32 v91, v106, v108
        v_bfi_b32 v105, v110, v119, v91
        v_xor_b32 v117, v123, v105
        v_xor_b32 v118, v102, v117
        v_bfi_b32 v98, v119, v118, v117
        v_bfi_b32 v97, v98, v119, v110
        v_bfi_b32 v98, v98, v117, v119
        v_xor_b32 v98, v110, v98
        v_bfi_b32 v94, v118, v105, v98
        v_bfi_b32 v121, v118, v110, v119
        v_bfi_b32 v95, v97, v121, v94
        v_xor_b32 v91, v91, v97
        v_bfi_b32 v97, v91, v121, v98
        v_bfi_b32 v98, v97, v98, v102
        v_not_b32 v93, v118
        v_bfi_b32 v121, v91, v121, v93
        v_bfi_b32 v98, v98, v118, v121
        v_bfi_b32 v116, v106, v98, v117
        v_bfi_b32 v116, v116, v121, v123
        v_xor_b32 v114, v118, v91
        v_xor_b32 v91, v116, v114
        v_xor_b32 v95, v95, v91
        v_xor_b32 v108, v108, v95
        v_bfi_b32 v110, v121, v98, v102
        v_bfi_b32 v121, v110, v95, v108
        v_not_b32 v121, v121
        v_bfi_b32 v108, v125, v108, v121
        v_xor_b32 v28, v28, v108
        v_bfi_b32 v108, v122, v92, v90
        v_xor_b32 v13, v13, v108
        v_bfi_b32 v108, v95, v91, v110
        v_bfi_b32 v116, v105, v94, v116
        v_xor_b32 v116, v108, v116
        v_bfi_b32 v116, v125, v116, v97
        v_xor_b32 v10, v10, v116
        v_bfi_b32 v116, v125, v98, v93
        v_xor_b32 v3, v3, v116
        v_bfi_b32 v116, v122, v127, v112
        v_xor_b32 v24, v24, v116
        v_bfi_b32 v116, v125, v91, v114
        v_xor_b32 v18, v18, v116
		s_setpc_b64 s[100:101]



.S7_S8_B:
        s_getpc_b64 s[84:85]
		s_add_u32 s84,s84,12
		s_addc_u32 s85,s85,0
		s_branch .startLoop

        v_bfi_b32 v90, v102, v113, v114
        v_bfi_b32 v98, v103, v102, v101
        v_bfi_b32 v97, v114, v103, v102
        v_xor_b32 v97, v113, v97
        v_bfi_b32 v90, v98, v90, v97
        v_xor_b32 v98, v101, v90
        v_bfi_b32 v94, v97, v102, v98
        v_bfi_b32 v121, v114, v113, v97
        v_bfi_b32 v97, v121, v103, v94
        v_bfi_b32 v121, v101, v121, v102
        v_bfi_b32 v94, v121, v98, v103
        v_bfi_b32 v95, v101, v102, v114
        v_xor_b32 v93, v94, v95
        v_xor_b32 v92, v97, v93
        v_bfi_b32 v110, v102, v92, v95
        v_bfi_b32 v115, v110, v101, v90
        v_bfi_b32 v95, v115, v95, v94
        v_bfi_b32 v95, v93, v95, v90
        v_xor_b32 v110, v121, v110
        v_xor_b32 v121, v98, v110
        v_not_b32 v94, v121
        v_xor_b32 v95, v95, v94
        v_bfi_b32 v95, v104, v95, v94
        v_xor_b32 v20, v20, v95
        v_bfi_b32 v95, v97, v115, v94
        v_xor_b32 v110, v110, v95
        v_bfi_b32 v110, v104, v98, v110
        v_xor_b32 v26, v26, v110
        v_or_b32 v113, v103, v97
        v_xor_b32 v113, v95, v113
        v_bfi_b32 v114, v93, v101, v90
        v_xor_b32 v114, v113, v114
        v_bfi_b32 v114, v104, v121, v114
        v_xor_b32 v4, v4, v114
        v_bfi_b32 v114, v118, v112, v127
        v_bfi_b32 v113, v100, v118, v107
        v_bfi_b32 v114, v112, v113, v114
        v_bfi_b32 v110, v100, v114, v127
        v_bfi_b32 v121, v127, v107, v118
        v_xor_b32 v121, v100, v121

        v_xor_b32 v95, v127, v118
        v_bfi_b32 v90, v121, v110, v95
        v_xor_b32 v98, v112, v107
        v_xor_b32 v97, v90, v98
        v_xor_b32 v94, v118, v97
        v_bfi_b32 v90, v90, v97, v94
        v_not_b32 v115, v112
        v_bfi_b32 v110, v110, v94, v115
        v_bfi_b32 v115, v107, v94, v121
        v_bfi_b32 v98, v98, v95, v115
        v_xor_b32 v113, v113, v98
        v_bfi_b32 v118, v118, v113, v121
        v_xor_b32 v98, v110, v118
        v_xor_b32 v115, v95, v98
        v_xor_b32 v101, v94, v115
        v_bfi_b32 v96, v100, v101, v90
        v_bfi_b32 v108, v95, v112, v94
        v_bfi_b32 v108, v107, v108, v97
        v_xor_b32 v114, v114, v121
        v_bfi_b32 v105, v97, v114, v108
        v_bfi_b32 v105, v105, v127, v96
        v_not_b32 v105, v105
        v_bfi_b32 v105, v106, v105, v96
        v_xor_b32 v6, v6, v105
        v_bfi_b32 v91, v104, v93, v92
        v_xor_b32 v14, v14, v91
        v_bfi_b32 v91, v106, v108, v98
        v_xor_b32 v11, v11, v91
        v_bfi_b32 v108, v118, v115, v108
        v_bfi_b32 v108, v110, v114, v108
        v_bfi_b32 v108, v106, v113, v108
        v_xor_b32 v21, v21, v108
        v_bfi_b32 v116, v106, v114, v97
        v_xor_b32 v31, v31, v116
		s_setpc_b64 s[100:101]
		
		/*	
		DB_EF00 = %v31
		DB_EF01 = %v0
		DB_EF02 = %v1
		DB_EF03 = %v2
		DB_EF04 = %v3
		DB_EF05 = %v4
		DB_EF06 = %v3
		DB_EF07 = %v4
		DB_EF08 = %v5
		DB_EF09 = %v6
		DB_EF10 = %v7
		DB_EF11 = %v8
		
        DB_EF24 = %v15
        DB_EF25 = %v16
        DB_EF26 = %v17
        DB_EF27 = %v18
        DB_EF28 = %v19
        DB_EF29 = %v20
        DB_EF30 = %v19
        DB_EF31 = %v20	
        DB_EF32 = %v21
        DB_EF33 = %v22
        DB_EF34 = %v23
        DB_EF35 = %v24
		
        DB_EF48 = %v63
        DB_EF49 = %v32
        DB_EF50 = %v33
        DB_EF51 = %v34
        DB_EF52 = %v35
        DB_EF53 = %v36
        DB_EF54 = %v35
        DB_EF55 = %v36
        DB_EF56 = %v37
        DB_EF57 = %v38
        DB_EF58 = %v39
        DB_EF59 = %v40
		
        DB_EF72 = %v47
        DB_EF73 = %v48
        DB_EF74 = %v49
        DB_EF75 = %v50
        DB_EF76 = %v51
        DB_EF77 = %v52
        DB_EF78 = %v51
        DB_EF79 = %v52
        DB_EF80 = %v53
        DB_EF81 = %v54
        DB_EF82 = %v55
        DB_EF83 = %v56
		*/

		K00 = %s0
		K01 = %s1
		K02 = %s2
		K03 = %s3
		K04 = %s4
		K05 = %s5
		K06 = %s6
		K07 = %s7
		K08 = %s8
		K09 = %s9
		K10 = %s10
		K11 = %s11
		K12 = %s12
		K13 = %s13
		K14 = %s14
		K15 = %s15
		K16 = %s16
		K17 = %s17
		K18 = %s18
		K19 = %s19
		K20 = %s20
		K21 = %s21
		K22 = %s22
		K23 = %s23
		K24 = %s24
		K25 = %s25
		K26 = %s26
		K27 = %s27
			
		K28 = %v64
		K29 = %v65
		K30 = %v66
		K31 = %v67
		K32 = %v68
		K33 = %v69
		K34 = %v70
		K35 = %v71
		K36 = %v72
		K37 = %v73
		K38 = %v74
		K39 = %v75
		K40 = %v76
		K41 = %v77
		K42 = %v78
		K43 = %v79
		K44 = %v80
		K45 = %v81
		K46 = %v82
		K47 = %v83
		K48 = %v84

		K49 = 0xaaaaaaaa
		K50 = 0x33333333
		K51 = 0xc3c3c3c3
		K52 = 0xfc03fc03
		K53 = 0xfffc0003
		K54 = 0xfffffffc
		K55 = 0xffffffff
.startLoop:

		/*******/
		/* A 0 */
		/*******/

        v_xor_b32 v115, K12, DB_EF00
        v_xor_b32 v116, K46, DB_EF01
        v_xor_b32 v117, K33, DB_EF02
        v_xor_b32 v118, K52, DB_EF03
        v_xor_b32 v119, K48, DB_EF04
        v_xor_b32 v120, K20, DB_EF05
        v_xor_b32 v121, K34, DB_EF06
        v_xor_b32 v122, K55, DB_EF07
        v_xor_b32 v123, K05, DB_EF08
        v_xor_b32 v124, K13, DB_EF09
        v_xor_b32 v125, K18, DB_EF10
        v_xor_b32 v126, K40, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K04, v7
        v_xor_b32 v120, K32, v8
        v_xor_b32 v118, K26, v9
        v_xor_b32 v114, K27, v10
        v_xor_b32 v116, K38, v11
        v_xor_b32 v125, K54, v12
        v_xor_b32 v119, K53, v11
        v_xor_b32 v122, K06, v12
        v_xor_b32 v113, K31, v13
        v_xor_b32 v123, K25, v14
        v_xor_b32 v124, K19, v15
        v_xor_b32 v112, K41, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K15, DB_EF24
        v_xor_b32 v109, K24, DB_EF25
        v_xor_b32 v118, K28, DB_EF26
        v_xor_b32 v121, K43, DB_EF27
        v_xor_b32 v122, K30, DB_EF28
        v_xor_b32 v123, K03, DB_EF29
        v_xor_b32 v111, K35, DB_EF30
        v_xor_b32 v114, K22, DB_EF31
        v_xor_b32 v110, K02, DB_EF32
        v_xor_b32 v124, K44, DB_EF33
        v_xor_b32 v120, K14, DB_EF34
        v_xor_b32 v125, K23, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K51, v23
        v_xor_b32 v118, K16, v24
        v_xor_b32 v121, K29, v25
        v_xor_b32 v124, K49, v26
        v_xor_b32 v126, K07, v27
        v_xor_b32 v123, K17, v28
        v_xor_b32 v119, K37, v27
        v_xor_b32 v112, K08, v28
        v_xor_b32 v125, K09, v29
        v_xor_b32 v122, K50, v30
        v_xor_b32 v111, K42, v31
        v_xor_b32 v120, K21, v0
        s_swappc_b64 s[100:101], s[92:93]

		/*******/
		/* B 1 */
		/*******/

        v_xor_b32 v108, K05, DB_EF48
        v_xor_b32 v118, K39, DB_EF49
        v_xor_b32 v105, K26, DB_EF50
        v_xor_b32 v116, K45, DB_EF51
        v_xor_b32 v126, K41, DB_EF52
        v_xor_b32 v119, K13, DB_EF53
        v_xor_b32 v114, K27, DB_EF54
        v_xor_b32 v106, K48, DB_EF55
        v_xor_b32 v102, K53, DB_EF56
        v_xor_b32 v107, K06, DB_EF57
        v_xor_b32 v104, K11, DB_EF58
        v_xor_b32 v103, K33, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K52, v39
        v_xor_b32 v118, K25, v40
        v_xor_b32 v110, K19, v41	
        v_xor_b32 v116, K20, v42
        v_xor_b32 v102, K31, v43
        v_xor_b32 v104, K47, v44
        v_xor_b32 v103, K46, v43
        v_xor_b32 v106, K54, v44
        v_xor_b32 v119, K55, v45
        v_xor_b32 v126, K18, v46
        v_xor_b32 v122, K12, v47
        v_xor_b32 v107, K34, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K08, DB_EF72
        v_xor_b32 v118, K17, DB_EF73
        v_xor_b32 v121, K21, DB_EF74
        v_xor_b32 v122, K36, DB_EF75
        v_xor_b32 v104, K23, DB_EF76
        v_xor_b32 v107, K49, DB_EF77
        v_xor_b32 v123, K28, DB_EF78
        v_xor_b32 v106, K15, DB_EF79
        v_xor_b32 v110, K24, DB_EF80
        v_xor_b32 v119, K37, DB_EF81
		v_xor_b32 v102, K07, DB_EF82
        v_xor_b32 v125, K16, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K44, v55
        v_xor_b32 v118, K09, v56
        v_xor_b32 v127, K22, v57
        v_xor_b32 v100, K42, v58
        v_xor_b32 v112, K00, v59
        v_xor_b32 v107, K10, v60
        v_xor_b32 v103, K30, v59
        v_xor_b32 v101, K01, v60
        v_xor_b32 v114, K02, v61
        v_xor_b32 v113, K43, v62
        v_xor_b32 v102, K35, v63
        v_xor_b32 v104, K14, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*******/
		/* A 2 */
		/*******/

        v_xor_b32 v115, K46, DB_EF00
        v_xor_b32 v116, K25, DB_EF01
        v_xor_b32 v117, K12, DB_EF02
        v_xor_b32 v118, K31, DB_EF03
        v_xor_b32 v119, K27, DB_EF04
        v_xor_b32 v120, K54, DB_EF05
        v_xor_b32 v121, K13, DB_EF06
        v_xor_b32 v122, K34, DB_EF07
        v_xor_b32 v123, K39, DB_EF08
        v_xor_b32 v124, K47, DB_EF09
        v_xor_b32 v125, K52, DB_EF10
        v_xor_b32 v126, K19, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K38, v7
        v_xor_b32 v120, K11, v8
        v_xor_b32 v118, K05, v9
        v_xor_b32 v114, K06, v10
        v_xor_b32 v116, K48, v11
        v_xor_b32 v125, K33, v12
        v_xor_b32 v119, K32, v11
        v_xor_b32 v122, K40, v12
        v_xor_b32 v113, K41, v13
        v_xor_b32 v123, K04, v14
        v_xor_b32 v124, K53, v15
        v_xor_b32 v112, K20, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K51, DB_EF24
        v_xor_b32 v109, K03, DB_EF25
        v_xor_b32 v118, K07, DB_EF26
        v_xor_b32 v121, K22, DB_EF27
        v_xor_b32 v122, K09, DB_EF28
        v_xor_b32 v123, K35, DB_EF29
        v_xor_b32 v111, K14, DB_EF30
        v_xor_b32 v114, K01, DB_EF31
        v_xor_b32 v110, K10, DB_EF32
        v_xor_b32 v124, K23, DB_EF33
        v_xor_b32 v120, K50, DB_EF34
        v_xor_b32 v125, K02, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K30, v23
        v_xor_b32 v118, K24, v24
        v_xor_b32 v121, K08, v25
        v_xor_b32 v124, K28, v26
        v_xor_b32 v126, K43, v27
        v_xor_b32 v123, K49, v28
        v_xor_b32 v119, K16, v27
        v_xor_b32 v112, K44, v28
        v_xor_b32 v125, K17, v29
        v_xor_b32 v122, K29, v30
        v_xor_b32 v111, K21, v31
        v_xor_b32 v120, K00, v0
        s_swappc_b64 s[100:101], s[92:93]

		/*******/
		/* B 3 */
		/*******/

        v_xor_b32 v108, K32, DB_EF48
        v_xor_b32 v118, K11, DB_EF49
        v_xor_b32 v105, K53, DB_EF50
        v_xor_b32 v116, K48, DB_EF51
        v_xor_b32 v126, K13, DB_EF52
        v_xor_b32 v119, K40, DB_EF53
        v_xor_b32 v114, K54, DB_EF54
        v_xor_b32 v106, K20, DB_EF55
        v_xor_b32 v102, K25, DB_EF56
        v_xor_b32 v107, K33, DB_EF57
        v_xor_b32 v104, K38, DB_EF58
        v_xor_b32 v103, K05, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K55, v39
        v_xor_b32 v118, K52, v40
        v_xor_b32 v110, K46, v41	
        v_xor_b32 v116, K47, v42
        v_xor_b32 v102, K34, v43
        v_xor_b32 v104, K19, v44
        v_xor_b32 v103, K18, v43
        v_xor_b32 v106, K26, v44
        v_xor_b32 v119, K27, v45
        v_xor_b32 v126, K45, v46
        v_xor_b32 v122, K39, v47
        v_xor_b32 v107, K06, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K37, DB_EF72
        v_xor_b32 v118, K42, DB_EF73
        v_xor_b32 v121, K50, DB_EF74
        v_xor_b32 v122, K08, DB_EF75
        v_xor_b32 v104, K24, DB_EF76
        v_xor_b32 v107, K21, DB_EF77
        v_xor_b32 v123, K00, DB_EF78
        v_xor_b32 v106, K44, DB_EF79
        v_xor_b32 v110, K49, DB_EF80
        v_xor_b32 v119, K09, DB_EF81
		v_xor_b32 v102, K36, DB_EF82
        v_xor_b32 v125, K17, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K16, v55
        v_xor_b32 v118, K10, v56
        v_xor_b32 v127, K51, v57
        v_xor_b32 v100, K14, v58
        v_xor_b32 v112, K29, v59
        v_xor_b32 v107, K35, v60
        v_xor_b32 v103, K02, v59
        v_xor_b32 v101, K30, v60
        v_xor_b32 v114, K03, v61
        v_xor_b32 v113, K15, v62
        v_xor_b32 v102, K07, v63
        v_xor_b32 v104, K43, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*******/
		/* A 4 */
		/*******/

        v_xor_b32 v115, K18, DB_EF00
        v_xor_b32 v116, K52, DB_EF01
        v_xor_b32 v117, K39, DB_EF02
        v_xor_b32 v118, K34, DB_EF03
        v_xor_b32 v119, K54, DB_EF04
        v_xor_b32 v120, K26, DB_EF05
        v_xor_b32 v121, K40, DB_EF06
        v_xor_b32 v122, K06, DB_EF07
        v_xor_b32 v123, K11, DB_EF08
        v_xor_b32 v124, K19, DB_EF09
        v_xor_b32 v125, K55, DB_EF10
        v_xor_b32 v126, K46, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K41, v7
        v_xor_b32 v120, K38, v8
        v_xor_b32 v118, K32, v9
        v_xor_b32 v114, K33, v10
        v_xor_b32 v116, K20, v11
        v_xor_b32 v125, K05, v12
        v_xor_b32 v119, K04, v11
        v_xor_b32 v122, K12, v12
        v_xor_b32 v113, K13, v13
        v_xor_b32 v123, K31, v14
        v_xor_b32 v124, K25, v15
        v_xor_b32 v112, K47, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K23, DB_EF24
        v_xor_b32 v109, K28, DB_EF25
        v_xor_b32 v118, K36, DB_EF26
        v_xor_b32 v121, K51, DB_EF27
        v_xor_b32 v122, K10, DB_EF28
        v_xor_b32 v123, K07, DB_EF29
        v_xor_b32 v111, K43, DB_EF30
        v_xor_b32 v114, K30, DB_EF31
        v_xor_b32 v110, K35, DB_EF32
        v_xor_b32 v124, K24, DB_EF33
        v_xor_b32 v120, K22, DB_EF34
        v_xor_b32 v125, K03, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K02, v23
        v_xor_b32 v118, K49, v24
        v_xor_b32 v121, K37, v25
        v_xor_b32 v124, K00, v26
        v_xor_b32 v126, K15, v27
        v_xor_b32 v123, K21, v28
        v_xor_b32 v119, K17, v27
        v_xor_b32 v112, K16, v28
        v_xor_b32 v125, K42, v29
        v_xor_b32 v122, K01, v30
        v_xor_b32 v111, K50, v31
        v_xor_b32 v120, K29, v0
        s_swappc_b64 s[100:101], s[92:93]

		/*******/
		/* B 5 */
		/*******/

        v_xor_b32 v108, K04, DB_EF48
        v_xor_b32 v118, K38, DB_EF49
        v_xor_b32 v105, K25, DB_EF50
        v_xor_b32 v116, K20, DB_EF51
        v_xor_b32 v126, K40, DB_EF52
        v_xor_b32 v119, K12, DB_EF53
        v_xor_b32 v114, K26, DB_EF54
        v_xor_b32 v106, K47, DB_EF55
        v_xor_b32 v102, K52, DB_EF56
        v_xor_b32 v107, K05, DB_EF57
        v_xor_b32 v104, K41, DB_EF58
        v_xor_b32 v103, K32, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K27, v39
        v_xor_b32 v118, K55, v40
        v_xor_b32 v110, K18, v41	
        v_xor_b32 v116, K19, v42
        v_xor_b32 v102, K06, v43
        v_xor_b32 v104, K46, v44
        v_xor_b32 v103, K45, v43
        v_xor_b32 v106, K53, v44
        v_xor_b32 v119, K54, v45
        v_xor_b32 v126, K48, v46
        v_xor_b32 v122, K11, v47
        v_xor_b32 v107, K33, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K09, DB_EF72
        v_xor_b32 v118, K14, DB_EF73
        v_xor_b32 v121, K22, DB_EF74
        v_xor_b32 v122, K37, DB_EF75
        v_xor_b32 v104, K49, DB_EF76
        v_xor_b32 v107, K50, DB_EF77
        v_xor_b32 v123, K29, DB_EF78
        v_xor_b32 v106, K16, DB_EF79
        v_xor_b32 v110, K21, DB_EF80
        v_xor_b32 v119, K10, DB_EF81
		v_xor_b32 v102, K08, DB_EF82
        v_xor_b32 v125, K42, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K17, v55
        v_xor_b32 v118, K35, v56
        v_xor_b32 v127, K23, v57
        v_xor_b32 v100, K43, v58
        v_xor_b32 v112, K01, v59
        v_xor_b32 v107, K07, v60
        v_xor_b32 v103, K03, v59
        v_xor_b32 v101, K02, v60
        v_xor_b32 v114, K28, v61
        v_xor_b32 v113, K44, v62
        v_xor_b32 v102, K36, v63
        v_xor_b32 v104, K15, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*******/
		/* A 6 */
		/*******/

        v_xor_b32 v115, K45, DB_EF00
        v_xor_b32 v116, K55, DB_EF01
        v_xor_b32 v117, K11, DB_EF02
        v_xor_b32 v118, K06, DB_EF03
        v_xor_b32 v119, K26, DB_EF04
        v_xor_b32 v120, K53, DB_EF05
        v_xor_b32 v121, K12, DB_EF06
        v_xor_b32 v122, K33, DB_EF07
        v_xor_b32 v123, K38, DB_EF08
        v_xor_b32 v124, K46, DB_EF09
        v_xor_b32 v125, K27, DB_EF10
        v_xor_b32 v126, K18, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K13, v7
        v_xor_b32 v120, K41, v8
        v_xor_b32 v118, K04, v9
        v_xor_b32 v114, K05, v10
        v_xor_b32 v116, K47, v11
        v_xor_b32 v125, K32, v12
        v_xor_b32 v119, K31, v11
        v_xor_b32 v122, K39, v12
        v_xor_b32 v113, K40, v13
        v_xor_b32 v123, K34, v14
        v_xor_b32 v124, K52, v15
        v_xor_b32 v112, K19, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K24, DB_EF24
        v_xor_b32 v109, K00, DB_EF25
        v_xor_b32 v118, K08, DB_EF26
        v_xor_b32 v121, K23, DB_EF27
        v_xor_b32 v122, K35, DB_EF28
        v_xor_b32 v123, K36, DB_EF29
        v_xor_b32 v111, K15, DB_EF30
        v_xor_b32 v114, K02, DB_EF31
        v_xor_b32 v110, K07, DB_EF32
        v_xor_b32 v124, K49, DB_EF33
        v_xor_b32 v120, K51, DB_EF34
        v_xor_b32 v125, K28, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K03, v23
        v_xor_b32 v118, K21, v24
        v_xor_b32 v121, K09, v25
        v_xor_b32 v124, K29, v26
        v_xor_b32 v126, K44, v27
        v_xor_b32 v123, K50, v28
        v_xor_b32 v119, K42, v27
        v_xor_b32 v112, K17, v28
        v_xor_b32 v125, K14, v29
        v_xor_b32 v122, K30, v30
        v_xor_b32 v111, K22, v31
        v_xor_b32 v120, K01, v0
        s_swappc_b64 s[100:101], s[92:93]

		/*******/
		/* B 7 */
		/*******/

        v_xor_b32 v108, K31, DB_EF48
        v_xor_b32 v118, K41, DB_EF49
        v_xor_b32 v105, K52, DB_EF50
        v_xor_b32 v116, K47, DB_EF51
        v_xor_b32 v126, K12, DB_EF52
        v_xor_b32 v119, K39, DB_EF53
        v_xor_b32 v114, K53, DB_EF54
        v_xor_b32 v106, K19, DB_EF55
        v_xor_b32 v102, K55, DB_EF56
        v_xor_b32 v107, K32, DB_EF57
        v_xor_b32 v104, K13, DB_EF58
        v_xor_b32 v103, K04, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K54, v39
        v_xor_b32 v118, K27, v40
        v_xor_b32 v110, K45, v41	
        v_xor_b32 v116, K46, v42
        v_xor_b32 v102, K33, v43
        v_xor_b32 v104, K18, v44
        v_xor_b32 v103, K48, v43
        v_xor_b32 v106, K25, v44
        v_xor_b32 v119, K26, v45
        v_xor_b32 v126, K20, v46
        v_xor_b32 v122, K38, v47
        v_xor_b32 v107, K05, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K10, DB_EF72
        v_xor_b32 v118, K43, DB_EF73
        v_xor_b32 v121, K51, DB_EF74
        v_xor_b32 v122, K09, DB_EF75
        v_xor_b32 v104, K21, DB_EF76
        v_xor_b32 v107, K22, DB_EF77
        v_xor_b32 v123, K01, DB_EF78
        v_xor_b32 v106, K17, DB_EF79
        v_xor_b32 v110, K50, DB_EF80
        v_xor_b32 v119, K35, DB_EF81
		v_xor_b32 v102, K37, DB_EF82
        v_xor_b32 v125, K14, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K42, v55
        v_xor_b32 v118, K07, v56
        v_xor_b32 v127, K24, v57
        v_xor_b32 v100, K15, v58
        v_xor_b32 v112, K30, v59
        v_xor_b32 v107, K36, v60
        v_xor_b32 v103, K28, v59
        v_xor_b32 v101, K03, v60
        v_xor_b32 v114, K00, v61
        v_xor_b32 v113, K16, v62
        v_xor_b32 v102, K08, v63
        v_xor_b32 v104, K44, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*******/
		/* A 8 */
		/*******/

        v_xor_b32 v115, K55, DB_EF00
        v_xor_b32 v116, K34, DB_EF01
        v_xor_b32 v117, K45, DB_EF02
        v_xor_b32 v118, K40, DB_EF03
        v_xor_b32 v119, K05, DB_EF04
        v_xor_b32 v120, K32, DB_EF05
        v_xor_b32 v121, K46, DB_EF06
        v_xor_b32 v122, K12, DB_EF07
        v_xor_b32 v123, K48, DB_EF08
        v_xor_b32 v124, K25, DB_EF09
        v_xor_b32 v125, K06, DB_EF10
        v_xor_b32 v126, K52, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K47, v7
        v_xor_b32 v120, K20, v8
        v_xor_b32 v118, K38, v9
        v_xor_b32 v114, K39, v10
        v_xor_b32 v116, K26, v11
        v_xor_b32 v125, K11, v12
        v_xor_b32 v119, K41, v11
        v_xor_b32 v122, K18, v12
        v_xor_b32 v113, K19, v13
        v_xor_b32 v123, K13, v14
        v_xor_b32 v124, K31, v15
        v_xor_b32 v112, K53, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K03, DB_EF24
        v_xor_b32 v109, K36, DB_EF25
        v_xor_b32 v118, K44, DB_EF26
        v_xor_b32 v121, K02, DB_EF27
        v_xor_b32 v122, K14, DB_EF28
        v_xor_b32 v123, K15, DB_EF29
        v_xor_b32 v111, K51, DB_EF30
        v_xor_b32 v114, K10, DB_EF31
        v_xor_b32 v110, K43, DB_EF32
        v_xor_b32 v124, K28, DB_EF33
        v_xor_b32 v120, K30, DB_EF34
        v_xor_b32 v125, K07, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K35, v23
        v_xor_b32 v118, K00, v24
        v_xor_b32 v121, K17, v25
        v_xor_b32 v124, K08, v26
        v_xor_b32 v126, K23, v27
        v_xor_b32 v123, K29, v28
        v_xor_b32 v119, K21, v27
        v_xor_b32 v112, K49, v28
        v_xor_b32 v125, K50, v29
        v_xor_b32 v122, K09, v30
        v_xor_b32 v111, K01, v31
        v_xor_b32 v120, K37, v0
        s_swappc_b64 s[100:101], s[92:93]

		/*******/
		/* B 9 */
		/*******/

        v_xor_b32 v108, K41, DB_EF48
        v_xor_b32 v118, K20, DB_EF49
        v_xor_b32 v105, K31, DB_EF50
        v_xor_b32 v116, K26, DB_EF51
        v_xor_b32 v126, K46, DB_EF52
        v_xor_b32 v119, K18, DB_EF53
        v_xor_b32 v114, K32, DB_EF54
        v_xor_b32 v106, K53, DB_EF55
        v_xor_b32 v102, K34, DB_EF56
        v_xor_b32 v107, K11, DB_EF57
        v_xor_b32 v104, K47, DB_EF58
        v_xor_b32 v103, K38, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K33, v39
        v_xor_b32 v118, K06, v40
        v_xor_b32 v110, K55, v41	
        v_xor_b32 v116, K25, v42
        v_xor_b32 v102, K12, v43
        v_xor_b32 v104, K52, v44
        v_xor_b32 v103, K27, v43
        v_xor_b32 v106, K04, v44
        v_xor_b32 v119, K05, v45
        v_xor_b32 v126, K54, v46
        v_xor_b32 v122, K48, v47
        v_xor_b32 v107, K39, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K42, DB_EF72
        v_xor_b32 v118, K22, DB_EF73
        v_xor_b32 v121, K30, DB_EF74
        v_xor_b32 v122, K17, DB_EF75
        v_xor_b32 v104, K00, DB_EF76
        v_xor_b32 v107, K01, DB_EF77
        v_xor_b32 v123, K37, DB_EF78
        v_xor_b32 v106, K49, DB_EF79
        v_xor_b32 v110, K29, DB_EF80
        v_xor_b32 v119, K14, DB_EF81
		v_xor_b32 v102, K16, DB_EF82
        v_xor_b32 v125, K50, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K21, v55
        v_xor_b32 v118, K43, v56
        v_xor_b32 v127, K03, v57
        v_xor_b32 v100, K51, v58
        v_xor_b32 v112, K09, v59
        v_xor_b32 v107, K15, v60
        v_xor_b32 v103, K07, v59
        v_xor_b32 v101, K35, v60
        v_xor_b32 v114, K36, v61
        v_xor_b32 v113, K24, v62
        v_xor_b32 v102, K44, v63
        v_xor_b32 v104, K23, v32
        s_swappc_b64 s[100:101], s[84:85]

		/********/
		/* A 10 */
		/********/

        v_xor_b32 v115, K27, DB_EF00
        v_xor_b32 v116, K06, DB_EF01
        v_xor_b32 v117, K48, DB_EF02
        v_xor_b32 v118, K12, DB_EF03
        v_xor_b32 v119, K32, DB_EF04
        v_xor_b32 v120, K04, DB_EF05
        v_xor_b32 v121, K18, DB_EF06
        v_xor_b32 v122, K39, DB_EF07
        v_xor_b32 v123, K20, DB_EF08
        v_xor_b32 v124, K52, DB_EF09
        v_xor_b32 v125, K33, DB_EF10
        v_xor_b32 v126, K55, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K19, v7
        v_xor_b32 v120, K47, v8
        v_xor_b32 v118, K41, v9
        v_xor_b32 v114, K11, v10
        v_xor_b32 v116, K53, v11
        v_xor_b32 v125, K38, v12
        v_xor_b32 v119, K13, v11
        v_xor_b32 v122, K45, v12
        v_xor_b32 v113, K46, v13
        v_xor_b32 v123, K40, v14
        v_xor_b32 v124, K34, v15
        v_xor_b32 v112, K25, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K28, DB_EF24
        v_xor_b32 v109, K08, DB_EF25
        v_xor_b32 v118, K16, DB_EF26
        v_xor_b32 v121, K03, DB_EF27
        v_xor_b32 v122, K43, DB_EF28
        v_xor_b32 v123, K44, DB_EF29
        v_xor_b32 v111, K23, DB_EF30
        v_xor_b32 v114, K35, DB_EF31
        v_xor_b32 v110, K15, DB_EF32
        v_xor_b32 v124, K00, DB_EF33
        v_xor_b32 v120, K02, DB_EF34
        v_xor_b32 v125, K36, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K07, v23
        v_xor_b32 v118, K29, v24
        v_xor_b32 v121, K42, v25
        v_xor_b32 v124, K37, v26
        v_xor_b32 v126, K24, v27
        v_xor_b32 v123, K01, v28
        v_xor_b32 v119, K50, v27
        v_xor_b32 v112, K21, v28
        v_xor_b32 v125, K22, v29
        v_xor_b32 v122, K10, v30
        v_xor_b32 v111, K30, v31
        v_xor_b32 v120, K09, v0
        s_swappc_b64 s[100:101], s[92:93]

 		/********/
		/* B 11 */
		/********/

        v_xor_b32 v108, K13, DB_EF48
        v_xor_b32 v118, K47, DB_EF49
        v_xor_b32 v105, K34, DB_EF50
        v_xor_b32 v116, K53, DB_EF51
        v_xor_b32 v126, K18, DB_EF52
        v_xor_b32 v119, K45, DB_EF53
        v_xor_b32 v114, K04, DB_EF54
        v_xor_b32 v106, K25, DB_EF55
        v_xor_b32 v102, K06, DB_EF56
        v_xor_b32 v107, K38, DB_EF57
        v_xor_b32 v104, K19, DB_EF58
        v_xor_b32 v103, K41, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K05, v39
        v_xor_b32 v118, K33, v40
        v_xor_b32 v110, K27, v41	
        v_xor_b32 v116, K52, v42
        v_xor_b32 v102, K39, v43
        v_xor_b32 v104, K55, v44
        v_xor_b32 v103, K54, v43
        v_xor_b32 v106, K31, v44
        v_xor_b32 v119, K32, v45
        v_xor_b32 v126, K26, v46
        v_xor_b32 v122, K20, v47
        v_xor_b32 v107, K11, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K14, DB_EF72
        v_xor_b32 v118, K51, DB_EF73
        v_xor_b32 v121, K02, DB_EF74
        v_xor_b32 v122, K42, DB_EF75
        v_xor_b32 v104, K29, DB_EF76
        v_xor_b32 v107, K30, DB_EF77
        v_xor_b32 v123, K09, DB_EF78
        v_xor_b32 v106, K21, DB_EF79
        v_xor_b32 v110, K01, DB_EF80
        v_xor_b32 v119, K43, DB_EF81
		v_xor_b32 v102, K17, DB_EF82
        v_xor_b32 v125, K22, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K50, v55
        v_xor_b32 v118, K15, v56
        v_xor_b32 v127, K28, v57
        v_xor_b32 v100, K23, v58
        v_xor_b32 v112, K10, v59
        v_xor_b32 v107, K44, v60
        v_xor_b32 v103, K36, v59
        v_xor_b32 v101, K07, v60
        v_xor_b32 v114, K08, v61
        v_xor_b32 v113, K49, v62
        v_xor_b32 v102, K16, v63
        v_xor_b32 v104, K24, v32
        s_swappc_b64 s[100:101], s[84:85]

		/********/
		/* A 12 */
		/********/

        v_xor_b32 v115, K54, DB_EF00
        v_xor_b32 v116, K33, DB_EF01
        v_xor_b32 v117, K20, DB_EF02
        v_xor_b32 v118, K39, DB_EF03
        v_xor_b32 v119, K04, DB_EF04
        v_xor_b32 v120, K31, DB_EF05
        v_xor_b32 v121, K45, DB_EF06
        v_xor_b32 v122, K11, DB_EF07
        v_xor_b32 v123, K47, DB_EF08
        v_xor_b32 v124, K55, DB_EF09
        v_xor_b32 v125, K05, DB_EF10
        v_xor_b32 v126, K27, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K46, v7
        v_xor_b32 v120, K19, v8
        v_xor_b32 v118, K13, v9
        v_xor_b32 v114, K38, v10
        v_xor_b32 v116, K25, v11
        v_xor_b32 v125, K41, v12
        v_xor_b32 v119, K40, v11
        v_xor_b32 v122, K48, v12
        v_xor_b32 v113, K18, v13
        v_xor_b32 v123, K12, v14
        v_xor_b32 v124, K06, v15
        v_xor_b32 v112, K52, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K00, DB_EF24
        v_xor_b32 v109, K37, DB_EF25
        v_xor_b32 v118, K17, DB_EF26
        v_xor_b32 v121, K28, DB_EF27
        v_xor_b32 v122, K15, DB_EF28
        v_xor_b32 v123, K16, DB_EF29
        v_xor_b32 v111, K24, DB_EF30
        v_xor_b32 v114, K07, DB_EF31
        v_xor_b32 v110, K44, DB_EF32
        v_xor_b32 v124, K29, DB_EF33
        v_xor_b32 v120, K03, DB_EF34
        v_xor_b32 v125, K08, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K36, v23
        v_xor_b32 v118, K01, v24
        v_xor_b32 v121, K14, v25
        v_xor_b32 v124, K09, v26
        v_xor_b32 v126, K49, v27
        v_xor_b32 v123, K30, v28
        v_xor_b32 v119, K22, v27
        v_xor_b32 v112, K50, v28
        v_xor_b32 v125, K51, v29
        v_xor_b32 v122, K35, v30
        v_xor_b32 v111, K02, v31
        v_xor_b32 v120, K10, v0
        s_swappc_b64 s[100:101], s[92:93]

		/********/
		/* B 13 */
		/********/

        v_xor_b32 v108, K40, DB_EF48
        v_xor_b32 v118, K19, DB_EF49
        v_xor_b32 v105, K06, DB_EF50
        v_xor_b32 v116, K25, DB_EF51
        v_xor_b32 v126, K45, DB_EF52
        v_xor_b32 v119, K48, DB_EF53
        v_xor_b32 v114, K31, DB_EF54
        v_xor_b32 v106, K52, DB_EF55
        v_xor_b32 v102, K33, DB_EF56
        v_xor_b32 v107, K41, DB_EF57
        v_xor_b32 v104, K46, DB_EF58
        v_xor_b32 v103, K13, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K32, v39
        v_xor_b32 v118, K05, v40
        v_xor_b32 v110, K54, v41	
        v_xor_b32 v116, K55, v42
        v_xor_b32 v102, K11, v43
        v_xor_b32 v104, K27, v44
        v_xor_b32 v103, K26, v43
        v_xor_b32 v106, K34, v44
        v_xor_b32 v119, K04, v45
        v_xor_b32 v126, K53, v46
        v_xor_b32 v122, K47, v47
        v_xor_b32 v107, K38, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K43, DB_EF72
        v_xor_b32 v118, K23, DB_EF73
        v_xor_b32 v121, K03, DB_EF74
        v_xor_b32 v122, K14, DB_EF75
        v_xor_b32 v104, K01, DB_EF76
        v_xor_b32 v107, K02, DB_EF77
        v_xor_b32 v123, K10, DB_EF78
        v_xor_b32 v106, K50, DB_EF79
        v_xor_b32 v110, K30, DB_EF80
        v_xor_b32 v119, K15, DB_EF81
		v_xor_b32 v102, K42, DB_EF82
        v_xor_b32 v125, K51, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K22, v55
        v_xor_b32 v118, K44, v56
        v_xor_b32 v127, K00, v57
        v_xor_b32 v100, K24, v58
        v_xor_b32 v112, K35, v59
        v_xor_b32 v107, K16, v60
        v_xor_b32 v103, K08, v59
        v_xor_b32 v101, K36, v60
        v_xor_b32 v114, K37, v61
        v_xor_b32 v113, K21, v62
        v_xor_b32 v102, K17, v63
        v_xor_b32 v104, K49, v32
        s_swappc_b64 s[100:101], s[84:85]

 		/********/
		/* A 14 */
		/********/

        v_xor_b32 v115, K26, DB_EF00
        v_xor_b32 v116, K05, DB_EF01
        v_xor_b32 v117, K47, DB_EF02
        v_xor_b32 v118, K11, DB_EF03
        v_xor_b32 v119, K31, DB_EF04
        v_xor_b32 v120, K34, DB_EF05
        v_xor_b32 v121, K48, DB_EF06
        v_xor_b32 v122, K38, DB_EF07
        v_xor_b32 v123, K19, DB_EF08
        v_xor_b32 v124, K27, DB_EF09
        v_xor_b32 v125, K32, DB_EF10
        v_xor_b32 v126, K54, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K18, v7
        v_xor_b32 v120, K46, v8
        v_xor_b32 v118, K40, v9
        v_xor_b32 v114, K41, v10
        v_xor_b32 v116, K52, v11
        v_xor_b32 v125, K13, v12
        v_xor_b32 v119, K12, v11
        v_xor_b32 v122, K20, v12
        v_xor_b32 v113, K45, v13
        v_xor_b32 v123, K39, v14
        v_xor_b32 v124, K33, v15
        v_xor_b32 v112, K55, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K29, DB_EF24
        v_xor_b32 v109, K09, DB_EF25
        v_xor_b32 v118, K42, DB_EF26
        v_xor_b32 v121, K00, DB_EF27
        v_xor_b32 v122, K44, DB_EF28
        v_xor_b32 v123, K17, DB_EF29
        v_xor_b32 v111, K49, DB_EF30
        v_xor_b32 v114, K36, DB_EF31
        v_xor_b32 v110, K16, DB_EF32
        v_xor_b32 v124, K01, DB_EF33
        v_xor_b32 v120, K28, DB_EF34
        v_xor_b32 v125, K37, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K08, v23
        v_xor_b32 v118, K30, v24
        v_xor_b32 v121, K43, v25
        v_xor_b32 v124, K10, v26
        v_xor_b32 v126, K21, v27
        v_xor_b32 v123, K02, v28
        v_xor_b32 v119, K51, v27
        v_xor_b32 v112, K22, v28
        v_xor_b32 v125, K23, v29
        v_xor_b32 v122, K07, v30
        v_xor_b32 v111, K03, v31
        v_xor_b32 v120, K35, v0
        s_swappc_b64 s[100:101], s[92:93]

		/********/
		/* B 15 */
		/********/

        v_xor_b32 v108, K19, DB_EF48
        v_xor_b32 v118, K53, DB_EF49
        v_xor_b32 v105, K40, DB_EF50
        v_xor_b32 v116, K04, DB_EF51
        v_xor_b32 v126, K55, DB_EF52
        v_xor_b32 v119, K27, DB_EF53
        v_xor_b32 v114, K41, DB_EF54
        v_xor_b32 v106, K31, DB_EF55
        v_xor_b32 v102, K12, DB_EF56
        v_xor_b32 v107, K20, DB_EF57
        v_xor_b32 v104, K25, DB_EF58
        v_xor_b32 v103, K47, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K11, v39
        v_xor_b32 v118, K39, v40
        v_xor_b32 v110, K33, v41	
        v_xor_b32 v116, K34, v42
        v_xor_b32 v102, K45, v43
        v_xor_b32 v104, K06, v44
        v_xor_b32 v103, K05, v43
        v_xor_b32 v106, K13, v44
        v_xor_b32 v119, K38, v45
        v_xor_b32 v126, K32, v46
        v_xor_b32 v122, K26, v47
        v_xor_b32 v107, K48, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K22, DB_EF72
        v_xor_b32 v118, K02, DB_EF73
        v_xor_b32 v121, K35, DB_EF74
        v_xor_b32 v122, K50, DB_EF75
        v_xor_b32 v104, K37, DB_EF76
        v_xor_b32 v107, K10, DB_EF77
        v_xor_b32 v123, K42, DB_EF78
        v_xor_b32 v106, K29, DB_EF79
        v_xor_b32 v110, K09, DB_EF80
        v_xor_b32 v119, K51, DB_EF81
		v_xor_b32 v102, K21, DB_EF82
        v_xor_b32 v125, K30, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K01, v55
        v_xor_b32 v118, K23, v56
        v_xor_b32 v127, K36, v57
        v_xor_b32 v100, K03, v58
        v_xor_b32 v112, K14, v59
        v_xor_b32 v107, K24, v60
        v_xor_b32 v103, K44, v59
        v_xor_b32 v101, K15, v60
        v_xor_b32 v114, K16, v61
        v_xor_b32 v113, K00, v62
        v_xor_b32 v102, K49, v63
        v_xor_b32 v104, K28, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*********************************************/
	    s_cmp_eq_i32    s32, 1
        s_cbranch_scc1  .quitLoop
		/*********************************************/

		/*******/
		/* B 0 */
		/*******/

        v_xor_b32 v108, K12, DB_EF48
        v_xor_b32 v118, K46, DB_EF49
        v_xor_b32 v105, K33, DB_EF50
        v_xor_b32 v116, K52, DB_EF51
        v_xor_b32 v126, K48, DB_EF52
        v_xor_b32 v119, K20, DB_EF53
        v_xor_b32 v114, K34, DB_EF54
		v_xor_b32 v106, K55, DB_EF55
        v_xor_b32 v102, K05, DB_EF56
        v_xor_b32 v107, K13, DB_EF57
        v_xor_b32 v104, K18, DB_EF58
        v_xor_b32 v103, K40, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K04, v39
        v_xor_b32 v118, K32, v40
        v_xor_b32 v110, K26, v41
        v_xor_b32 v116, K27, v42
        v_xor_b32 v102, K38, v43
        v_xor_b32 v104, K54, v44
        v_xor_b32 v103, K53, v43
        v_xor_b32 v106, K06, v44
        v_xor_b32 v119, K31, v45
        v_xor_b32 v126, K25, v46
        v_xor_b32 v122, K19, v47
        v_xor_b32 v107, K41, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K15, DB_EF72
        v_xor_b32 v118, K24, DB_EF73
        v_xor_b32 v121, K28, DB_EF74
        v_xor_b32 v122, K43, DB_EF75
        v_xor_b32 v104, K30, DB_EF76
        v_xor_b32 v107, K03, DB_EF77
        v_xor_b32 v123, K35, DB_EF78
        v_xor_b32 v106, K22, DB_EF79
        v_xor_b32 v110, K02, DB_EF80
        v_xor_b32 v119, K44, DB_EF81
        v_xor_b32 v102, K14, DB_EF82
        v_xor_b32 v125, K23, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K51, v55
        v_xor_b32 v118, K16, v56
        v_xor_b32 v127, K29, v57
        v_xor_b32 v100, K49, v58
        v_xor_b32 v112, K07, v59
        v_xor_b32 v107, K17, v60
        v_xor_b32 v103, K37, v59
        v_xor_b32 v101, K08, v60
        v_xor_b32 v114, K09, v61
        v_xor_b32 v113, K50, v62
        v_xor_b32 v102, K42, v63
        v_xor_b32 v104, K21, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*******/
		/* A 1 */
		/*******/

        v_xor_b32 v115, K05, DB_EF00
        v_xor_b32 v116, K39, DB_EF01
        v_xor_b32 v117, K26, DB_EF02
        v_xor_b32 v118, K45, DB_EF03
        v_xor_b32 v119, K41, DB_EF04
        v_xor_b32 v120, K13, DB_EF05
        v_xor_b32 v121, K27, DB_EF06
        v_xor_b32 v122, K48, DB_EF07
        v_xor_b32 v123, K53, DB_EF08
        v_xor_b32 v124, K06, DB_EF09
        v_xor_b32 v125, K11, DB_EF10
        v_xor_b32 v126, K33, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K52, v7
        v_xor_b32 v120, K25, v8
        v_xor_b32 v118, K19, v9
        v_xor_b32 v114, K20, v10
        v_xor_b32 v116, K31, v11
        v_xor_b32 v125, K47, v12
        v_xor_b32 v119, K46, v11
        v_xor_b32 v122, K54, v12
        v_xor_b32 v113, K55, v13
        v_xor_b32 v123, K18, v14
        v_xor_b32 v124, K12, v15
        v_xor_b32 v112, K34, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K08, DB_EF24
        v_xor_b32 v109, K17, DB_EF25
        v_xor_b32 v118, K21, DB_EF26
        v_xor_b32 v121, K36, DB_EF27
        v_xor_b32 v122, K23, DB_EF28
        v_xor_b32 v123, K49, DB_EF29
        v_xor_b32 v111, K28, DB_EF30
        v_xor_b32 v114, K15, DB_EF31
        v_xor_b32 v110, K24, DB_EF32
        v_xor_b32 v124, K37, DB_EF33
        v_xor_b32 v120, K07, DB_EF34
        v_xor_b32 v125, K16, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K44, v23
        v_xor_b32 v118, K09, v24
        v_xor_b32 v121, K22, v25
        v_xor_b32 v124, K42, v26
        v_xor_b32 v126, K00, v27
        v_xor_b32 v123, K10, v28
        v_xor_b32 v119, K30, v27
        v_xor_b32 v112, K01, v28
        v_xor_b32 v125, K02, v29
        v_xor_b32 v122, K43, v30
        v_xor_b32 v111, K35, v31
        v_xor_b32 v120, K14, v0
        s_swappc_b64 s[100:101], s[92:93]

		/*******/
		/* B 2 */
		/*******/

        v_xor_b32 v108, K46, DB_EF48
        v_xor_b32 v118, K25, DB_EF49
        v_xor_b32 v105, K12, DB_EF50
        v_xor_b32 v116, K31, DB_EF51
        v_xor_b32 v126, K27, DB_EF52
        v_xor_b32 v119, K54, DB_EF53
        v_xor_b32 v114, K13, DB_EF54
		v_xor_b32 v106, K34, DB_EF55
        v_xor_b32 v102, K39, DB_EF56
        v_xor_b32 v107, K47, DB_EF57
        v_xor_b32 v104, K52, DB_EF58
        v_xor_b32 v103, K19, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K38, v39
        v_xor_b32 v118, K11, v40
        v_xor_b32 v110, K05, v41
        v_xor_b32 v116, K06, v42
        v_xor_b32 v102, K48, v43
        v_xor_b32 v104, K33, v44
        v_xor_b32 v103, K32, v43
        v_xor_b32 v106, K40, v44
        v_xor_b32 v119, K41, v45
        v_xor_b32 v126, K04, v46
        v_xor_b32 v122, K53, v47
        v_xor_b32 v107, K20, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K51, DB_EF72
        v_xor_b32 v118, K03, DB_EF73
        v_xor_b32 v121, K07, DB_EF74
        v_xor_b32 v122, K22, DB_EF75
        v_xor_b32 v104, K09, DB_EF76
        v_xor_b32 v107, K35, DB_EF77
        v_xor_b32 v123, K14, DB_EF78
        v_xor_b32 v106, K01, DB_EF79
        v_xor_b32 v110, K10, DB_EF80
        v_xor_b32 v119, K23, DB_EF81
        v_xor_b32 v102, K50, DB_EF82
        v_xor_b32 v125, K02, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K30, v55
        v_xor_b32 v118, K24, v56
        v_xor_b32 v127, K08, v57
        v_xor_b32 v100, K28, v58
        v_xor_b32 v112, K43, v59
        v_xor_b32 v107, K49, v60
        v_xor_b32 v103, K16, v59
        v_xor_b32 v101, K44, v60
        v_xor_b32 v114, K17, v61
        v_xor_b32 v113, K29, v62
        v_xor_b32 v102, K21, v63
        v_xor_b32 v104, K00, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*******/
		/* A 3 */
		/*******/

        v_xor_b32 v115, K32, DB_EF00
        v_xor_b32 v116, K11, DB_EF01
        v_xor_b32 v117, K53, DB_EF02
        v_xor_b32 v118, K48, DB_EF03
        v_xor_b32 v119, K13, DB_EF04
        v_xor_b32 v120, K40, DB_EF05
        v_xor_b32 v121, K54, DB_EF06
        v_xor_b32 v122, K20, DB_EF07
        v_xor_b32 v123, K25, DB_EF08
        v_xor_b32 v124, K33, DB_EF09
        v_xor_b32 v125, K38, DB_EF10
        v_xor_b32 v126, K05, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K55, v7
        v_xor_b32 v120, K52, v8
        v_xor_b32 v118, K46, v9
        v_xor_b32 v114, K47, v10
        v_xor_b32 v116, K34, v11
        v_xor_b32 v125, K19, v12
        v_xor_b32 v119, K18, v11
        v_xor_b32 v122, K26, v12
        v_xor_b32 v113, K27, v13
        v_xor_b32 v123, K45, v14
        v_xor_b32 v124, K39, v15
        v_xor_b32 v112, K06, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K37, DB_EF24
        v_xor_b32 v109, K42, DB_EF25
        v_xor_b32 v118, K50, DB_EF26
        v_xor_b32 v121, K08, DB_EF27
        v_xor_b32 v122, K24, DB_EF28
        v_xor_b32 v123, K21, DB_EF29
        v_xor_b32 v111, K00, DB_EF30
        v_xor_b32 v114, K44, DB_EF31
        v_xor_b32 v110, K49, DB_EF32
        v_xor_b32 v124, K09, DB_EF33
        v_xor_b32 v120, K36, DB_EF34
        v_xor_b32 v125, K17, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K16, v23
        v_xor_b32 v118, K10, v24
        v_xor_b32 v121, K51, v25
        v_xor_b32 v124, K14, v26
        v_xor_b32 v126, K29, v27
        v_xor_b32 v123, K35, v28
        v_xor_b32 v119, K02, v27
        v_xor_b32 v112, K30, v28
        v_xor_b32 v125, K03, v29
        v_xor_b32 v122, K15, v30
        v_xor_b32 v111, K07, v31
        v_xor_b32 v120, K43, v0
        s_swappc_b64 s[100:101], s[92:93]

		/*******/
		/* B 4 */
		/*******/

        v_xor_b32 v108, K18, DB_EF48
        v_xor_b32 v118, K52, DB_EF49
        v_xor_b32 v105, K39, DB_EF50
        v_xor_b32 v116, K34, DB_EF51
        v_xor_b32 v126, K54, DB_EF52
        v_xor_b32 v119, K26, DB_EF53
        v_xor_b32 v114, K40, DB_EF54
		v_xor_b32 v106, K06, DB_EF55
        v_xor_b32 v102, K11, DB_EF56
        v_xor_b32 v107, K19, DB_EF57
        v_xor_b32 v104, K55, DB_EF58
        v_xor_b32 v103, K46, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K41, v39
        v_xor_b32 v118, K38, v40
        v_xor_b32 v110, K32, v41
        v_xor_b32 v116, K33, v42
        v_xor_b32 v102, K20, v43
        v_xor_b32 v104, K05, v44
        v_xor_b32 v103, K04, v43
        v_xor_b32 v106, K12, v44
        v_xor_b32 v119, K13, v45
        v_xor_b32 v126, K31, v46
        v_xor_b32 v122, K25, v47
        v_xor_b32 v107, K47, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K23, DB_EF72
        v_xor_b32 v118, K28, DB_EF73
        v_xor_b32 v121, K36, DB_EF74
        v_xor_b32 v122, K51, DB_EF75
        v_xor_b32 v104, K10, DB_EF76
        v_xor_b32 v107, K07, DB_EF77
        v_xor_b32 v123, K43, DB_EF78
        v_xor_b32 v106, K30, DB_EF79
        v_xor_b32 v110, K35, DB_EF80
        v_xor_b32 v119, K24, DB_EF81
        v_xor_b32 v102, K22, DB_EF82
        v_xor_b32 v125, K03, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K02, v55
        v_xor_b32 v118, K49, v56
        v_xor_b32 v127, K37, v57
        v_xor_b32 v100, K00, v58
        v_xor_b32 v112, K15, v59
        v_xor_b32 v107, K21, v60
        v_xor_b32 v103, K17, v59
        v_xor_b32 v101, K16, v60
        v_xor_b32 v114, K42, v61
        v_xor_b32 v113, K01, v62
        v_xor_b32 v102, K50, v63
        v_xor_b32 v104, K29, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*******/
		/* A 5 */
		/*******/

        v_xor_b32 v115, K04, DB_EF00
        v_xor_b32 v116, K38, DB_EF01
        v_xor_b32 v117, K25, DB_EF02
        v_xor_b32 v118, K20, DB_EF03
        v_xor_b32 v119, K40, DB_EF04
        v_xor_b32 v120, K12, DB_EF05
        v_xor_b32 v121, K26, DB_EF06
        v_xor_b32 v122, K47, DB_EF07
        v_xor_b32 v123, K52, DB_EF08
        v_xor_b32 v124, K05, DB_EF09
        v_xor_b32 v125, K41, DB_EF10
        v_xor_b32 v126, K32, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K27, v7
        v_xor_b32 v120, K55, v8
        v_xor_b32 v118, K18, v9
        v_xor_b32 v114, K19, v10
        v_xor_b32 v116, K06, v11
        v_xor_b32 v125, K46, v12
        v_xor_b32 v119, K45, v11
        v_xor_b32 v122, K53, v12
        v_xor_b32 v113, K54, v13
        v_xor_b32 v123, K48, v14
        v_xor_b32 v124, K11, v15
        v_xor_b32 v112, K33, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K09, DB_EF24
        v_xor_b32 v109, K14, DB_EF25
        v_xor_b32 v118, K22, DB_EF26
        v_xor_b32 v121, K37, DB_EF27
        v_xor_b32 v122, K49, DB_EF28
        v_xor_b32 v123, K50, DB_EF29
        v_xor_b32 v111, K29, DB_EF30
        v_xor_b32 v114, K16, DB_EF31
        v_xor_b32 v110, K21, DB_EF32
        v_xor_b32 v124, K10, DB_EF33
        v_xor_b32 v120, K08, DB_EF34
        v_xor_b32 v125, K42, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K17, v23
        v_xor_b32 v118, K35, v24
        v_xor_b32 v121, K23, v25
        v_xor_b32 v124, K43, v26
        v_xor_b32 v126, K01, v27
        v_xor_b32 v123, K07, v28
        v_xor_b32 v119, K03, v27
        v_xor_b32 v112, K02, v28
        v_xor_b32 v125, K28, v29
        v_xor_b32 v122, K44, v30
        v_xor_b32 v111, K36, v31
        v_xor_b32 v120, K15, v0
        s_swappc_b64 s[100:101], s[92:93]

		/*******/
		/* B 6 */
		/*******/

        v_xor_b32 v108, K45, DB_EF48
        v_xor_b32 v118, K55, DB_EF49
        v_xor_b32 v105, K11, DB_EF50
        v_xor_b32 v116, K06, DB_EF51
        v_xor_b32 v126, K26, DB_EF52
        v_xor_b32 v119, K53, DB_EF53
        v_xor_b32 v114, K12, DB_EF54
		v_xor_b32 v106, K33, DB_EF55
        v_xor_b32 v102, K38, DB_EF56
        v_xor_b32 v107, K46, DB_EF57
        v_xor_b32 v104, K27, DB_EF58
        v_xor_b32 v103, K18, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K13, v39
        v_xor_b32 v118, K41, v40
        v_xor_b32 v110, K04, v41
        v_xor_b32 v116, K05, v42
        v_xor_b32 v102, K47, v43
        v_xor_b32 v104, K32, v44
        v_xor_b32 v103, K31, v43
        v_xor_b32 v106, K39, v44
        v_xor_b32 v119, K40, v45
        v_xor_b32 v126, K34, v46
        v_xor_b32 v122, K52, v47
        v_xor_b32 v107, K19, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K24, DB_EF72
        v_xor_b32 v118, K00, DB_EF73
        v_xor_b32 v121, K08, DB_EF74
        v_xor_b32 v122, K23, DB_EF75
        v_xor_b32 v104, K35, DB_EF76
        v_xor_b32 v107, K36, DB_EF77
        v_xor_b32 v123, K15, DB_EF78
        v_xor_b32 v106, K02, DB_EF79
        v_xor_b32 v110, K07, DB_EF80
        v_xor_b32 v119, K49, DB_EF81
        v_xor_b32 v102, K51, DB_EF82
        v_xor_b32 v125, K28, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K03, v55
        v_xor_b32 v118, K21, v56
        v_xor_b32 v127, K09, v57
        v_xor_b32 v100, K29, v58
        v_xor_b32 v112, K44, v59
        v_xor_b32 v107, K50, v60
        v_xor_b32 v103, K42, v59
        v_xor_b32 v101, K17, v60
        v_xor_b32 v114, K14, v61
        v_xor_b32 v113, K30, v62
        v_xor_b32 v102, K22, v63
        v_xor_b32 v104, K01, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*******/
		/* A 7 */
		/*******/

        v_xor_b32 v115, K31, DB_EF00
        v_xor_b32 v116, K41, DB_EF01
        v_xor_b32 v117, K52, DB_EF02
        v_xor_b32 v118, K47, DB_EF03
        v_xor_b32 v119, K12, DB_EF04
        v_xor_b32 v120, K39, DB_EF05
        v_xor_b32 v121, K53, DB_EF06
        v_xor_b32 v122, K19, DB_EF07
        v_xor_b32 v123, K55, DB_EF08
        v_xor_b32 v124, K32, DB_EF09
        v_xor_b32 v125, K13, DB_EF10
        v_xor_b32 v126, K04, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K54, v7
        v_xor_b32 v120, K27, v8
        v_xor_b32 v118, K45, v9
        v_xor_b32 v114, K46, v10
        v_xor_b32 v116, K33, v11
        v_xor_b32 v125, K18, v12
        v_xor_b32 v119, K48, v11
        v_xor_b32 v122, K25, v12
        v_xor_b32 v113, K26, v13
        v_xor_b32 v123, K20, v14
        v_xor_b32 v124, K38, v15
        v_xor_b32 v112, K05, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K10, DB_EF24
        v_xor_b32 v109, K43, DB_EF25
        v_xor_b32 v118, K51, DB_EF26
        v_xor_b32 v121, K09, DB_EF27
        v_xor_b32 v122, K21, DB_EF28
        v_xor_b32 v123, K22, DB_EF29
        v_xor_b32 v111, K01, DB_EF30
        v_xor_b32 v114, K17, DB_EF31
        v_xor_b32 v110, K50, DB_EF32
        v_xor_b32 v124, K35, DB_EF33
        v_xor_b32 v120, K37, DB_EF34
        v_xor_b32 v125, K14, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K42, v23
        v_xor_b32 v118, K07, v24
        v_xor_b32 v121, K24, v25
        v_xor_b32 v124, K15, v26
        v_xor_b32 v126, K30, v27
        v_xor_b32 v123, K36, v28
        v_xor_b32 v119, K28, v27
        v_xor_b32 v112, K03, v28
        v_xor_b32 v125, K00, v29
        v_xor_b32 v122, K16, v30
        v_xor_b32 v111, K08, v31
        v_xor_b32 v120, K44, v0
        s_swappc_b64 s[100:101], s[92:93]

		/*******/
		/* B 8 */
		/*******/

        v_xor_b32 v108, K55, DB_EF48
        v_xor_b32 v118, K34, DB_EF49
        v_xor_b32 v105, K45, DB_EF50
        v_xor_b32 v116, K40, DB_EF51
        v_xor_b32 v126, K05, DB_EF52
        v_xor_b32 v119, K32, DB_EF53
        v_xor_b32 v114, K46, DB_EF54
		v_xor_b32 v106, K12, DB_EF55
        v_xor_b32 v102, K48, DB_EF56
        v_xor_b32 v107, K25, DB_EF57
        v_xor_b32 v104, K06, DB_EF58
        v_xor_b32 v103, K52, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K47, v39
        v_xor_b32 v118, K20, v40
        v_xor_b32 v110, K38, v41
        v_xor_b32 v116, K39, v42
        v_xor_b32 v102, K26, v43
        v_xor_b32 v104, K11, v44
        v_xor_b32 v103, K41, v43
        v_xor_b32 v106, K18, v44
        v_xor_b32 v119, K19, v45
        v_xor_b32 v126, K13, v46
        v_xor_b32 v122, K31, v47
        v_xor_b32 v107, K53, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K03, DB_EF72
        v_xor_b32 v118, K36, DB_EF73
        v_xor_b32 v121, K44, DB_EF74
        v_xor_b32 v122, K02, DB_EF75
        v_xor_b32 v104, K14, DB_EF76
        v_xor_b32 v107, K15, DB_EF77
        v_xor_b32 v123, K51, DB_EF78
        v_xor_b32 v106, K10, DB_EF79
        v_xor_b32 v110, K43, DB_EF80
        v_xor_b32 v119, K28, DB_EF81
        v_xor_b32 v102, K30, DB_EF82
        v_xor_b32 v125, K07, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K35, v55
        v_xor_b32 v118, K00, v56
        v_xor_b32 v127, K17, v57
        v_xor_b32 v100, K08, v58
        v_xor_b32 v112, K23, v59
        v_xor_b32 v107, K29, v60
        v_xor_b32 v103, K21, v59
        v_xor_b32 v101, K49, v60
        v_xor_b32 v114, K50, v61
        v_xor_b32 v113, K09, v62
        v_xor_b32 v102, K01, v63
        v_xor_b32 v104, K37, v32
        s_swappc_b64 s[100:101], s[84:85]

		/*******/
		/* A 9 */
		/*******/

        v_xor_b32 v115, K41, DB_EF00
        v_xor_b32 v116, K20, DB_EF01
        v_xor_b32 v117, K31, DB_EF02
        v_xor_b32 v118, K26, DB_EF03
        v_xor_b32 v119, K46, DB_EF04
        v_xor_b32 v120, K18, DB_EF05
        v_xor_b32 v121, K32, DB_EF06
        v_xor_b32 v122, K53, DB_EF07
        v_xor_b32 v123, K34, DB_EF08
        v_xor_b32 v124, K11, DB_EF09
        v_xor_b32 v125, K47, DB_EF10
        v_xor_b32 v126, K38, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K33, v7
        v_xor_b32 v120, K06, v8
        v_xor_b32 v118, K55, v9
        v_xor_b32 v114, K25, v10
        v_xor_b32 v116, K12, v11
        v_xor_b32 v125, K52, v12
        v_xor_b32 v119, K27, v11
        v_xor_b32 v122, K04, v12
        v_xor_b32 v113, K05, v13
        v_xor_b32 v123, K54, v14
        v_xor_b32 v124, K48, v15
        v_xor_b32 v112, K39, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K42, DB_EF24
        v_xor_b32 v109, K22, DB_EF25
        v_xor_b32 v118, K30, DB_EF26
        v_xor_b32 v121, K17, DB_EF27
        v_xor_b32 v122, K00, DB_EF28
        v_xor_b32 v123, K01, DB_EF29
        v_xor_b32 v111, K37, DB_EF30
        v_xor_b32 v114, K49, DB_EF31
        v_xor_b32 v110, K29, DB_EF32
        v_xor_b32 v124, K14, DB_EF33
        v_xor_b32 v120, K16, DB_EF34
        v_xor_b32 v125, K50, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K21, v23
        v_xor_b32 v118, K43, v24
        v_xor_b32 v121, K03, v25
        v_xor_b32 v124, K51, v26
        v_xor_b32 v126, K09, v27
        v_xor_b32 v123, K15, v28
        v_xor_b32 v119, K07, v27
        v_xor_b32 v112, K35, v28
        v_xor_b32 v125, K36, v29
        v_xor_b32 v122, K24, v30
        v_xor_b32 v111, K44, v31
        v_xor_b32 v120, K23, v0
        s_swappc_b64 s[100:101], s[92:93]

		/********/
		/* B 10 */
		/********/

        v_xor_b32 v108, K27, DB_EF48
        v_xor_b32 v118, K06, DB_EF49
        v_xor_b32 v105, K48, DB_EF50
        v_xor_b32 v116, K12, DB_EF51
        v_xor_b32 v126, K32, DB_EF52
        v_xor_b32 v119, K04, DB_EF53
        v_xor_b32 v114, K18, DB_EF54
		v_xor_b32 v106, K39, DB_EF55
        v_xor_b32 v102, K20, DB_EF56
        v_xor_b32 v107, K52, DB_EF57
        v_xor_b32 v104, K33, DB_EF58
        v_xor_b32 v103, K55, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K19, v39
        v_xor_b32 v118, K47, v40
        v_xor_b32 v110, K41, v41
        v_xor_b32 v116, K11, v42
        v_xor_b32 v102, K53, v43
        v_xor_b32 v104, K38, v44
        v_xor_b32 v103, K13, v43
        v_xor_b32 v106, K45, v44
        v_xor_b32 v119, K46, v45
        v_xor_b32 v126, K40, v46
        v_xor_b32 v122, K34, v47
        v_xor_b32 v107, K25, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K28, DB_EF72
        v_xor_b32 v118, K08, DB_EF73
        v_xor_b32 v121, K16, DB_EF74
        v_xor_b32 v122, K03, DB_EF75
        v_xor_b32 v104, K43, DB_EF76
        v_xor_b32 v107, K44, DB_EF77
        v_xor_b32 v123, K23, DB_EF78
        v_xor_b32 v106, K35, DB_EF79
        v_xor_b32 v110, K15, DB_EF80
        v_xor_b32 v119, K00, DB_EF81
        v_xor_b32 v102, K02, DB_EF82
        v_xor_b32 v125, K36, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K07, v55
        v_xor_b32 v118, K29, v56
        v_xor_b32 v127, K42, v57
        v_xor_b32 v100, K37, v58
        v_xor_b32 v112, K24, v59
        v_xor_b32 v107, K01, v60
        v_xor_b32 v103, K50, v59
        v_xor_b32 v101, K21, v60
        v_xor_b32 v114, K22, v61
        v_xor_b32 v113, K10, v62
        v_xor_b32 v102, K30, v63
        v_xor_b32 v104, K09, v32
        s_swappc_b64 s[100:101], s[84:85]

		/********/
		/* A 11 */
		/********/

        v_xor_b32 v115, K13, DB_EF00
        v_xor_b32 v116, K47, DB_EF01
        v_xor_b32 v117, K34, DB_EF02
        v_xor_b32 v118, K53, DB_EF03
        v_xor_b32 v119, K18, DB_EF04
        v_xor_b32 v120, K45, DB_EF05
        v_xor_b32 v121, K04, DB_EF06
        v_xor_b32 v122, K25, DB_EF07
        v_xor_b32 v123, K06, DB_EF08
        v_xor_b32 v124, K38, DB_EF09
        v_xor_b32 v125, K19, DB_EF10
        v_xor_b32 v126, K41, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K05, v7
        v_xor_b32 v120, K33, v8
        v_xor_b32 v118, K27, v9
        v_xor_b32 v114, K52, v10
        v_xor_b32 v116, K39, v11
        v_xor_b32 v125, K55, v12
        v_xor_b32 v119, K54, v11
        v_xor_b32 v122, K31, v12
        v_xor_b32 v113, K32, v13
        v_xor_b32 v123, K26, v14
        v_xor_b32 v124, K20, v15
        v_xor_b32 v112, K11, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K14, DB_EF24
        v_xor_b32 v109, K51, DB_EF25
        v_xor_b32 v118, K02, DB_EF26
        v_xor_b32 v121, K42, DB_EF27
        v_xor_b32 v122, K29, DB_EF28
        v_xor_b32 v123, K30, DB_EF29
        v_xor_b32 v111, K09, DB_EF30
        v_xor_b32 v114, K21, DB_EF31
        v_xor_b32 v110, K01, DB_EF32
        v_xor_b32 v124, K43, DB_EF33
        v_xor_b32 v120, K17, DB_EF34
        v_xor_b32 v125, K22, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K50, v23
        v_xor_b32 v118, K15, v24
        v_xor_b32 v121, K28, v25
        v_xor_b32 v124, K23, v26
        v_xor_b32 v126, K10, v27
        v_xor_b32 v123, K44, v28
        v_xor_b32 v119, K36, v27
        v_xor_b32 v112, K07, v28
        v_xor_b32 v125, K08, v29
        v_xor_b32 v122, K49, v30
        v_xor_b32 v111, K16, v31
        v_xor_b32 v120, K24, v0
        s_swappc_b64 s[100:101], s[92:93]

		/********/
		/* B 12 */
		/********/

        v_xor_b32 v108, K54, DB_EF48
        v_xor_b32 v118, K33, DB_EF49
        v_xor_b32 v105, K20, DB_EF50
        v_xor_b32 v116, K39, DB_EF51
        v_xor_b32 v126, K04, DB_EF52
        v_xor_b32 v119, K31, DB_EF53
        v_xor_b32 v114, K45, DB_EF54
		v_xor_b32 v106, K11, DB_EF55
        v_xor_b32 v102, K47, DB_EF56
        v_xor_b32 v107, K55, DB_EF57
        v_xor_b32 v104, K05, DB_EF58
        v_xor_b32 v103, K27, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K46, v39
        v_xor_b32 v118, K19, v40
        v_xor_b32 v110, K13, v41
        v_xor_b32 v116, K38, v42
        v_xor_b32 v102, K25, v43
        v_xor_b32 v104, K41, v44
        v_xor_b32 v103, K40, v43
        v_xor_b32 v106, K48, v44
        v_xor_b32 v119, K18, v45
        v_xor_b32 v126, K12, v46
        v_xor_b32 v122, K06, v47
        v_xor_b32 v107, K52, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K00, DB_EF72
        v_xor_b32 v118, K37, DB_EF73
        v_xor_b32 v121, K17, DB_EF74
        v_xor_b32 v122, K28, DB_EF75
        v_xor_b32 v104, K15, DB_EF76
        v_xor_b32 v107, K16, DB_EF77
        v_xor_b32 v123, K24, DB_EF78
        v_xor_b32 v106, K07, DB_EF79
        v_xor_b32 v110, K44, DB_EF80
        v_xor_b32 v119, K29, DB_EF81
        v_xor_b32 v102, K03, DB_EF82
        v_xor_b32 v125, K08, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K36, v55
        v_xor_b32 v118, K01, v56
        v_xor_b32 v127, K14, v57
        v_xor_b32 v100, K09, v58
        v_xor_b32 v112, K49, v59
        v_xor_b32 v107, K30, v60
        v_xor_b32 v103, K22, v59
        v_xor_b32 v101, K50, v60
        v_xor_b32 v114, K51, v61
        v_xor_b32 v113, K35, v62
        v_xor_b32 v102, K02, v63
        v_xor_b32 v104, K10, v32
        s_swappc_b64 s[100:101], s[84:85]

		/********/
		/* A 13 */
		/********/

        v_xor_b32 v115, K40, DB_EF00
        v_xor_b32 v116, K19, DB_EF01
        v_xor_b32 v117, K06, DB_EF02
        v_xor_b32 v118, K25, DB_EF03
        v_xor_b32 v119, K45, DB_EF04
        v_xor_b32 v120, K48, DB_EF05
        v_xor_b32 v121, K31, DB_EF06
        v_xor_b32 v122, K52, DB_EF07
        v_xor_b32 v123, K33, DB_EF08
        v_xor_b32 v124, K41, DB_EF09
        v_xor_b32 v125, K46, DB_EF10
        v_xor_b32 v126, K13, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K32, v7
        v_xor_b32 v120, K05, v8
        v_xor_b32 v118, K54, v9
        v_xor_b32 v114, K55, v10
        v_xor_b32 v116, K11, v11
        v_xor_b32 v125, K27, v12
        v_xor_b32 v119, K26, v11
        v_xor_b32 v122, K34, v12
        v_xor_b32 v113, K04, v13
        v_xor_b32 v123, K53, v14
        v_xor_b32 v124, K47, v15
        v_xor_b32 v112, K38, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K43, DB_EF24
        v_xor_b32 v109, K23, DB_EF25
        v_xor_b32 v118, K03, DB_EF26
        v_xor_b32 v121, K14, DB_EF27
        v_xor_b32 v122, K01, DB_EF28
        v_xor_b32 v123, K02, DB_EF29
        v_xor_b32 v111, K10, DB_EF30
        v_xor_b32 v114, K50, DB_EF31
        v_xor_b32 v110, K30, DB_EF32
        v_xor_b32 v124, K15, DB_EF33
        v_xor_b32 v120, K42, DB_EF34
        v_xor_b32 v125, K51, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K22, v23
        v_xor_b32 v118, K44, v24
        v_xor_b32 v121, K00, v25
        v_xor_b32 v124, K24, v26
        v_xor_b32 v126, K35, v27
        v_xor_b32 v123, K16, v28
        v_xor_b32 v119, K08, v27
        v_xor_b32 v112, K36, v28
        v_xor_b32 v125, K37, v29
        v_xor_b32 v122, K21, v30
        v_xor_b32 v111, K17, v31
        v_xor_b32 v120, K49, v0
        s_swappc_b64 s[100:101], s[92:93]

		/********/
		/* B 14 */
		/********/

        v_xor_b32 v108, K26, DB_EF48
        v_xor_b32 v118, K05, DB_EF49
        v_xor_b32 v105, K47, DB_EF50
        v_xor_b32 v116, K11, DB_EF51
        v_xor_b32 v126, K31, DB_EF52
        v_xor_b32 v119, K34, DB_EF53
        v_xor_b32 v114, K48, DB_EF54
		v_xor_b32 v106, K38, DB_EF55
        v_xor_b32 v102, K19, DB_EF56
        v_xor_b32 v107, K27, DB_EF57
        v_xor_b32 v104, K32, DB_EF58
        v_xor_b32 v103, K54, DB_EF59
        s_swappc_b64 s[100:101], s[90:91]

        v_xor_b32 v125, K18, v39
        v_xor_b32 v118, K46, v40
        v_xor_b32 v110, K40, v41
        v_xor_b32 v116, K41, v42
        v_xor_b32 v102, K52, v43
        v_xor_b32 v104, K13, v44
        v_xor_b32 v103, K12, v43
        v_xor_b32 v106, K20, v44
        v_xor_b32 v119, K45, v45
        v_xor_b32 v126, K39, v46
        v_xor_b32 v122, K33, v47
        v_xor_b32 v107, K55, v48
        s_swappc_b64 s[100:101], s[88:89]

        v_xor_b32 v103, K29, DB_EF72
        v_xor_b32 v118, K09, DB_EF73
        v_xor_b32 v121, K42, DB_EF74
        v_xor_b32 v122, K00, DB_EF75
        v_xor_b32 v104, K44, DB_EF76
        v_xor_b32 v107, K17, DB_EF77
        v_xor_b32 v123, K49, DB_EF78
        v_xor_b32 v106, K36, DB_EF79
        v_xor_b32 v110, K16, DB_EF80
        v_xor_b32 v119, K01, DB_EF81
        v_xor_b32 v102, K28, DB_EF82
        v_xor_b32 v125, K37, DB_EF83
        s_swappc_b64 s[100:101], s[86:87]

        v_xor_b32 v106, K08, v55
        v_xor_b32 v118, K30, v56
        v_xor_b32 v127, K43, v57
        v_xor_b32 v100, K10, v58
        v_xor_b32 v112, K21, v59
        v_xor_b32 v107, K02, v60
        v_xor_b32 v103, K51, v59
        v_xor_b32 v101, K22, v60
        v_xor_b32 v114, K23, v61
        v_xor_b32 v113, K07, v62
        v_xor_b32 v102, K03, v63
        v_xor_b32 v104, K35, v32
        s_swappc_b64 s[100:101], s[84:85]

		/********/
		/* A 15 */
		/********/

        v_xor_b32 v115, K19, DB_EF00
        v_xor_b32 v116, K53, DB_EF01
        v_xor_b32 v117, K40, DB_EF02
        v_xor_b32 v118, K04, DB_EF03
        v_xor_b32 v119, K55, DB_EF04
        v_xor_b32 v120, K27, DB_EF05
        v_xor_b32 v121, K41, DB_EF06
        v_xor_b32 v122, K31, DB_EF07
        v_xor_b32 v123, K12, DB_EF08
        v_xor_b32 v124, K20, DB_EF09
        v_xor_b32 v125, K25, DB_EF10
        v_xor_b32 v126, K47, DB_EF11
        s_swappc_b64 s[100:101], s[98:99]

        v_xor_b32 v126, K11, v7
        v_xor_b32 v120, K39, v8
        v_xor_b32 v118, K33, v9
        v_xor_b32 v114, K34, v10
        v_xor_b32 v116, K45, v11
        v_xor_b32 v125, K06, v12
        v_xor_b32 v119, K05, v11
        v_xor_b32 v122, K13, v12
        v_xor_b32 v113, K38, v13
        v_xor_b32 v123, K32, v14
        v_xor_b32 v124, K26, v15
        v_xor_b32 v112, K48, v16
        s_swappc_b64 s[100:101], s[96:97]

        v_xor_b32 v116, K22, DB_EF24
        v_xor_b32 v109, K02, DB_EF25
        v_xor_b32 v118, K35, DB_EF26
        v_xor_b32 v121, K50, DB_EF27
        v_xor_b32 v122, K37, DB_EF28
        v_xor_b32 v123, K10, DB_EF29
        v_xor_b32 v111, K42, DB_EF30
        v_xor_b32 v114, K29, DB_EF31
        v_xor_b32 v110, K09, DB_EF32
        v_xor_b32 v124, K51, DB_EF33
        v_xor_b32 v120, K21, DB_EF34
        v_xor_b32 v125, K30, DB_EF35
        s_swappc_b64 s[100:101], s[94:95]

        v_xor_b32 v116, K01, v23
        v_xor_b32 v118, K23, v24
        v_xor_b32 v121, K36, v25
        v_xor_b32 v124, K03, v26
        v_xor_b32 v126, K14, v27
        v_xor_b32 v123, K24, v28
        v_xor_b32 v119, K44, v27
        v_xor_b32 v112, K15, v28
        v_xor_b32 v125, K16, v29
        v_xor_b32 v122, K00, v30
        v_xor_b32 v111, K49, v31
        v_xor_b32 v120, K28, v0
        s_swappc_b64 s[100:101], s[92:93]

        s_add_u32 s32, -1, s32
		s_branch  .startLoop



.quitLoop:
        s_cmp_eq_i32    s80, 0
        s_cbranch_scc0  .L19112_0
        v_readlane_b32 s0, v86, 0
        v_readlane_b32 s1, v86, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[0:1], 0x70
        s_load_dwordx4  s[12:15], s[0:1], 0x78
        s_load_dwordx4  s[0:3], s[0:1], 0x68
        s_mov_b64       s[16:17], exec
        s_mov_b64       s[18:19], exec
        v_mov_b32 v65, 0
        v_mov_b32 v72, v78
.L17884_0:
        v_cmp_lt_i32    vcc, 31, v65
        s_and_saveexec_b64 s[20:21], vcc
        v_mov_b32 v72, 0
        s_cbranch_execz .L17908_0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L19008_0
.L17908_0:
        s_and_b64       exec, s[20:21], s[18:19]
        v_lshl_b32 v72, 1, v65
        v_and_b32 v79, v63, v72
        v_cmp_lg_i32    vcc, 0, v79
        v_mov_b32 v79, 0x20000000
        v_cndmask_b32 v79, 0, v79, vcc
        v_and_b32 v71, v31, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x10000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v38, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x8000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v6, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x4000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v46, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x2000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v14, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x1000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v54, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x800000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v22, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x400000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v62, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x200000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v30, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x100000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v37, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x80000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v5, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x40000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_lshrrev_b32 v71, 18, v79
        v_add_i32       v71, vcc, s82, v71
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v71, v71, s[8:11], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_lg_i32    vcc, 0, v71
        s_mov_b64       s[20:21], exec
        s_andn2_b64     exec, s[20:21], vcc
        v_and_b32 v71, v45, v72
        s_cbranch_execz .L18980_0
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x20000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v13, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x10000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v53, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x8000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v21, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x4000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v61, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x2000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v29, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x1000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v36, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x800
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v4, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x400
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v44, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x200
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v12, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x100
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v52, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x80
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v20, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 64, vcc
        v_or_b32 v79, v79, v71
        v_lshrrev_b32 v71, 6, v79
        v_add_i32       v71, vcc, s83, v71
        buffer_load_ubyte v71, v71, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v71
        s_and_saveexec_b64 s[22:23], vcc
        v_and_b32 v71, v60, v72
        s_cbranch_execz .L18960_0
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 32, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v28, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 16, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v35, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 8, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v3, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 4, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v43, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 2, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v72, v11, v72
        v_cmp_lg_i32    vcc, 0, v72
        v_cndmask_b32 v72, 0, 1, vcc
        v_or_b32 v72, v79, v72
        s_mov_b64       s[24:25], exec
        s_mov_b64       s[26:27], exec
        v_mov_b32 v47, s81
        v_mov_b32 v79, 0
        v_mov_b32 v71, 0
        v_mov_b32 v83, 0
.L18700_0:
        v_add_i32       v64, vcc, -1, v47
        s_mov_b64       s[28:29], exec
        s_mov_b64       s[30:31], exec
        v_mov_b32 v78, v83
.L18716_0:
        v_lshlrev_b32 v79, 2, v79
        v_readlane_b32 s32, v86, 3
        v_add_i32       v79, vcc, s32, v79
        tbuffer_load_format_x v79, v79, s[0:3], 0 offen format:[32,float]
        v_cmp_gt_i32    s[32:33], v83, v64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[34:35], v72, v79
        s_or_b64        vcc, s[32:33], s[34:35]
        s_and_saveexec_b64 s[36:37], vcc
        v_cndmask_b32 v79, 0, -1, s[34:35]
        s_cbranch_execz .L18800_0
        v_cndmask_b32 v47, 0, -1, s[32:33]
        v_mov_b32 v71, 1
        v_mov_b32 v83, v78
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L18896_0
.L18800_0:
        s_and_b64       exec, s[36:37], s[30:31]
        v_add_i32       v79, vcc, v64, v83
        v_ashrrev_i32   v79, 1, v79
        v_lshlrev_b32 v47, 2, v79
        v_readlane_b32 s32, v86, 3
        v_add_i32       v47, vcc, s32, v47
        v_add_i32       v78, vcc, 1, v79
        tbuffer_load_format_x v47, v47, s[0:3], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    vcc, v72, v47
        s_mov_b64       s[32:33], exec
        s_andn2_b64     exec, s[32:33], vcc
        v_mov_b32 v47, v79
        s_cbranch_execz .L18868_0
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L18896_0
.L18868_0:
        s_mov_b64       exec, s[30:31]
        v_mov_b32 v47, v79
        v_mov_b32 v85, v78
        v_mov_b32 v78, v83
        v_mov_b32 v83, v85
        s_branch        .L18716_0
        v_mov_b32 v83, v78
.L18896_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_lg_u32    vcc, 0, v71
        s_and_saveexec_b64 s[28:29], vcc
        s_andn2_b64     s[26:27], s[26:27], exec
        s_cbranch_scc0  .L18924_0
        s_mov_b64       exec, s[26:27]
        s_branch        .L18700_0
.L18924_0:
        s_mov_b64       exec, s[24:25]
        v_cmp_lg_u32    vcc, 0, v79
        s_and_saveexec_b64 s[24:25], vcc
        v_mov_b32 v72, 1
        s_cbranch_execz .L18952_0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L19008_0
.L18952_0:
        s_and_b64       exec, s[24:25], s[18:19]
        v_mov_b32 v72, 1
.L18960_0:
        s_andn2_b64     exec, s[22:23], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32 v72, 0
        s_cbranch_execz .L18976_0
.L18976_0:
        s_and_b64       exec, s[22:23], s[18:19]
.L18980_0:
        s_andn2_b64     exec, s[20:21], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32 v72, 0
        s_cbranch_execz .L18996_0
.L18996_0:
        s_and_b64       exec, s[20:21], s[18:19]
        v_add_i32       v65, vcc, 1, v65
        s_branch        .L17884_0
.L19008_0:
        s_mov_b64       exec, s[16:17]
        v_cmp_lg_i32    vcc, 0, v72
        s_waitcnt       lgkmcnt(0)
        s_and_saveexec_b64 s[0:1], vcc
        v_readlane_b32 s2, v86, 0
        s_cbranch_execz .L19096_0
        v_readlane_b32 s3, v86, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_readlane_b32 s12, v86, 2
        v_add_i32       v65, vcc, s12, v65
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v65, v65, s[8:11], 0 offen
        v_mov_b32 v72, 1
        s_load_dwordx4  s[8:11], s[2:3], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v72, v99, s[8:11], 0 offen offset:4 glc
        s_waitcnt       vmcnt(1)
        buffer_store_byte v65, v99, s[8:11], 0 offen offset:24 glc
.L19096_0:
        s_mov_b64       exec, s[0:1]
        s_waitcnt       expcnt(1)
        v_mov_b32 v72, 2
        s_branch        .L23616_0
.L19112_0:
        s_cmp_eq_i32    s80, 3
        s_cbranch_scc0  .L22320_0
        s_add_u32       s0, -1, s81
        v_readlane_b32 s2, v86, 0
        v_readlane_b32 s3, v86, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[2:3], 0x70
        s_load_dwordx4  s[12:15], s[2:3], 0x78
        s_load_dwordx4  s[16:19], s[2:3], 0x68
        s_mov_b64       s[2:3], exec
        s_mov_b64       s[20:21], exec
        v_mov_b32 v65, 0
        v_mov_b32 v75, v78
        v_mov_b32 v72, 0
        v_mov_b32 v74, 0
        v_mov_b32 v83, 0
        v_mov_b32 v55, 0
        v_mov_b32 v47, 0
        v_mov_b32 v64, 0
        v_mov_b32 v78, 0
.L19192_0:
        v_add_f32       v76, v64, v78
        v_add_f32       v76, v47, v76
        v_add_f32       v76, v55, v76
        v_add_f32       v76, v83, v76
        v_add_f32       v76, v74, v76
        v_add_f32       v76, v72, v76
        v_cmp_eq_u32    vcc, 0, v76
        s_and_saveexec_b64 s[22:23], vcc
        s_andn2_b64     exec, s[22:23], exec
        s_cbranch_execz .L19240_0
        s_andn2_b64     s[20:21], s[20:21], exec
        s_cbranch_scc0  .L22216_0
.L19240_0:
        s_and_b64       exec, s[22:23], s[20:21]
        v_cmp_ge_i32    vcc, 31, v65
        v_cndmask_b32 v72, 1.0, v72, vcc
        v_cmp_eq_u32    vcc, 0, v72
        s_and_saveexec_b64 s[22:23], vcc
        v_lshl_b32 v79, 1, v65
        s_cbranch_execz .L22200_0
        v_and_b32 v76, v63, v79
        v_and_b32 v68, v31, v79
        v_cmp_lg_i32    s[24:25], v76, 0
        v_mov_b32 v76, 0x20000000
        v_cmp_lg_i32    vcc, 0, v68
        v_mov_b32 v68, 0x10000000
        v_and_b32 v82, v38, v79
        v_cndmask_b32 v76, 0, v76, s[24:25]
        v_cndmask_b32 v68, 0, v68, vcc
        v_cmp_lg_i32    vcc, 0, v82
        v_mov_b32 v82, 0x8000000
        v_and_b32 v77, v6, v79
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v82, 0x4000000
        v_and_b32 v77, v46, v79
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v82, 0x2000000
        v_and_b32 v77, v14, v79
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v82, 0x1000000
        v_and_b32 v77, v54, v79
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v82, 0x800000
        v_and_b32 v77, v22, v79
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v82, 0x400000
        v_and_b32 v77, v62, v79
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v82, 0x200000
        v_and_b32 v77, v30, v79
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v82, 0x100000
        v_and_b32 v77, v37, v79
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v82, 0x80000
        v_and_b32 v77, v5, v79
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v82, 0x40000
        v_or_b32 v76, v76, v68
        v_cndmask_b32 v68, 0, v82, vcc
        v_or_b32 v76, v76, v68
        v_lshrrev_b32 v68, 18, v76
        v_add_i32       v68, vcc, s82, v68
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v68, v68, s[8:11], 0 offen
        v_and_b32 v82, v45, v79
        v_cmp_lg_i32    vcc, 0, v82
        v_mov_b32 v82, 0x20000
        v_and_b32 v77, v13, v79
        v_cndmask_b32 v82, 0, v82, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_mov_b32 v77, 0x10000
        v_and_b32 v69, v53, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_mov_b32 v77, 0x8000
        v_and_b32 v69, v21, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_mov_b32 v77, 0x4000
        v_and_b32 v69, v61, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_mov_b32 v77, 0x2000
        v_and_b32 v69, v29, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_mov_b32 v77, 0x1000
        v_and_b32 v69, v36, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_mov_b32 v77, 0x800
        v_and_b32 v69, v4, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_mov_b32 v77, 0x400
        v_and_b32 v69, v44, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_mov_b32 v77, 0x200
        v_and_b32 v69, v12, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_mov_b32 v77, 0x100
        v_and_b32 v69, v52, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_mov_b32 v77, 0x80
        v_and_b32 v69, v20, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, v77, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v77, v60, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, 64, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_and_b32 v77, v28, v79
        v_or_b32 v76, v76, v82
        v_cndmask_b32 v82, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_and_b32 v77, v35, v79
        v_or_b32 v82, v76, v82
        v_cndmask_b32 v69, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_and_b32 v77, v3, v79
        v_or_b32 v82, v82, v69
        v_cndmask_b32 v69, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_and_b32 v77, v43, v79
        v_or_b32 v82, v82, v69
        v_cndmask_b32 v69, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_and_b32 v77, v11, v79
        v_or_b32 v82, v82, v69
        v_cndmask_b32 v69, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v77
        v_or_b32 v82, v82, v69
        v_cndmask_b32 v77, 0, 1, vcc
        v_or_b32 v82, v82, v77
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v68
        s_and_saveexec_b64 s[24:25], vcc
        v_lshrrev_b32 v76, 6, v76
        s_cbranch_execz .L20300_0
        v_add_i32       v76, vcc, s83, v76
        buffer_load_ubyte v76, v76, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v76
        s_and_saveexec_b64 s[26:27], vcc
        s_cbranch_execz .L20288_0
        s_mov_b64       s[28:29], exec
        s_mov_b64       s[30:31], exec
        v_mov_b32 v68, s81
        v_mov_b32 v76, 0
        v_mov_b32 v77, 0
        v_mov_b32 v69, 0
.L20056_0:
        v_add_i32       v68, vcc, -1, v68
        s_mov_b64       s[32:33], exec
        s_mov_b64       s[34:35], exec
        v_mov_b32 v84, v77
.L20072_0:
        v_lshlrev_b32 v77, 2, v76
        v_readlane_b32 s1, v86, 3
        v_add_i32       v77, vcc, s1, v77
        tbuffer_load_format_x v77, v77, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[36:37], v84, v68
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[38:39], v82, v77
        s_or_b64        vcc, s[36:37], s[38:39]
        s_and_saveexec_b64 s[40:41], vcc
        v_cndmask_b32 v68, 0, -1, s[38:39]
        s_cbranch_execz .L20152_0
        v_cndmask_b32 v77, 0, -1, s[36:37]
        v_mov_b32 v69, 1
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L20244_0
.L20152_0:
        s_and_b64       exec, s[40:41], s[34:35]
        v_add_i32       v76, vcc, v68, v84
        v_ashrrev_i32   v76, 1, v76
        v_lshlrev_b32 v77, 2, v76
        v_readlane_b32 s1, v86, 3
        v_add_i32       v77, vcc, s1, v77
        v_add_i32       v75, vcc, 1, v76
        tbuffer_load_format_x v77, v77, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    vcc, v82, v77
        s_mov_b64       s[36:37], exec
        s_andn2_b64     exec, s[36:37], vcc
        v_mov_b32 v68, v76
        s_cbranch_execz .L20224_0
        v_mov_b32 v77, v84
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L20244_0
.L20224_0:
        s_mov_b64       exec, s[34:35]
        v_mov_b32 v77, v84
        v_mov_b32 v84, v75
        s_branch        .L20072_0
        v_mov_b32 v68, v76
.L20244_0:
        s_mov_b64       exec, s[32:33]
        v_cmp_lg_u32    vcc, 0, v69
        s_and_saveexec_b64 s[32:33], vcc
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L20272_0
        s_mov_b64       exec, s[30:31]
        s_branch        .L20056_0
.L20272_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_eq_u32    vcc, 0, v68
        v_cndmask_b32 v74, 1.0, v74, vcc
        v_mov_b32 v75, 1
.L20288_0:
        s_andn2_b64     exec, s[26:27], exec
        v_mov_b32 v75, 0
        s_mov_b64       exec, s[26:27]
.L20300_0:
        s_andn2_b64     exec, s[24:25], exec
        v_mov_b32 v75, 0
        s_mov_b64       exec, s[24:25]
        v_cmp_eq_u32    vcc, 0, v74
        s_and_b64       exec, s[24:25], vcc
        v_lshlrev_b32 v68, 6, v82
        s_cbranch_execz .L22196_0
        v_and_b32 v68, 0x3fffffc0, v68
        v_lshrrev_b32 v77, 18, v68
        v_add_i32       v77, vcc, s82, v77
        buffer_load_ubyte v77, v77, s[8:11], 0 offen
        v_and_b32 v69, v51, v79
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v19, v79
        v_cndmask_b32 v84, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v59, v79
        v_or_b32 v68, v84, v68
        v_cndmask_b32 v84, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v27, v79
        v_or_b32 v68, v68, v84
        v_cndmask_b32 v84, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v34, v79
        v_or_b32 v68, v68, v84
        v_cndmask_b32 v84, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v2, v79
        v_or_b32 v68, v68, v84
        v_cndmask_b32 v84, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_or_b32 v68, v68, v84
        v_cndmask_b32 v69, 0, 1, vcc
        v_or_b32 v68, v68, v69
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v77
        s_and_saveexec_b64 s[26:27], vcc
        v_bfe_u32       v82, v82, 0, 24
        s_cbranch_execz .L20688_0
        v_add_i32       v82, vcc, s83, v82
        buffer_load_ubyte v82, v82, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v82
        s_and_saveexec_b64 s[28:29], vcc
        s_cbranch_execz .L20688_0
        s_mov_b64       s[30:31], exec
        s_mov_b64       s[32:33], exec
        v_mov_b32 v71, s0
        v_mov_b32 v82, 0
        v_mov_b32 v77, 0
        s_movk_i32      s34, 0x0
        s_movk_i32      s35, 0x0
.L20552_0:
        v_lshlrev_b32 v77, 2, v77
        v_readlane_b32 s1, v86, 3
        v_add_i32       v77, vcc, s1, v77
        tbuffer_load_format_x v77, v77, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[36:37], v82, v71
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v68, v77
        s_andn2_b64     s[34:35], s[34:35], exec
        s_or_b64        s[34:35], vcc, s[34:35]
        s_or_b64        vcc, s[36:37], vcc
        s_and_saveexec_b64 s[36:37], vcc
        s_andn2_b64     s[32:33], s[32:33], exec
        s_cbranch_scc0  .L20672_0
        s_mov_b64       exec, s[32:33]
        v_add_i32       v77, vcc, v71, v82
        v_ashrrev_i32   v77, 1, v77
        v_lshlrev_b32 v69, 2, v77
        v_readlane_b32 s1, v86, 3
        v_add_i32       v69, vcc, s1, v69
        v_add_i32       v84, vcc, -1, v77
        v_add_i32       v75, vcc, 1, v77
        tbuffer_load_format_x v69, v69, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v69, v68
        v_cndmask_b32 v82, v75, v82, vcc
        v_cndmask_b32 v71, v71, v84, vcc
        s_branch        .L20552_0
.L20672_0:
        s_mov_b64       exec, s[30:31]
        v_cndmask_b32 v83, v83, 1.0, s[34:35]
        v_mov_b32 v75, 1
.L20688_0:
        s_mov_b64       exec, s[26:27]
        v_cmp_eq_u32    vcc, 0, v83
        s_and_b64       exec, s[26:27], vcc
        v_lshlrev_b32 v82, 6, v68
        s_cbranch_execz .L22196_0
        v_and_b32 v82, 0x3fffffc0, v82
        v_lshrrev_b32 v77, 18, v82
        v_add_i32       v77, vcc, s82, v77
        buffer_load_ubyte v77, v77, s[8:11], 0 offen
        v_and_b32 v69, v42, v79
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v10, v79
        v_cndmask_b32 v84, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v50, v79
        v_or_b32 v82, v84, v82
        v_cndmask_b32 v84, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v18, v79
        v_or_b32 v82, v82, v84
        v_cndmask_b32 v84, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v58, v79
        v_or_b32 v82, v82, v84
        v_cndmask_b32 v84, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v26, v79
        v_or_b32 v82, v82, v84
        v_cndmask_b32 v84, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_or_b32 v82, v82, v84
        v_cndmask_b32 v69, 0, 1, vcc
        v_or_b32 v82, v82, v69
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v77
        s_and_saveexec_b64 s[28:29], vcc
        v_bfe_u32       v68, v68, 0, 24
        s_cbranch_execz .L21072_0
        v_add_i32       v68, vcc, s83, v68
        buffer_load_ubyte v68, v68, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v68
        s_and_saveexec_b64 s[30:31], vcc
        s_cbranch_execz .L21072_0
        s_mov_b64       s[32:33], exec
        s_mov_b64       s[34:35], exec
        v_mov_b32 v71, s0
        v_mov_b32 v68, 0
        v_mov_b32 v77, 0
        s_movk_i32      s36, 0x0
        s_movk_i32      s37, 0x0
        s_nop           0x0
.L20936_0:
        v_lshlrev_b32 v77, 2, v77
        v_readlane_b32 s1, v86, 3
        v_add_i32       v77, vcc, s1, v77
        tbuffer_load_format_x v77, v77, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[38:39], v68, v71
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v82, v77
        s_andn2_b64     s[36:37], s[36:37], exec
        s_or_b64        s[36:37], vcc, s[36:37]
        s_or_b64        vcc, s[38:39], vcc
        s_and_saveexec_b64 s[38:39], vcc
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L21056_0
        s_mov_b64       exec, s[34:35]
        v_add_i32       v77, vcc, v71, v68
        v_ashrrev_i32   v77, 1, v77
        v_lshlrev_b32 v69, 2, v77
        v_readlane_b32 s1, v86, 3
        v_add_i32       v69, vcc, s1, v69
        v_add_i32       v84, vcc, -1, v77
        v_add_i32       v75, vcc, 1, v77
        tbuffer_load_format_x v69, v69, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v69, v82
        v_cndmask_b32 v68, v75, v68, vcc
        v_cndmask_b32 v71, v71, v84, vcc
        s_branch        .L20936_0
.L21056_0:
        s_mov_b64       exec, s[32:33]
        v_cndmask_b32 v55, v55, 1.0, s[36:37]
        v_mov_b32 v75, 1
.L21072_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_eq_u32    vcc, 0, v55
        s_and_b64       exec, s[28:29], vcc
        v_lshlrev_b32 v68, 6, v82
        s_cbranch_execz .L22196_0
        v_and_b32 v68, 0x3fffffc0, v68
        v_lshrrev_b32 v77, 18, v68
        v_add_i32       v77, vcc, s82, v77
        buffer_load_ubyte v77, v77, s[8:11], 0 offen
        v_and_b32 v69, v33, v79
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v1, v79
        v_cndmask_b32 v84, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v41, v79
        v_or_b32 v68, v84, v68
        v_cndmask_b32 v84, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v9, v79
        v_or_b32 v68, v68, v84
        v_cndmask_b32 v84, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v49, v79
        v_or_b32 v68, v68, v84
        v_cndmask_b32 v84, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v17, v79
        v_or_b32 v68, v68, v84
        v_cndmask_b32 v84, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_or_b32 v68, v68, v84
        v_cndmask_b32 v69, 0, 1, vcc
        v_or_b32 v68, v68, v69
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v77
        s_and_saveexec_b64 s[30:31], vcc
        v_bfe_u32       v82, v82, 0, 24
        s_cbranch_execz .L21452_0
        v_add_i32       v82, vcc, s83, v82
        buffer_load_ubyte v82, v82, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v82
        s_and_saveexec_b64 s[32:33], vcc
        s_cbranch_execz .L21452_0
        s_mov_b64       s[34:35], exec
        s_mov_b64       s[36:37], exec
        v_mov_b32 v71, s0
        v_mov_b32 v82, 0
        v_mov_b32 v77, 0
        s_movk_i32      s38, 0x0
        s_movk_i32      s39, 0x0
.L21316_0:
        v_lshlrev_b32 v77, 2, v77
        v_readlane_b32 s1, v86, 3
        v_add_i32       v77, vcc, s1, v77
        tbuffer_load_format_x v77, v77, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[40:41], v82, v71
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v68, v77
        s_andn2_b64     s[38:39], s[38:39], exec
        s_or_b64        s[38:39], vcc, s[38:39]
        s_or_b64        vcc, s[40:41], vcc
        s_and_saveexec_b64 s[40:41], vcc
        s_andn2_b64     s[36:37], s[36:37], exec
        s_cbranch_scc0  .L21436_0
        s_mov_b64       exec, s[36:37]
        v_add_i32       v77, vcc, v71, v82
        v_ashrrev_i32   v77, 1, v77
        v_lshlrev_b32 v69, 2, v77
        v_readlane_b32 s1, v86, 3
        v_add_i32       v69, vcc, s1, v69
        v_add_i32       v84, vcc, -1, v77
        v_add_i32       v75, vcc, 1, v77
        tbuffer_load_format_x v69, v69, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v69, v68
        v_cndmask_b32 v82, v75, v82, vcc
        v_cndmask_b32 v71, v71, v84, vcc
        s_branch        .L21316_0
.L21436_0:
        s_mov_b64       exec, s[34:35]
        v_cndmask_b32 v47, v47, 1.0, s[38:39]
        v_mov_b32 v75, 1
.L21452_0:
        s_mov_b64       exec, s[30:31]
        v_cmp_eq_u32    vcc, 0, v47
        s_and_b64       exec, s[30:31], vcc
        v_lshlrev_b32 v82, 6, v68
        s_cbranch_execz .L22196_0
        v_and_b32 v82, 0x3fffffc0, v82
        v_lshrrev_b32 v77, 18, v82
        v_add_i32       v77, vcc, s82, v77
        buffer_load_ubyte v77, v77, s[8:11], 0 offen
        v_and_b32 v69, v57, v79
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v25, v79
        v_cndmask_b32 v84, 0, 32, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v32, v79
        v_or_b32 v82, v84, v82
        v_cndmask_b32 v84, 0, 16, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v0, v79
        v_or_b32 v82, v82, v84
        v_cndmask_b32 v84, 0, 8, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v40, v79
        v_or_b32 v82, v82, v84
        v_cndmask_b32 v84, 0, 4, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_and_b32 v69, v8, v79
        v_or_b32 v82, v82, v84
        v_cndmask_b32 v84, 0, 2, vcc
        v_cmp_lg_i32    vcc, 0, v69
        v_or_b32 v82, v82, v84
        v_cndmask_b32 v69, 0, 1, vcc
        v_or_b32 v82, v82, v69
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v77
        s_and_saveexec_b64 s[32:33], vcc
        v_bfe_u32       v68, v68, 0, 24
        s_cbranch_execz .L21840_0
        v_add_i32       v68, vcc, s83, v68
        buffer_load_ubyte v68, v68, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v68
        s_and_saveexec_b64 s[34:35], vcc
        s_cbranch_execz .L21840_0
        s_mov_b64       s[36:37], exec
        s_mov_b64       s[38:39], exec
        v_mov_b32 v71, s0
        v_mov_b32 v68, 0
        v_mov_b32 v77, 0
        s_movk_i32      s40, 0x0
        s_movk_i32      s41, 0x0
        s_nop           0x0
        s_nop           0x0
.L21704_0:
        v_lshlrev_b32 v77, 2, v77
        v_readlane_b32 s1, v86, 3
        v_add_i32       v77, vcc, s1, v77
        tbuffer_load_format_x v77, v77, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[42:43], v68, v71
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v82, v77
        s_andn2_b64     s[40:41], s[40:41], exec
        s_or_b64        s[40:41], vcc, s[40:41]
        s_or_b64        vcc, s[42:43], vcc
        s_and_saveexec_b64 s[42:43], vcc
        s_andn2_b64     s[38:39], s[38:39], exec
        s_cbranch_scc0  .L21824_0
        s_mov_b64       exec, s[38:39]
        v_add_i32       v77, vcc, v71, v68
        v_ashrrev_i32   v77, 1, v77
        v_lshlrev_b32 v69, 2, v77
        v_readlane_b32 s1, v86, 3
        v_add_i32       v69, vcc, s1, v69
        v_add_i32       v84, vcc, -1, v77
        v_add_i32       v75, vcc, 1, v77
        tbuffer_load_format_x v69, v69, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v69, v82
        v_cndmask_b32 v68, v75, v68, vcc
        v_cndmask_b32 v71, v71, v84, vcc
        s_branch        .L21704_0
.L21824_0:
        s_mov_b64       exec, s[36:37]
        v_cndmask_b32 v64, v64, 1.0, s[40:41]
        v_mov_b32 v75, 1
.L21840_0:
        s_mov_b64       exec, s[32:33]
        v_cmp_eq_u32    vcc, 0, v64
        s_and_b64       exec, s[32:33], vcc
        v_lshlrev_b32 v68, 6, v82
        s_cbranch_execz .L22196_0
        v_and_b32 v68, 0x3fffffc0, v68
        v_lshrrev_b32 v77, 18, v68
        v_add_i32       v77, vcc, s82, v77
        buffer_load_ubyte v77, v77, s[8:11], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v77
        s_and_saveexec_b64 s[34:35], vcc
        v_bfe_u32       v82, v82, 0, 24
        s_cbranch_execz .L22180_0
        v_add_i32       v82, vcc, s83, v82
        buffer_load_ubyte v82, v82, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v82
        s_and_saveexec_b64 s[36:37], vcc
        v_and_b32 v71, v48, v79
        s_cbranch_execz .L22180_0
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 32, vcc
        v_or_b32 v71, v68, v71
        v_and_b32 v68, v16, v79
        v_cmp_lg_i32    vcc, 0, v68
        v_cndmask_b32 v68, 0, 16, vcc
        v_or_b32 v71, v71, v68
        v_and_b32 v68, v56, v79
        v_cmp_lg_i32    vcc, 0, v68
        v_cndmask_b32 v68, 0, 8, vcc
        v_or_b32 v71, v71, v68
        v_and_b32 v79, v24, v79
        v_cmp_lg_i32    vcc, 0, v79
        v_cndmask_b32 v79, 0, 4, vcc
        v_or_b32 v79, v71, v79
        s_mov_b64       s[38:39], exec
        s_mov_b64       s[40:41], exec
        v_mov_b32 v71, s0
        v_mov_b32 v68, 0
        v_mov_b32 v82, 0
        s_movk_i32      s42, 0x0
        s_movk_i32      s43, 0x0
.L22044_0:
        v_lshlrev_b32 v68, 2, v68
        v_readlane_b32 s1, v86, 3
        v_add_i32       v68, vcc, s1, v68
        tbuffer_load_format_x v68, v68, s[16:19], 0 offen format:[32,float]
        v_cmp_gt_i32    s[44:45], v82, v71
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, v79, v68
        s_andn2_b64     s[42:43], s[42:43], exec
        s_or_b64        s[42:43], vcc, s[42:43]
        s_or_b64        vcc, s[44:45], vcc
        s_and_saveexec_b64 s[44:45], vcc
        s_andn2_b64     s[40:41], s[40:41], exec
        s_cbranch_scc0  .L22164_0
        s_mov_b64       exec, s[40:41]
        v_add_i32       v68, vcc, v71, v82
        v_ashrrev_i32   v68, 1, v68
        v_lshlrev_b32 v77, 2, v68
        v_readlane_b32 s1, v86, 3
        v_add_i32       v77, vcc, s1, v77
        v_add_i32       v69, vcc, -1, v68
        v_add_i32       v84, vcc, 1, v68
        tbuffer_load_format_x v77, v77, s[16:19], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_ge_u32    vcc, v77, v79
        v_cndmask_b32 v82, v84, v82, vcc
        v_cndmask_b32 v71, v71, v69, vcc
        s_branch        .L22044_0
.L22164_0:
        s_mov_b64       exec, s[38:39]
        v_cndmask_b32 v78, v78, 1.0, s[42:43]
        v_mov_b32 v75, 1
.L22180_0:
        s_mov_b64       exec, s[34:35]
        v_cmp_eq_u32    vcc, 0, v78
        v_addc_u32      v65, vcc, v65, 0, vcc
.L22196_0:
        s_mov_b64       exec, s[24:25]
.L22200_0:
        s_andn2_b64     exec, s[22:23], exec
        v_mov_b32 v75, 0
        s_mov_b64       exec, s[22:23]
        s_branch        .L19192_0
.L22216_0:
        s_mov_b64       exec, s[2:3]
        v_cmp_lg_i32    vcc, 0, v75
        s_and_saveexec_b64 s[0:1], vcc
        v_readlane_b32 s2, v86, 0
        s_cbranch_execz .L22304_0
        v_readlane_b32 s3, v86, 1
        s_waitcnt       lgkmcnt(0)
        s_nop           0x2
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_readlane_b32 s12, v86, 2
        v_add_i32       v65, vcc, s12, v65
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v65, v65, s[8:11], 0 offen
        v_mov_b32 v72, 1
        s_load_dwordx4  s[8:11], s[2:3], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v72, v99, s[8:11], 0 offen offset:4 glc
        s_waitcnt       vmcnt(1)
        buffer_store_byte v65, v99, s[8:11], 0 offen offset:24 glc
.L22304_0:
        s_mov_b64       exec, s[0:1]
        s_waitcnt       expcnt(1)
        v_mov_b32 v72, 2
        s_branch        .L23616_0
.L22320_0:
        s_cmp_eq_i32    s80, 2
        s_cbranch_scc1  .L22336_0
        v_mov_b32 v72, 1
        s_branch        .L23616_0
.L22336_0:
        v_readlane_b32 s0, v86, 0
        v_readlane_b32 s1, v86, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[0:1], 0x70
        s_load_dwordx4  s[12:15], s[0:1], 0x78
        s_load_dwordx4  s[0:3], s[0:1], 0x68
        s_mov_b64       s[16:17], exec
        s_mov_b64       s[18:19], exec
        v_mov_b32 v65, 0
        v_mov_b32 v72, v78
.L22376_0:
        v_cmp_lt_i32    vcc, 31, v65
        s_and_saveexec_b64 s[20:21], vcc
        v_mov_b32 v72, 0
        s_cbranch_execz .L22400_0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L23508_0
.L22400_0:
        s_and_b64       exec, s[20:21], s[18:19]
        v_lshl_b32 v72, 1, v65
        v_and_b32 v79, v63, v72
        v_cmp_lg_i32    vcc, 0, v79
        v_mov_b32 v79, 0x20000000
        v_cndmask_b32 v79, 0, v79, vcc
        v_and_b32 v71, v31, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x10000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v38, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x8000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v6, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x4000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v46, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x2000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v14, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x1000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v54, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x800000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v22, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x400000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v62, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x200000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v30, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x100000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v37, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x80000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v5, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x40000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_lshrrev_b32 v71, 18, v79
        v_add_i32       v71, vcc, s82, v71
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v71, v71, s[8:11], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_lg_i32    vcc, 0, v71
        s_mov_b64       s[20:21], exec
        s_andn2_b64     exec, s[20:21], vcc
        v_and_b32 v71, v45, v72
        s_cbranch_execz .L23480_0
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x20000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v13, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x10000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v53, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x8000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v21, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x4000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v61, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x2000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v29, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x1000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v36, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x800
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v4, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x400
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v44, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x200
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v12, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x100
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v52, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x80
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v20, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 64, vcc
        v_or_b32 v79, v79, v71
        v_lshrrev_b32 v71, 6, v79
        v_add_i32       v71, vcc, s83, v71
        buffer_load_ubyte v71, v71, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v71
        s_and_saveexec_b64 s[22:23], vcc
        v_and_b32 v71, v60, v72
        s_cbranch_execz .L23460_0
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 32, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v28, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 16, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v35, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 8, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v3, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 4, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v43, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 2, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v72, v11, v72
        v_cmp_lg_i32    vcc, 0, v72
        v_cndmask_b32 v72, 0, 1, vcc
        v_or_b32 v72, v79, v72
        s_mov_b64       s[24:25], exec
        s_mov_b64       s[26:27], exec
        v_mov_b32 v47, s81
        v_mov_b32 v79, 0
        v_mov_b32 v71, 0
        v_mov_b32 v83, 0
.L23192_0:
        v_add_i32       v64, vcc, -1, v47
        s_mov_b64       s[28:29], exec
        s_mov_b64       s[30:31], exec
        v_mov_b32 v78, v83
        s_nop           0x0
        s_nop           0x0
.L23216_0:
        v_lshlrev_b32 v79, 2, v79
        v_readlane_b32 s32, v86, 3
        v_add_i32       v79, vcc, s32, v79
        tbuffer_load_format_x v79, v79, s[0:3], 0 offen format:[32,float]
        v_cmp_gt_i32    s[32:33], v83, v64
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[34:35], v72, v79
        s_or_b64        vcc, s[32:33], s[34:35]
        s_and_saveexec_b64 s[36:37], vcc
        v_cndmask_b32 v79, 0, -1, s[34:35]
        s_cbranch_execz .L23300_0
        v_cndmask_b32 v47, 0, -1, s[32:33]
        v_mov_b32 v71, 1
        v_mov_b32 v83, v78
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L23396_0
.L23300_0:
        s_and_b64       exec, s[36:37], s[30:31]
        v_add_i32       v79, vcc, v64, v83
        v_ashrrev_i32   v79, 1, v79
        v_lshlrev_b32 v47, 2, v79
        v_readlane_b32 s32, v86, 3
        v_add_i32       v47, vcc, s32, v47
        v_add_i32       v78, vcc, 1, v79
        tbuffer_load_format_x v47, v47, s[0:3], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    vcc, v72, v47
        s_mov_b64       s[32:33], exec
        s_andn2_b64     exec, s[32:33], vcc
        v_mov_b32 v47, v79
        s_cbranch_execz .L23368_0
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L23396_0
.L23368_0:
        s_mov_b64       exec, s[30:31]
        v_mov_b32 v47, v79
        v_mov_b32 v85, v78
        v_mov_b32 v78, v83
        v_mov_b32 v83, v85
        s_branch        .L23216_0
        v_mov_b32 v83, v78
.L23396_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_lg_u32    vcc, 0, v71
        s_and_saveexec_b64 s[28:29], vcc
        s_andn2_b64     s[26:27], s[26:27], exec
        s_cbranch_scc0  .L23424_0
        s_mov_b64       exec, s[26:27]
        s_branch        .L23192_0
.L23424_0:
        s_mov_b64       exec, s[24:25]
        v_cmp_lg_u32    vcc, 0, v79
        s_and_saveexec_b64 s[24:25], vcc
        v_mov_b32 v72, 1
        s_cbranch_execz .L23452_0
        s_andn2_b64     s[18:19], s[18:19], exec
        s_cbranch_scc0  .L23508_0
.L23452_0:
        s_and_b64       exec, s[24:25], s[18:19]
        v_mov_b32 v72, 1
.L23460_0:
        s_andn2_b64     exec, s[22:23], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32 v72, 0
        s_cbranch_execz .L23476_0
.L23476_0:
        s_and_b64       exec, s[22:23], s[18:19]
.L23480_0:
        s_andn2_b64     exec, s[20:21], exec
        s_and_b64       exec, exec, s[18:19]
        v_mov_b32 v72, 0
        s_cbranch_execz .L23496_0
.L23496_0:
        s_and_b64       exec, s[20:21], s[18:19]
        v_add_i32       v65, vcc, 1, v65
        s_branch        .L22376_0
.L23508_0:
        s_mov_b64       exec, s[16:17]
        v_cmp_eq_i32    vcc, 0, v72
        s_waitcnt       lgkmcnt(0)
        s_and_saveexec_b64 s[0:1], vcc
        v_mov_b32 v72, 1
        s_andn2_b64     exec, s[0:1], exec
        v_readlane_b32 s2, v86, 0
        s_cbranch_execz .L23612_0
        v_readlane_b32 s3, v86, 1
        s_nop           0x3
        s_load_dwordx4  s[8:11], s[2:3], 0x50
        v_readlane_b32 s12, v86, 2
        v_add_i32       v65, vcc, s12, v65
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v65, v65, s[8:11], 0 offen
        v_mov_b32 v72, 1
        s_load_dwordx4  s[8:11], s[2:3], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v72, v99, s[8:11], 0 offen offset:4 glc
        s_waitcnt       vmcnt(1)
        buffer_store_byte v65, v99, s[8:11], 0 offen offset:24 glc
        s_waitcnt       expcnt(1)
        v_mov_b32 v72, 0
.L23612_0:
        s_mov_b64       exec, s[0:1]
.L23616_0:
        v_cmp_lg_i32    vcc, 2, v72
        s_and_saveexec_b64 s[0:1], vcc
        v_cmp_lg_u32    vcc, 0, v72
        s_cbranch_execz .L24872_0
        s_and_saveexec_b64 s[2:3], vcc
        s_cbranch_execz .L24872_0
        s_add_u32       s80, -1, s80
        s_cmp_le_u32    s80, 1
        s_cbranch_scc0  .L24872_0
        s_waitcnt       lgkmcnt(0)
        v_readlane_b32 s8, v86, 0
        v_readlane_b32 s9, v86, 1
        s_nop           0x3
        s_load_dwordx4  s[12:15], s[8:9], 0x70
        s_load_dwordx4  s[16:19], s[8:9], 0x78
        s_load_dwordx4  s[8:11], s[8:9], 0x68
        s_mov_b64       s[20:21], exec
        s_mov_b64       s[22:23], exec
        s_waitcnt       expcnt(0)
        v_mov_b32 v65, 0
.L23696_0:
        v_cmp_gt_i32    s[24:25], v65, 31
        s_and_saveexec_b64 s[24:25], s[24:25]
        v_mov_b32 v72, 0
        s_cbranch_execz .L23724_0
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L24784_0
.L23724_0:
        s_and_b64       exec, s[24:25], s[22:23]
        v_lshl_b32 v72, 1, v65
        v_and_b32 v79, v51, v72
        v_cmp_lg_i32    vcc, 0, v79
        v_mov_b32 v79, 0x20000000
        v_cndmask_b32 v79, 0, v79, vcc
        v_and_b32 v71, v19, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x10000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v59, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x8000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v27, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x4000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v34, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x2000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v2, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x1000000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v42, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x800000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v10, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x400000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v50, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x200000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v18, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x100000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v58, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x80000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v26, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x40000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_lshrrev_b32 v71, 18, v79
        v_add_i32       v71, vcc, s82, v71
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v71, v71, s[12:15], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_lg_i32    vcc, 0, v71
        s_mov_b64       s[24:25], exec
        s_andn2_b64     exec, s[24:25], vcc
        v_and_b32 v71, v33, v72
        s_cbranch_execz .L24756_0
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x20000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v1, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x10000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v41, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x8000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v9, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x4000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v49, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x2000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v17, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x1000
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v57, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x800
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v25, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x400
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v32, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x200
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v0, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x100
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v40, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_mov_b32 v71, 0x80
        v_cndmask_b32 v71, 0, v71, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v8, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 64, vcc
        v_or_b32 v79, v79, v71
        v_lshrrev_b32 v71, 6, v79
        v_add_i32       v71, vcc, s83, v71
        buffer_load_ubyte v71, v71, s[16:19], 0 offen
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    vcc, 0, v71
        s_and_saveexec_b64 s[26:27], vcc
        v_and_b32 v71, v48, v72
        s_cbranch_execz .L24736_0
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 32, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v16, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 16, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v71, v56, v72
        v_cmp_lg_i32    vcc, 0, v71
        v_cndmask_b32 v71, 0, 8, vcc
        v_or_b32 v79, v79, v71
        v_and_b32 v72, v24, v72
        v_cmp_lg_i32    vcc, 0, v72
        v_cndmask_b32 v72, 0, 4, vcc
        v_or_b32 v72, v79, v72
        s_mov_b64       s[28:29], exec
        s_mov_b64       s[30:31], exec
        v_mov_b32 v62, s81
        v_mov_b32 v79, 0
        v_mov_b32 v63, 0
        v_mov_b32 v55, 0
.L24476_0:
        v_add_i32       v61, vcc, -1, v62
        s_mov_b64       s[32:33], exec
        s_mov_b64       s[34:35], exec
        v_mov_b32 v60, v55
.L24492_0:
        v_lshlrev_b32 v79, 2, v79
        v_readlane_b32 s80, v86, 3
        v_add_i32       v79, vcc, s80, v79
        tbuffer_load_format_x v79, v79, s[8:11], 0 offen format:[32,float]
        v_cmp_gt_i32    s[36:37], v55, v61
        s_waitcnt       vmcnt(0)
        v_cmp_eq_i32    s[38:39], v72, v79
        s_or_b64        vcc, s[36:37], s[38:39]
        s_and_saveexec_b64 s[40:41], vcc
        v_cndmask_b32 v79, 0, -1, s[38:39]
        s_cbranch_execz .L24576_0
        v_cndmask_b32 v62, 0, -1, s[36:37]
        v_mov_b32 v63, 1
        v_mov_b32 v55, v60
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L24672_0
.L24576_0:
        s_and_b64       exec, s[40:41], s[34:35]
        v_add_i32       v79, vcc, v61, v55
        v_ashrrev_i32   v79, 1, v79
        v_lshlrev_b32 v62, 2, v79
        v_readlane_b32 s80, v86, 3
        v_add_i32       v62, vcc, s80, v62
        v_add_i32       v60, vcc, 1, v79
        tbuffer_load_format_x v62, v62, s[8:11], 0 offen format:[32,float]
        s_waitcnt       vmcnt(0)
        v_cmp_gt_u32    vcc, v72, v62
        s_mov_b64       s[36:37], exec
        s_andn2_b64     exec, s[36:37], vcc
        v_mov_b32 v62, v79
        s_cbranch_execz .L24644_0
        s_andn2_b64     s[34:35], s[34:35], exec
        s_cbranch_scc0  .L24672_0
.L24644_0:
        s_mov_b64       exec, s[34:35]
        v_mov_b32 v62, v79
        v_mov_b32 v85, v60
        v_mov_b32 v60, v55
        v_mov_b32 v55, v85
        s_branch        .L24492_0
        v_mov_b32 v55, v60
.L24672_0:
        s_mov_b64       exec, s[32:33]
        v_cmp_lg_u32    vcc, 0, v63
        s_and_saveexec_b64 s[32:33], vcc
        s_andn2_b64     s[30:31], s[30:31], exec
        s_cbranch_scc0  .L24700_0
        s_mov_b64       exec, s[30:31]
        s_branch        .L24476_0
.L24700_0:
        s_mov_b64       exec, s[28:29]
        v_cmp_lg_u32    vcc, 0, v79
        s_and_saveexec_b64 s[28:29], vcc
        v_mov_b32 v72, 1
        s_cbranch_execz .L24728_0
        s_andn2_b64     s[22:23], s[22:23], exec
        s_cbranch_scc0  .L24784_0
.L24728_0:
        s_and_b64       exec, s[28:29], s[22:23]
        v_mov_b32 v72, 1
.L24736_0:
        s_andn2_b64     exec, s[26:27], exec
        s_and_b64       exec, exec, s[22:23]
        v_mov_b32 v72, 0
        s_cbranch_execz .L24752_0
.L24752_0:
        s_and_b64       exec, s[26:27], s[22:23]
.L24756_0:
        s_andn2_b64     exec, s[24:25], exec
        s_and_b64       exec, exec, s[22:23]
        v_mov_b32 v72, 0
        s_cbranch_execz .L24772_0
.L24772_0:
        s_mov_b64       exec, s[22:23]
        v_add_i32       v65, vcc, 1, v65
        s_branch        .L23696_0
.L24784_0:
        s_mov_b64       exec, s[20:21]
        v_cmp_lg_i32    vcc, 0, v72
        s_and_saveexec_b64 s[80:81], vcc
        v_readlane_b32 s82, v86, 0
        s_cbranch_execz .L24872_0
        v_readlane_b32 s83, v86, 1
        s_waitcnt       lgkmcnt(0)
        s_nop           0x2
        s_load_dwordx4  s[8:11], s[82:83], 0x50
        v_readlane_b32 s12, v86, 2
        v_add_i32       v65, vcc, s12, v65
        s_waitcnt       lgkmcnt(0)
        buffer_load_ubyte v65, v65, s[8:11], 0 offen
        v_mov_b32 v72, 1
        s_load_dwordx4  s[8:11], s[82:83], 0x60
        s_waitcnt       lgkmcnt(0)
        buffer_store_byte v72, v99, s[8:11], 0 offen offset:4 glc
        s_waitcnt       vmcnt(1)
        buffer_store_byte v65, v99, s[8:11], 0 offen offset:24 glc
.L24872_0:
        s_mov_b64       exec, s[0:1]
        s_waitcnt       expcnt(0)
        v_mov_b32 v65, 32
        v_readlane_b32 s0, v86, 0
        v_readlane_b32 s1, v86, 1
        s_nop           0x3
        s_load_dwordx4  s[0:3], s[0:1], 0x60
        s_waitcnt       lgkmcnt(0)
        tbuffer_store_format_x v65, v99, s[0:3], 0 offen format:[32,float]
        s_endpgm
