add_library(StartCxx
    Swift/String.cpp
    StartCxx.cpp)

target_include_directories(StartCxx PUBLIC
    ${START_CXX_INCLUDE_DIR})
