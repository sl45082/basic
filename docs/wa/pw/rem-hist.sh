#!/bin/bash

#cd basic/docs/wa/pw

export GIT_SSH_COMMAND='ssh -i ~/.ssh/deploy_key'
git remote add origin git@github.com:sl45082/basic.git
git checkout main

for i in `ls *.png *.mp3 *.gif`
do
	date
	echo "Working on ${i} \n"
	git remote add origin git@github.com:sl45082/basic.git
	git push --set-upstream origin main
	git filter-repo --path ${i} --invert-paths --force
	git push origin --force
done


