# Toolchain-GNU

CMake GNU toolchain files for ARM Cortex-M microcontrollers.

## Files

- `toolchain-gnu.cmake` — Base toolchain config: GCC 15.3.1, C23/C++26, warning flags, optimizations.
- `cortex-*.cmake` — Per-CPU Cortex-M configurations (M0/M0+/M3/M4/M7/M23/M33).
- `generic-32.cmake` / `generic-64.cmake` — Host-native GNU toolchains (MinGW on Windows, system gcc on Linux/macOS). Use for on-host unit tests.

## Usage

In your project's `CMakeLists.txt`, set `TOOLCHAIN_PREFIX` (e.g. `arm-none-eabi-`) then include the CPU file:

```cmake
set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/path/to/toolchain-gnu/cortex-m4.cmake)
```

Or pass it on the command line:

```bash
cmake -B build -DCMAKE_TOOLCHAIN_FILE=cortex-m4.cmake -DTOOLCHAIN_PREFIX=arm-none-eabi-
```

For host unit tests (Linux/macOS/Windows):

```bash
cmake -B build -DCMAKE_TOOLCHAIN_FILE=generic-64.cmake
```

The CPU files set `CPU_FLAGS`, `SPEC_FLAGS`, and include `toolchain-gnu.cmake`.

## Requirements

- CMake 3.24+
- GNU ARM Embedded toolchain (`arm-none-eabi-gcc` on `PATH`)
