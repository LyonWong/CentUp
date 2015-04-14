conf=~/.conf

fcd()
{
	name=$1
	cnf_fcd=$conf/fcd
	if [ ! $name ]; then
		echo "Fcd list:"
		echo "------------------------------"
		cat $cnf_fcd
		echo "------------------------------"
		read -p "Distination ? " name
	fi
	for item in `cat $cnf_fcd`; do
		if [ ${item%%->*} == $name ]; then
			cd ${item##*->}
			return
		fi
	done
	echo "Can't find '$name' in list."
}

fcdadd()
{
	name=$1
	dist=$2
	echo "$1->$2" >> $conf/fcd
	echo "$(uniq $conf/fcd)" > $conf/fcd
}

fcddel()
{
	echo "building..."
}

pathadd()
{
	echo $1 >> /usr/local/etc/path
	export PATH=$PATH:$1
}
