
cmake_minimum_required( VERSION 3.26.3 )

project(
	timer
	VERSION 1.0
	LANGUAGES CXX
)

add_executable( timer src/main.cpp )

set_target_properties(
	timer
	PROPERTIES
	OUTPUT_NAME                      "timer"
	RUNTIME_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_BINARY_DIR}/builds/debug"
	RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/builds/release"
)

target_compile_definitions( timer PRIVATE C_PLUS_PLUS )
target_compile_definitions( timer PRIVATE "$<$<CONFIG:Debug>:DEBUG>" )
target_compile_definitions( timer PRIVATE "$<$<CONFIG:Release>:NDEBUG>" )

target_compile_features( timer PRIVATE cxx_std_20 )

if ( MSVC )
	target_compile_definitions( timer PRIVATE _CRT_SECURE_NO_WARNINGS )
	target_compile_options( timer PRIVATE -WX -W4 -wd4100 -wd4201 -wd4706 -Zc:preprocessor -Zc:strictStrings -GR- )
	target_compile_options( timer PRIVATE $<$<CONFIG:Debug>:-Z7 -FC -MDd> )
	target_compile_options( timer PRIVATE $<$<CONFIG:Release>:-MD -O2 -Ot -GF> )
endif()

if ( CMAKE_COMPILER_IS_GNUCC )
	target_compile_options( timer PRIVATE -Wall -Wextra -Wpedantic -Werror -Wno-uninitialized -Wno-non-virtual-dtor -fno-rtti )
	target_compile_options( timer PRIVATE $<$<CONFIG:Debug>:-OO -g> )
	target_compile_options( timer PRIVATE $<$<CONFIG:Release>:-O2> )
endif()

if ( CMAKE_SYSTEM_NAME STREQUAL "Windows" )
	target_compile_definitions( timer PRIVATE "PLATFORM_WINDOWS" )
endif()
if ( CMAKE_SYSTEM_NAME STREQUAL "Linux" )
	target_compile_definitions( timer PRIVATE "PLATFORM_LINUX" )
endif()
if ( CMAKE_SYSTEM_NAME STREQUAL "Darwin" )
	target_compile_definitions( timer PRIVATE "PLATFORM_MAC" )
endif()