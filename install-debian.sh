#!/bin/bash
apt-get install -y git;
git clone https://github.com/alex-min/puppet-base.git ./puppet-base;
cd ./puppet-base
bash ./debian-rootinstaller.sh