#!/bin/bash

sudo apt-get update
sudo apt-get install -y bash-completion wget vim
sudo apt-get dist-upgrade -Vy
sudo wget -O /root/.bashrc https://gist.githubusercontent.com/SimonHoenscheid/b9528d087c2791ab7603/raw/b84197a3378f19d14aa2a9f2d3bde139d13583b1/.bashrc