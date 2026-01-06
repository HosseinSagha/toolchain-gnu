set(TOOLCHAIN_VER 15.2.1) #${TOOLCHAIN_PREFIX}-gcc-${TOOLCHAIN_VER} in the toolchain bin folder

set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(MCU_ARCH cortex-m3)
# CPU flags optimized for Cortex-M3 performance
# -mthumb: Use Thumb instruction set (16/32-bit mixed for code density)
# -mcpu: Target Cortex-M3 with optimized instruction scheduling
# -munaligned-access: Enable efficient unaligned memory access (M3 hardware feature)
# Note: M3 has no FPU but supports unaligned access
set(CPU_FLAGS "-mthumb -mcpu=${MCU_ARCH} -munaligned-access")
set(SPEC_FLAGS_INIT "--specs=nosys.specs")
set(SPEC_FLAGS "--specs=nano.specs")

include(${CMAKE_CURRENT_LIST_DIR}/toolchain-gnu.cmake)
