set(TOOLCHAIN_VER 15.2.1) #${TOOLCHAIN_PREFIX}-gcc-${TOOLCHAIN_VER} in the toolchain bin folder

set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(MCU_ARCH cortex-m0plus)
# CPU flags optimized for Cortex-M0+ performance
# -mthumb: Use Thumb instruction set (16-bit for code density)
# -mcpu: Target Cortex-M0+ with optimized instruction scheduling
# Note: M0+ has no FPU, no unaligned access support, but is more power-efficient than M0
set(CPU_FLAGS "-mthumb -mcpu=${MCU_ARCH}")
set(SPEC_FLAGS_INIT "--specs=nosys.specs")
set(SPEC_FLAGS "--specs=nano.specs")

include(${CMAKE_CURRENT_LIST_DIR}/toolchain-gnu.cmake)
