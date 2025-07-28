#!/bin/bash

#cd basic/docs/wa/pw

REMOTE_URL=$(git config --get remote.origin.url)
export GIT_SSH_COMMAND='ssh -i ~/.ssh/deploy_key'
git remote add origin "$ORIGIN_URL"
git checkout main

for i in `ls *.png *.mp3 *.gif`
do
	date
	echo "Working on ${i} \n"
	git remote add origin "$ORIGIN_URL"
	git filter-repo --path ${i} --invert-paths 
	git remote add origin "$ORIGIN_URL"
	git push --force --progress origin refs/heads/main
	git checkout main

exit


done


