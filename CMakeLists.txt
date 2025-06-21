cmake_minimum_required(VERSION 3.18)
project(cuda_example LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

add_library(add_lib src/add.cpp)
target_include_directories(add_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

add_executable(cuda_example main.cu)
target_link_libraries(cuda_example PRIVATE add_lib)

enable_testing()
find_package(GTest REQUIRED)
add_executable(add_tests tests/test_add.cpp)
target_link_libraries(add_tests PRIVATE add_lib GTest::gtest_main)
add_test(NAME add_tests COMMAND add_tests)
