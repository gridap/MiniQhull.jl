#################################################################
# HEADER
#################################################################
CMAKE_MINIMUM_REQUIRED(VERSION 2.8.7)
PROJECT(MiniQhullWrapper C)

SET(LIB ${PROJECT_NAME})

#################################################################
# DEFINE PATHS
#################################################################

SET(CMAKE_PATH ${CMAKE_SOURCE_DIR}/CMake)
SET(SRC_PATH ${CMAKE_SOURCE_DIR}/src)
SET(CMAKE_MODULE_PATH "${CMAKE_PATH}/Modules")
SET(LIB_PATH ${SRC_PATH}/lib)
SET(TESTS_PATH ${SRC_PATH}/tests)

#################################################################
# BUILD PATHS
#################################################################

SET(ROOT_OUTPUT_PATH ${PROJECT_BINARY_DIR})
SET(LIBRARY_OUTPUT_PATH ${ROOT_OUTPUT_PATH}/lib)
SET(EXECUTABLE_OUTPUT_PATH ${ROOT_OUTPUT_PATH}/bin)

#################################################################
# FIND QHULL
#################################################################

FIND_PACKAGE(Qhull REQUIRED)
INCLUDE_DIRECTORIES(${QHULL_qhull_INCLUDE_DIR} ${QHULL_qhull_INCLUDE_DIR} ${QHULL_qhullcpp_INCLUDE_DIR})

#################################################################
# FLAGS depend on the compiler and the build type
#################################################################

GET_FILENAME_COMPONENT(C_COMPILER_NAME ${CMAKE_C_COMPILER} NAME)

message(STATUS "COMPILER INFO: ${CMAKE_C_COMPILER_ID} - ${C_COMPILER_NAME}")

IF (${CMAKE_C_COMPILER_ID} STREQUAL "GNU" OR C_COMPILER_NAME MATCHES "gcc*")
    # gcc 
#    set (CMAKE_C_FLAGS " " CACHE STRING "" FORCE)
ELSEIF (${CMAKE_C_COMPILER_ID} STREQUAL "Intel" OR C_COMPILER_NAME MATCHES "icc*")
    # icc
#    set (CMAKE_C_FLAGS " " CACHE STRING "" FORCE)
ENDIF ()

message (STATUS "CMAKE_C_COMPILER full path: " ${CMAKE_C_COMPILER})
message (STATUS "CMAKE_C_FLAGS: " ${CMAKE_C_FLAGS})
message (STATUS "CMAKE_C_FLAGS_RELEASE: " ${CMAKE_C_FLAGS_RELEASE})
message (STATUS "CMAKE_C_FLAGS_DEBUG: " ${CMAKE_C_FLAGS_DEBUG})

#################################################################
# DYNAMIC LIBRARY
#################################################################
SET(BUILD_SHARED_LIBS True)

#################################################################
# ADD SOURCE SUBDIRS
#################################################################

ADD_SUBDIRECTORY(${LIB_PATH})

#################################################################
# ENABLE TESTING
#################################################################

ENABLE_TESTING()
INCLUDE(CTest)
ADD_SUBDIRECTORY(${TESTS_PATH})



