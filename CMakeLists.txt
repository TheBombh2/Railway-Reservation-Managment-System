# Specify the minimum version of CMake
cmake_minimum_required(VERSION 3.5)

project(RailwayReservationManagementSystemBackend)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

# Setting output lib and bin directories for debug and release mode 
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "../lib/$<CONFIG>")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "../bin/$<CONFIG>")

# Used for concise linking 
set(COMMON_LIBS
  yaml-cpp
  SOCI::soci_core
  SOCI::soci_mysql
  misc_functions
  database_connector
)

# For OpenSSL
find_package(OpenSSL REQUIRED)
find_package(ZLIB REQUIRED)
find_package(Boost REQUIRED COMPONENTS system date_time)   # Asio requires Boost
set(SOCI_STATIC true)
find_package(SOCI REQUIRED)
find_package(yaml-cpp REQUIRED)

#This is for my main headers
include_directories("./include")
include_directories("./include/apis")
include_directories("./include/crow")
# Needed to get soci working
include_directories("/usr/include/mysql")

# Libraries go here
add_library(crypto STATIC ./src/crypto.cpp)
add_library(misc_functions STATIC ./src/misc_functions.cpp)
add_library(database_connector STATIC ./src/database_connector.cpp)
add_library(tokens STATIC ./src/tokens.cpp)

# Executables (microservices) go here
add_executable(authorization ./src/authorization/authorization.cpp ./src/authorization/authorizationGET.cpp)

# Linking goes here
target_link_libraries(authorization PRIVATE ${COMMON_LIBS})
target_link_libraries(database_connector PRIVATE misc_functions)

add_compile_options(
    $<$<CONFIG:Debug>:-g>
    $<$<CONFIG:Release>:-O2 -s>
)

add_custom_target(debug
  COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --config Debug
  COMMENT "Building debug configuration"
)

add_custom_target(release
  COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --config Release
  COMMENT "Building release configuration"
)

