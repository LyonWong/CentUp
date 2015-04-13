#!/bin/bash
source "`cd $(dirname $0);pwd`/common.sh"

srcurl_php="http://cn2.php.net/distributions/php-5.6.7.tar.gz"
srcurl_php="http://cn2.php.net/distributions/php-5.5.23.tar.gz"
srcurl_libmcrypt="http://downloads.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz"
srcurl_mhash="http://downloads.sourceforge.net/project/mhash/mhash/0.9.9.9/mhash-0.9.9.9.tar.gz"
srcurl_mcrypt="http://downloads.sourceforge.net/project/mcrypt/MCrypt/2.6.8/mcrypt-2.6.8.tar.gz"
dir_prefix="/usr/local/php-5.6"
dir_prefix="/usr/local/php-5.5"


echo "Start install PHP ... "
echo "Preparing ... "
yum -y groupinstall "Development tools"
yum -y install libxml2-devel gd-devel libmcrypt-devel libcurl-devel openssl-devel

echo "get source ... "
srcget $srcurl_php $srcurl_libmcrypt $srcurl_mhash $srcurl_mcrypt

cd $dir_src/$(srcname $srcurl_libmcrypt)
./configure
make && make install

cd $dir_src/$(srcname $srcurl_mhash)
./configure
make && make install

cd $dir_src/$(srcname $srcurl_mcrypt)
D_LIBRARY_PATH=/usr/local/lib ./configure
make && make install

cd $dir_src/$(srcname $srcurl_php)
./configure --prefix=$dir_prefix --with-config-file-path="$dir_prefix/etc" --enable-fpm --enable-shared --enable-mbstring --enable-opcache --enable-mysqlnd --enable-zip --with-libxml-dir --with-gd --with-mcrypt --with-openssl --with-mysqli --with-mysql --with-zlib-dir --with-pdo-mysql --with-jpeg-dir --with-freetype-dir --with-curl
#--with-apxs2=/usr/local/apache/bin/apxs 

make && make install

cp php.ini-* $dir_prefix/etc/
