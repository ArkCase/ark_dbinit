#!/bin/bash
(( i = 0 ))
echo "PSQL"
for n in "${@}" ; do
	echo -e "\tARG[${i}]=[${n}]"
	(( i++ ))
done
