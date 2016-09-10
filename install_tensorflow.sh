#!/bin/sh


sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo install nvidia-352

#CUDA
wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run
chmod +x cuda_7.5.18_linux.run
sudo ./cuda_7.5.18_linux.run --override

#Do you accept the previously read EULA? (accept/decline/quit): accept
#You are attempting to install on an unsupported configuration. Do you wish to continue? ((y)es/(n)o) [ default is no ]: yes
#Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 352.39? ((y)es/(n)o/(q)uit): no
#Install the CUDA 7.5 Toolkit? ((y)es/(n)o/(q)uit): yes 
#Enter Toolkit Location [ default is /usr/local/cuda-7.5 ]: 그냥 엔터
#Do you want to install a symbolic link at /usr/local/cuda? ((y)es/(n)o/(q)uit): yes
#Install the CUDA 7.5 Samples? ((y)es/(n)o/(q)uit): no

cd /usr/local
sudo tar zxf ~/Downloads/cudnn-7.0-linux-x64-v4.0-prod.tgz

# install tensorflow python module
sudo -H pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0-cp27-none-linux_x86_64.whl
