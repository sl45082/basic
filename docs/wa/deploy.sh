

IMAGEDIR=/tmp/wa
export GIT_SSH_COMMAND='ssh -i ~/.ssh/deploy_key'
mkdir ${IMAGEDIR}
rm -f ${IMAGEDIR}/*.png

# generate an image for each page during test script
cd /home/admin/Documents/basic/docs/wa/pw

npx playwright test --trace on
 
# get all the images into the right dir and publish them
cp ${IMAGEDIR}/* .
git status


#  REMOVE THIS
exit

git add *.png 
git commit -m "checkin resources: $(date '+%Y-%m-%d %H:%M:%S')"
git push --all
