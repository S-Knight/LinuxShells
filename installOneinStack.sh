yum -y install wget screen curl python   #for CentOS/Redhat
# apt-get -y install wget screen curl python  #for Debian/Ubuntu
wget http://mirrors.linuxeye.com/oneinstack-full.tar.gz  #包含源码，国内外均可下载
tar xzf oneinstack-full.tar.gz
cd oneinstack    #如果需要修改目录(安装、数据存储、Nginx日志)，请修改options.conf文件
#screen -S oneinstack    #如果网路出现中断，可以执行命令`screen -r oneinstack`重新连接安装窗口
./install.sh     #注：请勿sh install.sh或者bash install.sh这样执行
