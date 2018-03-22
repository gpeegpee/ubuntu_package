#!/bin/sh

# source : https://github.com/doxygen/doxygen/archive/Release_1_8_14.tar.gz
# sudo apt-get install -y flex bison
# sudo apt-get install clang1-5.0 llvm-5.0 llvm-5.0-dev llvm-5.0-tools libllvm5.0 liblldb-5.0-dev

mkdir build
cd build
cmake -Dbuild_wizard=ON -G "Unix Makefiles" ../
# There is compile error with clang-5.0 if use_clang is enabled
# cmake -Dbuild_wizard=ON -Dbuild_parse=ON -Duse_libclang=ON -G "Unix Makefiles"  -DCMAKE_INSTALL_PREFIX=/usr -Wno-dev -DLLVM_DIR=/usr/lib/llvm-5.0/cmake -DCMAKE_PREFIX_PATH=/usr ..
# Refer https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=862328

make -j 8
sudo checkinstall -D make install

