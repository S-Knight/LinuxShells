#!/bin/bash

  tar -xzvf ./mysql/mysql-5.6.30.tar.gz

groupadd mysql
useradd -g mysql -s /sbin/nologin mysql
cd mysql-5.6.30 
cmake -DCMAKE_INSTALL_PREFIX=/alidata/server/mysql .
make
make install
/alidata/server/mysql/scripts/mysql_install_db --datadir=/alidata/server/mysql/data/ --basedir=/alidata/server/mysql --user=mysql
chown -R mysql:mysql /alidata/server/mysql/
chown -R mysql:mysql /alidata/server/mysql/data/
chown -R mysql:mysql /alidata/log/mysql
\cp -f /alidata/server/mysql/support-files/mysql.server /etc/init.d/mysqld
sed -i 's#^basedir=$#basedir=/alidata/server/mysql#' /etc/init.d/mysqld
sed -i 's#^datadir=$#datadir=/alidata/server/mysql/data#' /etc/init.d/mysqld
cat > /etc/my.cnf <<END
[client]
port            = 3306
socket          = /tmp/mysql.sock
[mysqld]
port            = 3306
socket          = /tmp/mysql.sock
skip-external-locking
log-error=/alidata/log/mysql/error.log
key_buffer_size = 16M
max_allowed_packet = 1M
table_open_cache = 64
sort_buffer_size = 512K
net_buffer_length = 8K
read_buffer_size = 256K
read_rnd_buffer_size = 512K
myisam_sort_buffer_size = 8M

log-bin=mysql-bin
binlog_format=mixed
server-id       = 1

sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size = 20M
sort_buffer_size = 20M
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout
END

chmod 755 /etc/init.d/mysqld
/etc/init.d/mysqld start
