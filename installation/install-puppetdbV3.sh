#!/bin/bash
sudo puppet agent --enable
sudo puppet agent -t --server puppet.local 
