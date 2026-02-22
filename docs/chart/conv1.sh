for i in `grep time  $1  | cut -f2 -d':' | tr -d ','`
do 
	ts=`date -r $i "+%B %e %T"` 
	echo $i " " $ts 
done
