#!/bin/bash

sudo yum check-update
sudo yum install -y bash-completion wget vim
sudo yum upgrade -y
sudo wget -O /root/.bashrc https://gist.githubusercontent.com/SimonHoenscheid/b9528d087c2791ab7603/raw/b84197a3378f19d14aa2a9f2d3bde139d13583b1/.bashrc
