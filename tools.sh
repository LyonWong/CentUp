conf=~/.conf

function fcd()
{
	cat $conf/fcd
}

function fcdadd()
{
	echo $* >> $conf/fcd
	echo "$(uniq $conf/fcd)" > $conf/fcd
}
