#set(TOOLCHAIN_VER -13.2.1) #${TOOLCHAIN_PREFIX}-gcc${TOOLCHAIN_VER} in the toolchain bin folder

if(WIN32)
    set(TOOLCHAIN_PREFIX x86_64-w64-mingw32-)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/toolchain-gnu.cmake)