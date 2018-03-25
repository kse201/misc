cmake_minimum_required(VERSION 3.0)
project(networking LANGUAGES C)

# add_definitions(-DDEBUG)
set(CMAKE_C_FLAGS "-MMD -MP  -Wall -Wextra -Winit-self -Wno-missing-field-initializers -Wimplicit-function-declaration")
set(CMAKE_C_FLAGS_DEBUG "-g3 -Og -pg -DCONBOATLOGDBG -D_UNIT_TEST -D_NOP")
set(CMAKE_C_FLAGS_RELEASE "-O2 -s")
# doxygen
find_package(Doxygen)
if(DOXYGEN_FOUND)
    #    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)
    set(DOXYGEN_CONF_FILE "Doxyfile")
    set(DOXYGEN_CONF_PATH   ${CMAKE_CURRENT_BINARY_DIR}/${DOXYGEN_CONF_FILE})
    set(DOXYGEN_SOURCE_DIR ${CMAKE_SOURCE_DIR})

    configure_file(${DOXYGEN_CONF_FILE} ${DOXYGEN_CONF_PATH})

    add_custom_target("doc"
        ${DOXYGEN_EXECUTABLE} ${DOXYGEN_CONF_PATH}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        DEPENDS  ${DOXYGEN_CONF_PATH}
        COMMENT "Generating API documentation with Doxygen" VERBATIM
        )
else()
    message("Doxygen not found...")
endif()
subdirs(${PROJECT_SOURCE_DIR}/src ${PROJECT_SOURCE_DIR}/test)

set(SRCS
    src/client.c
    src/server.c
    src/msock.c
    )

include_directories(include)

set(step_counter_version 3.0.3)
set(step_counter_jar stepcounter-${step_counter_version}-jar-with-dependencies.jar)
set(step_counter_url "http://amateras.osdn.jp/mvn/jp/sf/amateras/stepcounter/stepcounter/${step_counter_version}/${step_counter_jar}")

# step couter
add_custom_target("step_counter"
	COMMAND mkdir -p utils
	COMMAND curl -o utils/${step_counter_jar} -O ${step_counter_url}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
add_custom_target("count"
    COMMAND java -cp utils/${step_counter_jar} jp.sf.amateras.stepcounter.Main ${SRCS} src/main.c include
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

add_custom_target("tag"
    COMMAND ctags -R
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

add_custom_target("lint"
	COMMAND clang-format -i ${SRCS} include/*
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
add_executable(mcast_server ${PROJECT_SOURCE_DIR}/src/server.c ${PROJECT_SOURCE_DIR}/src/msock.c)
add_executable(mcast_client ${PROJECT_SOURCE_DIR}/src/client.c ${PROJECT_SOURCE_DIR}/src/msock.c)

