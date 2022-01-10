sudo apt-get purge node* -y

sudo find /etc/ /var/lib/ /opt/ -type d -name "node*"  |  sudo xargs --no-run-if-empty rm -rf

sudo apt-get autoremove -y

sudo apt-get clean -y