#!/bin/bash
#NDK_ROOT=/Users/wtwmiao/android-ndk-r10e

set -e


if [ -z "$ANDROID_NDK" ]; then
    echo "You must define ANDROID_NDK before starting."
    echo "They must point to your NDK directories.\n"
    exit 1
fi


PLATFORM=$ANDROID_NDK/platforms/android-18/arch-arm/
TOOLCHAIN=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
PREFIX=./android/arm




export PATH=$TOOLCHAIN/bin:$PATH

cd X264

function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-pic \
  --host=arm-linux \
  --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
  --sysroot=$PLATFORM

 
}

function make_pro
{
  make clean
  make
  make install

}

build_one
make_pro

echo Android ARM builds finished
