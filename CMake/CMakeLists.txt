cmake_minimum_required(VERSION 3.0.0)
project(MerikensTripcodeEngine CXX)



###########
# OPTIONS #
###########

option(USE_YASM "USE_YASM" ON)
option(ENABLE_OPENCL "ENABLE_OPENCL" ON)



##########
# OpenCL #
##########

set(CYGWIN_AMD_APP_SDK_DIR "/cygdrive/c/Program\ Files\ (x86)/AMD\ APP\ SDK/3.0")
if(ENABLE_OPENCL AND CYGWIN AND EXISTS ${CYGWIN_AMD_APP_SDK_DIR})
    set(OPENCL_LINK_LIBRARIES
        OpenCL)
    set(OPENCL_INCLUDE_DIR
        "${CYGWIN_AMD_APP_SDK_DIR}/include")
    set(OPENCL_LINK_DIR
        "${CYGWIN_AMD_APP_SDK_DIR}/lib/x86_64")
else()
    set(ENABLE_OPENCL FALSE)
endif()
if(ENABLE_OPENCL)
    file(GLOB OPENCL_SOURCES
        "../SourceFiles/OpenCL*.cpp")
    set(MTE_COMPILE_FLAGS ${MTE_COMPILE_FLAGS}
        -DENABLE_OPENCL)
endif()



set(YASM_FILES)
find_program(YASM_EXE NAMES yasm)
if((UNIX AND NOT CYGWIN) OR (NOT YASM_EXE))
    set(USE_YASM FALSE)
endif(UNIX)
if(USE_YASM)
    set(MTE_COMPILE_FLAGS "${MTE_COMPILE_FLAGS} -DUSE_YASM")
    function(assemble_yasm_files out_var)
	set(result)
	foreach(in_f ${ARGN})
		set(out_f "${CMAKE_CURRENT_BINARY_DIR}/${in_f}")
		string(REPLACE ".asm" ".o" out_f ${out_f})
		set(in_f "${CMAKE_CURRENT_SOURCE_DIR}/../SourceFiles/${in_f}")
		add_custom_command(
			OUTPUT ${out_f}
			DEPENDS ${in_f}
			COMMAND ${YASM_EXE}
			ARGS -f Win64 -o ${out_f} ${in_f}
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      			COMMENT "Building YASM object ${out_f}")
		list(APPEND result ${out_f})
	endforeach()
	set(${out_var} "${result}" PARENT_SCOPE)
    endfunction()
    assemble_yasm_files(YASM_FILES
	CPU10_x64_AVX.asm
	CPU10_x64_AVX2.asm
	CPU10_x64_SSE2.asm
	CPU10_x64_SSE2_Nehalem.asm
	CPU12_x64_AVX.asm
	CPU12_x64_AVX2.asm
	CPU12_x64_SSE2.asm
	CPU12_x64_SSE2_Nehalem.asm)
endif()



set(CORE_SOURCES
	../SourceFiles/Main.cpp
	../SourceFiles/Patterns.cpp
	../SourceFiles/Testing.cpp
	../SourceFiles/Verification10.cpp
	../SourceFiles/Verification12.cpp
	../SourceFiles/VerificationDuplicates.cpp
	../SourceFiles/UtilityFunctions.cpp)
if (USE_YASM)
	file(GLOB CPU_SOURCES
		"../SourceFiles/CPU10_yasm.cpp"
		"../SourceFiles/CPU10_AVX2.cpp"
		"../SourceFiles/CPU12_yasm.cpp")
else()
	file(GLOB CPU_SOURCES
		"../SourceFiles/CPU10_SSE2Intrinsics.cpp"
		"../SourceFiles/CPU12_SSE2Intrinsics.cpp")
endif()
set(SOURCES
	${CORE_SOURCES}
	${CPU_SOURCES}
	${OPENCL_SOURCES})



LINK_LIBRARIES(${OPENCL_LINK_LIBRARIES} boost_system)
include_directories(
    "../SourceFiles"
    "../BoostPackages/include"
    "../BoostPackages/boost_1_61_0_b1/"
    ${OPENCL_INCLUDE_DIR})
link_directories(
    "../BoostPackages/lib/Cygwin64"
    "../BoostPackages/boost_1_61_0_b1/stage/lib/"
    ${OPENCL_LINK_DIR})



if(UNIX)
    SET(GCC_COVERAGE_COMPILE_FLAGS "${GCC_COVERAGE_COMPILE_FLAGS} -pthread")
endif(UNIX)
if(CYGWIN)
    SET(GCC_COVERAGE_COMPILE_FLAGS "${GCC_COVERAGE_COMPILE_FLAGS} -fno-access-control")
endif(CYGWIN)
SET(GCC_COVERAGE_COMPILE_FLAGS "${GCC_COVERAGE_COMPILE_FLAGS} -std=c++11 -Wall -Wno-deprecated-declarations -O3")
SET(MTE_COMPILE_FLAGS "${MTE_COMPILE_FLAGS} -DENGLISH_VERSION")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS} ${MTE_COMPILE_FLAGS}")
#SET( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} --enable-auto-import" )

#set(CMAKE_INCLUDE_CURRENT_DIR ON)
add_executable(MerikensTripcodeEngine ${SOURCES} ${YASM_FILES})

