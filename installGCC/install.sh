rm -rf gcc-5.3.0
if [ ! -f gcc-5.3.0.tar.gz ];then
	wget http://mirror.hust.edu.cn/gnu/gcc/gcc-5.3.0/gcc-5.3.0.tar.gz
fi
tar zxvf gcc-5.3.0.tar.gz

rm -rf gmp-6.1.0
if [ ! -f gmp-6.1.0.tar.xz ];then
	wget http://mirror.hust.edu.cn/gnu/gmp/gmp-6.1.0.tar.xz
fi
tar -xvf gmp-6.1.0.tar.xz
mv gmp-6.1.0 gcc-5.3.0/gmp

rm -rf mpfr-3.1.3
if [ ! -f mpfr-3.1.3.tar.gz ];then
	wget http://mirror.hust.edu.cn/gnu/mpfr/mpfr-3.1.3.tar.gz
fi
tar -xvf mpfr-3.1.3.tar.gz
mv mpfr-3.1.3 gcc-5.3.0/mpfr

rm -rf mpc-1.0.3
if [ ! -f mpc-1.0.3.tar.gz ];then
	wget http://mirror.hust.edu.cn/gnu/mpc/mpc-1.0.3.tar.gz
fi
tar -xvf mpc-1.0.3.tar.gz
mv mpc-1.0.3 gcc-5.3.0/mpc
 
cd gcc-5.3.0
mkdir /usr/local/gcc-5.3.0
./configure --prefix=/usr/local/gcc-5.3.0 --disable-multilib
make
make install
