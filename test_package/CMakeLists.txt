project(type_safe_test_package)
cmake_minimum_required(VERSION 2.8)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
include(${CONAN_CMAKE-UTILS_ROOT}/conan.cmake)
conan_basic_setup()

add_conan_library(type_safe)

add_executable(example example.cpp)
if(NOT MSVC)
    target_compile_options(example PRIVATE -std=c++11)
endif()

target_link_libraries(example PRIVATE type_safe-conan)
