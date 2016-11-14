#!/bin/bash
source "`cd $(dirname $0);pwd`/common.sh"

# config
srcurl_php="http://cn2.php.net/distributions/php-7.0.0.tar.gz"
dir_prefix="/usr/local/php-7.0"

srcurl_libmcrypt="http://downloads.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz"
srcurl_mhash="http://downloads.sourceforge.net/project/mhash/mhash/0.9.9.9/mhash-0.9.9.9.tar.gz"
srcurl_mcrypt="http://downloads.sourceforge.net/project/mcrypt/MCrypt/2.6.8/mcrypt-2.6.8.tar.gz"


echo "Start install PHP ... "
echo "Preparing ... "

read -p "Have prepared before? [y/n]" answer

if [ $answer == 'n' ]; then
yum -y groupinstall "Development tools"
yum -y install libxml2-devel gd-devel libmcrypt-devel libcurl-devel openssl-devel

echo "get source ... "
srcget $srcurl_libmcrypt $srcurl_mhash $srcurl_mcrypt

echo "install libmcrypt ... "
cd $dir_src/$(srcname $srcurl_libmcrypt)
./configure
make && make install

echo "install mhash ... "
cd $dir_src/$(srcname $srcurl_mhash)
./configure
make && make install

echo "install mcrypt ... "
cd $dir_src/$(srcname $srcurl_mcrypt)
D_LIBRARY_PATH=/usr/local/lib ./configure
make && make install
fi

srcget $srcurl_php

cd $dir_src/$(srcname $srcurl_php)
./configure --prefix=$dir_prefix --with-config-file-path="$dir_prefix/etc" --enable-fpm --enable-shared --enable-mbstring --enable-opcache --enable-mysqlnd --enable-zip --with-libxml-dir --with-gd --with-mcrypt --with-openssl --with-zlib-dir --with-pdo-mysql --with-jpeg-dir --with-freetype-dir --with-curl
#--with-apxs2=/usr/local/apache/bin/apxs 

make && make install

useradd -rU php 
cp php.ini-* $dir_prefix/etc/
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod 755 /etc/init.d/php-fpm
