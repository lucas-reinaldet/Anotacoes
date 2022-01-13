#!/usr/bin/env bash
 
sudo apt-get purge postgresql-* -y

sudo find /etc/ /var/lib/ -type d -name "postgres*" |  sudo xargs --no-run-if-empty rm -rf

sudo apt-get autoremove -y

sudo apt-get clean -y

sudo apt-get update -y
