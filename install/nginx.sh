#!/bin/bash
source "`cd $(dirname $0);pwd`/common.sh"

# config
src_url="http://nginx.org/download/nginx-1.8.0.tar.gz"
dir_prefix="/usr/local/nginx"

echo "Preparing ... "
yum -y install gcc gcc-c++ autoconf automake zlib zlib-devel openssl openssl-devel pcre-devel

echo "Start install nginx ... "

echo "get source ... "
srcget $src_url


cd $dir_src/$(srcname $src_url)
./configure --prefix=$dir_prefix --with-http_ssl_module
make && make install

cd /usr/local/sbin
ln -s $dir_prefix/sbin/nginx 


echo "Install end."
