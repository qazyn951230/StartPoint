cmake_minimum_required(VERSION 3.20)
project(StartPoint)

set(CMAKE_CXX_STANDARD 20)

set(START_CXX_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/Sources/StartCxx/include)
set(CATOMICS_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/Sources/CAtomics/include)

add_subdirectory(Sources)
