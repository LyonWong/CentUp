#!/bin/bash

src_url="http://nginx.org/download/nginx-1.6.3.tar.gz"
src_dir="/usr/local/src"
src_tar="/var/tmp/nginx.tar.gz"

dir_prefix="/usr/local/nginx"

echo "Start install nginx ... "

if [ ! -f $src_tar ]; then
	wget $src_url -O $src_tar
fi

tar -zxf $src_tar -C $src_dir
rm -f $src_tar

yum -y install gcc gcc-c++ autoconf automake zlib zlib-devel openssl openssl-devel pcre-devel

cd $src_dir/nginx-*
./configure --prefix=$dir_prefix
make && make install

cd /usr/local/sbin
ln -s $dir_prefix/sbin/nginx 


echo "Install end."
