#GNU toolchain
set(CMAKE_C_COMPILER_ID GNU)
set(CMAKE_CXX_COMPILER_ID GNU)

if(WIN32)
    set(UTIL_SEARCH_CMD where)
elseif(UNIX OR APPLE)
    set(UTIL_SEARCH_CMD which)
endif()

#find toolchain paths in the system
execute_process(COMMAND ${UTIL_SEARCH_CMD} ${TOOLCHAIN_PREFIX}gcc${TOOLCHAIN_VER}
                OUTPUT_VARIABLE BINUTILS_PATHS
                RESULTS_VARIABLE ERROR_RESULT
                ERROR_QUIET)

#if not found, fail
if(NOT ${ERROR_RESULT} EQUAL 0)
    message(FATAL_ERROR "\nGNU toolchain${TOOLCHAIN_VER} not found!\n")
endif()

#convert it to a list and get the first folder in case of multiple paths
string(REPLACE "\n" ";" BINUTILS_PATHS_LIST ${BINUTILS_PATHS})
list(GET BINUTILS_PATHS_LIST 0 TOOLCHAIN_DIR)
cmake_path(REMOVE_FILENAME TOOLCHAIN_DIR OUTPUT_VARIABLE TOOLCHAIN_DIR)

#assembler flags
set(ASM_OPTIONS
    -D__ASSEMBLY__
    -x assembler-with-cpp
    )

#compile flags
set(COMPILER_FLAGS
    -fdata-sections
    -fdebug-prefix-map=${PROJECT_SOURCE_DIR}=. #make debug file paths relative in elf
    -ffunction-sections
    -fmacro-prefix-map=${PROJECT_SOURCE_DIR}=${PROJECT_NAME} #add proj name as root for _FILE_ macro
    -fmessage-length=0
    -fstack-protector-strong
    -fstack-usage
    -fstrict-aliasing
    $<$<COMPILE_LANGUAGE:CXX>:
    -fcoroutines
    >
    $<IF:$<STREQUAL:${SPEC_FLAGS},--specs=nano.specs>,
    -fno-exceptions
    $<$<COMPILE_LANGUAGE:CXX>:
    -fno-rtti
    >
    ,-fexceptions
    >
    $<$<CONFIG:Release>:
    -ffat-lto-objects
    -flto=auto
    >
    )

#arm-none-eabi-gcc -Q --help=warning
set(WARNING_OPTIONS
#    -Waggregate-return
    -Wall
    -Walloc-zero
    -Walloca
    -Wanalyzer-too-complex
    -Warith-conversion
    -Warray-bounds=2
    -Wattribute-alias=2
    -Wcast-align
    -Wcast-qual
    -Wconversion
    -Wdangling-else
    -Wdate-time
    -Wdisabled-optimization
    -Wdouble-promotion
    -Wduplicated-branches
    -Wduplicated-cond
    -Werror
    -Wextra
#   -Wfatal-errors
    -Wfloat-conversion
    -Wfloat-equal
    -Wformat=2
    -Wformat-diag
    -Wformat-overflow=2
    -Wformat-signedness
    -Wformat-truncation=2
    -Wimplicit-fallthrough=5
    -Winvalid-pch
    -Wlogical-op
    -Wmissing-declarations
    -Wmissing-include-dirs
    -Wmultichar
    -Wnormalized=nfc
    -Wnull-dereference
    -Wpacked
    -Wpacked-not-aligned
#    -Wpadded
    -Wpedantic
    -Wpointer-arith
    -Wredundant-decls
    -Wscalar-storage-order
    -Wshadow
    -Wshift-overflow=2
    -Wstack-protector
    -Wstrict-overflow=5
    -Wstringop-overflow=4
    -Wstringop-truncation
#    -Wsuggest-attribute=cold
#    -Wsuggest-attribute=const
#    -Wsuggest-attribute=format
#    -Wsuggest-attribute=malloc
#    -Wsuggest-attribute=noreturn
#    -Wsuggest-attribute=pure
#    -Wsuggest-final-methods
#    -Wsuggest-final-types
    -Wswitch-default
    -Wswitch-enum
    -Wtrampolines                         
    -Wundef
    -Wunused-const-variable
    -Wunused-macros
    -Wvector-operation-performance
    -Wvla
    -Wwrite-strings
    $<$<COMPILE_LANGUAGE:C>:
    -Wbad-function-cast
    -Winit-self
    -Wjump-misses-init
    -Wmissing-parameter-type
    -Wmissing-prototypes
    -Wnarrowing
    -Wnested-externs
    -Wstrict-prototypes
    -Wunsuffixed-float-constants
    >
    $<$<COMPILE_LANGUAGE:CXX>:
    -Waligned-new=all
    -Wcatch-value=3
    -Wclass-conversion
    -Wclass-memaccess
    -Wcomma-subscript
    -Wconditionally-supported
    -Wconversion-null
    -Wctor-dtor-privacy
    -Wdelete-incomplete
    -Wdelete-non-virtual-dtor
    -Wdeprecated-copy-dtor
    -Weffc++
    -Wextra-semi
    -Winaccessible-base
    -Winherited-variadic-ctor
    -Winit-list-lifetime
    -Winvalid-offsetof
    -Wliteral-suffix
    -Wmismatched-tags
    -Wnoexcept
    -Wnon-template-friend
    -Wold-style-cast
    -Woverloaded-virtual
    -Wplacement-new=2
    -Wpmf-conversions
    -Wredundant-tags
    -Wregister
    -Wreorder
    -Wsign-promo
    -Wsized-deallocation
    -Wstrict-null-sentinel
    -Wsubobject-linkage
    -Wsuggest-override
    -Wsynth
    -Wterminate
    -Wuseless-cast
    -Wvirtual-move-assign
    -Wvolatile
    -Wzero-as-null-pointer-constant
    >
    )

add_compile_options("$<$<COMPILE_LANGUAGE:ASM>:${ASM_OPTIONS}>" "${COMPILER_FLAGS}" "${WARNING_OPTIONS}")

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

set(DEBUG_FLAGS "-O0 -g3 ${CPU_FLAGS} ${SPEC_FLAGS}")
set(RELEASE_FLAGS "-Os -g3 -DNDEBUG ${CPU_FLAGS} ${SPEC_FLAGS}")
set(CMAKE_C_FLAGS_DEBUG ${DEBUG_FLAGS})
set(CMAKE_C_FLAGS_RELEASE ${RELEASE_FLAGS})
set(CMAKE_CXX_FLAGS_DEBUG ${DEBUG_FLAGS})
set(CMAKE_CXX_FLAGS_RELEASE ${RELEASE_FLAGS})
set(CMAKE_ASM_FLAGS_DEBUG ${DEBUG_FLAGS})
set(CMAKE_ASM_FLAGS_RELEASE ${RELEASE_FLAGS})

set(CMAKE_C_FLAGS_INIT ${SPEC_FLAGS_INIT})
set(CMAKE_CXX_FLAGS_INIT ${SPEC_FLAGS_INIT})

#linker options
set(LINKER_OPTS
    LINKER:-cref
    LINKER:-flto=auto
    LINKER:-gc-sections
    LINKER:-sort-section=alignment
    LINKER:-print-memory-usage
    LINKER:-u,_printf_float
    LINKER:-u,_scanf_float
    )

#limit find_program search paths
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

find_program(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy HINTS ${TOOLCHAIN_DIR})
find_program(CMAKE_OBJDUMP ${TOOLCHAIN_PREFIX}objdump HINTS ${TOOLCHAIN_DIR})
find_program(CMAKE_SIZE_UTIL ${TOOLCHAIN_PREFIX}size HINTS ${TOOLCHAIN_DIR})
find_program(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc HINTS ${TOOLCHAIN_DIR})
find_program(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++ HINTS ${TOOLCHAIN_DIR})
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
