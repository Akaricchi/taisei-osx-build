
cmake_minimum_required(VERSION 2.8.3)

set(CMAKE_SYSTEM_NAME Darwin)

set(TOOLCHAIN_PREFIX x86_64-apple-darwin15-)
set(TOOLCHAIN_ROOT "${CMAKE_CURRENT_LIST_DIR}/../osxcross/target")

# either i'm crazy, or there is a bug in cmake that's even crazier.
# i can't even begin to comprehend what the fuck is actually happening,
# but this seems to help.
get_filename_component(TOOLCHAIN_ROOT ${TOOLCHAIN_ROOT} ABSOLUTE)

set(TOOLCHAIN_FULL_PREFIX "${TOOLCHAIN_ROOT}/bin/${TOOLCHAIN_PREFIX}")

# cross compilers to use for C and C++
set(CMAKE_C_COMPILER ${TOOLCHAIN_FULL_PREFIX}clang)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_FULL_PREFIX}clang++)
set(CMAKE_AR ${TOOLCHAIN_FULL_PREFIX}ar)
set(CMAKE_LINKER ${TOOLCHAIN_FULL_PREFIX}ld)
set(CMAKE_RANLIB ${TOOLCHAIN_FULL_PREFIX}ranlib)
set(CMAKE_C_COMPILER_RANLIB ${TOOLCHAIN_FULL_PREFIX}ranlib)
set(CMAKE_C_COMPILER_AR ${TOOLCHAIN_FULL_PREFIX}ar)
set(PKG_CONFIG_EXECUTABLE ${TOOLCHAIN_FULL_PREFIX}pkg-config)

set(CMAKE_AR ${TOOLCHAIN_FULL_PREFIX}ar CACHE FILEPATH "" FORCE)

# set(CMAKE_EXE_LINKER_FLAGS "-v")
set(CMAKE_OSX_SYSROOT ${TOOLCHAIN_ROOT}/SDK/MacOSX10.11.sdk)

# target environment on the build host system
#   set 1st to dir with the cross compiler's C/C++ headers/libs
set(CMAKE_FIND_ROOT_PATH "${TOOLCHAIN_ROOT}")

#file(GLOB CMAKE_FRAMEWORK_PATH ${TOOLCHAIN_ROOT}/SDK/*.sdk)

#message(FATAL_ERROR "${CMAKE_FRAMEWORK_PATH}")

# modify default behavior of FIND_XXX() commands to
# search for headers/libs in the target environment and
# search for programs in the build host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
