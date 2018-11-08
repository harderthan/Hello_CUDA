cmake_minimum_required(VERSION 3.10)
project(hello_cuda)
set(CMAKE_CXX_STANDARD 11)

find_package(CUDA REQUIRED)
if(VIBRANTE)
    set(ARCH_DIR "aarch64-linux")
else()
    set(ARCH_DIR "x86_64-linux")
endif()
set(cuda_runtime_api_DIR /usr/local/cuda/targets/${ARCH_DIR}/include CACHE INTERNAL "")
include_directories(${cuda_runtime_api_DIR} /usr/local/nvidia/tensorrt/include)

CUDA_ADD_LIBRARY(Samples Samples.cu)

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME}
        ${CUDA_LIBRARIES}
        Samples
)
