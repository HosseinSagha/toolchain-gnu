set(TOOLCHAIN_VER 13.3.1) #${TOOLCHAIN_PREFIX}-gcc-${TOOLCHAIN_VER} in the toolchain bin folder

set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(MCU_ARCH cortex-m4)
set(CPU_FLAGS "-mthumb -mcpu=${MCU_ARCH} -mfloat-abi=hard -mfpu=fpv4-sp-d16")
set(SPEC_FLAGS_INIT "--specs=nosys.specs")
set(SPEC_FLAGS "--specs=nano.specs")

include(${CMAKE_CURRENT_LIST_DIR}/toolchain-gnu.cmake)
