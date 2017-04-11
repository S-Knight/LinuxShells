#!/bin/bash
#源码安装Git2.11.0
yum -y remove git
yum -y  install gcc curl-devel expat-devel gettext-devel   openssl-devel zlib-devel bash-completion perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker xz
if [ ! -f git-2.11.0.tar.xz];then
    wget https://www.kernel.org/pub/software/scm/git/git-2.11.0.tar.xz
fi
tar -xvf git-2.11.0.tar.xz
cd ./git-2.11.0
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
git config --system color.ui true
git config --system core.longpaths true
git config --global push.default simple

