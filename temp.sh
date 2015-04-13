#!/bin/bash
echo -e "Setting path ... \c"
touch /etc/path
echo '
#import path
for path in `cat /etc/path`; do
    PATH=$PATH:$path
done
' >> /etc/profile
echo "[down]";
