#!/bin/bash


PATH=$PATH:/home/admin/.nvm/versions/node/v24.4.1/bin

IMAGEDIR=/tmp/wa
export GIT_SSH_COMMAND='ssh -i ~/.ssh/deploy_key'
mkdir ${IMAGEDIR}
rm -f ${IMAGEDIR}/*.png

# generate an image for each page during test script
cd /home/admin/Documents/basic/docs/wa/pw

date >> cron.log
whereis npx >> cron.log
npx playwright test --trace on
 
# get all the images into the right dir and publish them
cp ${IMAGEDIR}/* .

whereis git >> cron.log
git status >> cron.log


#  REMOVE THIS
# exit

git add *.png 
git commit -m "checkin resources: $(date '+%Y-%m-%d %H:%M:%S')"
git push --all
