
sudo apt-get -y update

# INSTALL THE DEPENDENCIES
# Build tools:
sudo apt-get install -y build-essential cmake

# GUI (if you want to use GTK instead of Qt, replace 'qt5-default' with 'libgtkglext1-dev' and remove '-DWITH_QT=ON' option in CMake):
sudo apt-get install -y qt5-default libvtk6-dev

# Media I/O:
sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev

# Video I/O:
sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev

# Parallelism and linear algebra libraries:
sudo apt-get install -y libtbb-dev libeigen3-dev

# Python:
sudo apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy

# Java:
#sudo apt-get install -y ant defaul-jdk
sudo apt-get install -y ant

# AMDFFT AMDBLAS
sudo apt-get install libclfft-dev libclblas-dev libatlas-dev

# Documentation:
sudo apt-get install -y doxygen

sudo apt-get install -y unzip wget
wget https://github.com/opencv/opencv/archive/3.1.0.tar.gz
tar xfz 3.1.0.tar.gz
wget https://github.com/opencv/opencv_contrib/archive/3.1.0.tar.gz
tar xfz opencv_contrib-3.1.0.tar.gz
cd opencv-3.1.0
mkdir build
cd build
#cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON ..
cmake -DOPENCV_EXTRA_MODULES_PATH="../opencv_contrib-3.1.0/modules" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local \
-DWITH_TIFF=OFF -DWITH_QT=ON -DWITH_VTK=ON -DWITH_TBB=ON \
-DWITH_GDAL=ON -DWITH_OPENCL=ON -DWITH_OPENGL=ON -DWITH_IPP=ON -DWITH_OPENMP=ON -DBUILD_EXAMPLES=ON \
-DBUILD_SHARED_LIBS=ON -DINSTALL_PYTHON_EXAMPLES=ON -DENABLE_FAST_MATH=ON \
..
make -j8
sudo checkinstall -D make install
