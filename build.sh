#!/bin/bash
set -x
# 目标Android版本
API=29
ARCH=arm64
CPU=armv8-a
TOOL_CPU_NAME=aarch64
#so库输出目录
OUTPUT=/home/jinyj/android/so/$CPU
# NDK的路径，根据自己的NDK位置进行设置
NDK=/home/jinyj/android/ndk/ndk-r26c/android-ndk-r26c
# 编译工具链路径
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
# 编译环境
SYSROOT=$TOOLCHAIN/sysroot

TOOL_PREFIX="$TOOLCHAIN/bin/$TOOL_CPU_NAME-linux-android"
CC="$TOOL_PREFIX$API-clang.cmd"
CXX="$TOOL_PREFIX$API-clang++.cmd"
OPTIMIZE_CFLAGS="-march=$CPU"
function build
{
./configure \
    --prefix=$OUTPUT \
    --target-os=android \
    --arch=$ARCH  \
    --cpu=$CPU \
    --sysroot=$SYSROOT \
    --cross-prefix=$TOOL_PREFIX- \
    --cross-prefix-clang=$TOOL_PREFIX$API- \
    --extra-cflags="-fPIC" \
    --enable-cross-compile \
    --enable-asm --enable-neon \
    --enable-jni --enable-mediacodec \
    --enable-shared \
    --disable-static \
    --enable-gpl \
    --enable-nonfree \
    --enable-version3 \
    --enable-small \
    --disable-doc \
    --disable-filters \
    --disable-decoders \
    --disable-encoders \
    --disable-muxers \
    --disable-parsers \
    --disable-protocols \
    --disable-indevs \
    --disable-outdevs \
    --disable-devices \
    --disable-iconv \
    --disable-bzlib \
    --disable-bsfs \
    --disable-hwaccels \
    --enable-encoder=aac \
    --enable-decoder=hevc \
    --enable-decoder=pcm_alaw \
    --enable-decoder=pcm_mulaw \
    --enable-muxer=mp4 \
    --enable-muxer=h264 \
    --enable-muxer=hevc \
    --enable-muxer=pcm_alaw \
    --enable-muxer=pcm_mulaw \
    --enable-muxer=pcm_s16le \
    --enable-protocol=file \
    --enable-filter=scale \
    make clean all
    make -j8 
    make install
    }
build