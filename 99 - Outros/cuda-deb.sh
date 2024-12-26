
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin

sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600

wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2004-11-7-local_11.7.0-515.43.04-1_amd64.deb

sudo dpkg -i cuda-repo-ubuntu2004-11-7-local_11.7.0-515.43.04-1_amd64.deb

sudo cp /var/cuda-repo-ubuntu2004-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/

sudo apt-get update

sudo apt-get -y install cuda

echo '
export CUDA_HOME=/usr/local/cuda
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
' >> ~/.bashrc

# echo "Instalar CUDNN"
# echo "Acesse: https://developer.nvidia.com/cudnn-download-survey"
# echo "Fazer Login caso possua, ou Join Now"
# echo "Local Installers"
# echo "https://developer.nvidia.com/rdp/cudnn-download#a-collapse840-115"
# echo "https://developer.nvidia.com/compute/cudnn/secure/8.4.0/local_installers/11.6/cudnn-local-repo-ubuntu2004-8.4.0.27_1.0-1_amd64.deb"

# sudo dpkg -i cudnn-local-repo-ubuntu2004-8.4.0.27_1.0-1_amd64.deb

# sudo apt-key add /var/cudnn-local-repo-ubuntu2004-8.4.0.27/7fa2af80.pub

# sudo apt-get update

# sudo apt-get -y install cudnn

mkdir ~/cudnn 
cd ~/cudnn
tar -xf cudnn-linux-x86_64-8.4.0.27_cuda11.6-archive.tar.xz -C .

sudo ln -s ~/cudnn/cudnn-linux-x86_64-8.4.0.27_cuda11.6-archive/include/* /usr/local/cuda/lib64/
sudo ln -s ~/cudnn/cudnn-linux-x86_64-8.4.0.27_cuda11.6-archive/lib/libcudnn* /usr/local/cuda/lib64/

sudo chmod a+r /usr/local/cuda/lib64/libcudnn*

sudo apt install build-essential cmake git pkg-config libgtk-3-dev  libavcodec-dev libavformat-dev libswscale-dev libv4l-dev  libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev  gfortran openexr libatlas-base-dev python3-dev python3-numpy  libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev  libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev

sudo apt install gcc-8 g++-8 gcc-9 g++-9 gcc-10 g++-10


mkdir ~/opencv_build

cd ~/opencv_build

pip uninstall opencv-python
pip uninstall opencv-contrib-python
sudo apt-get purge '*opencv*'

git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

cd opencv
mkdir build
cd build

rm ../CMakeCache.txt

cmake -D CMAKE_BUILD_TYPE=RELEASE \
 -D CMAKE_C_COMPILER=/usr/bin/gcc-8 \
 -D CMAKE_INSTALL_PREFIX=/usr/local \
 -D INSTALL_PYTHON_EXAMPLES=ON \
 -D INSTALL_C_EXAMPLES=OFF \
 -D WITH_TBB=ON \
 -D WITH_V4L=ON \
 -D WITH_QT=OFF \
 -D WITH_OPENGL=ON \
 -D WITH_GSTREAMER=ON \
 -D OPENCV_GENERATE_PKGCONFIG=ON \
 -D OPENCV_PC_FILE_NAME=opencv.pc \
 -D OPENCV_ENABLE_NONFREE=ON \
 -D OPENCV_PYTHON3_INSTALL_PATH=~/.local/lib/python3.8/site-packages \
 -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
 -D PYTHON_EXECUTABLE=/usr/bin/python3 \
 -D BUILD_EXAMPLES=ON \
 -D WITH_CUDA=ON \
 -D WITH_CUDNN=ON \
 -D OPENCV_DNN_CUDA=ON \
 -D ENABLE_FAST_MATH=1 \
 -D CUDA_FAST_MATH=1 \
 -D CUDA_ARCH_BIN=8.6 \
 -D BUILD_opencv_cudacodec=OFF \
 -D WITH_CUBLAS=1 \
 -D CUDNN_LIBRARY=/usr/local/cuda/lib64/libcudnn.so.8 \
 -D CUDNN_INCLUDE_DIR=/usr/local/cuda/include  ..

make -j$(nproc)

sudo make install

python3
import cv2
print(cv2.getBuildInformation())