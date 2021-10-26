add_library(CAtomics
    CAtomics.c)

target_include_directories(CAtomics PUBLIC
    ${CATOMICS_INCLUDE_DIR})

target_link_libraries(CAtomics PUBLIC
    StartCxx)
