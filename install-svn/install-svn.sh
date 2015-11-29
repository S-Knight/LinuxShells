#!/bin/bash
#源码安装svn
#判断是否用root用户执行脚本
[ $USER != "root" ] && echo -e "\e[1;31m错误: 你当前用户是$USER,此脚本必须使用hadoop用户来执行！\e[0m" && exit 1

basedir=$(cd "$(dirname "$0")"; pwd)
cd $basedir

#检查是否yum安装了subversion。如果安装了卸载subversion
rpm -qa |grep subversion &>>${basedir}/install.log
if (($?==0))
then
	yum remove subversion -y &>>${basedir}/install.log && echo '卸载subversion的rpm包'
fi

tar -zxvf subversion-1.9.2.tar.gz &>>${basedir}/install.log
tar -zxvf subversion-deps-1.6.9.tar.gz &>>${basedir}/install.log

echo 'start to install sqlite'
unzip sqlite-amalgamation-3090200.zip &>>${basedir}/install.log
mkdir -p ${basedir}/subversion-1.9.2/sqlite-amalgamation
cp ${basedir}/sqlite-amalgamation-3090200/* ${basedir}/subversion-1.9.2/sqlite-amalgamation/
if (($?==0))
then
        echo 'install sqlite succesed';echo -e "\r"
else
        exit 1;
fi

echo 'start to install apr'
cd ${basedir}/subversion-1.6.9/apr/
./configure --prefix=/usr/local/apr &>>${basedir}/install.log
make &>>install.log && make install  &>>${basedir}/install.log
if (($?==0))
then
	echo 'install apr succesed';echo -e "\r"
else
	exit 2;
fi

echo 'start to install apr-util'
cd ${basedir}/subversion-1.6.9/apr-util/
./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr/  &>>${basedir}/install.log
make &>>install.log && make install &>>${basedir}/install.log
if (($?==0))
then
        echo 'install apr-util succesed';echo -e "\r"
else
        exit 3;
fi

echo 'start to install svn'
cd ${basedir}/subversion-1.9.2/
./configure --prefix=/usr/local/svn --with-apr=/usr/local/apr/ --with-apr-util=/usr/local/apr-util  &>>${basedir}/install.log
make &>>install.log  && make install &>>${basedir}/install.log
if (($?==0))
then
        echo 'install svn succesed';echo -e "\r"
else
        exit 4;
fi

echo "export SVN_HOME=/usr/local/svn" >> /etc/profile
echo "export PATH=\$SVN_HOME/bin:\$PATH" >> /etc/profile
