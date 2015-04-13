#_dir_=`cd $(dirname $0);pwd`
#source $_dir_/../tools.sh

dir_src="/usr/local/src"
dir_download="/var/download"


function target()
{
	tar_src=$1
	tar_name=${tar_src##*/}
	tar_file="$dir_download/$tar_name"
	if [ ! -f $tar_file ]; then
		echo "download $tar_name to $dir_download"
		wget $tar_src -O $tar_file
	fi
	tar -zxf $tar_file -C $dir_src
}


function srcget()
{
	for src in $*; do
		target $src
	done
}

function srcname()
{
	src=$1
	src_name=${src##*/}
	src_name=${src_name%.tar*}
	echo $src_name
}
