set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(MCU_ARCH cortex-m3)
# CPU flags optimized for Cortex-M3 performance
# -mthumb: Use Thumb instruction set (16/32-bit mixed for code density)
# -mcpu: Target Cortex-M3 with optimized instruction scheduling
# Note: M3 has no FPU but supports unaligned access
set(CPU_FLAGS "-mthumb -mcpu=${MCU_ARCH}")
set(SPEC_FLAGS_INIT "--specs=nosys.specs")
set(SPEC_FLAGS "--specs=nano.specs")

include(${CMAKE_CURRENT_LIST_DIR}/toolchain-gnu.cmake)
