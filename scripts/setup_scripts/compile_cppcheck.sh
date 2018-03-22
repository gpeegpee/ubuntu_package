#!/bin/sh

#source : https://github.com/danmar/cppcheck/archive/1.82.tar.gz

mkdir build
cd build
cmake ..
make -j 8 SRCDIR=build CFGDIR=cfg HAVE_RULES=yes
sudo checkinstall -D make install

# cppcheck --enable=all --inconclusive --std=c++14 --xml --language=c++ --output-file=cppcheck_result.xml . 
