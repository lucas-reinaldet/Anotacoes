#!/usr/bin/env bash
 
sudo apt-get purge postgresql-* pgadmin* -y

sudo find /etc/ /var/lib/ -type d '(' -name "postgres*" -o -name "Postgresl*" -o -name "*pgadmin4*" ')' |  xargs --no-run-if-empty sudo rm -rf

sudo apt-get autoremove -y

sudo apt-get clean -y

sudo apt-get update -y
