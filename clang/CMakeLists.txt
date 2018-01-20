cmake_minimum_required(VERSION 3.0)
project(helloC LANGUAGES C)

include_directories(include)

# リリースビルド用オプション
SET(CMAKE_C_FLAGS_RELEASE "-Wall -O2")
# デバッグビルド用オプション
SET(CMAKE_C_FLAGS_DEBUG "-g")
# ビルドのタイプはリリース
SET(CMAKE_BUILD_TYPE Release)

# バージョン番号
SET(serial "1.0.0")
# 共有ライブラリのバージョン番号
SET(soserial "1")

add_executable(hello_world
  src/main.c
  src/hello_world.c
)

add_library(static_lib STATIC
  lib/static_lib.c
)

add_library(shared_lib SHARED
  lib/shared_lib.c
)
target_link_libraries(hello_world static_lib)
install(TARGETS hello_world DESTINATION bin)
