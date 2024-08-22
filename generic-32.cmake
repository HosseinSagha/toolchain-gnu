#set(TOOLCHAIN_VER 13.2.1) #${TOOLCHAIN_PREFIX}-gcc-${TOOLCHAIN_VER} in the toolchain bin folder

if(WIN32)
    set(TOOLCHAIN_PREFIX i686-w64-mingw32-)
elseif(UNIX or APPLE)
    set(CPU_FLAGS "-m32")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/toolchain-gnu.cmake)