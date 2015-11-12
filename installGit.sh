#!/bin/bash
#源码安装Git2.6.3
yum -y remove git
yum -y  install curl-devel expat-devel gettext-devel   openssl-devel zlib-devel

wget https://www.kernel.org/pub/software/scm/git/git-2.6.3.tar.xz
tar -xvf git-2.6.3.tar.xz
cd ./git-2.6.3
make configure
./configure --prefix=/usr
make all 
make install
