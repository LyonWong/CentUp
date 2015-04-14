#!/bin/bash
yum install -y vim wget lrzsz 

groupadd -rf serv

echo -e "Setting path ... \c"
touch "/usr/local/etc/path"
echo '
#import path
for path in `cat /usr/local/etc/path`; do
    export PATH=$PATH:$path
done
' >> /etc/profile
echo "[down]";

echo -e "Setting vimrc ... \c"
echo '
hi Comment ctermfg=darkgrey
set tabstop=4
set nu
' > ~/.vimrc
echo "[done]"

echo -e "Setting .bashrc ... \c"
echo '
alias du="du -h --max-depth=1"
' >> ~/.bashrc
