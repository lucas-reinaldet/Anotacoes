
sudo apt update && sudo apt upgrade

ubuntu-drivers devices

-- Instalar a versão recomendada

sudo apt install nvidia-driver-535

sudo reboot

------------------

sudo rm -r /var/lib/dkms/nvidia

sudo apt-get remove --purge '^nvidia-.*'

sudo apt install --reinstall dkms

sudo ubuntu-drivers autoinstall

sudo apt install nvidia-driver-535

reboot
