#!/bin/bash
source "`cd $(dirname $0);pwd`/common.sh"

src_url="http://nchc.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.4.6/zabbix-2.4.6.tar.gz"
yum -y install net-snmp-devel libxml2-devel libcurl-devel

echo "Start install Zabbix ... "
echo "Preparing ... "

read -p "Install Zabbix Server or Client (s/c)?" answer
case $answer in
	s) conf="--enable-server --enable-agent --with-mysql --with-net-snmp --with-libcurl --with-libxml2";;
	c) conf="--enable-agent";;
	*) exit;;
esac

srcget $src_url
cd $dir_src/$(srcname $src_url)
./configure --prefix=/usr/local/zabbix $conf
make && make install

useradd zabbix

