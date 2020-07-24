for line in $(sort ./test); do
		number=$(echo $line | awk -F ";" '{ print $1}')
		name=$(echo $line | awk -F ";" '{ print $2}')
		echo "$number  -  $name"
	done
