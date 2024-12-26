sudo service apache2 stop

sudo apt-get purge apache2 apache2-utils apache2.2-bin apache2-common

sudo apt-get autoremove

sudo rm -rf $(whereis apache2)