sudo apt update && sudo apt upgrade

# NVidia

ubuntu-drivers devices

# se for trabalhar com IA usar a 450
sudo apt install nvidia-driver-X

sudo reboot

# Net Tools

sudo apt install net-tools

# vlc
sudo snap install vlc

# Anaconda

https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh

# Postgres

sudo sh -c '# deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update -y
sudo apt-get install build-essential -y
sudo apt-get install libreadline-dev -y
sudo apt-get install zlib1g-dev -y
sudo apt-get install gettext -y
 
sudo apt-get -y install postgresql-13 -y
sudo apt-get install -y postgresql-common -y
sudo apt-get install postgresql-13-postgis-3 -y
sudo apt-get install postgresql-13-postgis-3-scripts -y
sudo apt-get install postgis -y
sudo systemctl restart postgresql@13-main
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '30894'"
sudo -u postgres psql -c "SET TIME ZONE 'GMT-3'"

# PgAdmin

sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4-desktop

# Python

sudo apt-get install python3.8 -y
sudo apt-get install python3.8-venv -y
sudo apt-get install pip -y

# GIT

sudo apt-get install git -y

mkdir ~/'Área de Trabalho'/Projetos

cd ~/'Área de Trabalho'/Projetos

git clone https://github.com/lucas-reinaldet/Anotacoes.git

# Discord

https://discord.com/api/download?platform=linux&format=deb

# Google Chrome

https://www.google.pt/intl/pt-PT/chrome/thank-you.html?brand=ISCS&statcb=0&installdataindex=empty&defaultbrowser=0#

# VSCode

https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64

# Virtual Box 

https://download.virtualbox.org/virtualbox/6.1.28/virtualbox-6.1_6.1.28-147628~Ubuntu~eoan_amd64.deb

