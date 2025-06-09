
sudo apt update && sudo apt upgrade

ubuntu-drivers devices

-- Instalar a versão recomendada

sudo apt install nvidia-driver-570-open

sudo reboot

------------------

sudo rm -r /var/lib/dkms/nvidia

sudo apt-get remove --purge '^nvidia-.*'

sudo apt install --reinstall dkms

sudo ubuntu-drivers autoinstall

ubuntu-drivers devices

sudo apt install nvidia-driver-535

reboot

nvidia-smi

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get install --no-install-recommends cuda-toolkit-12-9

sudo apt-get install --no-install-recommends cudnn-cuda-12

ls /usr/local/cuda/bin/nvcc

echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

nvidia-smi
nvcc --version

ls /usr/lib/x86_64-linux-gnu/libcudnn*




