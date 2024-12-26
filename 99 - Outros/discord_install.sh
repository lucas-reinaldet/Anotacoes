sudo apt-get remove discord
sudo dpkg -r discord
sudo rm -rf /etc/discord/

wget -v -O discord.deb https://discord.com/api/download?platform=linux&format=deb 
sudo dpkg -i discord.deb
sudo rm -r discord.deb