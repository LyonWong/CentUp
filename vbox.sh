#!/bin/bash

yum install -y gcc.i686 kernel.i686 kernel-devel.i686
echo "Need reboot"

echo -e "Setting vbox share dirs ... \c"
echo '
# share dirs
PATH_SHARE=/mnt/share
for item in `ls $PATH_SHARE`; do
    mount -t vboxsf $item $PATH_SHARE/$item
done
' >> /etc/rc.local

echo "[done]"
mkdir -p /mnt/cdrom
mount /dev/cdrom /mnt/cdrom
cd /mnt/cdrom
./VBoxLinuxAdditions.run

reboot
