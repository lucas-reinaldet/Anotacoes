sudo apt-get --purge remove "*cublas*" "cuda*" "nsight*" 

sudo /usr/local/cuda-11.4/bin/cuda-uninstaller 

sudo rm -rf /usr/local/cuda*

Go to the line containing reference to Nvidia repo and comment it by appending 
# in front of the line, for e.g.:

sudo nano /etc/apt/sources.list

#deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /

sudo apt-get update

sudo apt-get upgrade
sudo /usr/local/cuda-11.7/bin/cuda-uninstaller

sudo apt-get remove --purge '^nvidia-.*'
