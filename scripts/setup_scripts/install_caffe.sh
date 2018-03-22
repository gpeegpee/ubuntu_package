#!/bin/sh

# https://github.com/BVLC/caffe/wiki/Ubuntu-16.04-or-15.10-Installation-Guide

sudo apt-get update

sudo apt-get install -y build-essential cmake git pkg-config

sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler

sudo apt-get install -y libatlas-base-dev 

sudo apt-get install -y --no-install-recommends libboost-all-dev

sudo apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev

# (Python general)
sudo apt-get install -y python-pip

# (Python 2.7 development files)
sudo apt-get install -y python-dev
sudo apt-get install -y python-numpy python-scipy

# (or, Python 3.5 development files)
sudo apt-get install -y python3-dev
sudo apt-get install -y python3-numpy python3-scipy

# opencv has been installed already
wget https://github.com/BVLC/caffe/archive/rc3.tar.gz
tar xfz caffe-rc3.tar.gz
cd caffe-rc3
mkdir release
cd release
#cmake -DCPU_ONLY=ON -DUSE_CUDNN=OFF ..
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make all -j16
make pycaffe
sudo checkinstall --nodoc --backup=no -D make install
#add /usr/local/python to PYTHONPATH  in .bashrc

sudo -H pip install -r ../python/requirements.txt


