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

# build android library for tensorflow
sudo apt-get install autoconf automake libtool curl make g++ unzip

git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout r0.10
./tensorflow/contrib/makefile/download_dependencies.sh

wget https://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip
unzip android-ndk-r12b-linux-x86_64.zip
# Add ndk path to NDK_ROOT in bashrc

mkdir -p ~/graphs
curl -o ~/graphs/inception.zip \
 https://storage.googleapis.com/download.tensorflow.org/models/inception5h.zip \
 && unzip ~/graphs/inception.zip -d ~/graphs/inception

./tensorflow/contrib/makefile/compile_android_protobuf.sh -c
make -f tensorflow/contrib/makefile/Makefile TARGET=ANDROID

# test
adb push ~/graphs/inception/tensorflow_inception_graph.pb /data/local/tmp/
adb push tensorflow/contrib/makefile/gen/bin/benchmark /data/local/tmp/
adb shell '/data/local/tmp/benchmark \
 --graph=/data/local/tmp/classify_image_graph_def.pb \
 --input_layer="input:0" \
 --input_layer_shape="1,224,224,3" \
 --input_layer_type="float" \
 --output_layer="output:0"
'




