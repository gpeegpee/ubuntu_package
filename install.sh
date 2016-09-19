#!/bin/sh

# setup proxy & certificate
# wget, apt, browser, git, pip, ruby, tomcat, jenkins, sonar, android studio, tizen sdk

sudo sed -i "s/kr\.archive\.ubuntu\.com/ftp.neowiz.com/g" /etc/apt/sources.list
sudo apt-get clean
sudo apt-get update
sudo apt-get upgrade

# disable network discovery
sudo sed -i "s/AVAHI_DAEMON_DETECT_LOCAL=1/AVAHI_DAEMON_DETECT_LOCAL=0/g" /etc/default/avahi-daemon
# disable error report
sudo sed -i "s/enabled=1/enabled=0/g" /etc/default/apport

# Kernel update for AMDGPU bug fix

wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.6.6/linux-headers-4.6.6-040606_4.6.6-040606.201608100733_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.6.6/linux-headers-4.6.6-040606-generic_4.6.6-040606.201608100733_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.6.6/linux-image-4.6.6-040606-generic_4.6.6-040606.201608100733_amd64.deb
sudo dpkg -i linux-headers-4.6.6-040606_4.6.6-040606.201608100733_all.deb
sudo dpkg -i linux-headers-4.6.6-040606-generic_4.6.6-040606.201608100733_amd64.deb
sudo dpkg -i linux-image-4.6.6-040606-generic_4.6.6-040606.201608100733_amd64.deb

# remove unused linux header
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

# SSD setting
echo "Please add discard,noatime in /etc/fstab if SSD is used"

sudo apt-get install vim
dpkg -l vim || echo "Failed to install vim"; exit 1

sudo apt-get install chromium-browser
dpkg -l chromium-browser || echo "Failed to install chromium-browser"; exit 1
# sudo apt-get install webaccounts-chromium-extension unity-chromium-extension adobe-flashplugin

# terminator
sudo apt-get install fonts-nanum-coding fonts-nanum
dpkg -l fonts-nanum-coding || echo "Failed to install fonts-nanum-coding"; exit 1
dpkg -l fonts-nanum || echo "Failed to install fonts-nanum"; exit 1
sudo apt-get install terminator
dpkg -l terminator || echo "Failed to install terminator"; exit 1
# for font config
cp ../config/terminator_config ~/.config/terminator/config

# numix theme
sudo add-apt-repository ppa:numix/ppa
sudo apt-get update
sudo apt-get install numix-*

sudo apt-get install unity-tweak-tool
dpkg -l unity-tweak-tool || echo "Failed to install unity-tweak-tool"; exit 1
echo "Please config appearance by unity-tweak-tool"

# Hangul support
sudo apt-get install uim uim-byeoru
dpkg -l uim uim-byeoru || echo "Failed to install uim uim-byeoru"; exit 1

# Git
sudo apt-get install git gitg git-core
echo "Please configure git username and email"


# beyond compare4
wget http://www.scootersoftware.com/bcompare-4.1.8.21575_amd64.deb
sudo apt-get install libqt4-opengl libqtwebkit4
sudo dpkg -i bcompare-4.1.8.21575_amd64.deb

# audacity
sudo apt-get install audacity

# hwp viewer
sudo apt-get install libwebkitgtk-3.0-0 libjavascriptcoregtk-3.0-0 libwebkitgtk-3.0-common
wget https://github.com/gpeegpee/ubuntu_package/raw/master/16.04/hwpviewer_9.20.0.347_amd64.deb
sudo dpkg -i hwpviewer_9.20.0.347_amd64.deb

# build-essential
sudo apt-get install build-essential

# devscripts
sudo apt-get install devscripts

# tool
sudo apt-get install checkinstall

sudo apt-get install doxygen doxygen-gui graphviz
sudo apt-get install pixz pxz plzip pigz unrar unzip
sudo apt-get install gawk
sudo apt-get install cmake cmake-qt-gui
sudo apt-get install clang ccache

# tool
sudo apt-get install htop


sudo apt-get install focuswriter guake gpodder handbrake gprename


# JAVA
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo echo "JAVA_HOME="/usr/lib/jvm/java-8-oracle/jre/bin/java"" >> /etc/environment

sudo apt-get install findbugs checkstyle


# Cpp
# uncrustify
sudo apt-get install uncrustify

# cppcheck
#sudo apt-get install libpcre3 libpcre3-dev
#sudo apt-get install libtinyxml2-2v5 python-chardet python-pkg-resources python-pygments
#sudo apt-get install astyle
#wget https://sourceforge.net/projects/cppcheck/files/cppcheck/1.75/cppcheck-1.75.tar.gz
#tar xfz cppcheck-1.75.tar.gz
#cd cppcheck-1.75
sudo apt-get install cppcheck cppcheck-gui

# Android
wget https://dl.google.com/dl/android/studio/ide-zips/2.1.3.0/android-studio-ide-143.3101438-linux.zip
unzip android-studio-ide-143.3101438-linux.zip

## Tizen
# rpm cpio for unpacking rpm(tizen)
sudo apt-get install rpm cpio
sudo apt-get install libwebkitgtk-1.0-0 expect ruby bridge-utils openvpn

wget http://download.tizen.org/sdk/Installer/tizen-studio_1.0/web-ide_Tizen_Studio_1.0_ubuntu-64.bin
chmod +x web-ide_Tizen_Studio_1.0_ubuntu-64.bin
./web-ide_Tizen_Studio_1.0_ubuntu-64.bin

# python
sudo apt-get install python-pip
#wget https://repo.continuum.io/archive/Anaconda3-4.1.1-Linux-x86_64.sh
#./Anaconda3-4.1.1-Linux-x86_64.sh
wget https://repo.continuum.io/archive/Anaconda2-4.1.1-Linux-x86_64.sh
./Anaconda2-4.1.1-Linux-x86_64.sh

wget https://download.jetbrains.com/python/pycharm-community-2016.2.3.tar.gz
tar xfz pycharm-community-2016.2.3.tar.gz

# sublime text 3
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer
echo "Try to install anaconda plugin for python development in sublime-text3"


# Caffe
# http://www.whydsp.org/316
# https://www.google.co.kr/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0ahUKEwjggc7mvv3OAhXIJJQKHZqcCmEQtwIIGjAA&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3D6HHkf1AQZ_c&usg=AFQjCNFTpsqZcZND9h325NZYjK0kq3gDFg&sig2=vtWWNHa5e27LppRX6qIXrw&bvm=bv.131783435,d.dGo&cad=rja

# for android
# https://github.com/sh1r0/caffe-android-demo

# OpenCV
cd ~/tools
git clone https://github.com/gpeegpee/opencv-3.1.0-build.git

# OpenCV SDK
wget http://sourceforge.net/projects/opencvlibrary/files/opencv-android/3.1.0/OpenCV-3.1.0-android-sdk.zip

# Tensorflow
# https://github.com/tensorflow/tensorflow

# https://www.tensorflow.org/versions/r0.10/get_started/os_setup.html#pip-installation

# CUDA, CuDNN

wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1504-7-5-local_7.5-18_amd64.deb

wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1404/x86_64/nvidia-machine-learning-repo_4.0-2_amd64.deb

# Digit
sudo apt-get update
sudo apt-get install digits
# https://github.com/NVIDIA/DIGITS/blob/digits-4.0/docs/UbuntuInstall.md


