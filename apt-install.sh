#! /bin/bash
cat apt-get.list | grep -v '#' | xargs sudo apt-get install -y
