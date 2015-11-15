#!/bin/bash
#源码安装Git2.6.3
yum -y remove git
yum -y  install curl-devel expat-devel gettext-devel   openssl-devel zlib-devel bash-completion

wget https://www.kernel.org/pub/software/scm/git/git-2.6.3.tar.xz
tar -xvf git-2.6.3.tar.xz
cd ./git-2.6.3
make configure
./configure --prefix=/usr
make all 
make install

cp contrib/completion/git-completion.bash /etc/bash_completion.d/
. /etc/bash_completion

git config --system alias.st status
git config --system alias.ci commit
git config --system alias.co checkout
git config --system alias.br branch
