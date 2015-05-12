#!/bin/bash

src_url="http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.22.tar.gz"
src_dir="/usr/local/src"
src_tar="/var/tmp/mysql.tar.gz"
dir_base="/usr/local/mysql"
dir_data="/var/data/mysql"

echo "Preparing ... "
yum -y install gcc gcc-c++ make cmake ncurses-devel bison

echo "Start install mysql ... "
if [ ! -f $src_tar ]; then
	wget $src_url -O $src_tar
fi
echo -e "unpacking target ... \c"
tar -zxf $src_tar -C $src_dir
echo "[down]"


cd $src_dir/mysql-*
cmake -DMYSQL_USER=mysql -DCMAKE_INSTALL_PREFIX=$dir_base  -DMYSQL_UNIX_ADDR=$dir_base/mysql.sock -DDEFAULT_CHARSET=utf8  -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=all -DWITH_EMBEDDED_SERVER=1 -DENABLED_LOCAL_INFILE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1
make
make install

echo -e "system settign ...\c"
useradd -rU  mysql
mv /etc/my.cnf /etc/my.cnf.bak
chown mysql:mysql -R $dir_base

cp $dir_base/support-files/mysql.server /etc/init.d/mysqld
echo "$dir_base/bin" >> $path_cnf
chkconfig add mysqld
chkconfig --level 2345 mysqld on
echo "[down]"

echo -e "Installing database ... \c"
echo "
[mysqld]
basedir=$dir_base
datadir=$dir_data
skip-name-resolve
log-error=/var/log/mysql.err
" > $dir_base/my.cnf

mkdir -p $dir_data
cd $dir_base
scripts/mysql_install_db --defaults-file=$dir_base/my.cnf
chown -R mysql:mysql $dir_data

echo '
Install completed.
Please start mysql with `service mysqld start`
and set password with `mysqladmin -u root password ***`
'
