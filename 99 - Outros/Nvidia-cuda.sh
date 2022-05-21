sudo apt-get install linux-headers-$(uname -r)

sudo apt install nvidia-cuda-toolkit

nvidia-smi

nvcc --version

sudo apt-get update

sudo apt-get upgrade

----------------------

conda install numba & conda install cudatoolkit


    echo 'NVIDIA Cuda'
    echo 'https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local'
    mkdir ~/cuda_nvidia/
    cd ~/cuda_nvidia/
    wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda_11.7.0_515.43.04_linux.run
    
    sudo sh cuda_11.7.0_515.43.04_linux.run
    echo "Selecione 'Continue'"
    echo "Selecione accept"
    echo "Desmarque a caixa de drivers, caso contrario pode quebrar a instalação"
    
    echo '
export CUDA_HOME=/usr/local/cuda
export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
' >> ~/.bashrc

    source ~/.bashrc

    echo "Instalar CUDNN"
    echo "Acesse: https://developer.nvidia.com/cudnn-download-survey"
    echo "Fazer Login caso possua, ou Join Now"
    echo "Local Installers"
    echo "https://developer.nvidia.com/rdp/cudnn-download#a-collapse840-115"
    echo "https://developer.nvidia.com/compute/cudnn/secure/8.4.0/local_installers/11.6/cudnn-local-repo-ubuntu2004-8.4.0.27_1.0-1_amd64.deb"
    echo "https://developer.nvidia.com/compute/cudnn/secure/8.4.0/local_installers/11.6/cudnn-linux-x86_64-8.4.0.27_cuda11.6-archive.tar.xz"

    mkdir ~/cudat
    tar -xf ~/Downloads/cudnn-linux-x86_64-8.4.0.27_cuda11.6-archive.tar.xz -C ~/cudat/

    sudo cp ~/cudat/cudnn-linux-x86_64-8.4.0.27_cuda11.6-archive/include/* /usr/local/cuda/include
    sudo cp ~/cudat/cudnn-linux-x86_64-8.4.0.27_cuda11.6-archive/lib/* /usr/local/cuda/lib64/

    sudo chmod a+r /usr/local/cuda/lib64/libcudnn*

    sudo ldconfig -v
    
    sudo apt install build-essential cmake git pkg-config libgtk-3-dev  libavcodec-dev libavformat-dev libswscale-dev libv4l-dev  libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev  gfortran openexr libatlas-base-dev python3-dev python3-numpy  libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev  libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev

    sudo apt install gcc-8 g++-8 gcc-9 g++-9 gcc-10 g++-10

    mkdir ~/opencv_build

    cd ~/opencv_build

    git clone https://github.com/opencv/opencv.git
    git clone https://github.com/opencv/opencv_contrib.git

    cd opencv
    mkdir build
    cd build

    ---------------
    
    ls -lha libcudnn.so*

    sudo rm libcudnn.so
    sudo rm libcudnn.so.8

    sudo ln libcudnn.so.8.4.0 libcudnn.so
    sudo ln libcudnn.so.8.4.0 libcudnn.so.8

    ------

    ls -lha /usr/local/cuda-11.7/lib64/libcudnn.so*

    sudo rm /usr/local/cuda-11.7/lib64/libcudnn.so
    sudo rm /usr/local/cuda-11.7/lib64/libcudnn.so.8

    sudo ln /usr/local/cuda-11.7/lib64/libcudnn.so.8.4.0 libcudnn.so
    sudo ln /usr/local/cuda-11.7/lib64/libcudnn.so.8.4.0 libcudnn.so.8

    -------

    ls -lha /usr/local/cuda-11.7/lib64/libcudnn.so*

    sudo rm /usr/local/cuda-11.7/lib64/libcudnn.so
    sudo rm /usr/local/cuda-11.7/lib64/libcudnn.so.8

    sudo ln /usr/local/cuda-11.7/lib64/libcudnn.so.8.4.0 libcudnn.so
    sudo ln /usr/local/cuda-11.7/lib64/libcudnn.so.8.4.0 libcudnn.so.8

    -------

    ls -lha /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn

    sudo rm /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_ops_infer.so.8
    sudo rm /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_ops_train.so.8
    sudo rm /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_adv_train.so.8
    sudo rm /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_cnn_infer.so.8
    sudo rm /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_cnn_train.so.8
    sudo rm /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_adv_infer.so.8

    sudo ln /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_ops_infer.so.8.4.0 libcudnn_ops_infer.so.8
    sudo ln /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_ops_train.so.8.4.0 libcudnn_ops_train.so.8
    sudo ln /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_adv_train.so.8.4.0 libcudnn_adv_train.so.8
    sudo ln /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_cnn_infer.so.8.4.0 libcudnn_cnn_infer.so.8
    sudo ln /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_cnn_train.so.8.4.0 libcudnn_cnn_train.so.8
    sudo ln /usr/local/cuda-11.7/targets/x86_64-linux/lib/libcudnn_adv_infer.so.8.4.0 libcudnn_adv_infer.so.8

    -------


    cd opencv_build/opencv/build/

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
    -D OPENCV_PYTHON3_INSTALL_PATH=$HOME/.local/lib/python3.8/site-packages \
    -D OPENCV_EXTRA_MODULES_PATH=$HOME/opencv_build/opencv_contrib/modules \
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
    -D CUDNN_LIBRARY=/usr/local/cuda/lib64/libcudnn.so.8.4.0 \
    -D CUDNN_INCLUDE_DIR=/usr/local/cuda/include  ..

    nproc

    ------

    sudo rm CMakeCache.txt

    sudo apt-get install libtiff-dev
    sudo apt-get install libtiff-dev:i386

    make -j16

    ------

    conda uninstall libtiff

    sudo rm CMakeCache.txt

    ------------

    In file included from /home/lucas/opencv_build/opencv/modules/python/src2/cv2.cpp:11:
    /home/lucas/opencv_build/opencv/build/modules/python_bindings_generator/pyopencv_generated_include.h:17:10: fatal error: opencv2/cudaarithm.hpp: Arquivo ou diretório inexistente
    17 | #include "opencv2/cudaarithm.hpp"

    sudo find / -name "cudaarithm.hpp"

    # Avaliar de onde os includes do arquivo estao vindo
    sudo find / -name "utility.hpp"

    # Fazer uma copia do arquivo para a pasta comum
    sudo cp ~/opencv_build/opencv_contrib/modules/cudaarithm/include/opencv2/cudaarithm.hpp ~/opencv_build/opencv/modules/flann/include/opencv2/cudaarithm.hpp

    ------

    sudo rm CMakeCache.txt

    make -j16

    ------

    python3
    import cv2
    print(cv2.getBuildInformation())