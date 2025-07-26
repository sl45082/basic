#!/bin/bash

#cd basic/docs/wa/pw

export GIT_SSH_COMMAND='ssh -i ~/.ssh/deploy_key'

for i in `ls *.png *.mp3 *.gif`
do
	date
	echo "Working on ${i} \n"
	git filter-repo --path ${i} --invert-paths --force
	git push --force --all
done


