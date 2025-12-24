set(TOOLCHAIN_VER 15.2.1) #${TOOLCHAIN_PREFIX}-gcc-${TOOLCHAIN_VER} in the toolchain bin folder

set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(MCU_ARCH cortex-m33)
# CPU flags optimized for Cortex-M4F performance
# -mthumb: Use Thumb instruction set (16/32-bit mixed for code density)
# -mcpu: Target Cortex-M4 with optimized instruction scheduling
# -mfloat-abi=hard: Use hardware FPU with direct FP register passing (faster than soft float)
# -mfpu: Enable single-precision FPU instructions
# -munaligned-access: Enable efficient unaligned memory access (M4 hardware feature)
# -ffast-math: Aggressive floating-point optimizations (relaxes IEEE-754 strict compliance)
# -fno-math-errno: Don't set errno for math functions (saves calls/checks)
set(CPU_FLAGS "-mthumb -mcpu=${MCU_ARCH} -mfloat-abi=hard -mfpu=fpv5-sp-d16 -munaligned-access -ffast-math -fno-math-errno")
set(SPEC_FLAGS_INIT "--specs=nosys.specs")
set(SPEC_FLAGS "--specs=nano.specs")

include(${CMAKE_CURRENT_LIST_DIR}/toolchain-gnu.cmake)
