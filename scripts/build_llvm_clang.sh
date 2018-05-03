#!/bin/sh
# sudo apt-get install libgcc1-armhf-cross libsfgcc1-armhf-cross libstdc++6-armhf-cross libstdc++6-4.7-dev-armhf-cross gcc-4.7-arm-linux-gnueabihf gcc-4.7-multilib-arm-linux-gnueabihf
# sudo apt-get install binutils-arm-linux-gnueabihf
# sudo apt-get install ninja-build
# sudo apt-get install clang-3.8
cmake -G Ninja /home/gpeegpee/Tools/clang/clang-5/llvm -DCMAKE_CROSSCOMPILING=True \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DLLVM_TABLEGEN=/usr/bin/llvm-tblgen \
      -DCLANG_TABLEGEN=/usr/bin/clang-tblgen \
      -DLLVM_DEFAULT_TARGET_TRIPLE=arm-linux-gnueabihf \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_USE_FOLDERS=OFF \
	-DBUILD_SHARED_LIBS=OFF \
	-DLLVM_ENABLE_ZLIB=OFF \
	-DLLVM_ENABLE_FFI=OFF \
	-DLLVM_INCLUDE_EXAMPLES=OFF \
	-DLLVM_BUILD_TESTS=OFF \
	-DLLVM_INCLUDE_TESTS=OFF \
	-DLLVM_INCLUDE_GO_TESTS=OFF \
	-DLLVM_BUILD_DOCS=OFF \
	-DLLVM_INCLUDE_DOCS=OFF \
	-DLLVM_ENABLE_OCAMLDOC=OFF \
	-DLLVM_BUILD_LLVM_DYLIB=OFF \
	-DLLVM_TARGETS_TO_BUILD=ARM \
	-DLLVM_ENABLE_LIBXML2=OFF \
	-DLLVM_ENABLE_LIBEDIT=OFF \
	-DLLVM_BUILD_STATIC=ON \
	-DLLVM_TARGET_ARCH=ARM \
	-DLLVM_ENABLE_PIC=False
#	-DCMAKE_CXX_FLAGS='-march=armv7-a -mcpu=cortex-a9 -mfloat-abi=hard' \
ninja
