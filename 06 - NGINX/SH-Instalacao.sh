# https://phoenixnap.com/kb/how-to-install-nginx-on-ubuntu-20-04

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $key
sudo apt update
sudo apt install nginx

# Verificar Versão
nginx -v

# Verificar Status
sudo systemctl status nginx

