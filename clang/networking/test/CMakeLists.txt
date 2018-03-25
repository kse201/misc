include_directories(${PROJECT_SOURCE_DIR}/include /usr/include/cutter)

link_directories(${PROJECT_BINARY_DIR/src})

add_library(test_msock SHARED msock_test.c)
target_link_libraries(test_msock msock)

enable_testing()

add_test(
    NAME test
    COMMAND cutter test
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    )
