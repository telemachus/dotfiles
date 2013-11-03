#!/bin/sh

apt-get update
apt-get install -y build-essential git vim-nox valgrind ed

git clone https://github.com/sstephenson/bats
cd /home/vagrant/bats
./install.sh /home/vagrant
cd /home/vagrant

git clone https://github.com/telemachus/toy-core

printf 'a\nPATH=$PATH:$HOME/bin\n.\nwq\n' | ed /home/vagrant/.bashrc
